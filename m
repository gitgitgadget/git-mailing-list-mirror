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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0468B1F462
	for <e@80x24.org>; Wed, 19 Jun 2019 21:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730594AbfFSVGL (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 17:06:11 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41663 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730549AbfFSVGG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 17:06:06 -0400
Received: by mail-ed1-f68.google.com with SMTP id p15so1263527eds.8
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 14:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qUawvVx9e8pcL3sa1O6MgFXtN7nuq0z+7VUdxlYXMko=;
        b=lXUfcyg4bMfFreMf9omfSBNySgijsrPgXz+q+rmO0NG/01s4ehv5B0yNxPfYS9SbUn
         H44u0lo4cZdH0qD24OBsb8aWOJokIEtUC7h7Vz88Rj3nqpuxXPZ0oe4ECnL9BKdLiQQp
         rWrAC3OxuIKNXQG09qpo1BD1MBna90XD2yhcZEPoYyXEdfuqq1PrStbG9PuOVpALpH1G
         1qZaRvQc4Zi4b+9MXz/mpwYAAgAb65IYmjeJG/yYMj569rCu/2gIN5rYiyCbgBpqGgG7
         TZl0ti9XSspJhmSZp3kygn9XyLZ7FjR5Dw/P0RVMMQuFc/pk3z5iDConv4YgctGnLstz
         ridA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qUawvVx9e8pcL3sa1O6MgFXtN7nuq0z+7VUdxlYXMko=;
        b=dqGcRZnjeU6NXddg4p34bbSQOvOkxeCXUVxn51bkn5lAiSrpLz7OsSE4u4KxJm5F+m
         QHe5FKDsq4hrX2scaWHTXluUi3IDl67KsVPs0B2LtVJ+i7LLe4JhpjS5QffkrtbGHJac
         ckzxW/oa3t/Dw/8NxyDu0VQwj1GzOn/J3ikMvIsZ5h+Zg0Hrz02QGXLuTDrl0WKRSPkS
         dhr63KfQ4cyy3hFfVSxDu8dUfPhJjslm1/UNPTuoPpe4jUB1T8H+fcGVfsh1rEGhDUA5
         NcG3ZqnC/i6UlVXYlkW/vq1Wh6LBzPSJAOkcmhyXaSKiBXcNTa5vlC3UGA4pRd9KPsEu
         hVvw==
X-Gm-Message-State: APjAAAXiATCskefSC0G6UyGbO0M2jHE8ArhS/hRgsnqWeQAPuw6+ytOi
        M6fVqyPUDNDWvED0IKjZff9ipCsl
X-Google-Smtp-Source: APXvYqwf3jTzhqJIgz7u2DJAHQ23c8ntKnxiYN+0WjMo/kK/3CkznmQdmQhI4v6LdyeudMIy2KZHpg==
X-Received: by 2002:a50:9282:: with SMTP id k2mr86990329eda.269.1560978365033;
        Wed, 19 Jun 2019 14:06:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h23sm1896278edh.40.2019.06.19.14.06.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 14:06:04 -0700 (PDT)
Date:   Wed, 19 Jun 2019 14:06:04 -0700 (PDT)
X-Google-Original-Date: Wed, 19 Jun 2019 21:05:46 GMT
Message-Id: <7cfd0fc9b42eee9bac026f7541b6cceec215000b.1560978354.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.v2.git.gitgitgadget@gmail.com>
References: <pull.149.git.gitgitgadget@gmail.com>
        <pull.149.v2.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 12/20] msvc: define ftello()
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

It is just called differently in MSVC's headers.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/msvc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/compat/msvc.h b/compat/msvc.h
index d336d80670..d7525cf61d 100644
--- a/compat/msvc.h
+++ b/compat/msvc.h
@@ -18,6 +18,8 @@
 
 #undef ERROR
 
+#define ftello _ftelli64
+
 typedef int sigset_t;
 /* open for reading, writing, or both (not in fcntl.h) */
 #define O_ACCMODE     (_O_RDONLY | _O_WRONLY | _O_RDWR)
-- 
gitgitgadget

