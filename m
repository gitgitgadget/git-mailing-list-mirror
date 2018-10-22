Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A29E01F453
	for <e@80x24.org>; Mon, 22 Oct 2018 22:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbeJWG0B (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 02:26:01 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45930 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbeJWG0B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 02:26:01 -0400
Received: by mail-pf1-f193.google.com with SMTP id u12-v6so20567007pfn.12
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 15:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3QcTDCFWboF0fdwrFMDM8mz4S3VCTVStwlIMi15y3HE=;
        b=PvZF+W0Ew90EYuHaXtEV07Pgj2bSbftefNsvFdkSeMpVJ65mNYLisMWFHi+RHB57Xi
         QyEwJ3/tBxZHJA2OlI62qbtYrRDbmRrPD/7CdF2oABGghWPqs4Qmgx+mFEzXHv5TCbaJ
         6XA2HTpzAkfoyiem2Di6RuXczHtRlnLBLBuIDCOD/8GBu38K22fa/jhftYrpDuFwSUFW
         2pcIqouegnsz3zJqWtl13lDf78TV/zPl2r3GS5XHVylhDEsnQQteN5hRM/qFRzM1AjG6
         nnj9i6s6sAvE06Iog8KA/+W0Ii0TEV8B1viB8Yg1fzMgUbeqUVyGVkFArXBKjKswdcN3
         jYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3QcTDCFWboF0fdwrFMDM8mz4S3VCTVStwlIMi15y3HE=;
        b=ER3DiTMIOxQBoaCkMuZZBfw5I6XrA6mMtisSHjm1JCWTgU/rY7GjfA/rDb8mdP/n/l
         gYgA+foM8EetPNqZ2UlVCme+B58kUlWOU/9yOWItFnFKIhObZyFQGbr9JqXvAsVAtn11
         9X8OwSgkJNSzj56Q2upjRnaFLuTkDwD4Nx0wCEkux4JcRdIC/m9iIy+mePPKEAbhsYaW
         NKwo6jDb7vfin1+WqplGGPHhdrKbfINU8vLky1nylvwehZz5R/1ANKm3S3RHCNJ4oddK
         1VoR/biI1eXvpEaFL8LU2cMS7fpd1LTP+XTGwzqjUGfEOdAQZar5y8YXWK4oV4dtfRB8
         g0+Q==
X-Gm-Message-State: AGRZ1gKlpNkbFpfeV490hOZ7Gwp18w4tD8T7SqciP+yXcEUoUr8WwSmK
        owuu7p7E5csgd1jMGLYbBDSy8jPx
X-Google-Smtp-Source: AJdET5fM9Awmm7EA97cZp6auxWc/ClOcWHUXMhiBcCK/iePB8ju+VFWTnzQMCxEm+JXAj0EoZnD4/w==
X-Received: by 2002:a63:77ce:: with SMTP id s197mr5949378pgc.89.1540245938096;
        Mon, 22 Oct 2018 15:05:38 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id k12-v6sm22580441pgr.81.2018.10.22.15.05.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 15:05:37 -0700 (PDT)
Date:   Mon, 22 Oct 2018 15:05:37 -0700 (PDT)
X-Google-Original-Date: Mon, 22 Oct 2018 22:05:31 GMT
Message-Id: <ed8559b91b7a3b51a5950d62e78fc726ed5b44c2.1540245934.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.9.v3.git.gitgitgadget@gmail.com>
References: <pull.9.v2.git.gitgitgadget@gmail.com>
        <pull.9.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 1/3] repack: point out a bug handling stale shallow info
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
index 7045685e2..2d0031703 100755
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
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
gitgitgadget

