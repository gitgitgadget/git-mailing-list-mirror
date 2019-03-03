Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC14220248
	for <e@80x24.org>; Sun,  3 Mar 2019 17:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfCCRL6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 12:11:58 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46451 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfCCRL5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 12:11:57 -0500
Received: by mail-ed1-f66.google.com with SMTP id f2so2294972edy.13
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 09:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=w9D51nzePpOyGIwULQ/4KBCN7t8Dy6bXd4Z3X/qKuvQ=;
        b=nyxkNf/MIIfi+7RTSb6jJAx+6xX/gpkFv+3XvD4N3Ul9ujvRO5juzVWbpM/ShoQha0
         MI74TSZDQs994Uqq5ltoXTwI85OPSni80VUyTGyQW3ZaJhdMmuO8o2kKB5vxryMQqPBI
         7IuqfLe1qj3E7p9CGSOPm7uljdy2agoabev+x0DRAhKNTdcFGaWcBBWDxVlknwwlrqrZ
         KL2b+PC6cXTGkptLI6c5qRFkVFMtDPmcozpekYn/ofxi9UlsyOaH90F9cKH0wRkVDsLt
         Vhp37+qektQaSCTMODUcW6mEG3hKR6F2H1tH6sFOhOopN42Sf5AeKZHTZDmXOt1ryjnz
         kSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=w9D51nzePpOyGIwULQ/4KBCN7t8Dy6bXd4Z3X/qKuvQ=;
        b=MaLjBDPgvyJiSxAJmsW5JvX+LAXNsx0FC2AK7QXgdCOMgOrt/e/NY6n/D4e9dgzO4L
         4FsezLU4Pr2ViIeoDuS3XdZx8rcBGBm6w+FyFyp8n34wT/8WFon3GM8Jnw+2dQJOReQx
         vXI6WmEuHGdg8wh6O1p8Cd6iVnX46ZPQnxTp2iicGDS/P0kOc7mWIbtNM/MV9zPi+vfV
         GKARXbvKgnIILIC21O/asywU5SRR6dHNJrvfCuFwVVaQkQfA3jmG/jYBDSkREqXFtB8a
         uR3ZofRQZVXWr58GCrgjFc0m84fWUudY+1OkgvGrh8K0yTBkYKzE4yPGwhebHSZEj2SQ
         uuuA==
X-Gm-Message-State: APjAAAUhIH81T0Cj95n94Gdt7tvwBpClg9XIMOIj1VfJsJrnaQfikbwn
        jh3GXpb4Dq63FItdTLFc2SPsslyr
X-Google-Smtp-Source: APXvYqwblECrXC3BaHc5NY8C5RcTMWAy5ZT/1W/mbR9qSgj82DtCkzCGOQzQ3OLWy9+c0M1KcWwikA==
X-Received: by 2002:aa7:db04:: with SMTP id t4mr12040083eds.173.1551633115199;
        Sun, 03 Mar 2019 09:11:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h22sm741700ejj.43.2019.03.03.09.11.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 09:11:54 -0800 (PST)
Date:   Sun, 03 Mar 2019 09:11:54 -0800 (PST)
X-Google-Original-Date: Sun, 03 Mar 2019 17:11:51 GMT
Message-Id: <17737998f45ed8b4e38fa58ff82309231230fc81.1551633112.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.153.v2.git.gitgitgadget@gmail.com>
References: <pull.153.git.gitgitgadget@gmail.com>
        <pull.153.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 3/4] built-in rebase: demonstrate that ORIG_HEAD is not set
 correctly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nazri Ramliy <ayiehere@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The ORIG_HEAD pseudo ref is supposed to refer to the original,
pre-rebase state after a successful rebase. Let's add a regression test
to prove that this regressed: With GIT_TEST_REBASE_USE_BUILTIN=false,
this test case passes, with GIT_TEST_REBASE_USE_BUILTIN=true (or unset),
it fails.

Reported by Nazri Ramliy.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3400-rebase.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 3e73f7584c..7e8d5bb200 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -59,6 +59,14 @@ test_expect_success 'rebase against master' '
 	git rebase master
 '
 
+test_expect_failure 'rebase sets ORIG_HEAD to pre-rebase state' '
+	git checkout -b orig-head topic &&
+	pre="$(git rev-parse --verify HEAD)" &&
+	git rebase master &&
+	test_cmp_rev "$pre" ORIG_HEAD &&
+	! test_cmp_rev "$pre" HEAD
+'
+
 test_expect_success 'rebase, with <onto> and <upstream> specified as :/quuxery' '
 	test_when_finished "git branch -D torebase" &&
 	git checkout -b torebase my-topic-branch^ &&
-- 
gitgitgadget

