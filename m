From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] Fix bad quoting in documentation
Date: Sat, 16 Jan 2010 13:32:16 +0530
Message-ID: <f3271551001160002r25cb0ac7hc96891f4af22bd03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 16 09:04:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NW3dv-0008Pe-Ns
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 09:04:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519Ab0APICi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Jan 2010 03:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324Ab0APICi
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 03:02:38 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:55214 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721Ab0APICh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Jan 2010 03:02:37 -0500
Received: by yxe17 with SMTP id 17so1550451yxe.33
        for <git@vger.kernel.org>; Sat, 16 Jan 2010 00:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=ZLbjHLFneUB6Z1C4jco4UWWKBOKvtlOvdXU/8A80diM=;
        b=IS6I+dt5IILRjCAmf5Z/EF9d7X562N4cdBQUWP3tsu/AThQ/tDarcbYZfsgXLoUvdV
         5BC5ZkQtbMWwdjoWffOKHwHW9wM6/Vqzul/JMDWBsotIijDEvRCBzcs5EWQoOytVXH3o
         ofd9pTeJBxRhwdLb9E4/y0Qn3cqj5oNAlk/W4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=bO9LnfmoInQZ4+QvjKzbzq6M+LQOmiqKrxGa7nQO30lmiUgM7VWYWyTlLR6QJt9tg+
         IPhLU94KHsJzCck9jRv4Ci9ZiRKmy+3BR6+U7u/Q3m0/Ep+YVhbiHGlPgNE79pl07MMR
         Vb7G+b6oW42deozs4g6xCrCKtdG5bC7JC1yII=
Received: by 10.91.55.26 with SMTP id h26mr3389846agk.83.1263628956111; Sat, 
	16 Jan 2010 00:02:36 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137205>

Reported by Fr=E9d=E9ric Bri=E8re <fbriere@fbriere.net> through
http://bugs.debian.org/540001

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/diff-options.txt      |    2 +-
 Documentation/git-add.txt           |    4 ++--
 Documentation/git-bundle.txt        |    8 ++++----
 Documentation/git-checkout.txt      |    4 ++--
 Documentation/git-filter-branch.txt |   30 +++++++++++++++------------=
---
 Documentation/git-format-patch.txt  |    4 ++--
 Documentation/git-rebase.txt        |    8 ++++----
 Documentation/git-reflog.txt        |    6 +++---
 Documentation/git-rev-parse.txt     |   24 ++++++++++++------------
 Documentation/git-rm.txt            |    6 +++---
 10 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-option=
s.txt
index 8707d0e..6f3c115 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -54,7 +54,7 @@ endif::git-format-patch[]
 	giving another width to it separated by a comma.

 --numstat::
-	Similar to `\--stat`, but shows number of added and
+	Similar to `--stat`, but shows number of added and
 	deleted lines in decimal notation and pathname without
 	abbreviation, to make it more machine friendly.  For
 	binary files, outputs two `-` instead of saying
diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 1f1b199..838ad6f 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -149,14 +149,14 @@ those in info/exclude.  See
linkgit:gitrepository-layout[5].
 EXAMPLES
 --------

-* Adds content from all `\*.txt` files under `Documentation` directory
+* Adds content from all `*.txt` files under `Documentation` directory
 and its subdirectories:
 +
 ------------
 $ git add Documentation/\\*.txt
 ------------
 +
-Note that the asterisk `\*` is quoted from the shell in this
+Note that the asterisk `*` is quoted from the shell in this
 example; this lets the command include the files from
 subdirectories of `Documentation/` directory.

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.tx=
t
index c3a066e..ee8722f 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -60,7 +60,7 @@ unbundle <file>::
 [git-rev-list-args...]::
        A list of arguments, acceptable to 'git-rev-parse' and
        'git-rev-list', that specifies the specific objects and referen=
ces
-       to transport.  For example, `master\~10..master` causes the
+       to transport.  For example, `master~10..master` causes the
        current master reference to be packaged along with all objects
        added since its 10th ancestor commit.  There is no explicit
        limit to the number of references and objects that may be
@@ -79,12 +79,12 @@ SPECIFYING REFERENCES

 'git-bundle' will only package references that are shown by
 'git-show-ref': this includes heads, tags, and remote heads.  Referenc=
