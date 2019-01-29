Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B5DB1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 14:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfA2OTa (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 09:19:30 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:40942 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbfA2OT3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 09:19:29 -0500
Received: by mail-ed1-f49.google.com with SMTP id g22so16082728edr.7
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 06:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oT7R2wDGQ27bqNVq7NMA4Ofuj3PjG2VZGG2HORDkQtU=;
        b=IPl/kk8CfJhzANja26LrMnk/izpmhs4bxHt2CGJY7rxdzWSUIJ7+EPDUc38L7iotLQ
         uekUZfsHchLBddTDJ1HiTVESTWxVOieuCG7dEyHVAWEPURwWA4rjAmvrJKSOlsxgtt56
         Wk44rcl+arsM0hFCHdjDhOIeXWAgF1leRjhyS+wDvjFxwLFUlWzZdYZ4id9rDYqB26Wh
         ap6sOLL1II3WJEdTrfTQXbD5g+0HTIdjQIfRXaG3s78SMS76DLGXbBVNqF3s/X8OD7Md
         bmlqB+lQ1gSvR1Z6EPj3MF/KJ/AUd33jr/Si/FVHkeiOVfQ9HauHIyOw8lhTfQpvZCW/
         9cfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oT7R2wDGQ27bqNVq7NMA4Ofuj3PjG2VZGG2HORDkQtU=;
        b=YAP9uXaeEaGDxhfIEi13T0an/0rHk+eyFl5mhMXzNs5lInvVpgr1PBGBaGopxU3H3n
         jLvdI52kKwJjKodNHTbsCJ15yG3rRopN9LTYgW/ULJx4yctZiwxVPI42xAZ0RgbviQD4
         oSyRrKDJHV5Jr/2H18u0O7ZIaPKDbDjZaJZTxnjX1jLhJ1uBA+EGIZKDXy6Y/B6+wuZa
         TXdK7eAGjH7aX8e4bndCvVndS2LMThZIzs7T/djV8xN575vQaPwjH3p5BaufsYfD9YzO
         3u3MLzW9GenB4qrrWTgpU5vMA2+Mk+53kXWsTrMcSReLLexvhisCCeGg1qrX8M+eAJnE
         21dQ==
X-Gm-Message-State: AJcUukdL5zjqPd8Bz98txM1wFDQhllzfKhAiOJLjAx5tE1E5quUazuYT
        TL/h+5EirrfIk/N9oWuf0O3KZCoa
X-Google-Smtp-Source: ALg8bN68NVFNcUU6c3fv0t6z62ud4F2q8B6pHxHvclDAEarlbzA+Mjxqr8kgIaYcPnkfadgVDlORMg==
X-Received: by 2002:a17:906:32c6:: with SMTP id k6-v6mr22667624ejk.48.1548771567492;
        Tue, 29 Jan 2019 06:19:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l7sm341995ejc.70.2019.01.29.06.19.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 06:19:27 -0800 (PST)
Date:   Tue, 29 Jan 2019 06:19:27 -0800 (PST)
X-Google-Original-Date: Tue, 29 Jan 2019 14:19:05 GMT
Message-Id: <ccf8bf53d7f168e3edea5e4a0cc5e15486abba22.1548771561.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v6.git.gitgitgadget@gmail.com>
References: <pull.31.v5.git.gitgitgadget@gmail.com>
        <pull.31.v6.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 06/21] test-date: add a subcommand to measure times in
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
time, that outputs preciser values. Note that this might not actually
give us nanosecond precision on some platforms, but it will give us as
precise information as possible, without the portability issues of shell
commands.

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

