From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Remove leftover comment from documentation.
Date: Wed, 13 Jul 2005 20:27:41 -0700
Message-ID: <7v64vekqxe.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 14 05:28:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsuOH-0008Fi-3h
	for gcvg-git@gmane.org; Thu, 14 Jul 2005 05:28:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262877AbVGND15 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 23:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbVGND15
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 23:27:57 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:61164 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S262881AbVGND1n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2005 23:27:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050714032741.HDAG12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 13 Jul 2005 23:27:41 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The comment was left over from the days when we had a single
huge core-git.txt document.  No more.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Documentation/git-write-tree.txt |   13 -------------
 1 files changed, 0 insertions(+), 13 deletions(-)

86eab95db201216395a24c02e88136ddbd007ed8
diff --git a/Documentation/git-write-tree.txt b/Documentation/git-write-tree.txt
--- a/Documentation/git-write-tree.txt
+++ b/Documentation/git-write-tree.txt
@@ -30,19 +30,6 @@ OPTIONS
 	Normally "git-write-tree" ensures that the objects referenced by the
 	directory exist in the object database.  This option disables this check.
 
-
-////////////////////////////////////////////////////////////////
-
-Producing man pages and html
-
-To create a set of html pages run:
-  perl split-docs.pl -html < core-git.txt
-
-To create a set of man pages run:
-  perl split-docs.pl -man < core-git.txt
-
-
-////////////////////////////////////////////////////////////////
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
