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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B8361F461
	for <e@80x24.org>; Thu, 18 Jul 2019 09:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389532AbfGRJag (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 05:30:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42441 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfGRJaf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 05:30:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id x1so12883902wrr.9
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 02:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=SFXdxdNj8J1lGeeY65TFvLsYxrsStLqU0vsJjZnwxcA=;
        b=B767BsGwEgcNcKgaqsg7N3zqmOUJXHG6bnD89fojCFTc9E4Jd5Czb6Si2rDE8mJfN5
         ERzj0M31KoQxDXJ54gJDnSnI5CUqIV+k6CDTYGHlZLiOvc+ZVF7p+QIApO0RY+QimJm5
         5Al6MrgQI+LhgmzHpeZpM9ZqWg+rLlwOia6BFza4ysGWfnb5L8Y7CWUxq2UvQfhUXRP3
         7fs57EIfaJMBiij6ZwEnNh+tjME+tSdUukHGdR+hry/Ld2MM+sfyd+67Lwb/oFQF88jw
         GLRD7txYT2MPVuoOupTsU6qPseyfTAsw4I6dntmocre0y5CzRhb8QYgjgw7nzFAYbvni
         GjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=SFXdxdNj8J1lGeeY65TFvLsYxrsStLqU0vsJjZnwxcA=;
        b=LzFfggFK65fOcwvSO6RwAOZrQcdlWVLPEkdQzdGyg/9EghMP4mZmfTI2q585LGWvkJ
         uSQCHqv1FRzoW9Nctt7ccRk491oDVD45WuPu+Ex1LvkE+d2xIg3/YQi2RG+Rxf4yC7mM
         YZcao/BvDbH98Z/pk70guDzlrGpr+U3+TIVAiaHP04NimFeeACp+PNIQ/MXEXSkup7oN
         +ZJDX66GrcTF0MGWFnRbaAGKSav5GuanoGlDP1a1PuAN4KvxoQF9rTUu3ZfwWWFRa6lW
         Q29uM6Wycb5QBBOcarWmwNM11YqJ0Kw/lVaO09QP4Qeg3F8mtAX2U7gNhlKTJ4wtZvSI
         HVfg==
X-Gm-Message-State: APjAAAW+lweF4LqzRx8sNf7JBa0eTBp2kfqn+znM4W13w6FGMZkwYwHF
        mxVvBzyRFbDs6k75874+uPLxLFRp
X-Google-Smtp-Source: APXvYqz85QZ4y5IteF0Beal14aJmmYlcedpN9yG1OiC1uJsYffo7h6Qh7WAV78LByfWrQnhwYOgeWw==
X-Received: by 2002:adf:e444:: with SMTP id t4mr46146060wrm.262.1563442233664;
        Thu, 18 Jul 2019 02:30:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o185sm25706149wmo.45.2019.07.18.02.30.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 02:30:33 -0700 (PDT)
Date:   Thu, 18 Jul 2019 02:30:33 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Jul 2019 09:30:31 GMT
Message-Id: <c7b11fe410196c14e142756a036e2bdae5d4bcab.1563442231.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.219.v2.git.gitgitgadget@gmail.com>
References: <pull.219.git.gitgitgadget@gmail.com>
        <pull.219.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/1] clean: show an error message when the path is too long
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe_=3Cl=2Es=2Er=40web=2Ede=3E=2C_SZEDER_G=C3=A1bor?= 
        <szeder.dev@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Without an error message when `lstat()` failed, `git clean` would
abort without an error message, leaving the user quite puzzled.

In particular on Windows, where the default maximum path length is quite
small (yet there are ways to circumvent that limit in many cases), it is
very important that users be given an indication why their command
failed because of too long paths when it did.

This test case makes sure that a warning is issued that would have
helped the user who reported this issue:

	https://github.com/git-for-windows/git/issues/521

Note that we temporarily set `core.longpaths = false` in the regression
test; This ensures forward-compatibility with the `core.longpaths`
feature that has not yet been upstreamed from Git for Windows.

Helped-by: René Scharfe <l.s.r@web.de>
Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/clean.c  |  3 ++-
 t/t7300-clean.sh | 12 ++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index aaba4af3c2..d5579da716 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -34,6 +34,7 @@ static const char *msg_would_remove = N_("Would remove %s\n");
 static const char *msg_skip_git_dir = N_("Skipping repository %s\n");
 static const char *msg_would_skip_git_dir = N_("Would skip repository %s\n");
 static const char *msg_warn_remove_failed = N_("failed to remove %s");
+static const char *msg_warn_lstat_failed = N_("could not lstat %s\n");
 
 enum color_clean {
 	CLEAN_COLOR_RESET = 0,
@@ -194,7 +195,7 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 		strbuf_setlen(path, len);
 		strbuf_addstr(path, e->d_name);
 		if (lstat(path->buf, &st))
-			; /* fall thru */
+			warning_errno(_(msg_warn_lstat_failed), path->buf);
 		else if (S_ISDIR(st.st_mode)) {
 			if (remove_dirs(path, prefix, force_flag, dry_run, quiet, &gone))
 				ret = 1;
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 7b36954d63..a2c45d1902 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -669,4 +669,16 @@ test_expect_success 'git clean -d skips untracked dirs containing ignored files'
 	test_path_is_missing foo/b/bb
 '
 
+test_expect_success MINGW 'handle clean & core.longpaths = false nicely' '
+	test_config core.longpaths false &&
+	a50=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa &&
+	mkdir -p $a50$a50/$a50$a50/$a50$a50 &&
+	: >"$a50$a50/test.txt" 2>"$a50$a50/$a50$a50/$a50$a50/test.txt" &&
+	# create a temporary outside the working tree to hide from "git clean"
+	test_must_fail git clean -xdf 2>.git/err &&
+	# grepping for a strerror string is unportable but it is OK here with
+	# MINGW prereq
+	test_i18ngrep "too long" .git/err
+'
+
 test_done
-- 
gitgitgadget
