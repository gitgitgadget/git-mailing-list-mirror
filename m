Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 145BD1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 13:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731701AbeGQOY3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 10:24:29 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37919 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731429AbeGQOY2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 10:24:28 -0400
Received: by mail-pl0-f65.google.com with SMTP id b1-v6so495591pls.5
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 06:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=m+FsaZQrdlhCzDq1yfETYj0eWan8JCrhgLz29HwSU30=;
        b=ivZi6I3Jh1CGq0VKA5xCuZDCQf09AITDDpD+kigd/fYaxnq8Ccy5i3QOXTeLid7Uhl
         JeSgRBdGnrqnTRVlLou4IF9zCVa3QXGF18kyxQsLSYRZBLDD0mAhy8YiGqtzU++t5BMJ
         5j6QCBD/fZBWBzpNNHnDVM9cMlqQBMnDk/tkFX18OZY8rMfgDb8HEYDJ4fkGDtmcVXgO
         XCWAC76KxIaUfYsYEBcs3ATUwva8n/gtStt+2UZHiz/rQA0b8aBlaRhwXB5hsMJj1M4E
         okcraL1VoTBgNT5rU5EOIWAxAfCxWQeq/are/ITQqBcvvNqUBiTtkHhXjGU5iMFtBMjs
         iJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=m+FsaZQrdlhCzDq1yfETYj0eWan8JCrhgLz29HwSU30=;
        b=WPVkU76couLsO0U3brRjHRqIm2Hc56Wejd1VW0feO8YEhsoEFkrpCKzFbAGKSvIiuB
         W1jiL9mBpDC7091pO//+enP/V6aggkHEzBKdRE9SAsLVrF917QUODQvEcIv0MqtuUZzq
         ofUQ7kXSkiGSRyws1fJQ5PBRdaMOOpr4ahXwBkfI4GVw+dvjJd5C76Apm1dD9l4e1bz6
         GX6MAZPs/SE2GAV/sCreCZhEPWbxJnTAtyZ04E2B5xlyYnABFOD6R2zNLp18WVK9nNKA
         ZZ39AY+r78aLjWp9nUkp6oghQyZxLjRjy5y1mmO/uqi9/5tycSwgCrOt5UDurpf8DCk9
         S9PA==
X-Gm-Message-State: AOUpUlF64B1weME5Hpj63OrIeS8MuUslbPcyMfY82C5BkEqRm2VA4Tcy
        2RezpNRub11g9TfY5Nyh0R3XuQ==
X-Google-Smtp-Source: AAOMgpfoAKnCIJ/EhBszU3YwLTGRVvQ8NagcWkav6TqjTC6SwJQOK8dNDQzhSdw2djDZ9tm1Kkt78A==
X-Received: by 2002:a17:902:1007:: with SMTP id b7-v6mr1695434pla.277.1531835501815;
        Tue, 17 Jul 2018 06:51:41 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id d132-v6sm2604599pgc.93.2018.07.17.06.51.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 06:51:41 -0700 (PDT)
Date:   Tue, 17 Jul 2018 06:51:41 -0700 (PDT)
X-Google-Original-Date: Tue, 17 Jul 2018 13:51:36 GMT
Message-Id: <d2be4013134c0e9dc032f934c6af82721fec4eba.1531835498.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.9.v2.git.gitgitgadget@gmail.com>
References: <pull.9.git.gitgitgadget@gmail.com>
        <pull.9.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/2] repack: point out a bug handling stale shallow info
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

A `git fetch --prune` can turn previously-reachable objects unreachable,
even commits that are in the `shallow` list. A subsequent `git repack
-ad` will then unceremoniously drop those unreachable commits, and the
`shallow` list will become stale. This means that when we try to fetch
with a larger `--depth` the next time, we may end up with:

	fatal: error in object: unshallow <commit-hash>

Reported by Alejandro Pauly.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5537-fetch-shallow.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index 943231af9..561485d31 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -186,4 +186,31 @@ EOF
 	test_cmp expect actual
 '
 
+test_expect_failure '.git/shallow is edited by repack' '
+	git init shallow-server &&
+	test_commit -C shallow-server A &&
+	test_commit -C shallow-server B &&
+	git -C shallow-server checkout -b branch &&
+	test_commit -C shallow-server C &&
+	test_commit -C shallow-server E &&
+	test_commit -C shallow-server D &&
+	d="$(git -C shallow-server rev-parse --verify D)" &&
+	git -C shallow-server checkout master &&
+
+	git clone --depth=1 --no-tags --no-single-branch \
+		"file://$PWD/shallow-server" shallow-client &&
+
+	: now remove the branch and fetch with prune &&
+	git -C shallow-server branch -D branch &&
+	git -C shallow-client fetch --prune --depth=1 \
+		origin "+refs/heads/*:refs/remotes/origin/*" &&
+	git -C shallow-client repack -adfl &&
+	test_must_fail git -C shallow-client rev-parse --verify $d^0 &&
+	! grep $d shallow-client/.git/shallow &&
+
+	git -C shallow-server branch branch-orig D^0 &&
+	git -C shallow-client fetch --prune --depth=2 \
+		origin "+refs/heads/*:refs/remotes/origin/*"
+'
+
 test_done
-- 
gitgitgadget

