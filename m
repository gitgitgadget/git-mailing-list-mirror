From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Assorted typo fixes
Date: Sun, 09 Jul 2006 03:36:03 -0400
Message-ID: <1152430563.6603.5.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Jul 09 09:36:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzTpr-0001QG-0c
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 09:36:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161118AbWGIHgH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 03:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbWGIHgH
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 03:36:07 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:10436 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932402AbWGIHgF
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 9 Jul 2006 03:36:05 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FzTpk-0007zs-KY
	for git@vger.kernel.org; Sun, 09 Jul 2006 03:36:04 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1FzTpj-0001qy-F7
	for git@vger.kernel.org; Sun, 09 Jul 2006 03:36:03 -0400
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.7.3 (2.7.3-7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23529>

Assorted typo fixes

Signed-off-by: Pavel Roskin <proski@gnu.org>

---
This is for "next".  "interopability" didn't make it to "master" yet.


 Documentation/SubmittingPatches                    |    2 +-
 Documentation/cvs-migration.txt                    |    2 +-
 Documentation/git-diff-files.txt                   |    2 +-
 Documentation/git-init-db.txt                      |    2 +-
 Documentation/git-mailsplit.txt                    |    2 +-
 Documentation/git-merge.txt                        |    2 +-
 Documentation/git-p4import.txt                     |    4 ++--
 Documentation/git-pack-redundant.txt               |    2 +-
 Documentation/git-push.txt                         |    2 +-
 Documentation/git-repo-config.txt                  |    4 ++--
 Documentation/git-rev-list.txt                     |    2 +-
 Documentation/git-tools.txt                        |    2 +-
 Documentation/git-upload-tar.txt                   |    2 +-
 Documentation/git.txt                              |    2 +-
 Documentation/howto/isolate-bugs-with-bisect.txt   |    2 +-
 .../howto/rebase-from-internal-branch.txt          |    2 +-
 Documentation/technical/pack-heuristics.txt        |    8 ++++----
 INSTALL                                            |    4 ++--
 Makefile                                           |    6 +++---
 git-cvsserver.perl                                 |   14
+++++++-------
 server-info.c                                      |    2 +-
 21 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/Documentation/SubmittingPatches
b/Documentation/SubmittingPatches
index 8601949..90722c2 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -49,7 +49,7 @@ People on the git mailing list need to b
 comment on the changes you are submitting.  It is important for
 a developer to be able to "quote" your changes, using standard
 e-mail tools, so that they may comment on specific portions of
-your code.  For this reason, all patches should be submited
+your code.  For this reason, all patches should be submitted
 "inline".  WARNING: Be wary of your MUAs word-wrap
 corrupting your patch.  Do not cut-n-paste your patch; you can
 lose tabs that way if you are not careful.
diff --git a/Documentation/cvs-migration.txt
b/Documentation/cvs-migration.txt
index 1fbca83..d2b0bd3 100644
--- a/Documentation/cvs-migration.txt
+++ b/Documentation/cvs-migration.txt
@@ -93,7 +93,7 @@ machine where the repository is hosted. 
 full shell on the machine, there is a restricted shell which only
allows
 users to do git pushes and pulls; see gitlink:git-shell[1].
 
-Put all the committers should in the same group, and make the
repository
+Put all the committers in the same group, and make the repository
 writable by that group:
 
 ------------------------------------------------
diff --git a/Documentation/git-diff-files.txt
b/Documentation/git-diff-files.txt
index 481b8b3..7248b35 100644
--- a/Documentation/git-diff-files.txt
+++ b/Documentation/git-diff-files.txt
@@ -37,7 +37,7 @@ omit diff output for unmerged entries an
 	commit with these flags.
 
 -q::
-	Remain silent even on nonexisting files
+	Remain silent even on nonexistent files
 
 Output format
 -------------
diff --git a/Documentation/git-init-db.txt
b/Documentation/git-init-db.txt
index 8a150d8..0a4fc14 100644
--- a/Documentation/git-init-db.txt
+++ b/Documentation/git-init-db.txt
@@ -25,7 +25,7 @@ DESCRIPTION
 -----------
 This command creates an empty git repository - basically a `.git`
directory
 with subdirectories for `objects`, `refs/heads`, `refs/tags`, and
-templated files.
+template files.
 An initial `HEAD` file that references the HEAD of the master branch
 is also created.
 
diff --git a/Documentation/git-mailsplit.txt
b/Documentation/git-mailsplit.txt
index 209e36b..5a17801 100644
--- a/Documentation/git-mailsplit.txt
+++ b/Documentation/git-mailsplit.txt
@@ -25,7 +25,7 @@ OPTIONS
 
 -b::
 	If any file doesn't begin with a From line, assume it is a
-	single mail message instead of signalling error.
+	single mail message instead of signaling error.
 
 -d<prec>::
 	Instead of the default 4 digits with leading zeros,
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 4ce799b..bebf30a 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -83,7 +83,7 @@ your local modifications interfere with 
 stops before touching anything.
 
 So in the above two "failed merge" case, you do not have to
-worry about lossage of data --- you simply were not ready to do
+worry about loss of data --- you simply were not ready to do
 a merge, so no merge happened at all.  You may want to finish
 whatever you were in the middle of doing, and retry the same
 pull after you are done and ready.
diff --git a/Documentation/git-p4import.txt
b/Documentation/git-p4import.txt
index 0858e5e..ee9e8fa 100644
--- a/Documentation/git-p4import.txt
+++ b/Documentation/git-p4import.txt
@@ -128,7 +128,7 @@ Tags
 A git tag of the form p4/xx is created for every change imported from
 the Perforce repository where xx is the Perforce changeset number.
 Therefore after the import you can use git to access any commit by its
-Perforce number, eg. git show p4/327.
+Perforce number, e.g. git show p4/327.
 
 The tag associated with the HEAD commit is also how `git-p4import`
 determines if there are new changes to incrementally import from the
@@ -143,7 +143,7 @@ may delete the tags.
 
 Notes
 -----
-You can interrupt the import (eg. ctrl-c) at any time and restart it
+You can interrupt the import (e.g. ctrl-c) at any time and restart it
 without worry.
 
 Author information is automatically determined by querying the
diff --git a/Documentation/git-pack-redundant.txt
b/Documentation/git-pack-redundant.txt
index 8fb0659..7d54b17 100644
--- a/Documentation/git-pack-redundant.txt
+++ b/Documentation/git-pack-redundant.txt
@@ -29,7 +29,7 @@ OPTIONS
 
 
 --all::
-	Processes all packs. Any filenames on the commandline are ignored.
+	Processes all packs. Any filenames on the command line are ignored.
 
 --alt-odb::
 	Don't require objects present in packs from alternate object
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index d5b5ca1..56afd64 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -67,7 +67,7 @@ Some short-cut notations are also suppor
 
 -f, \--force::
 	Usually, the command refuses to update a remote ref that is
-	not a descendent of the local ref used to overwrite it.
+	not a descendant of the local ref used to overwrite it.
 	This flag disables the check.  This can cause the
 	remote repository to lose commits; use it with care.
 
diff --git a/Documentation/git-repo-config.txt
b/Documentation/git-repo-config.txt
index cc72fa9..8a1ab61 100644
--- a/Documentation/git-repo-config.txt
+++ b/Documentation/git-repo-config.txt
@@ -120,8 +120,8 @@ you can set the filemode to true with
 % git repo-config core.filemode true
 ------------
 
-The hypothetic proxy command entries actually have a postfix to discern
-to what URL they apply. Here is how to change the entry for kernel.org
+The hypothetical proxy command entries actually have a postfix to
discern
+what URL they apply to. Here is how to change the entry for kernel.org
 to "ssh".
 
 ------------
diff --git a/Documentation/git-rev-list.txt
b/Documentation/git-rev-list.txt
index 6c370e1..e220842 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -64,7 +64,7 @@ OPTIONS
 
 --objects-edge::
 	Similar to `--objects`, but also print the IDs of
-	excluded commits refixed with a `-` character.  This is
+	excluded commits prefixed with a `-` character.  This is
 	used by `git-pack-objects` to build 'thin' pack, which
 	records objects in deltified form based on objects
 	contained in these excluded commits to reduce network
diff --git a/Documentation/git-tools.txt b/Documentation/git-tools.txt
index d79523f..0914cbb 100644
--- a/Documentation/git-tools.txt
+++ b/Documentation/git-tools.txt
@@ -42,7 +42,7 @@ History Viewers
 
    - *gitk* (shipped with git-core)
 
-   gitk is a simple TK GUI for browsing history of GIT repositories
easily.
+   gitk is a simple Tk GUI for browsing history of GIT repositories
easily.
 
 
    - *gitview*  (contrib/)
diff --git a/Documentation/git-upload-tar.txt
b/Documentation/git-upload-tar.txt
index a1019a0..394af62 100644
--- a/Documentation/git-upload-tar.txt
+++ b/Documentation/git-upload-tar.txt
@@ -17,7 +17,7 @@ to the other end over the git protocol.
 
 This command is usually not invoked directly by the end user.
 The UI for the protocol is on the 'git-tar-tree' side, and the
-program pair is meant to be used to get a tar achive from a
+program pair is meant to be used to get a tar archive from a
 remote repository.
 
 
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 51f20c6..d00cc3e 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -478,7 +478,7 @@ Configuration Mechanism
 
 Starting from 0.99.9 (actually mid 0.99.8.GIT), `.git/config` file
 is used to hold per-repository configuration options.  It is a
-simple text file modelled after `.ini` format familiar to some
+simple text file modeled after `.ini` format familiar to some
 people.  Here is an example:
 
 ------------
diff --git a/Documentation/howto/isolate-bugs-with-bisect.txt
b/Documentation/howto/isolate-bugs-with-bisect.txt
index edbcd4c..926bbdc 100644
--- a/Documentation/howto/isolate-bugs-with-bisect.txt
+++ b/Documentation/howto/isolate-bugs-with-bisect.txt
@@ -28,7 +28,7 @@ Then do
 
 and at this point "git bisect" will churn for a while, and tell you
what 
 the mid-point between those two commits are, and check that state out
as 
-the head of the bew "bisect" branch.
+the head of the new "bisect" branch.
 
 Compile and reboot.
 
diff --git a/Documentation/howto/rebase-from-internal-branch.txt
b/Documentation/howto/rebase-from-internal-branch.txt
index c2d4a91..fcd64e9 100644
--- a/Documentation/howto/rebase-from-internal-branch.txt
+++ b/Documentation/howto/rebase-from-internal-branch.txt
@@ -124,7 +124,7 @@ up your changes, along with other change
 
 The two commits #2' and #3' in the above picture record the same
 changes your e-mail submission for #2 and #3 contained, but
-probably with the new sign-off line added by the upsteam
+probably with the new sign-off line added by the upstream
 maintainer and definitely with different committer and ancestry
 information, they are different objects from #2 and #3 commits.
 
diff --git a/Documentation/technical/pack-heuristics.txt
b/Documentation/technical/pack-heuristics.txt
index 9aadd5c..103eb5d 100644
--- a/Documentation/technical/pack-heuristics.txt
+++ b/Documentation/technical/pack-heuristics.txt
@@ -73,7 +73,7 @@ The traditional insight:
 
     <pasky> yes
 
-And Bable-like confusion flowed.
+And Babel-like confusion flowed.
 
     <njs`> oh, hmm, and I'm not sure what this sliding window means
either
 
@@ -257,7 +257,7 @@ proclaim it a non-issue.  Good style too
         (type, basename, size)).
 
         Then we walk through this list, and calculate a delta of
-        each object against the last n (tunable paramater) objects,
+        each object against the last n (tunable parameter) objects,
         and pick the smallest of these deltas.
 
 Vastly simplified, but the essence is there!
@@ -395,7 +395,7 @@ used as setup for a later optimization, 
         do "object name->location in packfile" translation.
 
     <njs`> I'm assuming the real win for delta-ing large->small is
-        more homogenous statistics for gzip to run over?
+        more homogeneous statistics for gzip to run over?
 
         (You have to put the bytes in one place or another, but
         putting them in a larger blob wins on compression)
@@ -448,7 +448,7 @@ design options, etc.
 
         Bugs happen, but they are "simple" bugs. And bugs that
         actually get some object store detail wrong are almost always
-        so obious that they never go anywhere.
+        so obvious that they never go anywhere.
 
     <njs`> Yeah.
 
diff --git a/INSTALL b/INSTALL
index 4e8f883..4cf7e67 100644
--- a/INSTALL
+++ b/INSTALL
@@ -57,7 +57,7 @@ Issues of note:
 
 	- "libcurl" and "curl" executable.  git-http-fetch and
 	  git-fetch use them.  If you do not use http
-	  transfer, you are probabaly OK if you do not have
+	  transfer, you are probably OK if you do not have
 	  them.
 
 	- expat library; git-http-push uses it for remote lock
@@ -82,7 +82,7 @@ Issues of note:
 	  git, and if you only use git to track other peoples work you'll
 	  never notice the lack of it. 
 
-        - "wish", the TCL/Tk windowing shell is used in gitk to show
the
+        - "wish", the Tcl/Tk windowing shell is used in gitk to show
the
           history graphically
 
 	- "ssh" is used to push and pull over the net
diff --git a/Makefile b/Makefile
index 8d429a0..fd35dbe 100644
--- a/Makefile
+++ b/Makefile
@@ -28,7 +28,7 @@ #
 # Define NO_SYMLINK_HEAD if you never want .git/HEAD to be a symbolic
link.
 # Enable it on Windows.  By default, symrefs are still used.
 #
-# Define NO_SVN_TESTS if you want to skip time-consuming SVN
interopability
+# Define NO_SVN_TESTS if you want to skip time-consuming SVN
interoperability
 # tests.  These tests take up a significant amount of the total test
time
 # but are not needed unless you plan to talk to SVN repos.
 #
@@ -67,7 +67,7 @@ #
 # Define NO_ACCURATE_DIFF if your diff program at least sometimes
misses
 # a missing newline at the end of the file.
 #
-# Define NO_PYTHON if you want to loose all benefits of the recursive
merge.
+# Define NO_PYTHON if you want to lose all benefits of the recursive
merge.
 #
 # Define COLLISION_CHECK below if you believe that SHA1's
 # 1461501637330902918203684832716283019655932542976 hashes do not give
you
@@ -492,7 +492,7 @@ ifdef NO_ACCURATE_DIFF
 	BASIC_CFLAGS += -DNO_ACCURATE_DIFF
 endif
 
-# Shell quote (do not use $(call) to accomodate ancient setups);
+# Shell quote (do not use $(call) to accommodate ancient setups);
 
 SHA1_HEADER_SQ = $(subst ','\'',$(SHA1_HEADER))
 
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 5ccca4f..c30ef70 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -779,7 +779,7 @@ sub req_update
 
     #$log->debug("update state : " . Dumper($state));
 
-    # foreach file specified on the commandline ...
+    # foreach file specified on the command line ...
     foreach my $filename ( @{$state->{args}} )
     {
         $filename = filecleanup($filename);
@@ -1031,7 +1031,7 @@ sub req_ci
 
     my @committedfiles = ();
 
-    # foreach file specified on the commandline ...
+    # foreach file specified on the command line ...
     foreach my $filename ( @{$state->{args}} )
     {
         my $committedfile = $filename;
@@ -1145,7 +1145,7 @@ sub req_ci
 
     $updater->update();
 
-    # foreach file specified on the commandline ...
+    # foreach file specified on the command line ...
     foreach my $filename ( @committedfiles )
     {
         $filename = filecleanup($filename);
@@ -1190,7 +1190,7 @@ sub req_status
     # if no files were specified, we need to work out what files we
should be providing status on ...
     argsfromdir($updater);
 
-    # foreach file specified on the commandline ...
+    # foreach file specified on the command line ...
     foreach my $filename ( @{$state->{args}} )
     {
         $filename = filecleanup($filename);
@@ -1291,7 +1291,7 @@ sub req_diff
     # if no files were specified, we need to work out what files we
should be providing status on ...
     argsfromdir($updater);
 
-    # foreach file specified on the commandline ...
+    # foreach file specified on the command line ...
     foreach my $filename ( @{$state->{args}} )
     {
         $filename = filecleanup($filename);
@@ -1433,7 +1433,7 @@ sub req_log
     # if no files were specified, we need to work out what files we
should be providing status on ...
     argsfromdir($updater);
 
-    # foreach file specified on the commandline ...
+    # foreach file specified on the command line ...
     foreach my $filename ( @{$state->{args}} )
     {
         $filename = filecleanup($filename);
@@ -1519,7 +1519,7 @@ sub req_annotate
 
     chdir $tmpdir;
 
-    # foreach file specified on the commandline ...
+    # foreach file specified on the command line ...
     foreach my $filename ( @{$state->{args}} )
     {
         $filename = filecleanup($filename);
diff --git a/server-info.c b/server-info.c
index 0eb5132..fdfe05a 100644
--- a/server-info.c
+++ b/server-info.c
@@ -94,7 +94,7 @@ static int read_pack_info_file(const cha
 
 	fp = fopen(infofile, "r");
 	if (!fp)
-		return 1; /* nonexisting is not an error. */
+		return 1; /* nonexistent is not an error. */
 
 	while (fgets(line, sizeof(line), fp)) {
 		int len = strlen(line);

-- 
Regards,
Pavel Roskin
