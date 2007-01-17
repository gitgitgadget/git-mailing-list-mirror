From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] Documentation: a few spelling fixes
Date: Wed, 17 Jan 2007 16:32:41 +0100
Message-ID: <45AE4199.5090107@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 17 16:32:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7CmU-0001t6-FE
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 16:32:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbXAQPcw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 10:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbXAQPcw
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 10:32:52 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:39515
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932444AbXAQPcv (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Jan 2007 10:32:51 -0500
Received: from [10.0.1.3] (p508E4261.dip.t-dialin.net [80.142.66.97])
	by neapel230.server4you.de (Postfix) with ESMTP id 4F8912F025;
	Wed, 17 Jan 2007 16:32:49 +0100 (CET)
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37009>

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 95bea66..a5051aa 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -83,7 +83,7 @@ git-add git-*.sh::
 Interactive mode
 ----------------
 When the command enters the interactive mode, it shows the
-output of the 'status' subcommand, and then goes into ints
+output of the 'status' subcommand, and then goes into its
 interactive command loop.
 
 The command loop shows the list of subcommands available, and
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index bdfc666..b14e794 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -24,7 +24,7 @@ replaced; you need to use a tool such as gitlink:git-diff[1] or the "pickaxe"
 interface briefly mentioned in the following paragraph.
 
 Apart from supporting file annotation, git also supports searching the
-development history for when a code snippet occured in a change. This makes it
+development history for when a code snippet occurred in a change. This makes it
 possible to track when a code snippet was added to a file, moved or copied
 between files, and eventually deleted or replaced. It works by searching for
 a text string in the diff. A small example:
@@ -89,7 +89,7 @@ THE PORCELAIN FORMAT
 --------------------
 
 In this format, each line is output after a header; the
-header at the minumum has the first line which has:
+header at the minimum has the first line which has:
 
 - 40-byte SHA-1 of the commit the line is attributed to;
 - the line number of the line in the original file;
@@ -112,8 +112,8 @@ header, prefixed by a TAB. This is to allow adding more
 header elements later.
 
 
-SPECIFIYING RANGES
-------------------
+SPECIFYING RANGES
+-----------------
 
 Unlike `git-blame` and `git-annotate` in older git, the extent
 of annotation can be limited to both line ranges and revision
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index e872fc8..d5f8118 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -74,7 +74,7 @@ OPTIONS
 	List both remote-tracking branches and local branches.
 
 -v::
-	Show sha1 and commit subjectline for each head.
+	Show sha1 and commit subject line for each head.
 
 --abbrev=<length>::
 	Alter minimum display length for sha1 in output listing,
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 9c84353..bd1c22b 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -111,7 +111,7 @@ but can be used to amend a merge commit.
 	are concluding a conflicted merge.
 
 -q|--quiet::
-	Supress commit summary message.
+	Suppress commit summary message.
 
 \--::
 	Do not interpret any more arguments as options.
diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index 5c402de..4471394 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -97,7 +97,7 @@ If you need to pass multiple options, separate them with a comma.
 	Substitute the character "/" in branch names with <subst>
 
 -A <author-conv-file>::
-	CVS by default uses the unix username when writing its
+	CVS by default uses the Unix username when writing its
 	commit logs. Using this option and an author-conv-file
 	in this format
 
diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 2bf6aef..06e7ab1 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -15,7 +15,7 @@ DESCRIPTION
 Iterate over all refs that match `<pattern>` and show them
 according to the given `<format>`, after sorting them according
 to the given set of `<key>`.  If `<max>` is given, stop after
-showing that many refs.  The interporated values in `<format>`
+showing that many refs.  The interpolated values in `<format>`
 can optionally be quoted as string literals in the specified
 host language allowing their direct evaluation in that language.
 
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 73d78c1..2bcc949 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -35,7 +35,7 @@ can be set to indicate how long historical reflog entries which
 are not part of the current branch should remain available in
 this repository.  These types of entries are generally created as
 a result of using `git commit \--amend` or `git rebase` and are the
-commits prior to the amend or rebase occuring.  Since these changes
+commits prior to the amend or rebase occurring.  Since these changes
 are not part of the current project most users will want to expire
 them sooner.  This option defaults to '30 days'.
 
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index bfbece9..0140c8e 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -91,7 +91,7 @@ OPTIONS
 	combined by 'or'.
 
 --and | --or | --not | ( | )::
-	Specify how multiple patterns are combined using boolean
+	Specify how multiple patterns are combined using Boolean
 	expressions.  `--or` is the default operator.  `--and` has
 	higher precedence than `--or`.  `-e` has to be used for all
 	patterns.
diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index c8a4c5a..c254005 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -29,7 +29,7 @@ OPTIONS
 -u <exec>, --upload-pack=<exec>::
 	Specify the full path of gitlink:git-upload-pack[1] on the remote
 	host. This allows listing references from repositories accessed via
-	SSH and where the SSH deamon does not use the PATH configured by the
+	SSH and where the SSH daemon does not use the PATH configured by the
 	user. Also see the '--exec' option for gitlink:git-peek-remote[1].
 
 <repository>::
diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index 08a0557..c65c59e 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -38,7 +38,7 @@ its working state.
 
 This resets the metadata used by rerere if a merge resolution is to be
 is aborted.  Calling gitlink:git-am[1] --skip or gitlink:git-rebase[1]
-[--skip|--abort] will automatcally invoke this command.
+[--skip|--abort] will automatically invoke this command.
 
 'diff'::
 
diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index 95fa901..b0df92e 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -29,7 +29,7 @@ OPTIONS
 	of author alphabetic order.
 
 -s::
-	Supress commit description and provide a commit count summary only.
+	Suppress commit description and provide a commit count summary only.
 
 FILES
 -----
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 9ed7211..321083d 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -113,7 +113,7 @@ manually joining branches on commit.
 
 'commit-diff'::
 	Commits the diff of two tree-ish arguments from the
-	command-line.  This command is intended for interopability with
+	command-line.  This command is intended for interoperability with
 	git-svnimport and does not rely on being inside an git-svn
 	init-ed repository.  This command takes three arguments, (a) the
 	original tree to diff against, (b) the new tree result, (c) the
