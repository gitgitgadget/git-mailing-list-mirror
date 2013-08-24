From: Kacper Kornet <draenog@pld-linux.org>
Subject: [PATCH 3/3] t/t7106-reset-unborn-branch.sh: Add PERL prerequisite
Date: Sat, 24 Aug 2013 06:01:46 +0200
Message-ID: <1377316906-70338-4-git-send-email-draenog@pld-linux.org>
References: <1377316906-70338-1-git-send-email-draenog@pld-linux.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 24 06:02:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VD533-0001sM-Ep
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 06:02:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754865Ab3HXEB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 00:01:58 -0400
Received: from carme.pld-linux.org ([193.239.45.140]:59354 "EHLO
	carme.pld-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754563Ab3HXEB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Aug 2013 00:01:56 -0400
Received: from draenog by carme.pld-linux.org with local (Exim 4.80.1)
	(envelope-from <draenog@carme.pld-linux.org>)
	id 1VD52x-000IWW-0k
	for git@vger.kernel.org; Sat, 24 Aug 2013 06:01:55 +0200
X-Mailer: git-send-email 1.8.3.4
In-Reply-To: <1377316906-70338-1-git-send-email-draenog@pld-linux.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232860>

The test 'reset -p' uses git-reset -p, so it depends on the perl code.

Signed-off-by: Kacper Kornet <draenog@pld-linux.org>
---
 t/t7106-reset-unborn-branch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7106-reset-unborn-branch.sh b/t/t7106-reset-unborn-branch.sh
index 8062cf5..499cd88 100755
--- a/t/t7106-reset-unborn-branch.sh
+++ b/t/t7106-reset-unborn-branch.sh
@@ -27,7 +27,7 @@ test_expect_success 'reset $file' '
 	test "$(git ls-files)" = "b"
 '
 
-test_expect_success 'reset -p' '
+test_expect_success PERL 'reset -p' '
 	rm .git/index &&
 	git add a &&
 	echo y | git reset -p &&
-- 
1.8.3.4
