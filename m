Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 004E31F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 17:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbeJMBHx (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 21:07:53 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:41883 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbeJMBHw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 21:07:52 -0400
Received: by mail-pg1-f173.google.com with SMTP id 23-v6so6152673pgc.8
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 10:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jdX1Rnvq1twVS2CJ+pA4aROvzYh8zoMWnz7LagIzZps=;
        b=WLj8evA0q/f9vl+JqeYLGFUlGbV4B31ll7XKuZr76kZVYJ5Xa/liSV/rgaaN9Hlcyr
         3T3MwvyrpxcfrYdQH1fqd2PCE2c6vpLNYMAV/BsW6gSYcNuL+uTzlJbyuWUFF+azIziB
         /JvkfcXvrGxDJ97f1tH/BC1Wmi8DuRbpDV8fgOIPphmX+wO1NBPA0Y24/yZgS0sMjD9X
         ZPPI8Xl9vxYDjAEKeCvMoCI57TVnlokYt4Y819YdbqZhd+IjnOm9mRYrv2f9RAtdoOcv
         06T9pWP7WohOikKFG/tuYXK2aHBOv9NLBOHaMpcfd9CrAHWbK+NLU8xff+bskmdUXsI8
         lNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jdX1Rnvq1twVS2CJ+pA4aROvzYh8zoMWnz7LagIzZps=;
        b=dDrhuxJfapYqswh8N+KBd4P2kXjFrAcKsUal9CIveRpSnRzsr3DvgkEI3Md7rCw0hN
         NoxYA8VX8U9niVFJjdZYqHxCcoSAIHrkK4zu7Yvp0RsunfM8o+y8DnKi3FB+JOyDUSKO
         6Fgk1hJAtz5iP1JHIaIS6U+01rK9o1GuuiaCovVwK0Y4ORVkQRQc7YOEUJ2m/XVwdDIk
         Gz2y16g2sKtItC9CKC9Q1yAYD1PqbiYKN17MhJJdb7kSd/5orcskE94fD+R/Q73zihS3
         DoMJyBzqhqw0rcUYW3dRyIm0QrjkXspxgPsONRWkjYC7FXVki7EslbDyzaO/1kCxTH4T
         rNGw==
X-Gm-Message-State: ABuFfoh4LCi/OtBkjXMJzNW8H4G5CAQ99xQe9sBrIk/cw6S4Zn4lnjwO
        tQGEZ3r/hE/4ybFkZWLhc79MWq0X
X-Google-Smtp-Source: ACcGV623srrMfcHpDm8MzQjO9HWmP/WdN5zbCc5f5PcqVj+KGlrLfPjSZEtSaPjBkAvMws0dtTsR/w==
X-Received: by 2002:a63:bc12:: with SMTP id q18-v6mr6131672pge.353.1539365658606;
        Fri, 12 Oct 2018 10:34:18 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id g5-v6sm3044679pfk.160.2018.10.12.10.34.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 10:34:17 -0700 (PDT)
Date:   Fri, 12 Oct 2018 10:34:17 -0700 (PDT)
X-Google-Original-Date: Fri, 12 Oct 2018 17:34:12 GMT
Message-Id: <8bd672fe26574972043bc7e041e693c3e17d20a1.1539365654.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.27.v2.git.gitgitgadget@gmail.com>
References: <pull.27.git.gitgitgadget@gmail.com>
        <pull.27.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/3] midx: fix broken free() in close_midx()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When closing a multi-pack-index, we intend to close each pack-file
and free the struct packed_git that represents it. However, this
line was previously freeing the array of pointers, not the
pointer itself. This leads to a double-free issue.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index 713d6f9dde..bf1f511862 100644
--- a/midx.c
+++ b/midx.c
@@ -186,7 +186,7 @@ static void close_midx(struct multi_pack_index *m)
 	for (i = 0; i < m->num_packs; i++) {
 		if (m->packs[i]) {
 			close_pack(m->packs[i]);
-			free(m->packs);
+			free(m->packs[i]);
 		}
 	}
 	FREE_AND_NULL(m->packs);
-- 
gitgitgadget

