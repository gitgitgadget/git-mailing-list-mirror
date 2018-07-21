Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79D7D1F597
	for <e@80x24.org>; Sat, 21 Jul 2018 07:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbeGUImG (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 04:42:06 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34805 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbeGUImF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 04:42:05 -0400
Received: by mail-lj1-f193.google.com with SMTP id f8-v6so12899452ljk.1
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 00:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OQxDy1mYybRH8UAaNZit/ykOd6kHHhmV2un3ohUB1cA=;
        b=E316vkd/PE/l/tGPwflGt2GYlThVXeD4kUHXr/pcf6jQQYWGEKmXUGzQQaFRpEQJFm
         LlXR1HJwE/vsSJX2QAiwUft2x+u4/YY8/f0ZJy9sCS1vGtGtLCUTTx91ZSjJKV1PXUv0
         wvgXsgI38IT4i9bBE3wUWtemm/QaCgivRzhRso+oxLU0a8WC8Aq32YzJTlnXzG+wehuQ
         JUkEX6UQhyqI9inJJezeRNhSCXi5WnQYib9ClZR9lm2ZhKOarOsQ0TGALWcwG5+fm0UQ
         0eUucpDIUVNZSOdwNSh7ssP88gTLFYoc/09TIu2LsCqXptd0uVjeI4ZoMlZQxXjaoV1w
         dUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OQxDy1mYybRH8UAaNZit/ykOd6kHHhmV2un3ohUB1cA=;
        b=FbHvFiEvlEv++GGoLzpehsWepWirHGl5Vboz6Qkk/NpAH97PROVuJ5jL0yIOBUb86h
         iKkSUq9SKY1DX6auzqk9WrIX05tK706keHo43CrPBgBMCyg2h3RMVnBJgHQ0DdwiApfA
         G/yPAY0zZ53y8lBBjfndkZwa5zGdQP32ErFjSFA6Pe8shkMU2SNeTBFJuFjcVg5tMNQU
         3nTxaoMhomSaEB8ChqsSqhIDyUGc9Kg0aX94g/0siuAEVacLTQjjBfaw//lAfcDxQNDS
         f+zYVy1oR9f8n9VI11AWAmh5Ag3gvd1Lams0DonsQ2kpmEageqIEV70WuQKYf8DPVU9D
         /6kA==
X-Gm-Message-State: AOUpUlGkQYH65ZRIj0qK28A/U7R1ONnTEoJhduB+hWOjZgX3nh0LqNrH
        oheWVI1egHShFct4Ro3tlF5Y7t2R
X-Google-Smtp-Source: AAOMgpdTfylgTxQPqNmFbL8ewWuCyg8uGuw277OpGl9KZx3zWchC0dqtBnDzuor+nHNAc+zCiSS3Mw==
X-Received: by 2002:a2e:195c:: with SMTP id p89-v6mr3440610lje.138.1532159415800;
        Sat, 21 Jul 2018 00:50:15 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n3-v6sm759898lji.96.2018.07.21.00.50.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 00:50:15 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        stolee@gmail.com
Subject: [PATCH v3 19/23] replace-object.c: mark more strings for translation
Date:   Sat, 21 Jul 2018 09:49:37 +0200
Message-Id: <20180721074941.14632-20-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.656.gda699b98b3
In-Reply-To: <20180721074941.14632-1-pclouds@gmail.com>
References: <20180718161101.19765-1-pclouds@gmail.com>
 <20180721074941.14632-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 replace-object.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/replace-object.c b/replace-object.c
index 801b5c1678..ddc1546b8c 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -17,7 +17,7 @@ static int register_replace_ref(const char *refname,
 
 	if (get_oid_hex(hash, &repl_obj->original.oid)) {
 		free(repl_obj);
-		warning("bad replace ref name: %s", refname);
+		warning(_("bad replace ref name: %s"), refname);
 		return 0;
 	}
 
@@ -26,7 +26,7 @@ static int register_replace_ref(const char *refname,
 
 	/* Register new object */
 	if (oidmap_put(the_repository->objects->replace_map, repl_obj))
-		die("duplicate replace ref: %s", refname);
+		die(_("duplicate replace ref: %s"), refname);
 
 	return 0;
 }
@@ -69,5 +69,5 @@ const struct object_id *do_lookup_replace_object(struct repository *r,
 			return cur;
 		cur = &repl_obj->replacement;
 	}
-	die("replace depth too high for object %s", oid_to_hex(oid));
+	die(_("replace depth too high for object %s"), oid_to_hex(oid));
 }
-- 
2.18.0.656.gda699b98b3

