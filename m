From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/3] revisions.txt: consistent use of quotes
Date: Thu, 31 Mar 2011 13:03:07 +0200
Message-ID: <9ceacbc745405ffef097896afd123806e1f9bc90.1301569271.git.git@drmicha.warpmail.net>
References: <cover.1301569271.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 13:06:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5FiB-0000xv-CD
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 13:06:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757325Ab1CaLGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 07:06:44 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:33068 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751729Ab1CaLGn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Mar 2011 07:06:43 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A82EA2060E
	for <git@vger.kernel.org>; Thu, 31 Mar 2011 07:06:42 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 31 Mar 2011 07:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id:in-reply-to:references; s=smtpout; bh=X1dknP2SmImPSsNZFEKO1FvL7zA=; b=bIr/BFT9WliIs1nVABFqLTcBfhRjgukOnnPHM+h6bVGpPFD1n6O3/ejbfw4LmWkz+BhKm+jnwSHj/NY5QG55q1aqQmn/uin5Nani5kCwjyL7RpFbmu7CM+KQe3Pqk699Ty17G6YdG/vDcuQ79tbqeQBv4FOIZhbp5OR0V/xkijw=
X-Sasl-enc: /kccElLwIqjdqw0EZ2uHRnQKX4RTH5zye8ofo7pR8xwX 1301569601
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E76CE40069E;
	Thu, 31 Mar 2011 07:06:41 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.2.668.gba03a4
In-Reply-To: <cover.1301569271.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170470>

Our use of quotes is inconsistent everywhere and within some files.
Before reworking the structure of revisions.txt, make the quotes
consistent:

`git command`

'some snippet or term'

The former gets typeset as code, the latter with some form of emphasis.
the man backend uses two types of emphasis.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/revisions.txt |  104 +++++++++++++++++++++---------------------
 1 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 04fceee..b994bab 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -13,45 +13,45 @@ blobs contained in a commit.
   name the same commit object if there are no other object in
   your repository whose object name starts with dae86e.
 
-* An output from 'git describe'; i.e. a closest tag, optionally
+* An output from `git describe`; i.e. a closest tag, optionally
   followed by a dash and a number of commits, followed by a dash, a
-  `g`, and an abbreviated object name.
+  'g', and an abbreviated object name.
 
 * A symbolic ref name.  E.g. 'master' typically means the commit
-  object referenced by refs/heads/master.  If you
-  happen to have both heads/master and tags/master, you can
+  object referenced by 'refs/heads/master'.  If you
+  happen to have both 'heads/master' and 'tags/master', you can
   explicitly say 'heads/master' to tell git which one you mean.
-  When ambiguous, a `<name>` is disambiguated by taking the
+  When ambiguous, a '<name>' is disambiguated by taking the
   first match in the following rules:
 
-  . if `$GIT_DIR/<name>` exists, that is what you mean (this is usually
-    useful only for `HEAD`, `FETCH_HEAD`, `ORIG_HEAD`, `MERGE_HEAD`
-    and `CHERRY_PICK_HEAD`);
+  . if '$GIT_DIR/<name>' exists, that is what you mean (this is usually
+    useful only for 'HEAD', 'FETCH_HEAD', 'ORIG_HEAD', 'MERGE_HEAD'
+    and 'CHERRY_PICK_HEAD');
 
-  . otherwise, `refs/<name>` if exists;
+  . otherwise, 'refs/<name>' if exists;
 
-  . otherwise, `refs/tags/<name>` if exists;
+  . otherwise, 'refs/tags/<name>' if exists;
 
-  . otherwise, `refs/heads/<name>` if exists;
+  . otherwise, 'refs/heads/<name>' if exists;
 
-  . otherwise, `refs/remotes/<name>` if exists;
+  . otherwise, 'refs/remotes/<name>' if exists;
 
-  . otherwise, `refs/remotes/<name>/HEAD` if exists.
+  . otherwise, 'refs/remotes/<name>/HEAD' if exists.
 +
