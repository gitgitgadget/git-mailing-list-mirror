Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F82F1F453
	for <e@80x24.org>; Fri,  1 Feb 2019 17:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731542AbfBAR7R (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 12:59:17 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36780 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731515AbfBAR7N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 12:59:13 -0500
Received: by mail-ed1-f66.google.com with SMTP id f23so6173634edb.3
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 09:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+HNHRZvwJJmm0VWKLgMxINFpvo+ixKycoqwfuPzDbZo=;
        b=XkfmAtnrDd2L/xnYxnZFf2GScIjwx8aVw5fCYZY/dGZJZfnD0mM4F1WK13PSlO5KQr
         BFkjkjbFdLEVi/QAiN//A99cUEAobNsmUcyx0tPyzFwwcuP4M6XtxBVObTNtIuXXqm0O
         YOsG3SXRDcVRD27DMo8WqPz8V02HPdsepoJgQj+MDi9+IacbCAFpRlgEdVdC8j+hdiu2
         QHYBMtBKN9pwdxyG20E3ukMQboqLeofst3UKkzEmW+rwP7pFiv9wN8xqXYyzJQn36WqL
         mtxw+0f8/arSvrvGz6d/uMNhWCKICnzOJdNMtPOQX9bgqSwhGHQ+4S4qSGKobLjPrdfW
         vu0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+HNHRZvwJJmm0VWKLgMxINFpvo+ixKycoqwfuPzDbZo=;
        b=Kh0MIH3thPDS5PC+J6h+tNDlSbAecdGrevv9Yt+6/wGA1ESsNBhkxaklqj4JIy4l24
         Fan3Rxr8qfoiqUl4T9MUehGdtacBVszH6xeru+rMgzdzU7+nqULCv2E3BMMSdqemudN8
         1DIEAaR/MJamTXrTmEngHPb4cRu7avyJCnXcTtGhKKWkyqOx8X3upLVd8xIpRBq3wf8N
         PwnGI6w1tKl7x+P2kiaAZbCqaxce4dL8ycTd8Nv21B+DMXJKoKAiyDmSFWpL187QPWTD
         AmYyHkdQfLTC15GFdzkQyV6jC13UuTao+zalPpVUZGA95ZFvyl7RoY/5vYQ/WrL+d1Ri
         tKUA==
X-Gm-Message-State: AHQUAubTqbwuI/q4Ri0j4Bz9msSFJQp+R74GNWYk0B2sovK9jDbSpayK
        PJTKpgg1fM6AShM6s0PLfVKYMXYL
X-Google-Smtp-Source: AHgI3IY6qs77UF0RyKIm1njFT9nD6pL0wwYRQESwc8wYim+fX2waxb9254dx3ZRKeYMXFTam5Zf1vA==
X-Received: by 2002:a17:906:1d16:: with SMTP id n22mr11668197ejh.195.1549043952056;
        Fri, 01 Feb 2019 09:59:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k32sm2204493edb.42.2019.02.01.09.59.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 09:59:11 -0800 (PST)
Date:   Fri, 01 Feb 2019 09:59:11 -0800 (PST)
X-Google-Original-Date: Fri, 01 Feb 2019 17:58:56 GMT
Message-Id: <5f77c9b63307aab2bc5cd083f27b3a9c2f339ba8.1549043937.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v5.git.gitgitgadget@gmail.com>
References: <pull.108.v4.git.gitgitgadget@gmail.com>
        <pull.108.v5.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 15/15] trace2: add for_each macros to clang-format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 .clang-format | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.clang-format b/.clang-format
index de1c8b5c77..41d4cd23fd 100644
--- a/.clang-format
+++ b/.clang-format
@@ -149,7 +149,7 @@ Cpp11BracedListStyle: false
 
 # A list of macros that should be interpreted as foreach loops instead of as
 # function calls.
-ForEachMacros: ['for_each_string_list_item']
+ForEachMacros: ['for_each_string_list_item', 'for_each_wanted_builtin', 'for_each_builtin', 'for_each_ut']
 
 # The maximum number of consecutive empty lines to keep.
 MaxEmptyLinesToKeep: 1
-- 
gitgitgadget
