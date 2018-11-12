Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABB411F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 13:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbeKLXmB (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 18:42:01 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38099 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729460AbeKLXmB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 18:42:01 -0500
Received: by mail-pf1-f195.google.com with SMTP id v76-v6so1539917pfa.5
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 05:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GRvGJNcAjqDHObFuhezZ2nc2us/1D+U4papYNCoBuNE=;
        b=T18JVX4R9KNfGeZO/ppGqxV3xjs1iyFCSpdfcGJ3gcuHkuSQpn7NuzEH2/LA9vVuoJ
         yAuu9MBc2GYTaecYjlfc8rx2fP0cJ+ROAWOEwLpeHArB1+EA43jX0XVYHzHsaeb2u1cA
         h1bLgJ36cBq6IA42+0EwFuALAjfYpqISK3ApkxH+tGlaTyRSGE/dwwWQ3ka2+dXDNenV
         XOVL1V33GsL25o5trDKETIZy4G9RdeRE1jM7qWEisAEpIh/YZgs7lYs9X6PPgNkwu4Ke
         JUqd771KyiEgeLvaLVVOR+w3EGtkCO3YWcVqOQJY346PwrFwZEeQhV3kgck5apLumOxn
         uwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GRvGJNcAjqDHObFuhezZ2nc2us/1D+U4papYNCoBuNE=;
        b=kZZP4snISjpDwQ/pchuoug6OGr4E1E+g6eYZj/wVh37blkplcuI3ndHhg+rmIQRVbV
         1BmnrRzdqt6K1lq6fJHL6AxWk30d+69v/QrfqbVODjBMM3Nus06y+qEH+/MUwntw/dGW
         ADiU71baVJ5EC0lToTRe3SRFUMnZb/5xw2eGPlLncJeh8F7edBVbUYhqL0Gl1/ZgaQFZ
         WDjcs1Dkm1yLlXWDDIrPAiaH6nbaqhE2rW0S5GU0wac/cqF7UzIxrCKX4C3faBOTuGE0
         nqJP+lnxDfFIXfgMc3XR44zc8gC855fl6IfZTkU4m0TdVk+70lfT7MhpzVeX79KbD5Vy
         3sEA==
X-Gm-Message-State: AGRZ1gL7xr0mMB5K2nRyWyQ8FQ2vj+SfgtHkWLhHw68xCV/A6ZYtKuJj
        AcELqCcXNo7NnzR+LDFUTx3WnnVo
X-Google-Smtp-Source: AJdET5fzWHOcG5fWCgP5EQr6NsezcnwCIa1qXPrQiD6HLP9Cx20ySuWhPYl0bLsQZ7J7QZL00Y5HWw==
X-Received: by 2002:a63:5442:: with SMTP id e2-v6mr909778pgm.316.1542030519176;
        Mon, 12 Nov 2018 05:48:39 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id p5-v6sm13712735pfb.109.2018.11.12.05.48.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 05:48:38 -0800 (PST)
Date:   Mon, 12 Nov 2018 05:48:38 -0800 (PST)
X-Google-Original-Date: Mon, 12 Nov 2018 13:48:29 GMT
Message-Id: <cd314e1384312cd5b0c0031efd40c6442074e11c.1542030510.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.73.git.gitgitgadget@gmail.com>
References: <pull.73.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 5/5] tests: explicitly use `git.exe` on Windows
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

In the bin-wrappers/* scripts, we already take pains to use `git.exe`
rather than `git`, as this could pick up the wrong thing on Windows
(i.e. if there exists a `git` file or directory in the build directory).

Now we do the same in the tests' start-up code.

This also helps when testing an installed Git, as there might be even
more likely some stray file or directory in the way.

Note: the only way we can record whether the `.exe` suffix is by writing
it to the `GIT-BUILD-OPTIONS` file and sourcing it at the beginning of
`t/test-lib.sh`. This is not a requirement introduced by this patch, but
we move the call to be able to use the `$X` variable that holds the file
extension, if any.

Note also: the many, many calls to `git this` and `git that` are
unaffected, as the regular PATH search will find the `.exe` files on
Windows (and not be confused by a directory of the name `git` that is
in one of the directories listed in the `PATH` variable), while
`/path/to/git` would not, per se, know that it is looking for an
executable and happily prefer such a directory.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile                |  1 +
 t/test-lib-functions.sh |  2 +-
 t/test-lib.sh           | 13 +++++++++----
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index bbfbb4292d..5df0118ce9 100644
--- a/Makefile
+++ b/Makefile
@@ -2590,6 +2590,7 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@+
 	@echo PAGER_ENV=\''$(subst ','\'',$(subst ','\'',$(PAGER_ENV)))'\' >>$@+
 	@echo DC_SHA1=\''$(subst ','\'',$(subst ','\'',$(DC_SHA1)))'\' >>$@+
+	@echo X=\'$(X)\' >>$@+
 ifdef TEST_OUTPUT_DIRECTORY
 	@echo TEST_OUTPUT_DIRECTORY=\''$(subst ','\'',$(subst ','\'',$(TEST_OUTPUT_DIRECTORY)))'\' >>$@+
 endif
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 801cc9b2ef..c167b2e1af 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -900,7 +900,7 @@ test_create_repo () {
 	mkdir -p "$repo"
 	(
 		cd "$repo" || error "Cannot setup test environment"
-		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git" init \
+		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" init \
 			"--template=$GIT_BUILD_DIR/templates/blt/" >&3 2>&4 ||
 		error "cannot run git init -- have you built things yet?"
 		mv .git/hooks .git/hooks-disabled
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1ea20dc2dc..3e2a9ce76d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -49,18 +49,23 @@ export ASAN_OPTIONS
 : ${LSAN_OPTIONS=abort_on_error=1}
 export LSAN_OPTIONS
 
+if test ! -f "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
+then
+	echo >&2 'error: GIT-BUILD-OPTIONS missing (has Git been built?).'
+	exit 1
+fi
+. "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
+export PERL_PATH SHELL_PATH
+
 ################################################################
 # It appears that people try to run tests without building...
-test -n "$GIT_TEST_INSTALLED" || "$GIT_BUILD_DIR/git" >/dev/null ||
+test -n "$GIT_TEST_INSTALLED" || "$GIT_BUILD_DIR/git$X" >/dev/null ||
 if test $? != 1
 then
 	echo >&2 'error: you do not seem to have built git yet.'
 	exit 1
 fi
 
-. "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
-export PERL_PATH SHELL_PATH
-
 # if --tee was passed, write the output not only to the terminal, but
 # additionally to the file test-results/$BASENAME.out, too.
 case "$GIT_TEST_TEE_STARTED, $* " in
-- 
gitgitgadget