-HEAD names the commit your changes in the working tree is based on.
-FETCH_HEAD records the branch you fetched from a remote repository
-with your last 'git fetch' invocation.
-ORIG_HEAD is created by commands that moves your HEAD in a drastic
-way, to record the position of the HEAD before their operation, so that
+'HEAD' names the commit your changes in the working tree is based on.
+'FETCH_HEAD' records the branch you fetched from a remote repository
+with your last `git fetch` invocation.
+'ORIG_HEAD' is created by commands that moves your 'HEAD' in a drastic
+way, to record the position of the 'HEAD' before their operation, so that
 you can change the tip of the branch back to the state before you ran
 them easily.
-MERGE_HEAD records the commit(s) you are merging into your branch
-when you run 'git merge'.
-CHERRY_PICK_HEAD records the commit you are cherry-picking
-when you run 'git cherry-pick'.
+'MERGE_HEAD' records the commit(s) you are merging into your branch
+when you run `git merge`.
+'CHERRY_PICK_HEAD' records the commit you are cherry-picking
+when you run `git cherry-pick`.
 +
-Note that any of the `refs/*` cases above may come either from
-the `$GIT_DIR/refs` directory or from the `$GIT_DIR/packed-refs` file.
+Note that any of the 'refs/*' cases above may come either from
+the '$GIT_DIR/refs' directory or from the '$GIT_DIR/packed-refs' file.
 
 * A ref followed by the suffix '@' with a date specification
   enclosed in a brace
@@ -59,10 +59,10 @@ the `$GIT_DIR/refs` directory or from the `$GIT_DIR/packed-refs` file.
   second ago\}' or '\{1979-02-26 18:30:00\}') to specify the value
   of the ref at a prior point in time.  This suffix may only be
   used immediately following a ref name and the ref must have an
-  existing log ($GIT_DIR/logs/<ref>). Note that this looks up the state
+  existing log ('$GIT_DIR/logs/<ref>'). Note that this looks up the state
   of your *local* ref at a given time; e.g., what was in your local
-  `master` branch last week. If you want to look at commits made during
-  certain times, see `--since` and `--until`.
+  'master' branch last week. If you want to look at commits made during
+  certain times, see '--since' and '--until'.
 
 * A ref followed by the suffix '@' with an ordinal specification
   enclosed in a brace pair (e.g. '\{1\}', '\{15\}') to specify
@@ -70,7 +70,7 @@ the `$GIT_DIR/refs` directory or from the `$GIT_DIR/packed-refs` file.
   is the immediate prior value of 'master' while 'master@\{5\}'
   is the 5th prior value of 'master'. This suffix may only be used
   immediately following a ref name and the ref must have an existing
-  log ($GIT_DIR/logs/<ref>).
+  log ('$GIT_DIR/logs/<ref>').
 
 * You can use the '@' construct with an empty ref part to get at a
   reflog of the current branch. For example, if you are on the
@@ -98,36 +98,36 @@ the `$GIT_DIR/refs` directory or from the `$GIT_DIR/packed-refs` file.
   the usage of this form.
 
 * A suffix '{caret}' followed by an object type name enclosed in
-  brace pair (e.g. `v0.99.8{caret}\{commit\}`) means the object
+  brace pair (e.g. 'v0.99.8{caret}\{commit\}') means the object
   could be a tag, and dereference the tag recursively until an
   object of that type is found or the object cannot be
-  dereferenced anymore (in which case, barf).  `rev{caret}0`
-  introduced earlier is a short-hand for `rev{caret}\{commit\}`.
+  dereferenced anymore (in which case, barf).  'rev{caret}0'
+  introduced earlier is a short-hand for 'rev{caret}\{commit\}'.
 
 * A suffix '{caret}' followed by an empty brace pair
-  (e.g. `v0.99.8{caret}\{\}`) means the object could be a tag,
+  (e.g. 'v0.99.8{caret}\{\}') means the object could be a tag,
   and dereference the tag recursively until a non-tag object is
   found.
 
 * A suffix '{caret}' to a revision parameter followed by a brace
-  pair that contains a text led by a slash (e.g. `HEAD^{/fix nasty bug}`):
-  this is the same as `:/fix nasty bug` syntax below except that
+  pair that contains a text led by a slash (e.g. 'HEAD^{/fix nasty bug}'):
+  this is the same as ':/fix nasty bug' syntax below except that
   it returns the youngest matching commit which is reachable from
   the ref before '{caret}'.
 
