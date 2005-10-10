From: Christian Meder <chris@absolutegiganten.org>
Subject: [PATCH] Convert usage of GIT and Git into git
Date: Mon, 10 Oct 2005 23:26:31 +0200
Message-ID: <1128979592.7097.38.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Oct 10 23:28:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EP5BI-00080Y-8W
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 23:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbVJJV1d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 17:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbVJJV1d
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 17:27:33 -0400
Received: from a15181680.alturo-server.de ([217.160.108.75]:8403 "EHLO
	a15181680.alturo-server.de") by vger.kernel.org with ESMTP
	id S1751256AbVJJV1c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2005 17:27:32 -0400
Received: from p54a21cce.dip0.t-ipconnect.de ([84.162.28.206] helo=localhost)
	by a15181680.alturo-server.de with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.52)
	id 1EP5BD-00066f-1o
	for git@vger.kernel.org; Mon, 10 Oct 2005 23:27:31 +0200
Received: from chris by localhost with local (Exim 4.52)
	id 1EP5AG-00027m-CY
	for git@vger.kernel.org; Mon, 10 Oct 2005 23:26:32 +0200
To: git@vger.kernel.org
X-Mailer: Evolution 2.2.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9940>

Convert usage of GIT and Git into git.

Signed-off-by: Christian Meder <chris@absolutegiganten.org>

---

 Documentation/cvs-migration.txt       |   14 +++++++-------
 Documentation/diff-format.txt         |    2 +-
 Documentation/diffcore.txt            |    2 +-
 Documentation/git-apply.txt           |    2 +-
 Documentation/git-archimport.txt      |    8 ++++----
 Documentation/git-clone-pack.txt      |    2 +-
 Documentation/git-convert-objects.txt |    4 ++--
 Documentation/git-cvsimport.txt       |    4 ++--
 Documentation/git-daemon.txt          |    2 +-
 Documentation/git-fetch-pack.txt      |    2 +-
 Documentation/git-fsck-objects.txt    |   10 +++++-----
 Documentation/git-http-fetch.txt      |    4 ++--
 Documentation/git-local-fetch.txt     |    4 ++--
 Documentation/git-pack-objects.txt    |    2 +-
 Documentation/git-peek-remote.txt     |    2 +-
 Documentation/git-rev-parse.txt       |    2 +-
 Documentation/git-show-index.txt      |    2 +-
 Documentation/git-verify-pack.txt     |    4 ++--
 Documentation/git.txt                 |   10 +++++-----
 Documentation/glossary.txt            |    2 +-
 Documentation/hooks.txt               |    2 +-
 Documentation/pull-fetch-param.txt    |    2 +-
 Documentation/repository-layout.txt   |    4 ++--
 Documentation/tutorial.txt            |   18 +++++++++---------
 24 files changed, 55 insertions(+), 55 deletions(-)

2cfc19a4c9c2d66b642b0968df917938d182fd20
diff --git a/Documentation/cvs-migration.txt b/Documentation/cvs-migration.txt
--- a/Documentation/cvs-migration.txt
+++ b/Documentation/cvs-migration.txt
@@ -1,4 +1,4 @@
-Git for CVS users
+git for CVS users
 =================
 
 Ok, so you're a CVS user. That's ok, it's a treatable condition, and the
@@ -7,7 +7,7 @@ you are reading this file means that you
 already.
 
 The thing about CVS is that it absolutely sucks as a source control
-manager, and you'll thus be happy with almost anything else. Git,
+manager, and you'll thus be happy with almost anything else. git,
 however, may be a bit 'too' different (read: "good") for your taste, and
 does a lot of things differently. 
 
@@ -15,7 +15,7 @@ One particular suckage of CVS is very ha
 basically a tool for tracking 'file' history, while git is a tool for
 tracking 'project' history.  This sometimes causes problems if you are
 used to doing very strange things in CVS, in particular if you're doing
-things like making branches of just a subset of the project.  Git can't
+things like making branches of just a subset of the project.  git can't
 track that, since git never tracks things on the level of an individual
 file, only on the whole project level. 
 
@@ -32,7 +32,7 @@ and notes on converting from CVS to git.
 
 Second: CVS has the notion of a "repository" as opposed to the thing
 that you're actually working in (your working directory, or your
-"checked out tree").  Git does not have that notion at all, and all git
+"checked out tree").  git does not have that notion at all, and all git
 working directories 'are' the repositories.  However, you can easily
 emulate the CVS model by having one special "global repository", which
 people can synchronize with.  See details later, but in the meantime
