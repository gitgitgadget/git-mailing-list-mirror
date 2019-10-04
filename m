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
	by dcvr.yhbt.net (Postfix) with ESMTP id A6FA71F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 15:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389724AbfJDPJd (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 11:09:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45579 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389570AbfJDPJc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 11:09:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id r5so7605161wrm.12
        for <git@vger.kernel.org>; Fri, 04 Oct 2019 08:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zteYf+iycQJu2502hnxx/ZRaVqCtAFJWK+KlHVf9BQc=;
        b=dRjI8DZQt3jhLtM0WTPzGzPBU3EIWzgcSr33bT9ixm87BMyiAMNSxIOXSkakD2iDbX
         scozrMCiB/nrDUYPTLPouF1M/CT3IediEezsccmM/8eKykjbjfHOe1zKPXJGAQtX+faT
         mGYl1jLhokTNNUtCOhrWcg8ZGqBQuHdrUTbx2rx7S+ahneN1lj3lDX/juY7ElJ1pdRpV
         wOAgc2asL40V9/2MMBd/6eInM2TASIBjvodFsYfT9iQh+mFoGO0myL25tDhK9tmjDuLE
         WhNiBUhf2prcWY1wOXTiMlOIQ+sFs3O+PbxTarjAUuZGA4YT3elJlPXsuAs4oBQvWH8D
         cYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zteYf+iycQJu2502hnxx/ZRaVqCtAFJWK+KlHVf9BQc=;
        b=oHIBbNjj4I3eCq3BQ8JdcQ773tCqHU3gCzRnT/d+z3BGOBmhO30S8t8MsyWZeL5uo1
         G1kIGEmRyau9JSPcwo3e8i+TvYGRvO0GA0vIQMy4a+2QgOFIsFoaELZBzgitX3FUg0MI
         igLL+bbGYJ2xPWSQow2GyJTuWwJCpjNvhakG+NJYOD+OP8CvqBF3Vs1N4lEUN+QKsHdM
         RdJNV8d5mJbbDkg0dmpBuHZLrvqwlrHGLv+/H5GedlZ5vE9XudzzKEwKZrDxvRdfc9Rk
         z3Tj7dPKfSBS+E1duQOH1RNPD8zPLFUf5CVvVTznTtuuRtw04NXFFe0FN1U8MHMzfIz6
         yjlQ==
X-Gm-Message-State: APjAAAXUUVAZv0rXqAquaS50o/ogIBL+Z3Hhwx5klqxGsbpBdjb2KR7h
        rc/ca3pPmnvxv7Rc8tusArNnsuvs
X-Google-Smtp-Source: APXvYqw16M/ESFvXR6nO072sXl1O5k/FuIF4mPuRwfNFzC4LGjckUg1BT/X+VUvxfCf9ZESEYQX2ew==
X-Received: by 2002:adf:f9c9:: with SMTP id w9mr11583469wrr.172.1570201769753;
        Fri, 04 Oct 2019 08:09:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a2sm7864855wrp.11.2019.10.04.08.09.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 08:09:29 -0700 (PDT)
Date:   Fri, 04 Oct 2019 08:09:29 -0700 (PDT)
X-Google-Original-Date: Fri, 04 Oct 2019 15:09:14 GMT
Message-Id: <bf09257f65e8acf9a5fed7d27378e187e7328f91.1570201763.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.288.v3.git.gitgitgadget@gmail.com>
References: <pull.288.v2.git.gitgitgadget@gmail.com>
        <pull.288.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 05/13] msvc: ignore some libraries when linking
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

