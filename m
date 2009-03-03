From: Mike Ralphson <mike@abacus.co.uk>
Subject: [PATCH] Documentation: Typos / spelling fixes in RelNotes
Date: Tue,  3 Mar 2009 19:29:20 +0000
Message-ID: <1236108562-31469-1-git-send-email-mike@abacus.co.uk>
Cc: git@vger.kernel.org, Mike Ralphson <mike.ralphson@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 20:52:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeafY-0007zo-WA
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 20:52:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754119AbZCCTvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 14:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752817AbZCCTvP
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 14:51:15 -0500
Received: from [82.109.193.99] ([82.109.193.99]:21427 "EHLO orson.abacus.co.uk"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752780AbZCCTvN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 14:51:13 -0500
Received: by orson.abacus.co.uk (Postfix, from userid 1006)
	id B122C195DE9; Tue,  3 Mar 2009 19:29:22 +0000 (GMT)
X-Mailer: git-send-email 1.6.0.2.229.g1293c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112160>

Signed-off-by: Mike Ralphson <mike@abacus.co.uk>
---
 Documentation/RelNotes-1.5.2.2.txt |    2 +-
 Documentation/RelNotes-1.6.0.2.txt |    2 +-
 Documentation/RelNotes-1.6.1.1.txt |    4 ++--
 Documentation/RelNotes-1.6.1.2.txt |    4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/RelNotes-1.5.2.2.txt b/Documentation/RelNotes-1.5.2.2.txt
index f6393f8..7bfa341 100644
--- a/Documentation/RelNotes-1.5.2.2.txt
+++ b/Documentation/RelNotes-1.5.2.2.txt
@@ -45,7 +45,7 @@ Fixes since v1.5.2.1
     correctly when the branch name had slash in it.
 
   - The email address of the user specified with user.email
-    configuration was overriden by EMAIL environment variable.
+    configuration was overridden by EMAIL environment variable.
 
   - The tree parser did not warn about tree entries with
     nonsense file modes, and assumed they must be blobs.
diff --git a/Documentation/RelNotes-1.6.0.2.txt b/Documentation/RelNotes-1.6.0.2.txt
index 7a9646f..51b32f5 100644
--- a/Documentation/RelNotes-1.6.0.2.txt
+++ b/Documentation/RelNotes-1.6.0.2.txt
@@ -7,7 +7,7 @@ Fixes since v1.6.0.1
 * Installation on platforms that needs .exe suffix to git-* programs were
   broken in 1.6.0.1.
 
-* Installation on filesystems without symbolic links support did nto
+* Installation on filesystems without symbolic links support did not
   work well.
 
 * In-tree documentations and test scripts now use "git foo" form to set a
diff --git a/Documentation/RelNotes-1.6.1.1.txt b/Documentation/RelNotes-1.6.1.1.txt
index 88454c1..8c594ba 100644
--- a/Documentation/RelNotes-1.6.1.1.txt
+++ b/Documentation/RelNotes-1.6.1.1.txt
@@ -41,11 +41,11 @@ Fixes since v1.6.1
   work tree upon delete/modify conflict.
 
 * "git merge -s recursive" didn't leave the index unmerged for entries with
-  rename/delete conflictd.
+  rename/delete conflicts.
 
 * "git merge -s recursive" clobbered untracked files in the work tree.
 
-* "git mv -k" with more than one errorneous paths misbehaved.
+* "git mv -k" with more than one erroneous paths misbehaved.
 
 * "git read-tree -m -u" hence branch switching incorrectly lost a
   subdirectory in rare cases.
diff --git a/Documentation/RelNotes-1.6.1.2.txt b/Documentation/RelNotes-1.6.1.2.txt
index 230aa3d..be37cbb 100644
--- a/Documentation/RelNotes-1.6.1.2.txt
+++ b/Documentation/RelNotes-1.6.1.2.txt
@@ -4,8 +4,8 @@ GIT v1.6.1.2 Release Notes
 Fixes since v1.6.1.1
 --------------------
 
-* The logic for rename detectin in internal diff used by commands like
-  "git diff" and "git blame" have been optimized to avoid loading the same
+* The logic for rename detection in internal diff used by commands like
+  "git diff" and "git blame" has been optimized to avoid loading the same
   blob repeatedly.
 
 * We did not allow writing out a blob that is larger than 2GB for no good
-- 
1.6.0.2.229.g1293c.dirty
