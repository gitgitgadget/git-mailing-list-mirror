Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 307FE208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 09:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbeHFMBL (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 08:01:11 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46673 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbeHFMBL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 08:01:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id u24-v6so6606613pfn.13
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 02:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jTTvzwVdH9r+sX8kHvpDgV9GDztZ2ZvJi/0rPxOjMKY=;
        b=A3DLwTDSXzmaQu6a+2paxKuwgdspIz5qCP16wwsJYY6Duuv7rOighMlwDTEgmoy3uj
         zwXR40qBAGHiyknz0EkjZJngacNd0nGRPQ1/Q0rN87gThWFot+5j1niiWautPH5tH8vf
         X0/jY5VfdiizzkTzzxhegw2ijx1J9CMsmN8xoAS6X3w4aBT03WrKT4OUzEOmYTKyxxO7
         JygIp/rNHYMhzznteA0evR7Of7B62g0Kw7rSCVnQlsWqyC/FsQ8izOmzb8PApeX1gFjs
         2aas2W9oeVMQuagOEETM49MYoKF772+F3hYthn5di0pJhDJbqZLQERUuL9mh3r26G9Vo
         iH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jTTvzwVdH9r+sX8kHvpDgV9GDztZ2ZvJi/0rPxOjMKY=;
        b=i9+O3fX8mK/l5H/OUs8ZTx9gj5Px+8gpqcWATxfluJqOLaJP9QHr5mRWB463ZMEYJ4
         e9KOLDOsnEBzfFMngqbcSO1fYmgj2FHuNK+UKvHqCHgFayHhb16TISGlPUsOJNX4YnJO
         +fFUK4RxKXzfxrqV+4/UgyG/s2g0of0t7VstcXH9fb9a0+vk8gua+kjxJnPe+ljIKNyd
         MBPR5SG8lzbGouMWEXCysIr784ffOlWTDAupgYUpYwWNBmnFj+4EdYSJUqFFcSe00zhc
         zaQufeWRjteiCcf6viqbOxOFu2GGnBuPJ6XNpmT4uofEgnll3weNbbCAI9ma9KIkoK1J
         D/Sg==
X-Gm-Message-State: AOUpUlF7mVeGFTOs006XF+0goEF/sGqyAXsX26Eudf0lHa+H3ftd3eD/
        yhRnqRIiLQEyvACnph257DYtlARu
X-Google-Smtp-Source: AAOMgpeqtlMjWdD9SjAuu+TdUGIA5kb+DE9kxa6ZyOeioV/yIwYhTVdViJNC8ZqNjaztEUZJJDh5IA==
X-Received: by 2002:a65:5bc4:: with SMTP id o4-v6mr13668887pgr.448.1533549173417;
        Mon, 06 Aug 2018 02:52:53 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id d9-v6sm19965699pfb.86.2018.08.06.02.52.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 02:52:52 -0700 (PDT)
Date:   Mon, 06 Aug 2018 02:52:52 -0700 (PDT)
X-Google-Original-Date: Mon, 06 Aug 2018 09:52:48 GMT
Message-Id: <1d82eb450378c5d9ebdadb2f785df1782cf3a1d4.1533549169.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.13.v2.git.gitgitgadget@gmail.com>
References: <pull.13.git.gitgitgadget@gmail.com>
        <pull.13.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/2] t3430: demonstrate what -r, --autosquash & --exec
 should do
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

The --exec option's implementation is not really well-prepared for
--rebase-merges. Demonstrate this.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3430-rebase-merges.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 9e6229727..0bf5eaa37 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -363,4 +363,21 @@ test_expect_success 'octopus merges' '
 	EOF
 '
 
+test_expect_failure 'with --autosquash and --exec' '
+	git checkout -b with-exec H &&
+	echo Booh >B.t &&
+	test_tick &&
+	git commit --fixup B B.t &&
+	write_script show.sh <<-\EOF &&
+	subject="$(git show -s --format=%s HEAD)"
+	content="$(git diff HEAD^! | tail -n 1)"
+	echo "$subject: $content"
+	EOF
+	test_tick &&
+	git rebase -ir --autosquash --exec ./show.sh A >actual &&
+	grep "B: +Booh" actual &&
+	grep "E: +Booh" actual &&
+	grep "G: +G" actual
+'
+
 test_done
-- 
gitgitgadget

