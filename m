Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A1DD20248
	for <e@80x24.org>; Mon, 25 Feb 2019 19:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfBYT1O (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 14:27:14 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:41688 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfBYT1O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 14:27:14 -0500
Received: by mail-ed1-f50.google.com with SMTP id x7so8547023eds.8
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 11:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=M9qT6Q/hQFyKYfljJyv3pQTDxQiupSBENBufzzrWj7Q=;
        b=StwIE4GZGDe3PAe4Tpm5uWZ9612aWhIjTSp/uu5XLZ0qzHfg76wHXKuuvUC+fPoI0Y
         SkOnmdAP66LTv6Z3VYHZpHkBGukN886lLIBsAsJKjDe+zdMSi8YHlQxePZoQBP9QzFvV
         Z156nYVsE5Jl6kaFIAmNsWTDXCZM7TxH5uCbcsCKRe8isl2kLfcIlX7069jSEemyeA5K
         jQVj2s76zzAnk9dJaLcEFlB8KT67oLFstjo+XOZVMKXI8dABjxTXkkJYoDro1WqY+AYN
         Ny7i/pR4LAtwdAaWdv/5Wf278WiQjqKrcgjwrKSd8EtIHsyHq0LcHir3HedGrUl0o7XW
         gp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=M9qT6Q/hQFyKYfljJyv3pQTDxQiupSBENBufzzrWj7Q=;
        b=nvc96OuXxIOgSschug8NUfzUD+/nbJSYpAsviwaGyND+nskuoNagNRq6nXk6AvmZzu
         6a/Lwq+50KgpKqULgmXamR1bXLcCh8mHiDuoTLI1gVgJnikBQ2sc+3++MCTx49evv+U/
         5oc5bH/Vtn6WrhqzMREKjoEYm1TCgYbfYXMrWt1VVOwoL71qwnVjCXvLLsg3R6+2Ek+v
         YxY3oP8Ax5LdFPcZ//PzRzlnLcByOY2cScG6i+f6r2vt//vb427/IghB36MJPEfXOEAb
         Gg8ViVbEmmf7Cy9YoaT8g+ERG+evuSuLOh8u7/rqbe13gmd0IrWP1zz1Eq2bIy6TmWfx
         Elcg==
X-Gm-Message-State: AHQUAuZKEwjWgz0n1nvy5OaIGpY13drgjrpB7MF/O/kbct0yw1Z7Ge7P
        Y4cOkTfFx8E0XZzoHfmXitq2mR+y
X-Google-Smtp-Source: AHgI3IbjVAoJftW74Bh3Aaa3b9U4JVCKZ3AcwK/GivlwtzPqRS7RsWSbDXROsnd1LLo8YTS+CgnA7A==
X-Received: by 2002:a05:6402:124a:: with SMTP id l10mr16273028edw.62.1551122832405;
        Mon, 25 Feb 2019 11:27:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q3sm1890622eja.40.2019.02.25.11.27.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 11:27:11 -0800 (PST)
Date:   Mon, 25 Feb 2019 11:27:11 -0800 (PST)
X-Google-Original-Date: Mon, 25 Feb 2019 19:27:10 GMT
Message-Id: <061093e2f000829a560e7bcce1dc86cb6babbca5.1551122830.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.146.git.gitgitgadget@gmail.com>
References: <pull.146.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] mingw: drop MakeMaker reference
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

In 20d2a30f8ffe (Makefile: replace perl/Makefile.PL with simple make
rules, 2017-12-10), Git stopped using MakeMaker. Therefore, that
definition in the MINGW-specific section became useless.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index b37fa8424c..b88d8451fe 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -529,7 +529,6 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_STRTOUMAX = YesPlease
 	NO_MKDTEMP = YesPlease
 	NO_SVN_TESTS = YesPlease
-	NO_PERL_MAKEMAKER = YesPlease
 	RUNTIME_PREFIX = YesPlease
 	HAVE_WPGMPTR = YesWeDo
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
-- 
gitgitgadget
