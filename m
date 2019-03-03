Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80F6D20248
	for <e@80x24.org>; Sun,  3 Mar 2019 17:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfCCRL5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 12:11:57 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46449 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfCCRL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 12:11:56 -0500
Received: by mail-ed1-f65.google.com with SMTP id f2so2294955edy.13
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 09:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qeKfQwcLlkFWz4gPjlZ2UmNVoHDBzu39T3HJbs1zShg=;
        b=LZ7A3+8ZZDN/QlYmFepD1oOLKhyHl0JeM09/Cj4jXzsJmqt15kmiCxq7sn68jx7V54
         GrsU4Qx/iESUur9jib8fRkOn2QMzNl9wlmxd0wJNAoM4/n5yBKh5T2yYG6eFBkp7QGXx
         kjxIZTJMm2A69bBa3NiNutE4QzRTtTZWf0jEIPWMg78ggmbKC5fsc+q1MrZjMwMyDJ7F
         cvqml+FlEkLwtXQKISrfnWw8Lh1TERsi9oADMNebtDcPnRqOuT2YJgiZDlpEwkIukAng
         gydDpRe64qGqlBO7xyU5gtQ4DRkWAFe0tpzrOZNJhWIk3UgUgyO6Jmd51dH8z0gbna0O
         Hqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qeKfQwcLlkFWz4gPjlZ2UmNVoHDBzu39T3HJbs1zShg=;
        b=C4yXD3zSVmggIvv9D/xVExLTE3htduOn6P0t9RW4C1o5zpw8GYW9Hx0NzhRNUxcAg2
         UEQspj9kOPQI5pkONkjKfoH4V0i36b/rEEud2wMrMtajrgV6sqK15DHA07eIwgvxEqRh
         60PyZRwomwVKoUV8JBmE6j2Q6tknrq2KeZKZptDlkyxWmuSgQkchIv6JMK1+X5NEvIr+
         YuIhgbOiBBZNRgMu5jLRdSY2BZvtfW7qneVHQwlQc4FYru2AylNepXhqR5zZJqDQJ57t
         dZMPFpTRoAAeHcCOVFZeUNd9T6zrAlN1oMK8wXP/wS7Y5zSu7dRiua4oiLRfXFXbY8QS
         NWeg==
X-Gm-Message-State: APjAAAXElrPzAdkuZCM1WgvIue6eRYOgKFomQT2KMlU92k+Avjx0abYJ
        tM0D6CuO2oNLAOJLQAj2fVz5fYAW
X-Google-Smtp-Source: APXvYqyCx4kYx2xOe/+97yXrvuJSzUNmQYfe3/Ai2Nqlew3SbcI/MmMmUuoUDZl7Ta4Txe71/hKF5Q==
X-Received: by 2002:a17:906:6a82:: with SMTP id p2mr10058107ejr.212.1551633114477;
        Sun, 03 Mar 2019 09:11:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w31sm1367115edc.46.2019.03.03.09.11.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 09:11:54 -0800 (PST)
Date:   Sun, 03 Mar 2019 09:11:54 -0800 (PST)
X-Google-Original-Date: Sun, 03 Mar 2019 17:11:50 GMT
Message-Id: <67e41c032a744096bf7e63c30a570bac01e2f656.1551633112.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.153.v2.git.gitgitgadget@gmail.com>
References: <pull.153.git.gitgitgadget@gmail.com>
        <pull.153.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 2/4] built-in rebase: use the correct reflog when switching
 branches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nazri Ramliy <ayiehere@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

By mistake, we used the reflog intended for ORIG_HEAD.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 813ec284ca..aa469ec964 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -475,7 +475,7 @@ static int reset_head(struct object_id *oid, const char *action,
 				 detach_head ? REF_NO_DEREF : 0,
 				 UPDATE_REFS_MSG_ON_ERR);
 	else {
-		ret = update_ref(reflog_orig_head, switch_to_branch, oid,
+		ret = update_ref(reflog_head, switch_to_branch, oid,
 				 NULL, 0, UPDATE_REFS_MSG_ON_ERR);
 		if (!ret)
 			ret = create_symref("HEAD", switch_to_branch,
-- 
gitgitgadget

