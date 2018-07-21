Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7477D1F597
	for <e@80x24.org>; Sat, 21 Jul 2018 22:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbeGUW71 (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 18:59:27 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:39953 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728388AbeGUW70 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 18:59:26 -0400
Received: by mail-pg1-f173.google.com with SMTP id x5-v6so9540986pgp.7
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 15:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OpsSLmazJ23rFLapKvjhy8n85cZdC31/Agb2c3W4Oww=;
        b=Tc8PB6Ghf1JEGNUh1XLiu64GxMwyQ4PrZOOzJlC45xctBhG6JbsDTeKhbi+MGnSG/2
         0UNaBu02dDs9Vip8ATyoO4wDC1nHsk492JE0a2ymLv4eg0Raj5JRbe85Nff4up11QOAk
         M22oVk1+BDqB40aU5/C5AkCEVVyG+osVUFOcbPRxiY8Y8Md3395xWwuzQ84KP/lpi27i
         G9EkDMTQU7Lb3geNt+ba5D4IuwyIRXmtjXB4P+ft9Z/Q8f1S7z0BpCvSjgDkDCkWVTrY
         z5k6mwKlRqUctyns7IRh0w3A6EAqxToHkNQZCoqCygpNNN/qgC7eOrOeZSgQZgjdfImb
         LoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OpsSLmazJ23rFLapKvjhy8n85cZdC31/Agb2c3W4Oww=;
        b=rzViIcSimdSE/7IZYTwIlSTZt1Q7yLNdn0M4CWo6StRz0fLt7NQBxvB6S083NxHSjz
         eOxPZvlp5tg4miYW5IGT/06ZhAJ+VZIYYSTRMCuz5AuOSJWu+Hgh0Y9nPv0OyExO1X3t
         sKxp/nsnx2NDmMkvTLPOxg81fIcqzA8JOK8MullqIneA0dHhVSvfR196Yc57h8w03anB
         KMWAn8cnmaTijCV2DFtxtkwtkXcllMvcgSKwmrELHA6yY8Pl5ejHl8itKq8zWGwCImqO
         L57pN+vkqWbAocs8QOJQEQCFOxJkY8U/J7glBhrQSogehwCIDVEX6v8n2w5D08+e0aXJ
         gRjQ==
X-Gm-Message-State: AOUpUlFcIEE2czvsHsRvBWVBBBDS/aG7u7E6VcdpGutz1MA+jObj94DM
        qlcykpN/9WO2R+9ieX+ur56KdSN2
X-Google-Smtp-Source: AAOMgpeX2t3tYdQhiWEP0k//Y+Z58A/LUg512e5EQK3Zcvn/A0dWqUkpqqLXCf62Ss969SgRz1F8Xg==
X-Received: by 2002:a62:a05:: with SMTP id s5-v6mr7299679pfi.147.1532210710733;
        Sat, 21 Jul 2018 15:05:10 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id n24-v6sm9305800pfi.161.2018.07.21.15.05.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 15:05:09 -0700 (PDT)
Date:   Sat, 21 Jul 2018 15:05:09 -0700 (PDT)
X-Google-Original-Date: Sat, 21 Jul 2018 22:04:39 GMT
Message-Id: <9b3632324f93afdab7273df7a7dc119e14a261a1.1532210683.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v4.git.gitgitgadget@gmail.com>
References: <pull.1.v3.git.gitgitgadget@gmail.com>
        <pull.1.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 18/21] completion: support `git range-diff`
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

Tab completion of `git range-diff` is very convenient, especially
given that the revision arguments to specify the commit ranges to
compare are typically more complex than, say, what is normally passed
to `git log`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/completion/git-completion.bash | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 94c95516e..402490673 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1976,6 +1976,20 @@ _git_push ()
 	__git_complete_remote_or_refspec
 }
 
+_git_range_diff ()
+{
+  case "$cur" in
+  --*)
+          __gitcomp "
+	  	--creation-factor= --dual-color
+                  $__git_diff_common_options
+                  "
+          return
+          ;;
+  esac
+  __git_complete_revlist
+}
+
 _git_rebase ()
 {
 	__git_find_repo_path
-- 
gitgitgadget

