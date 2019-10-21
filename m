Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC4B91F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 13:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbfJUN4s (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 09:56:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36149 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729257AbfJUN4o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 09:56:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id w18so13574822wrt.3
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 06:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2OSiW1tIz6I5ZXpwz9+l07iHgNNKzetcZNlUCdKH8oM=;
        b=p61dO9mBxgWdq6aQQ7Ouf9Ss7o8V0ocZtXXLX90U8cWyveGF6T8kyIT3M+sP91B/09
         GHvX32uhLvGqrIDtDgI3vAg1kUMsFELnnovPBAPh2C72TUPIxk0R5RiRERH4mWHgR16Z
         /KLC9yj96T4iWul58rOw3xVW2e8zjwr+vTw44CmgpUZaIaLJFElHGy0oEwe+L3ynobbL
         yRCGB9fKN2kIzko9T7ER5hBI8XsB4D5GbacenwHIHs1z7GOPkUOrOcX1y4uO+KVNkSwb
         glh73otvxNKY+Yj633mkmA+cRiCsrKwX9KM5AYPi3I9pCx3l4B7Uh1S9VFHo4p8T9MJ7
         nFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2OSiW1tIz6I5ZXpwz9+l07iHgNNKzetcZNlUCdKH8oM=;
        b=QZJ4lhpj4Rs/ckcQdHUl0a3UoeVQpySPRZY/siLsf1dnatNM/A+jWCTAKmUFIxwUrJ
         1sL8/DaDmtkY0wS837B7CCUhzSZs1x2NFNGy8P0o0q5pZ7C9cCCM1o/oEIvdwOitZl9+
         qNTd/n3mIh12Y8KcdLcDjR3fAymHOfGW1oVg4vh7ZmUQSR2mFKxhhgwR1Wdh8FKCXUjz
         CrnFklKZVydWxKP1AxKmO+ytJ67HC3HPYNQWVMXXmL6G63NZbVgb7RqCDcAvK4Z9b9G4
         5+7ToI3k2osLgO4jGP5l/98RjTWprRH/Zn2xjoUii8T7sMZ5UFxlo3viIhT6YszTWpaP
         +jVg==
X-Gm-Message-State: APjAAAVPpveGbxJq8eHK+y6aoh143nOhZWAxKxqBa/KQhPFiyVE4OzbQ
        9hnv5r0zOd2EwThtfAi5+XaX3Jix
X-Google-Smtp-Source: APXvYqy1s115QDglSeNbtYvKwyob3szIL//xWa2z4o43Tcmz8OXU/AufMCrHfj0MZR9TNhZ1R8Z+/A==
X-Received: by 2002:adf:b21a:: with SMTP id u26mr20896633wra.119.1571666202149;
        Mon, 21 Oct 2019 06:56:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o70sm21075723wme.29.2019.10.21.06.56.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 06:56:41 -0700 (PDT)
Message-Id: <ab20c11d71a98def1c29e949cb267cdae822e5dc.1571666187.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
        <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Oct 2019 13:56:26 +0000
Subject: [PATCH v5 17/17] sparse-checkout: cone mode should not interact with
 .gitignore
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, jon@jonsimons.org, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

During the development of the sparse-checkout "cone mode" feature,
an incorrect placement of the initializer for "use_cone_patterns = 1"
caused warnings to show up when a .gitignore file was present with
non-cone-mode patterns. This was fixed in the original commit
introducing the cone mode, but now we should add a test to avoid
hitting this problem again in the future.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1091-sparse-checkout-builtin.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 2db706a9e4..4205e03449 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -283,4 +283,11 @@ test_expect_success 'fail when lock is taken' '
 	test_i18ngrep "File exists" err
 '
 
+test_expect_success '.gitignore should not warn about cone mode' '
+	git -C repo config --worktree core.sparseCheckoutCone true &&
+	echo "**/bin/*" >repo/.gitignore &&
+	git -C repo reset --hard 2>err &&
+	test_i18ngrep ! "disabling cone patterns" err
+'
+
 test_done
-- 
gitgitgadget
