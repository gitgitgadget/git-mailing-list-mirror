Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C2E820281
	for <e@80x24.org>; Sun, 17 Sep 2017 10:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751186AbdIQKTa (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Sep 2017 06:19:30 -0400
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:46224
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750793AbdIQKTa (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 17 Sep 2017 06:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1505643568;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=bvX1pHWcOT7tEBHPZ0gZNjFpzt0XWjoHdByJ5u2cD/E=;
        b=Un2GXR/GLnj1S0VZvFu2IfSbAlefW88fAYhSIYqGoA6vXlxXu6ETPYxsUhcHIHk/
        aKV7IICvE4P2sBOPyy/MruwfAlOkUmoxIfXwSXjp3xYMTVhooPRWB9aT0dyWKYT63n0
        H30n3OyyyEHEocIBih4BHzEM7BawllSE1Vkl0E0k=
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015e8f599df4-6e3b45f3-b3ea-4483-ad62-08119e29b1cd-000000@eu-west-1.amazonses.com>
Subject: [PATCH] t2018: remove unwanted empty line
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Sun, 17 Sep 2017 10:19:28 +0000
X-SES-Outgoing: 2017.09.17-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 t/t2018-checkout-branch.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index 2131fb2a5682c..e0a52334a22dd 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -192,7 +192,6 @@ test_expect_success 'checkout -b <describe>' '
 test_expect_success 'checkout -B to the current branch works' '
 	git checkout branch1 &&
 	git checkout -B branch1-scratch &&
-
 	setup_dirty_mergeable &&
 	git checkout -B branch1-scratch initial &&
 	test_dirty_mergeable

--
https://github.com/git/git/pull/403
