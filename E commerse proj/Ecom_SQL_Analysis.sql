use personal_proj;

SELECT * FROM personal_proj.e_com_data;

# basic understanding 

# total order
SELECT COUNT(*) AS total_orders
FROM e_com_data;

#Total revenue
SELECT SUM(`Order Value (INR)`) AS total_revenue
FROM e_com_data;

#Average order value
SELECT AVG(`Order Value (INR)`) AS avg_order_value
FROM e_com_data;

#Platform Analysis

#Orders per platform
SELECT Platform, COUNT(*) AS total_orders
FROM e_com_data
GROUP BY Platform;

#Revenue per platform
SELECT Platform, SUM(`Order Value (INR)`) AS revenue
FROM e_com_data
GROUP BY Platform;

#Average delivery time per platform
SELECT Platform, AVG(`Delivery Time (Minutes)`) AS avg_delivery_time
FROM e_com_data
GROUP BY Platform;

# Product Category Analysis

#Orders by product category
SELECT `Product Category`, COUNT(*) AS total_orders
FROM e_com_data
GROUP BY `Product Category`;

#Revenue by product category
SELECT `Product Category`, SUM(`Order Value (INR)`) AS revenue
FROM e_com_data
GROUP BY `Product Category`
ORDER BY revenue DESC;

#Delivery Performance Analysis

#Delayed vs non-delayed orders
SELECT `Delivery Delay`, COUNT(*) AS orders
FROM e_com_data
GROUP BY `Delivery Delay`;

#Average delivery time for delayed orders
SELECT AVG(`Delivery Time (Minutes)`) AS avg_delay_time
FROM e_com_data
WHERE `Delivery Delay` = 'Yes';

#Customer Satisfaction Analysis(CSA)

#Average service rating
SELECT round(AVG(`Service Rating`),0) AS avg_rating
FROM e_com_data;

#Rating distribution
SELECT `Service Rating`, COUNT(*) AS count
FROM e_com_data
GROUP BY `Service Rating`
ORDER BY `Service Rating` DESC;

#Does delay affect rating?
SELECT `Delivery Delay`, AVG(`Service Rating`) AS avg_rating
FROM e_com_data
GROUP BY `Delivery Delay`; # yes but negligible. 

#Refund Analysis 

#Refund count
SELECT COUNT(*) AS refund_orders
FROM e_com_data
WHERE `Refund Requested` = 'Yes';

#Refund rate
SELECT `Product Category`,
ROUND(SUM(CASE WHEN `Refund Requested` = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),2) AS refund_percentage
FROM e_com_data
GROUP BY `Product Category`; # in persentage %

#Refunds by product category
SELECT `Product Category`, COUNT(*) AS refund_count
FROM e_com_data
WHERE `Refund Requested` = 'Yes'
GROUP BY `Product Category`
ORDER BY refund_count DESC;

#Customer Behavior

#Top customers by spend
SELECT `Customer ID`, SUM(`Order Value (INR)`) AS total_spent
FROM e_com_data
GROUP BY `Customer ID`
ORDER BY total_spent DESC
LIMIT 10;

#frequent customers
SELECT `Customer ID`, COUNT(*) AS orders
FROM e_com_data
GROUP BY `Customer ID`
HAVING orders > 1;

#Business-Level Insights

#High delivery time but low rating
SELECT *
FROM e_com_data
WHERE `Delivery Time (Minutes)` > 30
AND `Service Rating` <= 2;

#High-value orders with refunds
SELECT *
FROM e_com_data
WHERE `Order Value (INR)` > 599
AND `Refund Requested` = 'Yes';

#Delayed Orders %
SELECT 
ROUND((SUM(CASE WHEN `Delivery Delay` = 'Yes' THEN 1 ELSE 0 END) * 100.0)/ COUNT(*),2) AS dop
FROM e_com_data;

#Worst Performing Orders
SELECT `Order ID`,Platform,`Product Category`,`Delivery Time (Minutes)`,`Service Rating`,`Refund Requested`
FROM e_com_data
WHERE `Delivery Delay` = 'Yes'
ORDER BY `Delivery Time (Minutes)` DESC;




