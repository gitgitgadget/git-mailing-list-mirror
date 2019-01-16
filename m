Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C7761F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 13:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393220AbfAPNgX (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 08:36:23 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:44285 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390475AbfAPNgT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 08:36:19 -0500
Received: by mail-ed1-f45.google.com with SMTP id y56so5390874edd.11
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 05:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bnpLIlyyLtIXH9ZdKeZynSDp+QyusEe60+Hv8ehTygc=;
        b=DfXSC78k5s0W8VnSqsztTDJU3818wG8JVltN2xnn48M6N00mmbHf6QQWXwC0OAENWZ
         c5+sL2953edljsOrZRm+oolKFRYq0aqKyLjHCl4H72U2NSy3AaYm+4zZ9R2evfh4yMU+
         oyl+Va/jIsxOqXkEDM4b/zu7tgMd1wxtG3FoRwZc197GP+okEMMF56ig8D36q8dFuIYF
         zW6VmvkHbtO+Z8k8vQm5kjNLdp/9VmuybDgd7WIwY5PVnjqaniQqUgOJKDP/wDkyH70R
         Zl8UHd4AAPVanbl5HGlATcufvEBCVsBCUK+lo5a7i8Rkor7S16gcj80h4MVcBDuyZPA7
         yJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bnpLIlyyLtIXH9ZdKeZynSDp+QyusEe60+Hv8ehTygc=;
        b=mh2p/h8+JV0oEGayBYtpEGHnRRS80y1YphomSLbIXk5jFmYZyVHce1Aaw+uXyCsSL2
         cYNxLvcRj1pUHPRwJEEnsfftyDMZPwsQyGsyRofEQV/Eknl6RMv5QrK1I0yCDQTHTSQa
         cN/cMctf6uViz9CaEzHdANdrPVzYdXCPXxzs9zgRljLfq2oPwJ42kYdotcjWwPeLQK1f
         FW0MbScXxLoDxPYFGj1SoclGxM3+Dks+QzYyKiMpLNSeGA81avlhm7n2ZcnbJMlC6DN1
         x1xjPIEaXbMKt0L/gR3s+FBK7U1jDpoyhOYzUWKneg1FUTNcCEIAR1Wv3eDNxES8ev2k
         nbJg==
X-Gm-Message-State: AJcUukcDrjzXDc9o/bynkAWrUtO6pB+t7Kom7rwx6P/JnSCFJ2jIio45
        4LzGbyis9JQ5UBi1yOIxYQRUOQIh
X-Google-Smtp-Source: ALg8bN6XM8bSHWG4rv17ZrVTPofzGuETd73pFxXm2QV2dHPIWOH2VEDNTCz9DS3XskhZEkUIR1f2Jg==
X-Received: by 2002:a50:bdc8:: with SMTP id z8mr7450698edh.46.1547645777176;
        Wed, 16 Jan 2019 05:36:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s36sm5834959edb.43.2019.01.16.05.36.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 05:36:16 -0800 (PST)
Date:   Wed, 16 Jan 2019 05:36:16 -0800 (PST)
X-Google-Original-Date: Wed, 16 Jan 2019 13:35:54 GMT
Message-Id: <16090ff67caeffe59bdc2294a93af634eb23e33e.1547645770.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v3.git.gitgitgadget@gmail.com>
References: <pull.31.v2.git.gitgitgadget@gmail.com>
        <pull.31.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 06/21] test-date: add a subcommand to measure times in
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

