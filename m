From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH v3 2/6] Change 'git' to 'Git' whenever the whole system is
 referred to #1
Date: Mon, 21 Jan 2013 20:17:53 +0100 (CET)
Message-ID: <1430594044.632790.1358795873467.JavaMail.ngmail@webmail20.arcor-online.net>
References: <884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net> <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net> <7vvcark1f2.fsf@alter.siamese.dyndns.org> <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: davvid@gmail.com, git@vger.kernel.org
To: gitster@pobox.com, th.acker@arcor.de
X-From: git-owner@vger.kernel.org Mon Jan 21 20:18:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxMsu-0004AG-J0
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 20:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753644Ab3AUTR4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 14:17:56 -0500
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:34445 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752666Ab3AUTRz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2013 14:17:55 -0500
Received: from mail-in-16-z2.arcor-online.net (mail-in-16-z2.arcor-online.net [151.189.8.33])
	by mx.arcor.de (Postfix) with ESMTP id 96CC55A08B;
	Mon, 21 Jan 2013 20:17:53 +0100 (CET)
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net [151.189.21.43])
	by mail-in-16-z2.arcor-online.net (Postfix) with ESMTP id 8B9AD3FEC2E;
	Mon, 21 Jan 2013 20:17:53 +0100 (CET)
Received: from webmail20.arcor-online.net (webmail20.arcor-online.net [151.189.8.201])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id 7C104D7F77;
	Mon, 21 Jan 2013 20:17:53 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-03.arcor-online.net 7C104D7F77
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1358795873; bh=u6SY74mXg6WTS35M/fRUOkJ0gvAhwPM+G+ABLYvQK0I=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=mmrDIJsfoqzmloJa3KmgJgXSgYiEIDs6swkwAgoxkpNUhQQnkyTFb6GyYaoLFggh+
	 ZFZdVZMx7AYoi00ZGnyGPsrULDsw1vxo60gX6D1YEr2TP6BYf8EAIWy68zOh7+079L
	 n0jtKXyfGtHMrQWwID7U2brFcgFLAYryam4KRJVY=
Received: from [188.105.98.86] by webmail20.arcor-online.net (151.189.8.201) with HTTP (Arcor Webmail); Mon, 21 Jan 2013 20:17:53 +0100 (CET)
In-Reply-To: <884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.105.98.86
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214147>


Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---

diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
index 51131d0..0142cd1 100644
--- a/Documentation/git-replace.txt
+++ b/Documentation/git-replace.txt
@@ -22,7 +22,7 @@ replacement object.
 
 Unless `-f` is given, the 'replace' reference must not yet exist.
 
-Replacement references will be used by default by all git commands
+Replacement references will be used by default by all Git commands
 except those doing reachability traversal (prune, pack transfer and
 fsck).
 
diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 38fafca..65ac27e 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -99,7 +99,7 @@ between the two operands.  The following two commands are equivalent:
 	$ git rev-list A...B
 -----------------------------------------------------------------------
 
-'rev-list' is a very essential git command, since it
+'rev-list' is a very essential Git command, since it
 provides the ability to build and traverse commit ancestry graphs. For
 this reason, it has a lot of different options that enables it to be
 used by commands as different as 'git bisect' and
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 3c63561..c743469 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-Many git porcelainish commands take mixture of flags
+Many Git porcelainish commands take mixture of flags
 (i.e. parameters that begin with a dash '-') and parameters
 meant for the underlying 'git rev-list' command they use internally
 and flags and parameters for the other commands they use
@@ -147,7 +147,7 @@ shown.  If the pattern does not contain a globbing character (`?`,
 	relative to the current working directory.
 +
 If `$GIT_DIR` is not defined and the current directory
-is not detected to lie in a git repository or work tree
+is not detected to lie in a Git repository or work tree
 print a message to stderr and exit with nonzero status.
 
 --is-inside-git-dir::
diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index 262436b..1e5ef3b 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -28,7 +28,7 @@ OPTIONS
 -------
 <file>...::
 	Files to remove.  Fileglobs (e.g. `*.c`) can be given to
-	remove all matching files.  If you want git to expand
+	remove all matching files.  If you want Git to expand
 	file glob characters, you may need to shell-escape them.
 	A leading directory name
 	(e.g. `dir` to remove `dir/file1` and `dir/file2`) can be
@@ -74,7 +74,7 @@ DISCUSSION
 
 The <file> list given to the command can be exact pathnames,
 file glob patterns, or leading directory names.  The command
-removes only the paths that are known to git.  Giving the name of
+removes only the paths that are known to Git.  Giving the name of
 a file that you have not told git about does not remove that file.
 
 File globbing matches across directory boundaries.  Thus, given
@@ -137,7 +137,7 @@ git diff --name-only --diff-filter=D -z | xargs -0 git rm --cached
 Submodules
 ~~~~~~~~~~
 Only submodules using a gitfile (which means they were cloned
-with a git version 1.7.8 or newer) will be removed from the work
+with a Git version 1.7.8 or newer) will be removed from the work
 tree, as their repository lives inside the .git directory of the
 superproject. If a submodule (or one of those nested inside it)
 still uses a .git directory, `git rm` will fail - no matter if forced
@@ -156,7 +156,7 @@ EXAMPLES
 	`Documentation` directory and any of its subdirectories.
 +
 Note that the asterisk `*` is quoted from the shell in this
-example; this lets git, and not the shell, expand the pathnames
+example; this lets Git, and not the shell, expand the pathnames
 of files and subdirectories under the `Documentation/` directory.
 
 `git rm -f git-*.sh`::
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index da067ec..aca8405 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -179,7 +179,7 @@ parameter can be any valid commit-ish.
 In case of conflict, 'git rebase' will stop at the first problematic commit
 and leave conflict markers in the tree.  You can use 'git diff' to locate
 the markers (<<<<<<) and make edits to resolve the conflict.  For each
-file you edit, you need to tell git that the conflict has been resolved,
+file you edit, you need to tell Git that the conflict has been resolved,
 typically this would be done with
 
 
diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index 7fe2d22..fb8697e 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -38,7 +38,7 @@ The reflog will cover all recent actions (HEAD reflog records branch switching
 as well).  It is an alias for `git log -g --abbrev-commit --pretty=oneline`;
 see linkgit:git-log[1].
 
-The reflog is useful in various git commands, to specify the old value
+The reflog is useful in various Git commands, to specify the old value
 of a reference. For example, `HEAD@{2}` means "where HEAD used to be
 two moves ago", `master@{one.week.ago}` means "where master used to
 point to one week ago", and so on. See linkgit:gitrevisions[7] for
diff --git a/Documentation/git-remote-ext.txt b/Documentation/git-remote-ext.txt
index 8a8e1d7..58b7fac 100644
--- a/Documentation/git-remote-ext.txt
+++ b/Documentation/git-remote-ext.txt
@@ -13,7 +13,7 @@ git remote add <nick> "ext::<command>[ <arguments>...]"
 DESCRIPTION
 -----------
 This remote helper uses the specified '<command>' to connect
-to a remote git server.
+to a remote Git server.
 
 Data written to stdin of the specified '<command>' is assumed
 to be sent to a git:// server, git-upload-pack, git-receive-pack
@@ -33,12 +33,12 @@ The following sequences have a special meaning:
 
 '%s'::
 	Replaced with name (receive-pack, upload-pack, or
-	upload-archive) of the service git wants to invoke.
+	upload-archive) of the service Git wants to invoke.
 
 '%S'::
 	Replaced with long name (git-receive-pack,
 	git-upload-pack, or git-upload-archive) of the service
-	git wants to invoke.
+	Git wants to invoke.
 
 '%G' (must be the first characters in an argument)::
 	This argument will not be passed to '<command>'. Instead, it
@@ -75,7 +75,7 @@ GIT_EXT_SERVICE_NOPREFIX::
 
 EXAMPLES:
 ---------
-This remote helper is transparently used by git when
+This remote helper is transparently used by Git when
 you use commands such as "git fetch <URL>", "git clone <URL>",
 , "git push <URL>" or "git remote add <nick> <URL>", where <URL>
 begins with `ext::`.  Examples:
@@ -100,14 +100,14 @@ begins with `ext::`.  Examples:
 	Represents a repository with path /repo accessed using the
 	helper program "git-server-alias foo".  The hostname for the
 	remote server passed in the protocol stream will be "foo"
