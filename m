Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3989F1F404
	for <e@80x24.org>; Tue, 18 Sep 2018 04:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbeIRJj1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Sep 2018 05:39:27 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44565 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbeIRJj1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Sep 2018 05:39:27 -0400
Received: by mail-pl1-f195.google.com with SMTP id ba4-v6so303474plb.11
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 21:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=K65VwEnoM18mn4v7KlCl+CxtPYHXpgqjKxIDTT0LP/A=;
        b=CspUjKrWDON21EUJBkUY583v1nntis+JCqQTouo8M1o59c6rkE1c/RWCPhuTiO+Nz0
         B/j/S9GnTDlD58Fl9pdvStwYIrVc3F/p95CFeqJFC4bDRt6XSMaAv7JfyrzMzZEJUYE5
         nxrGYEImqa+cs1WrDFOjJHWlne1cstcJ4wgiAgWOiC/QME9dOC3POJf81innsD7It6Ov
         KHm7VeSKC8YXs2aiNdn/FXQAmvyZKUc7FReRo1ZdgqK3A4Js5+G9BJjM4cvEH949joFF
         qRjUdMegHQJh3isReLQPbr8R7e6s4MeC1Lr9i36DteQFDcpKN9nxGtIN4ORJ2JZQvSgR
         ilHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=K65VwEnoM18mn4v7KlCl+CxtPYHXpgqjKxIDTT0LP/A=;
        b=HN00idR5hLnI4xbTw7BzXiQ38ttprVQ4FpprMBFWy7R2SzQBwXA1RC8UOE8AfF7lrI
         CJ4HAM4/ALVd+K/FMwXdoKzbNEHqNOIcaP+I9/1q1k3Kov160H0y/H/SFA6lQFtMH+FR
         XzGDrCOwc5mj/D4i7buSQBcAwxocxulYvhPSVS3QZCWQUyJoUDzwu0wbTB5CQBwjnE7/
         mFK7L9BliElDXB1dzEPJpBDF6qqqnA7vcFPwQqLl1bCyCKdKKhgHoR4rWMeYEyMTBEhK
         Yxfji6tr3To0VPFbOSr2hj3wD6EDVFdWSZRHgVo88zM0mHQ0DKviGzciCxO97ePtFwxG
         jupw==
X-Gm-Message-State: APzg51AOqx4f7Q6qLcvajP9vhGynIa3+yBD00oGijrGf8CS3lXLloQo8
        4cK9EBT6b/BCidtVFpwYYW307++d
X-Google-Smtp-Source: ANB0VdYpJliLvRDomtt/z9aLG0kuDlO1Sjm7IdTojF/pY6GNBDsTp35+MT9MQjzN0RXNIZQ+/rpkCQ==
X-Received: by 2002:a17:902:7246:: with SMTP id c6-v6mr27596610pll.28.1537243726931;
        Mon, 17 Sep 2018 21:08:46 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id y128-v6sm22779629pfb.56.2018.09.17.21.08.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 21:08:46 -0700 (PDT)
Date:   Mon, 17 Sep 2018 21:08:46 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Sep 2018 04:08:36 GMT
Message-Id: <30dee58c615701c8810d055008a687fca278888a.1537243720.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.25.v2.git.gitgitgadget@gmail.com>
References: <pull.25.git.gitgitgadget@gmail.com>
        <pull.25.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 3/6] test-reach: add rev-list tests
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

