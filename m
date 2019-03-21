Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95C2C20248
	for <e@80x24.org>; Thu, 21 Mar 2019 13:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbfCUN5g (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 09:57:36 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36456 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbfCUN5f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 09:57:35 -0400
Received: by mail-ed1-f67.google.com with SMTP id e4so5084475edi.3
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 06:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding:to:cc;
        bh=ghIjRDq7fU4IrMLrQrtJab1GlfhKESRgMtKLvPhlDSY=;
        b=FBQjyhCACn/k7JmwQlWolBULgCVh2uif13RnrnKUne5m5iR2T0luemIez1LqotqZcq
         rIDRyAnmbScwT+AieuoN7G/WDvgb1C4UA3QQv1oQhHRC/tSomryKZM9XSsLZRgnwS1OL
         Jo9yZjWArrpSJ15LRFGISG+aI5A75jPdb8DQk4JXltzn+D/5zbnxdxeLjhoSSPpv3g7+
         0XW8Fse4VYIfe3GYOSEuBQ6ajHvqkNMBf4KGvvn1bzkmQ94Ma0mtC8Rz6ilgGEGZyWjL
         tF9Vvg0Mzz/a5NM8LiqweY5vcBIOD4e4U7JQPptotR9HMoQdfs+9D2mpTZUNbJBlGRgD
         OnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:to:cc;
        bh=ghIjRDq7fU4IrMLrQrtJab1GlfhKESRgMtKLvPhlDSY=;
        b=S7t6aPVfZsTA4xOPxe2AVgLQ5MqgfRMbXT+HWsajJSfX5XcNwuI2RGPSoTtk8j+mWv
         4enp4g4guXDY/dMkVNt3Y2XhBSvuiXeHQwhNjucVIM1xlCiGJAq/R0xaeijY1+qgS1oY
         dxveItuiZeUs81eX0epeGU+bHIId4v81rk8wTB+agg5cfjd68oHJWg+0/QMDiWxKi4Au
         NUw2JX3MYQhACNqF2PiU691wvbO7oHhO9+6Vh7RBI4IDlbOzVLzGxIAO8kxKDUvCxXla
         6AIUflYbNuvu8fjr7H/BIaAwlIRWNQzuEaRQgwHzp7GUhtZ1nXSjlX165WwiCVOoufHI
         RVaw==
X-Gm-Message-State: APjAAAV/FLcCqoxr/F5cc/OUXJN77AhSNxS6fsx+0gC07xThRjHSDbyL
        ui8Rof1zz9dPXu0c/R89SvRnD1C6
X-Google-Smtp-Source: APXvYqwfHV/XzcwH8vjfMI6/Ux2dZ1jQLDSXzJqh23d+LN0qEnQAL+T5glxCCrRNfZtsacpAuldH0A==
X-Received: by 2002:aa7:dd0e:: with SMTP id i14mr2681093edv.172.1553176653996;
        Thu, 21 Mar 2019 06:57:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x20sm849651eda.40.2019.03.21.06.57.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 06:57:33 -0700 (PDT)
Date:   Thu, 21 Mar 2019 06:57:33 -0700 (PDT)
X-Google-Original-Date: Thu, 21 Mar 2019 13:57:30 GMT
Message-Id: <51a7edf22a22e86367893e77f2eccf70e0f91cb0.1553176651.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.165.v2.git.gitgitgadget@gmail.com>
References: <pull.165.git.gitgitgadget@gmail.com>
        <pull.165.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/2] fsmonitor: demonstrate that it is not refreshed after
 discard_index()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     git@vger.kernel.org
Cc:     Ben Peart <benpeart@microsoft.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This one is tricky.

When `core.fsmonitor` is set, a `refresh_index()` will not perform a
full scan of files that might be modified, but will query the fsmonitor
and refresh only the ones that have been actually touched.

Due to implementation details, the fsmonitor is queried in
`refresh_cache_ent()`, but of course it only has to be queried once, so
we set a flag when we did that. But when the index was discarded, we did
not re-set that flag.

So far, this is only covered by our test suite when running with
GIT_TEST_FSMONITOR=$PWD/t7519/fsmonitor-all, and only due to the way the
built-in stash interacts with the recursive merge machinery.

Let's introduce a straight-forward regression test for this.

We simply extend the "read & discard index" loop in `test-tool
read-cache` to optionally refresh the index, report on a given file's
status, and then modify that file. Due to the bug described above, only
the first refresh will actually query the fsmonitor; subsequent loop
iterations will not.

This problem was reported by Ævar Arnfjörð Bjarmason.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/helper/test-read-cache.c  | 24 +++++++++++++++++++++++-
 t/t7519-status-fsmonitor.sh |  8 ++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index d674c88ba0..7e79b555de 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -1,14 +1,36 @@
 #include "test-tool.h"
 #include "cache.h"
+#include "config.h"
 
 int cmd__read_cache(int argc, const char **argv)
 {
-	int i, cnt = 1;
+	int i, cnt = 1, namelen;
+	const char *name = NULL;
+
+	if (argc > 1 && skip_prefix(argv[1], "--print-and-refresh=", &name)) {
+		namelen = strlen(name);
+		argc--;
+		argv++;
+	}
+
 	if (argc == 2)
 		cnt = strtol(argv[1], NULL, 0);
 	setup_git_directory();
+	git_config(git_default_config, NULL);
 	for (i = 0; i < cnt; i++) {
 		read_cache();
+		if (name) {
+			int pos;
+
+			refresh_index(&the_index, REFRESH_QUIET,
+				      NULL, NULL, NULL);
+			pos = index_name_pos(&the_index, name, namelen);
+			if (pos < 0)
+				die("%s not in index", name);
+			printf("%s is%s up to date\n", name,
+			       ce_uptodate(the_index.cache[pos]) ? "" : " not");
+			write_file(name, "%d\n", i);
+		}
 		discard_cache();
 	}
 	return 0;
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 3e0a61db23..afd8fa7532 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -346,4 +346,12 @@ test_expect_success UNTRACKED_CACHE 'ignore .git changes when invalidating UNTR'
 	test_cmp before after
 '
 
+test_expect_failure 'discard_index() also discards fsmonitor info' '
+	test_config core.fsmonitor "$TEST_DIRECTORY/t7519/fsmonitor-all" &&
+	test_might_fail git update-index --refresh &&
+	test-tool read-cache --print-and-refresh=tracked 2 >actual &&
+	printf "tracked is%s up to date\n" "" " not" >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

