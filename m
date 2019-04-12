Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B80720248
	for <e@80x24.org>; Fri, 12 Apr 2019 09:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfDLJhX (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 05:37:23 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41285 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfDLJhV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 05:37:21 -0400
Received: by mail-ed1-f66.google.com with SMTP id g6so3788688edc.8
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 02:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fSib6Aueo4f2tH0P/GdTW+1ikI+DVkU702AgxIHCrso=;
        b=jRpBrpSGyjbtF5qi/W97m8Jr/U1S026Wxvm0pSe6GeHQdLBCQbLCOZaEVb603ZYsKw
         qAkSB1EzVBPad10LdQeYyZ4hiT9COaGaX13+qgEx7IWs3oG8FwhW2wvdgD5McJEDyl9k
         TFJs6Q/exPntvqFIdhv4LANJ3yXGpccppFkvpCuOnP4UV4lT2IhBlw4Q6UlScDrebrK5
         Q9UkNPRu7O2r5UjK6w02ISRRf9zDWgdfETEqPJ+NDTWbDqVp3Flq30KDJ19NlJ4Z8Ms0
         1x15g2Qp2HhLK5Dhryehd+HMwK4n1D0ATy9RR+jJdG8jK6Ox+ZTEiRrEqnH7m9MPpjEi
         BlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fSib6Aueo4f2tH0P/GdTW+1ikI+DVkU702AgxIHCrso=;
        b=jodfLZ86Q3jlrSl3uUQE51J9VlebAb+mZzT5007wx1a/eBUOCw6uR1ZiSTCq0Qscen
         qI8kjR9+vN2whCE/bMHCmGOGrQpRmTJUXeAwh+KBQyizlQy4QJwACK2FKoHiupONcBiW
         UxOyodImw6VV2eVmml27ZogqBzbX7uFKvOYuaF+I/jyx72+rkQ8MSQZ3LsBfkXCSj3v2
         5dzzFAy6wvtD2epExuKUHP6JcsnaO+wXFoL3SommhV6QHjSesCxf0/gQZRZnO1oS9ta0
         6IZZBad2yZuthNhySi54PcoIbvjeQZ6oqsSesxE+o4hvJJoOr3zslYqpw4Xk6KxwfnWC
         qoSw==
X-Gm-Message-State: APjAAAWq/Btcy4j2RADErzxgwyxl8q2r4j3NZr2YHjeD8GUw48UV0DBs
        dqbn4+yMNuY/7MfL4Sa3AAgxoc/m
X-Google-Smtp-Source: APXvYqyeSWbg5a7JiFuTN/HGkgvLUm4AckY/d0M5OVPiLheZgmz9DNabRvbRmTDG0engN4HjjdtvYw==
X-Received: by 2002:a17:906:e241:: with SMTP id gq1mr9338164ejb.5.1555061839766;
        Fri, 12 Apr 2019 02:37:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p13sm4106099edx.96.2019.04.12.02.37.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 02:37:19 -0700 (PDT)
Date:   Fri, 12 Apr 2019 02:37:19 -0700 (PDT)
X-Google-Original-Date: Fri, 12 Apr 2019 09:37:10 GMT
Message-Id: <a1b4b74b9167e279dae4cd8c58fb28d8a714a66a.1555061837.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.167.v2.git.gitgitgadget@gmail.com>
References: <pull.167.git.gitgitgadget@gmail.com>
        <pull.167.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/8] tests (rebase): spell out the `--keep-empty` option
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

This test wants to run `git rebase` with the `--keep-empty` option, but
it really only spelled out `--keep` and trusted Git's option parsing to
determine that this was a unique abbreviation of the real option.

However, Denton Liu contributed a patch series in
https://public-inbox.org/git/cover.1553354374.git.liu.denton@gmail.com/
that introduces a new `git rebase` option called `--keep-base`, which
makes this previously unique abbreviation non-unique.

Whether this patch series is accepted or not, it is actually a bad
practice to use abbreviated options in our test suite, because of the
issue that those unique option names are not guaranteed to stay unique
in the future.

So let's just not use abbreviated options in the test suite.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5407-post-rewrite-hook.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
index a4a5903cba..7344253bfb 100755
--- a/t/t5407-post-rewrite-hook.sh
+++ b/t/t5407-post-rewrite-hook.sh
@@ -131,7 +131,7 @@ test_expect_success 'git rebase -m --skip' '
 test_expect_success 'git rebase with implicit use of interactive backend' '
 	git reset --hard D &&
 	clear_hook_input &&
-	test_must_fail git rebase --keep --onto A B &&
+	test_must_fail git rebase --keep-empty --onto A B &&
 	echo C > foo &&
 	git add foo &&
 	git rebase --continue &&
@@ -146,7 +146,7 @@ test_expect_success 'git rebase with implicit use of interactive backend' '
 test_expect_success 'git rebase --skip with implicit use of interactive backend' '
 	git reset --hard D &&
 	clear_hook_input &&
-	test_must_fail git rebase --keep --onto A B &&
+	test_must_fail git rebase --keep-empty --onto A B &&
 	test_must_fail git rebase --skip &&
 	echo D > foo &&
 	git add foo &&
-- 
gitgitgadget

