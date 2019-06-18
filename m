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
	by dcvr.yhbt.net (Postfix) with ESMTP id A7DDD1F462
	for <e@80x24.org>; Tue, 18 Jun 2019 12:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbfFRMYD (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 08:24:03 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37226 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729120AbfFRMYC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 08:24:02 -0400
Received: by mail-ed1-f68.google.com with SMTP id w13so21475111eds.4
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 05:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mGuyugT6j7/HAJjAGUt/HlsulldM4hZ1Ka3Idb1elI0=;
        b=JHpqPhCa29q99ldVVIcpFJnrqwWOCCaMq1rJAyONjV2Daqw9iihWYOUOayl8b1bl7u
         25kzGMSWCNz45Utq6ejDzdn8ivw+OIbnqYS9DQpdgFzltZAbyxLQvWS2q5pv/wUKoig1
         Sh2HZ+IcPuoVZ0Neb5v7iyWlrVESOzflbR6if7j5TJQhn1WuXbXwJNX16KHvjAC72qwW
         byduBghXQ22KOG8cI7IVzMXIRSW1RmCTLjoSsizovS8mKAbtrDUqdb9eMTOZANmP0hyc
         00w2lAy7C+rS8K4BAyMpCXRJLBIzZvDeZHvjnaFaQu71rBiklKYcoGcNjV7KusSPvrMT
         mB3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mGuyugT6j7/HAJjAGUt/HlsulldM4hZ1Ka3Idb1elI0=;
        b=OyNE2yMU8txTpRmrdaJmLNVR5IKCfHkYxUT7dP85ZCvfGdTVv9+08Qm4NITH5NosV3
         qNBQlMW1+cAKEX1SGPUiJjfIm/Mj78Oxk5w4pLOYuXWQF3IUCyi3nSkSfpjLgjgMkmuw
         eNJTTb4tevFPhdvIsDKcAeBYcbynpzALp7RuxL9K7j3yEfvCWYaMPF3+6mcIyQLXw5Q+
         oNNRHeTVfiCU/htmoluAN1u7oC3dE9hLfmcOXFMmyPULzx+7PTW33tGQdvqTOxWp7yWt
         Q7a44Oiu7tTbp/Vfh67a4ANhHsl6Eb6P++8Fi5/pUMoj+BxBXBo8/7lxNJVq39UKLsAH
         ILOg==
X-Gm-Message-State: APjAAAWxjPr+C4I0JTxHUQB/K7VzSeLFGsurHd2uhSMdAwHU8hiL8dOt
        QOlSIyckroqgG/7p9R93LF7aFFQk
X-Google-Smtp-Source: APXvYqw1jQYH9Mtxg2U7GeJf5wTQbv1NTA8walgu6JwhoznETxGRaYs5qWLl8F/qrODGZv7Sr6v/nQ==
X-Received: by 2002:a17:906:2a8e:: with SMTP id l14mr11841981eje.276.1560860640339;
        Tue, 18 Jun 2019 05:24:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i1sm1898853ejo.32.2019.06.18.05.23.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 05:23:59 -0700 (PDT)
Date:   Tue, 18 Jun 2019 05:23:59 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Jun 2019 12:23:43 GMT
Message-Id: <250385d7a339c7fc6d1ee7183f44a7ab940bb194.1560860634.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.git.gitgitgadget@gmail.com>
References: <pull.149.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 06/17] msvc: fix dependencies of compat/msvc.c
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

The file compat/msvc.c includes compat/mingw.c, which means that we have
to recompile compat/msvc.o if compat/mingw.c changes.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index bf5d160ef4..3310f6284c 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -414,6 +414,8 @@ else
 	BASIC_CFLAGS += -Zi -MDd
 endif
 	X = .exe
+
+compat/msvc.o: compat/msvc.c compat/mingw.c GIT-CFLAGS
 endif
 ifeq ($(uname_S),Interix)
 	NO_INITGROUPS = YesPlease
-- 
gitgitgadget

