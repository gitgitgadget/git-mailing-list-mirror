From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] RelNotes-1.7.2: cherry-pick and revert learned the same things
Date: Thu, 01 Jul 2010 07:10:27 +0200
Message-ID: <20100701051028.2369.53975.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 01 07:11:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUC3r-0005xu-4c
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 07:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247Ab0GAFLh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 01:11:37 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:53205 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752953Ab0GAFLg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 01:11:36 -0400
Received: from style.boubyland (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 066E6818040;
	Thu,  1 Jul 2010 07:11:29 +0200 (CEST)
X-git-sha1: 07b8fe5fc2afdba5c04a7c1a815258ad41cf4e4f 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150008>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/RelNotes-1.7.2.txt |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/RelNotes-1.7.2.txt b/Documentation/RelNotes-1.7.2.txt
index 8ed7406..53a71da 100644
--- a/Documentation/RelNotes-1.7.2.txt
+++ b/Documentation/RelNotes-1.7.2.txt
@@ -44,9 +44,12 @@ Updates since v1.7.1
    prepares to create a root commit that is not connected to any existing
    commit.
 
- * "git cherry-pick" learned to pick a range of commits (e.g. "cherry-pick
-   A..B"); this does not have nicer sequencing control "rebase [-i]" has,
-   though.
+ * "git cherry-pick" and "git revert" learned to pick a range of
+   commits (e.g. "cherry-pick A..B"); this does not have nicer
+   sequencing control "rebase [-i]" has, though.
+
+ * "git cherry-pick" and "git revert" learned --strategy option to
+   specify the merge strategy.
 
  * "git cvsserver" can be told to use pserver; its password file can be
    stored outside the repository.
@@ -92,8 +95,6 @@ Updates since v1.7.1
 
  * "git remote" learned "set-branches" subcommand.
 
- * "git revert" learned --strategy option to specify the merge strategy.
-
  * "git rev-list A..B" learned --ancestry-path option to further limit
    the result to the commits that are on the ancestry chain between A and
    B (i.e. commits that are not descendants of A are excluded).
-- 
1.7.2.rc0.223.g465131.dirty