es
-such as `master\~1` cannot be packaged, but are perfectly suitable for
+such as `master~1` cannot be packaged, but are perfectly suitable for
 defining the basis.  More than one reference may be packaged, and more
 than one basis can be specified.  The objects packaged are those not
 contained in the union of the given bases.  Each basis can be
-specified explicitly (e.g. `^master\~10`), or implicitly (e.g.
-`master\~10..master`, `--since=3D10.days.ago master`).
+specified explicitly (e.g. `^master~10`), or implicitly (e.g.
+`master~10..master`, `--since=3D10.days.ago master`).

 It is very important that the basis used be held by the destination.
 It is okay to err on the side of caution, causing the bundle file
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkou=
t.txt
index 37c1810..df27ca5 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -133,9 +133,9 @@ edits from your current working tree.
 	commit, your HEAD becomes "detached" and you are no longer on
 	any branch (see below for details).
 +
-As a special case, the `"@\{-N\}"` syntax for the N-th last branch
+As a special case, the '@\{-N\}' syntax for the N-th last branch
 checks out the branch (instead of detaching).  You may also specify
-`-` which is synonymous with `"@\{-1\}"`.
+`-` which is synonymous with '@\{-1\}'.

 <new_branch>::
 	Name for the new branch.
diff --git a/Documentation/git-filter-branch.txt
b/Documentation/git-filter-branch.txt
index 394a77a..2fa46cc 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -95,8 +95,8 @@ OPTIONS
 --index-filter <command>::
 	This is the filter for rewriting the index.  It is similar to the
 	tree filter but does not check out the tree, which makes it much
-	faster.  Frequently used with `git rm \--cached
-	\--ignore-unmatch ...`, see EXAMPLES below.  For hairy
+	faster.  Frequently used with `git rm --cached
+	--ignore-unmatch ...`, see EXAMPLES below.  For hairy
 	cases, see linkgit:git-update-index[1].

 --parent-filter <command>::
@@ -221,11 +221,11 @@ However, if the file is absent from the tree of
some commit,
 a simple `rm filename` will fail for that tree and commit.
 Thus you may instead want to use `rm -f filename` as the script.

-Using `\--index-filter` with 'git-rm' yields a significantly faster
+Using `--index-filter` with 'git-rm' yields a significantly faster
 version.  Like with using `rm filename`, `git rm --cached filename`
 will fail if the file is absent from the tree of a commit.  If you
 want to "completely forget" a file, it does not matter when it entered
-history, so we also add `\--ignore-unmatch`:
+history, so we also add `--ignore-unmatch`:

 ----------------------------------------------------------------------=
----
 git filter-branch --index-filter 'git rm --cached --ignore-unmatch
filename' HEAD
@@ -241,8 +241,8 @@ git filter-branch --subdirectory-filter foodir -- -=
-all
 -------------------------------------------------------

 Thus you can, e.g., turn a library subdirectory into a repository of
-its own.  Note the `\--` that separates 'filter-branch' options from
-revision options, and the `\--all` to rewrite all branches and tags.
+its own.  Note the `--` that separates 'filter-branch' options from
+revision options, and the `--all` to rewrite all branches and tags.

 To set a commit (which typically is at the tip of another
 history) to be the parent of the current initial commit, in
@@ -370,18 +370,18 @@ Checklist for Shrinking a Repository
 ------------------------------------

 git-filter-branch is often used to get rid of a subset of files,
-usually with some combination of `\--index-filter` and
-`\--subdirectory-filter`.  People expect the resulting repository to
+usually with some combination of `--index-filter` and
+`--subdirectory-filter`.  People expect the resulting repository to
 be smaller than the original, but you need a few more steps to
 actually make it smaller, because git tries hard not to lose your
 objects until you tell it to.  First make sure that:

 * You really removed all variants of a filename, if a blob was moved
