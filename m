Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09E1D1F437
	for <e@80x24.org>; Sat, 28 Jan 2017 02:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751003AbdA1CCi (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 21:02:38 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36208 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750876AbdA1CCg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 21:02:36 -0500
Received: by mail-pg0-f49.google.com with SMTP id 3so26924468pgj.3
        for <git@vger.kernel.org>; Fri, 27 Jan 2017 18:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=enw/zVlgh0xizaKSE++CZ6ny5hlst0g9dZGlqkXdCgY=;
        b=Vjp7RmLG/LhDhAeTgG10rJRNSL5WqZrDPAYlp/ZThmK7p3RDQLfQeLQl2IVloEcgPt
         fX3LsCpFpJ0psS6sasuuDvIY8S2W0ouQRmh/7bNVZS059Z9z0e+dzYUchimVQ0QhT9nl
         a5zpuA+TNkTaYNBPdEz7KFWRHl3j0+t1znm3qh8brHGC077BO0awpACQWLkv/XNsToca
         fO547FWHynO7dGqE/nE4UA0QpgLt+E/vLGcF5Vpi8NK9VYSmIllfNeVKW15X4uEizcA2
         wkGUf2eTPQM+8gB7/Kp34Xid2OfcAz0BGRE8ievMTmaPfWDMOwE6UIN7V3PathH9EZZG
         GwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=enw/zVlgh0xizaKSE++CZ6ny5hlst0g9dZGlqkXdCgY=;
        b=TQYCdgzEdvhoof7bgrRvpYs15Xp0faudnGJSRaFOj4J/7+zxEeuQFviJ/agYw3zMha
         Nvxxd8/kLvKgqJqKwYSJpBT138BAftjMOGeHqf1r7I4I4KsLBF/HjpecAQpzn77qfmwk
         4EtFVlY0anU0TAe1YZt+skAHaUsk1FlV3sl6GXcJKs+h+VCvFlARH9NwSYuXCKCCZS73
         ljmkjDPspd8LacKvsKhZrN4c6kN4mm8jt4VTP0JOllEspvGJuBbP5ZrU5fzbywSdkwFX
         38tHAQxFMX81hsoqbKU85OC6V3VVqqmD2qAmr3lYzq4GNRIUsJ6p00IHlSBXqM0p0Y9r
         sxoQ==
X-Gm-Message-State: AIkVDXJX/MeKDQiaLIC2AibSvy5Rmhy91L7sMpYawKvsSXr6VUS+1nSA8S2pdznTJ2xfYT7F
X-Received: by 10.98.211.220 with SMTP id z89mr12021757pfk.3.1485568955503;
        Fri, 27 Jan 2017 18:02:35 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id w76sm14136185pfd.74.2017.01.27.18.02.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jan 2017 18:02:34 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, sbeller@google.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 05/27] attr.c: complete a sentence in a comment
Date:   Fri, 27 Jan 2017 18:01:45 -0800
Message-Id: <20170128020207.179015-6-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170128020207.179015-1-bmwill@google.com>
References: <20170123203525.185058-1-bmwill@google.com>
 <20170128020207.179015-1-bmwill@google.com>
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

