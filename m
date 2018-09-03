Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 900011F404
	for <e@80x24.org>; Mon,  3 Sep 2018 21:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeIDBce (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 21:32:34 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40149 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbeIDBce (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 21:32:34 -0400
Received: by mail-pg1-f195.google.com with SMTP id l63-v6so603444pga.7
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 14:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bnpLIlyyLtIXH9ZdKeZynSDp+QyusEe60+Hv8ehTygc=;
        b=vMvqFQU0E6skQ58pOTRGzZvynjLoSXP3BVwCiNUBF0CWC4//vSVi+p2FYHYaU59O/P
         WirDrY6JoAiIE2k4zDA22BKvhQWOUKf2oN33P1WPnc6hEXPV/PlHXnw1GWqaS8qs2pni
         yaixmD2kow5gN/kjGMfsHhDLufXqaEBHqiEYbmoOW5lyU7fWnC/b3lL2iZ0nrQxiRGtI
         kWqHj+xyHUGP8VNFoGzTDFIbhgH89O08kne/gAZeImt8099nPVEdVNtv6cGcpwDms4v9
         AltnyDGHbdKTtyY+jvApp9VxM0EYDj7lNnc35nZ3Uf+D7ps9F2BCmWEIj6S7ClQnFbPV
         +xHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bnpLIlyyLtIXH9ZdKeZynSDp+QyusEe60+Hv8ehTygc=;
        b=p2sIIN2o8dxr9lYJwCIxkk2ULrWu12HNMu2wHKGGs74WVYYUq0ekLD9ZqOqEN0WiVv
         j6HKDo9Gy/Spobq9tjagKurp+rYX8A9mJn2EkQIJ5tHBTI6wspq7MEyFwslR0kUZw8I1
         xOb22uLOtsj0ycMoO/KqPFG13IPUSWSGLL0dm1FASghgKBvvdKIvJ/qxERXR7wcEF5Ez
         XI6W/f3F8aflZJXEiMUYQbpvl6NnoIGQZMk5Qn2lrCM2b0q+kbgDuhobEzgY+nbRANvi
         sj1RrvvNKZSq8UO6RLeueS6OK9vYAWGNKzliTJylG1jed+ddy/q8D0XShUGRUE9Y0AVp
         Hcjg==
X-Gm-Message-State: APzg51BcG01BWm5TLYUHZCrNVw5GPdYWw+GwjCl9vyCe/lkFGpytrcWo
        cDuvAg/ZL4KWxwq2o+MpCxPrwYp4
X-Google-Smtp-Source: ANB0Vda0N8iFYng1Bt4Dw/ywR0Bz1K7gYEYiGfg30xMsDOBoSmo0pyHXm9zQ9PiRU5u3cOLLwTS3Eg==
X-Received: by 2002:a62:23c2:: with SMTP id q63-v6mr31478322pfj.116.1536009033900;
        Mon, 03 Sep 2018 14:10:33 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id a19-v6sm44051838pfj.38.2018.09.03.14.10.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 14:10:33 -0700 (PDT)
Date:   Mon, 03 Sep 2018 14:10:33 -0700 (PDT)
X-Google-Original-Date: Mon, 03 Sep 2018 21:10:20 GMT
Message-Id: <064db77669dab6c63a3fca559c0edbecd1f4ef80.1536009027.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.git.gitgitgadget@gmail.com>
References: <pull.31.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/9] test-date: add a subcommand to measure times in shell
 scripts
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