-  over its lifetime.  `git log \--name-only \--follow \--all \--
+  over its lifetime.  `git log --name-only --follow --all --
   filename` can help you find renames.

-* You really filtered all refs: use `\--tag-name-filter cat \--
-  \--all` when calling git-filter-branch.
+* You really filtered all refs: use `--tag-name-filter cat --
+  --all` when calling git-filter-branch.

 Then there are two ways to get a smaller repository.  A safer way is
 to clone, that keeps your original intact.
@@ -396,14 +396,14 @@ approach, so *make a backup* or go back to
cloning it.  You have been
 warned.

 * Remove the original refs backed up by git-filter-branch: say `git
-  for-each-ref \--format=3D"%(refname)" refs/original/ | xargs -n 1 gi=
t
+  for-each-ref --format=3D"%(refname)" refs/original/ | xargs -n 1 git
   update-ref -d`.

-* Expire all reflogs with `git reflog expire \--expire=3Dnow \--all`.
+* Expire all reflogs with `git reflog expire --expire=3Dnow --all`.

-* Garbage collect all unreferenced objects with `git gc \--prune=3Dnow=
`
+* Garbage collect all unreferenced objects with `git gc --prune=3Dnow`
   (or if your git-gc is not new enough to support arguments to
-  `\--prune`, use `git repack -ad; git prune` instead).
+  `--prune`, use `git repack -ad; git prune` instead).


 Author
diff --git a/Documentation/git-format-patch.txt
b/Documentation/git-format-patch.txt
index f1fd0df..20d1960 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -44,7 +44,7 @@ There are two ways to specify which commits to operat=
e on.
 The first rule takes precedence in the case of a single <commit>.  To
 apply the second rule, i.e., format everything since the beginning of
 history up until <commit>, use the '\--root' option: `git format-patch
-\--root <commit>`.  If you want to format only <commit> itself, you
+--root <commit>`.  If you want to format only <commit> itself, you
 can do this with `git format-patch -1 <commit>`.

 By default, each output file is numbered sequentially from 1, and uses=
 the
@@ -133,7 +133,7 @@ include::diff-options.txt[]
 The optional <style> argument can be either `shallow` or `deep`.
 'shallow' threading makes every mail a reply to the head of the
 series, where the head is chosen from the cover letter, the
-`\--in-reply-to`, and the first patch mail, in this order.  'deep'
+`--in-reply-to`, and the first patch mail, in this order.  'deep'
 threading makes every mail a reply to the previous one.
 +
 The default is `--no-thread`, unless the 'format.thread' configuration
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.tx=
t
index ca5e1e8..9554c63 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -512,8 +512,8 @@ Easy case: The changes are literally the same.::
 Hard case: The changes are not the same.::

 	This happens if the 'subsystem' rebase had conflicts, or used
-	`\--interactive` to omit, edit, or squash commits; or if the
-	upstream used one of `commit \--amend`, `reset`, or
+	`--interactive` to omit, edit, or squash commits; or if the
+	upstream used one of `commit --amend`, `reset`, or
 	`filter-branch`.


