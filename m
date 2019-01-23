Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B42A1F453
	for <e@80x24.org>; Wed, 23 Jan 2019 14:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfAWOk1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 09:40:27 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:37279 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbfAWOk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 09:40:26 -0500
Received: by mail-ed1-f52.google.com with SMTP id h15so1880463edb.4
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 06:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Nx9l6UGI/Mo+cXJbFVbhoaNDqQugjJei4UPiehgiQbs=;
        b=S93LwYKCKmAa+Tq8i9U6NGSu+dBuhLRKQzXl13nNNYoonrhHixyF4BHx4gjayDCxM0
         YJHOyKS6yb+ygB6CddRkB5b75tBP+ej4bfAXg8oEf+Q09S8TbPZhmapkSU3l3f/JeZie
         jFfuEzWVOXy3h5X4iAX5T6PGqGIlPtsmp6Ekvgp4ktA841isUrjkcKSF526f66PkwSR7
         I3ja5SQClidDN+1RaeTGNAj/f+3RiOF3o9RTd9h6EU7//dQFboi4dBXp2cLwyqfc1BU4
         6dhAOt+PywAT/8r/8UE3Kfrg7uge/hTNab8pn8NvNvRV9PgwpNjkqDLaDD1kuj3BqN5o
         ruNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Nx9l6UGI/Mo+cXJbFVbhoaNDqQugjJei4UPiehgiQbs=;
        b=UF1LxxX0PLoLvdsIwez3sfrNBbBXBW8oOrfX5YtAYgesWjd215+ew8TNuGbdpmK9Hq
         1aFin+LlC0eWiXpsEBU/x3xxvBxok4AGCY3XV5ZeNz0vOSn3sRiKQVlT5GQCmeQYGSMF
         3ihvexi8/ByvhTwmv64w8ktSmBQtw6JCtNUmCQLXG/7t6kK9JgP3q8VOL5IaxhIBdJk8
         H8lEtK8W8zFdD8zUEN/+Uc63vjIzVQgc7+X0r9jI2+oiVdCMba4CG9MyGdaTm7wg3OqA
         /OMDsnYdkM77QVcNQ2umEsGG3Awh8Z0UGvcOy+63ES9XytStGFczqm5mGBaeekT8OgjA
         0sLg==
X-Gm-Message-State: AJcUukfcaTqQS59XxeF8utCamDuK/oqxjzHLbYKfxZhEC4FHCPlhQtsG
        IONyEqwRydkSE6vFY+kBLPvXvdre
X-Google-Smtp-Source: ALg8bN4J5a/mNXSQzx1pcnS8LhbiaxmmHfMLnD3WeV7IkRuxcMS06iCjL7J+4p2ILK4LjKdjIiWkgA==
X-Received: by 2002:a50:9784:: with SMTP id e4mr2956798edb.165.1548254424037;
        Wed, 23 Jan 2019 06:40:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g5-v6sm5587967ejm.15.2019.01.23.06.40.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 06:40:23 -0800 (PST)
Date:   Wed, 23 Jan 2019 06:40:23 -0800 (PST)
X-Google-Original-Date: Wed, 23 Jan 2019 14:40:03 GMT
Message-Id: <18d76823e56547e47be39ad657a1795603659593.1548254412.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v4.git.gitgitgadget@gmail.com>
References: <pull.31.v3.git.gitgitgadget@gmail.com>
        <pull.31.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 12/21] mingw: be more generous when wrapping up the
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

