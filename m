Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FA071F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 00:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfKMAsJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 19:48:09 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52860 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfKMAsJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 19:48:09 -0500
Received: by mail-wm1-f67.google.com with SMTP id l1so137675wme.2
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 16:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=3GuW6pp1FHmtAgGWklIaQIg7WgyojR2Y0ZUlqrUDdyI=;
        b=N0ZanDrAEZE049e+2RluyLswZAoKmoDi5/raaQfDL42NFEduvgJrfvWhTPHdp1qs96
         AsYnKLhoBYdDxSTLe0CrV/8iTosDWvHJ0BkEnIvngG6LHWX4h99i1qGS/Xc6z8T0ltr5
         ScovULFyZit0+5Ev64PkxOzLUKzzJvx1qyevCZtGIxAMrqhqUsVaGKD5ud254usFTobL
         nyBy5dpEQObQT+ZR2+WrWXvH0D/4U0OrP4KBVnf7HcjH+3GLV4PeBfzYCQ1nfqNVrpWT
         D6Gd+684NTuvZE9y08ywwhDDQssH9JYDD/obzH/IcHA1UhTeg/Y2kEe0ybA5k33jABNd
         qGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3GuW6pp1FHmtAgGWklIaQIg7WgyojR2Y0ZUlqrUDdyI=;
        b=YwXBOG6iCMUWeA50whm/a7YCQVryNy9yhqrxNDLIpWbVmdymMj7qgCFKcepSbV/3YW
         oUBghl8otk32xVckyc0GGvPRvEs8fIajORqvAAwvjs99KtEPPk/uGRyK14lSsb9TOd8k
         AnlKO3+F/UO2O27qLw4L13ZfvhKhUx4K43aTHWTEd2nxgYLOryb0YvSWT8yYeaSSe5aP
         ZuvSOaH7BSJAP89z/DwfIfZZJjr5DH4V7rmZ1RG+jkzGUzSRjBXLyivLPdw6tMxjiARS
         wxw52NJKhMi5JrFOrOo4HVjKA9oXc0/sXz5kpZRe7ml2Cx/lX+yVzDeSD2KTXNTBpEJH
         4B1w==
X-Gm-Message-State: APjAAAVPoAKrWKlpQiuG5YGpH/+D/V5eDx6/P6WSVvfzSueLSc7pFtkc
        fu2lch4/HzgUyD8p1UwgXVZWgEaz
X-Google-Smtp-Source: APXvYqxeoUy4lHiRJlJLA5RvuMjyAc7cUdAtZbqiMGk8bo+uzhIY3GUM0s+poi7ybrZ07P9ZYiFTrQ==
X-Received: by 2002:a1c:a406:: with SMTP id n6mr266635wme.90.1573606085409;
        Tue, 12 Nov 2019 16:48:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t5sm609838wro.76.2019.11.12.16.48.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 16:48:05 -0800 (PST)
Message-Id: <pull.461.git.1573606072.gitgitgadget@gmail.com>
From:   "James via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 13 Nov 2019 00:47:51 +0000
Subject: [PATCH 0/1] contrib: Add --recursive flag for bash completion
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This flag was missing from the list, and I use it quite often :)

Signed-off-by: James Shubin james@shubin.ca [james@shubin.ca]

Thanks for taking the time to contribute to Git! Please be advised that the
Git community does not use github.com for their contributions. Instead, we
use a mailing list (git@vger.kernel.org) for code submissions, code reviews,
and bug reports. Nevertheless, you can use GitGitGadget (
https://gitgitgadget.github.io/) to conveniently send your Pull Requests
commits to our mailing list.

Please read the "guidelines for contributing" linked above!

James Shubin (1):
  contrib: Add --recursive flag for bash completion

 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)


base-commit: d9f6f3b6195a0ca35642561e530798ad1469bd41
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-461%2Fpurpleidea%2Ffeat%2Fcompletion-recursive2-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-461/purpleidea/feat/completion-recursive2-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/461
-- 
gitgitgadget
