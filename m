From: David Greaves <david@dgreaves.com>
Subject: [PATCH 2/2] core-git documentation update
Date: Sun, 08 May 2005 18:22:48 +0100
Message-ID: <427E4AE8.4020407@dgreaves.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060705060408090209050609"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 19:20:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUpRi-0006uP-NG
	for gcvg-git@gmane.org; Sun, 08 May 2005 19:20:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262900AbVEHR1B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 13:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262903AbVEHR1B
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 13:27:01 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:37512 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S262900AbVEHRXI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2005 13:23:08 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 76408E6A8B; Sun,  8 May 2005 18:22:10 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 12446-13; Sun,  8 May 2005 18:22:10 +0100 (BST)
Received: from oak.dgreaves.com (modem-2142.leopard.dialup.pol.co.uk [217.135.152.94])
	by mail.ukfsn.org (Postfix) with ESMTP
	id C87A0E6D53; Sun,  8 May 2005 18:21:55 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DUpUP-0005jp-Ic; Sun, 08 May 2005 18:22:49 +0100
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>, Junio C Hamano <junkio@cox.net>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------060705060408090209050609
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Reformat core-git.txt to asciidoc format.
Includes split-docs.pl to create individual txt, html and man pages.

Signed-off-by: David Greaves <david@dgreaves.com>
---

--------------060705060408090209050609
Content-Type: text/x-patch;
 name="core-git_to_asciidoc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="core-git_to_asciidoc.patch"

--- a/Documentation/core-git.txt
+++ b/Documentation/core-git.txt
@@ -1,142 +1,354 @@
-This file contains reference information for the core git commands.
+GIT(1)
+======
+v0.1, May 2005
 
-The README contains much useful definition and clarification
+////////////////////////
+Please note that this document is in asciidoc format.
+  http://www.methods.co.nz/asciidoc/index.html
+
+You should be able to read it but be aware that there is some minor
+typographical bludgeoning to allow the production of clean man and
+html output.
+
+(eg in some synopsis lines the '*' character is preceded by a '\' and
+there are one or two '+' characters)
+
+////////////////////////
+
+NAME
+----
+git - the stupid content tracker
+
+SYNOPSIS
+--------
+'git-<command>' <args>
+
+DESCRIPTION
+-----------
+
+This is reference information for the core git commands.
+
+The link:README[] contains much useful definition and clarification
 info - read that first.  And of the commands, I suggest reading
 'git-update-cache' and 'git-read-tree' first - I wish I had!
 
 David Greaves <david@dgreaves.com>
-24/4/05
+08/05/05
 
 Updated by Junio C Hamano <junkio@cox.net> on 2005-05-05 to
 reflect recent changes.
 
-Identifier terminology used:
+Commands Overview
+-----------------
+The git commands can helpfully be split into those that manipulate
+the repository, the cache and the working fileset and those that
+interrogate and compare them.
+
+Manipulation commands
+~~~~~~~~~~~~~~~~~~~~~
+link:git-apply-patch-script.html[git-apply-patch-script]::
+	Sample script to apply the diffs from git-diff-*
+
+link:git-checkout-cache.html[git-checkout-cache]::
+	Copy files from the cache to the working directory
+
+link:git-commit-tree.html[git-commit-tree]::
+	Creates a new commit object
+
+link:git-convert-cache.html[git-convert-cache]::
+	Converts old-style GIT repository
+
+link:git-http-pull.html[git-http-pull]::
+	Downloads a remote GIT repository via HTTP
+
+link:git-init-db.html[git-init-db]::
+	Creates an empty git object database
+
+link:git-local-pull.html[git-local-pull]::
+	Duplicates another GIT repository on a local system
+
+link:git-merge-base.html[git-merge-base]::
+	Finds as good a common ancestor as possible for a merge
+
+link:git-merge-one-file-script.html[git-merge-one-file-script]::
+	The standard helper program to use with "git-merge-cache"
+
+link:git-mktag.html[git-mktag]::
+	Creates a tag object
+
+link:git-prune-script.html[git-prune-script]::
+	Prunes all unreachable objects from the object database
+
+link:git-pull-script.html[git-pull-script]::
+	Script used by Linus to pull and merge a remote repository
+
+link:git-read-tree.html[git-read-tree]::
+	Reads tree information into the directory cache
+
+link:git-resolve-script.html[git-resolve-script]::
+	Script used to merge two trees
+
+link:git-rpull.html[git-rpull]::
+	Pulls from a remote repository over ssh connection
+
+link:git-tag-script.html[git-tag-script]::
+	An example script to create a tag object signed with GPG
+
+link:git-update-cache.html[git-update-cache]::
+	Modifies the index or directory cache
+
+link:git-write-blob.html[git-write-blob]::
+	Creates a blob from a file
+
+link:git-write-tree.html[git-write-tree]::
+	Creates a tree from the current cache
+
+Interrogation commands
+~~~~~~~~~~~~~~~~~~~~~~
+link:git-cat-file.html[git-cat-file]::
+	Provide content or type information for repository objects
+
+link:git-check-files.html[git-check-files]::
+	Verify a list of files are up-to-date
+
+link:git-diff-cache.html[git-diff-cache]::
+	Compares content and mode of blobs between the cache and repository
+
+link:git-diff-files.html[git-diff-files]::
+	Compares files in the working tree and the cache
+
+link:git-diff-tree.html[git-diff-tree]::
+	Compares the content and mode of blobs found via two tree objects
 
-<object>
+link:git-diff-tree-helper.html[git-diff-tree-helper]::
+	Generates patch format output for git-diff-*
+
+link:git-export.html[git-export]::
+	Exports each commit and a diff against each of its parents
+
+link:git-fsck-cache.html[git-fsck-cache]::
+	Verifies the connectivity and validity of the objects in the database
+
+link:git-ls-files.html[git-ls-files]::
+	Information about files in the cache/working directory
+
+link:git-ls-tree.html[git-ls-tree]::
+	Displays a tree object in human readable form
+
+link:git-merge-cache.html[git-merge-cache]::
+	Runs a merge for files needing merging
+
+link:git-rev-list.html[git-rev-list]::
+	Lists commit objects in reverse chronological order
+
+link:git-rev-tree.html[git-rev-tree]::
+	Provides the revision tree for one or more commits
+
+link:git-rpush.html[git-rpush]::
+	Helper "server-side" program used by git-rpull
+
+link:git-tar-tree.html[git-tar-tree]::
+	Creates a tar archive of the files in the named tree
+
+link:git-unpack-file.html[git-unpack-file]::
+	Creates a temporary file with a blob's contents
+
+The interrogate commands may create files - and you can force them to
+touch the working file set - but in general they don't
+
+
+Terminology
+-----------
+see README for description
+
+Identifier terminology
+----------------------
+<object>::
 	Indicates any object sha1 identifier
 
-<blob>
+<blob>::
 	Indicates a blob object sha1 identifier
 
-<tree>
+<tree>::
 	Indicates a tree object sha1 identifier
 
-<commit>
+<commit>::
 	Indicates a commit object sha1 identifier
 
-<tree-ish>
+<tree-ish>::
 	Indicates a tree, commit or tag object sha1 identifier.
 	A command that takes a <tree-ish> argument ultimately
 	wants to operate on a <tree> object but automatically
 	dereferences <commit> and <tag> that points at a
 	<tree>.
 
-<type>
+<type>::
 	Indicates that an object type is required.
 	Currently one of: blob/tree/commit/tag
 
-<file>
+<file>::
 	Indicates a filename - always relative to the root of
 	the tree structure GIT_INDEX_FILE describes.
 
+Terminology
+-----------
+Each line contains terms used interchangeably
 
-################################################################
-git-apply-patch-script
-
-This is a sample script to be used as GIT_EXTERNAL_DIFF to apply
-differences git-diff-* family of commands reports to the current
-work tree.
-
+ object database, .git directory
+ directory cache, index
+ id, sha1, sha1-id, sha1 hash
+ type, tag
+ blob, blob object
+ tree, tree object
+ commit, commit object
+ parent
+ root object
+ changeset
 
-################################################################
-git-cat-file
-	git-cat-file (-t | <type>) <object>
 
-Provides contents or type of objects in the repository. The type
-is required if -t is not being used to find the object type.
+Environment Variables
+---------------------
+Various git commands use the following environment variables:
 
