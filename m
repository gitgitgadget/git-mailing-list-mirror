Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19188211B9
	for <e@80x24.org>; Wed, 26 Dec 2018 16:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeLZQWu (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Dec 2018 11:22:50 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46070 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbeLZQWu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Dec 2018 11:22:50 -0500
Received: by mail-pl1-f195.google.com with SMTP id a14so7682831plm.12
        for <git@vger.kernel.org>; Wed, 26 Dec 2018 08:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S8assnDEFyd43+loUml6gLYcCcIEjtGr3bfkcdKUzuM=;
        b=nTo3eIa1ofT4LNEP+weHvWE0F+JxHVNHEXvmC201k4yCB00Gzxxodvkf1YWoHPTofC
         +xRbFtIo4nazSGj4k6jReTA/Rv/NotArUXaq318BbcrzjcWIa7WZJVsMKR50ciSieP+n
         +JNtuOq14tImxM/24Yvq74myNbutLLzpVIMRg8Tdrm0M8HCQ5DhRLIZnSl4um4d38I2x
         flYmfRy/OZpF3ovNrWm7io25FX6QSlBCix7c6Biu8RzJglgXnkRyMcN02JslLs230SD3
         sQssQt0hW5LGkFwB6wM4xN7hlXed9IUabs2KI/kHTg0IQ3Tg0WH1ZFw/Dv3uxOwv19mw
         /pmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S8assnDEFyd43+loUml6gLYcCcIEjtGr3bfkcdKUzuM=;
        b=Kmc1Ans939RfqOC1XhpjiVpHV18VrZVYofZfa2U+v7SkxqOejGANfzqObezgfG2RJR
         +LLhLcmTb361pawongftvav4HASeS0R/2t1IAWr3vwqArphMsbL9SHtL0NBgXfjyvFx4
         gdM5Y2f7vnvavmQ+a0CNp7ZvDBjWugHbsvVPjnMhqRv3vJPrzpzithLTrn0pstGSlo/U
         ARgSbMLdRuw1KKMowVLYFg7T9Fjxg7jcWyao9FMTki1wU9Kz7J0ozGMHpztYftt0qYvx
         RHt3ZYpOCcD5iexUFXIx2jB0FO7Bqe/0asoppHmAadSpukxYYO3AEgsbs3PJq2PgBsKf
         LB7Q==
X-Gm-Message-State: AJcUukenSI5pfQ4n939+TyyUyUVkr8gFsvxx5BVkxAxjcH30zftg1oBX
        w4vY4Zq6TiIbyy9Ka67ekGCNsp2o
X-Google-Smtp-Source: ALg8bN60a7Dnpqslf6eu26cU+mHTYRZ0faKPU1QQ0ZRzlKPBft6Fj/TnBzSXBNkAeRJEM+SHPZCz3A==
X-Received: by 2002:a17:902:2aaa:: with SMTP id j39mr20787325plb.335.1545841368030;
        Wed, 26 Dec 2018 08:22:48 -0800 (PST)
Received: from localhost.localdomain ([39.119.71.29])
        by smtp.gmail.com with ESMTPSA id l5sm61248243pgu.86.2018.12.26.08.22.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Dec 2018 08:22:47 -0800 (PST)
From:   Chayoung You <yousbe@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] completion: fix typo in git-completion.bash
Date:   Thu, 27 Dec 2018 01:22:16 +0900
Message-Id: <20181226162215.70167-1-yousbe@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181226161426.68329-1-yousbe@gmail.com>
References: <20181226161426.68329-1-yousbe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Chayoung You <yousbe@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9e8ec95c3..86a9719a5 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -438,7 +438,7 @@ __gitcomp_nl ()
 # Callers must take care of providing only paths that match the current path
 # to be completed and adding any prefix path components, if necessary.
 # 1: List of newline-separated matching paths, complete with all prefix
-#    path componens.
+#    path components.
 __gitcomp_file_direct ()
 {
 	local IFS=$'\n'
-- 
2.20.1

