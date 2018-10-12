Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 480CD1F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 17:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeJMBH4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 21:07:56 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35129 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeJMBH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 21:07:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id l17-v6so6544628pff.2
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 10:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YJF4vh9Er0zXBt2eRS+5BRM2MBtdK+OZOhIp7cm4kI8=;
        b=lxKYC4T+213LjQHN/XI0KNAOri/VIlVMa7QNZqwYn/8Pn8IjN9pZR6F49AFImAzVUU
         g+DQt2LGNMf0URkO1xIO5xbnpWEHfJRo/iVftub70otRXhk+bDUaocU2JGX8+5vPp6Wr
         P2J6fOpyhN0Bb9SQ7k/Q2FeSwvETiBErklaVDNPuzZVvzdtlPUOVY+HP0rViw9VnaW++
         CsJ5NeSC5djQ0CFGiaSiN3weIlTbmGLiKwufEz91lrweqP5mcWoN9ZzSjHuGJbRZn8pv
         MUeXx1Jty4N6Pr4bB3ilSswhNTpU+b3xNIfWSRlTyjEu5YCpbUCJ9G8OOxB9ajKLXRUg
         ZaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YJF4vh9Er0zXBt2eRS+5BRM2MBtdK+OZOhIp7cm4kI8=;
        b=UdCzBFOfh9lhR7G4k13reWZAp7sj/kxmbYVbnfrdjfd7xCzVZ5O+0LOvfXaV8ghYbv
         ZVmoSbeqnXMUzh3723VCHjH/S8YhuXxJUxeFUNc1NC+HTZuVJbUmDSmL15lQcDhh7ZfS
         /E9184ApoYas8g4qguEf0DiiZahUPOIUiIs3ZyW+8sAeU51llr2jOcqKZoUw1YPJ0roQ
         Mg8Vqu8K0HIvw8uHJCmTIBsnuQ6RJJmOJTa1GPSEMXgcbJlJcdJAC4dPAcbGzeuImkU2
         8Q2qIW0oHNNnCwDgcTnus2+h9g751PLro3AwGB7TYA7zwogz65QeYpAug98rtZY/nqci
         rvmw==
X-Gm-Message-State: ABuFfohGEXlQnF4+Wqag0OazMzbmPbiEWm21xt73DyTSxPsk5uORmWY+
        SAwoTZhYQ32okZ9gUvIovJy/8dSi
X-Google-Smtp-Source: ACcGV63BEgj1cCP8vgXcm66fFtZz+uVLZdmGh8PeprRiuHMlHxmZsde1YISdV+tee4lvDmZCGAu5Qw==
X-Received: by 2002:a63:2c8a:: with SMTP id s132-v6mr6200518pgs.73.1539365661411;
        Fri, 12 Oct 2018 10:34:21 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id l197-v6sm2745616pga.9.2018.10.12.10.34.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 10:34:20 -0700 (PDT)
Date:   Fri, 12 Oct 2018 10:34:20 -0700 (PDT)
X-Google-Original-Date: Fri, 12 Oct 2018 17:34:14 GMT
Message-Id: <57c64e814cc5c5a453dcfd1d84c1efba1a4ef964.1539365654.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.27.v2.git.gitgitgadget@gmail.com>
References: <pull.27.git.gitgitgadget@gmail.com>
        <pull.27.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 3/3] multi-pack-index: define GIT_TEST_MULTI_PACK_INDEX
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The multi-pack-index feature is tested in isolation by
t5319-multi-pack-index.sh, but there are many more interesting
scenarios in the test suite surrounding pack-file data shapes
and interactions. Since the multi-pack-index is an optional
data structure, it does not make sense to include it by default
in those tests.

Instead, add a new GIT_TEST_MULTI_PACK_INDEX environment variable
that enables core.multiPackIndex and writes a multi-pack-index
after each 'git repack' command. This adds extra test coverage
when needed.

There are a few spots in the test suite that need to react to this
change:

* t5319-multi-pack-index.sh: there is a test that checks that
  'git repack' deletes the multi-pack-index. Disable the environment
  variable to ensure this still happens.

* t5310-pack-bitmaps.sh: One test moves a pack-file from the object
  directory to an alternate. This breaks the multi-pack-index, so
  delete the multi-pack-index at this point, if it exists.

