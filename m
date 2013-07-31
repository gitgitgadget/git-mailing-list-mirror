From: Dirk Wallenstein <halsmit@t-online.de>
Subject: [PATCH 2/2] howto: Eliminate all tabs
Date: Wed, 31 Jul 2013 18:54:25 +0200
Message-ID: <20130731165425.GC11219@bottich>
References: <20130716180158.GA7524@bottich>
 <cover.1375288760.git.halsmit@t-online.de>
 <4d37bfa3326469ab5b7cdbf0018f7aa671c2d74a.1375288760.git.halsmit@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junio@vger.kernel.org, Thomas Ackermann <th.acker@arcor.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 31 18:54:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4Zfl-0007fy-ME
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 18:54:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760572Ab3GaQyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 12:54:41 -0400
Received: from mailout02.t-online.de ([194.25.134.17]:49993 "EHLO
	mailout02.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760565Ab3GaQyk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 12:54:40 -0400
Received: from fwd09.aul.t-online.de (fwd09.aul.t-online.de )
	by mailout02.t-online.de with smtp 
	id 1V4Zfa-0001xS-Ot; Wed, 31 Jul 2013 18:54:38 +0200
Received: from localhost (Tv1ibEZcwhmhvsK9DstQR9LBossjun4DcGR7rIDZ1A9BytzxCUDJw2SYmo-p1RFZ9X@[78.94.248.235]) by fwd09.t-online.de
	with esmtp id 1V4ZfQ-01zSxU0; Wed, 31 Jul 2013 18:54:28 +0200
Content-Disposition: inline
In-Reply-To: <4d37bfa3326469ab5b7cdbf0018f7aa671c2d74a.1375288760.git.halsmit@t-online.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ID: Tv1ibEZcwhmhvsK9DstQR9LBossjun4DcGR7rIDZ1A9BytzxCUDJw2SYmo-p1RFZ9X
X-TOI-MSGID: 75714fff-a0ba-4776-ad7b-15dcd9b95939
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231432>

Because tabs have a variable width, the layout can diverge from what the
author intended.  Replace all tabs with spaces to the next column that
is a multiple of 8.

This fixes several ascii art sketches and a code example where viewing
it with a tab-width other than 8 lead to wrong indentation.

Signed-off-by: Dirk Wallenstein <halsmit@t-online.de>
---
 .../howto/rebase-from-internal-branch.txt          |  8 ++--
 Documentation/howto/rebuild-from-update-hook.txt   |  4 +-
 .../howto/recover-corrupted-blob-object.txt        | 50 +++++++++++-----------
 Documentation/howto/revert-a-faulty-merge.txt      | 16 +++----
 Documentation/howto/revert-branch-rebase.txt       |  2 +-
 Documentation/howto/update-hook-example.txt        |  8 ++--
 Documentation/howto/use-git-daemon.txt             | 10 ++---
 7 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/Documentation/howto/rebase-from-internal-branch.txt b/Documentation/howto/rebase-from-internal-branch.txt
index 19ab604..aefe5b1 100644
--- a/Documentation/howto/rebase-from-internal-branch.txt
+++ b/Documentation/howto/rebase-from-internal-branch.txt
@@ -1,8 +1,8 @@
-From:	Junio C Hamano <gitster@pobox.com>
-To:	git@vger.kernel.org
-Cc:	Petr Baudis <pasky@suse.cz>, Linus Torvalds <torvalds@osdl.org>
+From:Junio C Hamano <gitster@pobox.com>
+To:     git@vger.kernel.org
+Cc:     Petr Baudis <pasky@suse.cz>, Linus Torvalds <torvalds@osdl.org>
 Subject: Re: sending changesets from the middle of a git tree
-Date:	Sun, 14 Aug 2005 18:37:39 -0700
+Date:   Sun, 14 Aug 2005 18:37:39 -0700
 Abstract: In this article, JC talks about how he rebases the
  public "pu" branch using the core Git tools when he updates
  the "master" branch, and how "rebase" works.  Also discussed
diff --git a/Documentation/howto/rebuild-from-update-hook.txt b/Documentation/howto/rebuild-from-update-hook.txt
index 25378f6..97365ff 100644
--- a/Documentation/howto/rebuild-from-update-hook.txt
+++ b/Documentation/howto/rebuild-from-update-hook.txt
@@ -19,8 +19,8 @@ when I took over Git maintainership from Linus.
 
 The directories relevant to this how-to are these two:
 
-    /pub/scm/git/git.git/	The public Git repository.
-    /pub/software/scm/git/docs/	The HTML documentation page.
+    /pub/scm/git/git.git/       The public Git repository.
+    /pub/software/scm/git/docs/ The HTML documentation page.
 
 So I made a repository to generate the documentation under my
 home directory over there.
diff --git a/Documentation/howto/recover-corrupted-blob-object.txt b/Documentation/howto/recover-corrupted-blob-object.txt
index 1b3b188..6a8cc49 100644
--- a/Documentation/howto/recover-corrupted-blob-object.txt
+++ b/Documentation/howto/recover-corrupted-blob-object.txt
@@ -62,22 +62,22 @@ we now know which tree points to it!
 
 Now you can do
 
-	git ls-tree 2d9263c6d23595e7cb2a21e5ebbb53655278dff8
+        git ls-tree 2d9263c6d23595e7cb2a21e5ebbb53655278dff8
 
 which will show something like
 
-	100644 blob 8d14531846b95bfa3564b58ccfb7913a034323b8    .gitignore
-	100644 blob ebf9bf84da0aab5ed944264a5db2a65fe3a3e883    .mailmap
-	100644 blob ca442d313d86dc67e0a2e5d584b465bd382cbf5c    COPYING
-	100644 blob ee909f2cc49e54f0799a4739d24c4cb9151ae453    CREDITS
-	040000 tree 0f5f709c17ad89e72bdbbef6ea221c69807009f6    Documentation
-	100644 blob 1570d248ad9237e4fa6e4d079336b9da62d9ba32    Kbuild
-	100644 blob 1c7c229a092665b11cd46a25dbd40feeb31661d9    MAINTAINERS
-	...
+        100644 blob 8d14531846b95bfa3564b58ccfb7913a034323b8    .gitignore
+        100644 blob ebf9bf84da0aab5ed944264a5db2a65fe3a3e883    .mailmap
+        100644 blob ca442d313d86dc67e0a2e5d584b465bd382cbf5c    COPYING
+        100644 blob ee909f2cc49e54f0799a4739d24c4cb9151ae453    CREDITS
+        040000 tree 0f5f709c17ad89e72bdbbef6ea221c69807009f6    Documentation
+        100644 blob 1570d248ad9237e4fa6e4d079336b9da62d9ba32    Kbuild
+        100644 blob 1c7c229a092665b11cd46a25dbd40feeb31661d9    MAINTAINERS
+        ...
 
 and you should now have a line that looks like
 
-	10064 blob 4b9458b3786228369c63936db65827de3cc06200	my-magic-file
+        10064 blob 4b9458b3786228369c63936db65827de3cc06200     my-magic-file
 
 in the output. This already tells you a *lot* it tells you what file the
 corrupt blob came from!
@@ -87,7 +87,7 @@ Now, it doesn't tell you quite enough, though: it doesn't tell what
 lucky, and it may be the version that you already have checked out in your
 working tree, in which case fixing this problem is really simple, just do
 
-	git hash-object -w my-magic-file
+        git hash-object -w my-magic-file
 
 again, and if it outputs the missing SHA-1 (4b945..) you're now all done!
 
@@ -96,26 +96,26 @@ version that was broken. How do you tell which version it was?
 
 The easiest way to do it is to do
 
-	git log --raw --all --full-history -- subdirectory/my-magic-file
+        git log --raw --all --full-history -- subdirectory/my-magic-file
 
 and that will show you the whole log for that file (please realize that
 the tree you had may not be the top-level tree, so you need to figure out
 which subdirectory it was in on your own), and because you're asking for
 raw output, you'll now get something like
 
-	commit abc
-	Author:
-	Date:
-	  ..
-	:100644 100644 4b9458b... newsha... M  somedirectory/my-magic-file
+        commit abc
+        Author:
+        Date:
+          ..
+        :100644 100644 4b9458b... newsha... M  somedirectory/my-magic-file
 
 
-	commit xyz
-	Author:
-	Date:
+        commit xyz
+        Author:
+        Date:
 
-	  ..
-	:100644 100644 oldsha... 4b9458b... M	somedirectory/my-magic-file
+          ..
+        :100644 100644 oldsha... 4b9458b... M   somedirectory/my-magic-file
 
 and this actually tells you what the *previous* and *subsequent* versions
 of that file were! So now you can look at those ("oldsha" and "newsha"
@@ -125,13 +125,13 @@ newer versions!
 
 If you can do that, you can now recreate the missing object with
 
-	git hash-object -w <recreated-file>
+        git hash-object -w <recreated-file>
 
 and your repository is good again!
 
 (Btw, you could have ignored the fsck, and started with doing a
 
-	git log --raw --all
+        git log --raw --all
 
 and just looked for the sha of the missing object (4b9458b..) in that
 whole thing. It's up to you - Git does *have* a lot of information, it is
@@ -141,4 +141,4 @@ Trying to recreate trees and especially commits is *much* harder. So you
 were lucky that it's a blob. It's quite possible that you can recreate the
 thing.
 
-			Linus
+                        Linus
diff --git a/Documentation/howto/revert-a-faulty-merge.txt b/Documentation/howto/revert-a-faulty-merge.txt
index 075418e..4b75bfc 100644
--- a/Documentation/howto/revert-a-faulty-merge.txt
+++ b/Documentation/howto/revert-a-faulty-merge.txt
@@ -30,7 +30,7 @@ The history immediately after the "revert of the merge" would look like
 this:
 
  ---o---o---o---M---x---x---W
-	       /
+               /
        ---A---B
 
 where A and B are on the side development that was not so good, M is the
@@ -47,7 +47,7 @@ After the developers of the side branch fix their mistakes, the history
 may look like this:
 
  ---o---o---o---M---x---x---W---x
-	       /
+               /
        ---A---B-------------------C---D
 
 where C and D are to fix what was broken in A and B, and you may already
@@ -81,7 +81,7 @@ In such a situation, you would want to first revert the previous revert,
 which would make the history look like this:
 
  ---o---o---o---M---x---x---W---x---Y
-	       /
+               /
        ---A---B-------------------C---D
 
 where Y is the revert of W.  Such a "revert of the revert" can be done
@@ -93,14 +93,14 @@ This history would (ignoring possible conflicts between what W and W..Y
 changed) be equivalent to not having W nor Y at all in the history:
 
  ---o---o---o---M---x---x-------x----
-	       /
+               /
        ---A---B-------------------C---D
 
 and merging the side branch again will not have conflict arising from an
 earlier revert and revert of the revert.
 
  ---o---o---o---M---x---x-------x-------*
-	       /                       /
+               /                       /
        ---A---B-------------------C---D
 
 Of course the changes made in C and D still can conflict with what was
@@ -111,13 +111,13 @@ faulty A and B, and redone the changes on top of the updated mainline
 after the revert, the history would have looked like this:
 
  ---o---o---o---M---x---x---W---x---x
-	       /                 \
+               /                 \
        ---A---B                   A'--B'--C'
 
 If you reverted the revert in such a case as in the previous example:
 
  ---o---o---o---M---x---x---W---x---x---Y---*
-	       /                 \         /
+               /                 \         /
        ---A---B                   A'--B'--C'
 
 where Y is the revert of W, A' and B' are rerolled A and B, and there may
@@ -129,7 +129,7 @@ lot of overlapping changes that result in conflicts.  So do not do "revert
 of revert" blindly without thinking..
 
  ---o---o---o---M---x---x---W---x---x
-	       /                 \
+               /                 \
        ---A---B                   A'--B'--C'
 
 In the history with rebased side branch, W (and M) are behind the merge
diff --git a/Documentation/howto/revert-branch-rebase.txt b/Documentation/howto/revert-branch-rebase.txt
index 0d5419e..bad54a1 100644
--- a/Documentation/howto/revert-branch-rebase.txt
+++ b/Documentation/howto/revert-branch-rebase.txt
@@ -154,7 +154,7 @@ $ git pull . master
 Packing 0 objects
 Unpacking 0 objects
 
-* committish: e3a693c...	refs/heads/master from .
+* committish: e3a693c...        refs/heads/master from .
 Trying to merge e3a693c... into 8c1f5f0... using 10d781b...
 Committed merge 7fb9b7262a1d1e0a47bbfdcbbcf50ce0635d3f8f
  cache.h        |    8 ++++----
diff --git a/Documentation/howto/update-hook-example.txt b/Documentation/howto/update-hook-example.txt
index a5193b1..40a35b1 100644
--- a/Documentation/howto/update-hook-example.txt
+++ b/Documentation/howto/update-hook-example.txt
@@ -51,19 +51,19 @@ verbose=false
 GLOBIGNORE=*
 
 function grant {
-  $verbose && echo >&2 "-Grant-		$1"
+  $verbose && echo >&2 "-Grant-         $1"
   echo grant
   exit 0
 }
 
 function deny {
-  $verbose && echo >&2 "-Deny-		$1"
+  $verbose && echo >&2 "-Deny-          $1"
   echo deny
   exit 1
 }
 
 function info {
-  $verbose && echo >&2 "-Info-		$1"
+  $verbose && echo >&2 "-Info-          $1"
 }
 
 # Implement generic branch and tag policies.
@@ -83,7 +83,7 @@ case "$1" in
       mb=$(git-merge-base "$2" "$3")
       case "$mb,$2" in
         "$2,$mb") info "Update is fast-forward" ;;
-	*)	  noff=y; info "This is not a fast-forward update.";;
+        *)        noff=y; info "This is not a fast-forward update.";;
       esac
     fi
     ;;
