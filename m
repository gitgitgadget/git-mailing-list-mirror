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
	by dcvr.yhbt.net (Postfix) with ESMTP id 73C251F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 15:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389753AbfJDPJk (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 11:09:40 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38807 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389711AbfJDPJc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 11:09:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id w12so7680717wro.5
        for <git@vger.kernel.org>; Fri, 04 Oct 2019 08:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PTJvnArUvKNsOxVEuhJbTo8k3kGB1/WAG8v2GjmdSbc=;
        b=O6w5WpizwfNeRFf4sJhzyUNFBCbwSSvC0/omtg/Ih4+axxq4N0lxB+HKay3irDYz8R
         mLxFo7R3M4LZ842exbaSFFoFin98NKvEMMzhiRR1oxjAKAauwddBOFA+6r6tF+FpMlaW
         f5qxbW0aRsTQcXqExkYn207qU6a4kKuF05fXKy2EMbPeWXgYzgnetXdS4PH+RKDXWwDs
         OmYLazu9a409DQOloK8vb2uqkhYL2CpfMvI/I1WLEMVU6ACIv/SZFsppa7KcOxGO4BJo
         5mdGiWcR00PP3b8+4MvL4DPeQqh5ryDiyfpQ3yXfUQhsOwwKLsqvVYZOYqb5LtWhmten
         cchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PTJvnArUvKNsOxVEuhJbTo8k3kGB1/WAG8v2GjmdSbc=;
        b=c89A7dQ7sSVJgo25aYsPjnqHu3H2weoO/s9SLNyjI98Q5wedC0KdsZBGb4/W5k1yZI
         wZKcC2DaOMS8pOlAXabOShtd/jGwcCf9iiSl6FQ44qurJ9QflHLJXQwwHovL3kwmfeUd
         KANf7JNoc2bdAs91JX4BwRbMpmTQ1b9Xr/nG7/p4hEOgK+g8IWcZaK8bnwtgTDVbIRFd
         lWrB2ev927+VWmMRSuVFD7KNNGmTHkDK4qvkbor/NZ+WgRMo9Bp5SeATZwBAKa4GidwN
         A1g8rAHHMMPw5HWgaWsssFKomyktImw6Rwb4Cak4dE0TUkruJlVWy6WCSFbBav60BWwb
         CEQw==
X-Gm-Message-State: APjAAAVAaphcbBg1USYctiA0b0sYTsyHpZd3DCiPZbRabe6DIiWrj/bm
        /yQ+93ySlQb/s/xFEZKsFfjcDRyu
X-Google-Smtp-Source: APXvYqwwU/hh+cPMWSpQXMfoM84ipHg0ljHIPXdqYnc2aXXDgz3DgwQQIGmsfWQn4pZwXQSB5P75ww==
X-Received: by 2002:adf:f20e:: with SMTP id p14mr11443135wro.212.1570201770631;
        Fri, 04 Oct 2019 08:09:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s9sm5146857wme.36.2019.10.04.08.09.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 08:09:30 -0700 (PDT)
Date:   Fri, 04 Oct 2019 08:09:30 -0700 (PDT)
X-Google-Original-Date: Fri, 04 Oct 2019 15:09:15 GMT
Message-Id: <39c707464cf46f199157db0c37bf6dec1da7c3af.1570201763.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.288.v3.git.gitgitgadget@gmail.com>
References: <pull.288.v2.git.gitgitgadget@gmail.com>
        <pull.288.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 06/13] msvc: handle DEVELOPER=1
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

