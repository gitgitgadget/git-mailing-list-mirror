From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 6/6] worktree: wordsmith worktree-related manpages
Date: Sat, 18 Jul 2015 19:10:58 -0700
Message-ID: <087f0fbeffa8fb30529ba69498e427d11396eddf.1437271363.git.mhagger@alum.mit.edu>
References: <cover.1437271363.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 19 04:11:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGe54-0008Qc-Ur
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 04:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752856AbbGSCLu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2015 22:11:50 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:61891 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752368AbbGSCLl (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jul 2015 22:11:41 -0400
X-AuditID: 12074411-f797e6d000007df3-12-55ab075c7cc6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id BB.83.32243.C570BA55; Sat, 18 Jul 2015 22:11:40 -0400 (EDT)
Received: from localhost.localdomain ([66.251.117.141])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t6J2BUOg011238
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 18 Jul 2015 22:11:39 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1437271363.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsUixO6iqBvDvjrUYNtqJYuuK91MFg29V5gt
	bq+Yz2zRPeUto8WZN42MDqwef99/YPLYOesuu8fFS8oeix94eXzeJBfAGsVtk5RYUhacmZ6n
	b5fAnTFj/gamgi0yFW8WrGBqYNwi3sXIySEhYCKxddMFZghbTOLCvfVsXYxcHEIClxklLs1Y
	ywLhrGeS+LV6DytIFZuArsSinmYmEFtEYBOjROvrfBCbWcBBYvPnRkYQW1jASWLRoiZ2EJtF
	QFWi4+ATsDivQJTElNNPobbJSZw//hPM5hSwkJj0qoUNxBYSMJe4Pe8f8wRG3gWMDKsY5RJz
	SnN1cxMzc4pTk3WLkxPz8lKLdE31cjNL9FJTSjcxQkJKcAfjjJNyhxgFOBiVeHgtvqwKFWJN
	LCuuzD3EKMnBpCTKW/oKKMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmEN59xdagQb0piZVVqUT5M
	SpqDRUmcl2+Jup+QQHpiSWp2ampBahFMVoaDQ0mCV4UNqFGwKDU9tSItM6cEIc3EwQkynEtK
	pDg1LyW1KLG0JCMeFBvxxcDoAEnxAO19xQqyt7ggMRcoCtF6ilGXY83s+2uZhFjy8vNSpcR5
	HUB2CIAUZZTmwa2AJZBXjOJAHwvz7gep4gEmH7hJr4CWMAEt6Vy9AmRJSSJCSqqB0anrre6y
	pK0MVwO43j3MiXg1oU271LS1L0xrmbmU6TGdf30BedcOPKtgSZ72WEnBMVndssHhmP+TjNyE
	f785d18tMF75OG1rxBfVVf0Gs9u9lSbLhCzIL/vOa2+p2KtxbtcajWS+yP7/LCt6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274187>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/config.txt               |  8 ++++----
 Documentation/git-worktree.txt         |  2 +-
 Documentation/gitrepository-layout.txt | 18 +++++++++---------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7f65dbb..10bc351 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1292,11 +1292,11 @@ gc.pruneExpire::
 	unreachable objects immediately.
 
 gc.pruneWorktreesExpire::
-	When 'git gc' is run, it will call
+	When 'git gc' is run, it calls
 	'git worktree prune --expire 3.months.ago'.
-	Override the grace period with this config variable. The value
-	"now" may be used to disable the grace period and prune
-	$GIT_DIR/worktrees immediately.
+	This config variable can be used to set a different grace
+	period. The value "now" may be used to disable the grace
+	period and prune $GIT_DIR/worktrees immediately.
 
 gc.reflogExpire::
 gc.<pattern>.reflogExpire::
diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index d5aeda0..cecb44c 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -138,7 +138,7 @@ EXAMPLES
 --------
 You are in the middle of a refactoring session and your boss comes in and
 demands that you fix something immediately. You might typically use
-linkgit:git-stash[1] to store your changes away temporarily, however, your
+linkgit:git-stash[1] to store your changes away temporarily; however, your
 worktree is in such a state of disarray (with new, moved, and removed files,
 and other bits and pieces strewn around) that you don't want to risk
 disturbing any of it. Instead, you create a temporary linked working tree to
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index fe7fa96..fe7d4bb 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -251,25 +251,25 @@ modules::
 	Contains the git-repositories of the submodules.
 
 worktrees::
-	Contains worktree specific information of linked
-	working trees. Each subdirectory contains the worktree-related
+	Contains worktree-specific information for linked working
+	trees. Each subdirectory contains the worktree-related
 	part of a linked working tree. This directory is ignored if
-	$GIT_COMMON_DIR is set and "$GIT_COMMON_DIR/worktrees" will be
-	used instead.
+	$GIT_COMMON_DIR is set, in which case
+	"$GIT_COMMON_DIR/worktrees" will be used instead.
 
 worktrees/<id>/gitdir::
 	A text file containing the absolute path back to the .git file
 	that points to here. This is used to check if the linked
 	repository has been manually removed and there is no need to
-	keep this directory any more. mtime of this file should be
+	keep this directory any more. The mtime of this file should be
 	updated every time the linked repository is accessed.
 
 worktrees/<id>/locked::
 	If this file exists, the linked working tree may be on a
-	portable device and not available. It does not mean that the
-	linked working tree is gone and `worktrees/<id>` could be
-	removed. The file's content contains a reason string on why
-	the repository is locked.
+	portable device and not available. The presence of this file
+	prevents `worktrees/<id>` from being pruned by `git worktree
+	prune`. The file may contain a string explaining why the
+	repository is locked.
 
 worktrees/<id>/link::
 	If this file exists, it is a hard link to the linked .git
-- 
2.1.4
