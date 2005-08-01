From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Updates to tutorial.txt
Date: Mon, 1 Aug 2005 16:33:19 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.20050801163147.12985@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Aug 01 16:34:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzbMK-0000O2-A3
	for gcvg-git@gmane.org; Mon, 01 Aug 2005 16:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbVHAOd3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Aug 2005 10:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbVHAOd2
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Aug 2005 10:33:28 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:52924 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S262084AbVHAOdU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2005 10:33:20 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id E6252E1B94
	for <git@vger.kernel.org>; Mon,  1 Aug 2005 16:33:19 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id C7CAD91BE5
	for <git@vger.kernel.org>; Mon,  1 Aug 2005 16:33:19 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id A96F991BB3
	for <git@vger.kernel.org>; Mon,  1 Aug 2005 16:33:19 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 9D8D9E1B94
	for <git@vger.kernel.org>; Mon,  1 Aug 2005 16:33:19 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Fix a few typos.
Adapt to git-http-pull not borking on packed repositories.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 Documentation/tutorial.txt |   36 +++++++++++++++++-------------------
 1 files changed, 17 insertions(+), 19 deletions(-)

161f6e2d135e2b24e6629aaf8be65ede4fdf1ad3
diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -241,7 +241,7 @@ creating the equivalent of a git "direct
 	git-write-tree

 and this will just output the name of the resulting tree, in this case
-(if you have does exactly as I've described) it should be
+(if you have done exactly as I've described) it should be

 	8988da15d077d4829fc51d8544c097def6644dbb

@@ -283,7 +283,7 @@ message ever again.

 Again, normally you'd never actually do this by hand.  There is a
 helpful script called "git commit" that will do all of this for you. So
-you could have just writtten
+you could have just written

 	git commit

@@ -312,7 +312,7 @@ have committed something, we can also le

 Unlike "git-diff-files", which showed the difference between the index
 file and the working directory, "git-diff-cache" shows the differences
-between a committed _tree_ and either the the index file or the working
+between a committed _tree_ and either the index file or the working
 directory.  In other words, git-diff-cache wants a tree to be diffed
 against, and before we did the commit, we couldn't do that, because we
 didn't have anything to diff against.
@@ -482,7 +482,7 @@ particular state.  You can, for example,

 to diff your current state against that tag (which at this point will
 obviously be an empty diff, but if you continue to develop and commit
-stuff, you can use your tag as a "anchor-point" to see what has changed
+stuff, you can use your tag as an "anchor-point" to see what has changed
 since you tagged it.

 A "signed tag" is actually a real git object, and contains not only a
@@ -800,16 +800,13 @@ pull from:

 	GIT URL
 		git://remote.machine/path/to/repo.git/
+
+	SSH URL
 		remote.machine:/path/to/repo.git/

 	Local directory
 		/path/to/repo.git/

-[ Side Note: currently, HTTP transport is slightly broken in
-  that when the remote repository is "packed" they do not always
-  work.  But we have not talked about packing repository yet, so
-  let's not worry too much about it for now.  ]
-
 [ Digression: you could do without using any branches at all, by
   keeping as many local repositories as you would like to have
   branches, and merging between them with "git pull", just like
@@ -829,7 +826,7 @@ directory, like this:
 	echo rsync://kernel.org/pub/scm/git/git.git/ \
 	    >.git/branches/linus

-and use the filenae to "git pull" instead of the full URL.
+and use the filename to "git pull" instead of the full URL.
 The contents of a file under .git/branches can even be a prefix
 of a full URL, like this:

@@ -983,10 +980,11 @@ would remove them for you.
 You can try running "find .git/objects -type f" before and after
 you run "git prune-packed" if you are curious.

-[ Side Note: as we already mentioned, "git pull" is broken for
-  some transports dealing with packed repositories right now, so
-  do not run "git prune-packed" if you plan to give "git pull"
-  access via HTTP transport for now.  ]
+[ Side Note: "git pull" is slightly cumbersome for HTTP transport,
+  as a packed repository may contain relatively few objects in a
+  relatively large pack. If you expect many HTTP pulls from your
+  public repository you might want to repack & prune often, or
+  never. ]

 If you run "git repack" again at this point, it will say
 "Nothing to pack".  Once you continue your development and
@@ -998,7 +996,7 @@ project from scratch), and then run "git
 while, depending on how active your project is.

 When a repository is synchronized via "git push" and "git pull",
-objects packed in the source repository is usually stored
+objects packed in the source repository are usually stored
 unpacked in the destination, unless rsync transport is used.


@@ -1048,8 +1046,8 @@ A recommended workflow for a "project le
      Go back to step (5) and continue working.


-A recommended work cycle for a "subsystem maintainer" that works
-on that project and has own "public repository" goes like this:
+A recommended work cycle for a "subsystem maintainer" who works
+on that project and has an own "public repository" goes like this:

  (1) Prepare your work repository, by "git clone" the public
      repository of the "project lead".  The URL used for the
@@ -1058,8 +1056,8 @@ on that project and has own "public repo
  (2) Prepare a public repository accessible to others.

  (3) Copy over the packed files from "project lead" public
-     repository to your public repository by hand; this part is
-     currently not automated.
+     repository to your public repository by hand; preferrably
+     use rsync for that task.

  (4) Push into the public repository from your primary
      repository.  Run "git repack", and possibly "git
