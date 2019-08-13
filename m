Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 144D11F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 18:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbfHMShu (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 14:37:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42177 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727715AbfHMShu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 14:37:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id b16so11980676wrq.9
        for <git@vger.kernel.org>; Tue, 13 Aug 2019 11:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=O+qmWoRP6oC9ST1DAdn4EHXUEP0N+Knv2h0GZKQPYws=;
        b=R9LRKLTBA7psK1ReEClfN/sEiwFynju1Kpeh2ZuVCDQvLQDsCPPpHSp2gqoMWx/fcp
         vhz7hGPV/Z/bjSAhzrYtl21AjVGNbAywiKxWAFzAxoEm3p1w3AU6sTN9idTDVrlsj540
         q4j0OEFyIiMUN6ziEWUH6bicMK015owKPosEJWCakeE+vuTRg3gIhTyptcSkwca3lJL1
         lB5sBZ/YtG7ow1voonRMh90gi/p2lrgiKMPjnlNc4QFRdb4/giH4Jx2oHgLDGgccQm4+
         Z8jNmsKeGl5zzeBFSz3ygm55OLdZcjCwYsOYkDawnAVfUJpBYeDMDxotEGu7PL6aNIol
         nbgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=O+qmWoRP6oC9ST1DAdn4EHXUEP0N+Knv2h0GZKQPYws=;
        b=YarZpSDJwq350NgNHwxo7doafSIQ5NrdCoeBF7uGKnBk6aATfx2TekTAz5yS+lXbpP
         yzaGAnzWYUhG55JaW+ocxj7U12e18j0Ft4e0PUpdG9m8xVKSVjt39RdHUxGAknb8ilun
         MviUkGBx1TbZT0U2+9Pixifji7IpSh+oS9syl6/sIb1zQotcZYYPomDNtB4nLLitnoif
         9cO0iRwLOSeua9wT+NvpURZiXvQkl9rDxr0W5nFjBqaxcr64m9GNQOMFSgl1CHmyCSBp
         P9e+1jG2aOsgXNf/taRvRLBZRIiPrCI/Z0gNbEiCGP/GvSZ2Kk2/tkRCmTaxUkOqyLW3
         7seg==
X-Gm-Message-State: APjAAAV1ttC8uZ49KTwmC1g2V2XszNuW2Sxa9AkBCy3FLf/F1ET+Dmbh
        k/h7YCmgPiqukUNgTuoMdwvRyVLh
X-Google-Smtp-Source: APXvYqy3pNWp5ryvzvT/vsfn/BpNR6KKp9Twi0nKZEASOSX7LwPlQ9pxyGpfMh014lpXGa9xI0G+PA==
X-Received: by 2002:a05:6000:1189:: with SMTP id g9mr51696687wrx.51.1565721467684;
        Tue, 13 Aug 2019 11:37:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y16sm1007359wrh.64.2019.08.13.11.37.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 11:37:47 -0700 (PDT)
Date:   Tue, 13 Aug 2019 11:37:47 -0700 (PDT)
X-Google-Original-Date: Tue, 13 Aug 2019 18:37:40 GMT
Message-Id: <082fc572884ec9e91e3bdd76dd2a7801f28b414a.1565721461.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.292.v4.git.gitgitgadget@gmail.com>
References: <pull.292.v3.git.gitgitgadget@gmail.com>
        <pull.292.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 5/6] repo-settings: create feature.manyFiles setting
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
 Documentation/config.txt         |  2 ++
 Documentation/config/core.txt    |  4 +++-
 Documentation/config/feature.txt | 15 +++++++++++++++
 Documentation/config/index.txt   |  1 +
 repo-settings.c                  |  5 ++++-
 t/t1600-index.sh                 | 31 ++++++++++++++++++++++++++-----
 6 files changed, 51 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/config/feature.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e3f5bc3396..77f3b1486b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -345,6 +345,8 @@ include::config/difftool.txt[]
 
 include::config/fastimport.txt[]
 
+include::config/feature.txt[]
+
 include::config/fetch.txt[]
 
 include::config/format.txt[]
diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index e66d79fd76..852d2ba37a 100644
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
new file mode 100644
index 0000000000..8ea198a642
--- /dev/null
+++ b/Documentation/config/feature.txt
@@ -0,0 +1,15 @@
+feature.*::
+	The config settings that start with `feature.` modify the defaults of
+	a group of other config settings. These groups are created by the Git
+	developer community as recommended defaults and are subject to change.
+	In particular, new config options may be added with different defaults.
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
index abbc6566f8..d5bf9069f4 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -36,9 +36,12 @@ void prepare_repo_settings(struct repository *r)
 		free(strval);
 	}
 
-
 	if (!repo_config_get_bool(r, "pack.usesparse", &value))
 		r->settings.pack_use_sparse = value;
+	if (!repo_config_get_bool(r, "feature.manyfiles", &value) && value) {
+		UPDATE_DEFAULT_BOOL(r->settings.index_version, 4);
+		UPDATE_DEFAULT_BOOL(r->settings.core_untracked_cache, UNTRACKED_CACHE_WRITE);
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

