CREATE DATABASE sql_project_p2;
USE sql_project_p2;

CREATE TABLE retail_sales
	(
      transaction_id INT PRIMARY KEY,
      sale_date DATE,
      sale_time TIME,
      customer_id INT,
      gender VARCHAR(15),
      age INT,
      category VARCHAR(15),
      quantity INT,
	  price_per_unit FLOAT,
      cogs FLOAT,
      total_sale float
    );  
SELECT * FROM retail_sales;  
SELECT count(*)FROM retail_sales;

SELECT * FROM retail_sales
WHERE 
	transaction_id IS NULL
    OR 
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR 
    gender IS NULL
    OR 
    category IS NULL 
    OR 
    quantity IS NULL
	OR 
    cogs IS NULL
    OR 
    total_sale IS NULL;
    
SET SQL_SAFE_UPDATES = 0;

DELETE FROM retail_sales
WHERE 
	transaction_id IS NULL
    OR 
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR 
    gender IS NULL
    OR 
    category IS NULL 
    OR 
    quantity IS NULL
	OR 
    cogs IS NULL
    OR 
    total_sale IS NULL;
    
    -- how many sales we have?
    SELECT count(*)AS total_sale FROM retail_sales
    
    -- how many uniuque customers we have?
    SELECT COUNT(DISTINCT customer_id)as total_sale FROM retail_sales
    
    SELECT DISTINCT category FROM retail_sales
    
    -- data analysis & business key problem & answers.
Q1-- write a SQL query to retrive all columns for sales made on '2022-11-05'
SELECT *
FROM retail_sales
where sale_date ='2022-11-05'  

Q2-- write SQL query to retrive all transction where the category is clothing and the quantity sold is more than 10 in the of nov -2022
SELECT 
	category 
    sum(quantity)
from retail_sales
where category ='clothing'
GROUP BY 1

Q3-- Write a sql query to calculate the total sales (total_sales) for each category
SELECT
	category,
    sum(total_sale)as net_sale,
    count(*) total_orders
from retail_sales
GROUP BY 1

Q4-- Write a sql query to find the average age of customers who puchased items form the 'beauty' category
SELECT
	ROUND(AVG(age),2)AS avg_age
    FROM retail_sales
    WHERE category ='beauty'
    
Q5-- write a sql query to find all transaction where the tota_sales is greater than 1000
SELECT * FROM retail_sales
WHERE total_sale >1000 

Q6-- Write a sql query to find the total no of transaction made by each gender in each category 
SELECT 
	category,
    gender,
    count(*) as total_trans
from retail_sales
group 
	by
    category,
    gender
     
Q7-- Write a sql query to calculate the average sale for each month find out best selling month in each year 
SELECT *
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1

Q8-- write a sql query to find the top 5 customers based on the heighest total sales 
SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

Q9-- write a sql query to find the number of unique customers who purchased items each category 
SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category

Q10-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift

-- End of project





