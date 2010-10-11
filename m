From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/5] Documentation: gitrevisions is in section 7
Date: Mon, 11 Oct 2010 11:03:32 -0500
Message-ID: <20101011160332.GB25842@burratino>
References: <20101011150342.292ad725@chalon.bertin.fr>
 <AANLkTinqPiGf1nbo0oOvDD5edgLBdO8xZfjGeFC4q0MU@mail.gmail.com>
 <20101011161721.35940919@chalon.bertin.fr>
 <20101011160224.GA25842@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Santi =?utf-8?B?QsOpamFy?= <santi@agolina.net>, git@vger.kernel.org
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Mon Oct 11 18:07:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5Ktt-0003m9-Tw
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 18:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755223Ab0JKQGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Oct 2010 12:06:51 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:41293 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754964Ab0JKQGu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 12:06:50 -0400
Received: by qwf7 with SMTP id 7so1898903qwf.19
        for <git@vger.kernel.org>; Mon, 11 Oct 2010 09:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=6oTc3o9uZTpYlTO1zR839BEmDfAVbIETi3WCsDYwEhU=;
        b=t6t/J/h3hQ8XjoSMry8yPkDCJdvLUkguX6817HLRLbM85Bbhe6cqp8fOGh5UgzGym5
         LQwm12TRYb8kpTtD8gpuEGxQn4lG80UMpOJDgozugqvWq2EBNelcFvvAp0XnRY/ylgzS
         HUKIHEGurbLKNEkfUSbLxZa+K4uvdhIQ08daE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=p97rJLdh4/FiUT5GY2pyqu0gea8auj5HWRS6BovrSvjc69yGQpWMzndAO6vqW2qZPd
         Azkl0v9WOwBxEZH5JIhiDr9Z+Jzt6Amt2DlZhbPjv8tn/c1/ew2mJmhZrNNxo0FuKPVk
         8c/OGPZFIEGxXtZcDiCAID5uWmK17H8Qr5X2U=
Received: by 10.224.54.85 with SMTP id p21mr3572367qag.46.1286813208927;
        Mon, 11 Oct 2010 09:06:48 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id l13sm5894226qck.43.2010.10.11.09.06.47
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 11 Oct 2010 09:06:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101011160224.GA25842@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158771>

Fix references to gitrevisions(1) in the manual pages and HTML
documentation.

In practice, this will not matter much unless someone tries to use a
hard copy of the git reference manual.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-cat-file.txt         |    2 +-
 Documentation/git-check-ref-format.txt |    2 +-
 Documentation/git-cherry-pick.txt      |    2 +-
 Documentation/git-diff.txt             |    4 ++--
 Documentation/git-fast-import.txt      |    2 +-
 Documentation/git-format-patch.txt     |    2 +-
 Documentation/git-log.txt              |    2 +-
 Documentation/git-push.txt             |    2 +-
 Documentation/git-reflog.txt           |    2 +-
 Documentation/git-revert.txt           |    2 +-
 Documentation/git-show-branch.txt      |    2 +-
 Documentation/git-show.txt             |    2 +-
 Documentation/git.txt                  |    2 +-
 Documentation/gitcore-tutorial.txt     |    2 +-
 Documentation/gitk.txt                 |    2 +-
 Documentation/user-manual.txt          |    8 ++++----
 16 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index a3f56b0..544ba7b 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -27,7 +27,7 @@ OPTIONS
 <object>::
 	The name of the object to show.
 	For a more complete list of ways to spell object names, see
-	the "SPECIFYING REVISIONS" section in linkgit:gitrevisions[1].
+	the "SPECIFYING REVISIONS" section in linkgit:gitrevisions[7].
 
 -t::
 	Instead of the content, show the object type identified by
diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index f5c2e06..205d83d 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -49,7 +49,7 @@ git imposes the following rules on how references are named:
 These rules make it easy for shell script based tools to parse
 reference names, pathname expansion by the shell when a reference name is used
 unquoted (by mistake), and also avoids ambiguities in certain
