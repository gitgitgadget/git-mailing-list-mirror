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
	by dcvr.yhbt.net (Postfix) with ESMTP id 343731F731
	for <e@80x24.org>; Wed, 31 Jul 2019 15:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbfGaPTU (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 11:19:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38456 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfGaPSr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 11:18:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id g17so70123006wrr.5
        for <git@vger.kernel.org>; Wed, 31 Jul 2019 08:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PtYDEk8j/culv19HlR3YtTcEAOMgectWhfjlyhZHWAg=;
        b=pZhHhhicBEdQUYqA+OAHSGi9cQgB2aIt/2ZM+WwDwwjKo1AOy+mDcQf9izJq6Wdn3L
         eq20QZdsKVjBxumIZTlKKyD8MLx7187KGsmTGkfcAkXJ5AWIttPcShWdjzcsoD3eGYuQ
         ARMr7WfvQdvuppe66qNrRYVb64GvuSpLpDvz7w5cuLDPgHvb5MS8Q/9jPlnflMsuWiB0
         7iL0xnDEmuaxweS4ocLI80b0G3xziqfOoEXYPG8Eonkc0RhfazS+08aIwt12TTjZLsEg
         vYF4oaA7q6U3stDGtp9FUHlheeyng5+A/X1uCYnAR8LXOB64LXxtlteLnlAbZSRHbdxG
         bUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PtYDEk8j/culv19HlR3YtTcEAOMgectWhfjlyhZHWAg=;
        b=bb4XEuASnNNb3cMZidXbkGafTWHtCdX67MMnah+NJ3hMeOIw20x7Poh3yxgYTiG7ap
         a3q5Kuz1qkneUvNLC09eO4Mu7D/cJ9h5Cjuk6XVEE2wM+AdAJWcLpaL5E8RekR+4tGIE
         1ckA+gMxoLjVaz8Pd9NTrvfib2uTvgAy+ZWAMMauUb3dZR/fWD+OdhC5hd/BSRagfoW7
         3mptUK2JeJyFqHI51W4ZRIZf8k1ygNAyWFKXfG159M3SXg9FNfMy7t3JRQerKZn+mCYH
         pKSY5GaGzEPwQmUajBp/vayMWP11AWCXrE+9v0xn3hyetra139C8qO3G0Idtbc2VGcpp
         G0Sg==
X-Gm-Message-State: APjAAAVYZ9pqZeZp50diZLnJed22S9Bxhn85yBdNfls2kGDa5+Qac66h
        Y2UBQW9RXmeCFh5/Jq+5Iq1Jh9Cc
X-Google-Smtp-Source: APXvYqzqTow6b8WgokCe/rjo9/YHMRbqRgFm3DVK/VUB44ZrATe2ebljLFCYpeKF9puZJspVDKMpKg==
X-Received: by 2002:a5d:63c8:: with SMTP id c8mr55204403wrw.21.1564586325718;
        Wed, 31 Jul 2019 08:18:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b8sm89078973wmh.46.2019.07.31.08.18.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 08:18:45 -0700 (PDT)
Date:   Wed, 31 Jul 2019 08:18:45 -0700 (PDT)
X-Google-Original-Date: Wed, 31 Jul 2019 15:18:30 GMT
Message-Id: <8afec74cfc9907fff7379cc2d7b664deac6f93aa.1564586316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.294.v2.git.gitgitgadget@gmail.com>
References: <pull.294.git.gitgitgadget@gmail.com>
        <pull.294.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 10/16] t3427: fix erroneous assumption
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Apart from the `setup` test case, `t3427-rebase-subtree.sh` is made up
exclusively of demonstrations of breakages. The tricky thing about such
demonstrations is that they are often buggy themselves.

In this instance, somewhere over the course of the six iterations
of the patch that eventually made it into Git's `master` as 5f35900849e
(contrib/subtree: Add a test for subtree rebase that loses commits,
2016-06-28), the commit message "files_subtree/master4" was changed to
just "master4", but the test cases still expected the old commit
message.

Let's fix this, at long last.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3427-rebase-subtree.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
index b21925d279..94cc532e10 100755
--- a/t/t3427-rebase-subtree.sh
+++ b/t/t3427-rebase-subtree.sh
@@ -68,7 +68,7 @@ test_expect_failure REBASE_P 'Rebase -Xsubtree --preserve-merges --onto commit'
 	reset_rebase &&
 	git checkout -b rebase-preserve-merges to-rebase &&
 	git rebase -Xsubtree=files_subtree --preserve-merges --onto files-master master &&
-	verbose test "$(commit_message HEAD~)" = "files_subtree/master4" &&
+	verbose test "$(commit_message HEAD~)" = "master4" &&
 	verbose test "$(commit_message HEAD)" = "files_subtree/master5"
 '
 
@@ -77,7 +77,7 @@ test_expect_failure REBASE_P 'Rebase -Xsubtree --keep-empty --preserve-merges --
 	reset_rebase &&
 	git checkout -b rebase-keep-empty to-rebase &&
 	git rebase -Xsubtree=files_subtree --keep-empty --preserve-merges --onto files-master master &&
-	verbose test "$(commit_message HEAD~2)" = "files_subtree/master4" &&
+	verbose test "$(commit_message HEAD~2)" = "master4" &&
 	verbose test "$(commit_message HEAD~)" = "files_subtree/master5" &&
 	verbose test "$(commit_message HEAD)" = "Empty commit"
 '
@@ -87,7 +87,7 @@ test_expect_failure 'Rebase -Xsubtree --onto commit' '
 	reset_rebase &&
 	git checkout -b rebase-onto to-rebase &&
 	git rebase -Xsubtree=files_subtree --onto files-master master &&
-	verbose test "$(commit_message HEAD~2)" = "files_subtree/master4" &&
+	verbose test "$(commit_message HEAD~2)" = "master4" &&
 	verbose test "$(commit_message HEAD~)" = "files_subtree/master5" &&
 	verbose test "$(commit_message HEAD)" = "Empty commit"
 '
-- 
gitgitgadget

