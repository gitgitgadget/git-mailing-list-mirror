Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB60B1F461
	for <e@80x24.org>; Tue, 14 May 2019 11:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfENLWf (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 07:22:35 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40912 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfENLWd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 07:22:33 -0400
Received: by mail-ed1-f65.google.com with SMTP id j12so21603507eds.7
        for <git@vger.kernel.org>; Tue, 14 May 2019 04:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/GJiEyTi5lxX8CARpPutU4SPKwi7xZGxBG+qZbGdXa4=;
        b=AA6ubZwrTwAs8gb+X1bwxRQ/mvNz4XVc+TO/7mjroD2c48uFslLSkjfybH961vglGG
         r0nEIiGaGrFbt5aYbNy8L79mHtX+ZTYBOjAAAvqwC7cPuTo1zVpDXEkRgP8+WLVjMO39
         Pu+CTXFdfjmr6WIcr0Rfo4ALqi3dOADeACA15d8EbZpC0Kl4nL/h+52X/WFJqjbcUwoI
         92f1Sw/iM3LNcorYkt1dkKDC0Hfapg/+25k/WjbHR1tQQzwHyix2JOgr6n01MfWNp3LB
         xkTqH/5juDke69z0ZpyLx3akQbe1rfAqSj12SNyH0VkMWCrIqY7vMvyG0a0/VJzOzPfr
         +cHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/GJiEyTi5lxX8CARpPutU4SPKwi7xZGxBG+qZbGdXa4=;
        b=ly+3UoNo2bntBH68mI798GquRNn6EoaYX2Lhs6iev5gz55R/mZJyz+le86uU1tEj+g
         VIATh5Yzwi7ssmBVMn5seKMnVNRrbBUvJ+u6GlnqcOqmvNU5rDo9EY0wYqR2H5ZXnorj
         y6Wv/XwB5gQWgArn0K6w9smkSflFAaKT6qvN/+C6DBR09wZLmi+zEy7jvCf6jDpnb9fw
         RAr8RL+tP4WdMGwxRj+lOu4FyHsjwxXgYIaCibFDS6Ohij7gKNHUhNM04fc+LvkFl+yQ
         zwnqU+ND+0zdBoPBH75Gd1w4O6HOdQRVZqYJdOuF0GYRNsJml+o2jEmBwTL9b8eX7CrD
         y6Mw==
X-Gm-Message-State: APjAAAUzAnFD/133Q91DyoH7nYAza78ijXrWEiEAx+tGHwYPwIJPAZq2
        mGpshC3yRW7WZUsbmkQFMJYgkTDC
X-Google-Smtp-Source: APXvYqwHzfInLaoi5c5DXRYNTR8e2AUeSqM2LqZZE2Xlga1QkNPfYlfWf/DFViFbTjSQt7e8yks7qA==
X-Received: by 2002:a17:906:3e85:: with SMTP id a5mr26982803ejj.272.1557832952455;
        Tue, 14 May 2019 04:22:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s57sm4446326edd.54.2019.05.14.04.22.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 04:22:31 -0700 (PDT)
Date:   Tue, 14 May 2019 04:22:31 -0700 (PDT)
X-Google-Original-Date: Tue, 14 May 2019 11:22:26 GMT
Message-Id: <b9d1fd14c8ff9cd649a348941f83ec832232eef3.1557832949.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.194.git.gitgitgadget@gmail.com>
References: <pull.194.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/5] t3400: stop referring to the scripted rebase
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

One test case's title mentioned the then-current implementation detail
that the `--am` backend was implemented in `git-rebase--am.sh`.

This is no longer the case, so let's update the title to reflect the
current reality.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3400-rebase.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 42f147858d..80b23fd326 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -285,7 +285,7 @@ EOF
 	test_cmp From_.msg out
 '
 
-test_expect_success 'rebase--am.sh and --show-current-patch' '
+test_expect_success 'rebase --am and --show-current-patch' '
 	test_create_repo conflict-apply &&
 	(
 		cd conflict-apply &&
-- 
gitgitgadget

