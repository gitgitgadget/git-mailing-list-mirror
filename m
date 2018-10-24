Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BFEA1F453
	for <e@80x24.org>; Wed, 24 Oct 2018 15:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbeJYAYu (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 20:24:50 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45423 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbeJYAYt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 20:24:49 -0400
Received: by mail-pl1-f193.google.com with SMTP id o19-v6so2422762pll.12
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 08:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TvVd19TVXJa2dWnrvyMeosc6pBA/zqAebDjb6GadYaI=;
        b=DoPux7JJRmONJ8w0jLmsRo3RFTprzWYN0AoPG6ZKWVB+izXSEH8tRLMh/h7NXwECw5
         O2mqDlnDPxK7/xDjURmPK4utEArheETN/bLnGWszNF9U6a+kSHQo/s1zDpIO+O4z2L7S
         AENmAbvtmFgATk+dNbWDadR+SihUda/4FVGt19OOXwpD8nPhA73APDXnt/mXfCfawwrP
         1BhFueqnY4kb+vQv+DIZ4Dt49BtLKT9WoYoNdlKDa4oshv2HPlMoQsX4EFNKbr51Sxg9
         /xwSZrrHewpdQsiKZKTys0L9+KKVO0HDH8+dy08uqixVY0lyqWARKUDjD3zvY3kaTR9r
         XHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TvVd19TVXJa2dWnrvyMeosc6pBA/zqAebDjb6GadYaI=;
        b=CWO2DFYKidPlMfGcgLK1Im5qfvpTwQSWlDGXjndcNY6Mwy0V1b+8WMaknzIUpiqixU
         enXRjX8udc67VWC1e1/3roTUyGYMKvBHoT8agPbHQ+xUh0tfP56shTESSVdKdM4N//YE
         d88aAN45fDnllqhwynJ5Hn+Gt0R7GTi4RWXk8GKxxXfSb7dAb57I8klyuXSXovaLqfq3
         otOOAbToPjugqon4tVNHzQG0/z9xOhfc+f6v7SHeuJAk0wB41irUULiODQWMyFr0CfQn
         phxLBS4iIByYUB+iUokFMcBpIa4ZuvzOyPnvB8mz+shzbt2OWQlXPVWCND7xCnOJdGbt
         hVkw==
X-Gm-Message-State: AGRZ1gLbgmlIrRKhdttZBcCOXEoYzluP2OtoE/4CelNe0WPbWIHbHCaV
        dnY1pJkX9DY972liAHgfFF9ehtiL
X-Google-Smtp-Source: AJdET5f1cY1n+qrc0za5b1b9XMWStEcYdw9kNtTd6L4IL0rGyq6fB0gaPnx/inQzD4nF2iYkJpzTuA==
X-Received: by 2002:a17:902:7109:: with SMTP id a9-v6mr3023523pll.310.1540396571765;
        Wed, 24 Oct 2018 08:56:11 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id y10-v6sm8397470pgi.85.2018.10.24.08.56.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 08:56:10 -0700 (PDT)
Date:   Wed, 24 Oct 2018 08:56:10 -0700 (PDT)
X-Google-Original-Date: Wed, 24 Oct 2018 15:56:05 GMT
Message-Id: <d9720bd25145c6e2b1b1a867b4eb49cdd779803d.1540396567.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.9.v4.git.gitgitgadget@gmail.com>
References: <pull.9.v3.git.gitgitgadget@gmail.com>
        <pull.9.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 1/3] repack: point out a bug handling stale shallow info
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
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
index 7045685e2..686fdc928 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -186,6 +186,33 @@ EOF
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
+	d="$(git -C shallow-server rev-parse --verify D^0)" &&
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
+	git -C shallow-server branch branch-orig $d &&
+	git -C shallow-client fetch --prune --depth=2 \
+		origin "+refs/heads/*:refs/remotes/origin/*"
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
gitgitgadget

