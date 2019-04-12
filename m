Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84EEB20248
	for <e@80x24.org>; Fri, 12 Apr 2019 09:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfDLJhX (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 05:37:23 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:33534 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfDLJhW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 05:37:22 -0400
Received: by mail-ed1-f47.google.com with SMTP id d55so6962003ede.0
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 02:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fGOHtPvcjQ3mSuxQl3i9SrO/790cDVD9LJUo8dfEDe8=;
        b=N2T2tqO9pLHukp8hEqYRoUvafrKkKeGPVrrZ77ad1pUaszdWdDhlOc1fPwubwvV1Wl
         Pf8HBoz+LU0XiymCyBzsa2H4FOMO2UB9MT3O2rUvQOTPZfcY0nlidUym9abYg0MTkoQ2
         wsI4vHQzznrK1s2bDd/DVbw0AFn3FG1bZjpJi1JWj6iJfSyxlRU2suAQZKCTzoOPRvDZ
         HEztZZxjJ5cq5AwEpDIij0vJ1CNwUOlSF3r3f904gE5VmVA5YUJN7jWGmb6qV6Zk46I/
         VsWOmkkcM9/EqkA/us/fdNKcDeiF1VFK0D2kIgnO98N4fSatoYKrbYPEeoevNFeOI4mB
         zgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fGOHtPvcjQ3mSuxQl3i9SrO/790cDVD9LJUo8dfEDe8=;
        b=rJnvxfXCGXjzfBLsXKImSGOyxzTPoOa68zuhDE3VBXjENZa28aOPH6Y/5/XLr7SnWr
         4as9nKV5hLzaE9jOPLEWhBwcJ7DVw/04UyTO6cZgWcRMGoOWg6Z2xUNvId3IJBLkFKeR
         R9MOzwKw077TchTFwun3oHuCOVneVlFpDCAnvbDgeH2CnNHUhUtQ9GVMejswu6xDC4l5
         eW5mOLhxzl3F0Go//ybWDgJplKY3v8iVuvRj/NX/axKf2bUuaZ98aNXAf9qRz24P9lKP
         MvisjkiN76DgnyK34nWE2+l8S3ubRPVApmthMYjVKT+e23Fjpl8S0Ta4Yv2vFyiv6uAp
         dOyw==
X-Gm-Message-State: APjAAAWKB3l8tTcV0iHOPtM70vh6yLqgz8UyuW3utSLjI7XSvHANYmel
        XqD6TwVRrqCNeXXlZ5foyyiEGgL3
X-Google-Smtp-Source: APXvYqwEY4Z/kg+i48d66iosutfopfOm/oS8zkFL6aMW8b1Rpt8lS5a3mW5R6tvsJN9tTKph7Brn/Q==
X-Received: by 2002:a50:b5c3:: with SMTP id a61mr29349119ede.31.1555061840565;
        Fri, 12 Apr 2019 02:37:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i8sm11861976eda.1.2019.04.12.02.37.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 02:37:20 -0700 (PDT)
Date:   Fri, 12 Apr 2019 02:37:20 -0700 (PDT)
X-Google-Original-Date: Fri, 12 Apr 2019 09:37:11 GMT
Message-Id: <017ec9a0c74c770a42843eef65f49b7cc4397728.1555061837.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.167.v2.git.gitgitgadget@gmail.com>
References: <pull.167.git.gitgitgadget@gmail.com>
        <pull.167.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 2/8] tests (rebase): spell out the `--force-rebase` option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
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

