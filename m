From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH 1/2] Documentation: Update 'linux-2.6.git' -> 'linux.git'
Date: Tue, 18 Jun 2013 21:55:21 -0400
Message-ID: <3286ddfe2dd6cbf9c435bd7f9eb579782eb32e1f.1371606791.git.wking@tremily.us>
References: <cover.1371606791.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 19 04:56:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up8ZN-0001WD-03
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 04:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934132Ab3FSC4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 22:56:19 -0400
Received: from vms173015pub.verizon.net ([206.46.173.15]:56736 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933836Ab3FSC4S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 22:56:18 -0400
X-Greylist: delayed 3604 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Jun 2013 22:56:18 EDT
Received: from odin.tremily.us ([unknown] [72.68.80.181])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MOM0021KAP5NW70@vms173015.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 18 Jun 2013 20:55:54 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id CFF0BA3A716; Tue,
 18 Jun 2013 21:55:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1371606952; bh=DkQt5mQHU+2V52E77dUK/QUBnYQ+SBiW3T9+gQMIUH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:	 References;
	b=Oj3BkamUiPBvwt4NNFrD3dYkx+NoTMYRdSCuiOuweFy9VeOM9emJfuEYdw2A+1+5O
 G9gGuoaBaaiGVDN/n7ZayDi4isSzOxWvr5MV3Pg1/QSOFAQ92ACf5JNQAecoVsesle
 zBo7Uo9aEU1ZEnU/AA39DXslfvJX6XFrxnEZ5BxU=
X-Mailer: git-send-email 1.8.1.5
In-reply-to: <cover.1371606791.git.wking@tremily.us>
In-reply-to: <cover.1371606791.git.wking@tremily.us>
References: <cover.1371606791.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228332>

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
 Documentation/git-clone.txt       | 2 +-
 Documentation/git-fast-export.txt | 2 +-
 Documentation/user-manual.txt     | 6 +++---
 t/perf/README                     | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index a0727d7..8e5260f 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -274,7 +274,7 @@ $ git clone --bare -l /home/proj/.git /pub/scm/proj.git
 * Create a repository on the kernel.org machine that borrows from Linus:
 +
 ------------
-$ git clone --bare -l -s /pub/scm/.../torvalds/linux-2.6.git \
+$ git clone --bare -l -s /pub/scm/.../torvalds/linux.git \
     /pub/scm/.../me/subsys-2.6.git
 ------------
 
diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index efb0380..85f1f30 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -141,7 +141,7 @@ Limitations
 -----------
 
 Since 'git fast-import' cannot tag trees, you will not be
-able to export the linux-2.6.git repository completely, as it contains
+able to export the linux.git repository completely, as it contains
 a tag referencing a tree instead of a commit.
 
 GIT
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index e831cc2..cd9941a 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -60,7 +60,7 @@ project in mind, here are some interesting examples:
 	# Git itself (approx. 10MB download):
 $ git clone git://git.kernel.org/pub/scm/git/git.git
 	# the Linux kernel (approx. 150MB download):
-$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
+$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
 ------------------------------------------------
 
 The initial clone may be time-consuming for a large project, but you
@@ -2156,7 +2156,7 @@ To set this up, first create your work tree by cloning Linus's public
 tree:
 
 -------------------------------------------------
-$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git work
+$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git work
 $ cd work
 -------------------------------------------------
 
@@ -2198,7 +2198,7 @@ make it easy to push both branches to your public tree.  (See
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
