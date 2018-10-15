Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAFFE1F453
	for <e@80x24.org>; Mon, 15 Oct 2018 10:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbeJOR4j (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 13:56:39 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46840 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJOR4i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 13:56:38 -0400
Received: by mail-pl1-f195.google.com with SMTP id v5-v6so9057202plz.13
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 03:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bnpLIlyyLtIXH9ZdKeZynSDp+QyusEe60+Hv8ehTygc=;
        b=Qixu0+594VQ0/19sUvL9kmmFKV8eejYn92/4YsWlF2ZuymVIfEQO2wZMyoKoWC1tdf
         Y0GSax9lkB1BXVaVBH/sfcp04PRp8cDy9J1mOLGCdgbjynF9Pa8/MO1eGQyfdA3FQr6y
         CgWUuFKszJ8M4LmgtGR6dHxbT7PHpG73hYF9s3Z3/xZIO38W9Bo993c1PLKl72R5QH5T
         6/sSUgIHicM0LN8HxOypyhc1PRtZF6tVXSUCT5CRFgq9eoUgdaWjM+9kxhz+Y94VjZtI
         Ig3LcYDZY5fK2NOernl/M3aMS74Tfc5hnJD5TWDzEpnR/DxvK+muBGPlZmuonyvnqiNO
         bvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bnpLIlyyLtIXH9ZdKeZynSDp+QyusEe60+Hv8ehTygc=;
        b=jTkp0QTHhxGgH6ZeMlXM/1dnyu9lCZoVGubfFd8gnuAxcDdtwH5D81PfvrfdIxPX7b
         gLi0qXC3Hmd82PM4+/qSZi2Dq4YF0OFdRMPv6etl6zSY0ElaHG/pQ1TKcwdET2LRXDv1
         t/GzT176vUgIlf+5B1QcldRtKxu5M/zB2QngX0NY5pqDw6GV0RMsZ+f1gAbaguLhMU/K
         qIopWrhXj9/nD0H78C7Rs/Isj4MN7F0sPFemkJhY55Y0RyqQVYaSqIEF7MkWaBkr5ciZ
         +1wd2DHQBVl7QdIEoL+WUiutAlLBJjQJtUTh49uKx42ublTOheFcDgdiDv61tjPYJITw
         zLDw==
X-Gm-Message-State: ABuFfoias7YrCiw22WrXDrtkhgCwjVljUA8wlaCsAaV3u2C7cZlBnPay
        Ww5HP0OLoi1V6AkUCRMrptecxyWd
X-Google-Smtp-Source: ACcGV63nfYcNQEEvhpJocRHcslBRw3/eQyGdBDYi9PfGAPVjqE/JocuJFvIQtV1eScEifk/jH9aXNw==
X-Received: by 2002:a17:902:5602:: with SMTP id h2-v6mr16331279pli.220.1539598323449;
        Mon, 15 Oct 2018 03:12:03 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id s2-v6sm10571350pgo.90.2018.10.15.03.12.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 03:12:02 -0700 (PDT)
Date:   Mon, 15 Oct 2018 03:12:02 -0700 (PDT)
X-Google-Original-Date: Mon, 15 Oct 2018 10:11:45 GMT
Message-Id: <52337f18750e16a9ba3bb11e9c2f3748f438846c.1539598316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v2.git.gitgitgadget@gmail.com>
References: <pull.31.git.gitgitgadget@gmail.com>
        <pull.31.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 03/13] test-date: add a subcommand to measure times in
 shell scripts
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

In the next commit, we want to teach Git's test suite to optionally
output test results in JUnit-style .xml files. These files contain
information about the time spent. So we need a way to measure time.

While we could use `date +%s` for that, this will give us only seconds,
i.e. very coarse-grained timings.

GNU `date` supports `date +%s.%N` (i.e. nanosecond-precision output),
but there is no equivalent in BSD `date` (read: on macOS, we would not
be able to obtain precise timings).

So let's introduce `test-tool date getnanos`, with an optional start
time, that outputs preciser values.

Granted, it is a bit pointless to try measuring times accurately in
shell scripts, certainly to nanosecond precision. But it is better than
second-granularity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/helper/test-date.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index a0837371ab..792a805374 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -7,6 +7,7 @@ static const char *usage_msg = "\n"
 "  test-tool date parse [date]...\n"
 "  test-tool date approxidate [date]...\n"
 "  test-tool date timestamp [date]...\n"
+"  test-tool date getnanos [start-nanos]\n"
 "  test-tool date is64bit\n"
 "  test-tool date time_t-is64bit\n";
 
@@ -82,6 +83,15 @@ static void parse_approx_timestamp(const char **argv, struct timeval *now)
 	}
 }
 
+static void getnanos(const char **argv, struct timeval *now)
+{
+	double seconds = getnanotime() / 1.0e9;
+
+	if (*argv)
+		seconds -= strtod(*argv, NULL);
+	printf("%lf\n", seconds);
+}
+
 int cmd__date(int argc, const char **argv)
 {
 	struct timeval now;
@@ -108,6 +118,8 @@ int cmd__date(int argc, const char **argv)
 		parse_approxidate(argv+1, &now);
 	else if (!strcmp(*argv, "timestamp"))
 		parse_approx_timestamp(argv+1, &now);
+	else if (!strcmp(*argv, "getnanos"))
+		getnanos(argv+1, &now);
 	else if (!strcmp(*argv, "is64bit"))
 		return sizeof(timestamp_t) == 8 ? 0 : 1;
 	else if (!strcmp(*argv, "time_t-is64bit"))
-- 
gitgitgadget

