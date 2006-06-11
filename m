From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: [PATCH] The name of the hash is SHA-1, use it consistently in Documentation
Date: Sun, 11 Jun 2006 16:37:47 -0400
Message-ID: <11500582682293-git-send-email-vonbrand@inf.utfsm.cl>
Reply-To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 11 22:38:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpWhO-0002eH-Qr
	for gcvg-git@gmane.org; Sun, 11 Jun 2006 22:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWFKUiK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 16:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbWFKUiK
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 16:38:10 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:5268 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1750965AbWFKUiI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jun 2006 16:38:08 -0400
Received: from laptop11.inf.utfsm.cl (pc-192-170-104-200.cm.vtr.net [200.104.170.192])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k5BKbr81019435
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 11 Jun 2006 16:37:58 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6) with ESMTP id k5BKbnMM007325
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 11 Jun 2006 16:37:54 -0400
Received: (from vonbrand@localhost)
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6/Submit) id k5BKbmR2007323;
	Sun, 11 Jun 2006 16:37:48 -0400
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.0.g1b2d
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Sun, 11 Jun 2006 16:38:00 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21667>

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 Documentation/config.txt           |    2 +-
 Documentation/core-tutorial.txt    |    8 ++++----
 Documentation/diff-format.txt      |    8 ++++----
 Documentation/diffcore.txt         |    2 +-
 Documentation/git-branch.txt       |    2 +-
 Documentation/git-cat-file.txt     |    2 +-
 Documentation/git-checkout.txt     |    2 +-
 Documentation/git-cherry.txt       |    4 ++--
 Documentation/git-diff-index.txt   |    8 ++++----
 Documentation/git-fsck-objects.txt |    8 ++++----
 Documentation/git-init-db.txt      |    2 +-
 Documentation/git-ls-files.txt     |    2 +-
 Documentation/git-merge-index.txt  |    2 +-
 Documentation/git-mktag.txt        |    6 +++---
 Documentation/git-name-rev.txt     |    2 +-
 Documentation/git-patch-id.txt     |    2 +-
 Documentation/git-push.txt         |    2 +-
 Documentation/git-receive-pack.txt |    4 ++--
 Documentation/git-rev-parse.txt    |    8 ++++----
 Documentation/git-show-branch.txt  |    4 ++--
 Documentation/git-show-index.txt   |    2 +-
 Documentation/git-tag.txt          |    2 +-
 Documentation/git-unpack-file.txt  |    2 +-
 Documentation/git-update-index.txt |   14 +++++++-------
 Documentation/git-verify-pack.txt  |    4 ++--
 Documentation/git-verify-tag.txt   |    2 +-
 Documentation/git.txt              |    2 +-
 Documentation/glossary.txt         |    4 ++--
 Documentation/tutorial-2.txt       |   14 +++++++-------
 29 files changed, 63 insertions(+), 63 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a04c5ad..169640a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -72,7 +72,7 @@ core.preferSymlinkRefs::
 
 core.logAllRefUpdates::
 	If true, `git-update-ref` will append a line to
-	"$GIT_DIR/logs/<ref>" listing the new SHA1 and the date/time
+	"$GIT_DIR/logs/<ref>" listing the new SHA-1 and the date/time
 	of the update.	If the file does not exist it will be
 	created automatically.	This information can be used to
 	determine what commit was the tip of a branch "2 days ago".
diff --git a/Documentation/core-tutorial.txt b/Documentation/core-tutorial.txt
index 1185897..151434b 100644
--- a/Documentation/core-tutorial.txt
+++ b/Documentation/core-tutorial.txt
@@ -100,9 +100,9 @@ branch. A number of the git tools will a
 valid, though.
 
 [NOTE]
-An 'object' is identified by its 160-bit SHA1 hash, aka 'object name',
+An 'object' is identified by its 160-bit SHA-1 hash, aka 'object name',
 and a reference to an object is always the 40-byte hex