-reference name expressions (see linkgit:gitrevisions[1]):
+reference name expressions (see linkgit:gitrevisions[7]):
 
 . A double-dot `..` is often used as in `ref1..ref2`, and in some
   contexts this notation means `{caret}ref1 ref2` (i.e. not in
diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 2cef579..3c96fa8 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -21,7 +21,7 @@ OPTIONS
 <commit>...::
 	Commits to cherry-pick.
 	For a more complete list of ways to spell commits, see
-	linkgit:gitrevisions[1].
+	linkgit:gitrevisions[7].
 	Sets of commits can be passed but no traversal is done by
 	default, as if the '--no-walk' option was specified, see
 	linkgit:git-rev-list[1].
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 08fd409..481a33c 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -68,11 +68,11 @@ for the last two forms that use ".." notations, can be any
 <tree-ish>.
 
 For a more complete list of ways to spell <commit>, see
-"SPECIFYING REVISIONS" section in linkgit:gitrevisions[1].
+"SPECIFYING REVISIONS" section in linkgit:gitrevisions[7].
 However, "diff" is about comparing two _endpoints_, not ranges,
 and the range notations ("<commit>..<commit>" and
 "<commit>\...<commit>") do not mean a range as defined in the
-"SPECIFYING RANGES" section in linkgit:gitrevisions[1].
+"SPECIFYING RANGES" section in linkgit:gitrevisions[7].
 
 OPTIONS
 -------
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 966ba4f..2c6ad5b 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -439,7 +439,7 @@ Marks must be declared (via `mark`) before they can be used.
 * A complete 40 byte or abbreviated commit SHA-1 in hex.
 
 * Any valid Git SHA-1 expression that resolves to a commit.  See
-  ``SPECIFYING REVISIONS'' in linkgit:gitrevisions[1] for details.
+  ``SPECIFYING REVISIONS'' in linkgit:gitrevisions[7] for details.
 
 The special case of restarting an incremental import from the
 current branch value should be written as:
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 4b3f5ba..a00b783 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -39,7 +39,7 @@ There are two ways to specify which commits to operate on.
    that leads to the <since> to be output.
 
 2. Generic <revision range> expression (see "SPECIFYING
-   REVISIONS" section in linkgit:gitrevisions[1]) means the
+   REVISIONS" section in linkgit:gitrevisions[7]) means the
    commits in the specified range.
 
 The first rule takes precedence in the case of a single <commit>.  To
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index c213bdb..6d40f00 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -31,7 +31,7 @@ OPTIONS
 	either <since> or <until> is omitted, it defaults to
 	`HEAD`, i.e. the tip of the current branch.
 	For a more complete list of ways to spell <since>
-	and <until>, see linkgit:gitrevisions[1].
+	and <until>, see linkgit:gitrevisions[7].
 
 --follow::
 	Continue listing the history of a file beyond renames
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 020955f..e11660a 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -41,7 +41,7 @@ OPTIONS[[OPTIONS]]
 +
 The <src> is often the name of the branch you would want to push, but
 it can be any arbitrary "SHA-1 expression", such as `master~4` or
-`HEAD` (see linkgit:gitrevisions[1]).
+`HEAD` (see linkgit:gitrevisions[7]).
 +
 The <dst> tells which ref on the remote side is updated with this
 push. Arbitrary expressions cannot be used here, an actual ref must
diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index 5a0451a..e50bd9b 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -40,7 +40,7 @@ see linkgit:git-log[1].
 The reflog is useful in various git commands, to specify the old value
 of a reference. For example, `HEAD@\{2\}` means "where HEAD used to be
 two moves ago", `master@\{one.week.ago\}` means "where master used to
-point to one week ago", and so on. See linkgit:gitrevisions[1] for
+point to one week ago", and so on. See linkgit:gitrevisions[7] for
 more details.
 
 To delete single entries from the reflog, use the subcommand "delete"
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index b7d9ef7..f40984d 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -31,7 +31,7 @@ OPTIONS
 <commit>...::
 	Commits to revert.
 	For a more complete list of ways to spell commit names, see
-	linkgit:gitrevisions[1].
+	linkgit:gitrevisions[7].
 	Sets of commits can also be given but no traversal is done by
 	default, see linkgit:git-rev-list[1] and its '--no-walk'
 	option.
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index 6453263..8dbcf1a 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -32,7 +32,7 @@ no <rev> nor <glob> is given on the command line.
 OPTIONS
 -------
 <rev>::
-	Arbitrary extended SHA1 expression (see linkgit:gitrevisions[1])
+	Arbitrary extended SHA1 expression (see linkgit:gitrevisions[7])
 	that typically names a branch head or a tag.
 
 <glob>::
diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index 0002bfb..2049c60 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -36,7 +36,7 @@ OPTIONS
 <object>...::
 	The names of objects to show.
 	For a more complete list of ways to spell object names, see
-	"SPECIFYING REVISIONS" section in linkgit:gitrevisions[1].
+	"SPECIFYING REVISIONS" section in linkgit:gitrevisions[7].
 
 include::pretty-options.txt[]
 
diff --git a/Documentation/git.txt b/Documentation/git.txt
index dd57bdc..b46c6f6 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -495,7 +495,7 @@ HEAD::
 	(i.e. the contents of `$GIT_DIR/refs/heads/<head>`).
 
 For a more complete list of ways to spell object names, see
-"SPECIFYING REVISIONS" section in linkgit:gitrevisions[1].
+"SPECIFYING REVISIONS" section in linkgit:gitrevisions[7].
 
 
 File/Directory Structure
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index 5e9c5eb..c27d086 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -971,7 +971,7 @@ commits from the master branch.  The string inside brackets
 before the commit log message is a short name you can use to
 name the commit.  In the above example, 'master' and 'mybranch'
 are branch heads.  'master^' is the first parent of 'master'
-branch head.  Please see linkgit:gitrevisions[1] if you want to
+branch head.  Please see linkgit:gitrevisions[7] if you want to
 see more complex cases.
 
 [NOTE]
diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index 05ac1c7..e21bac4 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -69,7 +69,7 @@ frequently used options.
 	the form "'<from>'..'<to>'" to show all revisions between '<from>' and
 	back to '<to>'. Note, more advanced revision selection can be applied.
 	For a more complete list of ways to spell object names, see
-	linkgit:gitrevisions[1].
+	linkgit:gitrevisions[7].
 
 <path>...::
 
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index ce45bfc..5b6de22 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -397,7 +397,7 @@ is usually a shortcut for the HEAD branch in the repository "origin".
 For the complete list of paths which git checks for references, and
 the order it uses to decide which to choose when there are multiple
 references with the same shorthand name, see the "SPECIFYING
-REVISIONS" section of linkgit:gitrevisions[1].
+REVISIONS" section of linkgit:gitrevisions[7].
 
 [[Updating-a-repository-With-git-fetch]]
 Updating a repository with git fetch
@@ -568,7 +568,7 @@ We have seen several ways of naming commits already:
 	- HEAD: refers to the head of the current branch
 
 There are many more; see the "SPECIFYING REVISIONS" section of the
-linkgit:gitrevisions[1] man page for the complete list of ways to
+linkgit:gitrevisions[7] man page for the complete list of ways to
 name revisions.  Some examples:
 
 -------------------------------------------------
@@ -909,7 +909,7 @@ commits reachable from some head but not from any tag in the repository:
 $ gitk $( git show-ref --heads ) --not  $( git show-ref --tags )
 -------------------------------------------------
 
-(See linkgit:gitrevisions[1] for explanations of commit-selecting
+(See linkgit:gitrevisions[7] for explanations of commit-selecting
 syntax such as `--not`.)
 
 [[making-a-release]]
@@ -1635,7 +1635,7 @@ you've checked out.
 The reflogs are kept by default for 30 days, after which they may be
 pruned.  See linkgit:git-reflog[1] and linkgit:git-gc[1] to learn
 how to control this pruning, and see the "SPECIFYING REVISIONS"
-section of linkgit:gitrevisions[1] for details.
+section of linkgit:gitrevisions[7] for details.
 
 Note that the reflog history is very different from normal git history.
 While normal history is shared by every repository that works on the
-- 
1.7.2.3