* t9300-fast-import.sh: One test verifies the number of files in
  the .git/objects/pack directory is exactly 8. Exclude the
  multi-pack-index from this count so it is still 8 in all cases.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/repack.c            | 4 ++++
 midx.c                      | 9 +++++++--
 midx.h                      | 2 ++
 t/README                    | 4 ++++
 t/t5310-pack-bitmaps.sh     | 1 +
 t/t5319-multi-pack-index.sh | 2 +-
 t/t9300-fast-import.sh      | 2 +-
 7 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 44965cbaa3..26dcccdafc 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -553,6 +553,10 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (!no_update_server_info)
 		update_server_info(0);
 	remove_temporary_files();
+
+	if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0))
+		write_midx_file(get_object_directory());
+
 	string_list_clear(&names, 0);
 	string_list_clear(&rollback, 0);
 	string_list_clear(&existing_packs, 0);
diff --git a/midx.c b/midx.c
index 22247a30ab..02b2211e31 100644
--- a/midx.c
+++ b/midx.c
@@ -335,9 +335,14 @@ int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, i
 	struct multi_pack_index *m;
 	struct multi_pack_index *m_search;
 	int config_value;
+	static int env_value = -1;
 
-	if (repo_config_get_bool(r, "core.multipackindex", &config_value) ||
-	    !config_value)
+	if (env_value < 0)
+		env_value = git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0);
+
+	if (!env_value &&
+	    (repo_config_get_bool(r, "core.multipackindex", &config_value) ||
+	    !config_value))
 		return 0;
 
 	for (m_search = r->objects->multi_pack_index; m_search; m_search = m_search->next)
diff --git a/midx.h b/midx.h
index 0f68bccdd5..f2bb7e681c 100644
--- a/midx.h
+++ b/midx.h
@@ -3,6 +3,8 @@
 
 #include "repository.h"
 
+#define GIT_TEST_MULTI_PACK_INDEX "GIT_TEST_MULTI_PACK_INDEX"
+
 struct multi_pack_index {
 	struct multi_pack_index *next;
 
diff --git a/t/README b/t/README
index 5e48a043ce..9bfdd3004c 100644
--- a/t/README
+++ b/t/README
@@ -327,6 +327,10 @@ GIT_TEST_COMMIT_GRAPH=<boolean>, when true, forces the commit-graph to
 be written after every 'git commit' command, and overrides the
 'core.commitGraph' setting to true.
 
+GIT_TEST_MULTI_PACK_INDEX=<boolean>, when true, forces the multi-pack-
+index to be written after every 'git repack' command, and overrides the
+'core.multiPackIndex' setting to true.
+
 Naming Tests
 ------------
 
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 1be3459c5b..82d7f7f6a5 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -191,6 +191,7 @@ test_expect_success 'pack-objects respects --honor-pack-keep (local bitmapped pa
 
 test_expect_success 'pack-objects respects --local (non-local bitmapped pack)' '
 	mv .git/objects/pack/$packbitmap.* alt.git/objects/pack/ &&
+	rm -f .git/objects/pack/multi-pack-index &&
 	test_when_finished "mv alt.git/objects/pack/$packbitmap.* .git/objects/pack/" &&
 	echo HEAD | git pack-objects --local --stdout --revs >3b.pack &&
 	git index-pack 3b.pack &&
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index bd8e841b81..70926b5bc0 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -271,7 +271,7 @@ test_expect_success 'git-fsck incorrect offset' '
 
 test_expect_success 'repack removes multi-pack-index' '
 	test_path_is_file $objdir/pack/multi-pack-index &&
-	git repack -adf &&
+	GIT_TEST_MULTI_PACK_INDEX=0 git repack -adf &&
 	test_path_is_missing $objdir/pack/multi-pack-index
 '
 
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 40fe7e4976..59a13b6a77 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1558,7 +1558,7 @@ test_expect_success 'O: blank lines not necessary after other commands' '
 	INPUT_END
 
 	git fast-import <input &&
-	test 8 = $(find .git/objects/pack -type f | wc -l) &&
+	test 8 = $(find .git/objects/pack -type f | grep -v multi-pack-index | wc -l) &&
 	test $(git rev-parse refs/tags/O3-2nd) = $(git rev-parse O3^) &&
 	git log --reverse --pretty=oneline O3 | sed s/^.*z// >actual &&
 	test_cmp expect actual
-- 
gitgitgadget