-<object>
+- 'AUTHOR_NAME'
+- 'AUTHOR_EMAIL'
+- 'AUTHOR_DATE'
+- 'COMMIT_AUTHOR_NAME'
+- 'COMMIT_AUTHOR_EMAIL'
+- 'GIT_DIFF_OPTS'
+- 'GIT_EXTERNAL_DIFF'
+- 'GIT_INDEX_FILE'
+- 'SHA1_FILE_DIRECTORY'
+
+
+NAME
+----
+git-apply-patch-script - Sample script to apply the diffs from git-diff-*
+
+SYNOPSIS
+--------
+'git-apply-patch-script'
+
+DESCRIPTION
+-----------
+This is a sample script to be used via the 'GIT_EXTERNAL_DIFF'
+environment variable to apply the differences that the "git-diff-*"
+family of commands report to the current work tree.
+
+
+NAME
+----
+git-cat-file - Provide content or type information for repository objects
+
+SYNOPSIS
+--------
+'git-cat-file' (-t | <type>) <object>
+
+DESCRIPTION
+-----------
+Provides content or type of objects in the repository. The type
+is required if '-t' is not being used to find the object type.
+
+OPTIONS
+-------
+<object>::
 	The sha1 identifier of the object.
 
--t
-	Instead of the content, show the object type identified
-	by <object>.
-
-<type>
-	Typically this matches the real type of <object> but
-	asking for type that can trivially dereferenced from the
-	given <object> is also permitted.  An example is to ask
-	"tree" with <object> for a commit object that contains
-	it, or to ask "blob" with <object> for a tag object that
+-t::
+	Instead of the content, show the object type identified by
+	<object>.
+
+<type>::
+	Typically this matches the real type of <object> but asking
+	for a type that can trivially dereferenced from the given
+	<object> is also permitted.  An example is to ask for a
+	"tree" with <object> being a commit object that contains it,
+	or to ask for a "blob" with <object> being a tag object that
 	points at it.
 
-Output
-
-If -t is specified, one of the <type>.
+OUTPUT
+------
+If '-t' is specified, one of the <type>.
 
 Otherwise the raw (though uncompressed) contents of the <object> will
 be returned.
 
 
-################################################################
-git-check-files
-	git-check-files <file>...
+NAME
+----
+git-check-files - Verify a list of files are up-to-date
 
+
+SYNOPSIS
+--------
+'git-check-files' <file>...
+
+DESCRIPTION
+-----------
 Check that a list of files are up-to-date between the filesystem and
 the cache. Used to verify a patch target before doing a patch.
 
 Files that do not exist on the filesystem are considered up-to-date
 (whether or not they are in the cache).
 
-Emits an error message on failure.
-preparing to update existing file <file> not in cache
+Emits an error message on failure:
+
+preparing to update existing file <file> not in cache::
 	  <file> exists but is not in the cache
 
-preparing to update file <file> not uptodate in cache
+preparing to update file <file> not uptodate in cache::
 	  <file> on disk is not up-to-date with the cache
 
 Exits with a status code indicating success if all files are
 up-to-date.
 
-see also: git-update-cache
+see also: link:git-update-cache.html[git-update-cache]
+
 
+NAME
+----
+git-checkout-cache - Copy files from the cache to the working directory
 
-################################################################
-git-checkout-cache
-	git-checkout-cache [-q] [-a] [-f] [-n] [--prefix=<string>]
-		           [--] <file>...
+SYNOPSIS
+--------
+'git-checkout-cache' [-q] [-a] [-f] [-n] [--prefix=<string>]
+	           [--] <file>...
 
+DESCRIPTION
+-----------
 Will copy all files listed from the cache to the working directory
 (not overwriting existing files).
 
--q
+OPTIONS
+-------
+-q::
 	be quiet if files exist or are not in the cache
 
--f
+-f::
 	forces overwrite of existing files
 
--a
+-a::
 	checks out all files in the cache (will then continue to
 	process listed files).
 
--n
+-n::
 	Don't checkout new files, only refresh files already checked
 	out.
 
---prefix=<string>
+--prefix=<string>::
 	When creating files, prepend <string> (usually a directory
 	including a trailing /)
 
---
+--::
 	Do not interpret any more arguments as options.
 
 Note that the order of the flags matters:
 
-	git-checkout-cache -a -f file.c
+     git-checkout-cache -a -f file.c
 
 will first check out all files listed in the cache (but not overwrite
-any old ones), and then force-checkout file.c a second time (ie that
-one _will_ overwrite any old contents with the same filename).
+any old ones), and then force-checkout `file.c` a second time (ie that
+one *will* overwrite any old contents with the same filename).
 
 Also, just doing "git-checkout-cache" does nothing. You probably meant
 "git-checkout-cache -a". And if you want to force it, you want
@@ -144,17 +356,17 @@ Also, just doing "git-checkout-cache" do
 
 Intuitiveness is not the goal here. Repeatability is. The reason for
 the "no arguments means no work" thing is that from scripts you are
-supposed to be able to do things like
+supposed to be able to do things like:
 
 	find . -name '*.h' -print0 | xargs -0 git-checkout-cache -f --
 
-which will force all existing *.h files to be replaced with their
+which will force all existing `*.h` files to be replaced with their
 cached copies. If an empty command line implied "all", then this would
 force-refresh everything in the cache, which was not the point.
 
 To update and refresh only the files already checked out:
 
-   git-checkout-cache -n -f -a && git-update-cache --ignore-missing --refresh
+        git-checkout-cache -n -f -a && git-update-cache --ignore-missing --refresh
 
 Oh, and the "--" is just a good idea when you know the rest will be
 filenames. Just so that you wouldn't have a filename of "-a" causing
@@ -170,19 +382,24 @@ desired tree into the index, and do a
 and git-checkout-cache will "export" the cache into the specified
 directory.
   
-NOTE! The final "/" is important. The exported name is literally just
+NOTE The final "/" is important. The exported name is literally just
 prefixed with the specified string, so you can also do something like
-  
-        git-checkout-cache --prefix=.merged- Makefile
-  
-to check out the currently cached copy of "Makefile" into the file
-".merged-Makefile".
 
+    git-checkout-cache --prefix=.merged- Makefile
+
+to check out the currently cached copy of `Makefile` into the file
+`.merged-Makefile`
 
-################################################################
-git-commit-tree
-	git-commit-tree <tree> [-p <parent commit>]*   < changelog
+NAME
+----
+git-commit-tree - Creates a new commit object
 
+SYNOPSIS
+--------
+'git-commit-tree' <tree> [-p <parent commit>]\   < changelog
+
+DESCRIPTION
+-----------
 Creates a new commit object based on the provided tree object and
 emits the new commit object id on stdout. If no parent is given then
 it is considered to be an initial tree.
@@ -197,103 +414,121 @@ to get there.
 
 Normally a commit would identify a new "HEAD" state, and while git
 doesn't care where you save the note about that state, in practice we
-tend to just write the result to the file ".git/HEAD", so that we can
+tend to just write the result to the file `.git/HEAD`, so that we can
 always see what the last committed state was.
 
-Options
-
-<tree>
+OPTIONS
+-------
+<tree>::
 	An existing tree object
 
--p <parent commit>
-	Each -p indicates a the id of a parent commit object.
+-p <parent commit>::
+	Each '-p' indicates a the id of a parent commit object.
 	
 
 Commit Information
+------------------
 
 A commit encapsulates:
-	all parent object ids
-	author name, email and date
-	committer name and email and the commit time.
 
-If not provided, git-commit-tree uses your name, hostname and domain to
+- all parent object ids
+- author name, email and date
+- committer name and email and the commit time.
+
+If not provided, "git-commit-tree" uses your name, hostname and domain to
 provide author and committer info. This can be overridden using the
 following environment variables.
+
 	AUTHOR_NAME
 	AUTHOR_EMAIL
 	AUTHOR_DATE
 	COMMIT_AUTHOR_NAME
 	COMMIT_AUTHOR_EMAIL
+
 (nb <,> and '\n's are stripped)
 
 A commit comment is read from stdin (max 999 chars). If a changelog
-entry is not provided via '<' redirection, git-commit-tree will just wait
+entry is not provided via '<' redirection, "git-commit-tree" will just wait
 for one to be entered and terminated with ^D
 
-see also: git-write-tree
+see also: link:git-write-tree.html[git-write-tree]
+
 
+NAME
+----
+git-convert-cache - Converts old-style GIT repository
 
-################################################################
-git-convert-cache
+SYNOPSIS
+--------
+'git-convert-cache'
 
