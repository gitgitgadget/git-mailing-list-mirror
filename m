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
	by dcvr.yhbt.net (Postfix) with ESMTP id 52DD41F462
	for <e@80x24.org>; Mon,  3 Jun 2019 20:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfFCUS0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 16:18:26 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37352 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfFCUSY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 16:18:24 -0400
Received: by mail-ed1-f65.google.com with SMTP id w13so1953210eds.4
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 13:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=27s+rbHdkAdNzKgKgbTjlL1emWCnj+0/JsTVWXnAlWk=;
        b=ruMi1Dt7x1/nbuvnSEWEdhwMIeMCP7h8a+NAdKrC3u+beqaYPkKm0Vr58fsRwDcgVm
         dUL8KK425BCWgPSpC2IfwQ6NQ+UW/GTl6+Hw95Sw5gUZK10oPV/4HjnUg8Wv2YupWkwe
         uoQPsIQ8VrgfW6PnYeTUZRMb31dBJGETtokcCyGgcJ11w6tbhIy/F/bUBit0TiUbxXTp
         V0HRm3n1XkRwIkdPfFK6CRegotMGMuzULaD9t2a+8BIv0OGwcOyKJ5YhmgeR7Hqd6Q1I
         cz9rmmqZQyzi3JhR0C+QMZnvFQMbKa6SES/g6RuQe/9wrzrwc2DQW7ZgsAaPPp0cG4/i
         2vMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=27s+rbHdkAdNzKgKgbTjlL1emWCnj+0/JsTVWXnAlWk=;
        b=SnA/pq693kDZloGLvvmGN7AcV4RJKJZUCu+oGDs5D5fnMUW4XUARNkyi8IJyShCjFu
         7tOCTAvwEYQcCX934sAqWrNsubRWvbh+KnTaYLtmJ9yNHQZ09brbpF3mTMVEDESPKa+b
         uDjfxSsjkDuLgXxck/ygCbjFAMXVFNfkskUExfYRFYQYWyucQxOWsWShshldcGITeoVt
         iXPUJ9m+2WXrP5O0q1pDLBVRLPMCTR8nv99kTdx/3UxDISlD/4FJ36n4HxQIfsFs9Dcb
         rujHqUhLknPbwU+zcDsIazZ6XiKAlE8wJrCByXjXzeyHrs/ePmu+ZTE4b0raxxZHfokm
         Dwlw==
X-Gm-Message-State: APjAAAWRlYIL5uhvO+gJDK+4d8zFybItUV53d9tRORIQkcNp4oFqcCC+
        T+8xL78QiRGDTjRK8WdkUtKHGSBt
X-Google-Smtp-Source: APXvYqwaWVgR5mh7Jf49qG4c2ZZ4T3Z/fZmUxf/xYv3YR7223DHKe1TfKaPhXVdJUOt7FFSw01h7vA==
X-Received: by 2002:a50:9e6c:: with SMTP id z99mr30976338ede.298.1559593102011;
        Mon, 03 Jun 2019 13:18:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f9sm2766216ejt.18.2019.06.03.13.18.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 13:18:21 -0700 (PDT)
Date:   Mon, 03 Jun 2019 13:18:21 -0700 (PDT)
X-Google-Original-Date: Mon, 03 Jun 2019 20:18:10 GMT
Message-Id: <671cf092fd549486f668b9f0f353dd595c0e3afc.1559593097.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.254.git.gitgitgadget@gmail.com>
References: <pull.254.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 04/11] status: add status.aheadbehind setting
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add "status.aheadbehind" config setting to change the default
behavior of ALL git status formats.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/status.txt |  5 +++++
 builtin/commit.c                | 17 ++++++++++++++++-
 t/t6040-tracking-info.sh        | 31 +++++++++++++++++++++++++++++++
 t/t7064-wtstatus-pv2.sh         |  4 ++++
 4 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/status.txt b/Documentation/config/status.txt
index ed72fa7dae..0fc704ab80 100644
--- a/Documentation/config/status.txt
+++ b/Documentation/config/status.txt
@@ -12,6 +12,11 @@ status.branch::
 	Set to true to enable --branch by default in linkgit:git-status[1].
 	The option --no-branch takes precedence over this variable.
 
