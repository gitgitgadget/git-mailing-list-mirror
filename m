From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] Documentation: fix typos, grammar, asciidoc syntax
Date: Fri, 19 Dec 2008 13:14:18 +0100
Message-ID: <200812191314.19302.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Dec 19 13:15:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDeGA-0007Iv-Mb
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 13:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752659AbYLSMN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 07:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752306AbYLSMN4
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 07:13:56 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:56161 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbYLSMNy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 07:13:54 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id F028EF7DAFC0;
	Fri, 19 Dec 2008 13:13:52 +0100 (CET)
Received: from [91.19.63.31] (helo=pluto)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.109 #226)
	id 1LDeEq-0003j7-00; Fri, 19 Dec 2008 13:13:52 +0100
User-Agent: KMail/1.9.9
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/bCBN+XTCM8p/cVhnwrk+2HZNPjbEALzcVHvLe
	LoYcOPNTnOOOZsD/5M2BAptl8i4XaluejT1jrIfcvr+fjJ8oR6
	yHE18bpB6q1tiEcPJTCg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103560>


Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 Documentation/diff-format.txt         |    2 +-
 Documentation/diff-generate-patch.txt |    6 +++---
 Documentation/git-commit.txt          |    2 +-
 Documentation/git-diff-tree.txt       |    4 ++--
 Documentation/git-mailinfo.txt        |    2 +-
 Documentation/git-receive-pack.txt    |    4 ++--
 Documentation/git-reflog.txt          |    4 ++--
 Documentation/git-show-branch.txt     |    4 ++--
 Documentation/git-submodule.txt       |    2 +-
 Documentation/git-update-index.txt    |    8 ++++----
 Documentation/gitcore-tutorial.txt    |    8 ++++----
 Documentation/gitk.txt                |    4 ++--
 Documentation/i18n.txt                |    4 ++--
 13 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
index aafd3a3..1eeb1c7 100644
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -58,7 +58,7 @@ Possible status letters are:
 be committed)
 - X: "unknown" change type (most probably a bug, please report it)
 
-Status letters C and M are always followed by a score (denoting the
+Status letters C and R are always followed by a score (denoting the
 percentage of similarity between the source and target of the move or
 copy), and are the only ones to be so.
 
diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index 517e1eb..0f25ba7 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -143,15 +143,15 @@ different from it.
 
 A `-` character in the column N means that the line appears in
 fileN but it does not appear in the result.  A `+` character
-in the column N means that the line appears in the last file,
+in the column N means that the line appears in the result,
 and fileN does not have that line (in other words, the line was
 added, from the point of view of that parent).
 
 In the above example output, the function signature was changed
 from both files (hence two `-` removals from both file1 and
 file2, plus `++` to mean one line that was added does not appear
-in either file1 nor file2).  Also two other lines are the same
-from file1 but do not appear in file2 (hence prefixed with ` +`).
+in either file1 nor file2).  Also eight other lines are the same
+from file1 but do not appear in file2 (hence prefixed with `{plus}`).
 
 When shown by `git diff-tree -c`, it compares the parents of a
 merge commit with the merge result (i.e. file1..fileN are the
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 6203461..b5d81be 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -166,7 +166,7 @@ FROM UPSTREAM REBASE" section in linkgit:git-rebase[1].)
 	'git-commit' if any paths are given on the command line,
 	in which case this option can be omitted.
 	If this option is specified together with '--amend', then
-	no paths need be specified, which can be used to amend
+	no paths need to be specified, which can be used to amend
 	the last commit without committing changes that have
 	already been staged.
 
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index 5d48664..23b7abd 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -43,7 +43,7 @@ include::diff-options.txt[]
 	show tree entry itself as well as subtrees.  Implies -r.
 
 --root::
-	When '--root' is specified the initial commit will be showed as a big
+	When '--root' is specified the initial commit will be shown as a big
 	creation event. This is equivalent to a diff against the NULL tree.
 
 --stdin::
@@ -63,7 +63,7 @@ and terminated by a newline) is printed before the difference.  When
 comparing commits, the ID of the first (or only) commit, followed by a
 newline, is printed.
 +
-The following flags further affects the behavior when comparing
+The following flags further affect the behavior when comparing
 commits (but not trees).
 
 -m::
diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
index 31eccea..8d95aaa 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Reading a single e-mail message from the standard input, and
+Reads a single e-mail message from the standard input, and
 writes the commit log message in <msg> file, and the patches in
 <patch> file.  The author name, e-mail and e-mail subject are
 written out to the standard output to be used by 'git-am'
diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 6b2f8c4..514f03c 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -86,7 +86,7 @@ post-receive Hook
 -----------------
 After all refs were updated (or attempted to be updated), if any
 ref update was successful, and if $GIT_DIR/hooks/post-receive
-file exists and is executable, it will be invoke once with no
+file exists and is executable, it will be invoked once with no
 parameters.  The standard input of the hook will be one line
 for each successfully updated ref:
 
@@ -133,7 +133,7 @@ post-update Hook
 ----------------
 After all other processing, if at least one ref was updated, and
 if $GIT_DIR/hooks/post-update file exists and is executable, then
-post-update will called with the list of refs that have been updated.
+post-update will be called with the list of refs that have been updated.
 This can be used to implement any repository wide cleanup tasks.
 
 The exit code from this hook invocation is ignored; the only thing
diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index d99236e..7f7a544 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -28,7 +28,7 @@ updated.  This command is to manage the information recorded in it.
 
 The subcommand "expire" is used to prune older reflog entries.
 Entries older than `expire` time, or entries older than
