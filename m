Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9D211F463
	for <e@80x24.org>; Tue, 17 Sep 2019 16:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbfIQQfP (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 12:35:15 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40748 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730433AbfIQQfO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 12:35:14 -0400
Received: by mail-pl1-f193.google.com with SMTP id d22so1762742pll.7
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 09:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v7xr8dO/PKyyZkcwXng48GAuBZjjskM6OjxLbdfnaxA=;
        b=l+VREk0gXvRaZCGQNwopdZX4CzouftPfFaBMetaMO8Oy7/VrUuegb5nbjnwx/j2DAg
         cj53yloC2q++zYJ+Q3UF4CM4D5rAIqpvlqcjt1/dui1TAmbgcs1IJerxLe7NQ39T9UjY
         foAnS/Vem/wW1jIvttRB9h/7v+lF+MCGUdGi+2ir6yHYvO9b1q1TPQ6T6EMJKoS5dXEt
         jowKmnlme9Pj4wSV+RIC8zEap42O+s5E0GcVmipAsceeAu9exp2fWTygWs17j35CpzdW
         qUaex7oOu33OOIhxH/4CRlIUbKBvIy4u6f9gEsc1ZJMvtvoo9zrZsyJPjCjji9XezW+d
         mXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v7xr8dO/PKyyZkcwXng48GAuBZjjskM6OjxLbdfnaxA=;
        b=KZWotPEvvf08psArdIz7NqPOoVLOPhHruOnziz3YYGTE7egJor/uftvCGvxxZIcXCg
         nKSoqWOySg3N6S7YdsDuJGdiX2kUsq9Px8cveA5dUHYwnmgMm8d7X+fBo4krbK20LrUU
         V4DLg41+NP/E16mTRUx33g2L1Cl4bOxuwScH3UPO4v2RITcQpevGl49PWLfUFxxWO9o7
         vpGo1rob1EWGNBqW0fanu8cu1SUy1Y5ciAmSKN85nQyVj9dobtbyFHUSvncc7Mrk6j08
         J8aeYtIuxMpeOWaTLc9p+f8c6xirjseXvb/2wi7omz/apTkQGDvwrStoKs5pyPAw6gM2
         DD7w==
X-Gm-Message-State: APjAAAWRSOv04fPz4e3EJ28lEPZz2pDybKShfRAGD1btQjXdfc3eGJ9o
        RBsfDTTKUzdO6qon4oMSMKJTT4id3KE=
X-Google-Smtp-Source: APXvYqw1mWyrcn9+nMXifBaXLvHBvnBh5ErlX2EBTuuGtwfGECvtP8Z7rccIUv0IM/Lwg8Le+LIsBw==
X-Received: by 2002:a17:902:bb91:: with SMTP id m17mr4717073pls.267.1568738113187;
        Tue, 17 Sep 2019 09:35:13 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id s5sm3202452pfe.52.2019.09.17.09.35.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Sep 2019 09:35:12 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 02/12] dir: fix typo in comment
Date:   Tue, 17 Sep 2019 09:34:54 -0700
Message-Id: <20190917163504.14566-3-newren@gmail.com>
X-Mailer: git-send-email 2.22.1.17.g6e632477f7
In-Reply-To: <20190917163504.14566-1-newren@gmail.com>
References: <20190912221240.18057-1-newren@gmail.com>
 <20190917163504.14566-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index d021c908e5..a9168bed96 100644
--- a/dir.c
+++ b/dir.c
@@ -139,7 +139,7 @@ static size_t common_prefix_len(const struct pathspec *pathspec)
 	 * ":(icase)path" is treated as a pathspec full of
 	 * wildcard. In other words, only prefix is considered common
 	 * prefix. If the pathspec is abc/foo abc/bar, running in
-	 * subdir xyz, the common prefix is still xyz, not xuz/abc as
+	 * subdir xyz, the common prefix is still xyz, not xyz/abc as
 	 * in non-:(icase).
 	 */
 	GUARD_PATHSPEC(pathspec,
-- 
2.22.1.17.g6e632477f7.dirty

