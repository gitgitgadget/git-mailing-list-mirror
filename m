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
	by dcvr.yhbt.net (Postfix) with ESMTP id DFD851F461
	for <e@80x24.org>; Tue, 25 Jun 2019 14:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731053AbfFYOtv (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 10:49:51 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35274 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731769AbfFYOtj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 10:49:39 -0400
Received: by mail-ed1-f67.google.com with SMTP id w20so19944613edd.2
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 07:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qUawvVx9e8pcL3sa1O6MgFXtN7nuq0z+7VUdxlYXMko=;
        b=JIVq68mihUMrx/q/VOuzSJuN605TKKwoK7cEYp1ZDWqGf9VNSvR69KXAKeKKO42GXM
         zCQ9wF/q3K/9NUjui6kmmkGLw/r6dWhd+4cRCdfuhp73Y7yv33oqlSbVz21F8e/53MXS
         d45qM4uGqw92gRMWcyTaa36vTZknbS5A62nRYX6Hx/nKIUHZGLfq3LN5iYHPauro93wS
         jxH6nZsc508CkRkI3npKe6jnCohGOk+CjmNzTnve3NmNVngWsvuG9+1CQaglNTbXXC5E
         Sd+NEPux+FS6fQWbSr4c1CS13Tvn1XtyL8C+qYDR2ieIu1fkjdGl/luApbllpVhpNOlc
         ppng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qUawvVx9e8pcL3sa1O6MgFXtN7nuq0z+7VUdxlYXMko=;
        b=NyPvu8MCdxxyehzd7Tdy03vSiJ7lS0e4L3wcT567P2yZKzjHzqVZntwjyAjR+hD3C2
         2NHhMMuJGDM0U7rpVQytOSV8q8iq1bLkm4xu6OCO/+gq3qonSzO6+Tx6OpvgtiI57ehe
         vf6S5EMXLDOl8vMJ/7QsEZ+5wT5VcBwmZ8ROEiauPbvpY637rRphyWVjSGXZvaDLeo6T
         D+GpJroNiM2UvgEOEqIy9kyj3t4jvg89I4JYDS3KXZos2PxWG9ePr/vGFZPJRdI5lClg
         tabQXNoZoJ+LAmi1slozbeDNP55erIlpi+dCnTcqLRoRYPTRlGs7MKKZT02ZvlCc9OHj
         5X4A==
X-Gm-Message-State: APjAAAX242xWB3VC56w6iRxtyFjn23P2yA7yy2EtxpObbkQoSP/NxVk2
        IcgtDiacbaSfQ2lfE0T/ZLvbzR+M
X-Google-Smtp-Source: APXvYqx2qY/f58V7V1Fi8fxYmux+ERym4HHfPFoOyKtsI/VeRQDf2gea+V9ml4Gx7mhNetmsPQAZjw==
X-Received: by 2002:a50:87d0:: with SMTP id 16mr118899127edz.133.1561474177703;
        Tue, 25 Jun 2019 07:49:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m3sm4604493edi.33.2019.06.25.07.49.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 07:49:37 -0700 (PDT)
Date:   Tue, 25 Jun 2019 07:49:37 -0700 (PDT)
X-Google-Original-Date: Tue, 25 Jun 2019 14:49:18 GMT
Message-Id: <7cfd0fc9b42eee9bac026f7541b6cceec215000b.1561474167.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.v3.git.gitgitgadget@gmail.com>
References: <pull.149.v2.git.gitgitgadget@gmail.com>
        <pull.149.v3.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 12/20] msvc: define ftello()
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

