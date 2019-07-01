Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 581541F4B6
	for <e@80x24.org>; Mon,  1 Jul 2019 13:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbfGANMo (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 09:12:44 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:41647 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbfGANLy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 09:11:54 -0400
Received: by mail-ed1-f46.google.com with SMTP id p15so23430694eds.8
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 06:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MOFIuzVUEWDvxwACbnEAaAdJ0v4d0KiO9ZgPlfd0bx8=;
        b=OO8Cfun/tPF5rBwDEJjGiIpPw42SXiF1ENqgkWZgzRipSa+UC9t6wb0k8imq8nz0nV
         N2dTx1YpJ1k6XEnDDGHa1ux1h2ZuDjClAPT8wqkAV+HlXTufiarUrNwqMunQojhY6mqe
         UNaKmGbLoI2DAYQET2WS88zxkOCte1bHFqAah7YLNBFPYw4zIKiAuuEZFBFdXT58rOiW
         uzXnItKn2U72lmScz/MYSk2lWgWG/xTGnfKAbk8zpZvb9jyKkN/mkoRQXrsFjoOH1/+E
         NzFjoqiekBPPkoBxbu6Lcmiul5oixhCd9o0JjFE6om5pQWtSzCIyACgtrrizF8zsJH0L
         g3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MOFIuzVUEWDvxwACbnEAaAdJ0v4d0KiO9ZgPlfd0bx8=;
        b=F7QV79DEnQLgpVYjmJ+y0NT521hXVGYvz9fWkBycfSdbySlU91XfMbihWRa+eGbLlg
         tvhyuJnQ93jD9IfO+PPFVkmUEv4dg0Jq5sRpbSwe17goQ4wtcuZDvpmKg5+nAIuVIZtt
         N4YlMZy8ohSbDIAsOQcGDkbrH780qknhqaPK1gJTDsYJGvMFfMt//0HTEhXuJR5YwKvQ
         QkQzQKgl/2OkUBq03qN0dOG8q86UtCg21fXwNfr+PbAzruM3PhTbUh4T21k733HJ8a9T
         xchp4D1gAZ3EjZ7w7UFJ5plS65hTopd8SuJkW2LO+jf9p6OhOLbJN6pzCe7z5abwm8Vm
         Bk4Q==
X-Gm-Message-State: APjAAAWYekJohmksnuEVX853UQbxKuXg5r283NxkXNjXFNAcwtN2/18U
        P/gGSGJRL5/Z2MD2waY2HT5rbc+2
X-Google-Smtp-Source: APXvYqzr/Z56d8GegSMyWRVN47Fxlm2sDZVzgBhayJnCjC9oVKe4O/N2yklu9HVJLDp4nHMHN/bUAg==
X-Received: by 2002:a17:906:470a:: with SMTP id y10mr22780161ejq.115.1561986712534;
        Mon, 01 Jul 2019 06:11:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o22sm3677705edc.37.2019.07.01.06.11.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 06:11:52 -0700 (PDT)
Date:   Mon, 01 Jul 2019 06:11:52 -0700 (PDT)
X-Google-Original-Date: Mon, 01 Jul 2019 13:11:50 GMT
Message-Id: <52501623f6b47447ce5da283ec11e378413899b7.1561986710.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.276.git.gitgitgadget@gmail.com>
References: <pull.276.git.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] t3420: remove progress lines before comparing output
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
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
 t/t3420-rebase-autostash.sh | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index 9186e90127..0454018584 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -48,8 +48,8 @@ create_expected_success_interactive () {
 	q_to_cr >expected <<-EOF
 	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
 	HEAD is now at $(git rev-parse --short feature-branch) third commit
-	Rebasing (1/2)QRebasing (2/2)QApplied autostash.
-	Q                                                                                QSuccessfully rebased and updated refs/heads/rebased-feature-branch.
+	Applied autostash.
+	Successfully rebased and updated refs/heads/rebased-feature-branch.
 	EOF
 }
 
@@ -67,13 +67,13 @@ create_expected_failure_am () {
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
 
@@ -109,7 +109,8 @@ testrebase () {
 			suffix=interactive
 		fi &&
 		create_expected_success_$suffix &&
-		test_i18ncmp expected actual
+		sed "$(printf "s/.*\\r//")" <actual >actual2 &&
+		test_i18ncmp expected actual2
 	'
 
 	test_expect_success "rebase$type: dirty index, non-conflicting rebase" '
@@ -209,7 +210,8 @@ testrebase () {
 			suffix=interactive
 		fi &&
 		create_expected_failure_$suffix &&
-		test_i18ncmp expected actual
+		sed "$(printf "s/.*\\r//")" <actual >actual2 &&
+		test_i18ncmp expected actual2
 	'
 }
 
-- 
gitgitgadget
