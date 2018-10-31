Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5188C1F453
	for <e@80x24.org>; Wed, 31 Oct 2018 20:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbeKAFBf (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 01:01:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33460 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbeKAFBf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 01:01:35 -0400
Received: by mail-pg1-f193.google.com with SMTP id q5-v6so4189978pgv.0
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 13:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RWyEvZgIgwu+DAlrIh+oX5uvNmOW/34eeJ60po0Nl2I=;
        b=qzjOO3n5ygNPXX7YoZIADUsdToC/yrzyaAfXttGxVDSYraqVXY0Vj1DXhtRwJE6PPE
         55zsp3VI92uupSJaCpp/02GQQOOFo5Glbi5USrVPk4pRTwdhqnUnhdQl+/aDj8V72VmM
         ZF2KjDELQ2OmsNqx3f3aGwRwK1I5cVK+UxXQzYekWnMNX680YSan//pZyb2QwqAgW7JE
         FjMaNhgwkrovJucb/pINTwq1VUfywQzy1JeW9qMdgYv88tany0WgN3KITUhESj6I3duj
         /O1dkPJMWFVlhIJ1WM4ceO7K5cnR0DrpcHcoSL3UiKqDuH3/ajhQ7DSyh4EdZiG1uRIh
         bHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RWyEvZgIgwu+DAlrIh+oX5uvNmOW/34eeJ60po0Nl2I=;
        b=em0rjDqfaygzf1F2FQv9tkaNHjWzNJ6a56UaNBrLu0UwdTggsWfW+Rx15eqQRtHQsY
         t/qJCHuZ4tVItj4ABeDqf3HxPWw3VUG4wKY0P+xeO6Nq+l4a2lfXfdAd2nKXxdr84/mI
         0/gE1Q6Sf+jOuWSkHaP/80F1bai1qKKN1gFq5jbWjadZ1bazs2z3fTL+zQyJ1b3h6BCp
         zXi5RH9fg5z0p+b9Sh0B+YJ5E3UFymPnjlZeYsAZiHYp8hWb7NnI64IeO6QEFzBjHq18
         z772Tr3R7TG16akEmvqTcWmaqzAdDHmEkCCPYss6WJoH/YuHkrhWJOAnodkUFh0XYVXc
         WP8Q==
X-Gm-Message-State: AGRZ1gLHrKWb6zj/Ulxkk7LwyiyAdnTuoz8/K/nBeGpX64rQ64BqBzY/
        wVS1n+G10HGrOSRj34CmeDAlcJ6Q
X-Google-Smtp-Source: AJdET5f+YTNj1AJjYxtdiUGRlvZVqG2Zntpvwapwj4nEvl0l8g7UYE/17Q7gsEY5aHCL4YpgjQ5Wng==
X-Received: by 2002:a63:2643:: with SMTP id m64mr4342958pgm.35.1541016121364;
        Wed, 31 Oct 2018 13:02:01 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id y88-v6sm17728906pfd.104.2018.10.31.13.02.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 13:02:00 -0700 (PDT)
Date:   Wed, 31 Oct 2018 13:02:00 -0700 (PDT)
X-Google-Original-Date: Wed, 31 Oct 2018 20:01:53 GMT
Message-Id: <f7d7892a48a90b54f466569ac220cb2c9e319806.1541016115.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.63.git.gitgitgadget@gmail.com>
References: <pull.63.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/3] t3418: decouple test cases from a previous `rebase -p`
 test case
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

It is in general a good idea for regression test cases to be as
independent of each other as possible (with the one exception of an
initial `setup` test case, which is only a test case in Git's test suite
because it does not have a notion of a fixture or setup).

This patch addresses one particular instance of this principle being
violated: a few test cases in t3418-rebase-continue.sh depend on a side
effect of a test case that verifies a specific `rebase -p` behavior. The
later test cases should, however, still succeed even if the `rebase -p`
test case is skipped.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3418-rebase-continue.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 25099d715c..031e3d8ddb 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -177,6 +177,7 @@ test_expect_success 'setup rerere database' '
 	git checkout master &&
 	test_commit "commit-new-file-F3" F3 3 &&
 	test_config rerere.enabled true &&
+	git update-ref refs/heads/topic commit-new-file-F3-on-topic-branch &&
 	test_must_fail git rebase -m master topic &&
 	echo "Resolved" >F2 &&
 	cp F2 expected-F2 &&
-- 
gitgitgadget

