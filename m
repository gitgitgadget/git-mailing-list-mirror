Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38C521F462
	for <e@80x24.org>; Tue, 30 Jul 2019 19:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfG3Tfd (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 15:35:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39215 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfG3Tfc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 15:35:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id u25so47309240wmc.4
        for <git@vger.kernel.org>; Tue, 30 Jul 2019 12:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YBiuv1ZUTvHY0XEtrjWIXVRz6tGL5L4VT59zVgtW6Zo=;
        b=VXVoeTclgwtgY4A8gwW2kNYcrQKwekFEc6vfc60AlPDxm5qbgXzsTZB+2m8qCaGLSZ
         2NFrQOR+kzvAqUonDcHROxCgogmhdfJ7iFvIm+rZ8Y3jYUMUOA7d8orccngS395B7XcY
         kUR/QgRSzeUt/O++VH1fhjW7rBg85Y5EpUHCS+x52uY7ihazF9+PHLyNVgi0YzLBXk5j
         synvqYbYf0jifUy7k15MjC01UJtgb+/9w0SP2F3oTl/Ct2+qlED+Jfh7DST4TT8SWu58
         JKgty1P5zHP5rl7w8vdwvN0lkx4emhIfCo6lUMe5RpbYQhJ50Rc9LYpsEfxi6mlp2W1R
         3LaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YBiuv1ZUTvHY0XEtrjWIXVRz6tGL5L4VT59zVgtW6Zo=;
        b=azwaT7ZmWi5MpWa2RTOZF1G49onMK5HbkVOFee973djFXYMv/0gZM4BAImfY++lFGp
         LRH3T97eHRYMuQpPkyoWP301b1GMZFKGhCDEwLelKvzlp6HHP8KhEQQRuK3wEuCEygvr
         ULa+TyfXjMkWThx05yilc9HRsXo3sNE5t7dwoAr8MBEseIXhKmNjpWgrbxTVPXUKVDcf
         u34BevXEyXihutKYDZr6pG7xjPMaw8gTF5lk75c8RkxHdzaJNYZNF0uLg5EqiWaUU3Sv
         +FN+Q7Buz/y/vlwHeGBLVJnXt9xJ8ITJkquap+48wz84fMQgAG5o+Dc0xwHiKM/SsWlE
         fQbw==
X-Gm-Message-State: APjAAAX8dc2rouwElGw3kPFK/rCv5fLrXh0zaCmVudBAmO+Qmfdf157P
        phKI3kD5A6e0g7hbTPw/qn0h/Xnn
X-Google-Smtp-Source: APXvYqz2RIbyqDSV0nteO8oLlYTRN83XDxkdExteW9+dAUki0v0iGZJECPwQYIK+LQ8iuSmhyzThMg==
X-Received: by 2002:a1c:c2d5:: with SMTP id s204mr108671619wmf.174.1564515329245;
        Tue, 30 Jul 2019 12:35:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b19sm46875283wmj.13.2019.07.30.12.35.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 12:35:28 -0700 (PDT)
Date:   Tue, 30 Jul 2019 12:35:28 -0700 (PDT)
X-Google-Original-Date: Tue, 30 Jul 2019 19:35:23 GMT
Message-Id: <0d4774d45fee108981a4ad7316367f78c9f23fa1.1564515324.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.292.v3.git.gitgitgadget@gmail.com>
References: <pull.292.v2.git.gitgitgadget@gmail.com>
        <pull.292.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 4/5] repo-settings: create feature.manyFiles setting
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, peff@peff.net, jnareb@gmail.com,
        pclouds@gmail.com, carenas@gmail.com, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The feature.manyFiles setting is suitable for repos with many
files in the working directory. By setting index.version=4 and
core.untrackedCache=true, commands such as 'git status' should
improve.

While adding this setting, modify the index version precedence
tests to check how this setting overrides the default for
index.version is unset.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/core.txt    |  4 +++-
 Documentation/config/feature.txt | 12 +++++++++++-
 Documentation/config/index.txt   |  1 +
 repo-settings.c                  |  4 ++++
 t/t1600-index.sh                 | 31 ++++++++++++++++++++++++++-----
 5 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index d80162681a..7a2a33bc8c 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -86,7 +86,9 @@ core.untrackedCache::
 	it will automatically be removed, if set to `false`. Before
 	setting it to `true`, you should check that mtime is working
 	properly on your system.
