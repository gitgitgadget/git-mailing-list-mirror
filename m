Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 395691F404
	for <e@80x24.org>; Mon, 27 Aug 2018 20:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbeH1A3k (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 20:29:40 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37131 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbeH1A3j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 20:29:39 -0400
Received: by mail-pl1-f194.google.com with SMTP id d12-v6so120355pls.4
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 13:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=K65VwEnoM18mn4v7KlCl+CxtPYHXpgqjKxIDTT0LP/A=;
        b=fE55+AV7FKqo8GK854YoUB1Fw0QdJCQK6P/NOHJe9DcuPB8AtTS7HxzeCW0bV+BbN7
         4+PsDPhawm1yCv8ji1KjwliH5I9iY9bb6Rr3UK443j1b54CnaJcwtN+uu5bQzrj9aNM4
         qBpE57yPwfcKkTzjygv8wGlhqaL8pz+brp/mbk3pg1/mNNtouUOMOwqpyvL9JLxmYgtN
         M68g7uC/CVqu4wBnvbihwZoUi7fHw/7Lf59h9/RRl0mI9bB+9U3CQzdGSztRwiWB8tjp
         4tpkFjYrjtXhadZ9EJXKW1ys11cEWo44REgW2Ou/RpDumfizJ4T1MWN4FBWAZOY/nTFz
         tOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=K65VwEnoM18mn4v7KlCl+CxtPYHXpgqjKxIDTT0LP/A=;
        b=XyA5oJlkOgE3HkxbAIxnJ9pUDpO2D6SfbA2+3Ms94D+2ow/kw/jjL5/aQ2pcf/xV/a
         UDDB4mtW4wI75CLJjK7wyauJmMCq8T15X/m99zHJe+799lKX43YrZxnOZ53Z7rdFprXu
         H+mqHeXHsuO9Yoc/uFFJPAZwKThXq7mvR0fcOqThIhlQeufCpRDQJpC+qyP2UBUBN2dI
         /p4iteyVoayin7OWZk0WIxQfB8Z8/zTAn9y2F1pJuP6DSd8g7uPR8Pm8w+pHApm6x2d7
         V4gFi4gxkOEiA4aVtJrGi+K55NZQi9yuMl8+OemdYxd2cofCfbEGlYI7e9LcLPL5myJ+
         fK4w==
X-Gm-Message-State: APzg51DvK5RYfYdii5LPec385I54Iei3B9d9vsvHJ7GhemOPFaKaa4Qs
        2KF2Wz8qODZUC1O5Zh5zu/9IyIzp
X-Google-Smtp-Source: ANB0VdaYl87Y3b3vyHIDYLNAF1S8+WTedHJLUjWSS/tkaV2cE1Kz1vbaKpnrBvztGVtQbP4d+wEphg==
X-Received: by 2002:a17:902:bd4a:: with SMTP id b10-v6mr14544155plx.209.1535402486523;
        Mon, 27 Aug 2018 13:41:26 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id b64-v6sm164040pfg.66.2018.08.27.13.41.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 13:41:25 -0700 (PDT)
Date:   Mon, 27 Aug 2018 13:41:25 -0700 (PDT)
X-Google-Original-Date: Mon, 27 Aug 2018 20:41:16 GMT
Message-Id: <708b4550a115c3905de688dae8c479e7c2636d98.1535402479.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.25.git.gitgitgadget@gmail.com>
References: <pull.25.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/6] test-reach: add rev-list tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
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
index 1b18e12a4e..2fcaa39077 100755
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
+	run_three_modes "git rev-list --topo-order commit-6-6"
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
+	run_three_modes "git rev-list --first-parent --topo-order commit-6-6"
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
+	run_three_modes "git rev-list --topo-order commit-3-3..commit-6-6"
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
+	run_three_modes "git rev-list --topo-order commit-3-8..commit-6-6"
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
+	run_three_modes "git rev-list --first-parent --topo-order commit-3-8..commit-6-6"
+'
+
+test_expect_success 'rev-list: ancestry-path topo-order' '
+	git rev-parse \
+		commit-6-6 commit-5-6 commit-4-6 commit-3-6 \
+		commit-6-5 commit-5-5 commit-4-5 commit-3-5 \
+		commit-6-4 commit-5-4 commit-4-4 commit-3-4 \
+		commit-6-3 commit-5-3 commit-4-3 \
+	>expect &&
+	run_three_modes "git rev-list --topo-order --ancestry-path commit-3-3..commit-6-6"
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
+	run_three_modes "git rev-list --topo-order commit-3-8...commit-6-6"
+'
+
 test_done
-- 
gitgitgadget

