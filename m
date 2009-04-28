From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [JGIT PATCH] Fix spelling of Junit option jgit.junit.usemmap
Date: Wed, 29 Apr 2009 00:50:18 +0200
Message-ID: <1240959018-2388-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Apr 29 00:50:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lyw8K-0007D7-Dq
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 00:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754623AbZD1Wu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 18:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753446AbZD1Wu1
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 18:50:27 -0400
Received: from mail.dewire.com ([83.140.172.130]:16321 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752612AbZD1Wu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 18:50:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 317C91023428;
	Wed, 29 Apr 2009 00:50:21 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JrI8ad3z9w1J; Wed, 29 Apr 2009 00:50:20 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.8])
	by dewire.com (Postfix) with ESMTP id 66BB310233F2;
	Wed, 29 Apr 2009 00:50:20 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.rc2.1.g868b6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117828>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
index b85d3eb..3b03ac1 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
@@ -61,7 +61,7 @@
  * Sets up a predefined test repository and has support for creating additional
  * repositories and destroying them when the tests are finished.
  *
- * A system property <em>jgit.junit.usemmmap</em> defines whether memory mapping
+ * A system property <em>jgit.junit.usemmap</em> defines whether memory mapping
  * is used. Memory mapping has an effect on the file system, in that memory
  * mapped files in java cannot be deleted as long as they mapped arrays have not
  * been reclaimed by the garbage collector. The programmer cannot control this
@@ -123,7 +123,7 @@ protected void configure() {
 		final WindowCacheConfig c = new WindowCacheConfig();
 		c.setPackedGitLimit(128 * WindowCacheConfig.KB);
 		c.setPackedGitWindowSize(8 * WindowCacheConfig.KB);
-		c.setPackedGitMMAP("true".equals(System.getProperty("jgit.junit.usemmmap")));
+		c.setPackedGitMMAP("true".equals(System.getProperty("jgit.junit.usemmap")));
 		c.setDeltaBaseCacheLimit(8 * WindowCacheConfig.KB);
 		WindowCache.reconfigure(c);
 	}
-- 
1.6.3.rc2.1.g868b6
