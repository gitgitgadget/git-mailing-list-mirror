Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECA071F462
	for <e@80x24.org>; Wed, 19 Jun 2019 21:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730533AbfFSVGE (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 17:06:04 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35341 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfFSVGD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 17:06:03 -0400
Received: by mail-ed1-f66.google.com with SMTP id p26so1323058edr.2
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 14:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=r/O7mGiYSOfebeKLkybd1sbh6jRCwfbI+Q4YuChRtPw=;
        b=Uow6ItECsyE7cVi/54GBlTcHXE1y4gpJyLAN/NnFcfoBrIeA1hKFJihW92xcV7DPpl
         V7D49TX8/YIOlgbakHS1scP7cSC9kkoONintsqVBQAN5YLJkao8Et6ckJlVu7HZm31pq
         PD+YJO0Fj+qtD38TUI+xY36G3KibQc80AmGJ55cTWbvEjtdZ4F/070r+PTMupuNvAQCQ
         ZLpTyWc90XvI/1bBIxFIJZTPS/AVoUCtdY5ym+LXekmDsRLZfk7TBNu5iO6p4fPqZRv9
         Plg64U3SoISvsKZcV0n0Z6eEx+9L2xUb9xyuWMiOFyTof2ECmaRKsKIQbqaiDadIpj//
         8puw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=r/O7mGiYSOfebeKLkybd1sbh6jRCwfbI+Q4YuChRtPw=;
        b=eLFyI1xhxxZsHqvf7FQ5EVHbpDA5LXaQ1IAQ3yfMBpVnAZQwjXgeaBo0pd/f4UZ5n5
         nGf4t1PQuDtai4r60Hh8uJxFYhSX/y1DXAOvJNQwGttSZTOr00StUqVZdw4zQ7NQ3ZTq
         ffAu1ZEsayQsKTpXwOIGENnnjHwFLY+NnfO2rzRB+RkWGCUiuexWElEKcGpIOHfn4Ehr
         ULixZ1kLRz2zlH7fo9EeVKn+GeMy4v5e/b1ogZwgfHLDW1eoPCZtFSablF//wVHeWEqG
         xSKmQz/VlKeQAYHBsgNeYmRbliBdb85/4x0SnRvkB+eBgLwff6dnWkOhA8LsYU9rCOxP
         d5vQ==
X-Gm-Message-State: APjAAAUp0k8YW7OfpnfKRxUIj8PAp87Mxi1YLwAlxN5kdJyYqvwJF1Em
        K99r6hq0MqLt7W+yrY/WEBCECd8s
X-Google-Smtp-Source: APXvYqzZ0oUI5D5tCnS1Lp/B19ajVuHHqBoRgM1Pm19fK7lypt+lQZkEysx7sEgczDn+tZN0HqIbGw==
X-Received: by 2002:a17:906:6a97:: with SMTP id p23mr107446945ejr.203.1560978361861;
        Wed, 19 Jun 2019 14:06:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w11sm2063388ejk.63.2019.06.19.14.06.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 14:06:01 -0700 (PDT)
Date:   Wed, 19 Jun 2019 14:06:01 -0700 (PDT)
X-Google-Original-Date: Wed, 19 Jun 2019 21:05:42 GMT
Message-Id: <0a2985dc3c096023928ef81eea6da05ed1cd73f7.1560978354.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.v2.git.gitgitgadget@gmail.com>
References: <pull.149.git.gitgitgadget@gmail.com>
        <pull.149.v2.git.gitgitgadget@gmail.com>
From:   "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 08/20] msvc: include sigset_t definition
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philip Oakley <philipoakley@iee.org>

On MSVC (VS2008) sigset_t is not defined.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/msvc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/compat/msvc.h b/compat/msvc.h
index 29a8ce8204..04b4750b87 100644
--- a/compat/msvc.h
+++ b/compat/msvc.h
@@ -18,6 +18,8 @@
 
 #undef ERROR
 
+typedef int sigset_t;
+
 #include "compat/mingw.h"
 
 #endif
-- 
gitgitgadget

