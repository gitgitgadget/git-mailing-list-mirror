From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH] Documentation/tutorial: misc updates
Date: Wed, 03 Jan 2007 13:53:27 +0100
Message-ID: <87fyastgoo.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jan 03 14:00:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H25ik-0000n3-5G
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 13:59:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbXACM7q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 07:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbXACM7q
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 07:59:46 -0500
Received: from ifae-s0.ifae.es ([192.101.162.68]:52252 "EHLO ifae-s0.ifae.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750740AbXACM7o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 07:59:44 -0500
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id l03CqUl24115
	for <git@vger.kernel.org>; Wed, 3 Jan 2007 13:52:32 +0100
To: Git Mailing List <git@vger.kernel.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35863>


Three changes:
1) Teach how to delete a branch with "git branch -d name".
2) The first commit does not have a parent.
3) Teach "git show" instead of "git cat-file -p".
---
 Documentation/tutorial.txt |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index d043e84..f0a5526 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -222,6 +222,15 @@ $ gitk
 
 will show a nice graphical representation of the resulting history.
 
+At this point you could delete the experimental branch with
+
+------------------------------------------------
+$ git branch -d experimental
+------------------------------------------------
+
+This command ensures that the changes in the experimental branch are
+already in the current branch.
+
 If you develop on a branch crazy-idea, then regret it, you can always
 delete the branch with
 
@@ -391,8 +400,8 @@ $ git show HEAD		# the tip of the current branch
 $ git show experimental	# the tip of the "experimental" branch
 -------------------------------------
 
-Every commit has at least one "parent" commit, which points to the
-previous state of the project:
+Every commit has at least one "parent" commit (except the first),
+which points to the previous state of the project:
 
 -------------------------------------
 $ git show HEAD^  # to see the parent of HEAD
@@ -510,10 +519,10 @@ of the file:
 $ git diff v2.5:Makefile HEAD:Makefile.in
 -------------------------------------
 
-You can also use "git cat-file -p" to see any such file:
+You can also use "git show" to see any such file:
 
 -------------------------------------
-$ git cat-file -p v2.5:Makefile
+$ git show v2.5:Makefile
 -------------------------------------
 
 Next Steps
-- 
1.5.0.rc0.g91ea
