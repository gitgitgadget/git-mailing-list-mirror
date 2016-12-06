Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF2B81FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 21:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752190AbcLFVxZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 16:53:25 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:35578 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751772AbcLFVxN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 16:53:13 -0500
Received: by mail-pg0-f45.google.com with SMTP id p66so153555903pga.2
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 13:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v1YS/J83Eu5nrPHDPpheoNGguZg0ZukbHxQjRUh1nnc=;
        b=EnHFcKg3LiKkhEByJcCMRze6/ek2T0l5iKsNodkni1dkSmtzZqt3zFNBDyqk7xRWIn
         WPKzgWchaqC+bMVP/8AEoe6XPpP/5niOGjVfb//Ws3F3IBCbH04fV4GeSczBY6lbrYBL
         th70wpqyevq9EUhaWMEyczWit5LXqYY/+MzgkTORuvEFi7BHNmE1DwJP0oCblp0oAUZb
         bcPDWDNcI84SOQ42mnMK1IVeggooLKxDcGCOYixEkh1VqyPTMB+R5QLOnaf/63rhArdP
         v2bvlwAE/dpauTMrxHQ6PMu5/O5zV9Q0VtcneoEvFXzffW2hcFy/PWoaqVast6zfzX2I
         V1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v1YS/J83Eu5nrPHDPpheoNGguZg0ZukbHxQjRUh1nnc=;
        b=i/nJRYVOnAFU3mctS3vKt9VvwjLPUcT/U5U/Y4BjLZg/kR2DpxyAAyew62Fo39VaYQ
         XpXUyiKZIIGLxKEuG89FcrGBn6hv7wQvQzlAUqPOjstgxtt5/7V5vdP6+daFtFcwN1iI
         6J6KyCVHM/EoYMYufOXUfQD3Qgn+ntRFd4uiouWvN5SwzCxyT0VOCrQUpk6qPdsL9POE
         jgOM8ef8joqR8WF5sUfqd0FFzPlD/DXrYKUEL2o8GUensY0uR5dxUtPq89snt0DjO/4c
         WzWeow8RB6PPd1C5zxIbjnYPbiF6MJBepCBbEm+SBHruYfqQYXU61e9Q0yebH3LsFfrW
         mZvw==
X-Gm-Message-State: AKaTC03gjHw1X6pVPaEup7Ac9xeTVwtaN8IAgzTOkicrvQY6VYH3gpmu0+GcLttENx1sODAm
X-Received: by 10.98.70.150 with SMTP id o22mr65959015pfi.134.1481061147596;
        Tue, 06 Dec 2016 13:52:27 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id y89sm36940228pfk.83.2016.12.06.13.52.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Dec 2016 13:52:26 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, pclouds@gmail.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 08/17] pathspec: remove unused variable from unsupported_magic
Date:   Tue,  6 Dec 2016 13:51:37 -0800
Message-Id: <1481061106-117775-9-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481061106-117775-1-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Removed unused variable 'n' from the 'unsupported_magic()' function.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pathspec.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 8f367f0..ec0d590 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -333,8 +333,8 @@ static void NORETURN unsupported_magic(const char *pattern,
 				       unsigned short_magic)
 {
 	struct strbuf sb = STRBUF_INIT;
-	int i, n;
-	for (n = i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
+	int i;
+	for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
 		const struct pathspec_magic *m = pathspec_magic + i;
 		if (!(magic & m->bit))
 			continue;
@@ -344,7 +344,6 @@ static void NORETURN unsupported_magic(const char *pattern,
 			strbuf_addf(&sb, "'%c'", m->mnemonic);
 		else
 			strbuf_addf(&sb, "'%s'", m->name);
-		n++;
 	}
 	/*
 	 * We may want to substitute "this command" with a command
-- 
2.8.0.rc3.226.g39d4020