-representation of that SHA1 name. The files in the `refs`
+representation of that SHA-1 name. The files in the `refs`
 subdirectory are expected to contain these hex references
 (usually with a final `\'\n\'` at the end), and you should thus
 expect to see a number of 41-byte files containing these
@@ -772,7 +772,7 @@ already discussed, the `HEAD` branch is 
 these object pointers. 
 
 You can at any time create a new branch by just picking an arbitrary
-point in the project history, and just writing the SHA1 name of that
+point in the project history, and just writing the SHA-1 name of that
 object into a file under `.git/refs/heads/`. You can use any filename you
 want (and indeed, subdirectories), but the convention is that the
 "normal" branch is called `master`. That's just a convention, though,
@@ -1260,7 +1260,7 @@ file (the first tree goes to stage 1, th
 etc.).  After reading three trees into three stages, the paths
 that are the same in all three stages are 'collapsed' into stage
 0.  Also paths that are the same in two of three stages are
-collapsed into stage 0, taking the SHA1 from either stage 2 or
+collapsed into stage 0, taking the SHA-1 from either stage 2 or
 stage 3, whichever is different from stage 1 (i.e. only one side
 changed from the common ancestor).
 
diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
index 617d8f5..d0d08bb 100644
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -35,9 +35,9 @@ That is, from the left to the right:
 . a space.
 . mode for "dst"; 000000 if deletion or unmerged.
 . a space.
-. sha1 for "src"; 0\{40\} if creation or unmerged.
+. SHA-1 for "src"; 0\{40\} if creation or unmerged.
 . a space.
-. sha1 for "dst"; 0\{40\} if creation, unmerged or "look at work tree".
+. SHA-1 for "dst"; 0\{40\} if creation, unmerged or "look at work tree".
 . a space.
 . status, followed by optional "score" number.
 . a tab or a NUL when '-z' option is used.
@@ -46,7 +46,7 @@ That is, from the left to the right:
 . path for "dst"; only exists for C or R.
 . an LF or a NUL when '-z' option is used, to terminate the record.
 
-<sha1> is shown as all 0's if a file is new on the filesystem
+<SHA-1> is shown as all 0's if a file is new on the filesystem
 and it is out of sync with the index.
 
 Example:
@@ -97,7 +97,7 @@ where:
 
      <old|new>-file:: are files GIT_EXTERNAL_DIFF can use to read the
 		      contents of <old|new>,
-     <old|new>-hex:: are the 40-hexdigit SHA1 hashes,
+     <old|new>-hex:: are the 40-hexdigit SHA-1 hashes,
      <old|new>-mode:: are the octal representation of the file modes.
 
 + 
diff --git a/Documentation/diffcore.txt b/Documentation/diffcore.txt
index cb4e562..984bb2b 100644
--- a/Documentation/diffcore.txt
+++ b/Documentation/diffcore.txt
@@ -115,7 +115,7 @@ it changes it to:
 For the purpose of breaking a filepair, diffcore-break examines
 the extent of changes between the contents of the files before
 and after modification (i.e. the contents that have "bcd1234..."
-and "0123456..." as their SHA1 content ID, in the above
+and "0123456..." as their SHA-1 content ID, in the above
 example).  The amount of deletion of original contents and
 insertion of new material are added together, and if it exceeds
 the "break score", the filepair is broken into two.  The break
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index d43ef1d..e16944d 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -38,7 +38,7 @@ OPTIONS
 -l::
 	Create the branch's ref log.  This activates recording of
 	all changes to made the branch ref, enabling use of date
-	based sha1 expressions such as "<branchname>@{yesterday}".
+	based SHA-1 expressions such as "<branchname>@{yesterday}".
 
 -f::
 	Force the creation of a new branch even if it means deleting
diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 5e9cbf8..8aa9fcb 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -19,7 +19,7 @@ or '-s' is used to find the object size.
 OPTIONS
 -------
 <object>::
-	The sha1 identifier of the object.
+	The SHA-1 identifier of the object.
 
 -t::
 	Instead of the content, show the object type identified by
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index fbdbadc..77db0b3 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -43,7 +43,7 @@ OPTIONS
 -l::
 	Create the new branch's ref log.  This activates recording of
 	all changes to made the branch ref, enabling use of date
