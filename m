From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 4/6] git-reset.txt: use "working tree" consistently
Date: Mon, 13 Sep 2010 10:06:34 +0200
Message-ID: <30bf6d6227a2ebbe4453bd77d44c726cc56d078b.1284365021.git.git@drmicha.warpmail.net>
References: <cover.1284365021.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 13 10:16:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ov4Di-0004ll-9D
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 10:16:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754613Ab0IMIQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Sep 2010 04:16:31 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:52492 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754533Ab0IMIQW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Sep 2010 04:16:22 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C7C6A1F3;
	Mon, 13 Sep 2010 04:06:41 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Mon, 13 Sep 2010 04:06:41 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=zSzWuv/lGc1E/zOywRV0XaJFSv0=; b=dy80YiC4NZeyKZy/sTB2c1u8n+EmXwwzGneZoI11SCRImZveL01funZlwDvSRybI4W0XeaNUQmHLFaX5tyQvI0hBM2ZNiW292qdhiedWYkAVvHVYcWgmM18CTm3n0KBaEF4tKLBo8mwBVYmbMaMovl/WBc6jIzjyQgLsvqenNWU=
X-Sasl-enc: WfSp65PpPbXamUsp604UsOjMgXsSEWGk49uofw+mJz2U 1284365201
Received: from localhost (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 495EA4053A4;
	Mon, 13 Sep 2010 04:06:41 -0400 (EDT)
X-Mailer: git-send-email 1.7.3.rc1.215.g6997c
In-Reply-To: <cover.1284365021.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156078>

as per git help glossary

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-reset.txt |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 65f5d07..60b4b80 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -16,12 +16,12 @@ DESCRIPTION
 -----------
 In the first and second form, copy entries from <commit> to the index.
 In the third form, set the current branch head to <commit>, optionally
-modifying index and worktree to match.  The <commit> defaults to HEAD
+modifying index and working tree to match.  The <commit> defaults to HEAD
 in all forms.
 
 'git reset' [-q] [<commit>] [--] <paths>...::
 	This form resets the index entries for all <paths> to their
-	state at the <commit>.  (It does not affect the worktree, nor
+	state at the <commit>.  (It does not affect the working tree, nor
 	the current branch.)
 +
 This means that `git reset <paths>` is the opposite of `git add
@@ -185,7 +185,7 @@ tip of the current branch in ORIG_HEAD, so resetting hard to it
 brings your index file and the working tree back to that state,
 and resets the tip of the branch to that commit.
 
-Undo a merge or pull inside a dirty work tree::
+Undo a merge or pull inside a dirty working tree::
 +
 ------------
 $ git pull                         <1>
@@ -258,7 +258,7 @@ Suppose you are working on something and you commit it, and then you
 continue working a bit more, but now you think that what you have in
 your working tree should be in another branch that has nothing to do
 with what you committed previously. You can start a new branch and
-reset it while keeping the changes in your work tree.
+reset it while keeping the changes in your working tree.
 +
 ------------
 $ git tag start
@@ -347,11 +347,11 @@ in the index and set HEAD to target (which has the file in state D).
 				--keep   B       C     C
 
 "reset --merge" is meant to be used when resetting out of a conflicted
-merge. Any mergy operation guarantees that the work tree file that is
+merge. Any mergy operation guarantees that the working tree file that is
 involved in the merge does not have local change wrt the index before
-it starts, and that it writes the result out to the work tree. So if
+it starts, and that it writes the result out to the working tree. So if
 we see some difference between the index and the target and also
-between the index and the work tree, then it means that we are not
+between the index and the working tree, then it means that we are not
 resetting out from a state that a mergy operation left after failing
 with a conflict. That is why we disallow --merge option in this case.
 
-- 
1.7.3.rc1.215.g6997c
