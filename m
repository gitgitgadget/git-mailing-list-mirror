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
	by dcvr.yhbt.net (Postfix) with ESMTP id CAFA31F462
	for <e@80x24.org>; Tue, 18 Jun 2019 12:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbfFRMYP (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 08:24:15 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:34597 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729179AbfFRMYH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 08:24:07 -0400
Received: by mail-ed1-f52.google.com with SMTP id s49so21513172edb.1
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 05:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7kDTvmNJzxuKVCuUEw2sUjOAOs9WzIM36vSbnY3v/YM=;
        b=IysWD+Niy9qw0d0s6OFZvu5vP6HQ7EsFoUe0YImEIrv4G7sVVF6JT2XlKLRoyjz9H6
         UAfYCP45rMvSCSvY/fOgriP1etuso0Ndk1QMfyQDHWCQEjZVmxrtQi8yb6WLIwducDKy
         Yt4DVfb3vAna/Sj+n81zL6MXGr3BPBgX0+H449t5bj8Nwqjp62VAKhqzvA9fJNQ/FLnt
         3qBL8cvKSblNTOCYH2ZnAQEhJr7Hdaexj96ogYpir7ipsBgS8PzhiiTvq4LwwO3Qc1de
         3aSiuqV48GNz7bMkx6tgY/zsPp6h5YgvrybAMgiqskvbmEvd2a0sX9kk/QtQAhU4dorF
         bCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7kDTvmNJzxuKVCuUEw2sUjOAOs9WzIM36vSbnY3v/YM=;
        b=s49Q4BrgSVXPttNo7QlzZmKRMyv0NHOlXO7bvVasDS6mkrZSwySY1su8now2G36rwc
         /K9IUQHJAPgLEW0x2OISXwUL4PNVS1lcIFNrv/aiCPELrpNfrKUWRPwnN+UDLp4Vbkeh
         kAiLJOJxwiVQzEmOKW1V/C2XGmFz1yb05tl8aZ1heCP3Ue+fgIJjXg4CknZsZHiaycxd
         Lu01qU577jw60y5y8/S+DVEwLTuijY3Xhhtuj7GP//HMKrkbpcbguHBHEeHsvSoI2H1k
         Y5TK0a8Qnj4ns61RSDmK5gAMn6PrzXynMp9FwA3V+4GEBJvSQndycqSgwBJvSgU46k8Q
         rt3g==
X-Gm-Message-State: APjAAAV+F2oIIMElL/LARcANmlXtdUFI8H87gj6HIEq4y+cu0iIoW1Uy
        fl7KpnSixp8RKWIC0HaiCRl/7eZq
X-Google-Smtp-Source: APXvYqwJTY13IFZshpAiDTWVXENjLaWg0ma/1staPx7PxJHPA0UDWD2S1f55w1HGPZrhYnix6OGONA==
X-Received: by 2002:a05:6402:14cf:: with SMTP id f15mr65547802edx.255.1560860645644;
        Tue, 18 Jun 2019 05:24:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i3sm4789712edk.9.2019.06.18.05.24.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 05:24:05 -0700 (PDT)
Date:   Tue, 18 Jun 2019 05:24:05 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Jun 2019 12:23:51 GMT
Message-Id: <0cca8c3c68e848836606757745f20287a4fb96c9.1560860634.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.git.gitgitgadget@gmail.com>
References: <pull.149.git.gitgitgadget@gmail.com>
From:   "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 14/17] msvc: add pragmas for common warnings
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philip Oakley <philipoakley@iee.org>

MSVC can be overzealous about some warnings. Disable them.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/msvc.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/compat/msvc.h b/compat/msvc.h
index d7525cf61d..1d7a8c6145 100644
--- a/compat/msvc.h
+++ b/compat/msvc.h
@@ -6,6 +6,10 @@
 #include <malloc.h>
 #include <io.h>
 
+#pragma warning(disable: 4018) /* signed/unsigned comparison */
+#pragma warning(disable: 4244) /* type conversion, possible loss of data */
+#pragma warning(disable: 4090) /* 'function' : different 'const' qualifiers (ALLOC_GROW etc.)*/
+
 /* porting function */
 #define inline __inline
 #define __inline__ __inline
-- 
gitgitgadget

