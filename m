Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A3311F42B
	for <e@80x24.org>; Thu, 13 Sep 2018 18:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbeIMXNA (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 19:13:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38977 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728193AbeIMXM7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 19:12:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id i190-v6so3105671pgc.6
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 11:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lgN9+HaKNLJe4NXAvjUb52XkOhnN7utX07voe/Kf4ug=;
        b=pdS4COBH4WyZzgSc8xWgExvVl/w5AGWJv1wRVGTtPZ5/fspOJ6LS+EeIQGS9Z+ipbV
         vmBXUY0MkxzdyEP4Kjp6uq2+lU41LjsfXRGx3b64eqF0ovrosold7Fu72wm8r9EyMZys
         RVdx2t404/StUiREt8JPUKq8QbwP9TrZxRnT8EqOU0fBOsDLOZ9ZatwCDT2qDXQrt5Z1
         ZOYC7L93HWqOwQEdcD3r+sbi0OqE46cCzBNApcSTQu8yIlXmK2iwPnLJnNnLtb20OKFo
         zeSkwAbICSFrmJ9woa/VtJ6tXukVd5qKBvMOgfALmBIZ0UuvJjI1Jz3IUjEhGzrUWi+H
         gDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lgN9+HaKNLJe4NXAvjUb52XkOhnN7utX07voe/Kf4ug=;
        b=ZDRrQF4veuU5OU/BeDPrCO6PRC5+yRdWagua/9RA1rbnysPMtxyz+vmw0/pBfCfnoc
         RPx5Zv1K8wWxkxVbVm/nYWIWiYA32Ws/sOfU6eq1dUZLF79xQeLCP1dzOc3+OoTdJAiO
         m2zdBjqXEPG6ZALQz3nmEIzPqYxwp637y8L+0cgoadeBgilv3vZLuZVRf+h/IiicxfAI
         znxZJXSIFNBZTg1v4KNznA2ljnlGZOy3qzGSWF88MnI+rCgx55FOCBoVRAg6BtlwJSHI
         BSUMlSjA8vPqBnSSz32jnq9tjq/2VNXNLvS/gnjs/YjhDYeqfffsuVxWHLI0NWh0cdSa
         wtoA==
X-Gm-Message-State: APzg51DRYbzbmtbOwCS3I5dwGo6zec+BhZzogtfJxev0luFWqHHqPjTj
        /U+4ym7W2//BCz1J5S4KrGRBRjCb
X-Google-Smtp-Source: ANB0Vda3kzybL0pQ1eN4c0EWabQLugFEUZpfO9TBctAzJT+TX0SmMaInSPDHmYThIU3RoCQmu6iCcg==
X-Received: by 2002:a63:e756:: with SMTP id j22-v6mr8206974pgk.185.1536861744547;
        Thu, 13 Sep 2018 11:02:24 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id v140-v6sm6357927pgb.45.2018.09.13.11.02.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 11:02:23 -0700 (PDT)
Date:   Thu, 13 Sep 2018 11:02:23 -0700 (PDT)
X-Google-Original-Date: Thu, 13 Sep 2018 18:02:07 GMT
Message-Id: <210649bf838bf0dc338671c691cbd015bef41240.1536861730.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.34.v2.git.gitgitgadget@gmail.com>
References: <pull.34.git.gitgitgadget@gmail.com>
        <pull.34.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 08/11] multi-pack-index: fix 32-bit vs 64-bit size check
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When loading a 64-bit offset, we intend to check that off_t can store
the resulting offset. However, the condition accidentally checks the
32-bit offset to see if it is smaller than a 64-bit value. Fix it,
and this will be covered by a test in the 'git multi-pack-index verify'
command in a later commit.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index 06d5cfc826..80094c02a7 100644
--- a/midx.c
+++ b/midx.c
@@ -236,7 +236,7 @@ static off_t nth_midxed_offset(struct multi_pack_index *m, uint32_t pos)
 	offset32 = get_be32(offset_data + sizeof(uint32_t));
 
 	if (m->chunk_large_offsets && offset32 & MIDX_LARGE_OFFSET_NEEDED) {
-		if (sizeof(offset32) < sizeof(uint64_t))
+		if (sizeof(off_t) < sizeof(uint64_t))
 			die(_("multi-pack-index stores a 64-bit offset, but off_t is too small"));
 
 		offset32 ^= MIDX_LARGE_OFFSET_NEEDED;
-- 
gitgitgadget

