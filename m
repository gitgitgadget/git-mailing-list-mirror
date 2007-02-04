From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 4/4] Assorted typos
Date: Sun, 04 Feb 2007 00:32:37 -0500
Message-ID: <20070204053236.15035.75366.stgit@dv.roinet.com>
References: <20070204053221.15035.88015.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 04 06:34:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDa0v-0003wt-86
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 06:34:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101AbXBDFcn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 00:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752136AbXBDFcm
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 00:32:42 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:48776 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752198AbXBDFcl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 00:32:41 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HDZyO-0008GZ-Rg
	for git@vger.kernel.org; Sun, 04 Feb 2007 00:31:32 -0500
Received: from localhost ([127.0.0.1] helo=dv.roinet.com)
	by gnu.org with esmtp (Exim 4.63)
	(envelope-from <proski@gnu.org>)
	id 1HDZzR-0003wQ-1h; Sun, 04 Feb 2007 00:32:37 -0500
In-Reply-To: <20070204053221.15035.88015.stgit@dv.roinet.com>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38652>

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 debian/copyright         |    2 +-
 stgit/commands/branch.py |    2 +-
 stgit/stack.py           |    4 ++--
 t/t1301-assimilate.sh    |    2 +-
 t/test-lib.sh            |    2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/debian/copyright b/debian/copyright
index 345789d..15d8679 100644
--- a/debian/copyright
+++ b/debian/copyright
@@ -1,6 +1,6 @@
 This package was downloaded from http://www.procode.org/stgit/
 
-Copyright Holder: Cataling Marinas <catalin.marinas@gmail.com>
+Copyright Holder: Catalin Marinas <catalin.marinas@gmail.com>
                   and various contributors
 
 License:
diff --git a/stgit/commands/branch.py b/stgit/commands/branch.py
index f074d47..d7ddedb 100644
--- a/stgit/commands/branch.py
+++ b/stgit/commands/branch.py
@@ -126,7 +126,7 @@ def func(parser, options, args):
         if len(args) >= 2:
             try:
                 if git.rev_parse(args[1]) == git.rev_parse('refs/heads/' + args[1]):
-                    # we are for sure refering to a branch
+                    # we are for sure referring to a branch
                     parentbranch = 'refs/heads/' + args[1]
                     print 'Recording "%s" as parent branch.' % parentbranch
                 elif git.rev_parse(args[1]) and re.search('/', args[1]):
diff --git a/stgit/stack.py b/stgit/stack.py
index 2e01f52..7f3b65d 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -658,7 +658,7 @@ class Series(StgitObject):
             os.rmdir(self.__trash_dir)
 
             # FIXME: find a way to get rid of those manual removals
-            # (move functionnality to StgitObject ?)
+            # (move functionality to StgitObject ?)
             if os.path.exists(self.__applied_file):
                 os.remove(self.__applied_file)
             if os.path.exists(self.__unapplied_file):
@@ -1044,7 +1044,7 @@ class Series(StgitObject):
             else:
                 # we store the correctly merged files only for
                 # tracking the conflict history. Note that the
-                # git.merge() operations shouls always leave the index
+                # git.merge() operations should always leave the index
                 # in a valid state (i.e. only stage 0 files)
                 self.refresh_patch(cache_update = False, log = 'push(c)')
                 raise StackException, str(ex)
diff --git a/t/t1301-assimilate.sh b/t/t1301-assimilate.sh
index 26b263c..906f5bb 100755
--- a/t/t1301-assimilate.sh
+++ b/t/t1301-assimilate.sh
@@ -65,7 +65,7 @@ test_expect_success \
     '
 
 test_expect_success \
-    'Create a mege commit' \
+    'Create a merge commit' \
     '
     git checkout -b br master^^ &&
     echo woof > woof.txt &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index b44a590..3274b84 100755
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -164,7 +164,7 @@ test_create_repo () {
 	mv .git/hooks .git/hooks-disabled
 	echo "empty start" |
 	git-commit-tree `git-write-tree` >.git/refs/heads/master 2>&4 ||
-	error "cannot run git-commit -- is your git-core funtionning?"
+	error "cannot run git-commit -- is your git-core functioning?"
 	cd "$owd"
 }
 
