From: Torstein Hegge <hegge@resisty.net>
Subject: [PATCH] test-lib: fix typo in comment
Date: Sun, 27 Oct 2013 10:56:33 +0100
Message-ID: <1382867793-23483-1-git-send-email-hegge@resisty.net>
Cc: Torstein Hegge <hegge@resisty.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 27 15:17:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VaR9s-0006jR-S6
	for gcvg-git-2@plane.gmane.org; Sun, 27 Oct 2013 15:17:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754192Ab3J0ORS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Oct 2013 10:17:18 -0400
Received: from microbel.pvv.ntnu.no ([129.241.210.179]:34820 "EHLO
	microbel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754049Ab3J0ORS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Oct 2013 10:17:18 -0400
Received: from 120.179.202.84.customer.cdi.no ([84.202.179.120] helo=stacker.resisty.net)
	by microbel.pvv.ntnu.no with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <torstehe@pvv.ntnu.no>)
	id 1VaN68-0004a4-UT; Sun, 27 Oct 2013 10:57:34 +0100
X-Mailer: git-send-email 1.8.4.1.808.g053d237
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236803>

Point test writers to the test_expect_* functions properly.

Signed-off-by: Torstein Hegge <hegge@resisty.net>
---
 t/test-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0fa7dfd..3dc1792 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -325,7 +325,7 @@ trap 'die' EXIT
 . "$TEST_DIRECTORY/test-lib-functions.sh"
 
 # You are not expected to call test_ok_ and test_failure_ directly, use
-# the text_expect_* functions instead.
+# the test_expect_* functions instead.
 
 test_ok_ () {
 	test_success=$(($test_success + 1))
-- 
1.8.4.1.808.g053d237