-	(this allows multiple virtual git servers to share a
+	(this allows multiple virtual Git servers to share a
 	link-level address).
 
 "ext::git-server-alias foo %G/repo% with% spaces %Vfoo"::
 	Represents a repository with path '/repo with spaces' accessed
 	using the helper program "git-server-alias foo".  The hostname for
 	the remote server passed in the protocol stream will be "foo"
-	(this allows multiple virtual git servers to share a
+	(this allows multiple virtual Git servers to share a
 	link-level address).
 
 "ext::git-ssl foo.example /bar"::
@@ -118,7 +118,7 @@ begins with `ext::`.  Examples:
 
 Documentation
 --------------
-Documentation by Ilari Liusvaara, Jonathan Nieder and the git list
+Documentation by Ilari Liusvaara, Jonathan Nieder and the Git list
 <git@vger.kernel.org>
 
 GIT
diff --git a/Documentation/git-remote-fd.txt b/Documentation/git-remote-fd.txt
index f095d57..9bfe12c 100644
--- a/Documentation/git-remote-fd.txt
+++ b/Documentation/git-remote-fd.txt
@@ -11,14 +11,14 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-This helper uses specified file descriptors to connect to a remote git server.
-This is not meant for end users but for programs and scripts calling git
+This helper uses specified file descriptors to connect to a remote Git server.
+This is not meant for end users but for programs and scripts calling Git
 fetch, push or archive.
 
 If only <infd> is given, it is assumed to be a bidirectional socket connected
-to remote git server (git-upload-pack, git-receive-pack or
+to remote Git server (git-upload-pack, git-receive-pack or
 git-upload-achive). If both <infd> and <outfd> are given, they are assumed
-to be pipes connected to a remote git server (<infd> being the inbound pipe
+to be pipes connected to a remote Git server (<infd> being the inbound pipe
 and <outfd> being the outbound pipe.
 
 It is assumed that any handshaking procedures have already been completed
@@ -52,7 +52,7 @@ EXAMPLES
 
 Documentation
 --------------
-Documentation by Ilari Liusvaara and the git list <git@vger.kernel.org>
+Documentation by Ilari Liusvaara and the Git list <git@vger.kernel.org>
 
 GIT
 ---
diff --git a/Documentation/Makefile b/Documentation/Makefile
index 971977b..a7a4f75 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -347,7 +347,7 @@ install-webdoc : html
 	'$(SHELL_PATH_SQ)' ./install-webdoc.sh $(WEBDOC_DEST)
 
 # You must have a clone of git-htmldocs and git-manpages repositories
-# next to the git repository itself for the following to work.
+# next to the Git repository itself for the following to work.
 
 quick-install: quick-install-man
 
diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 90133d8..d0a4733 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -103,9 +103,9 @@ without external resources. Instead of giving a URL to a mailing list
 archive, summarize the relevant points of the discussion.
 
 
-(3) Generate your patch using git tools out of your commits.
+(3) Generate your patch using Git tools out of your commits.
 
-git based diff tools generate unidiff which is the preferred format.
+Git based diff tools generate unidiff which is the preferred format.
 
 You do not have to be afraid to use -M option to "git diff" or
 "git format-patch", if your patch involves file renames.  The
@@ -122,7 +122,7 @@ that is fine, but please mark it as such.
 
 (4) Sending your patches.
 
-People on the git mailing list need to be able to read and
+People on the Git mailing list need to be able to read and
 comment on the changes you are submitting.  It is important for
 a developer to be able to "quote" your changes, using standard
 e-mail tools, so that they may comment on specific portions of
@@ -206,7 +206,7 @@ patch.
 
 To improve tracking of who did what, we've borrowed the
 "sign-off" procedure from the Linux kernel project on patches
-that are being emailed around.  Although core GIT is a lot
+that are being emailed around.  Although core Git is a lot
 smaller project it is a good discipline to follow it.
 
 The sign-off is a simple line at the end of the explanation for
@@ -244,7 +244,7 @@ then you just add a line saying
 
 	Signed-off-by: Random J Developer <random@developer.example.org>
 
-This line can be automatically added by git if you run the git-commit
+This line can be automatically added by Git if you run the git-commit
 command with the -s option.
 
 Notice that you can place your own Signed-off-by: line when
@@ -337,7 +337,7 @@ Know the status of your patch after submission
   tell you if your patch is merged in pu if you rebase on top of
   master).
 
-* Read the git mailing list, the maintainer regularly posts messages
+* Read the Git mailing list, the maintainer regularly posts messages
   entitled "What's cooking in git.git" and "What's in git.git" giving
   the status of various proposed changes.
 
diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index d4a51da..b0d31df 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -95,7 +95,7 @@ of lines before or after the line given by <start>.
 	running extra passes of inspection.
 +
 <num> is optional but it is the lower bound on the number of
-alphanumeric characters that git must detect as moving/copying
+alphanumeric characters that Git must detect as moving/copying
 within a file for it to associate those lines with the parent
 commit. The default value is 20.
 
@@ -110,7 +110,7 @@ commit. The default value is 20.
 	looks for copies from other files in any commit.
 +
 <num> is optional but it is the lower bound on the number of
-alphanumeric characters that git must detect as moving/copying
+alphanumeric characters that Git must detect as moving/copying
 between files for it to associate those lines with the parent
 commit. And the default value is 40. If there are more than one
 `-C` options given, the <num> argument of the last `-C` will
diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index 4314ad0..6d06aa4 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -99,7 +99,7 @@ diff.renameLimit::
 	detection; equivalent to the 'git diff' option '-l'.
 
 diff.renames::
-	Tells git to detect renames.  If set to any boolean value, it
+	Tells Git to detect renames.  If set to any boolean value, it
 	will enable basic rename detection.  If set to "copies" or
 	"copy", it will detect copies, as well.
 
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 39f2c50..7a87473 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -283,7 +283,7 @@ few lines that happen to match textually as the context, but as a
 single deletion of everything old followed by a single insertion of
 everything new, and the number `m` controls this aspect of the -B
 option (defaults to 60%). `-B/70%` specifies that less than 30% of the
-original should remain in the result for git to consider it a total
+original should remain in the result for Git to consider it a total
 rewrite (i.e. otherwise the resulting patch will be a series of
 deletion and insertion mixed together with context lines).
 +
@@ -307,7 +307,7 @@ ifdef::git-log[]
 endif::git-log[]
 	If `n` is specified, it is a threshold on the similarity
 	index (i.e. amount of addition/deletions compared to the
-	file's size). For example, `-M90%` means git should consider a
+	file's size). For example, `-M90%` means Git should consider a
 	delete/add pair to be a rename if more than 90% of the file
 	hasn't changed.  Without a `%` sign, the number is to be read as
 	a fraction, with a decimal point before it.  I.e., `-M5` becomes
diff --git a/Documentation/everyday.txt b/Documentation/everyday.txt
index 6acfd33..e1fba85 100644
--- a/Documentation/everyday.txt
+++ b/Documentation/everyday.txt
@@ -12,7 +12,7 @@ commands in addition to the above.
 
 <<Repository Administration>> commands are for system
 administrators who are responsible for the care and feeding
-of git repositories.
+of Git repositories.
 
 
 Individual Developer (Standalone)[[Individual Developer (Standalone)]]
@@ -87,7 +87,7 @@ $ git log v2.43.. curses/ <12>
 +
 <1> create a new topic branch.
 <2> revert your botched changes in `curses/ux_audio_oss.c`.
-<3> you need to tell git if you added a new file; removal and
+<3> you need to tell Git if you added a new file; removal and
 modification will be caught if you do `git commit -a` later.
 <4> to see what changes you are committing.
 <5> commit everything as you have tested, with your sign-off.
@@ -332,7 +332,7 @@ Run git-daemon to serve /pub/scm from xinetd.::
 ------------
 $ cat /etc/xinetd.d/git-daemon
 # default: off
-# description: The git server offers access to git repositories
+# description: The Git server offers access to Git repositories
 service git
 {
         disable = no
diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 634b84e..c1704dc 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -24,7 +24,7 @@ Reads the supplied diff output (i.e. "a patch") and applies it to files.
 With the `--index` option the patch is also applied to the index, and
 with the `--cached` option the patch is only applied to the index.
 Without these options, the command applies the patch only to files,
-and does not require them to be in a git repository.
+and does not require them to be in a Git repository.
 
 This command applies the patch but does not create a commit.  Use
 linkgit:git-am[1] to create commits from patches generated by
diff --git a/Documentation/git-archimport.txt b/Documentation/git-archimport.txt
index f4504ba..25b1cab 100644
--- a/Documentation/git-archimport.txt
+++ b/Documentation/git-archimport.txt
@@ -40,13 +40,13 @@ directory. To follow the development of a project that uses Arch, rerun
 incremental imports.
 
 While 'git archimport' will try to create sensible branch names for the
-archives that it imports, it is also possible to specify git branch names
-manually.  To do so, write a git branch name after each <archive/branch>
+archives that it imports, it is also possible to specify Git branch names
+manually.  To do so, write a Git branch name after each <archive/branch>
 parameter, separated by a colon.  This way, you can shorten the Arch
-branch names and convert Arch jargon to git jargon, for example mapping a
+branch names and convert Arch jargon to Git jargon, for example mapping a
 "PROJECT{litdd}devo{litdd}VERSION" branch to "master".
 
-Associating multiple Arch branches to one git branch is possible; the
+Associating multiple Arch branches to one Git branch is possible; the
 result will make the most sense only if no commits are made to the first
 branch, after the second branch is created.  Still, this is useful to
 convert Arch repositories that had been rotated periodically.
@@ -54,14 +54,14 @@ convert Arch repositories that had been rotated periodically.
 
 MERGES
 ------
-Patch merge data from Arch is used to mark merges in git as well. git
+Patch merge data from Arch is used to mark merges in Git as well. Git
 does not care much about tracking patches, and only considers a merge when a
 branch incorporates all the commits since the point they forked. The end result
-is that git will have a good idea of how far branches have diverged. So the
+is that Git will have a good idea of how far branches have diverged. So the
 import process does lose some patch-trading metadata.
 
 Fortunately, when you try and merge branches imported from Arch,
-git will find a good merge base, and it has a good chance of identifying
+Git will find a good merge base, and it has a good chance of identifying
 patches that have been traded out-of-sequence between the branches.
 
 OPTIONS
diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 59d73e5..b4c2e24 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -128,7 +128,7 @@ export-ignore::
 	added to archive files.  See linkgit:gitattributes[5] for details.
 
 export-subst::
-	If the attribute export-subst is set for a file then git will
+	If the attribute export-subst is set for a file then Git will
 	expand several placeholders when adding this file to an archive.
 	See linkgit:gitattributes[5] for details.
 
diff --git a/Documentation/git-bisect-lk2009.txt b/Documentation/git-bisect-lk2009.txt
index ec4497e..0eed3e3 100644
--- a/Documentation/git-bisect-lk2009.txt
+++ b/Documentation/git-bisect-lk2009.txt
@@ -224,7 +224,7 @@ Note that the example that we will use is really a toy example, we
 will be looking for the first commit that has a version like
 "2.6.26-something", that is the commit that has a "SUBLEVEL = 26" line
 in the top level Makefile. This is a toy example because there are
-better ways to find this commit with git than using "git bisect" (for
+better ways to find this commit with Git than using "git bisect" (for
 example "git blame" or "git log -S<string>").
 
 Driving a bisection manually
@@ -455,7 +455,7 @@ So only the W and B commits will be kept. Because commits X and Y will
 have been removed by rules a) and b) respectively, and because commits
 G are removed by rule b) too.
 
-Note for git users, that it is equivalent as keeping only the commit
+Note for Git users, that it is equivalent as keeping only the commit
 given by:
 
 -------------
@@ -710,8 +710,8 @@ Skip algorithm discussed
 After step 7) (in the skip algorithm), we could check if the second
 commit has been skipped and return it if it is not the case. And in
 fact that was the algorithm we used from when "git bisect skip" was
-developed in git version 1.5.4 (released on February 1st 2008) until
-git version 1.6.4 (released July 29th 2009).
+developed in Git version 1.5.4 (released on February 1st 2008) until
+Git version 1.6.4 (released July 29th 2009).
 
 But Ingo Molnar and H. Peter Anvin (another well known linux kernel
 developer) both complained that sometimes the best bisection points
@@ -1025,10 +1025,10 @@ And here is what Andreas said about this work-flow <<5>>:
 _____________
 To give some hard figures, we used to have an average report-to-fix
 cycle of 142.6 hours (according to our somewhat weird bug-tracker
-which just measures wall-clock time). Since we moved to git, we've
+which just measures wall-clock time). Since we moved to Git, we've
 lowered that to 16.2 hours. Primarily because we can stay on top of
 the bug fixing now, and because everyone's jockeying to get to fix
-bugs (we're quite proud of how lazy we are to let git find the bugs
+bugs (we're quite proud of how lazy we are to let Git find the bugs
 for us). Each new release results in ~40% fewer bugs (almost certainly
 due to how we now feel about writing tests).
 _____________
@@ -1228,9 +1228,9 @@ commits in already released history, for example to change the commit
 message or the author. And it can also be used instead of git "grafts"
 to link a repository with another old repository.
 
-In fact it's this last feature that "sold" it to the git community, so
-it is now in the "master" branch of git's git repository and it should
-be released in git 1.6.5 in October or November 2009.
+In fact it's this last feature that "sold" it to the Git community, so
+it is now in the "master" branch of Git's Git repository and it should
+be released in Git 1.6.5 in October or November 2009.
 
 One problem with "git replace" is that currently it stores all the
 replacements refs in "refs/replace/", but it would be perhaps better
@@ -1324,7 +1324,7 @@ Acknowledgements
 ----------------
 
 Many thanks to Junio Hamano for his help in reviewing this paper, for
-reviewing the patches I sent to the git mailing list, for discussing
+reviewing the patches I sent to the Git mailing list, for discussing
 some ideas and helping me improve them, for improving "git bisect" a
 lot and for his awesome work in maintaining and developing Git.
 
@@ -1337,7 +1337,7 @@ Many thanks to Linus Torvalds for inventing, developing and
 evangelizing "git bisect", Git and Linux.
 
 Many thanks to the many other great people who helped one way or
-another when I worked on git, especially to Andreas Ericsson, Johannes
+another when I worked on Git, especially to Andreas Ericsson, Johannes
 Schindelin, H. Peter Anvin, Daniel Barkalow, Bill Lear, John Hawley,
 Shawn O. Pierce, Jeff King, Sam Vilain, Jon Seymour.
 
diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index e4f46bc..b4831bb 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -169,14 +169,14 @@ the revision as good or bad in the usual manner.
 Bisect skip
 ~~~~~~~~~~~~
 
-Instead of choosing by yourself a nearby commit, you can ask git
+Instead of choosing by yourself a nearby commit, you can ask Git
 to do it for you by issuing the command:
 
 ------------
 $ git bisect skip                 # Current version cannot be tested
 ------------
 
-But git may eventually be unable to tell the first bad commit among
+But Git may eventually be unable to tell the first bad commit among
 a bad commit and one or more skipped commits.
 
 You can even skip a range of commits, instead of just one commit,
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index e44173f..9a05c2b 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -30,7 +30,7 @@ The report does not tell you anything about lines which have been deleted or
 replaced; you need to use a tool such as 'git diff' or the "pickaxe"
 interface briefly mentioned in the following paragraph.
 
-Apart from supporting file annotation, git also supports searching the
+Apart from supporting file annotation, Git also supports searching the
 development history for when a code snippet occurred in a change. This makes it
 possible to track when a code snippet was added to a file, moved or copied
 between files, and eventually deleted or replaced. It works by searching for
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 45a225e..d4a9be2 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -45,7 +45,7 @@ Note that this will create the new branch, but it will not switch the
 working tree to it; use "git checkout <newbranch>" to switch to the
 new branch.
 
-When a local branch is started off a remote-tracking branch, git sets up the
+When a local branch is started off a remote-tracking branch, Git sets up the
 branch so that 'git pull' will appropriately merge from
 the remote-tracking branch. This behavior may be changed via the global
 `branch.autosetupmerge` configuration flag. That setting can be
diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index bc023cc..0417562 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -19,7 +19,7 @@ DESCRIPTION
 
 Some workflows require that one or more branches of development on one
 machine be replicated on another machine, but the two machines cannot
-be directly connected, and therefore the interactive git protocols (git,
+be directly connected, and therefore the interactive Git protocols (git,
 ssh, rsync, http) cannot be used.  This command provides support for
 'git fetch' and 'git pull' to operate by packaging objects and references
 in an archive at the originating machine, then importing those into
diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index 98009d1..ec1739a 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -18,14 +18,14 @@ DESCRIPTION
 Checks if a given 'refname' is acceptable, and exits with a non-zero
 status if it is not.
 
-A reference is used in git to specify branches and tags.  A
+A reference is used in Git to specify branches and tags.  A
 branch head is stored in the `refs/heads` hierarchy, while
 a tag is stored in the `refs/tags` hierarchy of the ref namespace
 (typically in `$GIT_DIR/refs/heads` and `$GIT_DIR/refs/tags`
 directories or, as entries in file `$GIT_DIR/packed-refs`
 if refs are packed by `git gc`).
 
-git imposes the following rules on how references are named:
+Git imposes the following rules on how references are named:
 
 . They can include slash `/` for hierarchical (directory)
   grouping, but no slash-separated component can begin with a
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 6f04d22..8edcdca 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -333,7 +333,7 @@ a---b---c---d  branch 'master' (refers to commit 'd')
   tag 'v2.0' (refers to commit 'b')
 ------------
 
-In fact, we can perform all the normal git operations. But, let's look
+In fact, we can perform all the normal Git operations. But, let's look
 at what happens when we then checkout master:
 
 ------------
@@ -350,7 +350,7 @@ a---b---c---d  branch 'master' (refers to commit 'd')
 
 It is important to realize that at this point nothing refers to commit
 'f'. Eventually commit 'f' (and by extension commit 'e') will be deleted
-by the routine git garbage collection process, unless we create a reference
+by the routine Git garbage collection process, unless we create a reference
 before that happens. If we have not yet moved away from commit 'f',
 any of these will create a reference to it:
 
diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 9f42c0d..14bdbbb 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -16,7 +16,7 @@ DESCRIPTION
 Cleans the working tree by recursively removing files that are not
 under version control, starting from the current directory.
 
-Normally, only files unknown to git are removed, but if the '-x'
+Normally, only files unknown to Git are removed, but if the '-x'
 option is specified, ignored files are also removed. This can, for
 example, be useful to remove all build products.
 
@@ -33,7 +33,7 @@ OPTIONS
 
 -f::
 --force::
-	If the git configuration variable clean.requireForce is not set
+	If the Git configuration variable clean.requireForce is not set
 	to false, 'git clean' will refuse to run unless given -f or -n.
 
 -n::
@@ -60,7 +60,7 @@ OPTIONS
 	working directory to test a clean build.
 
 -X::
-	Remove only files ignored by git.  This may be useful to rebuild
+	Remove only files ignored by Git.  This may be useful to rebuild
 	everything from scratch, but keep manually created files.
 
 SEE ALSO
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 597048b..47d9880 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -43,7 +43,7 @@ OPTIONS
 --local::
 -l::
 	When the repository to clone from is on a local machine,
-	this flag bypasses the normal "git aware" transport
+	this flag bypasses the normal "Git aware" transport
 	mechanism and clones the repository by making a copy of
 	HEAD and everything under objects and refs directories.
 	The files under `.git/objects/` directory are hardlinked
@@ -54,11 +54,11 @@ this is the default, and --local is essentially a no-op.  If the
 repository is specified as a URL, then this flag is ignored (and we
 never use the local optimizations).  Specifying `--no-local` will
 override the default when `/path/to/repo` is given, using the regular
-git transport instead.
+Git transport instead.
 +
 To force copying instead of hardlinking (which may be desirable if you
 are trying to make a back-up of your repository), but still avoid the
-usual "git aware" transport mechanism, `--no-hardlinks` can be used.
+usual "Git aware" transport mechanism, `--no-hardlinks` can be used.
 
 --no-hardlinks::
 	Optimize the cloning process from a repository on a
@@ -76,9 +76,9 @@ usual "git aware" transport mechanism, `--no-hardlinks` can be used.
 *NOTE*: this is a possibly dangerous operation; do *not* use
 it unless you understand what it does. If you clone your
 repository using this option and then delete branches (or use any
-other git command that makes any existing commit unreferenced) in the
+other Git command that makes any existing commit unreferenced) in the
 source repository, some objects may become unreferenced (or dangling).
-These objects may be removed by normal git operations (such as `git commit`)
+These objects may be removed by normal Git operations (such as `git commit`)
 which automatically call `git gc --auto`. (See linkgit:git-gc[1].)
 If these objects are removed and were referenced by the cloned repository,
 then the cloned repository will become corrupt.
@@ -214,7 +214,7 @@ objects from the source repository into a pack in the cloned repository.
 	Instead of placing the cloned repository where it is supposed
 	to be, place the cloned repository at the specified directory,
 	then make a filesytem-agnostic git symbolic link to there.
-	The result is git repository can be separated from working
+	The result is Git repository can be separated from working
 	tree.
 
 
diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index a221169..86ef56e 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -30,7 +30,7 @@ While a tree represents a particular directory state of a working
 directory, a commit represents that state in "time", and explains how
 to get there.
 
-Normally a commit would identify a new "HEAD" state, and while git
+Normally a commit would identify a new "HEAD" state, and while Git
 doesn't care where you save the note about that state, in practice we
 tend to just write the result to the file that is pointed at by
 `.git/HEAD`, so that we can always see what the last committed
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 41b27da..0eb79cc 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -32,7 +32,7 @@ The content to be added can be specified in several ways:
 3. by listing files as arguments to the 'commit' command, in which
    case the commit will ignore changes staged in the index, and instead
    record the current content of the listed files (which must already
-   be known to git);
+   be known to Git);
 
 4. by using the -a switch with the 'commit' command to automatically
    "add" changes from all known files (i.e. all files that are already
@@ -59,7 +59,7 @@ OPTIONS
 --all::
 	Tell the command to automatically stage files that have
 	been modified and deleted, but new files you have not
-	told git about are not affected.
+	told Git about are not affected.
 
 -p::
 --patch::
@@ -404,7 +404,7 @@ Though not required, it's a good idea to begin the commit message
 with a single short (less than 50 character) line summarizing the
 change, followed by a blank line and then a more thorough description.
 The text up to the first blank line in a commit message is treated
-as the commit title, and that title is used throughout git.
+as the commit title, and that title is used throughout Git.
 For example, linkgit:git-format-patch[1] turns a commit into email, and it uses
 the title on the Subject line and the rest of the commit in the body.
 
diff --git a/Documentation/git-credential-cache.txt b/Documentation/git-credential-cache.txt
index eeff5fa..89b7306 100644
--- a/Documentation/git-credential-cache.txt
+++ b/Documentation/git-credential-cache.txt
@@ -14,13 +14,13 @@ git config credential.helper 'cache [options]'
 DESCRIPTION
 -----------
 
-This command caches credentials in memory for use by future git
+This command caches credentials in memory for use by future Git
 programs. The stored credentials never touch the disk, and are forgotten
 after a configurable timeout.  The cache is accessible over a Unix
 domain socket, restricted to the current user by filesystem permissions.
 
 You probably don't want to invoke this command directly; it is meant to
-be used as a credential helper by other parts of git. See
+be used as a credential helper by other parts of Git. See
 linkgit:gitcredentials[7] or `EXAMPLES` below.
 
 OPTIONS
diff --git a/Documentation/git-credential-store.txt b/Documentation/git-credential-store.txt
index b27c03c..8481cae 100644
--- a/Documentation/git-credential-store.txt
+++ b/Documentation/git-credential-store.txt
@@ -20,7 +20,7 @@ security tradeoff, try linkgit:git-credential-cache[1], or find a helper
 that integrates with secure storage provided by your operating system.
 
 This command stores credentials indefinitely on disk for use by future
-git programs.
+Git programs.
 
 You probably don't want to invoke this command directly; it is meant to
 be used as a credential helper by other parts of git. See
@@ -63,11 +63,11 @@ stored on its own line as a URL like:
 https://user:pass@example.com
 ------------------------------
 
-When git needs authentication for a particular URL context,
+When Git needs authentication for a particular URL context,
 credential-store will consider that context a pattern to match against
 each entry in the credentials file.  If the protocol, hostname, and
 username (if we already have one) match, then the password is returned
-to git. See the discussion of configuration in linkgit:gitcredentials[7]
+to Git. See the discussion of configuration in linkgit:gitcredentials[7]
 for more information.
 
 GIT
diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index 810e957..472f00f 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -18,9 +18,9 @@ Git has an internal interface for storing and retrieving credentials
 from system-specific helpers, as well as prompting the user for
 usernames and passwords. The git-credential command exposes this
 interface to scripts which may want to retrieve, store, or prompt for
-credentials in the same manner as git. The design of this scriptable
+credentials in the same manner as Git. The design of this scriptable
 interface models the internal C API; see
-link:technical/api-credentials.txt[the git credential API] for more
+link:technical/api-credentials.txt[the Git credential API] for more
 background on the concepts.
 
 git-credential takes an "action" option on the command-line (one of
@@ -74,7 +74,7 @@ infomation it has):
 	password=secr3t
 +
 In most cases, this means the attributes given in the input will be
-repeated in the output, but git may also modify the credential
+repeated in the output, but Git may also modify the credential
 description, for example by removing the `path` attribute when the
 protocol is HTTP(s) and `credential.useHttpPath` is false.
 +
diff --git a/Documentation/git-cvsexportcommit.txt b/Documentation/git-cvsexportcommit.txt
index a671e22..00154b6 100644
--- a/Documentation/git-cvsexportcommit.txt
+++ b/Documentation/git-cvsexportcommit.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 Exports a commit from Git to a CVS checkout, making it easier
-to merge patches from a git repository into a CVS repository.
+to merge patches from a Git repository into a CVS repository.
 
 Specify the name of a CVS checkout using the -w switch or execute it
 from the root of the CVS working copy. In the latter case GIT_DIR must
@@ -71,7 +71,7 @@ OPTIONS
 -w::
 	Specify the location of the CVS checkout to use for the export. This
 	option does not require GIT_DIR to be set before execution if the
-	current directory is within a git repository.  The default is the
+	current directory is within a Git repository.  The default is the
 	value of 'cvsexportcommit.cvsdir'.
 
 -W::
diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index 9d5353e..1d0baa3 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -18,7 +18,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Imports a CVS repository into git. It will either create a new
+Imports a CVS repository into Git. It will either create a new
 repository, or incrementally import into an existing one.
 
 Splitting the CVS log into patch sets is done by 'cvsps'.
@@ -59,18 +59,18 @@ OPTIONS
 	`CVS/Repository`.
 
 -C <target-dir>::
-        The git repository to import to.  If the directory doesn't
+        The Git repository to import to.  If the directory doesn't
         exist, it will be created.  Default is the current directory.
 
 -r <remote>::
-	The git remote to import this CVS repository into.
+	The Git remote to import this CVS repository into.
 	Moves all CVS branches into remotes/<remote>/<branch>
 	akin to the way 'git clone' uses 'origin' by default.
 
 -o <branch-for-HEAD>::
 	When no remote is specified (via -r) the 'HEAD' branch
-	from CVS is imported to the 'origin' branch within the git
-	repository, as 'HEAD' already has a special meaning for git.
+	from CVS is imported to the 'origin' branch within the Git
+	repository, as 'HEAD' already has a special meaning for Git.
 	When a remote is specified the 'HEAD' branch is named
 	remotes/<remote>/master mirroring 'git clone' behaviour.
 	Use this option if you want to import into a different
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 36d069b..dc5069f 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -60,7 +60,7 @@ unless '--export-all' was given, too.
 DESCRIPTION
 -----------
 
-This application is a CVS emulation layer for git.
+This application is a CVS emulation layer for Git.
 
 It is highly functional. However, not all methods are implemented,
 and for those methods that are implemented,
@@ -160,9 +160,9 @@ with CVS_SERVER (and shouldn't) as 'git-shell' understands `cvs` to mean
 Note: you need to ensure each user that is going to invoke 'git-cvsserver' has
 write access to the log file and to the database (see
 <<dbbackend,Database Backend>>. If you want to offer write access over
-SSH, the users of course also need write access to the git repository itself.
+SSH, the users of course also need write access to the Git repository itself.
 
-You also need to ensure that each repository is "bare" (without a git index
+You also need to ensure that each repository is "bare" (without a Git index
 file) for `cvs commit` to work. See linkgit:gitcvs-migration[7].
 
 [[configaccessmethod]]
@@ -181,7 +181,7 @@ allowing access over SSH.
 3. If you didn't specify the CVSROOT/CVS_SERVER directly in the checkout command,
    automatically saving it in your 'CVS/Root' files, then you need to set them
    explicitly in your environment.  CVSROOT should be set as per normal, but the
-   directory should point at the appropriate git repo.  As above, for SSH clients
+   directory should point at the appropriate Git repo.  As above, for SSH clients
    _not_ restricted to 'git-shell', CVS_SERVER should be set to 'git-cvsserver'.
 +
 --
@@ -210,7 +210,7 @@ allowing access over SSH.
 Database Backend
 ----------------
 
-'git-cvsserver' uses one database per git head (i.e. CVS module) to
+'git-cvsserver' uses one database per Git head (i.e. CVS module) to
 store information about the repository to maintain consistent
 CVS revision numbers. The database needs to be
 updated (i.e. written to) after every commit.
@@ -225,7 +225,7 @@ the pserver method), 'git-cvsserver' should have write access to
 the database to work reliably (otherwise you need to make sure
 that the database is up-to-date any time 'git-cvsserver' is executed).
 
-By default it uses SQLite databases in the git directory, named
+By default it uses SQLite databases in the Git directory, named
 `gitcvs.<module_name>.sqlite`. Note that the SQLite backend creates
 temporary files in the same directory as the database file on
 write so it might not be enough to grant the users using
diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 80de4f6..77da564 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -3,7 +3,7 @@ git-daemon(1)
 
 NAME
 ----
-git-daemon - A really simple server for git repositories
+git-daemon - A really simple server for Git repositories
 
 SYNOPSIS
 --------
@@ -22,12 +22,12 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-A really simple TCP git daemon that normally listens on port "DEFAULT_GIT_PORT"
+A really simple TCP Git daemon that normally listens on port "DEFAULT_GIT_PORT"
 aka 9418.  It waits for a connection asking for a service, and will serve
 that service if it is enabled.
 
 It verifies that the directory has the magic file "git-daemon-export-ok", and
-it will refuse to export any git directory that hasn't explicitly been marked
+it will refuse to export any Git directory that hasn't explicitly been marked
 for export this way (unless the '--export-all' parameter is specified). If you
 pass some directory paths as 'git daemon' arguments, you can further restrict
 the offers to a whitelist comprising of those.
@@ -37,7 +37,7 @@ By default, only `upload-pack` service is enabled, which serves
 from 'git fetch', 'git pull', and 'git clone'.
 
 This is ideally suited for read-only updates, i.e., pulling from
-git repositories.
+Git repositories.
 
 An `upload-archive` also exists to serve 'git archive'.
 
diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index 72d6bb6..32da244 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -131,7 +131,7 @@ closest tagname without any suffix:
 
 Note that the suffix you get if you type these commands today may be
 longer than what Linus saw above when he ran these commands, as your
-git repository may have new commits whose object names begin with
+Git repository may have new commits whose object names begin with
 975b that did not exist back then, and "-g975b" suffix alone may not
 be sufficient to disambiguate these commits.
 
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index f8c0601..a7b4620 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -25,7 +25,7 @@ between two files on disk.
 
 	This form is to view the changes you made relative to
 	the index (staging area for the next commit).  In other
-	words, the differences are what you _could_ tell git to
+	words, the differences are what you _could_ tell Git to
 	further add to the index but you still haven't.  You can
 	stage these changes by using linkgit:git-add[1].
 +
diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 73ca702..e0e12e9 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-'git difftool' is a git command that allows you to compare and edit files
+'git difftool' is a Git command that allows you to compare and edit files
 between revisions using common diff tools.  'git difftool' is a frontend
 to 'git diff' and accepts the same options and arguments. See
 linkgit:git-diff[1].
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index b41d7c1..e08a028 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -80,7 +80,7 @@ Using --recurse-submodules can only fetch new commits in already checked
 out submodules right now. When e.g. upstream added a new submodule in the
 just fetched commits of the superproject the submodule itself can not be
 fetched, making it impossible to check out that submodule later without
-having to do a fetch again. This is expected to be fixed in a future git
+having to do a fetch again. This is expected to be fixed in a future Git
 version.
 
 SEE ALSO
diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index e2301f5..c07ad61 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -29,7 +29,7 @@ The command will only rewrite the _positive_ refs mentioned in the
 command line (e.g. if you pass 'a..b', only 'b' will be rewritten).
 If you specify no filters, the commits will be recommitted without any
 changes, which would normally have no effect.  Nevertheless, this may be
-useful in the future for compensating for some git bugs or such,
+useful in the future for compensating for some Git bugs or such,
 therefore such a usage is permitted.
 
 *NOTE*: This command honors `.git/info/grafts` file and refs in
@@ -374,7 +374,7 @@ git-filter-branch is often used to get rid of a subset of files,
 usually with some combination of `--index-filter` and
 `--subdirectory-filter`.  People expect the resulting repository to
 be smaller than the original, but you need a few more steps to
-actually make it smaller, because git tries hard not to lose your
+actually make it smaller, because Git tries hard not to lose your
 objects until you tell it to.  First make sure that:
 
 * You really removed all variants of a filename, if a blob was moved
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 9a914d0..3a62f50 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -208,14 +208,14 @@ The expected use case of this is to write supporting explanation for
 the commit that does not belong to the commit log message proper,
 and include it with the patch submission. While one can simply write
 these explanations after `format-patch` has run but before sending,
-keeping them as git notes allows them to be maintained between versions
+keeping them as Git notes allows them to be maintained between versions
 of the patch series (but see the discussion of the `notes.rewrite`
 configuration options in linkgit:git-notes[1] to use this workflow).
 
 --[no]-signature=<signature>::
 	Add a signature to each message produced. Per RFC 3676 the signature
 	is separated from the body by a line with '-- ' on it. If the
-	signature option is omitted the signature defaults to the git version
+	signature option is omitted the signature defaults to the Git version
 	number.
 
 --suffix=.<sfx>::
@@ -389,7 +389,7 @@ Thunderbird
 ~~~~~~~~~~~
 By default, Thunderbird will both wrap emails as well as flag
 them as being 'format=flowed', both of which will make the
-resulting email unusable by git.
+resulting email unusable by Git.
 
 There are three different approaches: use an add-on to turn off line wraps,
 configure Thunderbird to not mangle patches, or use
@@ -525,8 +525,8 @@ $ git format-patch -M -B origin
 Additionally, it detects and handles renames and complete rewrites
 intelligently to produce a renaming patch.  A renaming patch reduces
 the amount of text output, and generally makes it easier to review.
-Note that non-git "patch" programs won't understand renaming patches, so
-use it only when you know the recipient uses git to apply your patch.
+Note that non-Git "patch" programs won't understand renaming patches, so
+use it only when you know the recipient uses Git to apply your patch.
 
 * Extract three topmost commits from the current branch and format them
 as e-mailable patches:
diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index da348fc..eff9188 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -56,7 +56,7 @@ index file, all SHA1 references in `refs` namespace, and all reflogs
 	($GIT_DIR/objects), but also the ones found in alternate
 	object pools listed in GIT_ALTERNATE_OBJECT_DIRECTORIES
 	or $GIT_DIR/objects/info/alternates,
-	and in packed git archives found in $GIT_DIR/objects/pack
+	and in packed Git archives found in $GIT_DIR/objects/pack
 	and corresponding pack subdirectories in alternate
 	object pools.  This is now default; you can turn it off
 	with --no-full.
@@ -64,8 +64,8 @@ index file, all SHA1 references in `refs` namespace, and all reflogs
 --strict::
 	Enable more strict checking, namely to catch a file mode
 	recorded with g+w bit set, which was created by older
-	versions of git.  Existing repositories, including the
-	Linux kernel, git itself, and sparse repository have old
+	versions of Git.  Existing repositories, including the
+	Linux kernel, Git itself, and sparse repository have old
 	objects that triggers this check, but it is recommended
 	to check new projects with this flag.
 
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index cfecf84..50d46e1 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -61,7 +61,7 @@ OPTIONS
 	blobs registered in the index file.
 
 --no-index::
-	Search files in the current directory that is not managed by git.
+	Search files in the current directory that is not managed by Git.
 
 --untracked::
 	In addition to searching in the tracked files in the working
diff --git a/Documentation/git-gui.txt b/Documentation/git-gui.txt
index 0041994..8144527 100644
--- a/Documentation/git-gui.txt
+++ b/Documentation/git-gui.txt
@@ -102,7 +102,7 @@ Examples
 SEE ALSO
 --------
 linkgit:gitk[1]::
-	The git repository browser.  Shows branches, commit history
+	The Git repository browser.  Shows branches, commit history
 	and file differences.  gitk is the utility started by
 	'git gui''s Repository Visualize actions.
 
diff --git a/Documentation/git-hash-object.txt b/Documentation/git-hash-object.txt
index 4b0a502..02c1f12 100644
--- a/Documentation/git-hash-object.txt
+++ b/Documentation/git-hash-object.txt
@@ -40,7 +40,7 @@ OPTIONS
 --path::
 	Hash object as it were located at the given path. The location of
 	file does not directly influence on the hash value, but path is
-	used to determine what git filters should be applied to the object
+	used to determine what Git filters should be applied to the object
 	before it can be placed to the object database, and, as result of
 	applying filters, the actual blob put into the object database may
 	differ from the given file. This option is mainly useful for hashing
diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 9e0b3f6..071e947 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -14,7 +14,7 @@ DESCRIPTION
 -----------
 
 With no options and no COMMAND given, the synopsis of the 'git'
-command and a list of the most commonly used git commands are printed
+command and a list of the most commonly used Git commands are printed
 on the standard output.
 
 If the option '--all' or '-a' is given, then all available commands are
diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index f4e0741..7b1e85c 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -19,7 +19,7 @@ and the backwards-compatible dumb HTTP protocol, as well as clients
 pushing using the smart HTTP protocol.
 
 It verifies that the directory has the magic file
-"git-daemon-export-ok", and it will refuse to export any git directory
+"git-daemon-export-ok", and it will refuse to export any Git directory
 that hasn't explicitly been marked for export this way (unless the
 GIT_HTTP_EXPORT_ALL environmental variable is set).
 
diff --git a/Documentation/git-http-fetch.txt b/Documentation/git-http-fetch.txt
index 070cd1e..21a33d2 100644
--- a/Documentation/git-http-fetch.txt
+++ b/Documentation/git-http-fetch.txt
@@ -3,7 +3,7 @@ git-http-fetch(1)
 
 NAME
 ----
-git-http-fetch - Download from a remote git repository via HTTP
+git-http-fetch - Download from a remote Git repository via HTTP
 
 
 SYNOPSIS
@@ -13,7 +13,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Downloads a remote git repository via HTTP.
+Downloads a remote Git repository via HTTP.
 
 *NOTE*: use of this command without -a is deprecated.  The -a
 behaviour will become the default in a future release.
diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 39e6d0d..36adc5f 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -19,7 +19,7 @@ DESCRIPTION
 Reads a packed archive (.pack) from the specified file, and
 builds a pack index file (.idx) for it.  The packed archive
 together with the pack index can then be placed in the
-objects/pack/ directory of a git repository.
+objects/pack/ directory of a Git repository.
 
 
 OPTIONS
@@ -39,7 +39,7 @@ OPTIONS
 	When this flag is provided, the pack is read from stdin
 	instead and a copy is then written to <pack-file>. If
 	<pack-file> is not specified, the pack is written to
-	objects/pack/ directory of the current git repository with
+	objects/pack/ directory of the current Git repository with
 	a default name determined from the pack content.  If
 	<pack-file> is not specified consider using --keep to
 	prevent a race condition between this process and
@@ -81,7 +81,7 @@ OPTIONS
 	This is meant to reduce packing time on multiprocessor
 	machines. The required amount of memory for the delta search
 	window is however multiplied by the number of threads.
-	Specifying 0 will cause git to auto-detect the number of CPU's
+	Specifying 0 will cause Git to auto-detect the number of CPU's
 	and use maximum 3 threads.
 
 
diff --git a/Documentation/git-init-db.txt b/Documentation/git-init-db.txt
index a21e346..648a6cd 100644
--- a/Documentation/git-init-db.txt
+++ b/Documentation/git-init-db.txt
@@ -3,7 +3,7 @@ git-init-db(1)
 
 NAME
 ----
-git-init-db - Creates an empty git repository
+git-init-db - Creates an empty Git repository
 
 
 SYNOPSIS
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 9ac2bba..2571f56 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -3,7 +3,7 @@ git-init(1)
 
 NAME
 ----
-git-init - Create an empty git repository or reinitialize an existing one
+git-init - Create an empty Git repository or reinitialize an existing one
 
 
 SYNOPSIS
@@ -17,7 +17,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-This command creates an empty git repository - basically a `.git`
+This command creates an empty Git repository - basically a `.git`
 directory with subdirectories for `objects`, `refs/heads`,
 `refs/tags`, and template files.  An initial `HEAD` file that
 references the HEAD of the master branch is also created.
@@ -58,19 +58,19 @@ DIRECTORY" section below.)
 --separate-git-dir=<git dir>::
 
 Instead of initializing the repository where it is supposed to be,
-place a filesytem-agnostic git symbolic link there, pointing to the
-specified git path, and initialize a git repository at the path. The
-result is git repository can be separated from working tree. If this
+place a filesytem-agnostic Git symbolic link there, pointing to the
+specified Git path, and initialize a Git repository at the path. The
+result is Git repository can be separated from working tree. If this
 is reinitialization, the repository will be moved to the specified
 path.
 
 --shared[=(false|true|umask|group|all|world|everybody|0xxx)]::
 
-Specify that the git repository is to be shared amongst several users.  This
+Specify that the Git repository is to be shared amongst several users.  This
 allows users belonging to the same group to push into that
 repository.  When specified, the config variable "core.sharedRepository" is
 set so that files and directories under `$GIT_DIR` are created with the
-requested permissions.  When not specified, git will use permissions reported
+requested permissions.  When not specified, Git will use permissions reported
 by umask(2).
 
 The option can have the following values, defaulting to 'group' if no value
@@ -130,7 +130,7 @@ The suggested patterns and hook files are all modifiable and extensible.
 EXAMPLES
 --------
 
-Start a new git repository for an existing code base::
+Start a new Git repository for an existing code base::
 +
 ----------------
 $ cd /path/to/my/codebase
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 22c0d6e..69db578 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -64,7 +64,7 @@ produced by --stat etc.
 
 --log-size::
 	Before the log message print out its size in bytes. Intended
-	mainly for porcelain tools consumption. If git is unable to
+	mainly for porcelain tools consumption. If Git is unable to
 	produce a valid value size is set to zero.
 	Note that only message is considered, if also a diff is shown
 	its size is not included.
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 4b28292..0bdebff 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -92,7 +92,7 @@ OPTIONS
 	directory and its subdirectories in <file>.
 
 --exclude-standard::
-	Add the standard git exclusions: .git/info/exclude, .gitignore
+	Add the standard Git exclusions: .git/info/exclude, .gitignore
 	in each directory, and the user's global exclusion file.
 
 --error-unmatch::
diff --git a/Documentation/git-merge-index.txt b/Documentation/git-merge-index.txt
index e0df1b3..0c80cec 100644
--- a/Documentation/git-merge-index.txt
+++ b/Documentation/git-merge-index.txt
@@ -41,13 +41,13 @@ If 'git merge-index' is called with multiple <file>s (or -a) then it
 processes them in turn only stopping if merge returns a non-zero exit
 code.
 
-Typically this is run with a script calling git's imitation of
+Typically this is run with a script calling Git's imitation of
 the 'merge' command from the RCS package.
 
 A sample script called 'git merge-one-file' is included in the
 distribution.
 
-ALERT ALERT ALERT! The git "merge object order" is different from the
+ALERT ALERT ALERT! The Git "merge object order" is different from the
 RCS 'merge' program merge object order. In the above ordering, the
 original is first. But the argument order to the 3-way merge program
 'merge' is to have the original in the middle. Don't ask me why.
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index d34ea3c..c852a26 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -178,10 +178,10 @@ of the merge.  Among the changes made to the common ancestor's version,
 non-overlapping ones (that is, you changed an area of the file while the
 other side left that area intact, or vice versa) are incorporated in the
 final result verbatim.  When both sides made changes to the same area,
-however, git cannot randomly pick one side over the other, and asks you to
+however, Git cannot randomly pick one side over the other, and asks you to
 resolve it by leaving what both sides did to that area.
 
-By default, git uses the same style as the one used by the "merge" program
+By default, Git uses the same style as the one used by the "merge" program
 from the RCS suite to present such a conflicted hunk, like this:
 
 ------------
diff --git a/Documentation/git-mergetool--lib.txt b/Documentation/git-mergetool--lib.txt
index f98a41b..b748bdf 100644
--- a/Documentation/git-mergetool--lib.txt
+++ b/Documentation/git-mergetool--lib.txt
@@ -19,7 +19,7 @@ Porcelain-ish scripts and/or are writing new ones.
 
 The 'git-mergetool{litdd}lib' scriptlet is designed to be sourced (using
 `.`) by other shell scripts to set up functions for working
-with git merge tools.
+with Git merge tools.
 
 Before sourcing 'git-mergetool{litdd}lib', your script must set `TOOL_MODE`
 to define the operation mode for the functions listed below.
diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
index 65e167a..3ca158b 100644
--- a/Documentation/git-mktag.txt
+++ b/Documentation/git-mktag.txt
@@ -28,9 +28,9 @@ A tag signature file has a very simple fixed format: four lines of
   tagger <tagger>
 
 followed by some 'optional' free-form message (some tags created
-by older git may not have `tagger` line).  The message, when
+by older Git may not have `tagger` line).  The message, when
 exists, is separated by a blank line from the header.  The
-message part may contain a signature that git itself doesn't
+message part may contain a signature that Git itself doesn't
 care about, but that can be verified with gpg.
 
 GIT
diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index beff622..96a5b31 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -18,13 +18,13 @@ SYNOPSIS
 DESCRIPTION
 -----------
 This command provides a way to interact with p4 repositories
-using git.
+using Git.
 
-Create a new git repository from an existing p4 repository using
+Create a new Git repository from an existing p4 repository using
 'git p4 clone', giving it one or more p4 depot paths.  Incorporate
 new commits from p4 changes with 'git p4 sync'.  The 'sync' command
 is also used to include new branches from other p4 depot paths.
-Submit git changes back to p4 using 'git p4 submit'.  The command
+Submit Git changes back to p4 using 'git p4 submit'.  The command
 'git p4 rebase' does a sync plus rebases the current branch onto
 the updated p4 remote branch.
 
@@ -37,7 +37,7 @@ EXAMPLE
 $ git p4 clone //depot/path/project
 ------------
 
-* Do some work in the newly created git repository:
+* Do some work in the newly created Git repository:
 +
 ------------
 $ cd project
@@ -45,7 +45,7 @@ $ vi foo.h
 $ git commit -a -m "edited foo.h"
 ------------
 
-* Update the git repository with recent changes from p4, rebasing your
+* Update the Git repository with recent changes from p4, rebasing your
   work on top:
 +
 ------------
@@ -71,14 +71,14 @@ $ git p4 clone //depot/path/project
 ------------
 This:
 
-1.   Creates an empty git repository in a subdirectory called 'project'.
+1.   Creates an empty Git repository in a subdirectory called 'project'.
 +
 2.   Imports the full contents of the head revision from the given p4
-depot path into a single commit in the git branch 'refs/remotes/p4/master'.
+depot path into a single commit in the Git branch 'refs/remotes/p4/master'.
 +
 3.   Creates a local branch, 'master' from this remote and checks it out.
 
-To reproduce the entire p4 history in git, use the '@all' modifier on
+To reproduce the entire p4 history in Git, use the '@all' modifier on
 the depot path:
 ------------
 $ git p4 clone //depot/path/project@all
@@ -88,13 +88,13 @@ $ git p4 clone //depot/path/project@all
 Sync
 ~~~~
 As development continues in the p4 repository, those changes can
-be included in the git repository using:
+be included in the Git repository using:
 ------------
 $ git p4 sync
 ------------
-This command finds new changes in p4 and imports them as git commits.
+This command finds new changes in p4 and imports them as Git commits.
 
-P4 repositories can be added to an existing git repository using
+P4 repositories can be added to an existing Git repository using
 'git p4 sync' too:
 ------------
 $ mkdir repo-git
@@ -103,14 +103,14 @@ $ git init
 $ git p4 sync //path/in/your/perforce/depot
 ------------
 This imports the specified depot into
-'refs/remotes/p4/master' in an existing git repository.  The
+'refs/remotes/p4/master' in an existing Git repository.  The
 '--branch' option can be used to specify a different branch to
 be used for the p4 content.
 
-If a git repository includes branches 'refs/remotes/origin/p4', these
+If a Git repository includes branches 'refs/remotes/origin/p4', these
 will be fetched and consulted first during a 'git p4 sync'.  Since
 importing directly from p4 is considerably slower than pulling changes
-from a git remote, this can be useful in a multi-developer environment.
+from a Git remote, this can be useful in a multi-developer environment.
 
 
 Rebase
@@ -127,13 +127,13 @@ $ git p4 rebase
 
 Submit
 ~~~~~~
-Submitting changes from a git repository back to the p4 repository
+Submitting changes from a Git repository back to the p4 repository
 requires a separate p4 client workspace.  This should be specified
-using the 'P4CLIENT' environment variable or the git configuration
+using the 'P4CLIENT' environment variable or the Git configuration
 variable 'git-p4.client'.  The p4 client must exist, but the client root
 will be created and populated if it does not already exist.
 
-To submit all changes that are in the current git branch but not in
+To submit all changes that are in the current Git branch but not in
 the 'p4/master' branch, use:
 ------------
 $ git p4 submit
@@ -149,7 +149,7 @@ be overridden using the '--origin=' command-line option.
 
 The p4 changes will be created as the user invoking 'git p4 submit'. The
 '--preserve-user' option will cause ownership to be modified
-according to the author of the git commit.  This option requires admin
+according to the author of the Git commit.  This option requires admin
 privileges in p4, which can be granted using 'p4 protect'.
 
 
@@ -178,7 +178,7 @@ subsequent 'sync' operations.
 	with an initial clone, no HEAD will be checked out.
 +
 This example imports a new remote "p4/proj2" into an existing
-git repository:
+Git repository:
 +
 ----
     $ git init
@@ -199,11 +199,11 @@ git repository:
 
 --detect-labels::
 	Query p4 for labels associated with the depot paths, and add
-	them as tags in git. Limited usefulness as only imports labels
+	them as tags in Git. Limited usefulness as only imports labels
 	associated with new changelists. Deprecated.
 
 --import-labels::
-	Import labels from p4 into git.
+	Import labels from p4 into Git.
 
 --import-local::
 	By default, p4 branches are stored in 'refs/remotes/p4/',
@@ -219,12 +219,12 @@ git repository:
 	specifier.
 
 --keep-path::
-	The mapping of file names from the p4 depot path to git, by
+	The mapping of file names from the p4 depot path to Git, by
 	default, involves removing the entire depot path.  With this
-	option, the full p4 depot path is retained in git.  For example,
+	option, the full p4 depot path is retained in Git.  For example,
 	path '//depot/main/foo/bar.c', when imported from
 	'//depot/main/', becomes 'foo/bar.c'.  With '--keep-path', the
-	git path is instead 'depot/main/foo/bar.c'.
+	Git path is instead 'depot/main/foo/bar.c'.
 
 --use-client-spec::
 	Use a client spec to find the list of interesting files in p4.
@@ -236,7 +236,7 @@ These options can be used in an initial 'clone', along with the 'sync'
 options described above.
 
 --destination <directory>::
-	Where to create the git repository.  If not provided, the last
+	Where to create the Git repository.  If not provided, the last
 	component in the p4 depot path is used to create a new
 	directory.
 
@@ -266,12 +266,12 @@ These options can be used to modify 'git p4 submit' behavior.
 	requires p4 admin privileges.
 
 --export-labels::
-	Export tags from git as p4 labels. Tags found in git are applied
+	Export tags from Git as p4 labels. Tags found in Git are applied
 	to the perforce working directory.
 
 --dry-run, -n::
 	Show just what commits would be submitted to p4; do not change
-	state in git or p4.
+	state in Git or p4.
 
 --prepare-p4-only::
 	Apply a commit to the p4 workspace, opening, adding and deleting
@@ -312,12 +312,12 @@ p4 revision specifier on the end:
 "//depot/proj1@all //depot/proj2@all"::
     Import all changes from both named depot paths into a single
     repository.  Only files below these directories are included.
-    There is not a subdirectory in git for each "proj1" and "proj2".
+    There is not a subdirectory in Git for each "proj1" and "proj2".
     You must use the '--destination' option when specifying more
     than one depot path.  The revision specifier must be specified
     identically on each depot path.  If there are files in the
     depot paths with the same name, the path with the most recently
-    updated version of the file is the one that appears in git.
+    updated version of the file is the one that appears in Git.
 
 See 'p4 help revisions' for the full syntax of p4 revision specifiers.
 
@@ -354,7 +354,7 @@ variable P4CLIENT, a file referenced by P4CONFIG, or the local host name.
 
 BRANCH DETECTION
 ----------------
-P4 does not have the same concept of a branch as git.  Instead,
+P4 does not have the same concept of a branch as Git.  Instead,
 p4 organizes its content as a directory tree, where by convention
 different logical branches are in different locations in the tree.
 The 'p4 branch' command is used to maintain mappings between
@@ -364,7 +364,7 @@ can use these mappings to determine branch relationships.
 If you have a repository where all the branches of interest exist as
 subdirectories of a single depot path, you can use '--detect-branches'
 when cloning or syncing to have 'git p4' automatically find
-subdirectories in p4, and to generate these as branches in git.
+subdirectories in p4, and to generate these as branches in Git.
 
 For example, if the P4 repository structure is:
 ----
@@ -386,7 +386,7 @@ called 'master', and one for //depot/branch1 called 'depot/branch1'.
 
 However, it is not necessary to create branches in p4 to be able to use
 them like branches.  Because it is difficult to infer branch
-relationships automatically, a git configuration setting
+relationships automatically, a Git configuration setting
 'git-p4.branchList' can be used to explicitly identify branch
 relationships.  It is a list of "source:destination" pairs, like a
 simple p4 branch specification, where the "source" and "destination" are
@@ -402,7 +402,7 @@ git p4 clone --detect-branches //depot@all
 PERFORMANCE
 -----------
 The fast-import mechanism used by 'git p4' creates one pack file for
-each invocation of 'git p4 sync'.  Normally, git garbage compression
+each invocation of 'git p4 sync'.  Normally, Git garbage compression
 (linkgit:git-gc[1]) automatically compresses these to fewer pack files,
 but explicit invocation of 'git repack -adf' may improve performance.
 
@@ -440,9 +440,9 @@ git-p4.client::
 Clone and sync variables
 ~~~~~~~~~~~~~~~~~~~~~~~~
 git-p4.syncFromOrigin::
-	Because importing commits from other git repositories is much faster
+	Because importing commits from other Git repositories is much faster
 	than importing them from p4, a mechanism exists to find p4 changes
-	first in git remotes.  If branches exist under 'refs/remote/origin/p4',
+	first in Git remotes.  If branches exist under 'refs/remote/origin/p4',
 	those will be fetched and used when syncing from p4.  This
 	variable can be set to 'false' to disable this behavior.
 
@@ -531,7 +531,7 @@ git-p4.attemptRCSCleanup::
 	present.
 
 git-p4.exportLabels::
-	Export git tags to p4 labels, as per --export-labels.
+	Export Git tags to p4 labels, as per --export-labels.
 
 git-p4.labelExportRegexp::
 	Only p4 labels matching this regular expression will be exported. The
@@ -543,11 +543,11 @@ git-p4.conflict::
 
 IMPLEMENTATION DETAILS
 ----------------------
-* Changesets from p4 are imported using git fast-import.
+* Changesets from p4 are imported using Git fast-import.
 * Cloning or syncing does not require a p4 client; file contents are
   collected using 'p4 print'.
 * Submitting requires a p4 client, which is not in the same location
-  as the git repository.  Patches are applied, one at a time, to
+  as the Git repository.  Patches are applied, one at a time, to
   this p4 client and submitted from there.
 * Each commit imported by 'git p4' has a line at the end of the log
   message indicating the p4 depot location and change number.  This
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 20c8551..69c9313 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -35,7 +35,7 @@ A pack index file (.idx) is generated for fast, random access to the
 objects in the pack. Placing both the index file (.idx) and the packed
 archive (.pack) in the pack/ subdirectory of $GIT_OBJECT_DIRECTORY (or
 any of the directories on $GIT_ALTERNATE_OBJECT_DIRECTORIES)
-enables git to read from the pack archive.
+enables Git to read from the pack archive.
 
 The 'git unpack-objects' command can read the packed archive and
 expand the objects contained in the pack into "one-file
@@ -80,7 +80,7 @@ base-name::
 --include-tag::
 	Include unasked-for annotated tags if the object they
 	reference was included in the resulting packfile.  This
-	can be useful to send new tags to native git clients.
+	can be useful to send new tags to native Git clients.
 
 --window=<n>::
 --depth=<n>::
@@ -185,14 +185,14 @@ base-name::
 	option only makes sense in conjunction with --stdout.
 +
 Note: A thin pack violates the packed archive format by omitting
-required objects and is thus unusable by git without making it
+required objects and is thus unusable by Git without making it
 self-contained. Use `git index-pack --fix-thin`
 (see linkgit:git-index-pack[1]) to restore the self-contained property.
 
 --delta-base-offset::
 	A packed archive can express the base object of a delta as
 	either a 20-byte object name or as an offset in the
-	stream, but ancient versions of git don't understand the
+	stream, but ancient versions of Git don't understand the
 	latter.  By default, 'git pack-objects' only uses the
 	former format for better compatibility.  This option
 	allows the command to use the latter format for
@@ -202,7 +202,7 @@ self-contained. Use `git index-pack --fix-thin`
 +
 Note: Porcelain commands such as `git gc` (see linkgit:git-gc[1]),
 `git repack` (see linkgit:git-repack[1]) pass this option by default
-in modern git when they put objects in your repository into pack files.
+in modern Git when they put objects in your repository into pack files.
 So does `git bundle` (see linkgit:git-bundle[1]) when it creates a bundle.
 
 --threads=<n>::
@@ -212,7 +212,7 @@ So does `git bundle` (see linkgit:git-bundle[1]) when it creates a bundle.
 	This is meant to reduce packing time on multiprocessor machines.
 	The required amount of memory for the delta search window is
 	however multiplied by the number of threads.
-	Specifying 0 will cause git to auto-detect the number of CPU's
+	Specifying 0 will cause Git to auto-detect the number of CPU's
 	and set the number of threads accordingly.
 
 --index-version=<version>[,<offset>]::
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 67fa5ee..c975743 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -59,8 +59,8 @@ and a log message from the user describing the changes.
 See linkgit:git-merge[1] for details, including how conflicts
 are presented and handled.
 
-In git 1.7.0 or later, to cancel a conflicting merge, use
-`git reset --merge`.  *Warning*: In older versions of git, running 'git pull'
+In Git 1.7.0 or later, to cancel a conflicting merge, use
+`git reset --merge`.  *Warning*: In older versions of Git, running 'git pull'
 with uncommitted changes is discouraged: while possible, it leaves you
 in a state that may be hard to back out of in the case of a conflict.
 
@@ -89,7 +89,7 @@ must be given before the options meant for 'git fetch'.
 	This option controls if new commits of all populated submodules should
 	be fetched too (see linkgit:git-config[1] and linkgit:gitmodules[5]).
 	That might be necessary to get the data needed for merging submodule
-	commits, a feature git learned in 1.7.3. Notice that the result of a
+	commits, a feature Git learned in 1.7.3. Notice that the result of a
 	merge will not be checked out in the submodule, "git submodule update"
 	has to be called afterwards to bring the work tree up to date with the
 	merge result.
@@ -228,7 +228,7 @@ Using --recurse-submodules can only fetch new commits in already checked
 out submodules right now. When e.g. upstream added a new submodule in the
 just fetched commits of the superproject the submodule itself can not be
 fetched, making it impossible to check out that submodule later without
-having to do a fetch again. This is expected to be fixed in a future git
+having to do a fetch again. This is expected to be fixed in a future Git
 version.
 
 SEE ALSO
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index c964b79..1398025 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -53,7 +53,7 @@ updated.
 The object referenced by <src> is used to update the <dst> reference
 on the remote side.  By default this is only allowed if <dst> is not
 a tag (annotated or lightweight), and then only if it can fast-forward
-<dst>.  By having the optional leading `+`, you can tell git to update
+<dst>.  By having the optional leading `+`, you can tell Git to update
 the <dst> ref even if it is not allowed by default (e.g., it is not a
 fast-forward.)  This does *not* attempt to merge <src> into <dst>.  See
 EXAMPLES below for details.
@@ -64,7 +64,7 @@ Pushing an empty <src> allows you to delete the <dst> ref from
 the remote repository.
 +
 The special refspec `:` (or `+:` to allow non-fast-forward updates)
-directs git to push "matching" branches: for every branch that exists on
+directs Git to push "matching" branches: for every branch that exists on
 the local side, the remote side is updated if a branch of the same name
 already exists on the remote side.  This is the default operation mode
 if no explicit refspec is found (that is neither on the command line
@@ -177,7 +177,7 @@ useful if you write an alias or script around 'git push'.
 --recurse-submodules=check|on-demand::
 	Make sure all submodule commits used by the revisions to be
 	pushed are available on a remote-tracking branch. If 'check' is
-	used git will verify that all submodule commits that changed in
+	used Git will verify that all submodule commits that changed in
 	the revisions to be pushed are available on at least one remote
 	of the submodule. If any commits are missing the push will be
 	aborted and exit with non-zero status. If 'on-demand' is used
@@ -192,7 +192,7 @@ OUTPUT
 ------
 
 The output of "git push" depends on the transport method used; this
-section describes the output when pushing over the git protocol (either
+section describes the output when pushing over the Git protocol (either
 locally or via ssh).
 
 The status of the push is output in tabular form, with each line
diff --git a/Documentation/git-quiltimport.txt b/Documentation/git-quiltimport.txt
index 7f112f3..a356196 100644
--- a/Documentation/git-quiltimport.txt
+++ b/Documentation/git-quiltimport.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Applies a quilt patchset onto the current git branch, preserving
+Applies a quilt patchset onto the current Git branch, preserving
 the patch boundaries, patch order, and patch descriptions present
 in the quilt patchset.
 
@@ -25,7 +25,7 @@ the patch description is displayed and the user is asked to
 interactively enter the author of the patch.
 
 If a subject is not found in the patch description the patch name is
-preserved as the 1 line subject in the git description.
+preserved as the 1 line subject in the Git description.
 
 OPTIONS
 -------
-- 
1.8.0.msysgit.0


---
Thomas
