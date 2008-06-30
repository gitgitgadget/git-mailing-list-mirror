From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: [PATCH 1/7] Documentation: fix links to tutorials and other new
 manual pages
Date: Mon, 30 Jun 2008 17:01:21 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0806301657320.7190@harper.uchicago.edu>
References: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jon Loeliger <jdl@jdl.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 01 00:03:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDRSs-0002rf-JU
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 00:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763702AbYF3WCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 18:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763066AbYF3WCQ
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 18:02:16 -0400
Received: from smtp02.uchicago.edu ([128.135.12.75]:49273 "EHLO
	smtp02.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763054AbYF3WCP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 18:02:15 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp02.uchicago.edu (8.13.8/8.13.8) with ESMTP id m5UM1ONW021840;
	Mon, 30 Jun 2008 17:01:24 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m5UM1MoA007588;
	Mon, 30 Jun 2008 17:01:22 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86942>

With the conversion of HTML documentation to man pages

tutorial.html -> gittutorial (7)
tutorial-2.html -> gittutorial-2 (7)
cvs-migration.html -> gitcvs-migration (7)
diffcore.html -> gitdiffcore (7)
repository-layout.html -> gitrepository-layout (5)
hooks.html -> githooks (5)
glossary.html -> gitglossary (7)
core-tutorial.html -> gitcore-tutorial (7)

and the automatic update of references to these pages,
a little debris was left behind. We clear it away.

Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
---
 Documentation/diff-options.txt           |    2 +-
 Documentation/git-add.txt                |    2 +-
 Documentation/git-commit.txt             |    4 ++--
 Documentation/git-update-server-info.txt |    2 +-
 Documentation/git.txt                    |   20 ++++++++++----------
 Documentation/gitcore-tutorial.txt       |    9 ++++-----
 Documentation/gitcvs-migration.txt       |   12 ++++++------
 Documentation/gitrepository-layout.txt   |    2 +-
 Documentation/gittutorial-2.txt          |   12 +++++-------
 Documentation/gittutorial.txt            |    8 ++++----
 Documentation/user-manual.txt            |    7 +++----
 11 files changed, 38 insertions(+), 42 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 5721548..cba90fd 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -241,4 +241,4 @@ endif::git-format-patch[]
 	Do not show any source or destination prefix.
 
 For more detailed explanation on these common options, see also
-linkgit:gitdiffcore[7][diffcore documentation].
+linkgit:gitdiffcore[7].
diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index b8e3fa6..2b0ccb3 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -107,7 +107,7 @@ Configuration
 The optional configuration variable 'core.excludesfile' indicates a path to a
 file containing patterns of file names to exclude from git-add, similar to
 $GIT_DIR/info/exclude.  Patterns in the exclude file are used in addition to
-those in info/exclude.  See linkgit:gitrepository-layout[5][repository layout].
+those in info/exclude.  See linkgit:gitrepository-layout[5].
 
 
 EXAMPLES
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index d0fe192..656d4db 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -97,7 +97,7 @@ OPTIONS
 -n::
 --no-verify::
 	This option bypasses the pre-commit and commit-msg hooks.
-	See also linkgit:githooks[5][hooks].
+	See also linkgit:githooks[5].
 
 --allow-empty::
 	Usually recording a commit that has the exact same tree as its
@@ -316,7 +316,7 @@ order).
 HOOKS
 -----
 This command can run `commit-msg`, `prepare-commit-msg`, `pre-commit`,
-and `post-commit` hooks.  See linkgit:githooks[5][hooks] for more
+and `post-commit` hooks.  See linkgit:githooks[5] for more
 information.
 
 
diff --git a/Documentation/git-update-server-info.txt b/Documentation/git-update-server-info.txt
index d21be41..0102410 100644
--- a/Documentation/git-update-server-info.txt
+++ b/Documentation/git-update-server-info.txt
@@ -31,7 +31,7 @@ OUTPUT
 ------
 
 Currently the command updates the following files.  Please see
-linkgit:gitrepository-layout[5][repository-layout] for description of
+linkgit:gitrepository-layout[5] for description of
 what they are for:
 
 * objects/info/packs
diff --git a/Documentation/git.txt b/Documentation/git.txt
index a791ce7..27eebfb 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -20,11 +20,11 @@ Git is a fast, scalable, distributed revision control system with an
 unusually rich command set that provides both high-level operations
 and full access to internals.
 
-See this linkgit:gittutorial[7][tutorial] to get started, then see
+See linkgit:gittutorial[7] to get started, then see
 link:everyday.html[Everyday Git] for a useful minimum set of commands, and
 "man git-commandname" for documentation of each command.  CVS users may
