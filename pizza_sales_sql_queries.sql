--SQL QUERIES for pizza_sales

--1.) Total Revenue 
SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales; 

--2.) Average Order Value
SELECT ROUND((SUM(total_price) / COUNT(DISTINCT order_id)),2) AS Avg_order_Value FROM pizza_sales;

--3.) Total Pizzas Sold
SELECT SUM(quantity) AS Total_pizza_sold FROM pizza_sales;

--4.) Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales;

--5.) Average Pizzas Per Order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS Avg_Pizzas_per_order
FROM pizza_sales;

--6.) Daily Trend for Total Orders
SELECT 
	DATENAME(DW, order_date) AS order_day, 
	COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)
ORDER BY total_orders DESC;

--7.) Hourly Trend for Total Orders
SELECT 
	DATEPART(HOUR, order_time) as order_hours, 
	COUNT(DISTINCT order_id) as total_orders
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time);

--8.) % of Sales by Pizza Category
SELECT 
	pizza_category, 
	ROUND(SUM(total_price), 2) as total_revenue,
	CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) 
		from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category

--9.) % of Sales by Pizza Size
SELECT 
	pizza_size, 
	CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
	CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size;

--10.) Total Pizzas Sold by Pizza Category
SELECT 
	pizza_category, 
	SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;

--11.) Top 5 Best Sellers by Total Pizzas Sold
SELECT Top 5 
	pizza_name, 
	SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC;

--12.) Bottom 5 Worst Sellers by Total Pizzas Sold
SELECT TOP 5 
	pizza_name, 
	SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC;










