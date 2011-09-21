From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/3] git-read-tree.txt: language and typography fixes
Date: Wed, 21 Sep 2011 09:48:37 +0200
Message-ID: <9355aabec087558c4347d012d87e4c678fae148b.1316590874.git.git@drmicha.warpmail.net>
References: <4E7996AA.4040909@drmicha.warpmail.net>
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 21 09:48:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6HY6-0000EA-7J
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 09:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638Ab1IUHss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 03:48:48 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:55042 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752409Ab1IUHsq (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2011 03:48:46 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway2.nyi.mail.srv.osa (Postfix) with ESMTP id 1B9142930C;
	Wed, 21 Sep 2011 03:48:46 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute4.internal (MEProxy); Wed, 21 Sep 2011 03:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=RJ
	9/rCNr8xFRBXLfqG6SbnThzPk=; b=G8fxXKwZ2Bl6e5ZCAhhYWqLeXyVmavFKax
	IZPKpfmT9ngYKcPbdFpWyrd1BG6yiWXz8hoIca7guxRHeJ7wDrQB89jNAdP+67w4
	+v9bPPx6AvvweAqdAclW4pr/chKf3YOpzYFFqUIxj4ASh2694Mxa+tq7nofRPIgF
	OkypHmOU4=
X-Sasl-enc: urrptfzeQTN/qxmSre8Dj3c0iAks/yc+oJazf9YiF48o 1316591325
Received: from localhost (p548594C9.dip0.t-ipconnect.de [84.133.148.201])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 517957C064A;
	Wed, 21 Sep 2011 03:48:45 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc0.469.g9eb94
In-Reply-To: <4E7996AA.4040909@drmicha.warpmail.net>
In-Reply-To: <cover.1316590874.git.git@drmicha.warpmail.net>
References: <cover.1316590874.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181823>

Fix a few missing articles and such, and mark-up 'commands' and `files`
appropriately.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-read-tree.txt |   40 +++++++++++++++++++-------------------
 1 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index c45d53c..0004f4b 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -47,7 +47,7 @@ OPTIONS
 
 -i::
 	Usually a merge requires the index file as well as the
-	files in the working tree are up to date with the
+	files in the working tree to be up to date with the
 	current head commit, in order not to lose local
 	changes.  This flag disables the check with the working
 	tree and is meant to be used when creating a merge of
@@ -71,21 +71,21 @@ OPTIONS
 --aggressive::
 	Usually a three-way merge by 'git read-tree' resolves
 	the merge for really trivial cases and leaves other
-	cases unresolved in the index, so that Porcelains can
+	cases unresolved in the index, so that porcelains can
 	implement different merge policies.  This flag makes the
-	command to resolve a few more cases internally:
+	command resolve a few more cases internally:
 +
 * when one side removes a path and the other side leaves the path
   unmodified.  The resolution is to remove that path.
 * when both sides remove a path.  The resolution is to remove that path.
-* when both sides adds a path identically.  The resolution
+* when both sides add a path identically.  The resolution
   is to add that path.
 
 --prefix=<prefix>/::
 	Keep the current index contents, and read the contents
-	of named tree-ish under directory at `<prefix>`.  The
+	of the named tree-ish under the directory at `<prefix>`. The
 	original index file cannot have anything at the path
-	`<prefix>` itself, and have nothing in `<prefix>/`
+	`<prefix>` itself, nor anything in the `<prefix>/`
 	directory.  Note that the `<prefix>/` value must end
 	with a slash.
 
@@ -379,15 +379,15 @@ have finished your work-in-progress), attempt the merge again.
 Sparse checkout
 ---------------
 
-"Sparse checkout" allows to sparsely populate working directory.
-It uses skip-worktree bit (see linkgit:git-update-index[1]) to tell
-Git whether a file on working directory is worth looking at.
+"Sparse checkout" allows populating the working directory sparsely.
+It uses the skip-worktree bit (see linkgit:git-update-index[1]) to tell
+Git whether a file in the working directory is worth looking at.
 
-"git read-tree" and other merge-based commands ("git merge", "git
-checkout"...) can help maintaining skip-worktree bitmap and working
+'git read-tree' and other merge-based commands ('git merge', 'git
+checkout'...) can help maintaining the skip-worktree bitmap and working
 directory update. `$GIT_DIR/info/sparse-checkout` is used to
-define the skip-worktree reference bitmap. When "git read-tree" needs
-to update working directory, it will reset skip-worktree bit in index
+define the skip-worktree reference bitmap. When 'git read-tree' needs
+to update the working directory, it resets the skip-worktree bit in the index
 based on this file, which uses the same syntax as .gitignore files.
 If an entry matches a pattern in this file, skip-worktree will be
 set on that entry. Otherwise, skip-worktree will be unset.
@@ -397,18 +397,18 @@ skip-worktree turns from unset to set, it will add the corresponding
 file back. If it turns from set to unset, that file will be removed.
 
 While `$GIT_DIR/info/sparse-checkout` is usually used to specify what
-files are in. You can also specify what files are _not_ in, using
-negate patterns. For example, to remove file "unwanted":
+files are in, you can also specify what files are _not_ in, using
+negate patterns. For example, to remove the file `unwanted`:
 
 ----------------
 *
 !unwanted
 ----------------
 
-Another tricky thing is fully repopulating working directory when you
+Another tricky thing is fully repopulating the working directory when you
 no longer want sparse checkout. You cannot just disable "sparse
-checkout" because skip-worktree are still in the index and you working
-directory is still sparsely populated. You should re-populate working
+checkout" because skip-worktree bits are still in the index and your working
+directory is still sparsely populated. You should re-populate the working
 directory with the `$GIT_DIR/info/sparse-checkout` file content as
 follows:
 
@@ -416,8 +416,8 @@ follows:
 *
 ----------------
 
-Then you can disable sparse checkout. Sparse checkout support in "git
-read-tree" and similar commands is disabled by default. You need to
+Then you can disable sparse checkout. Sparse checkout support in 'git
+read-tree' and similar commands is disabled by default. You need to
 turn `core.sparseCheckout` on in order to have sparse checkout
 support.
 
-- 
1.7.7.rc0.469.g9eb94