@@ -49,7 +49,7 @@ gone through the git tutorial, and gener
 how to commit stuff etc in git) is to create a git'ified version of your
 CVS archive.
 
-Happily, that's very easy indeed. Git will do it for you, although git
+Happily, that's very easy indeed. git will do it for you, although git
 will need the help of a program called "cvsps":
 
 	http://www.cobite.com/cvsps/
@@ -135,7 +135,7 @@ technically possible, and there are at l
 there that can be used to get equivalent information (see the git
 mailing list archives for details). 
 
-Git has a couple of alternatives, though, that you may find sufficient
+git has a couple of alternatives, though, that you may find sufficient
 or even superior depending on your use.  One is called "git-whatchanged"
 (for obvious reasons) and the other one is called "pickaxe" ("a tool for
 the software archeologist"). 
@@ -208,7 +208,7 @@ show anything for commits that do not to
 Also, in the original context, the same statement might have
 appeared at first in a different file and later the file was
 renamed to "a-file.c".  CVS annotate would not help you to go
-back across such a rename, but GIT would still help you in such
+back across such a rename, but git would still help you in such
 a situation.  For that, you can give the -C flag to
 git-diff-tree, like this:
 
diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -106,7 +106,7 @@ For a path that is unmerged, 'GIT_EXTERN
 parameter, <path>.
 
 
-Git specific extension to diff format
+git specific extension to diff format
 -------------------------------------
 
 What -p option produces is slightly different from the
diff --git a/Documentation/diffcore.txt b/Documentation/diffcore.txt
--- a/Documentation/diffcore.txt
+++ b/Documentation/diffcore.txt
@@ -250,7 +250,7 @@ pattern.  Filepairs that match a glob pa
 in the file are output before ones that match a later line, and
 filepairs that do not match any glob pattern are output last.
 
-As an example, typical orderfile for the core GIT probably
+As an example, typical orderfile for the core git probably
 would look like this:
 
 ------------------------------------------------
diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -3,7 +3,7 @@ git-apply(1)
 
 NAME
 ----
-git-apply - Apply patch on a GIT index file and a work tree
+git-apply - Apply patch on a git index file and a work tree
 
 
 SYNOPSIS
diff --git a/Documentation/git-archimport.txt b/Documentation/git-archimport.txt
--- a/Documentation/git-archimport.txt
+++ b/Documentation/git-archimport.txt
@@ -3,7 +3,7 @@ git-archimport(1)
 
 NAME
 ----
-git-archimport - Import an Arch repository into GIT
+git-archimport - Import an Arch repository into git 
 
 
 SYNOPSIS
@@ -40,14 +40,14 @@ incremental imports.
 
 MERGES
 ------
-Patch merge data from Arch is used to mark merges in GIT as well. GIT 
+Patch merge data from Arch is used to mark merges in git as well. git 
 does not care much about tracking patches, and only considers a merge when a
 branch incorporates all the commits since the point they forked. The end result
-is that GIT will have a good idea of how far branches have diverged. So the 
+is that git will have a good idea of how far branches have diverged. So the 
 import process does lose some patch-trading metadata.
 
 Fortunately, when you try and merge branches imported from Arch, 
-GIT will find a good merge base, and it has a good chance of identifying 
+git will find a good merge base, and it has a good chance of identifying 
 patches that have been traded out-of-sequence between the branches. 
 
 OPTIONS
diff --git a/Documentation/git-clone-pack.txt b/Documentation/git-clone-pack.txt
--- a/Documentation/git-clone-pack.txt
+++ b/Documentation/git-clone-pack.txt
@@ -28,7 +28,7 @@ OPTIONS
 	remote side, if it is not found on your $PATH.
 	Installations of sshd ignore the user's environment
 	setup scripts for login shells (e.g. .bash_profile) and
-	your privately installed GIT may not be found on the system
+	your privately installed git may not be found on the system
 	default $PATH.  Another workaround suggested is to set
 	up your $PATH in ".bashrc", but this flag is for people
 	who do not want to pay the overhead for non-interactive
diff --git a/Documentation/git-convert-objects.txt b/Documentation/git-convert-objects.txt
--- a/Documentation/git-convert-objects.txt
+++ b/Documentation/git-convert-objects.txt
@@ -3,7 +3,7 @@ git-convert-objects(1)
 
 NAME
 ----
-git-convert-objects - Converts old-style GIT repository
+git-convert-objects - Converts old-style git repository
 
 
 SYNOPSIS
@@ -12,7 +12,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Converts old-style GIT repository to the latest format
+Converts old-style git repository to the latest format
 
 
 Author
diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 'git-cvsimport' [ -o <branch-for-HEAD> ] [ -h ] [ -v ]
 			[ -d <CVSROOT> ] [ -p <options-for-cvsps> ]
-			[ -C <GIT_repository> ] [ -i ] [ -k ]
+			[ -C <git_repository> ] [ -i ] [ -k ]
 			[ -s <subst> ] [ -m ] [ -M regex ] [ <CVS_module> ]
 
 
@@ -30,7 +30,7 @@ OPTIONS
 	are supported.
 
 -C <target-dir>::
-        The GIT repository to import to.  If the directory doesn't
+        The git repository to import to.  If the directory doesn't
         exist, it will be created.  Default is the current directory.
 
 -i::
diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -3,7 +3,7 @@ git-daemon(1)
 
 NAME
 ----
-git-daemon - A really simple server for GIT repositories.
+git-daemon - A really simple server for git repositories.
 
 SYNOPSIS
 --------
diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -34,7 +34,7 @@ OPTIONS
 	remote side, if is not found on your $PATH.
 	Installations of sshd ignores the user's environment
 	setup scripts for login shells (e.g. .bash_profile) and
-	your privately installed GIT may not be found on the system
+	your privately installed git may not be found on the system
 	default $PATH.  Another workaround suggested is to set
 	up your $PATH in ".bashrc", but this flag is for people
 	who do not want to pay the overhead for non-interactive
diff --git a/Documentation/git-fsck-objects.txt b/Documentation/git-fsck-objects.txt
--- a/Documentation/git-fsck-objects.txt
+++ b/Documentation/git-fsck-objects.txt
@@ -41,22 +41,22 @@ index file and all SHA1 references in .g
 	($GIT_DIR/objects), making sure that it is consistent and
 	complete without referring to objects found in alternate
 	object pools listed in GIT_ALTERNATE_OBJECT_DIRECTORIES,
-	nor packed GIT archives found in $GIT_DIR/objects/pack;
+	nor packed git archives found in $GIT_DIR/objects/pack;
 	cannot be used with --full.
 
 --full::
 	Check not just objects in GIT_OBJECT_DIRECTORY
 	($GIT_DIR/objects), but also the ones found in alternate
 	object pools listed in GIT_ALTERNATE_OBJECT_DIRECTORIES,
-	and in packed GIT archives found in $GIT_DIR/objects/pack
+	and in packed git archives found in $GIT_DIR/objects/pack
 	and corresponding pack subdirectories in alternate
 	object pools; cannot be used with --standalone.
 
 --strict::
 	Enable more strict checking, namely to catch a file mode
 	recorded with g+w bit set, which was created by older
-	versions of GIT.  Existing repositories, including the
-	Linux kernel, GIT itself, and sparse repository have old
+	versions of git.  Existing repositories, including the
+	Linux kernel, git itself, and sparse repository have old
 	objects that triggers this check, but it is recommended
 	to check new projects with this flag.
 
@@ -80,7 +80,7 @@ Any corrupt objects you will have to fin
 the hopes that somebody else has the object you have corrupted).
 
 Of course, "valid tree" doesn't mean that it wasn't generated by some
