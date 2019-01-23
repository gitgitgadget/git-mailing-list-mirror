Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06D5C1F453
	for <e@80x24.org>; Wed, 23 Jan 2019 14:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfAWOkY (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 09:40:24 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:41408 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbfAWOkV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 09:40:21 -0500
Received: by mail-ed1-f51.google.com with SMTP id a20so1862200edc.8
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 06:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bnpLIlyyLtIXH9ZdKeZynSDp+QyusEe60+Hv8ehTygc=;
        b=Xvu7gkv+gWscJ2kBRpmfqIgNUvAz47PnZ0Dl7CQJCWUPK5P2fNTq3ggFPDJfG30X+U
         bCF29/P5adfS9VAgd/8xXFkGUFUiCFAnSj18AtD60Py5d/SrpBUxiWkL62UkHFMAWvLO
         Ej4KLRZ/bNRAYvQVtBJX2NFsOi89sN4NnIaHBCGCLKv7IGHdiBYV6E5/Hj8J+i/9mkXt
         f33t/JnuSHr0eXyEQoYQ6cCw2e+z1+/KN4jPgfr3vX1ohrbie+5V549k+4yElIPYphNN
         7CoKjX++k19UwuQxmq69KHQQLLwDMio7iqWmqwH9ho1WdubbnsAk4wcGSGQHaTU/3Irt
         ZQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bnpLIlyyLtIXH9ZdKeZynSDp+QyusEe60+Hv8ehTygc=;
        b=LcUconUacRdqghKrlrhLSo7ahrtFWLm7LGqceUZ2eI/061O9vFtwO0Pvv9lch8yad7
         O6wSC0Lkmrc8HRyfPUPBzeCUianHHUvT9XSU3yx47UxMTWd0NdSbtO/isntGLFKkTnbI
         Xcddf7qbq4phE9HkHo/brmNpuMmw9x14QiZK+OQW4RS72EwmewWtWMgfWuD+AqN+1A51
         1aYmZeMGLPN96AXsq1MnrUp8Q16IrAhdtzAczVs64QS3qIc3NKL30npPCv3E5XuWpt6p
         0/OWGJ0dfiQgnBlAJoeiTMB6eUVSdX5e32hQhAC+Tgzmj7K00UOjfQuOU+mcwFXiV/6f
         7IaA==
X-Gm-Message-State: AJcUukcf+NDGNlF+imN60VMf6HmPwGfhesQFxHvFXWpiu4ssoFzj4hRX
        CKMCXH6ryDyFjaRqjxF/E+Ki9A1G
X-Google-Smtp-Source: ALg8bN4N9Z5PrZcO4w/A2s4bKc0iuDmkCBfRSOh8PtH7Nu0RHYkN7qlFqZyWiKjANz8Q4EV+aWB4ZQ==
X-Received: by 2002:a50:b36f:: with SMTP id r44mr2958838edd.284.1548254419203;
        Wed, 23 Jan 2019 06:40:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i8-v6sm3946308eja.45.2019.01.23.06.40.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 06:40:18 -0800 (PST)
Date:   Wed, 23 Jan 2019 06:40:18 -0800 (PST)
X-Google-Original-Date: Wed, 23 Jan 2019 14:39:57 GMT
Message-Id: <aa053ed9936ebae0ca5e18d27de96f1d054d7f89.1548254412.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v4.git.gitgitgadget@gmail.com>
References: <pull.31.v3.git.gitgitgadget@gmail.com>
        <pull.31.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 06/21] test-date: add a subcommand to measure times in
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