-also want to read linkgit:gitcvs-migration[7][CVS migration].  See
-link:user-manual.html[Git User's Manual] for a more in-depth
+also want to read linkgit:gitcvs-migration[7].  See
+the link:user-manual.html[Git User's Manual] for a more in-depth
 introduction.
 
 The COMMAND is either a name of a Git command (see below) or an alias
@@ -182,13 +182,14 @@ See the references above to get started using git.  The following is
 probably more detail than necessary for a first-time user.
 
 The link:user-manual.html#git-concepts[git concepts chapter of the
-user-manual] and the linkgit:gitcore-tutorial[7][Core tutorial] both provide
+user-manual] and linkgit:gitcore-tutorial[7] both provide
 introductions to the underlying git architecture.
 
 See also the link:howto-index.html[howto] documents for some useful
 examples.
 
-The internals are documented link:technical/api-index.html[here].
+The internals are documented in the
+link:technical/api-index.html[GIT API documentation].
 
 GIT COMMANDS
 ------------
@@ -372,10 +373,9 @@ For a more complete list of ways to spell object names, see
 File/Directory Structure
 ------------------------
 
-Please see the linkgit:gitrepository-layout[5][repository layout]
-document.
+Please see the linkgit:gitrepository-layout[5] document.
 
-Read linkgit:githooks[5][hooks] for more details about each hook.
+Read linkgit:githooks[5] for more details about each hook.
 
 Higher level SCMs may provide and manage additional information in the
 `$GIT_DIR`.
@@ -383,7 +383,7 @@ Higher level SCMs may provide and manage additional information in the
 
 Terminology
 -----------
-Please see the linkgit:gitglossary[7][glossary] document.
+Please see linkgit:gitglossary[7].
 
 
 Environment Variables
@@ -535,7 +535,7 @@ Discussion[[Discussion]]
 
 More detail on the following is available from the
 link:user-manual.html#git-concepts[git concepts chapter of the
-user-manual] and the linkgit:gitcore-tutorial[7][Core tutorial].
+user-manual] and linkgit:gitcore-tutorial[7].
 
 A git project normally consists of a working directory with a ".git"
 subdirectory at the top level.  The .git directory contains, among other
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index cb4ec40..6bb32a8 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -16,8 +16,8 @@ This tutorial explains how to use the "core" git programs to set up and
 work with a git repository.
 
 If you just need to use git as a revision control system you may prefer
-to start with linkgit:gittutorial[7][a tutorial introduction to git] or
-link:user-manual.html[the git user manual].
+to start with "A Tutorial Introduction to GIT" (linkgit:gittutorial[7]) or
+link:user-manual.html[the GIT User Manual].
 
 However, an understanding of these low-level tools can be helpful if
 you want to understand git's internals.
@@ -108,8 +108,7 @@ references in these `refs` subdirectories when you actually start
 populating your tree.
 
 [NOTE]
-An advanced user may want to take a look at the
-linkgit:gitrepository-layout[5][repository layout] document
+An advanced user may want to take a look at linkgit:gitrepository-layout[5]
 after finishing this tutorial.
 
 You have now created your first git repository. Of course, since it's
@@ -1589,7 +1588,7 @@ suggested in the previous section may be new to you. You do not
 have to worry. git supports "shared public repository" style of
 cooperation you are probably more familiar with as well.
 
-See linkgit:gitcvs-migration[7][git for CVS users] for the details.
+See linkgit:gitcvs-migration[7] for the details.
 
 Bundling your work together
 ---------------------------
diff --git a/Documentation/gitcvs-migration.txt b/Documentation/gitcvs-migration.txt
index 1db3f52..d652658 100644
--- a/Documentation/gitcvs-migration.txt
+++ b/Documentation/gitcvs-migration.txt
@@ -18,9 +18,9 @@ important than any other.  However, you can emulate the CVS model by
 designating a single shared repository which people can synchronize with;
 this document explains how to do that.
 
-Some basic familiarity with git is required.  This
-linkgit:gittutorial[7][tutorial introduction to git] and the
-linkgit:gitglossary[7][git glossary] should be sufficient.
+Some basic familiarity with git is required. Having gone through
+linkgit:gittutorial[7] and
+linkgit:gitglossary[7] should be sufficient.
 
 Developing against a shared repository
 --------------------------------------
@@ -81,8 +81,8 @@ Setting Up a Shared Repository
 ------------------------------
 
 We assume you have already created a git repository for your project,
-possibly created from scratch or from a tarball (see the
-linkgit:gittutorial[7][tutorial]), or imported from an already existing CVS
+possibly created from scratch or from a tarball (see
+linkgit:gittutorial[7]), or imported from an already existing CVS
 repository (see the next section).
 
 Assume your existing repo is at /home/alice/myproject.  Create a new "bare"
@@ -148,7 +148,7 @@ Advanced Shared Repository Management
 
 Git allows you to specify scripts called "hooks" to be run at certain
 points.  You can use these, for example, to send all commits to the shared