@@ -549,7 +549,7 @@ correspond to the ones before the rebase.
 NOTE: While an "easy case recovery" sometimes appears to be successful
       even in the hard case, it may have unintended consequences.  For
       example, a commit that was removed via `git rebase
-      \--interactive` will be **resurrected**!
+      --interactive` will be **resurrected**!

 The idea is to manually tell 'git-rebase' "where the old 'subsystem'
 ended and your 'topic' began", that is, what the old merge-base
@@ -557,7 +557,7 @@ between them was.  You will have to find a way to
name the last commit
 of the old 'subsystem', for example:

 * With the 'subsystem' reflog: after 'git-fetch', the old tip of
-  'subsystem' is at `subsystem@\{1}`.  Subsequent fetches will
+  'subsystem' is at 'subsystem@\{1\}'.  Subsequent fetches will
   increase the number.  (See linkgit:git-reflog[1].)

 * Relative to the tip of 'topic': knowing that your 'topic' has three
diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.tx=
t
index 7f7a544..32baa14 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -40,13 +40,13 @@ as well).  It is an alias for `git log -g
--abbrev-commit --pretty=3Doneline`;
 see linkgit:git-log[1].

 The reflog is useful in various git commands, to specify the old value
-of a reference. For example, `HEAD@\{2\}` means "where HEAD used to be
-two moves ago", `master@\{one.week.ago\}` means "where master used to
+of a reference. For example, 'HEAD@\{2\}' means "where HEAD used to be
+two moves ago", 'master@\{one.week.ago\}' means "where master used to
 point to one week ago", and so on. See linkgit:git-rev-parse[1] for
 more details.

 To delete single entries from the reflog, use the subcommand "delete"
-and specify the _exact_ entry (e.g. "`git reflog delete master@\{2\}`"=
).
+and specify the _exact_ entry (e.g. "`git reflog delete master@{2}`").


 OPTIONS
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-pa=
rse.txt
index 82045a2..c332a3c 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -74,7 +74,7 @@ OPTIONS
 	properly quoted for consumption by shell.  Useful when
 	you expect your parameter to contain whitespaces and
 	newlines (e.g. when using pickaxe `-S` with
-	'git-diff-\*'). In contrast to the `--sq-quote` option,
+	'git-diff-*'). In contrast to the `--sq-quote` option,
 	the command input is still interpreted as usual.

 --not::
@@ -88,7 +88,7 @@ OPTIONS
 	form as close to the original input as possible.

 --symbolic-full-name::
-	This is similar to \--symbolic, but it omits input that
+	This is similar to `--symbolic`, but it omits input that
 	are not refs (i.e. branch or tag names; or more
 	explicitly disambiguating "heads/master" form, when you
 	want to name the "master" branch when there is an
@@ -246,14 +246,14 @@ when you run 'git-merge'.
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

@@ -314,25 +314,25 @@ specifying a single revision with the notation
described in the
 previous section means the set of commits reachable from that
 commit, following the commit ancestry chain.

-To exclude commits reachable from a commit, a prefix `{caret}`
-notation is used.  E.g. `{caret}r1 r2` means commits reachable
+To exclude commits reachable from a commit, a prefix '{caret}'
+notation is used.  E.g. '{caret}r1 r2' means commits reachable
 from `r2` but exclude the ones reachable from `r1`.

 This set operation appears so often that there is a shorthand
 for it.  When you have two commits `r1` and `r2` (named according
 to the syntax explained in SPECIFYING REVISIONS above), you can ask
 for commits that are reachable from r2 excluding those that are reacha=
ble
-from r1 by `{caret}r1 r2` and it can be written as `r1..r2`.
+from r1 by '{caret}r1 r2' and it can be written as 'r1..r2'.

-A similar notation `r1\...r2` is called symmetric difference
+A similar notation 'r1\...r2' is called symmetric difference
 of `r1` and `r2` and is defined as
 `r1 r2 --not $(git merge-base --all r1 r2)`.
 It is the set of commits that are reachable from either one of
 `r1` or `r2` but not from both.

 Two other shorthands for naming a set that is formed by a commit
-and its parent commits exist.  The `r1{caret}@` notation means all
-parents of `r1`.  `r1{caret}!` includes commit `r1` but excludes
+and its parent commits exist.  The 'r1{caret}@' notation means all
+parents of `r1`.  'r1{caret}!' includes commit `r1` but excludes
 all of its parents.

 Here are a handful of examples:
diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index c21d19e..fe3ee38 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -78,7 +78,7 @@ a file that you have not told git about does not
remove that file.

 File globbing matches across directory boundaries.  Thus, given
 two directories `d` and `d2`, there is a difference between
-using `git rm \'d\*\'` and `git rm \'d/\*\'`, as the former will
+using `git rm 'd*'` and `git rm 'd/*'`, as the former will
 also remove all of directory `d2`.

 REMOVING FILES THAT HAVE DISAPPEARED FROM THE FILESYSTEM
@@ -136,10 +136,10 @@ git diff --name-only --diff-filter=3DD -z | xargs
-0 git rm --cached
 EXAMPLES
 --------
 git rm Documentation/\\*.txt::
-	Removes all `\*.txt` files from the index that are under the
+	Removes all `*.txt` files from the index that are under the
 	`Documentation` directory and any of its subdirectories.
 +
-Note that the asterisk `\*` is quoted from the shell in this
+Note that the asterisk `*` is quoted from the shell in this
 example; this lets git, and not the shell, expand the pathnames
 of files and subdirectories under the `Documentation/` directory.

--=20
1.6.5
