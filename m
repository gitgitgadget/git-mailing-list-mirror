From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] change ent to tree in git-diff documentation
Date: Sun, 9 Jul 2006 11:59:39 +0200
Message-ID: <E1FzW4h-00058M-3u@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jul 09 11:59:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzW4p-0004c9-OF
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 11:59:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWGIJ7n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 05:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWGIJ7n
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 05:59:43 -0400
Received: from moooo.ath.cx ([85.116.203.178]:62936 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S932160AbWGIJ7n (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jul 2006 05:59:43 -0400
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
Mail-Followup-To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23539>

---
I've sent this patch a while ago and did not get any feedback, so here
it is again.
This is quite confusing for someone new to git who is not familiar
with the vocabulary used with git. I don't think a man page is the
right place for riddles :)
Additionaly I changed two times 'is' to 'are', I hope this is correct.

 Documentation/git-diff.txt |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

83ace740fdf1e064168f8438a6ad863986cf4832
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 890931c..41d85cf 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -8,24 +8,24 @@ git-diff - Show changes between commits,
 
 SYNOPSIS
 --------
-'git-diff' [ --diff-options ] <ent>{0,2} [<path>...]
+'git-diff' [ --diff-options ] <tree-ish>{0,2} [<path>...]
 
 DESCRIPTION
 -----------
-Show changes between two ents, an ent and the working tree, an
-ent and the index file, or the index file and the working tree.
+Show changes between two trees, a tree and the working tree, a
+tree and the index file, or the index file and the working tree.
 The combination of what is compared with what is determined by
-the number of ents given to the command.
+the number of trees given to the command.
 
-* When no <ent> is given, the working tree and the index
-  file is compared, using `git-diff-files`.
+* When no <tree-ish> is given, the working tree and the index
+  file are compared, using `git-diff-files`.
 
-* When one <ent> is given, the working tree and the named
-  tree is compared, using `git-diff-index`.  The option
+* When one <tree-ish> is given, the working tree and the named
+  tree are compared, using `git-diff-index`.  The option
   `--cached` can be given to compare the index file and
   the named tree.
 
-* When two <ent>s are given, these two trees are compared
+* When two <tree-ish>s are given, these two trees are compared
   using `git-diff-tree`.
 
 OPTIONS
-- 
1.3.1.g9af0

