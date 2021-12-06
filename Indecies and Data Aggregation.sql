USE Gringotts
GO

SELECT COUNT(*) AS [Count] FROM WizzardDeposits
/*-------------------------------------------*/
SELECT MAX(MagicWandSize) AS [LongestMagicWand]
  FROM WizzardDeposits
 /*-------------------------------------------*/
  SELECT DepositGroup AS [DepositGroup], MAX(MagicWandSize) AS [LongestMagicWand]
  FROM WizzardDeposits
 GROUP BY DepositGroup
/*-------------------------------------------*/
 SELECT TOP 2 DepositGroup 
  FROM WizzardDeposits
 GROUP BY DepositGroup
 ORDER BY AVG(MagicWandSize)
/*-------------------------------------------*/
 SELECT DepositGroup, SUM(DepositAmount) AS [TotalSum]
  FROM WizzardDeposits
 GROUP BY DepositGroup
 /*-------------------------------------------*/
 SELECT DepositGroup, SUM(DepositAmount) AS [TotalSum]
  FROM WizzardDeposits
 WHERE MagicWandCreator ='Ollivander family'
 GROUP BY DepositGroup
 /*-------------------------------------------*/
 SELECT DepositGroup, SUM(DepositAmount) AS [TotalSum]
  FROM WizzardDeposits
 WHERE MagicWandCreator ='Ollivander family'
 GROUP BY DepositGroup
 HAVING SUM(DepositAmount) < 150000
 ORDER BY TotalSum DESC  
 /*-------------------------------------------*/
 SELECT DepositGroup, MagicWandCreator, MIN(DepositCharge)  AS [MinDepositCharge]
  FROM WizzardDeposits
 GROUP BY DepositGroup, MagicWandCreator
 /*-------------------------------------------*/
 SELECT 
	CASE
	  WHEN Age BETWEEN 0 AND 10 THEN '[0-10]'
	  WHEN Age BETWEEN 11 AND 20 THEN '[11-20]'
	  WHEN Age BETWEEN 21 AND 30 THEN '[21-30]'
	  WHEN Age BETWEEN 31 AND 40 THEN '[31-40]'
	  WHEN Age BETWEEN 41 AND 50 THEN '[41-50]'
	  WHEN Age BETWEEN 51 AND 60 THEN '[51-60]'
	  WHEN Age >= 61 THEN '[61+]'
	END AS [AgeGroup],
COUNT(*) AS [WizardCount]
	FROM WizzardDeposits
GROUP BY CASE
	  WHEN Age BETWEEN 0 AND 10 THEN '[0-10]'
	  WHEN Age BETWEEN 11 AND 20 THEN '[11-20]'
	  WHEN Age BETWEEN 21 AND 30 THEN '[21-30]'
	  WHEN Age BETWEEN 31 AND 40 THEN '[31-40]'
	  WHEN Age BETWEEN 41 AND 50 THEN '[41-50]'
	  WHEN Age BETWEEN 51 AND 60 THEN '[51-60]'
	  WHEN Age >= 61 THEN '[61+]'
	END
 /*-------------------------------------------*/
 SELECT DISTINCT LEFT(FirstName,1) AS [FirstLetter]
  FROM WizzardDeposits
 WHERE DepositGroup = 'Troll Chest'
GROUP BY LEFT(FirstName,1)
ORDER BY FirstLetter
 /*-------------------------------------------*/
 SELECT DepositGroup, IsDepositExpired, AVG(DepositInterest) AS [AverageInterest]
 FROM WizzardDeposits
WHERE DepositStartDate >= '1985-01-01'
GROUP BY DepositGroup,IsDepositExpired
ORDER BY DepositGroup DESC,IsDepositExpired
 /*-------------------------------------------*/
 SELECT SUM(ResultTable.[Difference]) AS SumDifference
FROM (SELECT DepositAmount - (SELECT DepositAmount FROM WizzardDeposits WHERE Id = WizDeposits.Id + 1) 
AS [Difference] FROM WizzardDeposits WizDeposits) AS ResultTable
 /*-------------------------------------------*/
 USE SoftUni
 GO

 SELECT DepartmentID, SUM(Salary) AS [TotalSalary] 
  FROM Employees
 GROUP BY DepartmentID
 ORDER BY DepartmentID
 /*-------------------------------------------*/
 SELECT DepartmentID, MIN(Salary) AS [MinimumSalary]
  FROM Employees
 WHERE DepartmentID IN (2,5,7) AND HireDate > '2000-01-01'
 GROUP BY DepartmentID
 /*-------------------------------------------*/
 SELECT * INTO NewTable FROM Employees
 WHERE Salary > 30000;

DELETE FROM NewTable
 WHERE ManagerID = 42
 
UPDATE NewTable
SET Salary += 5000
WHERE DepartmentId =1 

SELECT DepartmentID, AVG(Salary) AS [AverageSalary]
  FROM NewTable
 GROUP BY DepartmentID
 /*-------------------------------------------*/
 SELECT DepartmentID, MAX(Salary) AS [MaxSalary]  
  FROM Employees
 GROUP BY DepartmentID
 HAVING MAX(Salary) NOT BETWEEN 30000 AND 70000;
 /*-------------------------------------------*/
 SELECT COUNT(*) AS [Count]
  FROM Employees
 WHERE ManagerID IS NULL
 /*-------------------------------------------*/
 SELECT DepartmentID, 
	(SELECT DISTINCT Salary FROM Employees WHERE DepartmentID = e.DepartmentID ORDER BY Salary DESC OFFSET 2 ROWS FETCH NEXT 1 ROWS ONLY) AS ThirdHighestSalary
 FROM Employees e
WHERE (SELECT DISTINCT Salary FROM Employees WHERE DepartmentID = e.DepartmentID ORDER BY Salary DESC OFFSET 2 ROWS FETCH NEXT 1 ROWS ONLY) IS NOT NULL
GROUP BY DepartmentID
 /*-------------------------------------------*/
 SELECT TOP(10) e.FirstName, e.LastName, e.DepartmentID
FROM Employees AS e
WHERE e.Salary >(SELECT AVG(e2.Salary)
				FROM Employees AS e2
				WHERE e.DepartmentID = e2.DepartmentID)
ORDER BY e.DepartmentID
 /*-------------------------------------------*/