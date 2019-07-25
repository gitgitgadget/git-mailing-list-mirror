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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6ECC41F462
	for <e@80x24.org>; Thu, 25 Jul 2019 10:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388929AbfGYKL2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 06:11:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33047 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388598AbfGYKLX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 06:11:23 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so50214043wru.0
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 03:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fQ1jpV5hXG3+KClOooYJ0y0WP14LqHDEEcYhh/tCaRc=;
        b=jrUOJGs7pkNdf5UePHb4RRFE/CSUYWOJ+8Gqp5Xcn6DJ8DpR8xwqY8t3WeB7fwYiGz
         JDWi8t/t2SnD1wuLeLZnsn1qmmDHkM4aVkHuKyCTsHznf0QcajS+IR+8CMAsNvCRQo1g
         rEIvyilr5/TXf8h6GcMl5zbtVmhnSQJap+QHA7+2XqvjM+YeEFpHgoBz2UH8zrUYcM/c
         QLwbxFi2HasqaRtiKjiliL1YYRpVGHWtUT7d8mpUyVWyRbyBvBeYCeO0c7zaj+CaLMTu
         2p8F2HiP0XP/efK375+td3CF2F6HDtY18T4IW1iFNDzuSUPVnaFo18CNz1+fy1R35NqD
         zWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fQ1jpV5hXG3+KClOooYJ0y0WP14LqHDEEcYhh/tCaRc=;
        b=DgoucaN24kDYNjZKKSile8f+BxwJ4bLTfPnexWLhEchBC5zF4JO2c0z7qU1ZU+U1GI
         4LrePZgcvMXAp1Q+w2FR/QxlwEY8V323pkLARA7mddcxNixilXXmJSyC8xQoFNkpfwJm
         B0JV+xDgn/jzs4uPJJLmELgUOBdfqd2DqPN7fd2ucKrNLSRc37HxnwV4Ty1uxYnw/8jH
         XIFUS1DDkAzkKYDsoxufubUieVWRpkBKCv/hFjUafcMi28YWKwDtu2gQPtSKOiMhRJN/
         xQI+iHfVNwu2ETDKA+A7X90Y0mujUt3SMGni7RXs1VeJHrt1waEzjGjfRzHOacBF3zE9
         +FBg==
X-Gm-Message-State: APjAAAWDI72BEhU/DZZJvQuZzkooWVWN5097FCB3HW/mr1YzqOBrV5pE
        BBvS/X/QBFsnTXbSYUVdAB22oYoV
X-Google-Smtp-Source: APXvYqxZuGeAqrU06JNtGlv3A+BINGlW8sujEqpUT/wCeSmhVYdsCIlmhOYAZkAwJjmXaduBIvtlWA==
X-Received: by 2002:adf:e40e:: with SMTP id g14mr12019399wrm.161.1564049481369;
        Thu, 25 Jul 2019 03:11:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z1sm49927053wrp.51.2019.07.25.03.11.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 03:11:20 -0700 (PDT)
Date:   Thu, 25 Jul 2019 03:11:20 -0700 (PDT)
X-Google-Original-Date: Thu, 25 Jul 2019 10:11:09 GMT
Message-Id: <7f60b8e745bd1e1c556c28510ee4211e975d9b6a.1564049474.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.294.git.gitgitgadget@gmail.com>
References: <pull.294.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 08/12] t3427: mark two test cases as requiring support for
 `git rebase -p`
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

To prepare for the long game, where the `--preserve-merges` backend will
be dropped eventually, we already introduced the `REBASE_P` prerequisite
to allow saving time by skipping the now-almost-pointless test cases
that verify that that backend works as expected.

Due to the nature of the tests in t3427 (`test_expect_failure` is happy
as long as the scriptlet fails, whether it is for the intended reason or
because `git-rebase--preserve-merges.sh` was deleted), these two test
cases were missed.

When running with GIT_TEST_SKIP_REBASE_P=OhYesPlease, this drops the
overall run time of t3427 on this developer's machine from ~28s to
~8.5s.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3427-rebase-subtree.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
index c0ff3241e4..7a37235768 100755
--- a/t/t3427-rebase-subtree.sh
+++ b/t/t3427-rebase-subtree.sh
@@ -64,7 +64,7 @@ test_expect_success 'setup' '
 '
 
 # FAILURE: Does not preserve master4.
-test_expect_failure 'Rebase -Xsubtree --preserve-merges --onto commit' '
+test_expect_failure REBASE_P 'Rebase -Xsubtree --preserve-merges --onto commit' '
 	reset_rebase &&
 	git checkout -b rebase-preserve-merges to-rebase &&
 	git rebase -Xsubtree=files_subtree --preserve-merges --onto files-master master &&
@@ -73,7 +73,7 @@ test_expect_failure 'Rebase -Xsubtree --preserve-merges --onto commit' '
 '
 
 # FAILURE: Does not preserve master4.
-test_expect_failure 'Rebase -Xsubtree --keep-empty --preserve-merges --onto commit' '
+test_expect_failure REBASE_P 'Rebase -Xsubtree --keep-empty --preserve-merges --onto commit' '
 	reset_rebase &&
 	git checkout -b rebase-keep-empty to-rebase &&
 	git rebase -Xsubtree=files_subtree --keep-empty --preserve-merges --onto files-master master &&
-- 
gitgitgadget