diff --git a/Documentation/howto/use-git-daemon.txt b/Documentation/howto/use-git-daemon.txt
index 7af2e52..6b33d85 100644
--- a/Documentation/howto/use-git-daemon.txt
+++ b/Documentation/howto/use-git-daemon.txt
@@ -12,11 +12,11 @@ things do not go according to plan (e.g. a socket could not be bound).
 
 Another word of warning: if you run
 
-	$ git ls-remote git://127.0.0.1/rule-the-world.git
+        $ git ls-remote git://127.0.0.1/rule-the-world.git
 
 and you see a message like
 
-	fatal: The remote end hung up unexpectedly
+        fatal: The remote end hung up unexpectedly
 
 it only means that _something_ went wrong. To find out _what_ went wrong,
 you have to ask the server. (Git refuses to be more precise for your
@@ -25,8 +25,8 @@ Sorry, not allowed -- who knows what you planned to do with them?)
 
 With these two caveats, let's see an example:
 
-	$ git daemon --reuseaddr --verbose --base-path=/home/gitte/git \
-	  --export-all -- /home/gitte/git/rule-the-world.git
+        $ git daemon --reuseaddr --verbose --base-path=/home/gitte/git \
+          --export-all -- /home/gitte/git/rule-the-world.git
 
 (Of course, unless your user name is `gitte` _and_ your repository is in
 ~/rule-the-world.git, you have to adjust the paths. If your repository is
@@ -49,6 +49,6 @@ a good practice to put the paths after a "--" separator.
 
 Now, test your daemon with
 
-	$ git ls-remote git://127.0.0.1/rule-the-world.git
+        $ git ls-remote git://127.0.0.1/rule-the-world.git
 
 If this does not work, find out why, and submit a patch to this document.
-- 
1.8.3.3.2.g85103ba
