Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DC561F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 22:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbeK1JyW (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 04:54:22 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40338 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbeK1JyV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 04:54:21 -0500
Received: by mail-wm1-f66.google.com with SMTP id q26so641677wmf.5
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 14:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jhwnY7wHIThWbNpugwN85Gni4ruFt8ixTo38BLvsuwQ=;
        b=HhlwiXY3B2Gzx5+4lBYhNQ2OkkRCyV8aaRdNXXV2FkvUl/AcU3mPQgEMd3s8F6ymp2
         ND+l3cmTVv4GGTuGn5FgDNZ6paQiDovOhpT7aYgaYC8hmlU4Rh06h+lAY31qrMTW+FqN
         WqISLc+vYG7XqhfsXmoOwGAw8MtMBvBq6XRr6cnV7kqyTi3TLsJXApg60MxB7Fzl5L8z
         JQ4BjmC/FLoCqLodzpsP5MVM+2hMkWABz0f1BH1NqYo+V75r9s1cDHE8lzaPZcJ10NG0
         b7ZDDc8i3Hyr9FFPFTB6AYJ9M1YMGVYXbF1mwftbCiE+4yrI0tdq92jpr9jmoX1NYnuX
         TZ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jhwnY7wHIThWbNpugwN85Gni4ruFt8ixTo38BLvsuwQ=;
        b=TbqbhgCcJn0C9xfhKrBb28fQ2eALJRTz70jxdVgbzt+GYP7NqCaf+FyAhl1kmvG8fx
         IM+0qbnwShMRRv7l8ldCYpAKLK172OcfmubnGSR/658IIqBgzSYVRO2bAdhSWYUt3myP
         wupNK52a3VIpHAzn0zi2rE8EslTWD9JD9SJw0mBK4IfsCpHo34mUNZfKD48BF8TdNgeW
         7cXWHN4gQw4eBKp/k0LBmockxZEU5OWLMxsyJVbBF5sWTNx2K6IhX48tiK6kY5r4jaEd
         M+bOJJYQtvmS0+vIW4gA8+mjL069YyO4nnf5KoFrCL+9GZkNUZp3M1B2lTf326+tHBQH
         2IRw==
X-Gm-Message-State: AA+aEWZi3cttPL/Fb6UCHdy6YAC/5s66pgx1y58+Curup+iq7hPDTfJg
        nMbm83tejJixMk0jesDto6PYWt8V
X-Google-Smtp-Source: AFSGD/Vb4Rad/Vl/kTgPNPRiebqJ/GSe1DYe6CrFC0o2mcUTWfiy5qd/VcyUxXCrXwZVaSYJTDHFBQ==
X-Received: by 2002:a1c:ee14:: with SMTP id m20mr577907wmh.47.1543359293602;
        Tue, 27 Nov 2018 14:54:53 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v189-v6sm710604wmd.40.2018.11.27.14.54.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 14:54:52 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/5] t/README: re-flow a paragraph
Date:   Tue, 27 Nov 2018 23:54:43 +0100
Message-Id: <20181127225445.30045-3-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1.379.g1dd7ef354c
In-Reply-To: <20181127225445.30045-1-avarab@gmail.com>
References: <20181127225445.30045-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An earlier change changed this paragraph to make the first line quite
short as to produce a more minimal diff. Let's re-flow it. There's no
changes here if diffed with --word-diff.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/README | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/t/README b/t/README
index 3139f4330a..c03b268813 100644
--- a/t/README
+++ b/t/README
@@ -216,11 +216,10 @@ Or tests matching a glob:
 
     $ GIT_SKIP_TESTS='t[0-4]??? t91?? t9200.8' make
 
-The value of the environment variable is a
-SP separated list of patterns that tells which tests to skip,
-and either can match the "t[0-9]{4}" part to skip the whole
-test, or t[0-9]{4} followed by ".$number" to say which
-particular test to skip.
+The value of the environment variable is a SP separated list of
+patterns that tells which tests to skip, and either can match the
+"t[0-9]{4}" part to skip the whole test, or t[0-9]{4} followed by
+".$number" to say which particular test to skip.
 
 For an individual test suite --run could be used to specify that
 only some tests should be run or that some tests should be
-- 
2.20.0.rc1.379.g1dd7ef354c

