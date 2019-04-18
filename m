Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B316320248
	for <e@80x24.org>; Thu, 18 Apr 2019 13:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389016AbfDRNQx (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 09:16:53 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44340 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388996AbfDRNQw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 09:16:52 -0400
Received: by mail-ed1-f67.google.com with SMTP id i13so1749977edf.11
        for <git@vger.kernel.org>; Thu, 18 Apr 2019 06:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qN63TrtHggTAGtg/Fx+ZyXty2CY5YBwtv3fKIy6wnQw=;
        b=qS73TIrG70t3zpkMfs+QVdWRyLRd6D2J0fV88YqMSEDj33pRRaymu8aQUxYbVkg75r
         veqOFU6gD3pkwf3j1S6aUvILWP+NCVZjg106XsGUGcd1EMd4Z5AmGtiFFyaahYwoyDOW
         5NdIzN8k0vlPq3b3x4DIDvQvndmn6/OFuWklCfz+xl+FT//Ql39gEEB65N0WCAjI1OpV
         eDe/F3nvvabdl9BVMvFtSRIYvGMM9qMV2DuOIW2ZYz5B7c1dzvZ/ijdpQQQ4XGFwap6g
         dB/9olhbQ5py9o1DVvbnCjcygo41KKOCxIKZcHQlU1HUeowMLusGAlz3+w9tJ4NdYLCB
         Jrrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qN63TrtHggTAGtg/Fx+ZyXty2CY5YBwtv3fKIy6wnQw=;
        b=hnzAQr1mTxhmjHxDowutC2w3NNVcROKEBUGYoua17JkKCjFGRp4Fx3qPqZBfxBlHuk
         NDVtvwNZEk/N8dYHTQCI13Z90ohFiCxsbxXlgqAjoFaw2jJ5YZ6oxTgI3Vmc8Co0JGNS
         /r2WmxhROusi+LX3sjDh9NYYKM4VHhz2pF2zPOgr58Y3Xl9kMWTwoZ6xKLCDhM9LsHM/
         BngtZlX/l8OXZNHrnScDatB2q5kQETcYFBqpfbgpBqsqVt8FRc+KM4MuN9W7lF7XteZN
         VN3dMhb5L+l/Ha50DR5puSVGDfcrA3Em6UkwtuzTeTYQbbXcBclq8rTBeRTJ/+VaXDu/
         xbCA==
X-Gm-Message-State: APjAAAUzydtL1OQ7awrHWWAakvrYwEUsoTanMfFXBatxOA7+YXSBllDb
        83ps3L8BlmbU4yQHRKwthVt1rEeH
X-Google-Smtp-Source: APXvYqylXQABN8Vx6QSFZzkZFCrnA16USmG4+JPeUy3IrUjaiBr/EyBPkBhKMCeZlOIpXjdw2Yaqhw==
X-Received: by 2002:a50:ad3a:: with SMTP id y55mr21480098edc.220.1555593410202;
        Thu, 18 Apr 2019 06:16:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id gf2sm382221ejb.20.2019.04.18.06.16.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 06:16:49 -0700 (PDT)
Date:   Thu, 18 Apr 2019 06:16:49 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Apr 2019 13:16:35 GMT
Message-Id: <cf73021574a25f8f4f90dfa8a2b2ca827ef51723.1555593396.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.168.v2.git.gitgitgadget@gmail.com>
References: <pull.168.git.gitgitgadget@gmail.com>
        <pull.168.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 7/8] test-tool: handle the `-C <directory>` option just
 like `git`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In preparation for moving `git serve` into `test-tool` (because it
really is only used by the test suite), we teach the `test-tool` the
useful trick to change the working directory before running the test
command, which will avoid introducing subshells in the test code.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/helper/test-tool.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 99db7409b8..2b21943f93 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -1,5 +1,11 @@
 #include "git-compat-util.h"
 #include "test-tool.h"
+#include "parse-options.h"
+
+static const char * const test_tool_usage[] = {
+	"test-tool [-C <directory>] <command [<arguments>...]]",
+	NULL
+};
 
 struct test_cmd {
 	const char *name;
@@ -73,11 +79,24 @@ static NORETURN void die_usage(void)
 int cmd_main(int argc, const char **argv)
 {
 	int i;
+	const char *working_directory = NULL;
+	struct option options[] = {
+		OPT_STRING('C', NULL, &working_directory, "directory",
+			   "change the working directory"),
+		OPT_END()
+	};
 
 	BUG_exit_code = 99;
+	argc = parse_options(argc, argv, NULL, options, test_tool_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION |
+			     PARSE_OPT_KEEP_ARGV0);
+
 	if (argc < 2)
 		die_usage();
 
+	if (working_directory && chdir(working_directory) < 0)
+		die("Could not cd to '%s'", working_directory);
+
 	for (i = 0; i < ARRAY_SIZE(cmds); i++) {
 		if (!strcmp(cmds[i].name, argv[1])) {
 			argv++;
-- 
gitgitgadget

