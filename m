From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] t7012: Mark missing tests as TODO
Date: Mon, 19 Apr 2010 10:14:32 +0200
Message-ID: <1584248d122ac952e6c9f4b4243b23c32f23aa3b.1271664768.git.git@drmicha.warpmail.net>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 19 10:17:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3mAp-0007wg-45
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 10:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824Ab0DSIRh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 04:17:37 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:58482 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751162Ab0DSIRg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Apr 2010 04:17:36 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 53EB9EB57A;
	Mon, 19 Apr 2010 04:17:36 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 19 Apr 2010 04:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=cl+0wMx5QvV0mC8GMDPICHu/NqQ=; b=pIJL47nXRwMYie5KLtDzTuyYT1jcIhP8WwrG50UwepCD4s6RURaMOQEcpXp6p0uhSZuYHS968bmGgdHvX33syZ88JY36K6MtSpWLOKMn2upRfvAtRs6gP3vq8maawq8+fTzQZh9siAGl4igcvAER3FPjvDLf3zZHZFG2Yp4Wj0g=
X-Sasl-enc: vZPjiG7S6eV4LNc+LYTQgWBzriAkIXxIrlcqItezqJJQ 1271665055
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B83FE4731F;
	Mon, 19 Apr 2010 04:17:35 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.rc1.248.gcefbb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145277>

Currently, there are 6 tests which are not even written but are
'test_expect_failure message false'.
Do not abuse test_expect_failure as a to do marker, but mark them as
'#TODO' instead.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Part of my personal war on test failures... I don't think it is helpful
to have bogus counts for failed tests.

 t/t7012-skip-worktree-writing.sh |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t7012-skip-worktree-writing.sh b/t/t7012-skip-worktree-writing.sh
index 8d8b1c0..582d0b5 100755
--- a/t/t7012-skip-worktree-writing.sh
+++ b/t/t7012-skip-worktree-writing.sh
@@ -136,11 +136,11 @@ test_expect_success 'git-clean, dirty case' '
 	test_cmp expected result
 '
 
-test_expect_failure 'git-apply adds file' false
-test_expect_failure 'git-apply updates file' false
-test_expect_failure 'git-apply removes file' false
-test_expect_failure 'git-mv to skip-worktree' false
-test_expect_failure 'git-mv from skip-worktree' false
-test_expect_failure 'git-checkout' false
+#TODO test_expect_failure 'git-apply adds file' false
+#TODO test_expect_failure 'git-apply updates file' false
+#TODO test_expect_failure 'git-apply removes file' false
+#TODO test_expect_failure 'git-mv to skip-worktree' false
+#TODO test_expect_failure 'git-mv from skip-worktree' false
+#TODO test_expect_failure 'git-checkout' false
 
 test_done
-- 
1.7.1.rc1.248.gcefbb
