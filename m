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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C3011F462
	for <e@80x24.org>; Wed, 19 Jun 2019 21:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbfFSVGJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 17:06:09 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:40884 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730568AbfFSVGI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 17:06:08 -0400
Received: by mail-ed1-f41.google.com with SMTP id k8so1275878eds.7
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 14:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hZNUWoDxtPYSagWWQfRxxLc7WIBwG+NKxJpRjBW0xjo=;
        b=YF4OgjLsSSxN8o/67aUrdOVsd8f+V1LE58XxlsUhMuG4bz6XNL7GSs59twrUrww68D
         DGy4fM6ZyTVLvyjCyzGe67o6KcwQzh8D3NZJsHYlgL5TOut04MiI9qzyizRLFkv26WGV
         jBc/Kn+Kmx1qEGzLlv5Zu49LM4sMpEy1jhpfk9UMSWVd7a604lt/wrr1DDJAtulLiRFm
         zoBHPPl7iQbuhzt9xgCQmhFN3oM3nabxlvmybvyuFeESOkfLrAcgBKq80ZoKJxP4aFVe
         R/Se57a+MHrWdb9n8kBCKChAIblzjUI/89hdNuJ5O9Pm3bvhNYLqvCk5BVN6+Vg2y3Dg
         N2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hZNUWoDxtPYSagWWQfRxxLc7WIBwG+NKxJpRjBW0xjo=;
        b=Hfp2j2sXBN0UE7bU4+SvXuZSOjfO1QGD/K0NIvCf+nHB5qYx4A4u5d2F2kvvKG4uPH
         WZ3C6n7FZv9JMs/iXC3+drA2hCdr4+5vK0i5q0WBBud/A39c50qmGiIH7SrWkMhzqt5e
         pUFbTt7W67Jede5hc+8W7r3VeiIAz3WA/oT4hXUHbxTRimif5CMHKDbMLJsSGzTXQnlc
         VPt0Aes2AY7IPXumsj3P7PU6nYuPupqLbS+yL7aDWdMQa4E/R1ygiByKi8yDh6wblnBA
         JtmCAIgIRxzmteUJHrGG2PRevRqnuP8mFW8ngURevqtc6681auOQsNUMG4QFMDGzjhpk
         0fDA==
X-Gm-Message-State: APjAAAX/XSQYaUwoh0H2nwjx2NVsvA5RP2wO7LOQBqpdJL8Q390NbAz8
        dBfXbDmYErzieXeNEWo3TzIqy22V
X-Google-Smtp-Source: APXvYqx2TvhzGnieL50YduRqUmvjbG/YNIqz+Id+YS9k0vR5W93e7/ulxn1JKKtxfLNxG4DsQRhcMQ==
X-Received: by 2002:a17:906:68d8:: with SMTP id y24mr61900794ejr.16.1560978366472;
        Wed, 19 Jun 2019 14:06:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p37sm6033606edc.14.2019.06.19.14.06.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 14:06:06 -0700 (PDT)
Date:   Wed, 19 Jun 2019 14:06:06 -0700 (PDT)
X-Google-Original-Date: Wed, 19 Jun 2019 21:05:48 GMT
Message-Id: <63bf9f1f9239280359c0086375117f984ae72dc1.1560978354.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.v2.git.gitgitgadget@gmail.com>
References: <pull.149.git.gitgitgadget@gmail.com>
        <pull.149.v2.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 14/20] msvc: update Makefile to allow for spaces in the
 compiler path
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

It is quite common that MS Visual C++ is installed into a location whose
path contains spaces, therefore we need to quote it.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 8a7e235352..3cf8cc8ffd 100644
--- a/Makefile
+++ b/Makefile
@@ -1240,7 +1240,7 @@ endif
 
 ifdef SANE_TOOL_PATH
 SANE_TOOL_PATH_SQ = $(subst ','\'',$(SANE_TOOL_PATH))
-BROKEN_PATH_FIX = 's|^\# @@BROKEN_PATH_FIX@@$$|git_broken_path_fix $(SANE_TOOL_PATH_SQ)|'
+BROKEN_PATH_FIX = 's|^\# @@BROKEN_PATH_FIX@@$$|git_broken_path_fix "$(SANE_TOOL_PATH_SQ)"|'
 PATH := $(SANE_TOOL_PATH):${PATH}
 else
 BROKEN_PATH_FIX = '/^\# @@BROKEN_PATH_FIX@@$$/d'
-- 
gitgitgadget