-	See linkgit:git-update-index[1]. `keep` by default.
+	See linkgit:git-update-index[1]. `keep` by default, unless
+	`feature.manyFiles` is enabled which sets this setting to
+	`true` by default.
 
 core.checkStat::
 	When missing or is set to `default`, many fields in the stat
diff --git a/Documentation/config/feature.txt b/Documentation/config/feature.txt
index f74314ae90..c2d9ef7473 100644
--- a/Documentation/config/feature.txt
+++ b/Documentation/config/feature.txt
@@ -12,4 +12,14 @@ feature.manyCommits::
 * `core.commitGraph=true` enables reading the commit-graph file.
 +
 * `gc.writeCommitGraph=true` enables writing the commit-graph file during
-garbage collection.
\ No newline at end of file
+garbage collection.
+
+feature.manyFiles::
+	Enable config options that optimize for repos with many files in the
+	working directory. With many files, commands such as `git status` and
+	`git checkout` may be slow and these new defaults improve performance:
++
+* `index.version=4` enables path-prefix compression in the index.
++
+* `core.untrackedCache=true` enables the untracked cache. This setting assumes
+that mtime is working on your machine.
\ No newline at end of file
diff --git a/Documentation/config/index.txt b/Documentation/config/index.txt
index f181503041..7cb50b37e9 100644
--- a/Documentation/config/index.txt
+++ b/Documentation/config/index.txt
@@ -24,3 +24,4 @@ index.threads::
 index.version::
 	Specify the version with which new index files should be
 	initialized.  This does not affect existing repositories.
+	If `feature.manyFiles` is enabled, then the default is 4.
diff --git a/repo-settings.c b/repo-settings.c
index 9ed83e6e54..af93696343 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -42,6 +42,10 @@ void prepare_repo_settings(struct repository *r)
 		UPDATE_DEFAULT(r->settings.core_commit_graph, 1);
 		UPDATE_DEFAULT(r->settings.gc_write_commit_graph, 1);
 	}
+	if (!repo_config_get_bool(r, "feature.manyfiles", &value) && value) {
+		UPDATE_DEFAULT(r->settings.index_version, 4);
+		UPDATE_DEFAULT(r->settings.core_untracked_cache, UNTRACKED_CACHE_WRITE);
+	}
 
 	/* Hack for test programs like test-dump-untracked-cache */
 	if (ignore_untracked_cache_config)
diff --git a/t/t1600-index.sh b/t/t1600-index.sh
index 42962ed7d4..c77721b580 100755
--- a/t/t1600-index.sh
+++ b/t/t1600-index.sh
@@ -59,17 +59,38 @@ test_expect_success 'out of bounds index.version issues warning' '
 	)
 '
 
-test_expect_success 'GIT_INDEX_VERSION takes precedence over config' '
+test_index_version () {
+	INDEX_VERSION_CONFIG=$1 &&
+	FEATURE_MANY_FILES=$2 &&
+	ENV_VAR_VERSION=$3
+	EXPECTED_OUTPUT_VERSION=$4 &&
 	(
 		rm -f .git/index &&
-		GIT_INDEX_VERSION=4 &&
-		export GIT_INDEX_VERSION &&
-		git config --add index.version 2 &&
+		rm -f .git/config &&
+		if test "$INDEX_VERSION_CONFIG" -ne 0
+		then
+			git config --add index.version $INDEX_VERSION_CONFIG
+		fi &&
+		git config --add feature.manyFiles $FEATURE_MANY_FILES
+		if test "$ENV_VAR_VERSION" -ne 0
+		then
+			GIT_INDEX_VERSION=$ENV_VAR_VERSION &&
+			export GIT_INDEX_VERSION
+		else
+			unset GIT_INDEX_VERSION
+		fi &&
 		git add a 2>&1 &&
-		echo 4 >expect &&
+		echo $EXPECTED_OUTPUT_VERSION >expect &&
 		test-tool index-version <.git/index >actual &&
 		test_cmp expect actual
 	)
+}
+
+test_expect_success 'index version config precedence' '
+	test_index_version 2 false 4 4 &&
+	test_index_version 2 true 0 2 &&
+	test_index_version 0 true 0 4 &&
+	test_index_version 0 true 2 2
 '
 
 test_done
-- 
gitgitgadget

