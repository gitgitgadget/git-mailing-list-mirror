From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 3/4] git-svn.txt: fix fetch flags incorrectly documented as init flags.
Date: Tue,  7 Jul 2009 15:02:16 +0200
Message-ID: <85af960a258945d0eb1d62dd753ff9a3752b2455.1246971377.git.ydirson@altern.org>
References: <cover.1246971377.git.ydirson@altern.org>
 <ffe5b8e8cf2cb889cdcc04850cf867b46df9ced9.1246971377.git.ydirson@altern.org>
 <d96fcc984cf5e879ce132e4b1d97f29c2c6503ad.1246971377.git.ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 15:02:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOAJP-0003gB-Eg
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 15:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756514AbZGGNCG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 09:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756324AbZGGNCF
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 09:02:05 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:38016 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756118AbZGGNCE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 09:02:04 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id A24869400F7;
	Tue,  7 Jul 2009 15:01:59 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 565BE940188;
	Tue,  7 Jul 2009 15:01:56 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 491CE1F0A6; Tue,  7 Jul 2009 15:02:20 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <d96fcc984cf5e879ce132e4b1d97f29c2c6503ad.1246971377.git.ydirson@altern.org>
In-Reply-To: <cover.1246971377.git.ydirson@altern.org>
References: <cover.1246971377.git.ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122839>

Signed-off-by: Yann Dirson <ydirson@altern.org>
Acked-by: Eric Wong <normalperson@yhbt.net>
---
 Documentation/git-svn.txt |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 3599e01..d08b2ad 100644
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
