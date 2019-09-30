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
	by dcvr.yhbt.net (Postfix) with ESMTP id DF6251F463
	for <e@80x24.org>; Mon, 30 Sep 2019 09:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730627AbfI3Jzh (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 05:55:37 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54096 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730585AbfI3Jzg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 05:55:36 -0400
Received: by mail-wm1-f66.google.com with SMTP id i16so12630880wmd.3
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 02:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zteYf+iycQJu2502hnxx/ZRaVqCtAFJWK+KlHVf9BQc=;
        b=B0PE7ilEbK0XFR2wg3g++YDruHMWivz4suAlzKOw8yWyarjfALcr8AADPmsnyXid03
         pzpCSe3j7mtqDRnKcVlftYLsDorhUid0fqebeUHS7YsLbNrtzGGk+ofaXYVBfUz68sHg
         4Y1pzwGX7Tw290g3KsUv+BMyXHjOQ344g07BxjvAbFn2LFJNCaLfyxrKyVH1vVGUcYwf
         yzYd8MeBWZXAp8a68s9xZnhOFjayrCf0MfJc2m+eMOtgRF30MTntrUj8JdgymcWnTGJ8
         IU4IWFHQ1kSKCyd8CNIxn2g1SVVzWro3vCjBoJPOav0mW5HoXQbJkM6B6wj/TM/yz2E4
         vvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zteYf+iycQJu2502hnxx/ZRaVqCtAFJWK+KlHVf9BQc=;
        b=dW4/G9997SEumqNw2A1acUQjwlYTPKDeuOez01gwb8A8J+lP0rb7Ruhqx0iEUrdfvg
         pK+0K/gYdEIHSf+nCEc+DMyHTefSolxysWYrLkUM7IWzFeEX9azdroGi1Kvg1LbxVhfI
         7x42h3sSZB5K3PsBgs/6AW63JS1p81Q1VfDQMv6DigWSCNLukgXGYFVQgY+yp1hS2jXa
         P8ciEFOH+n1a2NJQd9oHkufQYft8aABL8TjGTIvgsD3X1KcwSuYAVI2PFQuUYaCTo+Rc
         jVNReNXCnmoM8YtARmmsu8Md+aFmgW/S4ml+3l3MX/N8YtJEVPB6m3dIQ7pFeMmuqUQL
         IMgg==
X-Gm-Message-State: APjAAAXP7gRuMSWuZXhYUohWqCL9/UwF8gvNuNPlS+boLS9PPvXzH59y
        N7nZY8DCkDfKMQQ9q+Alr/R/fCrI
X-Google-Smtp-Source: APXvYqzgjcMPcnPf/nSzJV2JqEH1kP2peua8TjcLIdV+sU4fwhO8oNtLKuuK6ize+EhCiiTDra9hQA==
X-Received: by 2002:a7b:c8d6:: with SMTP id f22mr15534110wml.173.1569837334344;
        Mon, 30 Sep 2019 02:55:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l11sm14546148wmh.34.2019.09.30.02.55.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2019 02:55:33 -0700 (PDT)
Date:   Mon, 30 Sep 2019 02:55:33 -0700 (PDT)
X-Google-Original-Date: Mon, 30 Sep 2019 09:55:21 GMT
Message-Id: <5add01f8ffeec28f7d91a0e63c1ce28f4f0d831c.1569837329.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.288.v2.git.gitgitgadget@gmail.com>
References: <pull.288.git.gitgitgadget@gmail.com>
        <pull.288.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 05/13] msvc: ignore some libraries when linking
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

To build with MSVC, we "translate" GCC options to MSVC options, and part
of those options refer to the libraries to link into the final
executable. Currently, this part looks somewhat like this on Windows:

	-lcurl -lnghttp2 -lidn2 -lssl -lcrypto -lssl -lcrypto -lgdi32
	-lcrypt32 -lwldap32 -lz -lws2_32 -lexpat

Some of those are direct dependencies (such as curl and ssl) and others
are indirect (nghttp2 and idn2, for example, are dependencies of curl,
but need to be linked in for reasons).

We already handle the direct dependencies, e.g. `-liconv` is already
handled as adding `libiconv.lib` to the list of libraries to link
against.

Let's just ignore the remaining `-l*` options so that MSVC does not have
to warn us that it ignored e.g. the `/lnghttp2` option. We do that by
extending the clause that already "eats" the `-R*` options to also eat
the `-l*` options.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/vcbuild/scripts/clink.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/vcbuild/scripts/clink.pl b/compat/vcbuild/scripts/clink.pl
index c7b021bfac..00fc339cba 100755
--- a/compat/vcbuild/scripts/clink.pl
+++ b/compat/vcbuild/scripts/clink.pl
@@ -68,7 +68,7 @@
 	} elsif ("$arg" =~ /^-L/ && "$arg" ne "-LTCG") {
 		$arg =~ s/^-L/-LIBPATH:/;
 		push(@lflags, $arg);
-	} elsif ("$arg" =~ /^-R/) {
+	} elsif ("$arg" =~ /^-[Rl]/) {
 		# eat
 	} else {
 		push(@args, $arg);
-- 
gitgitgadget

