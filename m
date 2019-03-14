Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0F8820248
	for <e@80x24.org>; Thu, 14 Mar 2019 15:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfCNPdK (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 11:33:10 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34404 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbfCNPdK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 11:33:10 -0400
Received: by mail-ed1-f66.google.com with SMTP id a16so5016579edn.1
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 08:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HwXLJGo8iQk3wza1HLErNr11oUIUPtFmq8A0nycusoY=;
        b=S9sUby1ydhiOqwpGsTc0/cWVA0KV5UmrAdWDbOomr5EidplW+KoINqAwQm3Rj4pW4H
         cdKVi1hje2IX91tm/Il3O6KZKuaSU6e2uEnFUeywZZ2FItlhdKaWnb3ngztqrKsVbGew
         GcXIFjXa2lmL+0m8U9Rny9JXrXLLCh+HW6l+cXKdBiMLaL69rMmracajNqgZAlhrdb4b
         bpXS62y1FVAq55pGD6gAOPoUaM2yflO2krvsnqhgzHHrjyuz7R/kw8m57GiVzO/HlEAo
         ZxkwBpNHJXZNiwWUWrQBGDp7xe5H6jK/dmn6NbV1J4N6xzZeLCiRIrI9Rc9CpF2Vqyj9
         6wWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HwXLJGo8iQk3wza1HLErNr11oUIUPtFmq8A0nycusoY=;
        b=KcEj42wz9OmNA+EXHJPonynkFhRToZxdiQafsrsSK/UV83O9wGPrX9/FDZUGolcoFX
         Pm0PuP+2VXCvQkS1/ZzbLyp3IcMRkJDS+S0VU1LsbuJHCkWygT17BJeEZX937I4SKk0b
         2ylY8aVxoAkxpyMjWVqASUYQ2mIG0vMarzXUVpQXyjafbNzd2Rayky/G2Yv9Q8ren20e
         /oNbVXkQQv16lN0KxMly97L3MZuwoyAT25/4yNLekVyWKLDKrOkYq6/HnQzAxOjgxay5
         QnmOxO9r2snGgc1kqoHF05oA3vI4/lsT4rGzvmO2rG1iivWc3BmrpTXuuu7ieIQCwt7f
         u3Jw==
X-Gm-Message-State: APjAAAVHoBbE8bPPvQUGxkZCjrJ/k4CZLaHfhRVi7vwunexlC7NoX21e
        /5/OAuXO5PEoE4iYbWtUL5ys2aj+
X-Google-Smtp-Source: APXvYqxNuBCeN8i5dcqZKrsZi2qCW12kmGxR1QxjA9jPIZz2WbhSXc9LuesEQN8G0fVr5fXqVKzK/w==
X-Received: by 2002:a17:906:4759:: with SMTP id j25mr3091229ejs.194.1552577588246;
        Thu, 14 Mar 2019 08:33:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a9sm1162216eje.37.2019.03.14.08.33.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 08:33:07 -0700 (PDT)
Date:   Thu, 14 Mar 2019 08:33:07 -0700 (PDT)
X-Google-Original-Date: Thu, 14 Mar 2019 15:33:03 GMT
Message-Id: <63ddb1dd040ab2a0faf3a516b97775a220ca5145.1552577586.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.161.v2.git.gitgitgadget@gmail.com>
References: <pull.161.git.gitgitgadget@gmail.com>
        <pull.161.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/4] rebase -i: demonstrate obscure loose object cache bug
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We specifically support `exec` commands in `git rebase -i`'s todo lists
to rewrite the very same todo list. Of course, we need to validate that
todo list when re-reading it.

It is also totally legitimate to extend the todo list by `pick` lines
using short names of commits that were created only after the rebase
started.

And this is where the loose object cache interferes with this feature:
if *some* loose object was read whose hash shares the same first two
digits with a commit that was not yet created when that loose object was
created, then we fail to find that new commit by its short name in
`get_oid()`, and the interactive rebase fails with an obscure error
message like:

	error: invalid line 1: pick 6568fef
	error: please fix this using 'git rebase --edit-todo'.

Let's first demonstrate that this is actually a bug in a new regression
test, in a separate commit so that other developers who do not believe
me can cherry-pick it to confirm the problem.

This new regression test generates two commits whose hashes share the
first two hex digits (so that their corresponding loose objects live in
the same subdirectory of .git/objects/, and are therefore supposed to be
in the same loose object cache bin).

It then picks the first, to make sure that the loose object cache is
initialized and cached that object directory, then generates the second
commit and picks it, too. Since the commit was generated in a different
process than the sequencer that wants to pick it, the loose object cache
had no chance of being updated in the meantime.

Technically, we would need only one `exec` command in this regression
test case, but for ease of implementation, it uses a pseudo-recursive
call to the same script.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3429-rebase-edit-todo.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/t/t3429-rebase-edit-todo.sh b/t/t3429-rebase-edit-todo.sh
index b9292dfc2a..83e5bb5eba 100755
--- a/t/t3429-rebase-edit-todo.sh
+++ b/t/t3429-rebase-edit-todo.sh
@@ -11,4 +11,26 @@ test_expect_success 'rebase exec modifies rebase-todo' '
 	test -e F
 '
 
+test_expect_failure SHA1 'loose object cache vs re-reading todo list' '
+	GIT_REBASE_TODO=.git/rebase-merge/git-rebase-todo &&
+	export GIT_REBASE_TODO &&
+	write_script append-todo.sh <<-\EOS &&
+	# For values 5 and 6, this yields SHA-1s with the same first two digits
+	echo "pick $(git rev-parse --short \
+		$(printf "%s\\n" \
+			"tree $EMPTY_TREE" \
+			"author A U Thor <author@example.org> $1 +0000" \
+			"committer A U Thor <author@example.org> $1 +0000" \
+			"" \
+			"$1" |
+		  git hash-object -t commit -w --stdin))" >>"$GIT_REBASE_TODO"
+
+	shift
+	test -z "$*" ||
+	echo "exec $0 $*" >>"$GIT_REBASE_TODO"
+	EOS
+
+	git rebase HEAD -x "./append-todo.sh 5 6"
+'
+
 test_done
-- 
gitgitgadget