-Converts old-style GIT repository to the latest.
+DESCRIPTION
+-----------
+Converts old-style GIT repository to the latest format
 
 
-################################################################
-git-diff-cache
-	git-diff-cache [-p] [-r] [-z] [--cached] <tree-ish>
+NAME
+----
+git-diff-cache - Compares content and mode of blobs between the cache and repository
 
+SYNOPSIS
+--------
+'git-diff-cache' [-p] [-r] [-z] [--cached] <tree-ish>
+
+DESCRIPTION
+-----------
 Compares the content and mode of the blobs found via a tree object
 with the content of the current cache and, optionally ignoring the
 stat state of the file on disk.
 
-<tree-ish>
+OPTIONS
+-------
+<tree-ish>::
 	The id of a tree object to diff against.
 
--p
+-p::
 	Generate patch (see section on generating patches)
 
--r
+-r::
 	This flag does not mean anything.  It is there only to match
-	git-diff-tree.  Unlike git-diff-tree, git-diff-cache always looks
-	at all the subdirectories.
+	"git-diff-tree".  Unlike "git-diff-tree", "git-diff-cache"
+	always looks at all the subdirectories.
 
--z
+-z::
 	\0 line termination on output
 
---cached
+--cached::
 	do not consider the on-disk file at all
 
-Output format:
-
-See "Output format from git-diff-cache, git-diff-tree and git-diff-files"
-section.
+Output format
+-------------
+include::diff-format.txt[]
 
 Operating Modes
-
+---------------
 You can choose whether you want to trust the index file entirely
-(using the "--cached" flag) or ask the diff logic to show any files
+(using the '--cached' flag) or ask the diff logic to show any files
 that don't match the stat state as being "tentatively changed".  Both
 of these operations are very useful indeed.
 
 Cached Mode
-
-If --cached is specified, it allows you to ask:
+-----------
+If '--cached' is specified, it allows you to ask:
 
 	show me the differences between HEAD and the current index
 	contents (the ones I'd write with a "git-write-tree")
 
 For example, let's say that you have worked on your index file, and are
-ready to commit. You want to see eactly _what_ you are going to commit is
+ready to commit. You want to see eactly *what* you are going to commit is
 without having to write a new tree object and compare it that way, and to
 do that, you just do
 
 	git-diff-cache --cached $(cat .git/HEAD)
 
-Example: let's say I had renamed "commit.c" to "git-commit.c", and I had
+Example: let's say I had renamed `commit.c` to `git-commit.c`, and I had
 done an "git-update-cache" to make that effective in the index file.
 "git-diff-files" wouldn't show anything at all, since the index file
-matches my working directory. But doing a git-diff-cache does:
+matches my working directory. But doing a "git-diff-cache" does:
 
   torvalds@ppc970:~/git> git-diff-cache --cached $(cat .git/HEAD)
   -100644 blob    4161aecc6700a2eb579e842af0b7f22b98443f74        commit.c
@@ -301,7 +536,7 @@ matches my working directory. But doing 
 
 You can trivially see that the above is a rename.
 
-In fact, "git-diff-cache --cached" _should_ always be entirely equivalent to
+In fact, "git-diff-cache --cached" *should* always be entirely equivalent to
 actually doing a "git-write-tree" and comparing that. Except this one is much
 nicer for the case where you just want to check where you are.
 
@@ -310,131 +545,145 @@ asking yourself "what have I already mar
 what's the difference to a previous tree".
 
 Non-cached Mode
+---------------
+The "non-cached" mode takes a different approach, and is potentially
+the more useful of the two in that what it does can't be emulated with
+a "git-write-tree" + "git-diff-tree". Thus that's the default mode.
+The non-cached version asks the question:
 
-The "non-cached" mode takes a different approach, and is potentially the
-even more useful of the two in that what it does can't be emulated with a
-"git-write-tree + git-diff-tree". Thus that's the default mode.  The
-non-cached version asks the question
-
-   "show me the differences between HEAD and the currently checked out 
-    tree - index contents _and_ files that aren't up-to-date"
+   show me the differences between HEAD and the currently checked out
+   tree - index contents _and_ files that aren't up-to-date
 
 which is obviously a very useful question too, since that tells you what
-you _could_ commit. Again, the output matches the "git-diff-tree -r"
+you *could* commit. Again, the output matches the "git-diff-tree -r"
 output to a tee, but with a twist.
 
-The twist is that if some file doesn't match the cache, we don't have a
-backing store thing for it, and we use the magic "all-zero" sha1 to show
-that. So let's say that you have edited "kernel/sched.c", but have not
-actually done an git-update-cache on it yet - there is no "object" associated
-with the new state, and you get:
+The twist is that if some file doesn't match the cache, we don't have
+a backing store thing for it, and we use the magic "all-zero" sha1 to
+show that. So let's say that you have edited `kernel/sched.c`, but
+have not actually done a "git-update-cache" on it yet - there is no
+"object" associated with the new state, and you get:
 
   torvalds@ppc970:~/v2.6/linux> git-diff-cache $(cat .git/HEAD )
   *100644->100664 blob    7476bb......->000000......      kernel/sched.c
 
-ie it shows that the tree has changed, and that "kernel/sched.c" has is
+ie it shows that the tree has changed, and that `kernel/sched.c` has is
 not up-to-date and may contain new stuff. The all-zero sha1 means that to
 get the real diff, you need to look at the object in the working directory
 directly rather than do an object-to-object diff.
 
 NOTE! As with other commands of this type, "git-diff-cache" does not
 actually look at the contents of the file at all. So maybe
-"kernel/sched.c" hasn't actually changed, and it's just that you touched
-it. In either case, it's a note that you need to upate-cache it to make
-the cache be in sync.
-
-NOTE 2! You can have a mixture of files show up as "has been updated" and
-"is still dirty in the working directory" together. You can always tell
-which file is in which state, since the "has been updated" ones show a
-valid sha1, and the "not in sync with the index" ones will always have the
-special all-zero sha1.
-
-
-################################################################
-git-diff-files
-	git-diff-files [-p] [-q] [-r] [-z] [<pattern>...]
+`kernel/sched.c` hasn't actually changed, and it's just that you
+touched it. In either case, it's a note that you need to
+"git-upate-cache" it to make the cache be in sync.
+
+NOTE 2! You can have a mixture of files show up as "has been updated"
+and "is still dirty in the working directory" together. You can always
+tell which file is in which state, since the "has been updated" ones
+show a valid sha1, and the "not in sync with the index" ones will
+always have the special all-zero sha1.
+
+
+NAME
+----
+git-diff-files - Compares files in the working tree and the cache
+
+SYNOPSIS
+--------
+'git-diff-files' [-p] [-q] [-r] [-z] [<pattern>...]
 
+DESCRIPTION
+-----------
 Compares the files in the working tree and the cache.  When paths
 are specified, compares only those named paths.  Otherwise all
 entries in the cache are compared.  The output format is the
-same as git-diff-cache and git-diff-tree.
+same as "git-diff-cache" and "git-diff-tree".
 
--p
+OPTIONS
+-------
+-p::
 	generate patch (see section on generating patches).
 
--q
+-q::
 	Remain silent even on nonexisting files
 
--r
+-r::
 	This flag does not mean anything.  It is there only to match
 	git-diff-tree.  Unlike git-diff-tree, git-diff-files always looks
 	at all the subdirectories.
 
 
-Output format:
+Output format
+-------------
+include::diff-format.txt[]
 
-See "Output format from git-diff-cache, git-diff-tree and git-diff-files"
-section.
 
+NAME
+----
+git-diff-tree - Compares the content and mode of blobs found via two tree objects
 
-################################################################
-git-diff-tree
-	git-diff-tree [-p] [-r] [-z] [--stdin] [-m] [-s] [-v] <tree-ish> <tree-ish> [<pattern>]*
+SYNOPSIS
+--------
+'git-diff-tree' [-p] [-r] [-z] [--stdin] [-m] [-s] [-v] <tree-ish> <tree-ish> [<pattern>]\*
 
+DESCRIPTION
+-----------
 Compares the content and mode of the blobs found via two tree objects.
 
-Note that git-diff-tree can use the tree encapsulated in a commit object.
+Note that "git-diff-tree" can use the tree encapsulated in a commit object.
 
-<tree-ish>
+OPTIONS
+-------
+<tree-ish>::
 	The id of a tree object.
 
-<pattern>
+<pattern>::
 	If provided, the results are limited to a subset of files
 	matching one of these prefix strings.
-	ie file matches /^<pattern1>|<pattern2>|.../
+	ie file matches `/^<pattern1>|<pattern2>|.../`
 	Note that pattern does not provide any wildcard or regexp
 	features.
 
--p
+-p::
 	generate patch (see section on generating patches).  For
-	git-diff-tree, this flag implies -r as well.
+	git-diff-tree, this flag implies '-r' as well.
 
--r
+-r::
 	recurse
 
--z
+-z::
 	\0 line termination on output
 
---stdin
-	When --stdin is specified, the command does not take
+--stdin::
+	When '--stdin' is specified, the command does not take
 	<tree-ish> arguments from the command line.  Instead, it
 	reads either one <commit> or a pair of <tree-ish>
 	separated with a single space from its standard input.
++
+When a single commit is given on one line of such input, it compares
+the commit with its parents.  The following flags further affects its
+behaviour.  This does not apply to the case where two <tree-ish>
+separated with a single space are given.
 
-        When a single commit is given on one line of such input,
-        it compares the commit with its parents.  The following
-        flags further affects its behaviour.  This does not
-        apply to the case where two <tree-ish> separated with a
-        single space are given.
-
--m
+-m::
 	By default, "git-diff-tree --stdin" does not show
 	differences for merge commits.  With this flag, it shows
 	differences to that commit from all of its parents.
 
--s
+-s::
 	By default, "git-diff-tree --stdin" shows differences,
-	either in machine-readable form (without -p) or in patch
-	form (with -p).  This output can be supressed.  It is
-	only useful with -v flag.
+	either in machine-readable form (without '-p') or in patch
+	form (with '-p').  This output can be supressed.  It is
+	only useful with '-v' flag.
 
--v
+-v::
 	This flag causes "git-diff-tree --stdin" to also show
 	the commit message before the differences.
 
 
 Limiting Output
-
+---------------
 If you're only interested in differences in a subset of files, for
 example some architecture-specific files, you might do:
 
@@ -442,7 +691,7 @@ example some architecture-specific files
 
 and it will only show you what changed in those two directories.
 
-Or if you are searching for what changed in just kernel/sched.c, just do
+Or if you are searching for what changed in just `kernel/sched.c`, just do
 
 	git-diff-tree -r <tree-ish> <tree-ish> kernel/sched.c
 
@@ -450,14 +699,9 @@ and it will ignore all differences to ot
 
 The pattern is always the prefix, and is matched exactly.  There are no
 wildcards.  Even stricter, it has to match complete path comonent.
-I.e. "foo" does not pick up "foobar.h".  "foo" does match "foo/bar.h"
+I.e. "foo" does not pick up `foobar.h`.  "foo" does match `foo/bar.h`
 so it can be used to name subdirectories.
 
-Output format:
-
-See "Output format from git-diff-cache, git-diff-tree and git-diff-files"
-section.
-
 An example of normal usage is:
 
   torvalds@ppc970:~/git> git-diff-tree 5319e4......
@@ -479,65 +723,90 @@ this one:
 
 in case you care).
 