-	based sha1 expressions such as "<branchname>@{yesterday}".
+	based SHA-1 expressions such as "<branchname>@{yesterday}".
 
 -m::
 	If you have local modifications to one or more files that
diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.txt
index 893baaa..5c783d4 100644
--- a/Documentation/git-cherry.txt
+++ b/Documentation/git-cherry.txt
@@ -15,12 +15,12 @@ The changeset (or "diff") of each commit
 is compared against each commit between the fork-point and <upstream>.
 
 Every commit with a changeset that doesn't exist in the other branch
-has its id (sha1) reported, prefixed by a symbol.  Those existing only
+has its id (SHA-1) reported, prefixed by a symbol.  Those existing only
 in the <upstream> branch are prefixed with a minus (-) sign, and those
 that only exist in the <head> branch are prefixed with a plus (+) symbol.
 
 Because git-cherry compares the changeset rather than the commit id
-(sha1), you can use git-cherry to find out if a commit you made locally
+(SHA-1), you can use git-cherry to find out if a commit you made locally
 has been applied <upstream> under a different commit id.  For example,
 this will happen if you're feeding patches <upstream> via email rather
 than pushing or pulling commits directly.
diff --git a/Documentation/git-diff-index.txt b/Documentation/git-diff-index.txt
index 9cd43f1..750d646 100644
--- a/Documentation/git-diff-index.txt
+++ b/Documentation/git-diff-index.txt
@@ -93,7 +93,7 @@ you *could* commit. Again, the output ma
 output to a tee, but with a twist.
 
 The twist is that if some file doesn't match the index, we don't have
-a backing store thing for it, and we use the magic "all-zero" sha1 to
+a backing store thing for it, and we use the magic "all-zero" SHA-1 to
 show that. So let's say that you have edited `kernel/sched.c`, but
 have not actually done a "git-update-index" on it yet - there is no
 "object" associated with the new state, and you get:
@@ -102,7 +102,7 @@ have not actually done a "git-update-ind
   *100644->100664 blob    7476bb......->000000......      kernel/sched.c
 
 i.e., it shows that the tree has changed, and that `kernel/sched.c` has is
-not up-to-date and may contain new stuff. The all-zero sha1 means that to
+not up-to-date and may contain new stuff. The all-zero SHA-1 means that to
 get the real diff, you need to look at the object in the working directory
 directly rather than do an object-to-object diff.
 
@@ -115,8 +115,8 @@ touched it. In either case, it's a note 
 NOTE: You can have a mixture of files show up as "has been updated"
 and "is still dirty in the working directory" together. You can always
 tell which file is in which state, since the "has been updated" ones
-show a valid sha1, and the "not in sync with the index" ones will
-always have the special all-zero sha1.
+show a valid SHA-1, and the "not in sync with the index" ones will
+always have the special all-zero SHA-1.
 
 
 Author
diff --git a/Documentation/git-fsck-objects.txt b/Documentation/git-fsck-objects.txt
index d0af99d..78c6b59 100644
--- a/Documentation/git-fsck-objects.txt
+++ b/Documentation/git-fsck-objects.txt
@@ -22,7 +22,7 @@ OPTIONS
 	An object to treat as the head of an unreachability trace.
 +
 If no objects are given, git-fsck-objects defaults to using the
