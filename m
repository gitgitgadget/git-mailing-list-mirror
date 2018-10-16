Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 842901F453
	for <e@80x24.org>; Tue, 16 Oct 2018 22:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbeJQG3Q (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 02:29:16 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37830 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeJQG3P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 02:29:15 -0400
Received: by mail-pl1-f196.google.com with SMTP id u6-v6so8947677plz.4
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 15:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=y1zQlUARm7GbYNl3NtJpUgMhk/cSFyvMqeULyUEQfWc=;
        b=ZteN7PdkYCdvEjIyHvZpKLhrjLaq58/JYjdfbo2/kKblujho7XQxI7DNmIutwVZP5V
         3Z43qLL1lGgpltrrPwhKpYHeiV6CRCYMANIPUcRYQoH2U7aZvWk9HrYRtFZSIgx30PEC
         h7ZROZ9KjLmqb4l0nWZqtv/Ryt8Z6A7/YaaTtiK0G2hhE2PmHU5OV3pFxb7Ti8gAZbRA
         u3sfb3LrSLCy4PCXTllH0+N9dxrKssCmndRm/pzHK36Zq+Gu1fs0e56niEuPAVltTHph
         Uq7wEjiSV4/1BXfkhZDFSjNcG+RvOlbkwSbdaTUZtWjm6xxWffpdJYC4EDUPK+ieeg/E
         9aSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=y1zQlUARm7GbYNl3NtJpUgMhk/cSFyvMqeULyUEQfWc=;
        b=qWHhFBiOhvYEmkrd2XFmfdV9YUafyxy2w+3nOYfggmmEYDLQoLXLkYGtf0lPou+WK/
         QoCSgK+35wI6rpRz6jV3OIjBurkDACZW7O6mom38mXRuPbcp++fRh3Gv/sVIDVwAPLzd
         4WNNJOzAGpbeeyyXC97stt9xpnitah1UaBn8lyIR94t1nsKoPGi7WsIvuTHwCaKDfiyN
         Eu5G8xpZbdM4HB4jGgW3BfiW9cGt3XwL8AjHblHAyVNF5T32X8lNOPj+A2uBdHh3QJtP
         r6uH7cJNprvohcPzA2MYcRLsoDnlawPTrF41WNv08AuX0Heyj39k3R3rpGOezL5uaWSf
         RWYw==
X-Gm-Message-State: ABuFfogGaSP73n6dtgnvFcw2r4B9mB8gndPZ5moelOTaHTHM2e6akwjT
        iDwDin5rqIczN/nwaUbyHQIv+wnK
X-Google-Smtp-Source: ACcGV630ifs+YMp4ceyiKr0qf6QuEpWgnPeXo5zSotp6WvZRM1qBg8fB0aHFzf318QIzPI2+nJP/5A==
X-Received: by 2002:a17:902:4103:: with SMTP id e3-v6mr23219979pld.236.1539729401903;
        Tue, 16 Oct 2018 15:36:41 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id i184-v6sm21263524pfg.88.2018.10.16.15.36.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 15:36:41 -0700 (PDT)
Date:   Tue, 16 Oct 2018 15:36:41 -0700 (PDT)
X-Google-Original-Date: Tue, 16 Oct 2018 22:36:28 GMT
Message-Id: <12a3f6d3670834f19b38f5e23ef83cdf80a58c33.1539729393.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.25.v4.git.gitgitgadget@gmail.com>
References: <pull.25.v3.git.gitgitgadget@gmail.com>
        <pull.25.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 3/7] test-reach: add rev-list tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The rev-list command is critical to Git's functionality. Ensure it
works in the three commit-graph environments constructed in
t6600-test-reach.sh. Here are a few important types of rev-list
operations:

* Basic: git rev-list --topo-order HEAD
* Range: git rev-list --topo-order compare..HEAD
* Ancestry: git rev-list --topo-order --ancestry-path compare..HEAD
* Symmetric Difference: git rev-list --topo-order compare...HEAD

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t6600-test-reach.sh | 84 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 9d65b8b946..288f703b7b 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -243,4 +243,88 @@ test_expect_success 'commit_contains:miss' '
 	test_three_modes commit_contains --tag
 '
 