-
-################################################################
-git-diff-tree-helper
-	git-diff-tree-helper [-z] [-R]
-
-Reads output from git-diff-cache, git-diff-tree and git-diff-files and
+Output format
+-------------
+include::diff-format.txt[]
+
+
+NAME
+----
+git-diff-tree-helper - Generates patch format output for git-diff-*
+
+SYNOPSIS
+--------
+'git-diff-tree-helper' [-z] [-R]
+
+DESCRIPTION
+-----------
+Reads output from "git-diff-cache", "git-diff-tree" and "git-diff-files" and
 generates patch format output.
 
--z
+OPTIONS
+-------
+-z::
 	\0 line termination on input
 
--R
+-R::
 	Output diff in reverse.  This is useful for displaying output from
-	git-diff-cache which always compares tree with cache or working
+	"git-diff-cache" which always compares tree with cache or working
 	file.  E.g.
 
-	git-diff-cache <tree> | git-diff-tree-helper -R file.c
+		git-diff-cache <tree> | git-diff-tree-helper -R file.c
++
+would show a diff to bring the working file back to what is in the <tree>.
 
-	would show a diff to bring the working file back to what is in the
-	<tree>.
+See also the section on generating patches in link:git-diff-cache.html[git-diff-cache]
 
-See also the section on generating patches.
 
+NAME
+----
+git-export - Exports each commit and a diff against each of its parents
 
-################################################################
-git-export
-	git-export top [base]
+SYNOPSIS
+--------
+'git-export' top [base]
 
+DESCRIPTION
+-----------
 Exports each commit and diff against each of its parents, between
 top and base.  If base is not specified it exports everything.
 
 
-################################################################
-git-fsck-cache
-	git-fsck-cache [--tags] [--root] [[--unreachable] [--cache] <object>*]
+NAME
+----
+git-fsck-cache - Verifies the connectivity and validity of the objects in the database
+
+SYNOPSIS
+--------
+'git-fsck-cache' [--tags] [--root] [[--unreachable] [--cache] <object>\*]
 
+DESCRIPTION
+-----------
 Verifies the connectivity and validity of the objects in the database.
 
-<object>
+OPTIONS
+-------
+<object>::
 	An object to treat as the head of an unreachability trace.
 
---unreachable
+--unreachable::
 	Print out objects that exist but that aren't readable from any
 	of the specified head nodes.
 
---root
+--root::
 	Report root nodes.
 
---tags
+--tags::
 	Report tags.
 
---cache
+--cache::
 	Consider any object recorded in the cache also as a head node for
 	an unreachability trace.
 
 It tests SHA1 and general object sanity, and it does full tracking of
 the resulting reachability and everything else. It prints out any
 corruption it finds (missing or bad objects), and if you use the
-"--unreachable" flag it will also print out objects that exist but
+'--unreachable' flag it will also print out objects that exist but
 that aren't readable from any of the specified head nodes.
 
 So for example
@@ -562,105 +831,131 @@ evil person, and the end result might be
 tracking system, not a quality assurance system ;)
 
 Extracted Diagnostics
+---------------------
 
-expect dangling commits - potential heads - due to lack of head information
+expect dangling commits - potential heads - due to lack of head information::
 	You haven't specified any nodes as heads so it won't be
 	possible to differentiate between un-parented commits and
 	root nodes.
 
-missing sha1 directory '<dir>'
+missing sha1 directory '<dir>'::
 	The directory holding the sha1 objects is missing.
 
-unreachable <type> <object>
+unreachable <type> <object>::
 	The <type> object <object>, isn't actually referred to directly
 	or indirectly in any of the trees or commits seen. This can
-	mean that there's another root na SHA1_ode that you're not specifying
+	mean that there's another root node that you're not specifying
 	or that the tree is corrupt. If you haven't missed a root node
 	then you might as well delete unreachable nodes since they
 	can't be used.
 
-missing <type> <object>
+missing <type> <object>::
 	The <type> object <object>, is referred to but isn't present in
 	the database.
 
-dangling <type> <object>
+dangling <type> <object>::
 	The <type> object <object>, is present in the database but never
-	_directly_ used. A dangling commit could be a root node.
+	'directly' used. A dangling commit could be a root node.
 
-warning: git-fsck-cache: tree <tree> has full pathnames in it
+warning: git-fsck-cache: tree <tree> has full pathnames in it::
 	And it shouldn't...
 
-sha1 mismatch <object>
+sha1 mismatch <object>::
 	The database has an object who's sha1 doesn't match the
 	database value.
-	This indicates a ??serious?? data integrity problem.
+	This indicates a serious data integrity problem.
 	(note: this error occured during early git development when
 	the database format changed.)
 
 Environment Variables
+---------------------
 
-SHA1_FILE_DIRECTORY
+SHA1_FILE_DIRECTORY::
 	used to specify the object database root (usually .git/objects)
 
-GIT_INDEX_FILE
+GIT_INDEX_FILE::
 	used to specify the cache
 
 
-################################################################
-git-http-pull
-
-	git-http-pull [-c] [-t] [-a] [-v] commit-id url
+NAME
+----
+git-http-pull - Downloads a remote GIT repository via HTTP
+
+SYNOPSIS
+--------
+'git-http-pull' [-c] [-t] [-a] [-v] commit-id url
+
+DESCRIPTION
+-----------
+Downloads a remote GIT repository via HTTP.
 