-* A colon, followed by a slash, followed by a text (e.g. `:/fix nasty bug`): this names
+* A colon, followed by a slash, followed by a text (e.g. ':/fix nasty bug'): this names
   a commit whose commit message matches the specified regular expression.
   This name returns the youngest matching commit which is
   reachable from any ref.  If the commit message starts with a
   '!', you have to repeat that;  the special sequence ':/!',
   followed by something else than '!' is reserved for now.
   The regular expression can match any part of the commit message. To
-  match messages starting with a string, one can use e.g. `:/^foo`.
+  match messages starting with a string, one can use e.g. ':/^foo'.
 
-* A suffix ':' followed by a path (e.g. `HEAD:README`); this names the blob or tree
+* A suffix ':' followed by a path (e.g. 'HEAD:README'); this names the blob or tree
   at the given path in the tree-ish object named by the part
   before the colon.
-  ':path' (with an empty part before the colon, e.g. `:README`)
+  ':path' (with an empty part before the colon, e.g. ':README')
   is a special case of the syntax described next: content
   recorded in the index at the given path.
   A path starting with './' or '../' is relative to current working directory.
@@ -136,9 +136,9 @@ the `$GIT_DIR/refs` directory or from the `$GIT_DIR/packed-refs` file.
   the same tree structure with the working tree.
 
 * A colon, optionally followed by a stage number (0 to 3) and a
-  colon, followed by a path (e.g. `:0:README`); this names a blob object in the
+  colon, followed by a path (e.g. ':0:README'); this names a blob object in the
   index at the given path. Missing stage number (and the colon
-  that follows it, e.g. `:README`) names a stage 0 entry. During a merge, stage
+  that follows it, e.g. ':README') names a stage 0 entry. During a merge, stage
   1 is the common ancestor, stage 2 is the target branch's version
   (typically the current branch), and stage 3 is the version from
   the branch being merged.
@@ -175,31 +175,31 @@ G   H   I   J
 SPECIFYING RANGES
 -----------------
 
-History traversing commands such as 'git log' operate on a set
+History traversing commands such as `git log` operate on a set
 of commits, not just a single commit.  To these commands,
 specifying a single revision with the notation described in the
 previous section means the set of commits reachable from that
 commit, following the commit ancestry chain.
 
-To exclude commits reachable from a commit, a prefix `{caret}`
-notation is used.  E.g. `{caret}r1 r2` means commits reachable
-from `r2` but exclude the ones reachable from `r1`.
+To exclude commits reachable from a commit, a prefix '{caret}'
+notation is used.  E.g. '{caret}r1 r2' means commits reachable
+from 'r2' but exclude the ones reachable from 'r1'.
 
 This set operation appears so often that there is a shorthand
-for it.  When you have two commits `r1` and `r2` (named according
+for it.  When you have two commits 'r1' and 'r2' (named according
 to the syntax explained in SPECIFYING REVISIONS above), you can ask
 for commits that are reachable from r2 excluding those that are reachable
-from r1 by `{caret}r1 r2` and it can be written as `r1..r2`.
+from r1 by '{caret}r1 r2' and it can be written as 'r1..r2'.
 
-A similar notation `r1\...r2` is called symmetric difference
-of `r1` and `r2` and is defined as
-`r1 r2 --not $(git merge-base --all r1 r2)`.
+A similar notation 'r1\...r2' is called symmetric difference
+of 'r1' and 'r2' and is defined as
+'r1 r2 --not $(git merge-base --all r1 r2)'.
 It is the set of commits that are reachable from either one of
-`r1` or `r2` but not from both.
+'r1' or 'r2' but not from both.
 
 Two other shorthands for naming a set that is formed by a commit
-and its parent commits exist.  The `r1{caret}@` notation means all
-parents of `r1`.  `r1{caret}!` includes commit `r1` but excludes
+and its parent commits exist.  The 'r1{caret}@' notation means all
+parents of 'r1'.  'r1{caret}!' includes commit 'r1' but excludes
 all of its parents.
 
 Here are a handful of examples:
-- 
1.7.4.2.668.gba03a4
