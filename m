Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72EF81F462
	for <e@80x24.org>; Thu, 25 Jul 2019 09:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390299AbfGYJQg (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 05:16:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43485 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390290AbfGYJQg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 05:16:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id p13so49896547wru.10
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 02:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iZL9JYiXw6dg3Nz1c9biyGAnt+uDxq8AO8eCx9SLiUE=;
        b=nd5tMLC/L/VxABTGc1OrUmrxNyGiQ6Hof2yvHB+uYybcahVRNPY5f0TCyf7EIS5Z2V
         +3zAIC17jjoGlixoVj7vbQFycMwtprQSp3QUdwd4Tf0fspIEvz3etj6+cCT/8qI8MX00
         VXh9OMA8tVW9Aoa8Fdqq+38yUkaPM+zTQZco89HvYa6NYRWgCA1xb7/gMMUbatTmn27M
         uYaGXXQNPegFUSuFUwwiQC/XfqELdgy4NQUmCQpOuySvrPJxlw/TebI6teLiUQ6dewT8
         BWpsPGZndeOUGOFA62jB7/89QaZVu6XVtbvLCEAEhQgU6NBjgdJ53BYr7dzbYXaw52aH
         nTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iZL9JYiXw6dg3Nz1c9biyGAnt+uDxq8AO8eCx9SLiUE=;
        b=INXRSvQMrToKsC8ORK/VAZIrjgf5N3HC8lnrNTo3s7iGrfVJFuP4zO5ktRVo8ZbL67
         7DZo9TfML2lHtgd4vFwWN0jgO2H3yhDDq809GFx9royR1orz9UstLN0/wjHa7VzLaKHN
         yT6lgloM4scSnSUVNKthCoFwxpPiQXS81Z8tISAWFpk3/QGBNP3zQcbAPlrC1vaUKqIw
         RTPysKedSqZ4dCLy7uLf/0mCKDK8TAp5EUMMtFowvx+WE/uAex3DHqNFtyz5zRsNMsjt
         F5Alkg5plGCGrfS/Dw8N9H3xVeZqKudk9bl9JZQQ/mFnCMzMWOPoa2/bBg07oIajnK4c
         ANIQ==
X-Gm-Message-State: APjAAAWLEC2e5shy18Z/t8GAylfo2fFeK74P+QKYW2H4lj2w/j5RO1gG
        zEjbBKU51v+NcX73xirCfNFM3vqh
X-Google-Smtp-Source: APXvYqxUgcTFCp9kRCrFoRy4cVppflE/bWJ4tmgIGw5M9j2zlwAFPCgFq/5thLr50aza7dQ0kUYQzw==
X-Received: by 2002:a5d:65c5:: with SMTP id e5mr45359160wrw.266.1564046194468;
        Thu, 25 Jul 2019 02:16:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f3sm30838124wrt.56.2019.07.25.02.16.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 02:16:33 -0700 (PDT)
Date:   Thu, 25 Jul 2019 02:16:33 -0700 (PDT)
X-Google-Original-Date: Thu, 25 Jul 2019 09:16:31 GMT
Message-Id: <ed41e8d7abc93603063e9a99f628548608413d34.1564046191.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.296.git.gitgitgadget@gmail.com>
References: <pull.296.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] t3422: mark two test cases as requiring support for
 `--preserve-merges`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We started marking all of those test cases that require `git rebase -p`
to work in the recent past, to allow for skipping them (because the
`--preserve-merges` backend is already deprecated and will be removed in
one of the next major versions, so it is a bit pointless to test its
functionality all the time).

This patch marks two previously forgotten test cases with the `REBASE_P`
prerequisite, to allow skipping them via setting the environment
variable `GIT_TEST_SKIP_REBASE_P`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3422-rebase-incompatible-options.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
index bb78a6ec86..eb5cb67b06 100755
--- a/t/t3422-rebase-incompatible-options.sh
+++ b/t/t3422-rebase-incompatible-options.sh
@@ -65,12 +65,12 @@ test_rebase_am_only --ignore-whitespace
 test_rebase_am_only --committer-date-is-author-date
 test_rebase_am_only -C4
 
-test_expect_success '--preserve-merges incompatible with --signoff' '
+test_expect_success REBASE_P '--preserve-merges incompatible with --signoff' '
 	git checkout B^0 &&
 	test_must_fail git rebase --preserve-merges --signoff A
 '
 
-test_expect_success '--preserve-merges incompatible with --rebase-merges' '
+test_expect_success REBASE_P '--preserve-merges incompatible with --rebase-merges' '
 	git checkout B^0 &&
 	test_must_fail git rebase --preserve-merges --rebase-merges A
 '
-- 
gitgitgadget
