Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8732020229
	for <e@80x24.org>; Thu, 10 Nov 2016 20:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964990AbcKJUer (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 15:34:47 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35149 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935817AbcKJUen (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 15:34:43 -0500
Received: by mail-pf0-f170.google.com with SMTP id i88so151077910pfk.2
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 12:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UO1+pSwgOYBfhboWQOJFvhe5SeYFkrxn7gCPLiVPlsA=;
        b=QpPR9Y8/PMry9Y2MypDBr28RUIRUIuI0liDT6gX25V9h3MzlrwERnVog+MIkfzikXP
         Dq3NSOlRQb2U+3xnQqv9mqjii6o/koWoGBUQJqK5sf4cXycEhKw5GpA0o5WTZSwWsdqY
         uN8Ul+I1b1TyT7oSLSM2SoO7WYmBWeUZ8XeBWSJsRqa5BUJP2NZSNWcWzjOESRf8JiQe
         ibyPDpmld/JqEweC6P/ZwxPJhfUi66Sb+XDeH2Ol0h5nZCxdWdGWZXM9rt4szTJVZToV
         6VJmd7jH15EoB9taj3+30yx00vNcrNBmd2Lwnm+WuBbrIDTePlcDXHrOVtRrG2g7JIr6
         e6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UO1+pSwgOYBfhboWQOJFvhe5SeYFkrxn7gCPLiVPlsA=;
        b=GaF4MUQzD/NSZDg1jq5UtI9oeL5ASbvzNnbrKgnuAfYsULSlEm8LfXx/w3DjI2ewKP
         xMWzfiRfaY+rJ+whP7g5Ln77s3TAxiBrAl8WyhBP9A+due5cndgIbiBORSHPtO/3K6D6
         TIMnADyHeR/MBw3Voo/sDPy+JTnXg0dfghqWzK89PXk+g02bORcY6PlMarMlUGrsZCXB
         8Uq4OHkGmoc7Hpp/z3o+h5RmnQcMMJBO99KCJbKI+eCmGtAwnyl7HMqM1USO/92zNpaX
         OdR20fi9UsDC+lsx5lysh8xJ4oiPm89b8wisTSVm0Qoyg2Mnzwrlv2TtEXXnBrTl4Rb8
         H6Wg==
X-Gm-Message-State: ABUngvcbKxNm32xW5HY67TZsIbCsiGcP3XRRTjmZ9DZB12IA/BRcNSKpvYugjjI+iyf9xC4S
X-Received: by 10.99.242.5 with SMTP id v5mr37966438pgh.181.1478810081958;
        Thu, 10 Nov 2016 12:34:41 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:b504:dcf8:965a:7ab8])
        by smtp.gmail.com with ESMTPSA id a22sm9364907pfg.7.2016.11.10.12.34.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 10 Nov 2016 12:34:41 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, bmwill@google.com, pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 05/35] attr.c: complete a sentence in a comment
Date:   Thu, 10 Nov 2016 12:33:58 -0800
Message-Id: <20161110203428.30512-6-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161110203428.30512-1-sbeller@google.com>
References: <20161110203428.30512-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/attr.c b/attr.c
index 05db667..a7f2c3f 100644
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
2.10.1.469.g00a8914

