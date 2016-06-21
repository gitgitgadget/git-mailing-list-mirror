Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9F2D1FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 21:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbcFUVcs (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 17:32:48 -0400
Received: from host02.zombieandprude.com ([80.82.119.138]:50878 "EHLO
	host02.zombieandprude.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbcFUVcq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 17:32:46 -0400
X-Greylist: delayed 1104 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Jun 2016 17:32:46 EDT
Received: from hashpling.plus.com ([212.159.69.125]:35829)
	by host02.zombieandprude.com with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA256:128)
	(Exim 4.80)
	(envelope-from <charles@hashpling.org>)
	id 1bFSzy-0002SO-B8; Tue, 21 Jun 2016 22:14:18 +0100
From:	Charles Bailey <charles@hashpling.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/2] Fix duplicated test name
Date:	Tue, 21 Jun 2016 14:14:11 -0700
Message-Id: <20160621211412.28752-1-charles@hashpling.org>
X-Mailer: git-send-email 2.8.2.311.gee88674
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Charles Bailey <charles@hashpling.org>
---

Spotted while testing t7810-grep and grep "i-t-a" fixes.

 t/t7810-grep.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 1e72971..c4302ed 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -353,7 +353,7 @@ test_expect_success 'grep -l -C' '
 cat >expected <<EOF
 file:5
 EOF
-test_expect_success 'grep -l -C' '
+test_expect_success 'grep -c -C' '
 	git grep -c -C1 foo >actual &&
 	test_cmp expected actual
 '
-- 
2.8.2.311.gee88674

