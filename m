From: Mark Struberg <struberg@yahoo.de>
Subject: [JGIT PATCH 8/9] renamed the PathSuffixFilter test to JUnit conventions, so it gets executed via maven test.
Date: Wed, 23 Sep 2009 23:16:09 +0200
Message-ID: <1253740570-10718-8-git-send-email-struberg@yahoo.de>
References: <1253740570-10718-1-git-send-email-struberg@yahoo.de>
 <1253740570-10718-2-git-send-email-struberg@yahoo.de>
 <1253740570-10718-3-git-send-email-struberg@yahoo.de>
 <1253740570-10718-4-git-send-email-struberg@yahoo.de>
 <1253740570-10718-5-git-send-email-struberg@yahoo.de>
 <1253740570-10718-6-git-send-email-struberg@yahoo.de>
 <1253740570-10718-7-git-send-email-struberg@yahoo.de>
Cc: Mark Struberg <struberg@yahoo.de>
To: git@vger.kernel.org, spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Sep 23 23:17:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqZCw-0004mJ-JT
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 23:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752919AbZIWVQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2009 17:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752764AbZIWVQY
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Sep 2009 17:16:24 -0400
Received: from n10.bullet.re3.yahoo.com ([68.142.237.123]:40854 "HELO
	n10.bullet.re3.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752882AbZIWVQG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2009 17:16:06 -0400
Received: from [68.142.237.89] by n10.bullet.re3.yahoo.com with NNFMP; 23 Sep 2009 21:16:09 -0000
Received: from [66.196.97.145] by t5.bullet.re3.yahoo.com with NNFMP; 23 Sep 2009 21:16:08 -0000
Received: from [127.0.0.1] by omp203.mail.re3.yahoo.com with NNFMP; 23 Sep 2009 21:16:08 -0000
X-Yahoo-Newman-Id: 568198.37126.bm@omp203.mail.re3.yahoo.com
Received: (qmail 22337 invoked from network); 23 Sep 2009 21:16:08 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:X-Yahoo-SMTP:X-YMail-OSG:X-Yahoo-Newman-Property:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References;
  b=tg4lbLyxEvuJxDNj7cSII7N7GAFbsHHDG9+0MnBW3gKYh1mvGzXTC+pK6sPgu+/+Rvb/FRiRzS8CDS+hXQTVu9TQiCnI6oK/O57yf9+QwXyg7ySetlDBBwlXqYBY/1AKBsPXfXtQBboXSuGmjtXiPHXYMzN9+srzKEHdgN+Rl4c=  ;
Received: from chello062178039060.14.11.vie.surfer.at (struberg@62.178.39.60 with login)
        by smtp103.plus.mail.re1.yahoo.com with SMTP; 23 Sep 2009 14:16:08 -0700 PDT
X-Yahoo-SMTP: 81dhI.iswBBq7boyzRoOX6xuRIe8
X-YMail-OSG: 4cVW8h8VM1liKRuhTcPUYNjhDBg5EmrOFtoAgWmBV9QA8v_9PLnVffDyKX9.hBULSfFVQT0OizvBQ0EjF4n6OPJsQOPo57AWQ2t_9xk9VpOMkA0OSQZzNUygBx0VR1SPg9cQgn20y975uharX3zsWrjo8sDYjXcnD6wM1CnHPjKfbzbc57n.02H0VRHsNxrQIGTkJdHWAuma7xfYJMjNErYo8BFlBnTkdxxtAA3dTObZdCgN.5ZwlnRKhT.OJMlY2V3qgVtXef0Sbl2gfUXi8nxa6UVERPrXKHZao.pi57l7F4wbR5Sa9qw5a5.s0ROiHZcfRfkLfwbqh7zjlkSvo1F3Wz0bj_mdMA--
X-Yahoo-Newman-Property: ymail-3
X-Mailer: git-send-email 1.6.2.5
In-Reply-To: <1253740570-10718-7-git-send-email-struberg@yahoo.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129006>

Signed-off-by: Mark Struberg <struberg@yahoo.de>
---
 ...lterTestCase.java => PathSuffixFilterTest.java} |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
 rename org.spearce.jgit/src/test/java/org/spearce/jgit/treewalk/filter/{PathSuffixFilterTestCase.java => PathSuffixFilterTest.java} (98%)

diff --git a/org.spearce.jgit/src/test/java/org/spearce/jgit/treewalk/filter/PathSuffixFilterTestCase.java b/org.spearce.jgit/src/test/java/org/spearce/jgit/treewalk/filter/PathSuffixFilterTest.java
similarity index 98%
rename from org.spearce.jgit/src/test/java/org/spearce/jgit/treewalk/filter/PathSuffixFilterTestCase.java
rename to org.spearce.jgit/src/test/java/org/spearce/jgit/treewalk/filter/PathSuffixFilterTest.java
index 56d9765..0043a7d 100644
--- a/org.spearce.jgit/src/test/java/org/spearce/jgit/treewalk/filter/PathSuffixFilterTestCase.java
+++ b/org.spearce.jgit/src/test/java/org/spearce/jgit/treewalk/filter/PathSuffixFilterTest.java
@@ -50,7 +50,7 @@
 import org.spearce.jgit.lib.RepositoryTestCase;
 import org.spearce.jgit.treewalk.TreeWalk;
 
-public class PathSuffixFilterTestCase extends RepositoryTestCase {
+public class PathSuffixFilterTest extends RepositoryTestCase {
 
 	public void testNonRecursiveFiltering() throws IOException {
 		final ObjectWriter ow = new ObjectWriter(db);
-- 
1.6.2.5