+test_expect_success 'rev-list: basic topo-order' '
+	git rev-parse \
+		commit-6-6 commit-5-6 commit-4-6 commit-3-6 commit-2-6 commit-1-6 \
+		commit-6-5 commit-5-5 commit-4-5 commit-3-5 commit-2-5 commit-1-5 \
+		commit-6-4 commit-5-4 commit-4-4 commit-3-4 commit-2-4 commit-1-4 \
+		commit-6-3 commit-5-3 commit-4-3 commit-3-3 commit-2-3 commit-1-3 \
+		commit-6-2 commit-5-2 commit-4-2 commit-3-2 commit-2-2 commit-1-2 \
+		commit-6-1 commit-5-1 commit-4-1 commit-3-1 commit-2-1 commit-1-1 \
+	>expect &&
+	run_three_modes git rev-list --topo-order commit-6-6
+'
+
+test_expect_success 'rev-list: first-parent topo-order' '
+	git rev-parse \
+		commit-6-6 \
+		commit-6-5 \
+		commit-6-4 \
+		commit-6-3 \
+		commit-6-2 \
+		commit-6-1 commit-5-1 commit-4-1 commit-3-1 commit-2-1 commit-1-1 \
+	>expect &&
+	run_three_modes git rev-list --first-parent --topo-order commit-6-6
+'
+
+test_expect_success 'rev-list: range topo-order' '
+	git rev-parse \
+		commit-6-6 commit-5-6 commit-4-6 commit-3-6 commit-2-6 commit-1-6 \
+		commit-6-5 commit-5-5 commit-4-5 commit-3-5 commit-2-5 commit-1-5 \
+		commit-6-4 commit-5-4 commit-4-4 commit-3-4 commit-2-4 commit-1-4 \
+		commit-6-3 commit-5-3 commit-4-3 \
+		commit-6-2 commit-5-2 commit-4-2 \
+		commit-6-1 commit-5-1 commit-4-1 \
+	>expect &&
+	run_three_modes git rev-list --topo-order commit-3-3..commit-6-6
+'
+
+test_expect_success 'rev-list: range topo-order' '
+	git rev-parse \
+		commit-6-6 commit-5-6 commit-4-6 \
+		commit-6-5 commit-5-5 commit-4-5 \
+		commit-6-4 commit-5-4 commit-4-4 \
+		commit-6-3 commit-5-3 commit-4-3 \
+		commit-6-2 commit-5-2 commit-4-2 \
+		commit-6-1 commit-5-1 commit-4-1 \
+	>expect &&
+	run_three_modes git rev-list --topo-order commit-3-8..commit-6-6
+'
+
+test_expect_success 'rev-list: first-parent range topo-order' '
+	git rev-parse \
+		commit-6-6 \
+		commit-6-5 \
+		commit-6-4 \
+		commit-6-3 \
+		commit-6-2 \
+		commit-6-1 commit-5-1 commit-4-1 \
+	>expect &&
+	run_three_modes git rev-list --first-parent --topo-order commit-3-8..commit-6-6
+'
+
+test_expect_success 'rev-list: ancestry-path topo-order' '
+	git rev-parse \
+		commit-6-6 commit-5-6 commit-4-6 commit-3-6 \
+		commit-6-5 commit-5-5 commit-4-5 commit-3-5 \
+		commit-6-4 commit-5-4 commit-4-4 commit-3-4 \
+		commit-6-3 commit-5-3 commit-4-3 \
+	>expect &&
+	run_three_modes git rev-list --topo-order --ancestry-path commit-3-3..commit-6-6
+'
+
+test_expect_success 'rev-list: symmetric difference topo-order' '
+	git rev-parse \
+		commit-6-6 commit-5-6 commit-4-6 \
+		commit-6-5 commit-5-5 commit-4-5 \
+		commit-6-4 commit-5-4 commit-4-4 \
+		commit-6-3 commit-5-3 commit-4-3 \
+		commit-6-2 commit-5-2 commit-4-2 \
+		commit-6-1 commit-5-1 commit-4-1 \
+		commit-3-8 commit-2-8 commit-1-8 \
+		commit-3-7 commit-2-7 commit-1-7 \
+	>expect &&
+	run_three_modes git rev-list --topo-order commit-3-8...commit-6-6
+'
+
 test_done
-- 
gitgitgadget

