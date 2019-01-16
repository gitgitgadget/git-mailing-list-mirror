Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24CCD1F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 13:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390552AbfAPNga (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 08:36:30 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:42237 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393221AbfAPNgY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 08:36:24 -0500
Received: by mail-ed1-f50.google.com with SMTP id y20so5397531edw.9
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 05:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Nx9l6UGI/Mo+cXJbFVbhoaNDqQugjJei4UPiehgiQbs=;
        b=Ee0piCGNHxJBy5Wb5GIvcKAGLQvLmHg70PUz0DAz10D8P6PCnzzmXC5J/c1y0TVmpK
         VUBcesPB6V3JDSir9lm2y2C0K6JJDXQvAMvVAxbmQnmTy601kLYHdIVJfKVpzWw+NO1d
         zTZx+3l9/YYhaKkjuDP/pC/69gRKThawnmZva0XLDf6SgvzNwpWn4nwhh0QTxtUpjJRk
         oSaud/mzYP5aIRH+Cn11kT8Kp1uLJ8FKqoljDgQb6MkmzibepH9KOixRhZS6XBnRnM9d
         NOHNUkafB8sFQ6iwq/vLyn89uyU663X8rgqwtS2RTVA8F5M4YeVApajgxTs2EjtTKKvJ
         mB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Nx9l6UGI/Mo+cXJbFVbhoaNDqQugjJei4UPiehgiQbs=;
        b=IxBv0Wtsr69Uj/A6u9zkyxabo37DJwVV0v9W+5odjPuCzSDx3kD1hPqvsIbIDuVhWj
         kTxLqlALbMUqk1AeWShxZJAFEVETqXb1xfkVsE3t7iOKokbJjOkuhn6owYNcvW/mmYu3
         kX3N9H5mYHom72+9h5Nl5nOSjW/Lx1ynKesOXCSBYn2ybbB3rzWMrPm0Hbv3x0p+9sUT
         red2Fr3b/miTuVX4nDHX5sbLLaBlZFcoeTPtwj1PlwGni2t1SgFyP4bcsHtpUZBiTYZq
         jibqJJH2moP/5GhOV0DpzA/0fu26gAKVW5y8qjzHZDweLfh541BK0uNLfZ5puVP6GHME
         ukfQ==
X-Gm-Message-State: AJcUukdH99cHNVJuI0lLoPigLVxhFBH8wLdLjovoTmcSvZjxuty2UIdd
        Wj4X20i8ve2aGgOan1FFVySHAYnX
X-Google-Smtp-Source: ALg8bN5SCO1zsQLv7S6AeAVf9lsV93sEQeDQlrfQQar1AsbOBxocGQUl5vT8x74l5FsFDs/UwBIbhQ==
X-Received: by 2002:a17:906:a3c8:: with SMTP id ca8-v6mr6901822ejb.88.1547645782642;
        Wed, 16 Jan 2019 05:36:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l20-v6sm3106404eja.18.2019.01.16.05.36.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 05:36:22 -0800 (PST)
Date:   Wed, 16 Jan 2019 05:36:22 -0800 (PST)
X-Google-Original-Date: Wed, 16 Jan 2019 13:36:00 GMT
Message-Id: <2b6ee78f021a47c5892d96b5d63d19bdedf25e2d.1547645770.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v3.git.gitgitgadget@gmail.com>
References: <pull.31.v2.git.gitgitgadget@gmail.com>
        <pull.31.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 12/21] mingw: be more generous when wrapping up the
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