-index file and all SHA1 references in .git/refs/* as heads.
+index file and all SHA-1 references in .git/refs/* as heads.
 
 --unreachable::
 	Print out objects that exist but that aren't readable from any
@@ -55,7 +55,7 @@ index file and all SHA1 references in .g
 	objects that triggers this check, but it is recommended
 	to check new projects with this flag.
 
-It tests SHA1 and general object sanity, and it does full tracking of
+It tests SHA-1 and general object sanity, and it does full tracking of
 the resulting reachability and everything else. It prints out any
 corruption it finds (missing or bad objects), and if you use the
 '--unreachable' flag it will also print out objects that exist but
@@ -87,7 +87,7 @@ expect dangling commits - potential head
 	root nodes.
 
 missing sha1 directory '<dir>'::
-	The directory holding the sha1 objects is missing.
+	The directory holding the SHA-1 objects is missing.
 
 unreachable <type> <object>::
 	The <type> object <object>, isn't actually referred to directly
@@ -109,7 +109,7 @@ warning: git-fsck-objects: tree <tree> h
 	And it shouldn't...
 
 sha1 mismatch <object>::
-	The database has an object who's sha1 doesn't match the
+	The database has an object who's SHA-1 doesn't match the
 	database value.
 	This indicates a serious data integrity problem.
 
diff --git a/Documentation/git-init-db.txt b/Documentation/git-init-db.txt
index 8a150d8..9ebd7d2 100644
--- a/Documentation/git-init-db.txt
+++ b/Documentation/git-init-db.txt
@@ -39,7 +39,7 @@ If the `$GIT_DIR` environment variable i
 to use instead of `./.git` for the base of the repository.
 
 If the object storage directory is specified via the `$GIT_OBJECT_DIRECTORY`
-environment variable then the sha1 directories are created underneath -
+environment variable then the SHA-1 directories are created underneath -
 otherwise the default `$GIT_DIR/objects` directory is used.
 
 A shared repository allows users belonging to the same group to push into that
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 4d8a2ad..be85561 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -123,7 +123,7 @@ which case it outputs:
 "git-ls-files --unmerged" and "git-ls-files --stage" can be used to examine
 detailed information on unmerged paths.
 
-For an unmerged path, instead of recording a single mode/SHA1 pair,
+For an unmerged path, instead of recording a single mode/SHA-1 pair,
 the dircache records up to three such pairs; one from tree O in stage
 1, A in stage 2, and B in stage 3.  This information can be used by
 the user (or the porcelain) to see what should eventually be recorded at the
diff --git a/Documentation/git-merge-index.txt b/Documentation/git-merge-index.txt
index 6cd0601..eb8e019 100644
--- a/Documentation/git-merge-index.txt
+++ b/Documentation/git-merge-index.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 This looks up the <file>(s) in the index and, if there are any merge
-entries, passes the SHA1 hash for those files as arguments 1, 2, 3 (empty
+entries, passes the SHA-1 hash for those files as arguments 1, 2, 3 (empty
 argument if no file), and <file> as argument 4.  File modes for the three
 files are passed as arguments 5, 6 and 7.
 
diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
index 2860a3d..d78d2dc 100644
--- a/Documentation/git-mktag.txt
+++ b/Documentation/git-mktag.txt
@@ -19,9 +19,9 @@ The output is the new tag's <object> ide
 
 Tag Format
 ----------
-A tag signature file has a very simple fixed format: three lines of
+A tag signature file has a very simple fixed format: Three lines of
 
-  object <sha1>
+  object <SHA-1>
   type <typename>
   tag <tagname>
 
@@ -30,7 +30,7 @@ doesn't care about, but that can be veri
 
 The size of the full object is artificially limited to 8kB.  (Just
 because I'm a lazy bastard, and if you can't fit a signature in that
-size, you're doing something wrong)
+size, you're doing something wrong.)
 
 
 Author
diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index 39a1434..0c8e8e3 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -26,7 +26,7 @@ OPTIONS
 	List all commits reachable from all refs
 
 --stdin::
-	Read from stdin, append "(<rev_name>)" to all sha1's of name'able
+	Read from stdin, append "(<rev_name>)" to all SHA-1s of name'able
 	commits, and pass to stdout
 
 EXAMPLE
diff --git a/Documentation/git-patch-id.txt b/Documentation/git-patch-id.txt
index 5389097..f57d2b2 100644
--- a/Documentation/git-patch-id.txt
+++ b/Documentation/git-patch-id.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-A "patch ID" is nothing but a SHA1 of the diff associated with a patch, with
+A "patch ID" is nothing but a SHA-1 of the diff associated with a patch, with
 whitespace and line numbers ignored.  As such, it's "reasonably stable", but at
 the same time also reasonably unique, i.e., two patches that have the same "patch
 ID" are almost guaranteed to be the same thing.
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index d5b5ca1..3cb33d7 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -34,7 +34,7 @@ OPTIONS
 	the destination ref.
 +
 The <src> side can be an
-arbitrary "SHA1 expression" that can be used as an
+arbitrary "SHA-1 expression" that can be used as an
 argument to `git-cat-file -t`.  E.g. `master~4` (push
 four parents before the current master head).
 +
diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 60debca..ad91e24 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -21,7 +21,7 @@ program pair is meant to be used to push
 repository.  For pull operations, see 'git-fetch-pack' and
 'git-clone-pack'.
 
-The command allows for creation and fast forwarding of sha1 refs
+The command allows for creation and fast forwarding of SHA-1 refs
 (heads/tags) on the remote end (strictly speaking, it is the
 local end receive-pack runs, but to the user who is sitting at
 the send-pack end, it is updating the remote.  Confused?)
@@ -32,7 +32,7 @@ and executable, it is called with three 
        $GIT_DIR/hooks/update refname sha1-old sha1-new
 
 The refname parameter is relative to $GIT_DIR; e.g. for the
-master head this is "refs/heads/master".  Two sha1 are the
+master head this is "refs/heads/master".  Two SHA-1s are the
 object names for the refname before and after the update.  Note
 that the hook is called before the refname is updated, so either
 sha1-old is 0{40} (meaning there is no such ref yet), or it
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 627cde8..25098bd 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -59,7 +59,7 @@ OPTIONS
 	one.
 
 --symbolic::
-	Usually the object names are output in SHA1 form (with
+	Usually the object names are output in SHA-1 form (with
 	possible '{caret}' prefix); this option makes them output in a
 	form as close to the original input as possible.
 
@@ -90,7 +90,7 @@ OPTIONS
 	Show `$GIT_DIR` if defined else show the path to the .git directory.
 
 --short, --short=number::
-	Instead of outputting the full SHA1 values of object names try to
+	Instead of outputting the full SHA-1 values of object names try to
 	abbreviate them to a shorter unique name. When no length is specified
 	7 is used. The minimum length is 4.
 
@@ -110,10 +110,10 @@ SPECIFYING REVISIONS
 --------------------
 
 A revision parameter typically, but not necessarily, names a
-commit object.  They use what is called an 'extended SHA1'
+commit object.  They use what is called an 'extended SHA-1'
 syntax.
 
-* The full SHA1 object name (40-byte hexadecimal string), or
+* The full SHA-1 object name (40-byte hexadecimal string), or
   a substring of such that is unique within the repository.
   E.g. dae86e1950b1277e545cee180551750029cfe735 and dae86e both
   name the same commit object if there are no other object in
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index f115b45..8937428 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -28,7 +28,7 @@ no <rev> nor <glob> is given on the comm
 OPTIONS
 -------
 <rev>::
-	Arbitrary extended SHA1 expression (see `git-rev-parse`)
+	Arbitrary extended SHA-1 expression (see `git-rev-parse`)
 	that typically names a branch HEAD or a tag.
 
 <glob>::
@@ -97,7 +97,7 @@ displayed, indented N places.  If a comm
 branch, the I-th indentation character shows a `+` sign;
 otherwise it shows a space.  Merge commits are denoted by
 a `-` sign.  Each commit shows a short name that
-can be used as an extended SHA1 to name that commit.
+can be used as an extended SHA-1 to name that commit.
 
 The following example shows three branches, "master", "fixes"
 and "mhf":
diff --git a/Documentation/git-show-index.txt b/Documentation/git-show-index.txt
index be09b62..04f1d22 100644
--- a/Documentation/git-show-index.txt
+++ b/Documentation/git-show-index.txt
@@ -18,7 +18,7 @@ git-pack-objects command, and dumps its 
 
 The information it outputs is subset of what you can get from
 'git-verify-pack -v'; this command only shows the packfile
-offset and SHA1 of each object.
+offset and SHA-1 of each object.
 
 
 Author
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 45476c2..f0f7d8c 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -24,7 +24,7 @@ creates a 'tag' object, and requires the
 `-m <msg>` is given, an editor is started for the user to type
 in the tag message.
 
-Otherwise just the SHA1 object name of the commit object is
+Otherwise just the SHA-1 object name of the commit object is
 written (i.e. a lightweight tag).
 
 A GnuPG signed tag object will be created when `-s` or `-u
diff --git a/Documentation/git-unpack-file.txt b/Documentation/git-unpack-file.txt
index 213dc81..c7b3be1 100644
--- a/Documentation/git-unpack-file.txt
+++ b/Documentation/git-unpack-file.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Creates a file holding the contents of the blob specified by sha1. It
+Creates a file holding the contents of the blob specified by SHA-1. It
 returns the name of the temporary file in the following format:
 	.merge_file_XXXXX
 
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 3ae6e74..6135601 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -129,7 +129,7 @@ OPTIONS
 
 Using --refresh
 ---------------
-'--refresh' does not calculate a new sha1 file or bring the index
+'--refresh' does not calculate a new SHA-1 file or bring the index
 up-to-date for mode/content changes. But what it *does* do is to
 "re-match" the stat information of a file with the index, so that you
 can refresh the index for a file that hasn't been changed but where
@@ -144,10 +144,10 @@ Using --cacheinfo or --info-only
 current working directory.  This is useful for minimum-checkout
 merging.
 
-To pretend you have a file with mode and sha1 at path, say:
+To pretend you have a file with mode and SHA-1 at path, say:
 
 ----------------
-$ git-update-index --cacheinfo mode sha1 path
+$ git-update-index --cacheinfo mode SHA-1 path
 ----------------
 
 '--info-only' is used to register files without placing them in the object
@@ -167,19 +167,19 @@ Using --index-info
 multiple entry definitions from the standard input, and designed
 specifically for scripts.  It can take inputs of three formats:
 
-    . mode         SP sha1          TAB path
+    . mode         SP SHA-1          TAB path
 +
 The first format is what "git-apply --index-info"
 reports, and used to reconstruct a partial tree
 that is used for phony merge base tree when falling
 back on 3-way merge.
 
-    . mode SP type SP sha1          TAB path
+    . mode SP type SP SHA-1          TAB path
 +
 The second format is to stuff git-ls-tree output
 into the index file.
 
-    . mode         SP sha1 SP stage TAB path
+    . mode         SP SHA-1 SP stage TAB path
 +
 This format is to put higher order stages into the
 index file and matches git-ls-files --stage output.
@@ -205,7 +205,7 @@ you can feed the following input to `--i
 ------------
 
 The first line of the input feeds 0 as the mode to remove the
-path; the SHA1 does not matter as long as it is well formatted.
+path; the SHA-1 does not matter as long as it is well formatted.
 Then the second and third line feeds stage 1 and stage 2 entries
 for that path.  After the above, we would end up with this:
 
diff --git a/Documentation/git-verify-pack.txt b/Documentation/git-verify-pack.txt
index 7a6132b..4fa5923 100644
--- a/Documentation/git-verify-pack.txt
+++ b/Documentation/git-verify-pack.txt
@@ -32,11 +32,11 @@ OUTPUT FORMAT
 -------------
 When specifying the -v option the format used is:
 
-	SHA1 type size offset-in-packfile
+	SHA-1 type size offset-in-packfile
 
 for objects that are not deltified in the pack, and
 
-	SHA1 type size offset-in-packfile depth base-SHA1
+	SHA-1 type size offset-in-packfile depth base-SHA1
 
 for objects that are deltified.
 
diff --git a/Documentation/git-verify-tag.txt b/Documentation/git-verify-tag.txt
index 0f9bdb5..d610a8b 100644
--- a/Documentation/git-verify-tag.txt
+++ b/Documentation/git-verify-tag.txt
@@ -16,7 +16,7 @@ Validates the gpg signature created by g
 OPTIONS
 -------
 <tag>::
-	SHA1 identifier of a git tag object.
+	SHA-1 identifier of a git tag object.
 
 Author
 ------
diff --git a/Documentation/git.txt b/Documentation/git.txt
index d4472b5..2d454f8 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -585,7 +585,7 @@ git so take care if using Cogito etc.
 
 'GIT_OBJECT_DIRECTORY'::
 	If the object storage directory is specified via this
-	environment variable then the sha1 directories are created
+	environment variable then the SHA-1 directories are created
 	underneath - otherwise the default `$GIT_DIR/objects`
 	directory is used.
 
diff --git a/Documentation/glossary.txt b/Documentation/glossary.txt
index 116ddb7..e83cd42 100644
--- a/Documentation/glossary.txt
+++ b/Documentation/glossary.txt
@@ -163,7 +163,7 @@ merge::
 
 object::
 	The unit of storage in git. It is uniquely identified by
-	the SHA1 of its contents. Consequently, an object can not
+	the SHA-1 of its contents. Consequently, an object can not
 	be changed.
 
 object database::
@@ -243,7 +243,7 @@ rebase::
 	changes from that branch.
 
 ref::
-	A 40-byte hex representation of a SHA1 or a name that denotes
+	A 40-byte hex representation of a SHA-1 or a name that denotes
 	a particular object. These may be stored in `$GIT_DIR/refs/`.
 
 refspec::
diff --git a/Documentation/tutorial-2.txt b/Documentation/tutorial-2.txt
index 894ca5e..0dc91e7 100644
--- a/Documentation/tutorial-2.txt
+++ b/Documentation/tutorial-2.txt
@@ -32,9 +32,9 @@ with?
 
 We saw in part one of the tutorial that commits have names like this.
 It turns out that every object in the git history is stored under
-such a 40-digit hex name.  That name is the SHA1 hash of the object's
+such a 40-digit hex name.  That name is the SHA-1 hash of the object's
 contents; among other things, this ensures that git will never store
-the same data twice (since identical data is given an identical SHA1
+the same data twice (since identical data is given an identical SHA-1
 name), and that the contents of a git object will never change (since
 that would change the object's name as well).
 
@@ -51,14 +51,14 @@ A tree can refer to one or more "blob" o
 a file.  In addition, a tree can also refer to other tree objects,
 thus creating a directory hierarchy.  You can examine the contents of
 any tree using ls-tree (remember that a long enough initial portion
-of the SHA1 will also work):
+of the SHA-1 will also work):
 
 ------------------------------------------------
 $ git ls-tree 92b8b694
 100644 blob 3b18e512dba79e4c8300dd08aeb37f8e728b8dad    file.txt
 ------------------------------------------------
 
-Thus we see that this tree has one file in it.  The SHA1 hash is a
+Thus we see that this tree has one file in it.  The SHA-1 hash is a
 reference to that file's data:
 
 ------------------------------------------------
@@ -77,7 +77,7 @@ Note that this is the old file data; so 
 its response to the initial tree was a tree with a snapshot of the
 directory state that was recorded by the first commit.
 
-All of these objects are stored under their SHA1 names inside the git
+All of these objects are stored under their SHA-1 names inside the git
 directory:
 
 ------------------------------------------------
@@ -114,7 +114,7 @@ ref: refs/heads/master
 
 As you can see, this tells us which branch we're currently on, and it
 tells us this by naming a file under the .git directory, which itself
-contains a SHA1 name referring to a commit object, which we can
+contains a SHA-1 name referring to a commit object, which we can
 examine with cat-file:
 
 ------------------------------------------------
@@ -180,7 +180,7 @@ project's history:
 
 Note, by the way, that lots of commands take a tree as an argument.
 But as we can see above, a tree can be referred to in many different
-ways--by the SHA1 name for that tree, by the name of a commit that
+ways--by the SHA-1 name for that tree, by the name of a commit that
 refers to the tree, by the name of a branch whose head refers to that
 tree, etc.--and most such commands can accept any of these names.
 
-- 
1.4.0.g1b2d