-evil person, and the end result might be crap. Git is a revision
+evil person, and the end result might be crap. git is a revision
 tracking system, not a quality assurance system ;)
 
 Extracted Diagnostics
diff --git a/Documentation/git-http-fetch.txt b/Documentation/git-http-fetch.txt
--- a/Documentation/git-http-fetch.txt
+++ b/Documentation/git-http-fetch.txt
@@ -3,7 +3,7 @@ git-http-fetch(1)
 
 NAME
 ----
-git-http-fetch - Downloads a remote GIT repository via HTTP
+git-http-fetch - Downloads a remote git repository via HTTP
 
 
 SYNOPSIS
@@ -12,7 +12,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Downloads a remote GIT repository via HTTP.
+Downloads a remote git repository via HTTP.
 
 -c::
 	Get the commit objects.
diff --git a/Documentation/git-local-fetch.txt b/Documentation/git-local-fetch.txt
--- a/Documentation/git-local-fetch.txt
+++ b/Documentation/git-local-fetch.txt
@@ -3,7 +3,7 @@ git-local-fetch(1)
 
 NAME
 ----
-git-local-fetch - Duplicates another GIT repository on a local system
+git-local-fetch - Duplicates another git repository on a local system
 
 
 SYNOPSIS
@@ -12,7 +12,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Duplicates another GIT repository on a local system.
+Duplicates another git repository on a local system.
 
 OPTIONS
 -------
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -30,7 +30,7 @@ transport by their peers.
 
 Placing both in the pack/ subdirectory of $GIT_OBJECT_DIRECTORY (or
 any of the directories on $GIT_ALTERNATE_OBJECT_DIRECTORIES)
