From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH] git-branch: Documentation fixes
Date: Sun, 29 Jan 2006 15:02:51 +0100
Message-ID: <20060129140251.GD4815@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Jan 29 15:03:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3D8y-0008Ta-29
	for gcvg-git@gmane.org; Sun, 29 Jan 2006 15:03:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWA2OCw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 09:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbWA2OCw
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 09:02:52 -0500
Received: from [85.8.31.11] ([85.8.31.11]:60061 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1750778AbWA2OCw (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jan 2006 09:02:52 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id E784740FF; Sun, 29 Jan 2006 15:16:06 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1F3D8l-0008BA-00; Sun, 29 Jan 2006 15:02:51 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15219>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>


---

 Documentation/git-branch.txt |    7 +++++--
 git-branch.sh                |    2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

fb625f143454671bfa6862ee83fbe9cdbac9af0b
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index d20b475..b1bc827 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -7,7 +7,7 @@ git-branch - Create a new branch, or rem
 
 SYNOPSIS
 --------
-'git-branch' [-d | -D] [<branchname> [start-point]]
+'git-branch' [(-d | -D) <branchname>] | [[-f] <branchname> [<start-point>]]
 
 DESCRIPTION
 -----------
@@ -25,10 +25,13 @@ OPTIONS
 -D::
 	Delete a branch irrespective of its index status.
 
+-f::
+	Force a reset of <branchname> to <start-point> (or current head).
+
 <branchname>::
 	The name of the branch to create or delete.
 
-start-point::
+<start-point>::
 	Where to create the branch; defaults to HEAD. This
 	option has no meaning with -d and -D.
 
diff --git a/git-branch.sh b/git-branch.sh
index b0e54ed..6ac961e 100755
--- a/git-branch.sh
+++ b/git-branch.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-USAGE='[-d <branch>] | [[-f] <branch> [start-point]]'
+USAGE='[(-d | -D) <branchname>] | [[-f] <branchname> [<start-point>]]'
 LONG_USAGE='If no arguments, show available branches and mark current branch with a star.
 If one argument, create a new branch <branchname> based off of current HEAD.
 If two arguments, create a new branch <branchname> based off of <start-point>.'
-- 
0.99.9k.g3480-dirty
