Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 839E51F463
	for <e@80x24.org>; Thu, 26 Sep 2019 15:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfIZPaC (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 11:30:02 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:46189 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfIZPaB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 11:30:01 -0400
Received: by mail-lf1-f41.google.com with SMTP id t8so2016613lfc.13
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 08:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mE8J7IVaPa1ppGRyBgicq522Wt85l7ff4610/jauWrw=;
        b=gnJ75SHF3/wwuifQBy0TR/7d3XwzjdSV5pDAshNnQUXyP7luTc4c3xlwT9Q+CXFrlE
         SBMsZwtDBwagwalhnZ3KcMwFDBZHI53vgforcYewqdp7RMTT/PeB0mh0CEhBDrHWdvoj
         2Wh1FYnFs2wRa4VABrIDjJ+tvvlmgqMYEMtVn4q/LINPk2xQNA9ie8AlFGVTNFCps/4F
         UtSR5wUMmi7N8gvdvoKryw6mU6kjf7fsBLUg61SgvfAxff3akiwe4nMY/bUonnrAcAJV
         PS8MzDpmKWM2YDn8LcFmizXOrcMwN1WHOpZSzFj1zO00NufwkV92vDHkmVhn26dY4rLX
         eZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mE8J7IVaPa1ppGRyBgicq522Wt85l7ff4610/jauWrw=;
        b=Yq8/tbH3P8aHxrg/q2PBAjyN5ERiIxHkwOOgqUpllw/Gzj/ohGydLG4cEA47GjwLe0
         wD82yTB+8A+v0OQQr/0QSUQeB0xt6iF81IQePRBdU1DY4hnzGsLmKUAbLzIiY81hQ3MZ
         iUb9morp5wXpSC4BkvJ/rYv38LucOwSjk9gA1Ae455v4QRw8gxrwrys3sfOtLQpqUFyv
         4001daSzkLChwypPc6tjWOmRUna9Gy5oHRDf3GxGGnl3BoW5O8+RltH4ozTCmY7YRnHi
         TLiSUDoGbo6h7MjtecaSLaNHdto0yqZ8omXct+M5Cj1zcx6uCJjvFPJTaokJh4QnKu1A
         Kclg==
X-Gm-Message-State: APjAAAUPjiILpBhO1kVGS8gCjaeHY+V4R3YDNKLVszboed/O/vU3dJWc
        GaFa2A6Q6iXlP/zGb6bkGacsuHQz
X-Google-Smtp-Source: APXvYqxQ1eNVsHUy813j+OYPzkblPgNxvCYVwF1KutwdzNw270Gr9U3BM8J1o4E7q/y2npvYmFGOyQ==
X-Received: by 2002:a19:8c14:: with SMTP id o20mr2597774lfd.158.1569511798011;
        Thu, 26 Sep 2019 08:29:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r19sm571422ljd.95.2019.09.26.08.29.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 08:29:57 -0700 (PDT)
Date:   Thu, 26 Sep 2019 08:29:57 -0700 (PDT)
X-Google-Original-Date: Thu, 26 Sep 2019 15:29:51 GMT
Message-Id: <cb9f8c8158c5a7b55ed746234624ae69a575f608.1569511793.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.358.git.gitgitgadget@gmail.com>
References: <pull.358.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/4] git gui: set GIT_ASKPASS=git-gui--askpass if not set yet
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-gui.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/git-gui.sh b/git-gui.sh
index 76d8139b8d..66f046a0c7 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1248,6 +1248,9 @@ set have_tk85 [expr {[package vcompare $tk_version "8.5"] >= 0}]
 if {![info exists env(SSH_ASKPASS)]} {
 	set env(SSH_ASKPASS) [gitexec git-gui--askpass]
 }
+if {![info exists env(GIT_ASKPASS)]} {
+	set env(GIT_ASKPASS) [gitexec git-gui--askpass]
+}
 if {![info exists env(GIT_ASK_YESNO)]} {
 	set env(GIT_ASK_YESNO) [gitexec git-gui--askyesno]
 }
-- 
gitgitgadget

