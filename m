Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCC8B20A17
	for <e@80x24.org>; Mon, 23 Jan 2017 20:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751571AbdAWUfu (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 15:35:50 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34108 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751516AbdAWUfp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 15:35:45 -0500
Received: by mail-pg0-f41.google.com with SMTP id 14so47682527pgg.1
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 12:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=enw/zVlgh0xizaKSE++CZ6ny5hlst0g9dZGlqkXdCgY=;
        b=BWRku26Yrl0tAgxUCmLJStRIiXiZNNCfPVjlSKWZrsMu0SteCBmtkT0wXvv7U/wkFZ
         Wah3CXF0cPhe44GLqVSHYlQcd1bC2i0D+gFBDyApPH3D4DZeFjF9r8DOaoT+UTGAzTQX
         3eE6ezsuWl7v/O8pkpxpZbKra4KL2Muh4otbgvOGrssEEbEL4APYszD1TpYDHHuyw3Gk
         golcxRazc1MoVBZr7dLT62B3kgtshUt/Ip2xAAR0uXxp3cIbe4GGqij+n+EhS65qPsZ1
         RcD0H8Byl8c5AfDMQCV6TNB/x/6qDEHKTQ3eL/sKnZ7lAnGdaJoUQfzJUbwiceDdDYvO
         clhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=enw/zVlgh0xizaKSE++CZ6ny5hlst0g9dZGlqkXdCgY=;
        b=Ra0GIFDBz7HtGnSSq13eQfIQ2BuXgeJeSNygDvbeCB3x46wWsSXR6dAHkz/beSxWyq
         BsSRBgVFC0xAAds6Z+cQnzMJmiO/pGDjE9XleCfzrsstpDAiCKzfDObztQrqE38hvWCt
         nRajZHZoFSk4ZoAU5Lam0htj/EZdhuJbaGTWo8p4uat8fbOQVfiTmmdJ3LWAcNMTX6X+
         UAedlADiE+fAtafyl93mhwIm6t2d4/2ihDm1qGhH9mcTH4VS8ZRafzXbVLAKiWsdPUA/
         26peb7Bzyr08NjN2MB8TTq0mG4LeXIpvByp7L9Co9cTahCHPwk+M0KCSBrtXH2iD/OjB
         68Qw==
X-Gm-Message-State: AIkVDXIdS4gdoj348Pe93rkut4K8kJ6R2pGeNGIwXOt24Od5q3gcEZgmeiv6V+nLOA+H//fG
X-Received: by 10.84.148.203 with SMTP id y11mr46049679plg.29.1485203744568;
        Mon, 23 Jan 2017 12:35:44 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id z29sm39280832pgc.7.2017.01.23.12.35.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jan 2017 12:35:43 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, sbeller@google.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 05/27] attr.c: complete a sentence in a comment
Date:   Mon, 23 Jan 2017 12:35:03 -0800
Message-Id: <20170123203525.185058-6-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170123203525.185058-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
 <20170123203525.185058-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/attr.c b/attr.c
index 6b55a57ef..9bdf87a6f 100644
--- a/attr.c
+++ b/attr.c
@@ -300,7 +300,7 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
  * directory (again, reading the file from top to bottom) down to the
  * current directory, and then scan the list backwards to find the first match.
  * This is exactly the same as what is_excluded() does in dir.c to deal with
- * .gitignore
+ * .gitignore file and info/excludes file as a fallback.
  */
 
 static struct attr_stack {
-- 
2.11.0.483.g087da7b7c-goog

