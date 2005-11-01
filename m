From: Jon Loeliger <jdl@freescale.com>
Subject: [PATCH] Remove 'Previously this command was known as ...' messages.
Date: Tue, 01 Nov 2005 14:22:22 -0600
Message-ID: <1130876541.1386.46.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Nov 01 21:22:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX2eK-00042m-Ma
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 21:22:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbVKAUWZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 15:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbVKAUWZ
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 15:22:25 -0500
Received: from az33egw01.freescale.net ([192.88.158.102]:55288 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1751119AbVKAUWY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2005 15:22:24 -0500
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id jA1KY4V0005426
	for <git@vger.kernel.org>; Tue, 1 Nov 2005 13:34:05 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id jA1KSI38009716
	for <git@vger.kernel.org>; Tue, 1 Nov 2005 14:28:18 -0600 (CST)
To: Git List <git@vger.kernel.org>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10951>

For a 1.0 release, there is no need to maintain the
historical "Previously this command was known as..."
information on the doc splash page.  It is noise;
command names should stand on their own now.

Signed-off-by: Jon Loeliger <jdl@freescale.com>
---

Right?


 Documentation/git.txt |   44
--------------------------------------------
 1 files changed, 0 insertions(+), 44 deletions(-)

bae42f2f93bcd41b5a389c31beeb49face0f6512
diff --git a/Documentation/git.txt b/Documentation/git.txt
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -60,7 +60,6 @@ gitlink:git-apply[1]::
 
 gitlink:git-checkout-index[1]::
 	Copy files from the cache to the working directory
-	Previously this command was known as git-checkout-cache.
 
 gitlink:git-commit-tree[1]::
 	Creates a new commit object
@@ -76,7 +75,6 @@ gitlink:git-init-db[1]::
 
 gitlink:git-merge-index[1]::
 	Runs a merge for files needing merging
-	Previously this command was known as git-merge-cache.
 
 gitlink:git-mktag[1]::
 	Creates a tag object
@@ -95,7 +93,6 @@ gitlink:git-unpack-objects[1]::
 
 gitlink:git-update-index[1]::
 	Modifies the index or directory cache
-	Previously this command was known as git-update-cache.
 
 gitlink:git-write-tree[1]::
 	Creates a tree from the current cache
@@ -109,7 +106,6 @@ gitlink:git-cat-file[1]::
 
 gitlink:git-diff-index[1]::
 	Compares content and mode of blobs between the cache and repository
-	Previously this command was known as git-diff-cache.
 
 gitlink:git-diff-files[1]::
 	Compares files in the working tree and the cache
@@ -122,7 +118,6 @@ gitlink:git-diff-tree[1]::
 
 gitlink:git-fsck-objects[1]::
 	Verifies the connectivity and validity of the objects in the database
-	Previously this command was known as git-fsck-cache.
 
 gitlink:git-ls-files[1]::
 	Information about files in the cache/working directory
@@ -170,11 +165,9 @@ gitlink:git-fetch-pack[1]::
 
 gitlink:git-http-fetch[1]::
 	Downloads a remote git repository via HTTP
-	Previously this command was known as git-http-pull.
 
 gitlink:git-local-fetch[1]::
 	Duplicates another git repository on a local system
-	Previously this command was known as git-local-pull.
 
 gitlink:git-peek-remote[1]::
 	Lists references on a remote repository using upload-pack protocol.
@@ -190,11 +183,9 @@ gitlink:git-shell[1]::
 
 gitlink:git-ssh-fetch[1]::
 	Pulls from a remote repository over ssh connection
-	Previously this command was known as git-ssh-pull.
 
 gitlink:git-ssh-upload[1]::
 	Helper "server-side" program used by git-ssh-fetch
-	Previously this command was known as git-ssh-push.
 
 gitlink:git-update-server-info[1]::
 	Updates auxiliary information on a dumb server to help
@@ -210,7 +201,6 @@ Porcelain-ish Commands
 
 gitlink:git-add[1]::
 	Add paths to the index file.
-	Previously this command was known as git-add-script.
 
 gitlink:git-am[1]::
 	Apply patches from a mailbox, but cooler.
@@ -220,50 +210,39 @@ gitlink:git-applymbox[1]::
 
 gitlink:git-bisect[1]::
 	Find the change that introduced a bug.
-	Previously this command was known as git-bisect-script.
 
 gitlink:git-branch[1]::
 	Create and Show branches.
-	Previously this command was known as git-branch-script.
 
 gitlink:git-checkout[1]::
 	Checkout and switch to a branch.
-	Previously this command was known as git-checkout-script.
 
 gitlink:git-cherry-pick[1]::
 	Cherry-pick the effect of an existing commit.
-	Previously this command was known as git-cherry-pick-script.
 
 gitlink:git-clone[1]::
 	Clones a repository into a new directory.
-	Previously this command was known as git-clone-script.
 
 gitlink:git-commit[1]::
 	Record changes to the repository.
-	Previously this command was known as git-commit-script.
 
 gitlink:git-diff[1]::
 	Show changes between commits, commit and working tree, etc.
-	Previously this command was known as git-diff-script.
 
 gitlink:git-fetch[1]::
 	Download from a remote repository via various protocols.
-	Previously this command was known as git-fetch-script.
 
 gitlink:git-format-patch[1]::
 	Prepare patches for e-mail submission.
-	Previously this command was known as git-format-patch-script.
 
 gitlink:git-grep[1]::
 	Print lines matching a pattern
 
 gitlink:git-log[1]::
 	Shows commit logs.
-	Previously this command was known as git-log-script.
 
 gitlink:git-ls-remote[1]::
 	Shows references in a remote or local repository.
-	Previously this command was known as git-ls-remote-script.
 
 gitlink:git-merge[1]::
 	Grand unified merge driver.
@@ -273,39 +252,30 @@ gitlink:git-mv[1]::
 
 gitlink:git-octopus[1]::
 	Merge more than two commits.
-	Previously this command was known as git-octopus-script.
 
 gitlink:git-pull[1]::
 	Fetch from and merge with a remote repository.
-	Previously this command was known as git-pull-script.
 
 gitlink:git-push[1]::
 	Update remote refs along with associated objects.
-	Previously this command was known as git-push-script.
 
 gitlink:git-rebase[1]::
 	Rebase local commits to new upstream head.
-	Previously this command was known as git-rebase-script.
 
 gitlink:git-rename[1]::
 	Rename files and directories.
-	Previously this command was known as git-rename-script.
 
 gitlink:git-repack[1]::
 	Pack unpacked objects in a repository.
-	Previously this command was known as git-repack-script.
 
 gitlink:git-reset[1]::
 	Reset current HEAD to the specified state.
-	Previously this command was known as git-reset-script.
 
 gitlink:git-resolve[1]::
 	Merge two commits.
-	Previously this command was known as git-resolve-script.
 
 gitlink:git-revert[1]::
 	Revert an existing commit.
-	Previously this command was known as git-revert-script.
 
 gitlink:git-shortlog[1]::
 	Summarizes 'git log' output.
@@ -315,11 +285,9 @@ gitlink:git-show-branch[1]::
 
 gitlink:git-status[1]::
 	Shows the working tree status.
-	Previously this command was known as git-status-script.
 
 gitlink:git-verify-tag[1]::
 	Check the GPG signature of tag.
-	Previously this command was known as git-verify-tag-script.
 
 gitlink:git-whatchanged[1]::
 	Shows commit logs and differences they introduce.
@@ -334,41 +302,33 @@ gitlink:git-applypatch[1]::
 
 gitlink:git-archimport[1]::
 	Import an arch repository into git.
-	Previously this command was known as git-archimport-script.
 
 gitlink:git-convert-objects[1]::
 	Converts old-style git repository
-	Previously this command was known as git-convert-cache.
 
 gitlink:git-cvsimport[1]::
 	Salvage your data out of another SCM people love to hate.
-	Previously this command was known as git-cvsimport-script.
 
 gitlink:git-merge-one-file[1]::
 	The standard helper program to use with "git-merge-index"
-	Previously this command was known as git-merge-one-file-script.
 
 gitlink:git-prune[1]::
 	Prunes all unreachable objects from the object database
-	Previously this command was known as git-prune-script.
 
 gitlink:git-relink[1]::
 	Hardlink common objects in local repositories.
-	Previously this command was known as git-relink-script.
 
 gitlink:git-svnimport[1]::
 	Import a SVN repository into git.
 
 gitlink:git-sh-setup[1]::
 	Common git shell script setup code.
-	Previously this command was known as git-sh-setup-script.
 
 gitlink:git-symbolic-ref[1]::
 	Read and modify symbolic refs
 
 gitlink:git-tag[1]::
 	An example script to create a tag object signed with GPG
-	Previously this command was known as git-tag-script.
 
 gitlink:git-update-ref[1]::
 	Update the object name stored in a ref safely.
@@ -384,7 +344,6 @@ gitlink:git-cherry[1]::
 
 gitlink:git-count-objects[1]::
 	Count unpacked number of objects and their disk consumption.
-	Previously this command was known as git-count-objects-script.
 
 gitlink:git-daemon[1]::
 	A really simple server for git repositories.
@@ -403,18 +362,15 @@ gitlink:git-patch-id[1]::
 
 gitlink:git-parse-remote[1]::
 	Routines to help parsing $GIT_DIR/remotes/
-	Previously this command was known as git-parse-remote-script.
 
 gitlink:git-request-pull[1]::
 	git-request-pull.
-	Previously this command was known as git-request-pull-script.
 
 gitlink:git-rev-parse[1]::
 	Pick out and massage parameters.
 
 gitlink:git-send-email[1]::
 	Send patch e-mails out of "format-patch --mbox" output.
-	Previously this command was known as git-send-email-script.
 
 gitlink:git-symbolic-refs[1]::
 	Read and modify symbolic refs.
