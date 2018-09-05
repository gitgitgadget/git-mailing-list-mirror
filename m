Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B42191F404
	for <e@80x24.org>; Wed,  5 Sep 2018 14:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbeIETRP (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 15:17:15 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:39391 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbeIETRP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 15:17:15 -0400
Received: by mail-pl1-f180.google.com with SMTP id w14-v6so3416398plp.6
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 07:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lgN9+HaKNLJe4NXAvjUb52XkOhnN7utX07voe/Kf4ug=;
        b=KhPEqxXdG73oIIFmCOTc7u7dV0oMYC+aenPheMK8IR3BDeXOXB6PYhXFOyaA3aLrSv
         M5DGZiBCKxwI/BOHFalasJ4/yn1CNbGyVJZAJd5+iPcs4zxc2ADQeDfN9VTywq408y3+
         hwKL/PVzWSaFfRZ37KzjGmXLJBS/gNObII3j1j0D7Tfq3PZ2Oog8KQxZahjXOpztZ1L1
         xSp/W0v/yVaxiY++cjAa4WuRtKo8DoDnBp+yydmclHHQHbpGYYybxmathuiuEnOsG69e
         88B2CTkReq4FWAgKFEalcSKd+lVoP8enlWjm5yA8fYK4Z5EuBNeLVQjMxuE4BPGdkVkg
         hBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lgN9+HaKNLJe4NXAvjUb52XkOhnN7utX07voe/Kf4ug=;
        b=J1+8SJilu4fX6+2ltW4uWwnd1Jtfmr/HqiEpwh3/lagMErOXWVh/bNYL6XUOv3NW39
         DK2RXtvLJ+o8hH1NHsd4IwzY4LsGnEIQsF8nzWRZK4N5Y2rRWKtN4nyqEgYUCpRuhwND
         WsQZ7DMqFRdVSG7sh0w69X6M6aYmQJV/XMD8EPlQNoptJC1VwnO0KcqvEO1cy4gl8rQ6
         GR66vQ6wtV/JjMY+PQVL6feOLRwe5HQcd5g9WPZLXw1dT9QXts/WPUdg7qLckQdm2dMI
         gzjcjwOl+2iHqROLFe11SkC58ijH0MMoNRKQe5DGhNyoy/D1pvdEnVsW6cbBbcHHRwzn
         Prhg==
X-Gm-Message-State: APzg51BGUNV61afjEbtS2M+fMjIZcUxG4PGM/whyja0kPR9sHI6jXXSI
        nDz9igWqB077Ipd3ASO8hRUFiYWQ
X-Google-Smtp-Source: ANB0VdajsJe0JURNlKKm3CEXgpHn+EgF3H6D34X2+jIc6TI58MiXOfjz/6S5UvcQn86RFJWruzqsAw==
X-Received: by 2002:a17:902:28eb:: with SMTP id f98-v6mr38936487plb.149.1536158803935;
        Wed, 05 Sep 2018 07:46:43 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id s3-v6sm3159146pgj.84.2018.09.05.07.46.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 07:46:43 -0700 (PDT)
Date:   Wed, 05 Sep 2018 07:46:43 -0700 (PDT)
X-Google-Original-Date: Wed, 05 Sep 2018 14:46:26 GMT
Message-Id: <b08d3f0055c7cdc0e3bcca91ed83d48ae9885c3e.1536158789.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.34.git.gitgitgadget@gmail.com>
References: <pull.34.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 08/11] multi-pack-index: fix 32-bit vs 64-bit size check
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