-Downloads a remote GIT repository via HTTP protocol.
-
--c
+-c::
 	Get the commit objects.
--t
+-t::
 	Get trees associated with the commit objects.
--a
+-a::
 	Get all the objects.
--v
+-v::
 	Report what is downloaded.
 
 
-################################################################
-git-init-db
-	git-init-db
-
-This simply creates an empty git object database - basically a .git
-directory and .git/object/??/ directories.
+NAME
+----
+git-init-db - Creates an empty git object database
+
+SYNOPSIS
+--------
+'git-init-db'
+
+DESCRIPTION
+-----------
+This simply creates an empty git object database - basically a `.git`
+directory and `.git/object/??/` directories.
 
-If the object storage directory is specified via the SHA1_FILE_DIRECTORY
+If the object storage directory is specified via the 'SHA1_FILE_DIRECTORY'
 environment variable then the sha1 directories are created underneath -
-otherwise the default .git/objects directory is used.
+otherwise the default `.git/objects` directory is used.
 
-git-init-db won't hurt an existing repository.
+"git-init-db" won't hurt an existing repository.
 
 
-################################################################
-git-local-pull
+NAME
+----
+git-local-pull - Duplicates another GIT repository on a local system
 
-	git-local-pull [-c] [-t] [-a] [-l] [-s] [-n] [-v] commit-id path
+SYNOPSIS
+--------
+'git-local-pull' [-c] [-t] [-a] [-l] [-s] [-n] [-v] commit-id path
 
-Downloads another GIT repository on a local system.
+DESCRIPTION
+-----------
+Duplicates another GIT repository on a local system.
 
--c
+OPTIONS
+-------
+-c::
 	Get the commit objects.
--t
+-t::
 	Get trees associated with the commit objects.
--a
+-a::
 	Get all the objects.
--v
+-v::
 	Report what is downloaded.
 
-################################################################
-git-ls-files
-	git-ls-files [-z] [-t]
-		(--[cached|deleted|others|ignored|stage|unmerged])*
-		(-[c|d|o|i|s|u])*
+NAME
+----
+git-ls-files - Information about files in the cache/working directory
+
+SYNOPSIS
+--------
+'git-ls-files' [-z] [-t]
+		(--[cached|deleted|others|ignored|stage|unmerged])\*
+		(-[c|d|o|i|s|u])\*
 		[-x <pattern>|--exclude=<pattern>]
 		[-X <file>|--exclude-from=<file>]
 
+DESCRIPTION
+-----------
 This merges the file listing in the directory cache index with the
 actual working directory list, and shows different combinations of the
 two.
@@ -668,40 +963,42 @@ two.
 One or more of the options below may be used to determine the files
 shown:
 
--c|--cached
+OPTIONS
+-------
+-c|--cached::
 	Show cached files in the output (default)
 
--d|--deleted
+-d|--deleted::
 	Show deleted files in the output
 
--o|--others
+-o|--others::
 	Show other files in the output
 
--i|--ignored
+-i|--ignored::
 	Show ignored files in the output
 	Note the this also reverses any exclude list present.
 
--s|--stage
+-s|--stage::
 	Show stage files in the output
 
--u|--unmerged
+-u|--unmerged::
 	Show unmerged files in the output (forces --stage)
 
--z
+-z::
 	\0 line termination on output
 
--x|--exclude=<pattern>
+-x|--exclude=<pattern>::
 	Skips files matching pattern.
 	Note that pattern is a shell wildcard pattern.
 
--X|--exclude-from=<file>
+-X|--exclude-from=<file>::
 	exclude patterns are read from <file>; 1 per line.
 	Allows the use of the famous dontdiff file as follows to find
 	out about uncommitted files just as dontdiff is used with
 	the diff command:
 	     git-ls-files --others --exclude-from=dontdiff
 
--t
+-t::
 	Identify the file status with the following tags (followed by
 	a space) at the start of each line:
 	H	cached
@@ -710,12 +1007,13 @@ shown:
 	?	other
 
 Output
-show files just outputs the filename unless --stage is specified in
+------
+show files just outputs the filename unless '--stage' is specified in
 which case it outputs:
 
-[<tag> ]<mode> <object> <stage> <file>
+        [<tag> ]<mode> <object> <stage> <file>
 
-git-ls-files --unmerged" and "git-ls-files --stage " can be used to examine
+"git-ls-files --unmerged" and "git-ls-files --stage" can be used to examine
 detailed information on unmerged paths.
 
 For an unmerged path, instead of recording a single mode/SHA1 pair,
@@ -724,64 +1022,86 @@ the dircache records up to three such pa
 the user (or Cogito) to see what should eventually be recorded at the
 path. (see read-cache for more information on state)
 
-see also:
-read-cache
+see also: link:read-cache.html[read-cache]
 
 
-################################################################
-git-ls-tree
-	git-ls-tree [-r] [-z] <tree-ish>
+NAME
+----
+git-ls-tree - Displays a tree object in human readable form
 
+SYNOPSIS
+--------
+'git-ls-tree' [-r] [-z] <tree-ish>
+
+DESCRIPTION
+-----------
 Converts the tree object to a human readable (and script processable)
 form.
 
-<tree-ish>
+OPTIONS
+-------
+<tree-ish>::
 	Id of a tree.
 
--r
+-r::
 	recurse into sub-trees
 
--z
+-z::
 	\0 line termination on output
 
 Output Format
-<mode>\t	<type>\t	<object>\t	<file>
+-------------
+        <mode>\t	<type>\t	<object>\t	<file>
+
 
+NAME
+----
+git-merge-base - Finds as good a common ancestor as possible for a merge
 
-################################################################
-git-merge-base
-	git-merge-base <commit> <commit>
+SYNOPSIS
+--------
+'git-merge-base' <commit> <commit>
 
-git-merge-base finds as good a common ancestor as possible. Given a
+DESCRIPTION
+-----------
+"git-merge-base" finds as good a common ancestor as possible. Given a
 selection of equally good common ancestors it should not be relied on
 to decide in any particular way.
 
-The git-merge-base algorithm is still in flux - use the source...
+The "git-merge-base" algorithm is still in flux - use the source...
 
 
-################################################################
-git-merge-cache
-	git-merge-cache <merge-program> (-a | -- | <file>*) 
+NAME
+----
+git-merge-cache - Runs a merge for files needing merging
 
+SYNOPSIS
+--------
+'git-merge-cache' <merge-program> (-a | -- | <file>\*) 
+
+DESCRIPTION
+-----------
 This looks up the <file>(s) in the cache and, if there are any merge
 entries, passes the SHA1 hash for those files as arguments 1, 2, 3 (empty
 argument if no file), and <file> as argument 4.  File modes for the three
 files are passed as arguments 5, 6 and 7.
 
---
+OPTIONS
+-------
+--::
 	Interpret all future arguments as filenames.
 
--a
+-a::
 	Run merge against all files in the cache that need merging.
 
-If git-merge-cache is called with multiple <file>s (or -a) then it
+If "git-merge-cache" is called with multiple <file>s (or -a) then it
 processes them in turn only stopping if merge returns a non-zero exit
 code.
 
 Typically this is run with the a script calling the merge command from
 the RCS package.
 
-A sample script called git-merge-one-file-script is included in the
+A sample script called "git-merge-one-file-script" is included in the
 ditribution.
 
 ALERT ALERT ALERT! The git "merge object order" is different from the
@@ -811,38 +1131,72 @@ merge once anything has returned an erro
 for the AA file, because it didn't exist in the original, and thus
 "git-merge-cache" didn't even try to merge the MM thing).
 
-################################################################
-git-merge-one-file-script
-
-This is the standard helper program to use with git-merge-cache
-to resolve a merge after the trivial merge done with git-read-tree -m.
-
-################################################################
-git-mktag
+NAME
+----
+git-merge-one-file-script - The standard helper program to use with "git-merge-cache"
+
+SYNOPSIS
+--------
+'git-merge-one-file-script'
+
+DESCRIPTION
+-----------
+This is the standard helper program to use with "git-merge-cache"
+to resolve a merge after the trivial merge done with "git-read-tree -m".
+
+NAME
+----
+git-mktag - Creates a tag object
+
+SYNOPSIS
+--------
+'git-mktag'
 
+DESCRIPTION
+-----------
 Reads a tag contents from its standard input and creates a tag object.
 The input must be a well formed tag object.
 
 
