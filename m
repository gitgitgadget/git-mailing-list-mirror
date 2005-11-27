From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: [PATCH] Small fixes in Documentation/git-mv.txt
Date: Sun, 27 Nov 2005 22:08:33 +0100
Message-ID: <200511272208.34112.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 27 22:09:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgTlJ-0001NN-WC
	for gcvg-git@gmane.org; Sun, 27 Nov 2005 22:08:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbVK0VIj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 16:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbVK0VIj
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 16:08:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:57739 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751153AbVK0VIj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Nov 2005 16:08:39 -0500
Received: (qmail invoked by alias); 27 Nov 2005 21:08:37 -0000
Received: from p5496A06C.dip0.t-ipconnect.de (EHLO linux) [84.150.160.108]
  by mail.gmx.net (mp033) with SMTP; 27 Nov 2005 22:08:37 +0100
X-Authenticated: #352111
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12823>

The two synopsis lines have to be prefixed with a space
so that asciidoc inserts a line break inbetween for the
manual page.

Signed-off-by: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>

---

 Documentation/git-mv.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

applies-to: 5b67c88670a5872520b05d5e2b1fd7fb586e99a1
dd7084033c36b92ada34192502ffe38b26a2f969
diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
index f2d5882..3013b8d 100644
--- a/Documentation/git-mv.txt
+++ b/Documentation/git-mv.txt
@@ -8,14 +8,14 @@ git-mv - Script used to move or rename a
 
 SYNOPSIS
 --------
-'git-mv' [-f] [-n] <source> <destination>
-'git-mv' [-f] [-k] [-n] <source> ... <destination directory>
+ 'git-mv' [-f] [-n] <source> <destination>
+ 'git-mv' [-f] [-n] [-k] <source> ... <destination directory>
 
 DESCRIPTION
 -----------
 This script is used to move or rename a file, directory or symlink.
 In the first form, it renames <source>, which must exist and be either
-a file, symlink or directory, to <destination>, which must not exist.
+a file, symlink or directory, to <destination>.
 In the second form, the last argument has to be an existing
 directory; the given sources will be moved into this directory.
 
@@ -25,7 +25,7 @@ committed.
 OPTIONS
 -------
 -f::
-	Force renaming or moving even targets exist
+	Force renaming or moving of a file even if the target exists
 -k::
         Skip move or rename actions which would lead to an error
 	condition. An error happens when a source is neither existing nor
---
0.99.9.GIT
