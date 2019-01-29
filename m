Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C005D1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 14:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbfA2OTg (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 09:19:36 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:42745 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbfA2OTe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 09:19:34 -0500
Received: by mail-ed1-f54.google.com with SMTP id y20so16080484edw.9
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 06:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Nx9l6UGI/Mo+cXJbFVbhoaNDqQugjJei4UPiehgiQbs=;
        b=Ikjo08ixU2LDC6UFmHKaVpZnhHXbm/FnBUjd7uNuxnYPcZb1qM8DElnKnWwrZgQuPW
         IuKInvISG9QwnZMOsCzLjSvAVq9vHEtMoPtXcXWV+AFnruPzlbNO7rwCkGGjYDKJQCTr
         ebI7Vh/RG9PJC+65DkwtSI3wNgBQGf1clBakcxHQRttuIt70qN0qitzUNN0qd0wyWXsX
         kFT9BVlxsXSFjgnj1HfJboJrF/6zIEUe9aqJXjkC+Ck4dCYSrR8DVFv1WTuqeSbKRrSa
         LIMZeNJK+xuY98h1+xEaQX4o0LTiezncSXXw26z/k9vnMUi3GCR4zDX3fHXS9VVi5OZM
         r52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Nx9l6UGI/Mo+cXJbFVbhoaNDqQugjJei4UPiehgiQbs=;
        b=Y4qSZHgVbC/VB+cNVP/QcebJZ6rAa8PPx2gdgoWnBapsorjLy7k9cZSSG812YOG9dG
         AUekuqPfIn3tqdgHCKdjHZ8E4UKTiZ5HdOcXxaVW7eBdiVggaLqVxYrgWc3pCInKlmK9
         Ob2lUFumMSyRFPNKJORJggR0DTVDWEjvvIG3yZXBS7U4buD2suI3uaYY/ROGZPxU3z4u
         JtWSjMB4dqbbg2YZx/Hr0VJ1NmS17/vo1T6TW/QB6Aymsy5ejlHj8aWm2Cye7/9SFabh
         YWvvTPmpb35z7XbrtTv/D6mvdfVzz/zbqSFUmC3nSBeldRC9PPhIWqG47Yjm8qKL33ZA
         aozw==
X-Gm-Message-State: AJcUukfyEx68rS4ozPlkCZyx3l0QYeXq2GwVM8FAhgQYWPU8lnv6zAAC
        6mvXST3U//DaH7Tb4Nk4hpkLkoQB
X-Google-Smtp-Source: ALg8bN6fZbQpKXb8ohuQSina6AjQOD9yXFOuPZx5T2/jUeO1kSgFsDbgwketYmoY1xXHW0RdIWxsbA==
X-Received: by 2002:aa7:c152:: with SMTP id r18mr26007969edp.258.1548771572464;
        Tue, 29 Jan 2019 06:19:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o23sm979448ejd.1.2019.01.29.06.19.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 06:19:31 -0800 (PST)
Date:   Tue, 29 Jan 2019 06:19:31 -0800 (PST)
X-Google-Original-Date: Tue, 29 Jan 2019 14:19:11 GMT
Message-Id: <c1ab8df6772045cbe63b2355904038a8556670c7.1548771561.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v6.git.gitgitgadget@gmail.com>
References: <pull.31.v5.git.gitgitgadget@gmail.com>
        <pull.31.v6.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 12/21] mingw: be more generous when wrapping up the
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