-################################################################
-git-prune-script
-
-This runs git-fsck-cache --unreachable program using the heads specified
-on the command line (or .git/refs/heads/* and .git/refs/tags/* if none is
+NAME
+----
+git-prune-script - Prunes all unreachable objects from the object database
+
+SYNOPSIS
+--------
+'git-prune-script'
+
+DESCRIPTION
+-----------
+This runs "git-fsck-cache --unreachable" program using the heads specified
+on the command line (or `.git/refs/heads/\*` and `.git/refs/tags/\*` if none is
 specified), and prunes all unreachable objects from the object database.
 
 
-################################################################
-git-pull-script
+NAME
+----
+git-pull-script - Script used by Linus to pull and merge a remote repository
+
+SYNOPSIS
+--------
+'git-pull-script'
 
+DESCRIPTION
+-----------
 This script is used by Linus to pull from a remote repository and perform
 a merge.
 
 
-################################################################
-git-read-tree
-	git-read-tree (<tree-ish> | -m <tree-ish1> [<tree-ish2> <tree-ish3>])"
+NAME
+----
+git-read-tree - Reads tree information into the directory cache
+
+SYNOPSIS
+--------
+'git-read-tree' (<tree-ish> | -m <tree-ish1> [<tree-ish2> <tree-ish3>])"
 
+DESCRIPTION
+-----------
 Reads the tree information given by <tree> into the directory cache,
 but does not actually _update_ any of the files it "caches". (see:
 git-checkout-cache)
@@ -850,36 +1204,41 @@ git-checkout-cache)
 Optionally, it can merge a tree into the cache or perform a 3-way
 merge.
 
-Trivial merges are done by git-read-tree itself.  Only conflicting paths
-will be in unmerged state when git-read-tree returns.
+Trivial merges are done by "git-read-tree" itself.  Only conflicting paths
+will be in unmerged state when "git-read-tree" returns.
 
--m
+OPTIONS
+-------
+-m::
 	Perform a merge, not just a read
 
-<tree-ish#>
+<tree-ish#>::
 	The id of the tree object(s) to be read/merged.
 
 
 Merging
-If -m is specified, git-read-tree performs 2 kinds of merge, a single tree
+-------
+If '-m' is specified, "git-read-tree" performs 2 kinds of merge, a single tree
 merge if only 1 tree is given or a 3-way merge if 3 trees are
 provided.
 
 Single Tree Merge
+~~~~~~~~~~~~~~~~~
 If only 1 tree is specified, git-read-tree operates as if the user did not
-specify "-m", except that if the original cache has an entry for a
+specify '-m', except that if the original cache has an entry for a
 given pathname; and the contents of the path matches with the tree
 being read, the stat info from the cache is used. (In other words, the
 cache's stat()s take precedence over the merged tree's)
 
 That means that if you do a "git-read-tree -m <newtree>" followed by a
-"git-checkout-cache -f -a", the git-checkout-cache only checks out the stuff
-that really changed.
+"git-checkout-cache -f -a", the "git-checkout-cache" only checks out
+the stuff that really changed.
 
-This is used to avoid unnecessary false hits when git-diff-files is
+This is used to avoid unnecessary false hits when "git-diff-files" is
 run after git-read-tree.
 
 3-Way Merge
+~~~~~~~~~~~
 Each "index" entry has two bits worth of "stage" state. stage 0 is the
 normal one, and is the only one you'd see in any kind of normal use.
 
@@ -907,7 +1266,7 @@ a file that matches in all respects in t
    - stage 1 and stage 3 are the same and stage 2 is different take
      stage 2 (some work has been done on stage 2)
 
-The git-write-tree command refuses to write a nonsensical tree, and it
+The "git-write-tree" command refuses to write a nonsensical tree, and it
 will complain about unmerged entries if it sees a single entry that is not
 stage 0.
 
@@ -926,88 +1285,112 @@ sense to always consider stage 0 to be t
 So what happens? Try it out. Select the original tree, and two trees
 to merge, and look how it works:
 
- - if a file exists in identical format in all three trees, it will 
-   automatically collapse to "merged" state by the new git-read-tree.
-
- - a file that has _any_ difference what-so-ever in the three trees
-   will stay as separate entries in the index. It's up to "script
-   policy" to determine how to remove the non-0 stages, and insert a
-   merged version.  But since the index is always sorted, they're easy
-   to find: they'll be clustered together.
-
- - the index file saves and restores with all this information, so you
-   can merge things incrementally, but as long as it has entries in
-   stages 1/2/3 (ie "unmerged entries") you can't write the result.
-
-So now the merge algorithm ends up being really simple:
-
- - you walk the index in order, and ignore all entries of stage 0,
-   since they've already been done.
-
- - if you find a "stage1", but no matching "stage2" or "stage3", you
-   know it's been removed from both trees (it only existed in the
-   original tree), and you remove that entry.  - if you find a
-   matching "stage2" and "stage3" tree, you remove one of them, and
-   turn the other into a "stage0" entry. Remove any matching "stage1"
-   entry if it exists too.  .. all the normal trivial rules ..
-
-Incidentally - it also means that you don't even have to have a separate
-subdirectory for this. All the information literally is in the index file,
-which is a temporary thing anyway. There is no need to worry about what is
-in the working directory, since it is never shown and never used.
-
-see also:
-git-write-tree
-git-ls-files
-
+- if a file exists in identical format in all three trees, it will
+  automatically collapse to "merged" state by the new git-read-tree.
 
-################################################################
-git-resolve-script
+- a file that has _any_ difference what-so-ever in the three trees
+  will stay as separate entries in the index. It's up to "script
+  policy" to determine how to remove the non-0 stages, and insert a
+  merged version.  But since the index is always sorted, they're easy
+  to find: they'll be clustered together.
+
+- the index file saves and restores with all this information, so you
+  can merge things incrementally, but as long as it has entries in
+  stages 1/2/3 (ie "unmerged entries") you can't write the result. So
+  now the merge algorithm ends up being really simple:
+
+  * you walk the index in order, and ignore all entries of stage 0,
+    since they've already been done.
+
+  * if you find a "stage1", but no matching "stage2" or "stage3", you
+    know it's been removed from both trees (it only existed in the
+    original tree), and you remove that entry.
+
+  * if you find a matching "stage2" and "stage3" tree, you remove one
+    of them, and turn the other into a "stage0" entry. Remove any
+    matching "stage1" entry if it exists too.  .. all the normal
+    trivial rules ..
+
+Incidentally - it also means that you don't even have to have a
+separate subdirectory for this. All the information literally is in
+the index file, which is a temporary thing anyway. There is no need to
+worry about what is in the working directory, since it is never shown
+and never used.
+
+see also: link:git-write-tree.html[git-write-tree], link:git-ls-files.html[git-ls-files]
+
+
+NAME
+----
+git-resolve-script - Script used to merge two trees
+
+SYNOPSIS
+--------
+'git-resolve-script'
 
+DESCRIPTION
+-----------
 This script is used by Linus to merge two trees.
 
 
-################################################################
-git-rev-list <commit>
+NAME
+----
+git-rev-list - Lists commit objects in reverse chronological order
+
+SYNOPSIS
+--------
+'git-rev-list' <commit>
 
+DESCRIPTION
+-----------
 Lists commit objects in reverse chronological order starting at the
 given commit, taking ancestry relationship into account.  This is
 useful to produce human-readable log output.
 
 
-################################################################
-git-rev-tree
-	git-rev-tree [--edges] [--cache <cache-file>] [^]<commit> [[^]<commit>]
+NAME
+----
+git-rev-tree - Provides the revision tree for one or more commits
+
+SYNOPSIS
+--------
+'git-rev-tree' [--edges] [--cache <cache-file>] [^]<commit> [[^]<commit>]
 
+DESCRIPTION
+-----------
 Provides the revision tree for one or more commits.
 
---edges
+OPTIONS
+-------
+--edges::
 	Show edges (ie places where the marking changes between parent
 	and child)
 
---cache <cache-file>
+--cache <cache-file>::
 	Use the specified file as a cache from a previous git-rev-list run
 	to speed things up.  Note that this "cache" is totally different
 	concept from the directory index.  Also this option is not
 	implemented yet.
 
-[^]<commit>
+[^]<commit>::
 	The commit id to trace (a leading caret means to ignore this
 	commit-id and below)
 
-Output:
-<date> <commit>:<flags> [<parent-commit>:<flags> ]*
+Output
+------
+
+        <date> <commit>:<flags> [<parent-commit>:<flags> ]\*
 
-<date>
+<date>::
 	Date in 'seconds since epoch'
 
-<commit>
+<commit>::
 	id of commit object
 
-<parent-commit>
+<parent-commit>::
 	id of each parent commit object (>1 indicates a merge)
 
-<flags>
+<flags>::
 
 	The flags are read as a bitmask representing each commit
 	provided on the commandline. eg: given the command:
@@ -1020,9 +1403,9 @@ Output:
 
 	 means that <commit> is reachable from <com1>(1) and <com3>(4)
 	
-A revtree can get quite large. git-rev-tree will eventually allow you to
-cache previous state so that you don't have to follow the whole thing
-down.
+A revtree can get quite large. "git-rev-tree" will eventually allow
+you to cache previous state so that you don't have to follow the whole
+thing down.
 
 So the change difference between two commits is literally
 
@@ -1036,111 +1419,157 @@ revisions - in "common-revision", and fi
 think.)
 
 
-################################################################
-git-rpull
+NAME
+----
+git-rpull - Pulls from a remote repository over ssh connection
 
-	git-rpull [-c] [-t] [-a] [-v] commit-id url
 
+SYNOPSIS
+--------
+'git-rpull' [-c] [-t] [-a] [-v] commit-id url
+
+DESCRIPTION
+-----------
 Pulls from a remote repository over ssh connection, invoking git-rpush on
 the other end.
 
--c
+OPTIONS
+-------
+-c::
 	Get the commit objects.
--t
+-t::
 	Get trees associated with the commit objects.
--a
+-a::
 	Get all the objects.
--v
+-v::
 	Report what is downloaded.
 
 
-################################################################
-git-rpush
+NAME
+----
+git-rpush - Helper "server-side" program used by git-rpull
+
+SYNOPSIS
+--------
+'git-rpush'
 
+DESCRIPTION
+-----------
 Helper "server-side" program used by git-rpull.
 
 
-################################################################
-git-tag-script
+NAME
+----
+git-tag-script - An example script to create a tag object signed with GPG
 
-This is an example script that uses git-mktag to create a tag object
-signed with GPG.
 
+SYNOPSIS
+--------
+'git-tag-script'
+
+DESCRIPTION
+-----------
+This is an example script that uses "git-mktag" to create a tag object
+signed with GPG.
 
-################################################################
-git-tar-tree
 
-	git-tar-tree <tree-ish> [ <base> ]
+NAME
+----
+git-tar-tree - Creates a tar archive of the files in the named tree
+
+SYNOPSIS
+--------
+'git-tar-tree' <tree-ish> [ <base> ]
 
+DESCRIPTION
+-----------
 Creates a tar archive containing the tree structure for the named tree.
 When <base> is specified it is added as a leading path as the files in the
 generated tar archive.
 
 
-################################################################
-git-unpack-file
-	git-unpack-file <blob>
+NAME
+----
+git-unpack-file - Creates a temporary file with a blob's contents
+
 
+SYNOPSIS
+--------
+'git-unpack-file' <blob>
+
+DESCRIPTION
+-----------
 Creates a file holding the contents of the blob specified by sha1. It
 returns the name of the temporary file in the following format:
 	.merge_file_XXXXX
 
-<blob>
+OPTIONS
+-------
+<blob>::
 	Must be a blob id
 
-################################################################
-git-update-cache
-	git-update-cache
+NAME
+----
+git-update-cache - Modifies the index or directory cache
+
+SYNOPSIS
+--------
+'git-update-cache'
 	     [--add] [--remove] [--refresh]
 	     [--ignore-missing]
 	     [--force-remove <file>]
-	     [--cacheinfo <mode> <object> <file>]*
-	     [--] [<file>]*
+	     [--cacheinfo <mode> <object> <file>]\*
+	     [--] [<file>]\*
 
+DESCRIPTION
+-----------
 Modifies the index or directory cache. Each file mentioned is updated
 into the cache and any 'unmerged' or 'needs updating' state is
 cleared.
 
-The way git-update-cache handles files it is told about can be modified
+The way "git-update-cache" handles files it is told about can be modified
 using the various options:
 
---add
+OPTIONS
+-------
+--add::
 	If a specified file isn't in the cache already then it's
 	added.
 	Default behaviour is to ignore new files.
 
---remove
+--remove::
 	If a specified file is in the cache but is missing then it's
 	removed.
 	Default behaviour is to ignore removed file.
 
---refresh
+--refresh::
 	Looks at the current cache and checks to see if merges or
 	updates are needed by checking stat() information.
 
---ignore-missing
+--ignore-missing::
 	Ignores missing files during a --refresh
 
---cacheinfo <mode> <object> <path>
+--cacheinfo <mode> <object> <path>::
 	Directly insert the specified info into the cache.
 	
---force-remove
+--force-remove::
 	Remove the file from the index even when the working directory
 	still has such a file.
 
---
+--::
 	Do not interpret any more arguments as options.
 
-<file>
+<file>::
 	Files to act on.
 	Note that files begining with '.' are discarded. This includes
-	"./file" and "dir/./file". If you don't want this, then use	
+	`./file` and `dir/./file`. If you don't want this, then use	
 	cleaner names.
 	The same applies to directories ending '/' and paths with '//'
 
 Using --refresh
---refresh does not calculate a new sha1 file or bring the cache
-up-to-date for mode/content changes. But what it _does_ do is to
+---------------
+'--refresh' does not calculate a new sha1 file or bring the cache
+up-to-date for mode/content changes. But what it *does* do is to
 "re-match" the stat information of a file with the cache, so that you
 can refresh the cache for a file that hasn't been changed but where
 the stat entry is out of date.
@@ -1149,7 +1578,8 @@ For example, you'd want to do this after
 up the stat cache details with the proper files.
 
 Using --cacheinfo
---cacheinfo is used to register a file that is not in the current
+-----------------
+'--cacheinfo' is used to register a file that is not in the current
 working directory.  This is useful for minimum-checkout merging.
 
 To pretend you have a file with mode and sha1 at path, say:
@@ -1161,147 +1591,55 @@ To update and refresh only the files alr
    git-checkout-cache -n -f -a && git-update-cache --ignore-missing --refresh
 
 
-################################################################
-git-write-blob
-
-	git-write-blob <any-file-on-the-filesystem>
+NAME
+----
+git-write-blob - Creates a blob from a file
+
+SYNOPSIS
+--------
+'git-write-blob' <any-file-on-the-filesystem>
 
+DESCRIPTION
+-----------
 Writes the contents of the named file (which can be outside of the work
 tree) as a blob into the object database, and reports its object ID to its
-standard output.  This is used by git-merge-one-file-script to update the
+standard output.  This is used by "git-merge-one-file-script" to update the
 cache without modifying files in the work tree.
 
 
-################################################################
-git-write-tree
-	git-write-tree
+NAME
+----
+git-write-tree - Creates a tree from the current cache
+
+SYNOPSIS
+--------
+'git-write-tree'
 
+DESCRIPTION
+-----------
 Creates a tree object using the current cache.
 
 The cache must be merged.
 
-Conceptually, git-write-tree sync()s the current directory cache contents
+Conceptually, "git-write-tree" sync()s the current directory cache contents
 into a set of tree files.
 In order to have that match what is actually in your directory right
 now, you need to have done a "git-update-cache" phase before you did the
 "git-write-tree".
 
 
-################################################################
-
-Output format from git-diff-cache, git-diff-tree and git-diff-files.
-
-These commands all compare two sets of things; what are
-compared are different:
-
-    git-diff-cache <tree-ish>
-
-        compares the <tree-ish> and the files on the filesystem.
-
-    git-diff-cache --cached <tree-ish>
-
-        compares the <tree-ish> and the cache.
-
-    git-diff-tree [-r] <tree-ish-1> <tree-ish-2> [<pattern>...]
-
-        compares the trees named by the two arguments.
-
-    git-diff-files [<pattern>...]
-
-        compares the cache and the files on the filesystem.
-
-The following desription uses "old" and "new" to mean those
-compared entities.
-
-For files in old but not in new (i.e. removed):
--<mode> \t <type> \t <object> \t <path>
 
-For files not in old but in new (i.e. added):
-+<mode> \t <type> \t <object> \t <path>
 
-For files that differ:
-*<old-mode>-><new-mode> \t <type> \t <old-sha1>-><new-sha1> \t <path>
+////////////////////////////////////////////////////////////////
 
-<new-sha1> is shown as all 0's if new is a file on the
-filesystem and it is out of sync with the cache.  Example:
+Producing man pages and html
 
-  *100644->100644 blob    5be4a4.......->000000.......      file.c
+To create a set of html pages run:
+  perl split-docs.pl -html < core-git.txt
 
-################################################################
+To create a set of man pages run:
+  perl split-docs.pl -man < core-git.txt
 
-Generating patches
 
-When git-diff-cache, git-diff-tree, or git-diff-files are run with a -p
-option, they do not produce the output described in "Output format from
-git-diff-cache, git-diff-tree and git-diff-files" section.  It instead
-produces a patch file.
-
-The patch generation can be customized at two levels.  This
-customization also applies to git-diff-tree-helper.
-
-1. When the environment variable GIT_EXTERNAL_DIFF is not set,
-   these commands internally invoke diff like this:
-
-   diff -L a/<path> -L a/<path> -pu <old> <new>
-
-   For added files, /dev/null is used for <old>.  For removed
-   files, /dev/null is used for <new>
-
-   The diff formatting options can be customized via the
-   environment variable GIT_DIFF_OPTS.  For example, if you
-   prefer context diff:
-
-   GIT_DIFF_OPTS=-c git-diff-cache -p $(cat .git/HEAD)
-
-
-2. When the environment variable GIT_EXTERNAL_DIFF is set, the
-   program named by it is called, instead of the diff invocation
-   described above.
-
-   For a path that is added, removed, or modified,
-   GIT_EXTERNAL_DIFF is called with 7 parameters:
-
-     path old-file old-hex old-mode new-file new-hex new-mode
-
-   where
-     <old|new>-file are files GIT_EXTERNAL_DIFF can use to read the
-                    contents of <old|ne>,
-     <old|new>-hex are the 40-hexdigit SHA1 hashes,
-     <old|new>-mode are the octal representation of the file modes.
-
-   The file parameters can point at the user's working file (e.g. new-file
-   in git-diff-files), /dev/null (e.g. old-file when a new file is added),
-   or a temporary file (e.g. old-file in the cache).  GIT_EXTERNAL_DIFF
-   should not worry about unlinking the temporary file --- it is removed
-   when GIT_EXTERNAL_DIFF exits.
-
-   For a path that is unmerged, GIT_EXTERNAL_DIFF is called with
-   1 parameter, path.
-
-################################################################
-
-Terminology: - see README for description
-Each line contains terms used interchangeably
+////////////////////////////////////////////////////////////////
 
-object database, .git directory
-directory cache, index
-id, sha1, sha1-id, sha1 hash
-type, tag
-blob, blob object
-tree, tree object
-commit, commit object
-parent
-root object
-changeset
-
-
-git Environment Variables
-AUTHOR_NAME
-AUTHOR_EMAIL
-AUTHOR_DATE
-COMMIT_AUTHOR_NAME
-COMMIT_AUTHOR_EMAIL
-GIT_DIFF_OPTS
-GIT_EXTERNAL_DIFF
-GIT_INDEX_FILE
-SHA1_FILE_DIRECTORY
Created: Documentation/diff-format.txt (mode:100644)
--- /dev/null
+++ b/Documentation/diff-format.txt
@@ -0,0 +1,89 @@
+The output format from "git-diff-cache", "git-diff-tree" and
+"git-diff-files" is very similar.
+
+These commands all compare two sets of things; what are
+compared are different:
+
+git-diff-cache <tree-ish>::
+        compares the <tree-ish> and the files on the filesystem.
+
+git-diff-cache --cached <tree-ish>::
+        compares the <tree-ish> and the cache.
+
+git-diff-tree [-r] <tree-ish-1> <tree-ish-2> [<pattern>...]::
+        compares the trees named by the two arguments.
+
+git-diff-files [<pattern>...]::
+        compares the cache and the files on the filesystem.
+
+The following desription uses "old" and "new" to mean those
+compared entities.
+
+For files in old but not in new (i.e. removed):
+
+    -<mode> \t <type> \t <object> \t <path>
+
+For files not in old but in new (i.e. added):
+
+    +<mode> \t <type> \t <object> \t <path>
+
+For files that differ:
+
+    *<old-mode>-><new-mode> \t <type> \t <old-sha1>-><new-sha1> \t <path>
+
+<new-sha1> is shown as all 0's if new is a file on the
+filesystem and it is out of sync with the cache.  Example:
+
+  *100644->100644 blob    5be4a4.......->000000.......      file.c
+
+
+Generating patches with -p
+--------------------------
+
+When "git-diff-cache", "git-diff-tree", or "git-diff-files" are run
+with a '-p' option, they do not produce the output described above
+instead they produce a patch file.
+
+The patch generation can be customized at two levels.  This
+customization also applies to "git-diff-tree-helper".
+
+1. When the environment variable 'GIT_EXTERNAL_DIFF' is not set,
+   these commands internally invoke "diff" like this:
+
+      diff -L a/<path> -L a/<path> -pu <old> <new>
+
+   For added files, `/dev/null` is used for <old>.  For removed
+   files, `/dev/null` is used for <new>
+
+   The "diff" formatting options can be customized via the
+   environment variable 'GIT_DIFF_OPTS'.  For example, if you
+   prefer context diff:
+
+	  GIT_DIFF_OPTS=-c git-diff-cache -p $(cat .git/HEAD)
+
+
+2. When the environment variable 'GIT_EXTERNAL_DIFF' is set, the
+   program named by it is called, instead of the diff invocation
+   described above.
++
+For a path that is added, removed, or modified,
+'GIT_EXTERNAL_DIFF' is called with 7 parameters:
+
+     path old-file old-hex old-mode new-file new-hex new-mode
++
+where:
+
+     <old|new>-file:: are files GIT_EXTERNAL_DIFF can use to read the
+		      contents of <old|ne>,
+     <old|new>-hex:: are the 40-hexdigit SHA1 hashes,
+     <old|new>-mode:: are the octal representation of the file modes.
+
++ 
+The file parameters can point at the user's working file
+(e.g. `new-file` in "git-diff-files"), `/dev/null` (e.g. `old-file`
+when a new file is added), or a temporary file (e.g. `old-file` in the
+cache).  'GIT_EXTERNAL_DIFF' should not worry about unlinking the
+temporary file --- it is removed when 'GIT_EXTERNAL_DIFF' exits.
+
+For a path that is unmerged, 'GIT_EXTERNAL_DIFF' is called with 1
+parameter, <path>.
Created: Documentation/split_docs.pl (mode:100644)
--- /dev/null
+++ b/Documentation/split_docs.pl
@@ -0,0 +1,44 @@
+#!/usr/bin/perl -w
+use strict;
+
+my $cmd;
+my $name;
+
+my $author;
+
+while (<STDIN>) {
+  if (/^NAME$/ || eof(STDIN)) {
+    if ($cmd) {
+      print PAGE $author if defined($author);
+      print PAGE "Documentation\n--------------\nDocumentation by David Greaves, Junio C Hamano and the git-list <git\@vger.kernel.org>.\n\n";
+      print PAGE "GIT\n---\nPart of the link:git.html[git] suite\n\n";
+
+      if ($#ARGV || $ARGV[0] eq "-html") {
+	system(qw(asciidoc -b css-embedded -d manpage), "$cmd.txt");
+      } elsif ($ARGV[0] eq "-man") {
+	system(qw(asciidoc -b docbook -d manpage), "$cmd.txt");
+	system(qw(xmlto man), "$cmd.xml") if -e "$cmd.xml";
+      }
+    }
+    exit if eof(STDIN);
+    $_=<STDIN>;$_=<STDIN>; # discard underline and get command
+    chomp;
+    $name = $_;
+    ($cmd) = split(' ',$_);
+    print "$name\n";
+    open(PAGE, "> $cmd.txt") or die;
+    print PAGE "$cmd(1)\n==="."="x length($cmd);
+    print PAGE "\nv0.1, May 2005\n\nNAME\n----\n$name\n\n";
+
+
+    $author = "Author\n------\nWritten by Linus Torvalds <torvalds\@osdl.org>\n\n";
+
+    next;
+  }
+  next unless $cmd;
+
+  $author=undef if /^AUTHOR$/i; # don't use default for commands with an author
+
+  print PAGE $_;
+
+}

--------------060705060408090209050609--