+status.aheadBehind::
+	Set to true to enable `--ahead-behind` and false to enable
+	`--no-ahead-behind` by default in linkgit:git-status[1] for
+	non-porcelain status formats.  Defaults to true.
+
 status.displayCommentPrefix::
 	If set to true, linkgit:git-status[1] will insert a comment
 	prefix before each output line (starting with
diff --git a/builtin/commit.c b/builtin/commit.c
index 1c9e8e2228..71305073ad 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1078,9 +1078,11 @@ static const char *read_commit_message(const char *name)
 static struct status_deferred_config {
 	enum wt_status_format status_format;
 	int show_branch;
+	enum ahead_behind_flags ahead_behind;
 } status_deferred_config = {
 	STATUS_FORMAT_UNSPECIFIED,
-	-1 /* unspecified */
+	-1, /* unspecified */
+	AHEAD_BEHIND_UNSPECIFIED,
 };
 
 static void finalize_deferred_config(struct wt_status *s)
@@ -1107,6 +1109,15 @@ static void finalize_deferred_config(struct wt_status *s)
 	if (s->show_branch < 0)
 		s->show_branch = 0;
 
+	/*
+	 * If the user did not give a "--[no]-ahead-behind" command
+	 * line argument, then we inherit the a/b config setting.
+	 * If is not set, then we inherit _FULL for backwards
+	 * compatibility.
+	 */
+	if (s->ahead_behind_flags == AHEAD_BEHIND_UNSPECIFIED)
+		s->ahead_behind_flags = status_deferred_config.ahead_behind;
+
 	if (s->ahead_behind_flags == AHEAD_BEHIND_UNSPECIFIED)
 		s->ahead_behind_flags = AHEAD_BEHIND_FULL;
 }
@@ -1246,6 +1257,10 @@ static int git_status_config(const char *k, const char *v, void *cb)
 		status_deferred_config.show_branch = git_config_bool(k, v);
 		return 0;
 	}
+	if (!strcmp(k, "status.aheadbehind")) {
+		status_deferred_config.ahead_behind = git_config_bool(k, v);
+		return 0;
+	}
 	if (!strcmp(k, "status.showstash")) {
 		s->show_stash = git_config_bool(k, v);
 		return 0;
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 716283b274..febf63f28a 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -159,6 +159,19 @@ test_expect_success 'status -s -b --no-ahead-behind (diverged from upstream)' '
 	test_i18ncmp expect actual
 '
 
+cat >expect <<\EOF
+## b1...origin/master [different]
+EOF
+
+test_expect_success 'status.aheadbehind=false status -s -b (diverged from upstream)' '
+	(
+		cd test &&
+		git checkout b1 >/dev/null &&
+		git -c status.aheadbehind=false status -s -b | head -1
+	) >actual &&
+	test_i18ncmp expect actual
+'
+
 cat >expect <<\EOF
 On branch b1
 Your branch and 'origin/master' have diverged,
@@ -174,6 +187,15 @@ test_expect_success 'status --long --branch' '
 	test_i18ncmp expect actual
 '
 
+test_expect_success 'status --long --branch' '
+	(
+		cd test &&
+		git checkout b1 >/dev/null &&
+		git -c status.aheadbehind=true status --long -b | head -3
+	) >actual &&
+	test_i18ncmp expect actual
+'
+
 cat >expect <<\EOF
 On branch b1
 Your branch and 'origin/master' refer to different commits.
@@ -188,6 +210,15 @@ test_expect_success 'status --long --branch --no-ahead-behind' '
 	test_i18ncmp expect actual
 '
 
+test_expect_success 'status.aheadbehind=false status --long --branch' '
+	(
+		cd test &&
+		git checkout b1 >/dev/null &&
+		git -c status.aheadbehind=false status --long -b | head -2
+	) >actual &&
+	test_i18ncmp expect actual
+'
+
 cat >expect <<\EOF
 ## b5...brokenbase [gone]
 EOF
diff --git a/t/t7064-wtstatus-pv2.sh b/t/t7064-wtstatus-pv2.sh
index 11eccc231a..a0baf6e8b0 100755
--- a/t/t7064-wtstatus-pv2.sh
+++ b/t/t7064-wtstatus-pv2.sh
@@ -436,6 +436,10 @@ test_expect_success 'verify --[no-]ahead-behind with V2 format' '
 		git status --no-ahead-behind --porcelain=v2 --branch --untracked-files=all >actual &&
 		test_cmp expect actual &&
 
+		# Confirmat that "status.aheadbehind" works on V2 format.
+		git -c status.aheadbehind=false status --porcelain=v2 --branch --untracked-files=all >actual &&
+		test_cmp expect actual &&
+
 		# Confirm --ahead-behind reports traditional branch.ab with 1/0.
 		cat >expect <<-EOF &&
 		# branch.oid $HUF
-- 
gitgitgadget

