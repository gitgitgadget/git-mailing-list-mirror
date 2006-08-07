From: Michael <barra_cuda@katamail.com>
Subject: [PATCH] Documentation: explain "--pretty"
Date: Mon, 7 Aug 2006 21:32:20 +0200
Message-ID: <200608072132.21032.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Aug 07 21:27:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAAlJ-0005lb-MV
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 21:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWHGT1h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 15:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWHGT1h
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 15:27:37 -0400
Received: from fe-7a.inet.it ([213.92.5.113]:10207 "EHLO fe-7a.inet.it")
	by vger.kernel.org with ESMTP id S1750831AbWHGT1f (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Aug 2006 15:27:35 -0400
Received: from dial-up-mi-21.lombardiacom.it ([::ffff:212.34.225.21]) by fe-7a.inet.it via I-SMTP-5.4.4-546
	id ::ffff:212.34.225.21+pypSvGpIF9v; Mon, 07 Aug 2006 21:27:30 +0200
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
Content-Disposition: inline
Message-ID: <20060807192731.257508@dial-up-mi-21.lombardiacom.it>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Michael <barra_cuda@katamail.com>
---
 Documentation/git-diff-tree.txt   |    4 ++--
 Documentation/git-log.txt         |    2 ++
 Documentation/git-rev-list.txt    |    4 +++-
 Documentation/git-show.txt        |    2 +-
 Documentation/git-whatchanged.txt |    2 +-
 5 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index f7e8ff2..11d4f48 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -73,9 +73,9 @@ separated with a single space are given.
 	This flag causes "git-diff-tree --stdin" to also show
 	the commit message before the differences.
 
---pretty[=(raw|medium|short)]::
+--pretty[=(raw|medium|short|full|oneline)]::
 	This is used to control "pretty printing" format of the
-	commit message.  Without "=<style>", it defaults to
+	commit message.  Without "=<format>", it defaults to
 	medium.
 
 --no-commit-id::
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index c9ffff7..cd46580 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -26,6 +26,8 @@ OPTIONS
 -------
 --pretty=<format>::
 	Controls the way the commit log is formatted.
+	<format> can be one of 'raw', 'medium', 'short', 'full',
+	and 'oneline'.  Without "=<format>", it defaults to medium.
 
 --max-count=<n>::
 	Limits the number of commits to show.
diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index f60eacd..761891e 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -49,8 +49,10 @@ between the two operands.  The following
 
 OPTIONS
 -------
---pretty::
+--pretty=<format>::
 	Print the contents of the commit changesets in human-readable form.
+	<format> can be one of 'raw', 'medium', 'short', 'full',
+	and 'oneline'.  Without "=<format>", it defaults to medium.
 
 --header::
 	Print the contents of the commit in raw-format; each
diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index 2b4df3f..58c64ff 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -29,7 +29,7 @@ OPTIONS
 --pretty=<format>::
 	Controls the output format for the commit logs.
 	<format> can be one of 'raw', 'medium', 'short', 'full',
-	and 'oneline'.
+	and 'oneline'.  Without "=<format>", it defaults to medium.
 
 Author
 ------
diff --git a/Documentation/git-whatchanged.txt 
b/Documentation/git-whatchanged.txt
index e8f21d0..4d7d45f 100644
--- a/Documentation/git-whatchanged.txt
+++ b/Documentation/git-whatchanged.txt
@@ -41,7 +41,7 @@ OPTIONS
 --pretty=<format>::
 	Controls the output format for the commit logs.
 	<format> can be one of 'raw', 'medium', 'short', 'full',
-	and 'oneline'.
+	and 'oneline'.  Without "=<format>", it defaults to medium.
 
 -m::
 	By default, differences for merge commits are not shown.
-- 
1.4.2.rc3
