From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH 4/5] Add more AsciiDoc markup to the README file
Date: Sat, 13 Aug 2005 18:30:35 +0200
Message-ID: <20050813163035.GE968@diku.dk>
References: <20050813162352.GA968@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 18:32:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3yu8-0000hG-P2
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 18:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbVHMQai (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 12:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbVHMQai
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 12:30:38 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:56538 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S932183AbVHMQah (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2005 12:30:37 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 0E9046E1615; Sat, 13 Aug 2005 18:30:24 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 82C546E1489; Sat, 13 Aug 2005 18:30:23 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 8272360A44; Sat, 13 Aug 2005 18:30:35 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050813162352.GA968@diku.dk>
User-Agent: Mutt/1.5.6i
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---

I've separated these because they make the README file less readable.
Pick the ones you like, and I will make a new patch.

 README |   76 ++++++++++++++++++++++++++++++++++++----------------------------
 1 files changed, 43 insertions(+), 33 deletions(-)

diff --git a/README b/README
--- a/README
+++ b/README
@@ -2,10 +2,10 @@ The Cogito Version Control System
 =================================
 
 Cogito is a version control system layered on top of the git tree history
-storage system. Note that you can MOSTLY use it in parallel of other GIT
+storage system. Note that you can *MOSTLY* use it in parallel of other GIT
 frontends (e.g. StGIT), as well as the Linus' GIT plumbing and core GIT
 tools - they only need to keep HEAD in place and follow the standardized
-refs/ hierarchy. The exception is that you should stick with a single
+`refs/` hierarchy. The exception is that you should stick with a single
 toolkit during a merge and mostly stick with Cogito while your tree is
 in cg-seek'd state.
 
@@ -18,27 +18,36 @@ Downloading Cogito From Scratch
 
 Cogito can be obtained as a tarball from
 
-	http://www.kernel.org/pub/software/scm/cogito/
+ - http://www.kernel.org/pub/software/scm/cogito/[]
 
 Download and unpack the latest version, build with make, put the executables
-somewhere in your $PATH (or add your Cogito directory itself to your $PATH),
+somewhere in your `$PATH` (or add your Cogito directory itself to your `$PATH`),
 and you're ready to go!
 
 The following tools are required by Cogito:
 
-	git-core (Cogito is a frontend for git)
-	bash, basic shell environment (sed, grep, textutils, mktemp, ...)
-	diff, patch
-	merge (e.g. from the RCS package)
-	wget
+`-------------------------------`----------------------------------------------
+Tool				Description
+-------------------------------------------------------------------------------
+git-core			Cogito is a frontend for git.
+bash				All Cogito executables are scripted in bash.
+sed, grep, textutils, etc.	The basic shell environment.
+diff, patch			The basic utilities for tracking file changes.
+merge				E.g. from the RCS package.
+wget				For pulling files with the HTTP backend.
+-------------------------------------------------------------------------------
 
 The following tools are optional but strongly recommended:
 
-	libcrypto (OpenSSL)
-	rsync
-	gnu coreutils (the gnu versions of stat, date and cp are
-	           preferred over the BSD variants)
-
+`-------------------------------`----------------------------------------------
+Tool				Description
+-------------------------------------------------------------------------------
+rsync				For pulling files with the rsync backend.
+gnu coreutils			The gnu versions of stat, date and cp \
+				are preferred over the BSD variants.
+ssh				For pulling files with the git+ssh backend.
+asciidoc (>= 7.0), xmlto	For building documentation.
+-------------------------------------------------------------------------------
 
 Starting a Fresh GIT Repository
 -------------------------------
@@ -50,7 +60,7 @@ take an existing directory tree and turn
 Starting an Empty Repository
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-To create a new repository with no files in it, cd into an empty directory,
+To create a new repository with no files in it, `cd` into an empty directory,
 and give the following command:
 
 	$ cg-init
@@ -58,7 +68,7 @@ and give the following command:
 Your editor will start up, and you will be asked to type in the initial
 commit description. Type something cute, and exit your editor.
 
-That's it! You're now in your own GIT repository. Notice there is now a .git
+That's it! You're now in your own GIT repository. Notice there is now a `.git`
 directory. Go into it and look around, but don't change anything in there.
 That's what Cogito commands are for.
 
@@ -67,7 +77,7 @@ Turning an Existing Directory Into a Rep
 
 If you have a directory full of files, you can easily turn this into a
 GIT repository. In fact, it is virtually the same as starting an empty
-repository. Just cd into the directory you want converted into a GIT
+repository. Just `cd` into the directory you want converted into a GIT
 repository, and give the following command:
 
 	$ cg-init
@@ -84,16 +94,16 @@ Creating the Repository
 ~~~~~~~~~~~~~~~~~~~~~~~
 
 If you want to get started tracking an outside GIT repository, you first
-must have Cogito's executables on your $PATH. Next, you need the URL (or
+must have Cogito's executables on your `$PATH`. Next, you need the URL (or
 local directory path) of the repository you want to track. You can't just
 use the URL of a tarball, like the one given above for the Cogito source.
-The URL must point specifically to a .git directory somewhere. For instance,
+The URL must point specifically to a `.git` directory somewhere. For instance,
 the URL for Cogito's self-hosting repository is
 
 	http://www.kernel.org/pub/scm/cogito/cogito.git
 
-Notice that the final directory, 'cogito.git', is not called '.git'. That is
-fine. It still has the same content as your .git directory.
+Notice that the final directory, `cogito.git`, is not called `.git`. That is
+fine. It still has the same content as your `.git` directory.
 
 To clone the repository to your local filesystem, use the cg-clone command.
 cg-clone can be told to create a new directory for your repository, or to
@@ -107,8 +117,8 @@ new directory be called, as follows:
 
 You will see a whole bunch of output, and when it is over there will be a
 new directory called 'cogitodir' (or whatever name you chose) in the current
-directory. cd into it. Because we used the Cogito URL, you will see the
-Cogito source tree, with its own .git directory keeping track of everything.
+directory. `cd` into it. Because we used the Cogito URL, you will see the
+Cogito source tree, with its own `.git` directory keeping track of everything.
 
 If, instead, you want to clone the repository to the current directory,
 first make sure you are in an empty directory. Then give the following
@@ -116,7 +126,7 @@ command:
 
 	$ cg-clone -s http://www.kernel.org/pub/scm/cogito/cogito.git
 
-When you get your prompt back, do an ls to see the source tree and .git
+When you get your prompt back, do an ls to see the source tree and `.git`
 directory.
 
 
@@ -125,14 +135,14 @@ Tracking Others' Work
 
 Of course, once you have cloned a repository, you don't just want to leave
 it at that. The upstream sources are constantly being updated, and you want
-to follow these updates. To do this, cd into the working tree directory (not
-the .git directory, but the directory that contains the .git directory), and
+to follow these updates. To do this, `cd` into the working tree directory (not
+the `.git` directory, but the directory that contains the `.git` directory), and
 give the following command:
 
 	$ cg-update
 
 You don't use a URL anymore. Cogito knows which tree you're tracking, because
-this information is stored in the .git directory. The above command will track
+this information is stored in the `.git` directory. The above command will track
 the 'origin' branch, which represents the repository you originally cloned.
 But cg-update can also be used to track specific branches. See below for more
 discussion of branches, and how to track them.
@@ -141,11 +151,11 @@ When you give the above cg-update comman
 First, it pulled all new changes from the upstream repository into your
 local repository. At that point, the changes exist in your local repository
 as part of the project history. The changes themselves are not actually
-visible in the files you see, but reside in the .git directory's awareness,
+visible in the files you see, but reside in the `.git` directory's awareness,
 just downloaded and ready to be merged somewhere.  The second thing cg-update
 does is to merge these changes into the files you see and work with. The end
 result is that, when the cg-update has finished, you will see all the upstream
-changes reflected in your local files, and the .git directory will be aware
+changes reflected in your local files, and the `.git` directory will be aware
 of the history of those changes as well.
 
 It may be that you want to be aware of the history of the upstream work, but
@@ -155,14 +165,14 @@ this, give the following command:
 	$ cg-pull
 
 This does the first part of cg-update's job, but skips the second part.
-Now your local files have not been changed, but your .git directory has been
+Now your local files have not been changed, but your `.git` directory has been
 updated with the history of all the changes that have occurred in the
 upstream sources.
 
 Using cg-pull is useful for a variety of purposes, for instance if you want
 to construct a diff against the latest version of the upstream sources, but
 don't want those changes to disturb your ongoing work. cg-pull will update
-your .git directory with the history you need to construct your diff,
+your `.git` directory with the history you need to construct your diff,
 without merging that history into your tree, potentially breaking your
 changes.
 
@@ -196,7 +206,7 @@ the command
 
 (the repourl can have a fragment part identifying a branch inside of the
 repository). Then you can specify the name to cg-update and cg-pull, or use
-it anywhere where you could use the "origin" name.
+it anywhere where you could use the 'origin' name.
 
 When you do some local changes, you can do
 
@@ -224,7 +234,7 @@ It is nice to be able to examine the com
 	$ cg-log -r origin
 
 will get you the history of my branch. cg-log with no arguments will default
-to the history of the current branch. Try prepending the "-c" and "-f" options.
+to the history of the current branch. Try prepending the `-c` and `-f` options.
 
 Note that we missed out a lot of stuff here. There is already support
 for merging (cg-merge), moving your tree to an older commit (cg-seek), etc.

-- 
Jonas Fonseca
