From: Mark Struberg <struberg@yahoo.de>
Subject: [JGIT PATCH 9/9] Add the <scm> section to the parent pom
Date: Wed, 23 Sep 2009 23:16:10 +0200
Message-ID: <1253740570-10718-9-git-send-email-struberg@yahoo.de>
References: <1253740570-10718-1-git-send-email-struberg@yahoo.de>
 <1253740570-10718-2-git-send-email-struberg@yahoo.de>
 <1253740570-10718-3-git-send-email-struberg@yahoo.de>
 <1253740570-10718-4-git-send-email-struberg@yahoo.de>
 <1253740570-10718-5-git-send-email-struberg@yahoo.de>
 <1253740570-10718-6-git-send-email-struberg@yahoo.de>
 <1253740570-10718-7-git-send-email-struberg@yahoo.de>
 <1253740570-10718-8-git-send-email-struberg@yahoo.de>
Cc: Mark Struberg <struberg@yahoo.de>
To: git@vger.kernel.org, spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Sep 23 23:17:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqZCw-0004mJ-1H
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 23:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752913AbZIWVQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2009 17:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752764AbZIWVQW
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Sep 2009 17:16:22 -0400
Received: from n64.bullet.mail.sp1.yahoo.com ([98.136.44.189]:41572 "HELO
	n64.bullet.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752852AbZIWVQG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Sep 2009 17:16:06 -0400
Received: from [216.252.122.217] by n64.bullet.mail.sp1.yahoo.com with NNFMP; 23 Sep 2009 21:16:09 -0000
Received: from [68.142.237.88] by t2.bullet.sp1.yahoo.com with NNFMP; 23 Sep 2009 21:16:09 -0000
Received: from [66.196.97.142] by t4.bullet.re3.yahoo.com with NNFMP; 23 Sep 2009 21:16:09 -0000
Received: from [127.0.0.1] by omp110.mail.re3.yahoo.com with NNFMP; 23 Sep 2009 21:16:09 -0000
X-Yahoo-Newman-Id: 724623.80551.bm@omp110.mail.re3.yahoo.com
Received: (qmail 22355 invoked from network); 23 Sep 2009 21:16:09 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:X-Yahoo-SMTP:X-YMail-OSG:X-Yahoo-Newman-Property:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References;
  b=0lPvkwy3GbV1/akb8jsg9rWu49llfUmZux8GEkU5EVIvMJnsLAfqVd2qgl48HHGGwNvrnBgVnj5+rLoq29C6Sdd2NyxydaWxABqCj4rc4wlYoKDq93ozAi0zRlOUkgKbf+Y+baaqOrqiKY7kt9ohPOjlBv/gXjubMMN9FdhtX+4=  ;
Received: from chello062178039060.14.11.vie.surfer.at (struberg@62.178.39.60 with login)
        by smtp103.plus.mail.re1.yahoo.com with SMTP; 23 Sep 2009 14:16:09 -0700 PDT
X-Yahoo-SMTP: 81dhI.iswBBq7boyzRoOX6xuRIe8
X-YMail-OSG: zJg6CAMVM1kZMZ6qZ6rPHXl5srRZjjRlvscucBXPOWqKWdoBSbt2e9HpSQtWiC9NN7LnrcbNIcEt5yNACMmoJ48E6__G351syUuyNzwa8tg7BaNVAW618T13fR3B1xs6xEbYOjt_MuqZrY4BcoIpcAfXPRZZcmDQdJYmMW50rxa_bRyLNmxmuLvYtgvrV7CwhlP5GzFJEepFe9pT0OufNC_.CMSrXljbRn.F1gF6shsr6BDQjdy38Sd4hbeuGgq1qOE_t5FJ2NoyyN1SC4cc.Ttdq6OchPawYmKqZVY9LS4aHPcEAK4svjofjSL4SRpYI31Ipi_TNwIQtnN_qCpJVh5l48LixQ--
X-Yahoo-Newman-Property: ymail-3
X-Mailer: git-send-email 1.6.2.5
In-Reply-To: <1253740570-10718-8-git-send-email-struberg@yahoo.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129005>


Signed-off-by: Mark Struberg <struberg@yahoo.de>
---
 pom.xml |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/pom.xml b/pom.xml
index 821e92c..ec4857c 100644
--- a/pom.xml
+++ b/pom.xml
@@ -65,6 +65,12 @@
 	   <system>google-issue</system>
 	</issueManagement>
 	
+	<scm>
+		<connection>scm:git:git://repo.or.cz/jgit</connection>
+		<developerConnection>scm:git:git://repo.or.cz/jgit</developerConnection>
+		<url>http://repo.or.cz/r/jgit.git</url>
+	</scm>
+	
 	<developers>
 		<developer>
 			<name>Shawn O. Pearce</name>
-- 
1.6.2.5
