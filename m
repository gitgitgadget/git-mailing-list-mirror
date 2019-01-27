Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78A111F453
	for <e@80x24.org>; Sun, 27 Jan 2019 23:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfA0X1B (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 18:27:01 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:44160 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfA0X04 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 18:26:56 -0500
Received: by mail-ed1-f52.google.com with SMTP id y56so11584316edd.11
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 15:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oT7R2wDGQ27bqNVq7NMA4Ofuj3PjG2VZGG2HORDkQtU=;
        b=C8FV+CGKUT7XUUOwSPnrsKtGBUQ8xZbytkbKNF/BS8XRFo94+V8NVWorpysuEwFmQa
         5KC3uUf0/qC/QdHnvBNRwB15W6ZFAoTsf31c08gsqh79kZCP0aTXRQFwOuWphs9/KrTj
         jLwrOF2TfAQ6AqcohPb7wnP8cgvexVSOvvN3pget3GhRynwThhWG9BclRHSxBNVOzLib
         GdEsMIuyr8emhlxTEWEXGdzha8pXX1Zj56YS4uHvKy4SiNGInkBzm0ZiQZllQfJaCAly
         enc0RRaq3YfPhKS01qjEKAGMlOV5YNKLm4/CBRlCDaIi/AfD8IfQiMi3SjJ0Q81IbgYO
         7UDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oT7R2wDGQ27bqNVq7NMA4Ofuj3PjG2VZGG2HORDkQtU=;
        b=rf37oioWdDzhKe/sws3Ch6rp2yo8duhQPMo92ns4YrAvv5F7x4yvGd9DgCmqmIt7oX
         00DkWOhyHPHTxhujzxOLv2PzwrtOYtE/BJQ20t1Iv3atoaJ2HSFqQ3t1RdAynN+WlAdf
         Yq7r6FUNrM0MC4kb+Xxf3QdhiN9Q+isE9u+pFK4y3p5eGrgvVVx+dKP3i9FdHmbY1Wzu
         kzymRJLWEqRMtrk3vOvRyDZ4x1tMRLzq4YZZXDRYkO8MS1Cdj6xr8KMn4uH79rR/TEZP
         kubPw6gBpcbL4aFEq6SQIUaXObAdYil7XE+iFrJMzzFr7GS+rpgCuAjoc6EblbdqLPE0
         l7Zw==
X-Gm-Message-State: AJcUukcagQlPpLPQllpK0yQcQdCfBPfALKBN8rkozzZpUa3pry4If+El
        +8AD1xbTyodDqu60IBOfDLpY2o9b
X-Google-Smtp-Source: ALg8bN4yQi0l6yKGGM7tEdzN5PjAzzgg5jb3Q8owGiQHyvPRGfKb55t43J/0D/sacUVWapxeTi7zaQ==
X-Received: by 2002:a50:84a9:: with SMTP id 38mr19279117edq.185.1548631614475;
        Sun, 27 Jan 2019 15:26:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k12sm647405eja.60.2019.01.27.15.26.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 15:26:54 -0800 (PST)
Date:   Sun, 27 Jan 2019 15:26:54 -0800 (PST)
X-Google-Original-Date: Sun, 27 Jan 2019 23:26:32 GMT
Message-Id: <ccf8bf53d7f168e3edea5e4a0cc5e15486abba22.1548631607.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v5.git.gitgitgadget@gmail.com>
References: <pull.31.v4.git.gitgitgadget@gmail.com>
        <pull.31.v5.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 06/21] test-date: add a subcommand to measure times in
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

