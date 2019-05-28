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
	by dcvr.yhbt.net (Postfix) with ESMTP id B56DE1F462
	for <e@80x24.org>; Tue, 28 May 2019 12:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfE1MmS (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 08:42:18 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33282 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfE1MmR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 08:42:17 -0400
Received: by mail-ed1-f65.google.com with SMTP id n17so31625428edb.0
        for <git@vger.kernel.org>; Tue, 28 May 2019 05:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2fTOT+18DfhivdqRIEQtOSeld/hS+Yo80nD4JjOINXw=;
        b=Orno/YQXjdPWPVeAAiZGHZgiG5qzdw9edEHzwO8gGCtLXyH7nrWf3ThdP0f6gnFrB8
         feq7wkFMz4wpPo8iNmRieUq7GHG398Xqj31Jzj7BFbsQHsNTCLXAvUsx25l/gqPAeK0o
         sc/kKTOwpTo9T0KvUJUAsaPnMIH53jwu5MKVIADTkH/vBVTJlywNBmknPmHY/7JLGsXY
         jx2vg9zNvB9zSuUUd1o7n4MWuRLkozi4R7/82OA5qPVn0eXxiT77FES6V7OGw6a2IcZj
         TeCudGWPhu257abpzDtcNrmds5G5wYER011wxo8goABTUQ3L/2HQlkDxl/BS6A0Rgvnq
         HuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2fTOT+18DfhivdqRIEQtOSeld/hS+Yo80nD4JjOINXw=;
        b=ITPJUQIWj08Crw3HOl/KpqnKxLONXup7i94zfipNhD3zBYPeEo+t/39pUA/NfXK9eS
         201Sb5FKJYWlbKPSk7rO7u9F15RAcg+2IJporxsGj8vncl3Q/CHw9SE5EivQZ3Lz9p9s
         mJ8sg/N84zEcYD0UJXzeJ7DW9HLHYr3RiclEyghqkz2mtsEjz31qT4Iai2R4h/lm1Cfq
         eO58EFhCDUMa8PEsNtTppBUDB+Q2IcxEF5zTnkfaJdsLPAkQI3TfbFOoQlerCm+u66MU
         v8MPqveqGFaul7LSvM8gnRO92OZa2iF20VZFhm9PfZR3B1DBj2HuTNBIfui9AbtGN2ny
         t+6g==
X-Gm-Message-State: APjAAAXF8TvOCy01VOOkiXBiMddlzUDkM7wOSlQM7RkrOAxAUjFYie+i
        yIBF4W+PDhr6aWQrdJkwmjSQ/gPBHh4=
X-Google-Smtp-Source: APXvYqw+l7NnKlUTIGE21sYKkK/gF7tM0eXD0OB1wbxu760un39T/ChNxC40YoXwwdfL29GUtmvXyw==
X-Received: by 2002:a50:b557:: with SMTP id z23mr128440870edd.154.1559047335344;
        Tue, 28 May 2019 05:42:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x40sm4225584edx.52.2019.05.28.05.42.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 05:42:14 -0700 (PDT)
Date:   Tue, 28 May 2019 05:42:14 -0700 (PDT)
X-Google-Original-Date: Tue, 28 May 2019 12:42:11 GMT
Message-Id: <d71308c75c60dbc8208063a50fc5285da557653b.1559047333.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.227.git.gitgitgadget@gmail.com>
References: <pull.227.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/3] tests: mark a couple more test cases as requiring `rebase
 -p`
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

The `--preserve-merges` option has been deprecated, and as a consequence
we started to mark test cases that require that option to be supported,
in preparation for removing that support eventually.

Since we marked those test cases, a couple more crept into the test
suite, and with this patch, we mark them, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3422-rebase-incompatible-options.sh |  5 +++--
 t/t3427-rebase-subtree.sh              | 15 ++++++++++-----
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
index bb78a6ec86..a5868ea152 100755
--- a/t/t3422-rebase-incompatible-options.sh
+++ b/t/t3422-rebase-incompatible-options.sh
@@ -65,12 +65,13 @@ test_rebase_am_only --ignore-whitespace
 test_rebase_am_only --committer-date-is-author-date
 test_rebase_am_only -C4
 
-test_expect_success '--preserve-merges incompatible with --signoff' '
+test_expect_success REBASE_P '--preserve-merges incompatible with --signoff' '
 	git checkout B^0 &&
 	test_must_fail git rebase --preserve-merges --signoff A
 '
 
-test_expect_success '--preserve-merges incompatible with --rebase-merges' '
+test_expect_success REBASE_P \
+	'--preserve-merges incompatible with --rebase-merges' '
 	git checkout B^0 &&
 	test_must_fail git rebase --preserve-merges --rebase-merges A
 '
diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
index 3780877e4e..d8640522a0 100755
--- a/t/t3427-rebase-subtree.sh
+++ b/t/t3427-rebase-subtree.sh
@@ -38,7 +38,8 @@ test_expect_success 'setup' '
 '
 
 # FAILURE: Does not preserve master4.
-test_expect_failure 'Rebase -Xsubtree --preserve-merges --onto commit 4' '
+test_expect_failure REBASE_P \
+	'Rebase -Xsubtree --preserve-merges --onto commit 4' '
 	reset_rebase &&
 	git checkout -b rebase-preserve-merges-4 master &&
 	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
@@ -48,7 +49,8 @@ test_expect_failure 'Rebase -Xsubtree --preserve-merges --onto commit 4' '
 '
 
 # FAILURE: Does not preserve master5.
-test_expect_failure 'Rebase -Xsubtree --preserve-merges --onto commit 5' '
+test_expect_failure REBASE_P \
+	'Rebase -Xsubtree --preserve-merges --onto commit 5' '
 	reset_rebase &&
 	git checkout -b rebase-preserve-merges-5 master &&
 	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
@@ -58,7 +60,8 @@ test_expect_failure 'Rebase -Xsubtree --preserve-merges --onto commit 5' '
 '
 
 # FAILURE: Does not preserve master4.
-test_expect_failure 'Rebase -Xsubtree --keep-empty --preserve-merges --onto commit 4' '
+test_expect_failure REBASE_P \
+	'Rebase -Xsubtree --keep-empty --preserve-merges --onto commit 4' '
 	reset_rebase &&
 	git checkout -b rebase-keep-empty-4 master &&
 	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
@@ -68,7 +71,8 @@ test_expect_failure 'Rebase -Xsubtree --keep-empty --preserve-merges --onto comm
 '
 
 # FAILURE: Does not preserve master5.
-test_expect_failure 'Rebase -Xsubtree --keep-empty --preserve-merges --onto commit 5' '
+test_expect_failure REBASE_P \
+	'Rebase -Xsubtree --keep-empty --preserve-merges --onto commit 5' '
 	reset_rebase &&
 	git checkout -b rebase-keep-empty-5 master &&
 	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
@@ -78,7 +82,8 @@ test_expect_failure 'Rebase -Xsubtree --keep-empty --preserve-merges --onto comm
 '
 
 # FAILURE: Does not preserve Empty.
-test_expect_failure 'Rebase -Xsubtree --keep-empty --preserve-merges --onto empty commit' '
+test_expect_failure REBASE_P \
+	'Rebase -Xsubtree --keep-empty --preserve-merges --onto empty commit' '
 	reset_rebase &&
 	git checkout -b rebase-keep-empty-empty master &&
 	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
-- 
gitgitgadget

