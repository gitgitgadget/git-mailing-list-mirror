From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v2 4/4] Documentation: Update 'linux-2.6.git' -> 'linux.git'
Date: Sat, 22 Jun 2013 10:46:27 -0400
Message-ID: <ce90543ed8c24f0968aafd9fb457bce409acd50c.1371911897.git.wking@tremily.us>
References: <7vppvhye6s.fsf@alter.siamese.dyndns.org>
 <cover.1371911897.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 22 16:46:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqP5K-0003Nh-UD
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 16:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756286Ab3FVOqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jun 2013 10:46:35 -0400
Received: from vms173011pub.verizon.net ([206.46.173.11]:50188 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308Ab3FVOqe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 10:46:34 -0400
Received: from odin.tremily.us ([unknown] [72.68.80.60])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MOS003QVUDK6220@vms173011.mailsrvcs.net> for
 git@vger.kernel.org; Sat, 22 Jun 2013 09:46:33 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 013A1A3D886; Sat,
 22 Jun 2013 10:46:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1371912392; bh=VTDi+UQcW04bCg1OcyCSq0r4KF4c25Mgjvuxn8KEHGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:	 References;
	b=oms2NaiwIby+nCQcq8jZSQwWlln83K8ia+tW6EuxgG3PIKaAoRxN3isJLm4ylxzju
 K9sl5pVrXqouuhmg92w6atET2cprhH21vLedMIaiZCtvUb3/y0jsiDCVIsJhnaXFXS
 lleXL4YZZKNu6WDSlNPK79KinouJdIiqefOVvnCg=
X-Mailer: git-send-email 1.8.1.5
In-reply-to: <cover.1371911897.git.wking@tremily.us>
In-reply-to: <cover.1371911897.git.wking@tremily.us>
References: <cover.1371911897.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228710>

From: "W. Trevor King" <wking@tremily.us>

The 3.x tree has been out for a while now.  The -2.6 repository name
survived the initial release [1], but kernel.org now only lists
'linux.git' (for aegl as well as torvalds) [2].

[1]: http://article.gmane.org/gmane.linux.kernel/1147422
  On 2011-05-30 01:47:57 GMT, Linus Torvalds wrote:
  > ... yes, that means that my git tree is still called
  > "linux-2.6.git" on kernel.org.
[2]: http://git.kernel.org/cgit/

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/git-clone.txt          | 4 ++--
 Documentation/git-fast-export.txt    | 2 +-
 Documentation/technical/racy-git.txt | 6 +++---
 Documentation/user-manual.txt        | 8 ++++----
 t/perf/README                        | 2 +-
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index bf05ada..98b139c 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -239,8 +239,8 @@ Examples
 * Clone from upstream:
 +
 ------------
-$ git clone git://git.kernel.org/pub/scm/.../linux-2.6 my2.6
-$ cd my2.6
+$ git clone git://git.kernel.org/pub/scm/.../linux.git my-linux
+$ cd my-linux
 $ make
 ------------
 
diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index d6487e1..0314da3 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -137,7 +137,7 @@ Limitations
 -----------
 
 Since 'git fast-import' cannot tag trees, you will not be
-able to export the linux-2.6.git repository completely, as it contains
+able to export the linux.git repository completely, as it contains
 a tag referencing a tree instead of a commit.
 
 GIT
diff --git a/Documentation/technical/racy-git.txt b/Documentation/technical/racy-git.txt
index 6dc82ca..f716d6d 100644
--- a/Documentation/technical/racy-git.txt
+++ b/Documentation/technical/racy-git.txt
@@ -135,9 +135,9 @@ them, and give the same timestamp to the index file:
   $ git ls-files | git update-index --stdin
   $ touch -r .datestamp .git/index
 
-This will make all index entries racily clean.  The linux-2.6
-project, for example, there are over 20,000 files in the working
-tree.  On my Athlon 64 X2 3800+, after the above:
+This will make all index entries racily clean.  The linux project, for
+example, there are over 20,000 files in the working tree.  On my
+Athlon 64 X2 3800+, after the above:
 
   $ /usr/bin/time git diff-files
   1.68user 0.54system 0:02.22elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 4283d8f..a13de93 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -66,8 +66,8 @@ $ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
 The initial clone may be time-consuming for a large project, but you
 will only need to clone once.
 
-The clone command creates a new directory named after the project (`git`
-or `linux-2.6` in the examples above).  After you cd into this
+The clone command creates a new directory named after the project
+(`git` or `linux` in the examples above).  After you cd into this
 directory, you will see that it contains a copy of the project files,
 called the <<def_working_tree,working tree>>, together with a special
 top-level directory named `.git`, which contains all the information
@@ -2162,7 +2162,7 @@ To set this up, first create your work tree by cloning Linus's public
 tree:
 
 -------------------------------------------------
-$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git work
+$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git work
 $ cd work
 -------------------------------------------------
 
@@ -2204,7 +2204,7 @@ make it easy to push both branches to your public tree.  (See
 -------------------------------------------------
 $ cat >> .git/config <<EOF
 [remote "mytree"]
-	url =  master.kernel.org:/pub/scm/linux/kernel/git/aegl/linux-2.6.git
+	url =  master.kernel.org:/pub/scm/linux/kernel/git/aegl/linux.git
 	push = release
 	push = test
 EOF
diff --git a/t/perf/README b/t/perf/README
index c552f56..8848c14 100644
--- a/t/perf/README
+++ b/t/perf/README
@@ -66,7 +66,7 @@ You can set the following variables (also in your config.mak):
     GIT_PERF_LARGE_REPO
 	Repositories to copy for the performance tests.  The normal
 	repo should be at least git.git size.  The large repo should
-	probably be about linux-2.6.git size for optimal results.
+	probably be about linux.git size for optimal results.
 	Both default to the git.git you are running from.
 
 You can also pass the options taken by ordinary git tests; the most
-- 
1.8.3
