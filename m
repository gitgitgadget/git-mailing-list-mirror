From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 3/4] git-svn.txt: fix fetch flags incorrectly documented as init flags.
Date: Mon,  6 Jul 2009 00:03:16 +0200
Message-ID: <1246831397-19489-4-git-send-email-ydirson@altern.org>
References: <1246831397-19489-1-git-send-email-ydirson@altern.org>
 <1246831397-19489-2-git-send-email-ydirson@altern.org>
 <1246831397-19489-3-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 00:09:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNZu5-0002XY-9W
	for gcvg-git-2@gmane.org; Mon, 06 Jul 2009 00:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754161AbZGEWJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jul 2009 18:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753738AbZGEWJb
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jul 2009 18:09:31 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:37516 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752667AbZGEWJb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jul 2009 18:09:31 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id A4686940143;
	Mon,  6 Jul 2009 00:09:28 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 7B92094012F;
	Mon,  6 Jul 2009 00:09:25 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 6957DA007; Mon,  6 Jul 2009 00:03:24 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1246831397-19489-3-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122760>


Signed-off-by: Yann Dirson <ydirson@altern.org>
---
 Documentation/git-svn.txt |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index b5b8366..03bc1c1 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -62,16 +62,6 @@ COMMANDS
 	Set the 'useSvnsyncProps' option in the [svn-remote] config.
 --rewrite-root=<URL>;;
 	Set the 'rewriteRoot' option in the [svn-remote] config.
---use-log-author;;
-	When retrieving svn commits into git (as part of fetch, rebase, or
-	dcommit operations), look for the first From: or Signed-off-by: line
-	in the log message and use that as the author string.
---add-author-from;;
-	When committing to svn from git (as part of commit or dcommit
-	operations), if the existing log message doesn't already have a
-	From: or Signed-off-by: line, append a From: line based on the
-	git commit's author string.  If you use this, then --use-log-author
-	will retrieve a valid author string for all commits.
 --username=<USER>;;
 	For transports that SVN handles authentication for (http,
 	https, and plain svn), specify the username.  For other
@@ -140,6 +130,17 @@ Skip "branches" and "tags" of first level directories;;
 ------------------------------------------------------------------------
 --
 
+--use-log-author;;
+	When retrieving svn commits into git (as part of fetch, rebase, or
+	dcommit operations), look for the first From: or Signed-off-by: line
+	in the log message and use that as the author string.
+--add-author-from;;
+	When committing to svn from git (as part of commit or dcommit
+	operations), if the existing log message doesn't already have a
+	From: or Signed-off-by: line, append a From: line based on the
+	git commit's author string.  If you use this, then --use-log-author
+	will retrieve a valid author string for all commits.
+
 'clone'::
 	Runs 'init' and 'fetch'.  It will automatically create a
 	directory based on the basename of the URL passed to it;
-- 
1.6.3.3
