Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF6D31F461
	for <e@80x24.org>; Thu,  4 Jul 2019 09:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfGDJrF (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jul 2019 05:47:05 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:47062 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbfGDJrE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jul 2019 05:47:04 -0400
Received: by mail-ed1-f47.google.com with SMTP id d4so4815615edr.13
        for <git@vger.kernel.org>; Thu, 04 Jul 2019 02:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=P+sm9/M+cNYaFTsruCLrWtUIpOyRvnHB/7dklHb+2p4=;
        b=Vpe96jfYkXoMNBM8vwMVHTZiYY9hDQ6XYV1v/iavyKOD67A3xKLI0rcOvIrFXDeDJj
         u2ZpreMJPZd1unn06ls+804PX39OjcwS6FpXOQyK5Lt3FxwVCBcdrnYtWbev6ReqJBoA
         bAqE0bYPGosT0JI9Mn8WWqJelN3cO/KZME/X2dyYD+DdJeCXSuX/SZ0vd+zNu4qIUwSW
         c+OnX6Lr30aKhbNqi3COAhGVQmu8ATnqM3YwTGDxzBCpgWArdkCw0faHUE0hUp0wf7uf
         sTzKnF2RnF+t2X3cD6SXpnUQbhz7JZt6OMl6e0LCUQj8XXX7Qg2vpgn3Gtn/c7ELEhX4
         0tQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=P+sm9/M+cNYaFTsruCLrWtUIpOyRvnHB/7dklHb+2p4=;
        b=TJ2YB2STyAGL5T+ET2yhAmSovOPGm7M6cPKrpjX8hcUoMDc718t4IwVwcSb3mN+ILE
         1p0K3S/6ZJMYOo9kXQYBhpc9KFoi2Wll4BsMrCeRrgg1mSnkBsYjmyqJtfZxabXYW2NH
         i+as86FcUPrL76GkCjWgP0GeU89PyBsXvaPw3CREZ9Al+nsohYw8a6rtJw9qDq7rhEc2
         8/AyZwleCtuG+E7Cj2hV8MrRrgs4pxrDqH1DwMslkDuLjEZjO5i/Lwj2bSob2v1tFUHV
         jnIYCjI3kAqqSt9vDIexzmVwhtq5EIsfvJoynX7pJLjfyF9dLbFF/TohRs5sIk1LuOap
         Tw1w==
X-Gm-Message-State: APjAAAU3WgALX/X7HaWN8zmq4lg9RGfDiPr6RoQGgjbSJqG1BoAvOkSV
        QfVK7s1fasF/y3EE6j+YkhV4qmAP
X-Google-Smtp-Source: APXvYqyMtDXS/ifn1uVXVjuoXvkvG8+ut2zlGVxl1fC1FTVWOlf98j4T2rkr3obj6f6wYZG11amLsQ==
X-Received: by 2002:a50:aeaa:: with SMTP id e39mr46827553edd.190.1562233622572;
        Thu, 04 Jul 2019 02:47:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m39sm1544504edm.96.2019.07.04.02.47.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 02:47:02 -0700 (PDT)
Date:   Thu, 04 Jul 2019 02:47:02 -0700 (PDT)
X-Google-Original-Date: Thu, 04 Jul 2019 09:47:00 GMT
Message-Id: <e1b4023bc0e606079547f7a7562a283009e69530.1562233620.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.276.v2.git.gitgitgadget@gmail.com>
References: <pull.276.git.gitgitgadget@gmail.com>
        <pull.276.v2.git.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/1] t3420: remove progress lines before comparing output
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Some of the tests check the output of rebase is what we expect. These
were added after a regression that added unwanted stash output when
using --autostash. They are useful as they prevent unintended changes to
the output of the various rebase commands. However they also include all
the progress output which is less useful as it only tests what would be
written to a dumb terminal which is not the normal use case. The recent
changes to fix clearing the line when printing progress necessarily
meant making an ugly change to these tests. Address this my removing the
progress output before comparing it to the expected output. We do this
by removing everything before the final "\r" on each line as we don't
care about the progress indicator, but we do care about what is printed
immediately after it.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3420-rebase-autostash.sh | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index 9186e90127..b8f4d03467 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -30,7 +30,8 @@ test_expect_success setup '
 	echo conflicting-change >file2 &&
 	git add . &&
 	test_tick &&
-	git commit -m "related commit"
+	git commit -m "related commit" &&
+	remove_progress_re="$(printf "s/.*\\r//")"
 '
 
 create_expected_success_am () {
@@ -48,8 +49,8 @@ create_expected_success_interactive () {
 	q_to_cr >expected <<-EOF
 	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
 	HEAD is now at $(git rev-parse --short feature-branch) third commit
-	Rebasing (1/2)QRebasing (2/2)QApplied autostash.
-	Q                                                                                QSuccessfully rebased and updated refs/heads/rebased-feature-branch.
+	Applied autostash.
+	Successfully rebased and updated refs/heads/rebased-feature-branch.
 	EOF
 }
 
@@ -67,13 +68,13 @@ create_expected_failure_am () {
 }
 
 create_expected_failure_interactive () {
-	q_to_cr >expected <<-EOF
+	cat >expected <<-EOF
 	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
 	HEAD is now at $(git rev-parse --short feature-branch) third commit
-	Rebasing (1/2)QRebasing (2/2)QApplying autostash resulted in conflicts.
+	Applying autostash resulted in conflicts.
 	Your changes are safe in the stash.
 	You can run "git stash pop" or "git stash drop" at any time.
-	Q                                                                                QSuccessfully rebased and updated refs/heads/rebased-feature-branch.
+	Successfully rebased and updated refs/heads/rebased-feature-branch.
 	EOF
 }
 
@@ -109,7 +110,8 @@ testrebase () {
 			suffix=interactive
 		fi &&
 		create_expected_success_$suffix &&
-		test_i18ncmp expected actual
+		sed "$remove_progress_re" <actual >actual2 &&
+		test_i18ncmp expected actual2
 	'
 
 	test_expect_success "rebase$type: dirty index, non-conflicting rebase" '
@@ -209,7 +211,8 @@ testrebase () {
 			suffix=interactive
 		fi &&
 		create_expected_failure_$suffix &&
-		test_i18ncmp expected actual
+		sed "$remove_progress_re" <actual >actual2 &&
+		test_i18ncmp expected actual2
 	'
 }
 
-- 
gitgitgadget
