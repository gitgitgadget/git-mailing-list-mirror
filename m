Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43B24211B9
	for <e@80x24.org>; Wed, 26 Dec 2018 16:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbeLZQOo (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Dec 2018 11:14:44 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41467 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbeLZQOo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Dec 2018 11:14:44 -0500
Received: by mail-pg1-f196.google.com with SMTP id m1so7714638pgq.8
        for <git@vger.kernel.org>; Wed, 26 Dec 2018 08:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rb4XgKx4XTpISZLPx6saGpFDwNQmNwJTJbVSd+iuS1E=;
        b=u3VuHx0Jlmkv4IbQrkgh4pPCaF6Q6e1603pZxAuVIfvZNsFZfh4N/lVzdd+EZEPiif
         T3SUUfYYcHGF2SxU1gQ9DQwFvhzBOQp8eMg4/LnlU4CFHiDxfb4Dassvy8bxY73/fd+7
         e6WBoL88sgBvaMHyUzPIJ2cN9B4dUkFzbWvkXTSH3xxf6vdhgZeyCIzXF7ARuzAIx9P8
         n1XhQ7FqShs671RmqAA55GnGP7XIe0G/NKEmZJ8X93AIvOVckhjwG7YsLpAkHnv6RV2i
         eYNrWUcc+gYIcAyoIg2+2zCJ6Ete18mF2TDY120A/PWy5qaAwjHUm31rbeaFSkhxttu3
         5eyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rb4XgKx4XTpISZLPx6saGpFDwNQmNwJTJbVSd+iuS1E=;
        b=JV7g6gEiRfUddd58NousXUUmxg54gTA4KuM2MZmSb/TzNwOxlNFLpy92/dX/FlXbjD
         qTnthKr6Pn2fmcytC8FgC29fA2TyfpXWv9a5hS0J38lrPBbwVeis/U79WVbyS8C0Tey9
         zXLtqhT3i07vNZoHtKRYCh0L1g1P24DViy6Z2GEqXkIRul5PaIO2cTLD4bYjKMR8cRRB
         cUKR2LRr9Bw+6wuLgBws+6MFWJuEdI767vBGn2LFMtzpBWRih4OqbEdf0hhzO0+WaHGp
         9E5MHH9A9b3R5IFhZJZ9Yi0vs3B0NS5wjeNJRLYQWTLvbSiBEWY8IkoadNQWoUQ0M3jw
         yiuA==
X-Gm-Message-State: AJcUukfl40JikHjppvgL/OOHDNeuvQTKDAMEDTR1UD+y6HswY/z/kHB5
        IxmH9Lul6FEgQiES2yjGlZJboxDU
X-Google-Smtp-Source: ALg8bN7A8gmxLtcdT7Uo9bB6Z8MQAQIZ5sPnMoqTj9AtZst2+Pz3vef6DmEGm/sJuh5uf2XH9Raieg==
X-Received: by 2002:a63:2bc4:: with SMTP id r187mr19253162pgr.306.1545840883373;
        Wed, 26 Dec 2018 08:14:43 -0800 (PST)
Received: from localhost.localdomain ([39.119.71.29])
        by smtp.gmail.com with ESMTPSA id d21sm55125364pgv.37.2018.12.26.08.14.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Dec 2018 08:14:42 -0800 (PST)
From:   Chayoung You <yousbe@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] completion: fix typo in git-completion.bash
Date:   Thu, 27 Dec 2018 01:14:26 +0900
Message-Id: <20181226161426.68329-1-yousbe@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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

