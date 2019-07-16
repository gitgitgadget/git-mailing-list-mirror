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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AC811F461
	for <e@80x24.org>; Tue, 16 Jul 2019 14:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387748AbfGPOE0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jul 2019 10:04:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51783 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbfGPOE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jul 2019 10:04:26 -0400
Received: by mail-wm1-f67.google.com with SMTP id 207so18814225wma.1
        for <git@vger.kernel.org>; Tue, 16 Jul 2019 07:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0Eulgdaa4jPOw19Ews0mOMFCmwkyUJyJMxnlBRsKc6Q=;
        b=Jyr5WdhGMwlCwslLJAv8xUXuIZQOCMahGY4gnm4diAm5xa/NxH1Ztvj0B3meX7fy+2
         giH1ho9TiAPNdQp4lh3lhnmoijlWcxC2ihnED0SB2A52apES48Psvjnnnvc/h2LVP4bn
         XOxO3lr830+ITkkRu5v1bZQLL0vneXg7tLCYYmfyL6SrlWykALCh/FSgJM0CMy6pDeMr
         agdWgs7zrfKzA9IruukhjKnhgTLuKTBAaTfGFhS1gMq6afBvR0/Zjtkld7tfQz+JHF2b
         NRTk4qfisw6vRPJzRZUsvGb2gM/DWdMzm71Jtsi6MRA/fyjLN9o7xH1jivhX/3+KR0GJ
         ZLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0Eulgdaa4jPOw19Ews0mOMFCmwkyUJyJMxnlBRsKc6Q=;
        b=ZEQ1ZsUwzk+QE8D87hq2E7eL9jDzXF5iYkFe3F/LPEQIqF+5R+/61l+R21Mxz784LR
         l/ZqpHx6nbvDw/W4A/D02jeOG4ZlbPDb7RYbL2VkmRl60gcfzNyFFg/TzjMR0aexbeih
         guVzkxJPpCR1K30ETrbXgeFPwHiV5y8CO6P9KwtaDBzepy5MliTipItVDei0bEOINkj8
         J3Dh/2lhMPIeYObMxtQdYKsShaYV1IHm1pdkDuTMSZaXD0BoIy2kFb82PLMrehi3qJJH
         HvV51fYk6dx7Vy8gxAkAdvAQF8iGldTO6UtkIEf+Dwtk3c81eEdTPB7aMTqpY2zj3hLz
         DY0A==
X-Gm-Message-State: APjAAAW9Q7Hnm2m4HMoU3+WDGTezYhiFv2Wqz/xENivAox1mRpvmRF7o
        Wc50rrtaTfC63r1JyXorxxPXryKr
X-Google-Smtp-Source: APXvYqz7pXoNXYlpxYG4fN2yBJfHe+5eOzbSObgFn5vO6DtDUVX7VSKQoxMvvE8IaIowLPP75VPLpA==
X-Received: by 2002:a7b:cd09:: with SMTP id f9mr29221938wmj.64.1563285864146;
        Tue, 16 Jul 2019 07:04:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y12sm17731795wrm.79.2019.07.16.07.04.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 07:04:23 -0700 (PDT)
Date:   Tue, 16 Jul 2019 07:04:23 -0700 (PDT)
X-Google-Original-Date: Tue, 16 Jul 2019 14:04:22 GMT
Message-Id: <36677556a26cca9eafd859c88aa9b2c5a6cde309.1563285862.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.219.git.gitgitgadget@gmail.com>
References: <pull.219.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] clean: show an error message when the path is too long
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

Without an error message when stat() failed, e.g. `git clean` would
abort without an error message, leaving the user quite puzzled.

In particular on Windows, where the default maximum path length is quite
small (yet there are ways to circumvent that limit in many cases), it is
very important that users be given an indication why their command
failed because of too long paths when it did.

This test case makes sure that a warning is issued that would have
helped the user who reported this issue:

	https://github.com/git-for-windows/git/issues/521

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/clean.c  |  3 ++-
 t/t7300-clean.sh | 11 +++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index aaba4af3c2..7be689f480 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -194,7 +194,8 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 		strbuf_setlen(path, len);
 		strbuf_addstr(path, e->d_name);
 		if (lstat(path->buf, &st))
-			; /* fall thru */
+			warning("Could not stat path '%s': %s",
+				path->buf, strerror(errno));
 		else if (S_ISDIR(st.st_mode)) {
 			if (remove_dirs(path, prefix, force_flag, dry_run, quiet, &gone))
 				ret = 1;
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 7b36954d63..aa08443f6a 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -669,4 +669,15 @@ test_expect_success 'git clean -d skips untracked dirs containing ignored files'
 	test_path_is_missing foo/b/bb
 '
 
+test_expect_success MINGW 'handle clean & core.longpaths = false nicely' '
+	git config core.longpaths false &&
+	test_when_finished git config --unset core.longpaths &&
+	a50=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa &&
+	mkdir -p $a50$a50/$a50$a50/$a50$a50 &&
+	touch $a50$a50/test.txt &&
+	touch $a50$a50/$a50$a50/$a50$a50/test.txt &&
+	test_must_fail git clean -xdf 2>.git/err &&
+	grep "too long" .git/err
+'
+
 test_done
-- 
gitgitgadget
