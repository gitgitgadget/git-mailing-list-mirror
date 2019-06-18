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
	by dcvr.yhbt.net (Postfix) with ESMTP id 60E4A1F462
	for <e@80x24.org>; Tue, 18 Jun 2019 12:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbfFRMYC (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 08:24:02 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45622 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfFRMYA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 08:24:00 -0400
Received: by mail-ed1-f67.google.com with SMTP id a14so21400955edv.12
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 05:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LoCuUzbLrTlxvzT3SSXNCTd+NcF5pCsvxAgW+KCAJpY=;
        b=kQSZg2MgE2DVKAnQR2+Aa4D3KIIbeavEAzBZ4Jy/RigRFV9Qpnn2W/bowYIZHd4Rg8
         GdbStMU/cEc8xxNudJfZDYU1l3QQdf81KqAITqw72G05cQOVLjlHiMkUxWlVFBG/zCrj
         QrAFf/vF8O94/DzaqnGPw5uG4UFvS43oW/2WHleRkQpbRz19TlM7SXdzE/PPe+5mqxuO
         TUnoVx8EI+zTucMaYpRFSjGvvRy2Nqrrq+lZffu/k1duTJ1jJV5SE0Wr4Tzb8A/LxYOT
         AmSH1Wo6HG/2LcXIbr6heJ/NE0NdZDKCmPOxJlgOESvXlRq/jHebVFlb83AWbAkgnoVB
         pJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LoCuUzbLrTlxvzT3SSXNCTd+NcF5pCsvxAgW+KCAJpY=;
        b=aOJ3xLrSXTXlNtgK04GTUQRl0ZHxkzNLIw1vOlUsEiZOI367b+CfpN7u72oUBgyjNq
         YC3jl0wMSqZEX2ICWNcc3DSlP7kTcmuOz1INaaE+1710Qr7m+/HTNERfDetuwE7LNw2a
         sroYA9rx0lt7usvndyckzXQZNP5wzEvQnCHVHXD4Cmwf6HYc8uPCPoYETyUPw422vdDh
         5N+/LVUbTkJJMTVXTIOlUOAXSuz95GluZmnNZr6GPdjbEOJzg+Hwy5Atbpzh9qVEbHpz
         8uOgxFdg5dIPXyLds4DjBQPw9jsqtEH1mdL2m7jRAKX/Foh/zPBuLau85vyem7jFPWi6
         KFUw==
X-Gm-Message-State: APjAAAVfONdSIfE7XAOQXUrpUXOSob4pkTEaHbNRn8wB7K3Gto8KwacR
        YK+CPLPECJixcvzP/IxIFSIVLy4H
X-Google-Smtp-Source: APXvYqxP/0xcb2xjMA/RiYnEGCf7RjkDqvSixpjPOIh6BVN5ltDtBPY1IE/czlYrNfr8Wxrhocto6g==
X-Received: by 2002:a17:906:b6c2:: with SMTP id ec2mr31340922ejb.200.1560860638929;
        Tue, 18 Jun 2019 05:23:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b53sm4732262edd.45.2019.06.18.05.23.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 05:23:58 -0700 (PDT)
Date:   Tue, 18 Jun 2019 05:23:58 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Jun 2019 12:23:41 GMT
Message-Id: <bda1c270c1248fe947183bbb04cb7c55f3a74941.1560860634.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.git.gitgitgadget@gmail.com>
References: <pull.149.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 04/17] obstack: fix compiler warning
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

MS Visual C suggests that the construct

	condition ? (int) i : (ptrdiff_t) d

is incorrect. Let's fix this by casting to ptrdiff_t also for the
positive arm of the conditional.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/obstack.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/obstack.h b/compat/obstack.h
index ced94d0118..ae36ed6a66 100644
--- a/compat/obstack.h
+++ b/compat/obstack.h
@@ -496,7 +496,7 @@ __extension__								\
 ( (h)->temp.tempint = (char *) (obj) - (char *) (h)->chunk,		\
   ((((h)->temp.tempint > 0						\
     && (h)->temp.tempint < (h)->chunk_limit - (char *) (h)->chunk))	\
-   ? (int) ((h)->next_free = (h)->object_base				\
+   ? (ptrdiff_t) ((h)->next_free = (h)->object_base				\
 	    = (h)->temp.tempint + (char *) (h)->chunk)			\
    : (((obstack_free) ((h), (h)->temp.tempint + (char *) (h)->chunk), 0), 0)))
 
-- 
gitgitgadget