-`expire-unreachable` time and are not reachable from the current
+`expire-unreachable` time and not reachable from the current
 tip, are removed from the reflog.  This is typically not used
 directly by the end users -- instead, see linkgit:git-gc[1].
 
@@ -71,7 +71,7 @@ them.
 	which in turn defaults to 90 days.
 
 --expire-unreachable=<time>::
-	Entries older than this time and are not reachable from
+	Entries older than this time and not reachable from
 	the current tip of the branch are pruned.  Without the
 	option it is taken from configuration
 	`gc.reflogExpireUnreachable`, which in turn defaults to
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index d3f2588..8277577 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -30,7 +30,7 @@ OPTIONS
 -------
 <rev>::
 	Arbitrary extended SHA1 expression (see linkgit:git-rev-parse[1])
-	that typically names a branch HEAD or a tag.
+	that typically names a branch head or a tag.
 
 <glob>::
 	A glob pattern that matches branch or tag names under
@@ -172,7 +172,7 @@ only the primary branches.  In addition, if you happen to be on
 your topic branch, it is shown as well.
 
 ------------
-$ git show-branch --reflog='10,1 hour ago' --list master
+$ git show-branch --reflog="10,1 hour ago" --list master
 ------------
 
 shows 10 reflog entries going back from the tip as of 1 hour ago.
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index babaa9b..2f207fb 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -87,7 +87,7 @@ use by subsequent users cloning the superproject. If the URL is
 given relative to the superproject's repository, the presumption
 is the superproject and submodule repositories will be kept
 together in the same relative location, and only the
-superproject's URL need be provided: git-submodule will correctly
+superproject's URL needs to be provided: git-submodule will correctly
 locate the submodule using the relative URL in .gitmodules.
 
 status::
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 1d9d81a..25e0bbe 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -55,7 +55,7 @@ OPTIONS
         default behavior is to error out.  This option makes
 	'git-update-index' continue anyway.
 
---ignore-submodules:
+--ignore-submodules::
 	Do not try to update submodules.  This option is only respected
 	when passed before --refresh.
 
@@ -78,9 +78,9 @@ OPTIONS
 
 --assume-unchanged::
 --no-assume-unchanged::
-	When these flags are specified, the object name recorded
+	When these flags are specified, the object names recorded
 	for the paths are not updated.  Instead, these options
-	sets and unsets the "assume unchanged" bit for the
+	set and unset the "assume unchanged" bit for the
 	paths.  When the "assume unchanged" bit is on, git stops
 	checking the working tree files for possible
 	modifications, so you need to manually unset the bit to
@@ -122,7 +122,7 @@ you will need to handle the situation manually.
 	'git-update-index' refuses an attempt to add `path/file`.
 	Similarly if a file `path/file` exists, a file `path`
 	cannot be added.  With --replace flag, existing entries
-	that conflicts with the entry being added are
+	that conflict with the entry being added are
 	automatically removed with warning messages.
 
 --stdin::
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index 96bf353..da8fa44 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -999,8 +999,8 @@ Fast forward
  2 files changed, 2 insertions(+), 0 deletions(-)
 ----------------
 
-Because your branch did not contain anything more than what are
-already merged into the `master` branch, the merge operation did
+Because your branch did not contain anything more than what had
+already been merged into the `master` branch, the merge operation did
 not actually do a merge. Instead, it just updated the top of
 the tree of your branch to that of the `master` branch. This is
 often called 'fast forward' merge.
@@ -1353,7 +1353,7 @@ $ GIT_DIR=my-git.git git init
 ------------
 
 Make sure this directory is available for others you want your
-changes to be pulled by via the transport of your choice. Also
+changes to be pulled via the transport of your choice. Also
 you need to make sure that you have the 'git-receive-pack'
 program on the `$PATH`.
 
@@ -1512,7 +1512,7 @@ You can repack this private repository whenever you feel like.
 6. Push your changes to the public repository, and announce it
    to the public.
 
-7. Every once in a while, "git-repack" the public repository.
+7. Every once in a while, 'git-repack' the public repository.
    Go back to step 5. and continue working.
 
 
diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index 317f631..4673a75 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -21,7 +21,7 @@ git repository.
 
 OPTIONS
 -------
-To control which revisions to shown, the command takes options applicable to
+To control which revisions to show, the command takes options applicable to
 the 'git-rev-list' command (see linkgit:git-rev-list[1]).
 This manual page describes only the most
 frequently used options.
@@ -80,7 +80,7 @@ Examples
 --------
 gitk v2.6.12.. include/scsi drivers/scsi::
 
-	Show as the changes since version 'v2.6.12' that changed any
+	Show the changes since version 'v2.6.12' that changed any
 	file in the include/scsi or drivers/scsi subdirectories
 
 gitk --since="2 weeks ago" \-- gitk::
diff --git a/Documentation/i18n.txt b/Documentation/i18n.txt
index 2cdacd9..708da6c 100644
--- a/Documentation/i18n.txt
+++ b/Documentation/i18n.txt
@@ -7,11 +7,11 @@ At the core level, git is character encoding agnostic.
    to be what lstat(2) and creat(2) accepts.  There is no such
    thing as pathname encoding translation.
 
- - The contents of the blob objects are uninterpreted sequence
+ - The contents of the blob objects are uninterpreted sequences
    of bytes.  There is no encoding translation at the core
    level.
 
- - The commit log messages are uninterpreted sequence of non-NUL
+ - The commit log messages are uninterpreted sequences of non-NUL
    bytes.
 
 Although we encourage that the commit log messages are encoded
-- 
1.6.1.rc3.27.gf650d1
