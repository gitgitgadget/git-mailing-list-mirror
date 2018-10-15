Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADC3F1F454
	for <e@80x24.org>; Mon, 15 Oct 2018 09:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbeJORbh (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 13:31:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40936 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeJORbg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 13:31:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id n31-v6so8906634pgm.7
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 02:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2lVmHcPkK6fUabiMYgRngQyqVc+hgvAjHkCkmFc5DzY=;
        b=eHN7SPD648FautlwQzX1eY8dqeZBB277Ej8fkPevhVLpL0kJ+H/ZWOLDQjjuqI/cHU
         TC3x7ZDr25Hsl1GdgVrXeJSPrOO2naWQC452RC7Dz7OmoLskTZhK2AhpELmGDC/28q8D
         YuSLWhitGvjotvJeQPcfXNGSdFkBB6fbM15kZ5hkDgmyUQ75qtXApXCDZLJ3ecQEMSpT
         jbH4puNz/4DEmVg0/h5EQBi2ZDAFAV595UaoI6xfnDIz/K9CWBBwLvGqaq2b6CYJCHZb
         5/iJHaZY20vqk1GbJ6vnxGqjWp3sF03ALP8WVKGEEWUDVbwbWzNyD0etdIKvRORw8uv9
         b41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2lVmHcPkK6fUabiMYgRngQyqVc+hgvAjHkCkmFc5DzY=;
        b=oQkb3SITzm2UMk0vvx963ZhJTVHXsN9xV1I6EqbezZcuLRwv1M0xxIEhGIfAVnoEYX
         55RoYe7D3Ui4/J3s/5dgwAURnKIQY05X75DhgyaUOEGF53JINsXCVBBCECAgZno+qsYI
         lHgUkyghuuD7o8KQpE6+yjM7Y8HWJWOMKRC8zMgB1wnN8OkuCj+HCVLRvAQxekOcawNB
         jNNJ6uzjoZ6fiIrjjhO3M7s/3ThuyXpevP1r8Qm3jHDjzGH8F7EbqhDahrb9h2W78qiv
         YVSEZNwCrMs6sbsfzXM9uzg9zv2XmPwcPxAIq5Ne/uZT+LEr47+hQrm0VecTanv9gtzD
         hABw==
X-Gm-Message-State: ABuFfoibQXvvvEdD6J2IUh/7TP1vFbRP3b2NvlLscECCeBOAJPwb9HVA
        jmsRdTSOaZYt5UtZ9dYEmZTH+qGW
X-Google-Smtp-Source: ACcGV61EcqdPxS1zXMerQqZOmY0JpMgAh83uvHT9GwAIU68XKW0vC0+UvOeGv1qX0xtgz4dv7OzMBw==
X-Received: by 2002:aa7:8305:: with SMTP id t5-v6mr16691021pfm.81.1539596826059;
        Mon, 15 Oct 2018 02:47:06 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id q68-v6sm6257290pfb.160.2018.10.15.02.47.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 02:47:05 -0700 (PDT)
Date:   Mon, 15 Oct 2018 02:47:05 -0700 (PDT)
X-Google-Original-Date: Mon, 15 Oct 2018 09:46:59 GMT
Message-Id: <63373dd91d0be324273ab34ff49d630453954173.1539596822.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.45.git.gitgitgadget@gmail.com>
References: <pull.45.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/3] getpwuid(mingw): initialize the structure only once
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

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 18caf21969..597781b370 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1800,16 +1800,27 @@ int mingw_getpagesize(void)
 
 struct passwd *getpwuid(int uid)
 {
+	static unsigned initialized;
 	static char user_name[100];
-	static struct passwd p;
+	static struct passwd *p;
+	DWORD len;
 
-	DWORD len = sizeof(user_name);
-	if (!GetUserName(user_name, &len))
+	if (initialized)
+		return p;
+
+	len = sizeof(user_name);
+	if (!GetUserName(user_name, &len)) {
+		initialized = 1;
 		return NULL;
-	p.pw_name = user_name;
-	p.pw_gecos = "unknown";
-	p.pw_dir = NULL;
-	return &p;
+	}
+
+	p = xmalloc(sizeof(*p));
+	p->pw_name = user_name;
+	p->pw_gecos = "unknown";
+	p->pw_dir = NULL;
+
+	initialized = 1;
+	return p;
 }
 
 static HANDLE timer_event;
-- 
gitgitgadget

