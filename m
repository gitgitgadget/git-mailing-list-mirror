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
	by dcvr.yhbt.net (Postfix) with ESMTP id D02691F461
	for <e@80x24.org>; Mon, 22 Jul 2019 17:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730657AbfGVRy0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jul 2019 13:54:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44485 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730613AbfGVRyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jul 2019 13:54:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id p17so40307521wrf.11
        for <git@vger.kernel.org>; Mon, 22 Jul 2019 10:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lOX80uVC2U2fQKJu8kcG4KezDPftBgNdrsTDy0EN1A8=;
        b=L1q3KiXIG//PZZXq61lQuCm/7iBmUk2QV+Gj2I3fH8LpYRJUXyTj/z9BSAW+tWZqWO
         Dac7HKPeXauPEogzq4RKxaQcSy5oMf4DOTucnV2DkjtDZe0AbxWbWbFOA67znb7/m0kn
         3x24QeWeZTlw9fzFown5rh+fJbSV5/t8OJKP2FaV4iiYGviFZEt8XFCniLj4y3aREgRB
         IIoPlD6KEU5TJbGZKfwbqy/Qy4daKQIZUQcWJVNtBAMIiksBJQh8vfAfILiAQfdlsFnp
         zD0MlKxzba6VxqiORbMyUYdbesjDCv+X/bitzgQOhWw1dZlImxnPYpNpXob20xVS05bd
         /XVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lOX80uVC2U2fQKJu8kcG4KezDPftBgNdrsTDy0EN1A8=;
        b=Y16ptJFXGeZ+y+ae6QT18o6ywUHBdxAhms5VqKCEBzGcg6Qxpa+erHmzyVQzdCqp/3
         oZNr66c4qD36b3krEP3iG55wgrSByJarI5WRNSUMBX75Ur8lsZNAJAAe5vai3LRwS0TQ
         GeBg3s77X/vbzZXMPYdaaYWw428BYnUhW1SUlQwEht3bfPTF7UFgFdV8ToAFE9a3zI5l
         EXahNajLecXZLV1SIOXJaTtbco4JwJ3xm38ZeWvZwznYY8DNF7wZiTJHAp68rBupjJqc
         xxzNIlnGzA+Fj5tzx2lK+LNx/Q7hySDA4B9CM2fqnjC3j+KC7p/xsVPhuvnGAgeQi5ER
         hk3w==
X-Gm-Message-State: APjAAAUHnBeyjoeGENqmg5I5yMpnIas8j7RxGebZShzlXwFcMWVi/bPo
        izMkc92EI0Z2iXT+MiEwJN61BQTg
X-Google-Smtp-Source: APXvYqz+VO9kT8BlD/JE/sYd1RuspxNBLY3tD7JfpS6g9d7bTccEgGAs1SkrRtS1vT1uLY+o0s4CqA==
X-Received: by 2002:adf:de10:: with SMTP id b16mr43122769wrm.296.1563818064371;
        Mon, 22 Jul 2019 10:54:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j9sm43916639wrn.81.2019.07.22.10.54.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 10:54:23 -0700 (PDT)
Date:   Mon, 22 Jul 2019 10:54:23 -0700 (PDT)
X-Google-Original-Date: Mon, 22 Jul 2019 17:54:18 GMT
Message-Id: <63b522a858bdd2fad78da53eae207e64f2f7a6e0.1563818059.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.292.git.gitgitgadget@gmail.com>
References: <pull.292.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 4/5] repo-settings: create feature.manyFiles setting
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
 repo-settings.c                  |  6 ++++++
 t/t1600-index.sh                 | 31 ++++++++++++++++++++++++++-----
 5 files changed, 47 insertions(+), 7 deletions(-)

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
index 807c5a29d6..9e4b8e6268 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -14,6 +14,12 @@ static int git_repo_config(const char *key, const char *value, void *cb)
 		UPDATE_DEFAULT(rs->gc_write_commit_graph, 1);
 		return 0;
 	}
+	if (!strcmp(key, "feature.manyfiles")) {
+		UPDATE_DEFAULT(rs->index_version, 4);
+		UPDATE_DEFAULT(rs->core_untracked_cache,
+			       CORE_UNTRACKED_CACHE_KEEP | CORE_UNTRACKED_CACHE_WRITE);
+		return 0;
+	}
 	if (!strcmp(key, "core.commitgraph")) {
 		rs->core_commit_graph = git_config_bool(key, value);
 		return 0;
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

