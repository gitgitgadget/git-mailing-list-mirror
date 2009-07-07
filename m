From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 3/4] git-svn.txt: fix fetch flags incorrectly documented as init flags.
Date: Tue,  7 Jul 2009 22:22:21 +0200
Message-ID: <a427e73e459e18d9e28701a97eca338934d74300.1246997775.git.ydirson@altern.org>
References: <cover.1246997775.git.ydirson@altern.org>
 <ffe5b8e8cf2cb889cdcc04850cf867b46df9ced9.1246997775.git.ydirson@altern.org>
 <4d918af1f5122cc5b71142cd50b7d5699a2a912d.1246997775.git.ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 22:22:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOHBR-0002yV-Od
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 22:22:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757416AbZGGUWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 16:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756781AbZGGUWM
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 16:22:12 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:42595 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756242AbZGGUWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 16:22:09 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 5DF749401CE;
	Tue,  7 Jul 2009 22:22:01 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 7480694019D;
	Tue,  7 Jul 2009 22:21:59 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 7129E1F0D6; Tue,  7 Jul 2009 22:22:24 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <4d918af1f5122cc5b71142cd50b7d5699a2a912d.1246997775.git.ydirson@altern.org>
In-Reply-To: <cover.1246997775.git.ydirson@altern.org>
References: <cover.1246997775.git.ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122868>

Signed-off-by: Yann Dirson <ydirson@altern.org>
Acked-by: Eric Wong <normalperson@yhbt.net>
---
 Documentation/git-svn.txt |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index f40fd42..1e8242b 100644
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
