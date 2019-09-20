Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	SPOOFED_FREEMAIL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF0A41F463
	for <e@80x24.org>; Fri, 20 Sep 2019 16:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405365AbfITQxz (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 12:53:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42702 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391425AbfITQxy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 12:53:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id n14so7435424wrw.9
        for <git@vger.kernel.org>; Fri, 20 Sep 2019 09:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2MAhdrAonx7LpocIdJOKaz4KH3yJKe0qlHiS0HqRbEc=;
        b=nKb6CaASUTA7F1QidwRkoHsO4GN1nBG3H81XWQGuI/opfy6p+MU8gi4SNXsSN6+oIv
         2afvD1rwgxvfz5i1FPwUUUeQtRkYIw7cVLuTMF7VRp8H4sPWYQFKFkyT8Dv+FOGL8PVc
         hJ6ojEdHW3Pa/IfaCglm/YPHbu50Y1CASJlEMuU27R3EMilkAsuxL+dbbXCOB0zMqV7K
         rP49t00w9JIGUFoKyoNmE0SEvVTC3njjLSovQZM9W3ppCc7CX1SaQ/i1sIecpGhzji1u
         L7VP6vxbFMon1bzuU64cfUcrUJsg0qZOK74Smmx4Tb86w+3HpEhOCBY4kxJFwdizaJkZ
         gV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2MAhdrAonx7LpocIdJOKaz4KH3yJKe0qlHiS0HqRbEc=;
        b=LpIxSMjFKT7ONg95EihrSxQ1uSZwHFgSHH7OJ0684kH50eJ/9tlvzxDChNIPrdaLfW
         h0LXtMWHiVzwjRP3gyU+q8hwHPqztOZ1fmLzxmMRVnkimL3wGKErpScOA9qfmajN9+84
         9TKWI0XqHIbhCWpW0mx9iQ5cqdCKlfaeoWjD1bH2SgdpERvLct+Y5xgtTNI0rWKd9TJo
         kJyJVHckqbgonOiYW5DzqhqP/fRr8xmQEHDWnNdG/pNwVAZAuq5EvTPhs58hhyeNWe7X
         wlFPb+1E84i4vUUOfzKVSgQctbTbE9e+BZk9Z27X97tzKtT4Rsgfz2YoJNgwFULE9tGZ
         5tiw==
X-Gm-Message-State: APjAAAW1S827EXdqzx6xDjZZctwxsH5C7x2LsHToXqEFVhRrzSZnoEug
        DBFNR1CQseeUZxEMcO9EhK2QqXQd
X-Google-Smtp-Source: APXvYqwUDbSPvM8kTC25eAPOSpZl5IoCEA0ixgWmnQk/Gq0n4OIHwtH/z/hHeJ3FIgCjj6qhhEX1/w==
X-Received: by 2002:a5d:6885:: with SMTP id h5mr13201608wru.92.1568998432227;
        Fri, 20 Sep 2019 09:53:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c132sm2675156wme.27.2019.09.20.09.53.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 09:53:51 -0700 (PDT)
Date:   Fri, 20 Sep 2019 09:53:51 -0700 (PDT)
X-Google-Original-Date: Fri, 20 Sep 2019 16:53:45 GMT
Message-Id: <57f6742f09820964453bb325023d44d86bca05a2.1568998427.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.337.v2.git.gitgitgadget@gmail.com>
References: <pull.337.git.gitgitgadget@gmail.com>
        <pull.337.v2.git.gitgitgadget@gmail.com>
From:   "William Baker via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 5/6] midx: honor the MIDX_PROGRESS flag in midx_repack
 Update midx_repack to only display progress when the MIDX_PROGRESS flag is
 set.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     williamtbakeremail@gmail.com, stolee@gmail.com,
        jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        William Baker <William.Baker@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: William Baker <William.Baker@microsoft.com>

Signed-off-by: William Baker <William.Baker@microsoft.com>
---
 midx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/midx.c b/midx.c
index dc7c5f43f8..106ccc4ab2 100644
--- a/midx.c
+++ b/midx.c
@@ -1374,6 +1374,12 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 	strbuf_addstr(&base_name, object_dir);
 	strbuf_addstr(&base_name, "/pack/pack");
 	argv_array_push(&cmd.args, base_name.buf);
+
+	if (flags & MIDX_PROGRESS)
+		argv_array_push(&cmd.args, "--progress");
+	else
+		argv_array_push(&cmd.args, "-q");
+
 	strbuf_release(&base_name);
 
 	cmd.git_cmd = 1;
-- 
gitgitgadget

