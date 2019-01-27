Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48AC51F453
	for <e@80x24.org>; Sun, 27 Jan 2019 23:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfA0X1P (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 18:27:15 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:42124 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbfA0X1B (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 18:27:01 -0500
Received: by mail-ed1-f41.google.com with SMTP id y20so11587538edw.9
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 15:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Nx9l6UGI/Mo+cXJbFVbhoaNDqQugjJei4UPiehgiQbs=;
        b=kZQPc80Z9BTecGNg59oKnUah9ba5RVMMANIFoMzcJLx2Zz8Zfw6buDzcGGr9oRMS6/
         jmw/a+q2HPK9XJGt0dmypqvH94q7p7SzF17DkUE8unk8lwBlFqIw67UgKBfShlCBgfkX
         fAofePIbW95BZ887uhiLshdYOiMW1aqs6HUewsTaH2mA5/0GAD3+heeZQ3AEE/NXohx6
         lNrMw8Szp8Ma0H6aDBHGkR68yDYx9WTFAGO12Tjz+X1x/MKP6snEOXasr+ci5O81FPnJ
         aeZRJBzmhi0aVfBRnnEX+usgUzVwEPqkYz5RPOAFie/4Eo5HJuv2MliRSGQ44XeOwtXn
         CKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Nx9l6UGI/Mo+cXJbFVbhoaNDqQugjJei4UPiehgiQbs=;
        b=XewwkexRbhVwWbiW7gEo1qqdhsqPlhK95BR0LA2OwgeZAoyLuN16NHBh9FpCaRmNz6
         ChPPe5mECObjxvKX0knZoBPmgz6bTaVhlBen44+RUhK0NSRTZ3aYKy+jdRDugaepB8Dv
         2NA/2JRguHdwagO8m4Kc38aj801KU3chlQ8IxTAE8wUF1inOpi0cfktYnCmvsI73ir8m
         k024bMLyMlCpPw8MjdtS9P6VeAwJvG+MSkDNTgYEoVyW6tW1z6rn9prJ+Cq6iaGa9pwX
         Ah0yoadNDpWt4NiDlwdneLh+k5WBdu1PlVmLCMXWOxTOodxDrwb6HtVwY0TqkY5DUwL2
         3EJQ==
X-Gm-Message-State: AJcUukfhU2GgSJuL3E+TrX3uGRPxxB9CCD2xSbmCxQxvHlmtj2A7kYMc
        7rAFTt8QunXNTTrzZJmoOhsxH8jD
X-Google-Smtp-Source: ALg8bN4ICoPzsUJ1uGg5WUfp+Px8ixFyu6ZxSfMoTroSZThIn06w0RHY9nwtmydaP1H/bf6u/WxFyQ==
X-Received: by 2002:a17:906:d191:: with SMTP id c17-v6mr17068232ejz.27.1548631619336;
        Sun, 27 Jan 2019 15:26:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c30sm13447633edc.70.2019.01.27.15.26.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 15:26:58 -0800 (PST)
Date:   Sun, 27 Jan 2019 15:26:58 -0800 (PST)
X-Google-Original-Date: Sun, 27 Jan 2019 23:26:38 GMT
Message-Id: <1cef14e4c04e27751445397538bc824154a9d42e.1548631608.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v5.git.gitgitgadget@gmail.com>
References: <pull.31.v4.git.gitgitgadget@gmail.com>
        <pull.31.v5.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 12/21] mingw: be more generous when wrapping up the
 setitimer() emulation
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

Every once in a while, the Azure Pipeline fails with some semi-random

	error: timer thread did not terminate timely

This error message means that the thread that is used to emulate the
setitimer() function did not terminate within 1,000 milliseconds.

The most likely explanation (and therefore the one we should assume to
be true, according to Occam's Razor) is that the timeout of one second
is simply not enough because we try to run so many tasks in parallel.

So let's give it ten seconds instead of only one. That should be enough.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index b459e1a291..e0dfe8844d 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2100,7 +2100,7 @@ static void stop_timer_thread(void)
 	if (timer_event)
 		SetEvent(timer_event);	/* tell thread to terminate */
 	if (timer_thread) {
-		int rc = WaitForSingleObject(timer_thread, 1000);
+		int rc = WaitForSingleObject(timer_thread, 10000);
 		if (rc == WAIT_TIMEOUT)
 			error("timer thread did not terminate timely");
 		else if (rc != WAIT_OBJECT_0)
-- 
gitgitgadget

