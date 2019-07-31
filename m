Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E12771F731
	for <e@80x24.org>; Wed, 31 Jul 2019 20:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbfGaUEe (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 16:04:34 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52472 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbfGaUEc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 16:04:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id s3so62073277wms.2
        for <git@vger.kernel.org>; Wed, 31 Jul 2019 13:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lpPmHd3fBsE9JavemDMELLuagiRzaYzKALhkOfPAMMs=;
        b=q8pEozYlNj5ljfumfaGMaIvxq2rY8hn6QcgcfsYUs5Ox+amVOrH5JES+ydol0Fbynt
         C6b/FgcJkkezz7i680wspCL0Q8bNg6iNOgNcxIwR0KREaIlrpBL/cuSk7/LP9RCos4gv
         WvU9fEHVRwP/VtvylTikuPbW58uFvm+qER1AMmaZ+FdLo/xo4V2Pfgp5dhOsfw8NzP9s
         2qHbbvtgETyH5QpONr2OmfDaMJkA08RE3QSHrmlbiJWjivAmRgYIN8IQq2+nLlSvOz0o
         JMPaKyRKQm+blHefBmKC5RUhXl6LFuTeHvPoKx9P+mDxjjLYFVl3cRKSwbZ00nOSC6ee
         D0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lpPmHd3fBsE9JavemDMELLuagiRzaYzKALhkOfPAMMs=;
        b=Hweail9uRPiPtTmka5IuR6NUJDG60ZSNpQ10Lk3njoeDtTifrnNKG1Zg95dRsQ2LGx
         E30L1rhj26HOeph1HBjep1CuQLewOJgaBeJK8ocIOfOZoodP37gKmlUkfxs86AIdR/Aw
         RHwI65qDQ+i0XrzhfE83GpDghINEPiROMCQTREMHS3IFmqotMsQOMAGHA7CGB1gQWxaE
         +VFH+iNR4MJlPlmeFnBFVZ7qx9v++pZbnvIPxqUPNGYTzpm4jmK21zehBCIVHb/a9MKw
         Ti4PgzDpdm8xBVFhgr5CrZzjEINBH3V70JmaaKEe2yBBy18CEkN8d9PR+z8Y5ugn3Zab
         cdCg==
X-Gm-Message-State: APjAAAU2lNDpPTWoB/Pk7qQJSVpcY9m3gmT47gIPxeqn/fo0k1b1OwxW
        +dQOCt6V3KOgCsppWM0p20pgDUXa
X-Google-Smtp-Source: APXvYqw/3AmXx/tl8hbUwcl1WqTh0VJ2fqoKLsLfxwkDQ5ZbocJLq61x4Gv5Izlx5Nv+YrsR7YlbpA==
X-Received: by 2002:a1c:6882:: with SMTP id d124mr109473777wmc.40.1564603469979;
        Wed, 31 Jul 2019 13:04:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v18sm69949412wrs.80.2019.07.31.13.04.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 13:04:29 -0700 (PDT)
Date:   Wed, 31 Jul 2019 13:04:29 -0700 (PDT)
X-Google-Original-Date: Wed, 31 Jul 2019 20:04:26 GMT
Message-Id: <834ee95cd2fe919c7a5a2d3cc3d647cfdeebe9e6.1564603467.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.298.git.gitgitgadget@gmail.com>
References: <pull.298.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/3] trace2: trim whitespace in start message in perf target
 format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Trim leading/trailing whitespace from the command line
printed in the "start" message in the perf target format.

We use `sq_quote_argv_pretty()` to format the message
and it adds a leading space to the output.  Trim that.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 trace2/tr2_tgt_perf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index 4a9d99218b..ed4e708f28 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -185,6 +185,7 @@ static void fn_start_fl(const char *file, int line,
 	struct strbuf buf_payload = STRBUF_INIT;
 
 	sq_quote_argv_pretty(&buf_payload, argv);
+	strbuf_trim(&buf_payload);
 
 	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
 			 NULL, NULL, &buf_payload);
-- 
gitgitgadget

