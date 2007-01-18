From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] Documentation: revisit command qualification in git.txt
Date: Thu, 18 Jan 2007 17:25:41 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701181713200.2577@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 18 23:25:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7fha-0001BI-3q
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 23:25:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932636AbXARWZo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 17:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932648AbXARWZo
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 17:25:44 -0500
Received: from relais.videotron.ca ([24.201.245.36]:55397 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932636AbXARWZn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 17:25:43 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JC300DDL4YT5530@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 18 Jan 2007 17:25:42 -0500 (EST)
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37142>

In particular, the "Main porcelain commands" section should focus on the 
minimum subset of obvious commands an average user is likely to ever 
need.

Commands that are not useful on their own should definitely be in the 
plumbing section.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
diff --git a/Documentation/git.txt b/Documentation/git.txt
index a0bcef7..db83b69 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -102,9 +102,6 @@ gitlink:git-branch[1]::
 gitlink:git-checkout[1]::
 	Checkout and switch to a branch.
 
-gitlink:git-cherry-pick[1]::
-	Cherry-pick the effect of an existing commit.
-
 gitlink:git-clean[1]::
 	Remove untracked files from the working tree.
 
@@ -123,27 +120,28 @@ gitlink:git-fetch[1]::
 gitlink:git-format-patch[1]::
 	Prepare patches for e-mail submission.
 
+gitlink:git-gc[1]::
+	Cleanup unnecessary files and optimize the local repository.
+
 gitlink:git-grep[1]::
 	Print lines matching a pattern.
 
+gitlink:git-init[1]::
+	Creates an empty git repository, or reinitialize an
+	existing one.
+
 gitlink:gitk[1]::
 	The git repository browser.
 
 gitlink:git-log[1]::
 	Shows commit logs.
 
-gitlink:git-ls-remote[1]::
-	Shows references in a remote or local repository.
-
 gitlink:git-merge[1]::
 	Grand unified merge driver.
 
 gitlink:git-mv[1]::
 	Move or rename a file, a directory, or a symlink.
 
-gitlink:git-pack-refs[1]::
-	Pack heads and tags for efficient repository access.
-
 gitlink:git-pull[1]::
 	Fetch from and merge with a remote repository or a local branch.
 
@@ -153,9 +151,6 @@ gitlink:git-push[1]::
 gitlink:git-rebase[1]::
 	Rebase local commits to the updated upstream head.
 
-gitlink:git-repack[1]::
-	Pack unpacked objects in a repository.
-
 gitlink:git-rerere[1]::
 	Reuse recorded resolution of conflicted merges.
 
@@ -177,14 +172,11 @@ gitlink:git-shortlog[1]::
 gitlink:git-show[1]::
 	Show one commit log and its diff.
 
-gitlink:git-show-branch[1]::
-	Show branches and their commits.
-
 gitlink:git-status[1]::
 	Shows the working tree status.
 
-gitlink:git-verify-tag[1]::
-	Check the GPG signature of tag.
+gitlink:git-tag[1]::
+	Create or verify a tag object signed with GPG.
 
 gitlink:git-whatchanged[1]::
 	Shows commit logs and differences they introduce.
@@ -192,6 +184,7 @@ gitlink:git-whatchanged[1]::
 
 Ancillary Commands
 ~~~~~~~~~~~~~~~~~~
+
 Manipulators:
 
 gitlink:git-applypatch[1]::
@@ -200,6 +193,9 @@ gitlink:git-applypatch[1]::
 gitlink:git-archimport[1]::
 	Import an arch repository into git.
 
+gitlink:git-cherry-pick[1]::
+	Cherry-pick the effect of an existing commit.
+
 gitlink:git-convert-objects[1]::
 	Converts old-style git repository.
 
@@ -212,18 +208,18 @@ gitlink:git-cvsexportcommit[1]::
 gitlink:git-cvsserver[1]::
 	A CVS server emulator for git.
 
-gitlink:git-gc[1]::
-	Cleanup unnecessary files and optimize the local repository.
-
 gitlink:git-lost-found[1]::
 	Recover lost refs that luckily have not yet been pruned.
 
-gitlink:git-merge-one-file[1]::
-	The standard helper program to use with `git-merge-index`.
+gitlink:git-pack-refs[1]::
+	Pack heads and tags for efficient repository access.
 
 gitlink:git-prune[1]::
 	Prunes all unreachable objects from the object database.
 
+gitlink:git-repack[1]::
+	Pack unpacked objects in a repository.
+
 gitlink:git-quiltimport[1]::
 	Applies a quilt patchset onto the current branch.
 
@@ -239,18 +235,6 @@ gitlink:git-svn[1]::
 gitlink:git-svnimport[1]::
 	Import a SVN repository into git.
 
-gitlink:git-sh-setup[1]::
-	Common git shell script setup code.
-
-gitlink:git-symbolic-ref[1]::
-	Read and modify symbolic refs.
-
-gitlink:git-tag[1]::
-	Create or verify a tag object signed with GPG.
-
-gitlink:git-update-ref[1]::
-	Update the object name stored in a ref safely.
-
 
 Interrogators:
 
@@ -260,20 +244,14 @@ gitlink:git-annotate[1]::
 gitlink:git-blame[1]::
 	Find out where each line in a file came from.
 
-gitlink:git-check-ref-format[1]::
-	Make sure ref name is well formed.
-
 gitlink:git-cherry[1]::
 	Find commits not merged upstream.
 
-gitlink:git-count-objects[1]::
-	Count unpacked number of objects and their disk consumption.
-
-gitlink:git-daemon[1]::
-	A really simple server for git repositories.
+gitlink:git-describe[1]::
+	Show the most recent tag that is reachable from a commit.
 
-gitlink:git-fmt-merge-msg[1]::
-	Produce a merge commit message.
+gitlink:git-fsck-objects[1]::
+	Verifies the connectivity and validity of the objects in the database.
 
 gitlink:git-get-tar-commit-id[1]::
 	Extract commit ID from an archive created using git-tar-tree.
@@ -284,6 +262,9 @@ gitlink:git-imap-send[1]::
 gitlink:git-instaweb[1]::
 	Instantly browse your working repository in gitweb.
 
+gitlink:git-ls-remote[1]::
+	Shows references in a remote or local repository.
+
 gitlink:git-mailinfo[1]::
 	Extracts patch and authorship information from a single
 	e-mail message, optionally transliterating the commit
@@ -296,29 +277,17 @@ gitlink:git-mailsplit[1]::
 gitlink:git-merge-tree[1]::
 	Show three-way merge without touching index.
 
-gitlink:git-patch-id[1]::
-	Compute unique ID for a patch.
-
-gitlink:git-parse-remote[1]::
-	Routines to help parsing `$GIT_DIR/remotes/` files.
-
 gitlink:git-request-pull[1]::
 	git-request-pull.
 
-gitlink:git-rev-parse[1]::
-	Pick out and massage parameters.
-
-gitlink:git-runstatus[1]::
-	A helper for git-status and git-commit.
-
 gitlink:git-send-email[1]::
 	Send patch e-mails out of "format-patch --mbox" output.
 
-gitlink:git-symbolic-ref[1]::
-	Read and modify symbolic refs.
+gitlink:git-show-branch[1]::
+	Show branches and their commits.
 
-gitlink:git-stripspace[1]::
-	Filter out empty lines.
+gitlink:git-verify-tag[1]::
+	Check the GPG signature of tag.
 
 
 Low-level commands (plumbing)
@@ -337,6 +306,7 @@ repositories.
 
 Manipulation commands
 ~~~~~~~~~~~~~~~~~~~~~
+
 gitlink:git-apply[1]::
 	Reads a "diff -up1" or git generated patch file and
 	applies it to the working tree.
@@ -353,16 +323,15 @@ gitlink:git-hash-object[1]::
 gitlink:git-index-pack[1]::
 	Build pack idx file for an existing packed archive.
 
-gitlink:git-init[1]::
-	Creates an empty git repository, or reinitialize an
-	existing one.
-
 gitlink:git-merge-file[1]::
 	Runs a threeway merge.
 
 gitlink:git-merge-index[1]::
 	Runs a merge for files needing merging.
 
+gitlink:git-merge-one-file[1]::
+	The standard helper program to use with `git-merge-index`.
+
 gitlink:git-mktag[1]::
 	Creates a tag object.
 
@@ -381,12 +350,24 @@ gitlink:git-read-tree[1]::
 gitlink:git-repo-config[1]::
 	Get and set options in .git/config.
 
+gitlink:git-sh-setup[1]::
+	Common git shell script setup code.
+
+gitlink:git-stripspace[1]::
+	Filter out empty lines.
+
+gitlink:git-symbolic-ref[1]::
+	Read and modify symbolic refs.
+
 gitlink:git-unpack-objects[1]::
 	Unpacks objects out of a packed archive.
 
 gitlink:git-update-index[1]::
 	Registers files in the working tree to the index.
 
+gitlink:git-update-ref[1]::
+	Update the object name stored in a ref safely.
+
 gitlink:git-write-tree[1]::
 	Creates a tree from the index.
 
@@ -397,8 +378,11 @@ Interrogation commands
 gitlink:git-cat-file[1]::
 	Provide content or type/size information for repository objects.
 
-gitlink:git-describe[1]::
-	Show the most recent tag that is reachable from a commit.
+gitlink:git-check-ref-format[1]::
+	Make sure ref name is well formed.
+
+gitlink:git-count-objects[1]::
+	Count unpacked number of objects and their disk consumption.
 
 gitlink:git-diff-index[1]::
 	Compares content and mode of blobs between the index and repository.
@@ -415,8 +399,8 @@ gitlink:git-diff-tree[1]::
 gitlink:git-for-each-ref[1]::
 	Output information on each ref.
 
-gitlink:git-fsck-objects[1]::
-	Verifies the connectivity and validity of the objects in the database.
+gitlink:git-fmt-merge-msg[1]::
+	Produce a merge commit message.
 
 gitlink:git-ls-files[1]::
 	Information about files in the index and the working tree.
@@ -433,9 +417,18 @@ gitlink:git-name-rev[1]::
 gitlink:git-pack-redundant[1]::
 	Find redundant pack files.
 
+gitlink:git-patch-id[1]::
+	Compute unique ID for a patch.
+
 gitlink:git-rev-list[1]::
 	Lists commit objects in reverse chronological order.
 
+gitlink:git-rev-parse[1]::
+	Pick out and massage parameters.
+
+gitlink:git-runstatus[1]::
+	A helper for git-status and git-commit.
+
 gitlink:git-show-index[1]::
 	Displays contents of a pack idx file.
 
@@ -461,6 +454,9 @@ the working tree.
 Synching repositories
 ~~~~~~~~~~~~~~~~~~~~~
 
+gitlink:git-daemon[1]::
+	A really simple server for git repositories.
+
 gitlink:git-fetch-pack[1]::
 	Updates from a remote repository (engine for ssh and
 	local transport).
@@ -473,6 +469,9 @@ gitlink:git-local-fetch[1]::
 	Duplicates another git repository on a local system by
 	walking commit chain.
 
+gitlink:git-parse-remote[1]::
+	Routines to help parsing `$GIT_DIR/remotes/` files.
+
 gitlink:git-peek-remote[1]::
 	Lists references on a remote repository using
 	upload-pack protocol (engine for ssh and local
