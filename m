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
	by dcvr.yhbt.net (Postfix) with ESMTP id D9E411F462
	for <e@80x24.org>; Wed, 19 Jun 2019 21:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbfFSVGN (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 17:06:13 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:44014 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730580AbfFSVGK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 17:06:10 -0400
Received: by mail-ed1-f46.google.com with SMTP id e3so1245152edr.10
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 14:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7kDTvmNJzxuKVCuUEw2sUjOAOs9WzIM36vSbnY3v/YM=;
        b=TPasIgZ35MyYb0n8V1aPxCPRA7+2guDPlNRJBPLakQlXHS6zNhTVsLPsczKqdJ8C4P
         B9C6gcwVavWcAqKJ0lOyNKf7Cl8K1wCYPM94IDAAhw8GHJNIrl9m3w80mvX1XK0CkwTo
         Mlvs6pHJOUFeIDgTwQxm88kFvG13V1Ro2oI3ctYjo9AiknG7nFNY2OJj/LUL4O8sEenT
         XNNK7pInIgzoEeECI3OGtd/e3xeX5aRHrDIS/ju4oLsv9a3GFVPxq7zL6ueeNAUg7qGn
         vfEP/r/Twnv52Xf+TGj/CgwAu4Zo7R+lmBoVyQKjghPMvS17ok/p1Pca44v7RcuHbRvw
         eJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7kDTvmNJzxuKVCuUEw2sUjOAOs9WzIM36vSbnY3v/YM=;
        b=RRCcc1lsY/+NCrJmoSXGLoLjggaLaWfVrZ+rFZ0nEieWArW6wqZpSmD6oFlY6Nr+xx
         XUFiQCStsy8QljKiHtPewA5SIp9fhXEOKobQ4FDV2fWpwsVsgtQDFdCpChSpYFyRzTkw
         Hx9Ck1mJFz7RQnK7mLcn/WDcK5Ho7bNxQz5lF1pzikB6sAI3Si2Kpk8sO9guF1JRA+es
         Rs5SW2/qUsX/QsLcaqcQ+/0cc60aYqVX5UR49wZ9nbQSYOZvJL9RwHS7QV+XyL2oKGQ3
         3FB+IU3Ws1a62tX4Pyt3mSIvLl5V53cw55TcKzPO2lwFyjjsALild+CCNgpkW7sBA7ID
         l53g==
X-Gm-Message-State: APjAAAXZt9gkLasoQuxtrMfnJZxvUBx7Xyv1nVM1YDnG/Zv1z8uSiqq8
        +lticvtyNjl+657x3UrO7xCl+M8q
X-Google-Smtp-Source: APXvYqz4GsXIePCs8d1B46dTUQlgyBlGQlmPCw44KZo24jCeBp6KRLlKU9yNmlZDfe+eOSnDpQXxzw==
X-Received: by 2002:a17:906:474a:: with SMTP id j10mr86832721ejs.104.1560978368737;
        Wed, 19 Jun 2019 14:06:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m32sm707313edc.89.2019.06.19.14.06.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 14:06:08 -0700 (PDT)
Date:   Wed, 19 Jun 2019 14:06:08 -0700 (PDT)
X-Google-Original-Date: Wed, 19 Jun 2019 21:05:51 GMT
Message-Id: <d9668558dd3dc006c45c5284cd43fbcf78ac094f.1560978354.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.v2.git.gitgitgadget@gmail.com>
References: <pull.149.git.gitgitgadget@gmail.com>
        <pull.149.v2.git.gitgitgadget@gmail.com>
From:   "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 17/20] msvc: add pragmas for common warnings
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

