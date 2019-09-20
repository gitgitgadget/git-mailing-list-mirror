Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F6001F463
	for <e@80x24.org>; Fri, 20 Sep 2019 22:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730662AbfITWLV (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 18:11:21 -0400
Received: from host02.zombieandprude.com ([80.82.119.138]:54764 "EHLO
        host02.zombieandprude.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfITWLV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 18:11:21 -0400
X-Greylist: delayed 306 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Sep 2019 18:11:20 EDT
Received: from hashpling.plus.com ([212.159.69.125]:48032)
        by host02.zombieandprude.com with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <cb@hashpling.org>)
        id 1iBR2a-0005m3-Uq; Fri, 20 Sep 2019 23:06:13 +0100
From:   CB Bailey <cb@hashpling.org>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH] t4038: Remove non-portable '-a' option passed to test_cmp
Date:   Fri, 20 Sep 2019 23:06:01 +0100
Message-Id: <20190920220601.8090-1-cb@hashpling.org>
X-Mailer: git-send-email 2.23.0.1.g68c7121409
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: CB Bailey <cbailey32@bloomberg.net>

Signed-off-by: CB Bailey <cbailey32@bloomberg.net>
---
 t/t4038-diff-combined.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
index d4afe12554..b9d876efa2 100755
--- a/t/t4038-diff-combined.sh
+++ b/t/t4038-diff-combined.sh
@@ -509,7 +509,7 @@ test_expect_success FUNNYNAMES '--combined-all-paths and --raw and funny names'
 test_expect_success FUNNYNAMES '--combined-all-paths and --raw -and -z and funny names' '
 	printf "aaf8087c3cbd4db8e185a2d074cf27c53cfb75d7\0::100644 100644 100644 f00c965d8307308469e537302baa73048488f162 088bd5d92c2a8e0203ca8e7e4c2a5c692f6ae3f7 333b9c62519f285e1854830ade0fe1ef1d40ee1b RR\0file\twith\ttabs\0i\tam\ttabbed\0fickle\tnaming\0" >expect &&
 	git diff-tree -c -M --raw --combined-all-paths -z HEAD >actual &&
-	test_cmp -a expect actual
+	test_cmp expect actual
 '
 
 test_expect_success FUNNYNAMES '--combined-all-paths and --cc and funny names' '
-- 
2.23.0.1.g68c7121409