-repository to a mailing list.  See linkgit:githooks[5][Hooks used by git].
+repository to a mailing list.  See linkgit:githooks[5].
 
 You can enforce finer grained permissions using update hooks.  See
 link:howto/update-hook-example.txt[Controlling access to branches using
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index 03c52ff..b75508a 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -135,7 +135,7 @@ hooks::
 	commands.  A handful of sample hooks are installed when
 	`git init` is run, but all of them are disabled by
 	default.  To enable, they need to be made executable.
-	Read linkgit:githooks[5][hooks] for more details about
+	Read linkgit:githooks[5] for more details about
 	each hook.
 
 index::
diff --git a/Documentation/gittutorial-2.txt b/Documentation/gittutorial-2.txt
index 31e8a23..2c54670 100644
--- a/Documentation/gittutorial-2.txt
+++ b/Documentation/gittutorial-2.txt
@@ -12,8 +12,7 @@ git *
 DESCRIPTION
 -----------
 
-You should work through linkgit:gittutorial[7][A tutorial introduction to
-git] before reading this tutorial.
+You should work through linkgit:gittutorial[7] before reading this tutorial.
 
 The goal of this tutorial is to introduce two fundamental pieces of
 git's architecture--the object database and the index file--and to
@@ -390,7 +389,7 @@ in the index file is identical to the one in the working directory.
 In addition to being the staging area for new commits, the index file
 is also populated from the object database when checking out a
 branch, and is used to hold the trees involved in a merge operation.
-See the linkgit:gitcore-tutorial[7][core tutorial] and the relevant man
+See linkgit:gitcore-tutorial[7] and the relevant man
 pages for details.
 
 What next?
@@ -399,20 +398,19 @@ What next?
 At this point you should know everything necessary to read the man
 pages for any of the git commands; one good place to start would be
 with the commands mentioned in link:everyday.html[Everyday git].  You
-should be able to find any unknown jargon in the
-linkgit:gitglossary[7][Glossary].
+should be able to find any unknown jargon in linkgit:gitglossary[7].
 
 The link:user-manual.html[Git User's Manual] provides a more
 comprehensive introduction to git.
 
-The linkgit:gitcvs-migration[7][CVS migration] document explains how to
+linkgit:gitcvs-migration[7] explains how to
 import a CVS repository into git, and shows how to use git in a
 CVS-like way.
 
 For some interesting examples of git use, see the
 link:howto-index.html[howtos].
 
-For git developers, the linkgit:gitcore-tutorial[7][Core tutorial] goes
+For git developers, linkgit:gitcore-tutorial[7] goes
 into detail on the lower-level git mechanisms involved in, for
 example, creating a new commit.
 
diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index d465aab..3d16e3d 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -392,7 +392,7 @@ see linkgit:git-pull[1] for details.
 
 Git can also be used in a CVS-like mode, with a central repository
 that various users push changes to; see linkgit:git-push[1] and
-linkgit:gitcvs-migration[7][git for CVS users].
+linkgit:gitcvs-migration[7].
 
 Exploring history
 -----------------
@@ -571,9 +571,9 @@ is based:
     used to create commits, check out working directories, and
     hold the various trees involved in a merge.
 
-linkgit:gittutorial-2[7][Part two of this tutorial] explains the object
+Part two of this tutorial explains the object
 database, the index file, and a few other odds and ends that you'll
-need to make the most of git.
+need to make the most of git. You can find it at linkgit:gittutorial-2[7].
 
 If you don't want to continue with that right away, a few other
 digressions that may be interesting at this point are:
@@ -592,7 +592,7 @@ digressions that may be interesting at this point are:
 
   * link:everyday.html[Everyday GIT with 20 Commands Or So]
 
-  * linkgit:gitcvs-migration[7][git for CVS users].
+  * linkgit:gitcvs-migration[7]: Git for CVS users.
 
 SEE ALSO
 --------
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 64a820b..ca4363f 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1879,8 +1879,7 @@ $ chmod a+x hooks/post-update
 -------------------------------------------------
 
 (For an explanation of the last two lines, see
-linkgit:git-update-server-info[1], and the documentation
-linkgit:githooks[5][Hooks used by git].)
+linkgit:git-update-server-info[1] and linkgit:githooks[5].)
 
 Advertise the URL of proj.git.  Anybody else should then be able to
 clone or pull from that URL, for example with a command line like:
@@ -1992,7 +1991,7 @@ the right to push to the same repository.  In that case, the correct
 solution is to retry the push after first updating your work by either a
 pull or a fetch followed by a rebase; see the
 <<setting-up-a-shared-repository,next section>> and
-linkgit:gitcvs-migration[7][git for CVS users] for more.
+linkgit:gitcvs-migration[7] for more.
 
 [[setting-up-a-shared-repository]]
 Setting up a shared repository
@@ -2001,7 +2000,7 @@ Setting up a shared repository
 Another way to collaborate is by using a model similar to that
 commonly used in CVS, where several developers with special rights
 all push to and pull from a single shared repository.  See
-linkgit:gitcvs-migration[7][git for CVS users] for instructions on how to
+linkgit:gitcvs-migration[7] for instructions on how to
 set this up.
 
 However, while there is nothing wrong with git's support for shared
-- 
1.5.5.GIT
