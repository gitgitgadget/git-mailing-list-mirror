Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 729D71F463
	for <e@80x24.org>; Mon, 30 Sep 2019 09:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730631AbfI3Jzj (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 05:55:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40321 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730598AbfI3Jzg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 05:55:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id l3so10498798wru.7
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 02:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PTJvnArUvKNsOxVEuhJbTo8k3kGB1/WAG8v2GjmdSbc=;
        b=RfG4kuISwtWa0/0WepiBOgKEckYjec27MYpBPkNvJ4Uf4FRDA1mKOuISsgfZ45lMtz
         aWkZVZCb4Lqi4uFWyxjexbqLQhX/wXFE4uwifw3jFF0/yqlEcWXuUBy+UHSC8BFNGxKf
         g+Q2+SnrgKtG/guTutTJNRreZESpmmaOazDrmnctSupp7ax+ptne6EfZ1pQXCy0rrmv6
         qspQD+4jNFopelWbxZk9tHD7k5LG0L1T3KFpRqHEYFyIer7hodl557BSUmbp6ECFEsip
         vgA26KYDtp6XVfo3HnF1lyCv1Ie9gnzPiTX4kfshcU+laArsLgxwgo25T9xWlNvdYImD
         mGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PTJvnArUvKNsOxVEuhJbTo8k3kGB1/WAG8v2GjmdSbc=;
        b=XCkwzt9g2UXBmJYncHu/khd2aooR28dSvb2paY+AgoBYVcI7vJGZySPxb96lgfzxtL
         msK/QImVQi7NAorOGL/QdhALf5+i8beIDK2gbVCqNUfkZE8SfR/TQfiPFPgEH7ib17kV
         GZB2GTtrklYwfncBFecehD+4Sm9HrQUQjw+5S9HlrrFLkCo5HLM5EOFNBGnDpPVYJFcH
         6TSVk/Ta1zO62csT5/C0kprJ4nq2TZvsr1rB/rNF85lyeM1Y86dqlHMaGfJ/ObfeE8Y/
         moW4TNG74xBJl1sMTcHG+Y/PKhBrAzsE1lf0oEpzd26efYulP5Xr+CKpHT8yGP85BPoN
         5lHg==
X-Gm-Message-State: APjAAAXJiIoYTS/uLG5GZUD4INmiNmRW0+JYouSTZamTV+0jjVbq4o1t
        Y++OGkI7hjuL5yjckWTHAp4R/Vrh
X-Google-Smtp-Source: APXvYqzSh8tf/YTGjeyxe4kIXvdOYOBRKurMWD5ofukZfLL61EPPMAwLQlfyjjqGf7UHQ3Ewn4ALLw==
X-Received: by 2002:a05:6000:45:: with SMTP id k5mr6181376wrx.259.1569837335030;
        Mon, 30 Sep 2019 02:55:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b5sm12236793wmj.18.2019.09.30.02.55.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2019 02:55:34 -0700 (PDT)
Date:   Mon, 30 Sep 2019 02:55:34 -0700 (PDT)
X-Google-Original-Date: Mon, 30 Sep 2019 09:55:22 GMT
Message-Id: <5c880f923ec9d5aa72b3b2dc6d54f427823b8389.1569837329.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.288.v2.git.gitgitgadget@gmail.com>
References: <pull.288.git.gitgitgadget@gmail.com>
        <pull.288.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 06/13] msvc: handle DEVELOPER=1
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We frequently build Git using the `DEVELOPER=1` make setting as a
shortcut to enable all kinds of more stringent compiler warnings.

Those compiler warnings are relatively specific to GCC, though, so let's
try our best to translate them to the equivalent options to pass to MS
Visual C++'s `cl.exe`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/vcbuild/scripts/clink.pl | 46 +++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/compat/vcbuild/scripts/clink.pl b/compat/vcbuild/scripts/clink.pl
index 00fc339cba..ec95a3b2d0 100755
--- a/compat/vcbuild/scripts/clink.pl
+++ b/compat/vcbuild/scripts/clink.pl
@@ -70,6 +70,52 @@
 		push(@lflags, $arg);
 	} elsif ("$arg" =~ /^-[Rl]/) {
 		# eat
+	} elsif ("$arg" eq "-Werror") {
+		push(@cflags, "-WX");
+	} elsif ("$arg" eq "-Wall") {
+		# cl.exe understands -Wall, but it is really overzealous
+		push(@cflags, "-W4");
+		# disable the "signed/unsigned mismatch" warnings; our source code violates that
+		push(@cflags, "-wd4018");
+		push(@cflags, "-wd4245");
+		push(@cflags, "-wd4389");
+		# disable the "unreferenced formal parameter" warning; our source code violates that
+		push(@cflags, "-wd4100");
+		# disable the "conditional expression is constant" warning; our source code violates that
+		push(@cflags, "-wd4127");
+		# disable the "const object should be initialized" warning; these warnings affect only objects that are `static`
+		push(@cflags, "-wd4132");
+		# disable the "function/data pointer conversion in expression" warning; our source code violates that
+		push(@cflags, "-wd4152");
+		# disable the "non-constant aggregate initializer" warning; our source code violates that
+		push(@cflags, "-wd4204");
+		# disable the "cannot be initialized using address of automatic variable" warning; our source code violates that
+		push(@cflags, "-wd4221");
+		# disable the "possible loss of data" warnings; our source code violates that
+		push(@cflags, "-wd4244");
+		push(@cflags, "-wd4267");
+		# disable the "array is too small to include a terminating null character" warning; we ab-use strings to initialize OIDs
+		push(@cflags, "-wd4295");
+		# disable the "'<<': result of 32-bit shift implicitly converted to 64 bits" warning; our source code violates that
+		push(@cflags, "-wd4334");
+		# disable the "declaration hides previous local declaration" warning; our source code violates that
+		push(@cflags, "-wd4456");
+		# disable the "declaration hides function parameter" warning; our source code violates that
+		push(@cflags, "-wd4457");
+		# disable the "declaration hides global declaration" warning; our source code violates that
+		push(@cflags, "-wd4459");
+		# disable the "potentially uninitialized local variable '<name>' used" warning; our source code violates that
+		push(@cflags, "-wd4701");
+		# disable the "unreachable code" warning; our source code violates that
+		push(@cflags, "-wd4702");
+		# disable the "potentially uninitialized local pointer variable used" warning; our source code violates that
+		push(@cflags, "-wd4703");
+		# disable the "assignment within conditional expression" warning; our source code violates that
+		push(@cflags, "-wd4706");
+		# disable the "'inet_ntoa': Use inet_ntop() or InetNtop() instead" warning; our source code violates that
+		push(@cflags, "-wd4996");
+	} elsif ("$arg" =~ /^-W[a-z]/) {
+		# let's ignore those
 	} else {
 		push(@args, $arg);
 	}
-- 
gitgitgadget

