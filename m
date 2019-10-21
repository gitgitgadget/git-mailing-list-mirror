Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAE551F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 21:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbfJUVys (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 17:54:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40381 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730355AbfJUVyr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 17:54:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id o28so15655711wro.7
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 14:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LRtur35fZsOeyCr+k9zLM1Aq/gErx+cVDNNZ7kPmhsA=;
        b=G/7ZlrsUHzYn5+0Nk/wKiFYUQRmJ1pih78BZxcVovQqsHFbJUIkN8jrkwLQ/U6g1fP
         /9ayUm5OU1/E+yg9pojWhlaBfGUkbr9T1CATYFGjZoxEzxEd6uxa+9XBQssZekngWSNS
         Szf/2/qaJf8J53WTY9L5ptNF498RePK97c6yBTH+JCUZUISb/hNTlSNKu3bd0b/Xq2Gy
         qJTeGjeQfzgAj/eoBaRWN2CUvubnPXmdYC0kQPwRDFF5lE8dpesclmLwOOdNOEwJUstr
         ElJf4KJ+G4XcWIqW2FX5ZhqFYyosLfqnuGWK7ONIe7/dGo1J/khelOHa5yFOH5kLCvMQ
         Nm5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LRtur35fZsOeyCr+k9zLM1Aq/gErx+cVDNNZ7kPmhsA=;
        b=tf3jCtsHq1WwY8zxFd8M1xTMjRUIkwrlHNmcwYn92Yxuv/7UlKuZzivF9VmMdqXvq3
         Fzhkb7ZVrjJhsfLRU25AxMmXEtMIEsed0BLmHqU3MRDVfYEo9ffYwa8A0U77MJkz6Vlg
         j4pCCINito2hCr9oZFBe1U96DujEPxZ5R8gCGFRITnHcKQ7mjWLNxN9wOoXpAXFQ/GuB
         LWoiHGxsJcJo/8Qi7zqlWFxXxOfhSDjFSNxFGLzt7vga7T7KWE9+62Av3o8TLFd+cAXj
         6cpKzAvkcpYNPXr8ahqq2IhY+6rQ+wyuAT4MicNRAMWzCyY+Ltm9uPXK9C8gM4AuQwhy
         fgsQ==
X-Gm-Message-State: APjAAAWrIsV8UiBAFMT5ieOTOu0MLCj30LQmxAPWG0jCzuDr1wmqpGbV
        1Y4iqgGeIjt+jnySEOJ/6zlluV3q
X-Google-Smtp-Source: APXvYqwD8AD2Wyyp/bXdoKNO2rlemzt4F3/8Qxw0gf/HgqjYesQe78hTiwyd8eTI6MHQxnZjap8s1Q==
X-Received: by 2002:adf:8068:: with SMTP id 95mr361165wrk.249.1571694885457;
        Mon, 21 Oct 2019 14:54:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n17sm4114733wrt.25.2019.10.21.14.54.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 14:54:44 -0700 (PDT)
Message-Id: <8b1f4f089a6d4a2293507a1a77668c828598e84f.1571694882.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.401.v3.git.1571694882.gitgitgadget@gmail.com>
References: <pull.401.v2.git.1571350077.gitgitgadget@gmail.com>
        <pull.401.v3.git.1571694882.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Oct 2019 21:54:42 +0000
Subject: [PATCH v3 2/2] git_path(): handle `.lock` files correctly
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
specific to the worktree, and therefore so is its reflog). However, the
wrong path is returned for `logs/HEAD.lock`.

This does not matter as long as the Git executable is doing the asking,
as the path for that `logs/HEAD.lock` file is constructed from
`git_path("logs/HEAD")` by appending the `.lock` suffix.

However, Git GUI just learned to use `--git-path` instead of appending
relative paths to what `git rev-parse --git-dir` returns (and as a
consequence not only using the correct hooks directory, but also using
the correct paths in worktrees other than the main one). While it does
not seem as if Git GUI in particular is asking for `logs/HEAD.lock`,
let's be safe rather than sorry.

Side note: Git GUI _does_ ask for `index.lock`, but that is already
resolved correctly, due to `update_common_dir()` preferring to leave
unknown paths in the (worktree-specific) git directory.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 path.c               |  8 +++++++-
 t/t1500-rev-parse.sh | 15 +++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/path.c b/path.c
index e3da1f3c4e..5ff64e7a8a 100644
--- a/path.c
+++ b/path.c
@@ -349,10 +349,16 @@ static int check_common(const char *unmatched, void *value, void *baton)
 static void update_common_dir(struct strbuf *buf, int git_dir_len,
 			      const char *common_dir)
 {
-	char *base = buf->buf + git_dir_len;
+	char *base = buf->buf + git_dir_len, *base2 = NULL;
+
+	if (ends_with(base, ".lock"))
+		base = base2 = xstrndup(base, strlen(base) - 5);
+
 	init_common_trie();
 	if (trie_find(&common_trie, base, check_common, NULL) > 0)
 		replace_dir(buf, git_dir_len, common_dir);
+
+	free(base2);
 }
 
 void report_linked_checkout_garbage(void)
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
