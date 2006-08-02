From: Jeff King <peff@peff.net>
Subject: [PATCH] Documentation: convert uses of git-link macro to gitlink
Date: Wed, 2 Aug 2006 12:32:32 -0400
Message-ID: <20060802163231.GA22107@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 02 18:40:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8JlX-0006Hx-34
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 18:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWHBQkG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 12:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWHBQkG
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 12:40:06 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2460 "HELO
	peff.net") by vger.kernel.org with SMTP id S932095AbWHBQkF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Aug 2006 12:40:05 -0400
Received: (qmail 4897 invoked from network); 2 Aug 2006 12:31:57 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 2 Aug 2006 12:31:57 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed,  2 Aug 2006 12:32:32 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24655>

There isn't and never was such a macro; all uses are typos.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt        |    6 +++---
 Documentation/git-cvsimport.txt |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e669003..d89916b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -223,14 +223,14 @@ showbranch.default::
 	See gitlink:git-show-branch[1].
 
 tar.umask::
-	By default, git-link:git-tar-tree[1] sets file and directories modes
+	By default, gitlink:git-tar-tree[1] sets file and directories modes
 	to 0666 or 0777. While this is both useful and acceptable for projects
 	such as the Linux Kernel, it might be excessive for other projects.
 	With this variable, it becomes possible to tell
-	git-link:git-tar-tree[1] to apply a specific umask to the modes above.
+	gitlink:git-tar-tree[1] to apply a specific umask to the modes above.
 	The special value "user" indicates that the user's current umask will
 	be used. This should be enough for most projects, as it will lead to
-	the same permissions as git-link:git-checkout[1] would use. The default
+	the same permissions as gitlink:git-checkout[1] would use. The default
 	value remains 0, which means world read-write.
 
 user.email::
diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index b0c6d7c..d21d66b 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -116,7 +116,7 @@ file each time git-cvsimport is run.
 +
 It is not recommended to use this feature if you intend to
 export changes back to CVS again later with
-git-link[1]::git-cvsexportcommit.
+gitlink:git-cvsexportcommit[1].
 
 OUTPUT
 ------
-- 
1.4.2.rc2.g59706-dirty