-enables GIT to read from such an archive.
+enables git to read from such an archive.
 
 
 OPTIONS
diff --git a/Documentation/git-peek-remote.txt b/Documentation/git-peek-remote.txt
--- a/Documentation/git-peek-remote.txt
+++ b/Documentation/git-peek-remote.txt
@@ -22,7 +22,7 @@ OPTIONS
 	remote side, if it is not found on your $PATH. Some
 	installations of sshd ignores the user's environment
 	setup scripts for login shells (e.g. .bash_profile) and
-	your privately installed GIT may not be found on the system
+	your privately installed git may not be found on the system
 	default $PATH.  Another workaround suggested is to set
 	up your $PATH in ".bashrc", but this flag is for people
 	who do not want to pay the overhead for non-interactive
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -91,7 +91,7 @@ what is called an 'extended SHA1' syntax
 * A symbolic ref name.  E.g. 'master' typically means the commit
   object referenced by $GIT_DIR/refs/heads/master.  If you
   happen to have both heads/master and tags/master, you can
-  explicitly say 'heads/master' to tell GIT which one you mean.
+  explicitly say 'heads/master' to tell git which one you mean.
 
 * A suffix '^' to a revision parameter means the first parent of
   that commit object.  '^<n>' means the <n>th parent (i.e.
diff --git a/Documentation/git-show-index.txt b/Documentation/git-show-index.txt
--- a/Documentation/git-show-index.txt
+++ b/Documentation/git-show-index.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Reads given idx file for packed GIT archive created with
+Reads given idx file for packed git archive created with
 git-pack-objects command, and dumps its contents.
 
 The information it outputs is subset of what you can get from
diff --git a/Documentation/git-verify-pack.txt b/Documentation/git-verify-pack.txt
--- a/Documentation/git-verify-pack.txt
+++ b/Documentation/git-verify-pack.txt
@@ -3,7 +3,7 @@ git-verify-pack(1)
 
 NAME
 ----
-git-verify-pack - Validate packed GIT archive files.
+git-verify-pack - Validate packed git archive files.
 
 
 SYNOPSIS
@@ -13,7 +13,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Reads given idx file for packed GIT archive created with
+Reads given idx file for packed git archive created with
 git-pack-objects command and verifies idx file and the
 corresponding pack file.
 
diff --git a/Documentation/git.txt b/Documentation/git.txt
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -146,7 +146,7 @@ gitlink:git-var[1]::
 	Displays a git logical variable
 
 gitlink:git-verify-pack[1]::
-	Validates packed GIT archive files
+	Validates packed git archive files
 
 The interrogate commands may create files - and you can force them to
 touch the working file set - but in general they don't
@@ -163,11 +163,11 @@ gitlink:git-fetch-pack[1]::
 	Updates from a remote repository.
 
 gitlink:git-http-fetch[1]::
-	Downloads a remote GIT repository via HTTP
+	Downloads a remote git repository via HTTP
 	Previously this command was known as git-http-pull.
 
 gitlink:git-local-fetch[1]::
-	Duplicates another GIT repository on a local system
+	Duplicates another git repository on a local system
 	Previously this command was known as git-local-pull.
 
 gitlink:git-peek-remote[1]::
@@ -322,7 +322,7 @@ gitlink:git-archimport[1]::
 	Previously this command was known as git-archimport-script.
 
 gitlink:git-convert-objects[1]::
-	Converts old-style GIT repository
+	Converts old-style git repository
 	Previously this command was known as git-convert-cache.
 
 gitlink:git-cvsimport[1]::
@@ -360,7 +360,7 @@ gitlink:git-count-objects[1]::
 	Previously this command was known as git-count-objects-script.
 
 gitlink:git-daemon[1]::
-	A really simple server for GIT repositories.
+	A really simple server for git repositories.
 
 gitlink:git-get-tar-commit-id[1]::
 	Extract commit ID from an archive created using git-tar-tree.
diff --git a/Documentation/glossary.txt b/Documentation/glossary.txt
--- a/Documentation/glossary.txt
+++ b/Documentation/glossary.txt
@@ -1,5 +1,5 @@
 object::
-	The unit of storage in GIT. It is uniquely identified by
+	The unit of storage in git. It is uniquely identified by
 	the SHA1 of its contents. Consequently, an object can not
 	be changed.
 
diff --git a/Documentation/hooks.txt b/Documentation/hooks.txt
--- a/Documentation/hooks.txt
+++ b/Documentation/hooks.txt
@@ -1,4 +1,4 @@
-Hooks used by GIT
+Hooks used by git
 =================
 
 Hooks are little scripts you can place in `$GIT_DIR/hooks`
diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -6,7 +6,7 @@
 ===============================================================
 - Rsync URL:		rsync://remote.machine/path/to/repo.git/
 - HTTP(s) URL:		http://remote.machine/path/to/repo.git/
-- GIT URL:		git://remote.machine/path/to/repo.git/
+- git URL:		git://remote.machine/path/to/repo.git/
 			or remote.machine:/path/to/repo.git/
 - Local directory:	/path/to/repo.git/
 ===============================================================
diff --git a/Documentation/repository-layout.txt b/Documentation/repository-layout.txt
--- a/Documentation/repository-layout.txt
+++ b/Documentation/repository-layout.txt
@@ -1,4 +1,4 @@
-GIT repository layout
+git repository layout
 =====================
 
 You may find these things in your git repository (`.git`
@@ -119,7 +119,7 @@ info/grafts::
 info/exclude::
 	This file, by convention among Porcelains, stores the
 	exclude pattern list.  `git status` looks at it, but
-	otherwise it is not looked at by any of the core GIT
+	otherwise it is not looked at by any of the core git
 	commands.
 
 remotes::
diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -160,7 +160,7 @@ you'll have to use the object name, not 
 	git-cat-file -t 557db03de997c86a4a028e1ebd3a1ceb225be238
 
 where the `-t` tells `git-cat-file` to tell you what the "type" of the
-object is. Git will tell you that you have a "blob" object (ie just a
+object is. git will tell you that you have a "blob" object (ie just a
 regular file), and you can see the contents with
 
 	git-cat-file "blob" 557db03
@@ -377,7 +377,7 @@ come from the working tree or not.
 
 This is not hard to understand, as soon as you realize that git simply
 never knows (or cares) about files that it is not told about
-explicitly. Git will never go *looking* for files to compare, it
+explicitly. git will never go *looking* for files to compare, it
 expects you to tell it what the files are, and that's what the index
 is there for.
 ================
@@ -543,7 +543,7 @@ name for the state at that point.
 Copying repositories
 --------------------
 
-Git repositories are normally totally self-sufficient, and it's worth noting
+git repositories are normally totally self-sufficient, and it's worth noting
 that unlike CVS, for example, there is no separate notion of
 "repository" and "working tree". A git repository normally *is* the
 working tree, with the local git information hidden in the `.git`
@@ -950,7 +950,7 @@ This transport is the same as SSH transp
 both ends on the local machine instead of running other end on
 the remote machine via `ssh`.
 
-GIT Native::
+git Native::
 	`git://remote.machine/path/to/repo.git/`
 +
 This transport was designed for anonymous downloading.  Like SSH
@@ -971,13 +971,13 @@ necessary objects.  Because of this beha
 sometimes also called 'commit walkers'.
 +
 The 'commit walkers' are sometimes also called 'dumb
-transports', because they do not require any GIT aware smart
-server like GIT Native transport does.  Any stock HTTP server
+transports', because they do not require any git aware smart
+server like git Native transport does.  Any stock HTTP server
 would suffice.
 +
 There are (confusingly enough) `git-ssh-fetch` and `git-ssh-upload`
 programs, which are 'commit walkers'; they outlived their
-usefulness when GIT Native and SSH transports were introduced,
+usefulness when git Native and SSH transports were introduced,
 and not used by `git pull` or `git push` scripts.
 
 Once you fetch from the remote repository, you `resolve` that
@@ -1081,7 +1081,7 @@ done only once.
 on the remote machine. The communication between the two over
 the network internally uses an SSH connection.
 
-Your private repository's GIT directory is usually `.git`, but
+Your private repository's git directory is usually `.git`, but
 your public repository is often named after the project name,
 i.e. `<project>.git`. Let's create such a public repository for
 project `my-git`. After logging into the remote machine, create
@@ -1089,7 +1089,7 @@ an empty directory:
 
 	mkdir my-git.git
 
-Then, make that directory into a GIT repository by running
+Then, make that directory into a git repository by running
 `git init-db`, but this time, since its name is not the usual
 `.git`, we do things slightly differently:
 
