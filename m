Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEE0020248
	for <e@80x24.org>; Mon, 25 Mar 2019 18:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbfCYSOW (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 14:14:22 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:35727 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729095AbfCYSOV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 14:14:21 -0400
Received: by mail-ed1-f45.google.com with SMTP id s39so2903785edb.2
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 11:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fGOHtPvcjQ3mSuxQl3i9SrO/790cDVD9LJUo8dfEDe8=;
        b=qlscxnAUj31THgDVSQkvj8hbMsIveMCfLKF5Ggt/rO3KHrXHwPO3OLcO4ItxnBJeKY
         Gt0wlbguu4B1mLWPQmVs1lnVIvql+EJvLIITEedbH5WlmAkDizlzV2JOkqEkExJbNmy6
         1nBMSSdn49TbrTZA41YIFnYfZTK6Ky/x0bw5zxK6qgkOh18Ou6LX3bOtWwAqoWRUHM/r
         cUSe13ye7VL8ESZKcG503ORcEn1aV6+rYhwETr7blvce1ququ2gfPxyTaDklmn2iPXDt
         ts+Mh4vvZ4+6UjeUjIbpbxLTtgV/Ho4ecZ/ZgaPzoA4RpheNMi54SmmLrUfmpPdD/HWu
         GMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fGOHtPvcjQ3mSuxQl3i9SrO/790cDVD9LJUo8dfEDe8=;
        b=OTOh+VmjqSjpl9KtdNRdM6/TK6eAqV1cK6rsJDu0j8s9hicZcUl1yN9Jzjy6tD8FWR
         4y6ZGrLF/qYnl5q3pFrKK2DEFWHQ0NYBsOAsNNXaFOpD0hk0KDdcTPUuAnMODj96Ll7Z
         E4hdL8RUUmwtBf7InN7b5phqwfUCgE7rIMSz0fblqqNI1/R5VV1CqZfgDz9BsaYrWIww
         nceZn+GYlruavmv3CthN2Ogyu1a6Pux1tCoc4ptcHtSwOlnSoBVv2UPNsga48sBpI0vU
         DH87UIp7y+InwH4QqMHHSC8WWb/JMZdy79kBP4ZtFdxUCKUb8JrJ8a8aeOJRkkAYiHQB
         Ioaw==
X-Gm-Message-State: APjAAAULR805qMOgomUNEKQuAoZuNmf+u2/HbtmkpCvQjN4XqWOaQEIm
        qPTVqIFXpyS3ySLrCxkvZGaQ0zRS
X-Google-Smtp-Source: APXvYqyh3sjKqIw8pxp+19+27QINW82DoHIP6NJo+BVjvGQVToZySOpJSgbAbgau8emc3EXHEEHr8g==
X-Received: by 2002:a50:e78a:: with SMTP id b10mr17690411edn.45.1553537659553;
        Mon, 25 Mar 2019 11:14:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i8sm3308913eda.1.2019.03.25.11.14.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 11:14:19 -0700 (PDT)
Date:   Mon, 25 Mar 2019 11:14:19 -0700 (PDT)
X-Google-Original-Date: Mon, 25 Mar 2019 18:14:10 GMT
Message-Id: <017ec9a0c74c770a42843eef65f49b7cc4397728.1553537656.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.167.git.gitgitgadget@gmail.com>
References: <pull.167.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/8] tests (rebase): spell out the `--force-rebase` option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In quite a few test cases, we were sloppy and used the abbreviation
`--force`, but we really should be precise in what we want to test.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3415-rebase-autosquash.sh | 2 +-
 t/t3430-rebase-merges.sh     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 13f5688135..22d218698e 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -277,7 +277,7 @@ test_expect_success 'autosquash with empty custom instructionFormat' '
 	(
 		set_cat_todo_editor &&
 		test_must_fail git -c rebase.instructionFormat= \
-			rebase --autosquash  --force -i HEAD^ >actual &&
+			rebase --autosquash  --force-rebase -i HEAD^ >actual &&
 		git log -1 --format="pick %h %s" >expect &&
 		test_cmp expect actual
 	)
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 4c69255ee6..42ba5b9f09 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -271,7 +271,7 @@ test_expect_success 'root commits' '
 	EOF
 	test_config sequence.editor \""$PWD"/replace-editor.sh\" &&
 	test_tick &&
-	git rebase -i --force --root -r &&
+	git rebase -i --force-rebase --root -r &&
 	test "Parsnip" = "$(git show -s --format=%an HEAD^)" &&
 	test $(git rev-parse second-root^0) != $(git rev-parse HEAD^) &&
 	test $(git rev-parse second-root:second-root.t) = \
@@ -364,7 +364,7 @@ test_expect_success 'octopus merges' '
 	test_cmp_rev HEAD $before &&
 
 	test_tick &&
-	git rebase -i --force -r HEAD^^ &&
+	git rebase -i --force-rebase -r HEAD^^ &&
 	test "Hank" = "$(git show -s --format=%an HEAD)" &&
 	test "$before" != $(git rev-parse HEAD) &&
 	test_cmp_graph HEAD^^.. <<-\EOF
-- 
gitgitgadget

