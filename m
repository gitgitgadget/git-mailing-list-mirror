From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 1/2] t/t3415: use && where applicable.
Date: Fri,  1 Oct 2010 23:19:19 +0200
Message-ID: <1285967960-17691-2-git-send-email-ydirson@altern.org>
References: <1285967960-17691-1-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 01 23:10:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1mrx-0003dV-M6
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 23:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756417Ab0JAVJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Oct 2010 17:09:50 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:47266 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753980Ab0JAVJt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Oct 2010 17:09:49 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id B927DD48054;
	Fri,  1 Oct 2010 23:09:43 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1P1n0n-0004cT-QV; Fri, 01 Oct 2010 23:19:25 +0200
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1285967960-17691-1-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157783>

Signed-off-by: Yann Dirson <ydirson@altern.org>
---
 t/t3415-rebase-autosquash.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 37cb89a..fd2184c 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -26,7 +26,7 @@ test_auto_fixup() {
 	echo 1 >file1 &&
 	git add -u &&
 	test_tick &&
-	git commit -m "fixup! first"
+	git commit -m "fixup! first" &&
 
 	git tag $1 &&
 	test_tick &&
@@ -55,7 +55,7 @@ test_auto_squash() {
 	echo 1 >file1 &&
 	git add -u &&
 	test_tick &&
-	git commit -m "squash! first"
+	git commit -m "squash! first" &&
 
 	git tag $1 &&
 	test_tick &&
@@ -84,7 +84,7 @@ test_expect_success 'misspelled auto squash' '
 	echo 1 >file1 &&
 	git add -u &&
 	test_tick &&
-	git commit -m "squash! forst"
+	git commit -m "squash! forst" &&
 	git tag final-missquash &&
 	test_tick &&
 	git rebase --autosquash -i HEAD^^^ &&
-- 
1.7.2.3
