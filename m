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
	by dcvr.yhbt.net (Postfix) with ESMTP id E7B301F463
	for <e@80x24.org>; Thu, 26 Sep 2019 08:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbfIZIaS (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 04:30:18 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39452 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbfIZIaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 04:30:16 -0400
Received: by mail-lj1-f196.google.com with SMTP id y3so1231155ljj.6
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 01:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zteYf+iycQJu2502hnxx/ZRaVqCtAFJWK+KlHVf9BQc=;
        b=p27yFV98a2d7jClf7kiTqeP2tI0JZ7NKhKE0gTETf7d5PA+nkviIi2JO+K/Cw1EbI6
         bM+ZPXh73DjM60A62T9IFp3Pq5yx9YvjZhCbHeU2cntkI1yHWHpbf2wSJwgb4fVC8hKB
         ki3Zz2/hgP3W1d5iGze5meqHZIXQItzVfNF9EIw5+NdWlbqjjkfq25VRlan2Az9xBN/y
         7oY5daac+4ln8JhFeY+flvCNFsaVysLdJPiSW12sdVe8rHOQsxMirpFXSAtdytbPx4MZ
         QDFLCHbeRB9WptvE+b7LQjkdL1oRRS6VzURlzcS5FnqOvhm6G9hC7RjI7VpmBbA2aZxF
         OPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zteYf+iycQJu2502hnxx/ZRaVqCtAFJWK+KlHVf9BQc=;
        b=mAW4/lGtL2KSE9h4uo/wte2ZNo1MUswjNRcPnGaymzQm+KfUpNktxjuH+34VwqGRu1
         xpGMdiquETr0c8YMOCiFf21XTKXMwF/EntFjuViCsQuX26+sc8eHTFxss8VxFqi1FUrY
         cQ4N3JUFRdfuoLfcV8tpsAQXskprpDqITpH4Y6ESTio5uSEU4GKkBTRho1kK2gNkrZGy
         3v4VtyPjbuG8esTKLgrP3RQZOv3UY6opaBlk9SNRSnrhUfke0li8NCmB4+0TZ18tG/er
         EcMP/fGELRHThYSpQAH6Z5ppo70rkAa+asdSpQ+cRg6/+wy53cG+RNURM6MIGI+OxKCy
         rb6Q==
X-Gm-Message-State: APjAAAX3KzfPSedEog4VX8NLM9OD2ZW4Wk/p1rlex23NzMfFDG1vdEG5
        uia0WInM6xAwnvNJqvNXBJZVL8j1
X-Google-Smtp-Source: APXvYqyUpIiMoE7eynjgVDfqAngg0zUR/gg8RffwT3vMCuSdbZKw2DLYfxD0AeMYEUKMntfvj2mYzA==
X-Received: by 2002:a2e:8616:: with SMTP id a22mr1726076lji.6.1569486614847;
        Thu, 26 Sep 2019 01:30:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j84sm352352ljb.91.2019.09.26.01.30.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 01:30:14 -0700 (PDT)
Date:   Thu, 26 Sep 2019 01:30:14 -0700 (PDT)
X-Google-Original-Date: Thu, 26 Sep 2019 08:29:58 GMT
Message-Id: <d1dee56fccba12e092a3737f9a7765c54c15c6c2.1569486607.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.288.git.gitgitgadget@gmail.com>
References: <pull.288.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 05/13] msvc: ignore some libraries when linking
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

