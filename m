Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0470B1F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 22:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438191AbfJQWIC (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 18:08:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32852 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbfJQWIC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 18:08:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id b9so4062557wrs.0
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 15:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UXwdHtGcenEpDWeqv3zB9IME53ZvSIPkiOcJngEl2KU=;
        b=Jsui0UGT3a17sc6nhF9Qu4fVyDvDuxeh+XCA589E5Anjn61FGNPylUvX9LpxRZfdnM
         6VAhaoh0hio7vrZS4cJ+uRWNIVyYiPcgg8hJAjnz+neGEa3jKS0xmWF5NDnHYQhwZNRn
         CnkA/vG7ohwL9ZyLtwOZ1AeDaIv3uLVBNtKuQWkKTmcWNjKpwr78P3qRN2ZZktHH/vz7
         9hUCvUhkx2xxI+30FOzM2ZCwYAupbA88ZoJTLXY6HLneG8Rp39/cVPs1YZPZj6XbHv2o
         nRM6gLxl7syzK5lM7XEHw/gBbK00YwRHSNkxxiI6qGv1b0YrFbehzKMFXWvHW/uPd5UA
         /Wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UXwdHtGcenEpDWeqv3zB9IME53ZvSIPkiOcJngEl2KU=;
        b=HYg+bwYN+8LxNyVjNBYDC5S3ljfAne2qeFvINBhfT8wjvrNyXKssfwQjtfQ6LimKWf
         fxf0UeY8hhGnRKjCx75IIDYsCj54SpHXkWdoBWyhzw9OY8XxMjgbcu3XGNTwYlH0EHEY
         WVhHaqB9V0kq+17+NDbzoVynboSpJCgvS5ar7AoIBBe0HM4fPnxlJC9TWpwk+QOL6fG4
         KC380mVJV+7WQBMINRiLa1NtJqZALBQUnlFP25vGoDRtyNRL6HJTcZsR+k83+RP9m/q6
         RtTcqbgifZq759XM7B30KAj5S9g0X8UsYWpBvUwK9sXh3tNxgHjjF1Nn53AQI4Um2hgI
         wSSA==
X-Gm-Message-State: APjAAAXN7ODxa3l+0Gk+IjVmR61zdIYD08ycLR1MuFTpyxcyC5P4tp16
        Aj1ffDj4x9WiGaHFXUQcWcmwAct3
X-Google-Smtp-Source: APXvYqyEMBPRS2KRqKTs095iElUyI+AknaaTtlbA/y7pO4rZvGIZbkjHVG0CUr7HOGR7tWw0vKUyQw==
X-Received: by 2002:a5d:5052:: with SMTP id h18mr5133141wrt.143.1571350080368;
        Thu, 17 Oct 2019 15:08:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y3sm13609573wmg.2.2019.10.17.15.07.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 15:07:59 -0700 (PDT)
Message-Id: <93dba5a3a38d75ba79329383a1d50419a1990c8d.1571350077.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.401.v2.git.1571350077.gitgitgadget@gmail.com>
References: <pull.401.git.1571209637.gitgitgadget@gmail.com>
        <pull.401.v2.git.1571350077.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Oct 2019 22:07:57 +0000
Subject: [PATCH v2 2/2] git_path(): handle `.lock` files correctly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Ever since worktrees were introduced, the `git_path()` function _really_
needed to be called e.g. to get at the path to `logs/HEAD` (`HEAD` is
specific to the worktree). However, the wrong path is returned for
`logs/HEAD.lock`.

This does not matter as long as the Git executable is doing the asking,
as the path for that `index.lock` file is constructed from
`git_path("index")` by appending the `.lock` suffix.

However, Git GUI just learned to use `--git-path` instead of appending
relative paths to what `git rev-parse --git-dir` returns (and as a
consequence not only using the correct hooks directory, but also using
the correct paths in worktrees other than the main one). While it does
not seem as if Git GUI in particular is asking for `logs/HEAD.lock`,
let's be safe rather than sorry.

Side note: Git GUI _does_ ask for `index.lock`, but that is already
resolved correctly.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 path.c               |  4 ++--
 t/t1500-rev-parse.sh | 15 +++++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/path.c b/path.c
index e3da1f3c4e..ff85692b45 100644
--- a/path.c
+++ b/path.c
@@ -268,7 +268,7 @@ static int trie_find(struct trie *root, const char *key, match_fn fn,
 	int result;
 	struct trie *child;
 
-	if (!*key) {
+	if (!*key || !strcmp(key, ".lock")) {
 		/* we have reached the end of the key */
 		if (root->value && !root->len)
 			return fn(key, root->value, baton);
@@ -288,7 +288,7 @@ static int trie_find(struct trie *root, const char *key, match_fn fn,
 
 	/* Matched the entire compressed section */
 	key += i;
-	if (!*key)
+	if (!*key || !strcmp(key, ".lock"))
 		/* End of key */
 		return fn(key, root->value, baton);
 
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 01abee533d..d318a1eeef 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -116,6 +116,21 @@ test_expect_success 'git-path inside sub-dir' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git-path in worktree' '
+	test_tick &&
+	git commit --allow-empty -m empty &&
+	git worktree add --detach wt &&
+	test_write_lines >expect \
+		"$(pwd)/.git/worktrees/wt/logs/HEAD" \
+		"$(pwd)/.git/worktrees/wt/logs/HEAD.lock" \
+		"$(pwd)/.git/worktrees/wt/index" \
+		"$(pwd)/.git/worktrees/wt/index.lock" &&
+	git -C wt rev-parse >actual \
+		--git-path logs/HEAD --git-path logs/HEAD.lock \
+		--git-path index --git-path index.lock &&
+	test_cmp expect actual
+'
+
 test_expect_success 'rev-parse --is-shallow-repository in shallow repo' '
 	test_commit test_commit &&
 	echo true >expect &&
-- 
gitgitgadget
