Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA94B1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 11:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbeKLVhZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 16:37:25 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36320 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728302AbeKLVhZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 16:37:25 -0500
Received: by mail-pl1-f196.google.com with SMTP id w24-v6so4254143plq.3
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 03:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TSKHKgv2TzfUvBiYxx9er5v4tnRLDKXojvS9K+o3yqg=;
        b=TuWlYu+1RxF7//PSfIigpMrez8p72NnpG42obnXzf0BWC16EV/GqPVt5o9LGQSKFz6
         k6AdTUSkKCAthEZ5vJltvIuuJoau+51k3JH0XvJhz+3ejYCRAgFDBn/dixg7yb+89HMf
         GkwNLMtEdAAPRQIm1f9Ghol9pzCxZQ0uhJcILzO1DAqEpcVQhuJyIJAjar+OkQjgR9yL
         yeY/0MnEkHSz/9RrnbbyCIJnz9o3XTgUQiQSGOPX06+wqgRk7w0PHJCVocvqaRUpFBtv
         fH44QaEVzkFituSbuzjz6MPr2D1f109hY6rSMDlPofm75I9EXf3YXqupYV71ZE5CyFQ/
         CNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TSKHKgv2TzfUvBiYxx9er5v4tnRLDKXojvS9K+o3yqg=;
        b=J3KLmleaEoUcTEQ7tuAoWIdGyhsD8CJe5wiUINvKljtTOBea7iYvV1RWoiDT5IiS0S
         YMoumBObbpCgwW41JmR7MyE49Uf96PtdNmnzgKkwuqWMQuAbVfafI83s8NpWgZ0FzNgC
         sO4EaF4Uo3i7u0nQfkk/dtRNUei+IQzco8fK6SaPigbFpRlHVQdVVa1bMvvJLrtlQpFW
         U8aax4+iAKYN3/uF9M8/IW1APTz90IEFYL0pnt1IwkHpuh2IpEod92Bpg7yy60e+p9CR
         cTq8/u9fSDQA0ltAeb5z24Q8Bn1DviUku8A2lQ3Sai32nmiumbuBHgTWYfHOlHP93re9
         VTKQ==
X-Gm-Message-State: AGRZ1gKJQrpwv1AnulEJswE/AHNQ2SxvFTAUS8AwuDjQfl6bxxPXzHOe
        3V8JAqO4iNHFjG6ILKzdpJ4IVX/K
X-Google-Smtp-Source: AJdET5c0/uw1EpSlCo/ZvSp7nv3X70Lxko0EGaLqwRsYN3A0GmcatebPnKx0V5iqlfnNiIHF+s93ng==
X-Received: by 2002:a17:902:66e5:: with SMTP id e92-v6mr624408plk.92.1542023070726;
        Mon, 12 Nov 2018 03:44:30 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id i189-v6sm18255038pfg.156.2018.11.12.03.44.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 03:44:30 -0800 (PST)
Date:   Mon, 12 Nov 2018 03:44:30 -0800 (PST)
X-Google-Original-Date: Mon, 12 Nov 2018 11:44:24 GMT
Message-Id: <28e24d98abad95996b78f346a505171bccfdf547.1542023066.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.72.v2.git.gitgitgadget@gmail.com>
References: <pull.72.git.gitgitgadget@gmail.com>
        <pull.72.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/3] rebase: consolidate clean-up code before leaving
 reset_head()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The same clean-up code is repeated quite a few times; Let's DRY up the
code some.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 0ee06aa363..e173654d56 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -541,13 +541,15 @@ static int reset_head(struct object_id *oid, const char *action,
 	if (switch_to_branch && !starts_with(switch_to_branch, "refs/"))
 		BUG("Not a fully qualified branch: '%s'", switch_to_branch);
 
-	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0)
-		return -1;
+	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0) {
+		ret = -1;
+		goto leave_reset_head;
+	}
 
 	if (!oid) {
 		if (get_oid("HEAD", &head_oid)) {
-			rollback_lock_file(&lock);
-			return error(_("could not determine HEAD revision"));
+			ret = error(_("could not determine HEAD revision"));
+			goto leave_reset_head;
 		}
 		oid = &head_oid;
 	}
@@ -564,32 +566,27 @@ static int reset_head(struct object_id *oid, const char *action,
 		unpack_tree_opts.reset = 1;
 
 	if (read_index_unmerged(the_repository->index) < 0) {
-		rollback_lock_file(&lock);
-		return error(_("could not read index"));
+		ret = error(_("could not read index"));
+		goto leave_reset_head;
 	}
 
 	if (!fill_tree_descriptor(&desc, oid)) {
-		error(_("failed to find tree of %s"), oid_to_hex(oid));
-		rollback_lock_file(&lock);
-		free((void *)desc.buffer);
-		return -1;
+		ret = error(_("failed to find tree of %s"), oid_to_hex(oid));
+		goto leave_reset_head;
 	}
 
 	if (unpack_trees(1, &desc, &unpack_tree_opts)) {
-		rollback_lock_file(&lock);
-		free((void *)desc.buffer);
-		return -1;
+		ret = -1;
+		goto leave_reset_head;
 	}
 
 	tree = parse_tree_indirect(oid);
 	prime_cache_tree(the_repository->index, tree);
 
-	if (write_locked_index(the_repository->index, &lock, COMMIT_LOCK) < 0)
+	if (write_locked_index(the_repository->index, &lock, COMMIT_LOCK) < 0) {
 		ret = error(_("could not write index"));
-	free((void *)desc.buffer);
-
-	if (ret)
-		return ret;
+		goto leave_reset_head;
+	}
 
 	reflog_action = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
 	strbuf_addf(&msg, "%s: ", reflog_action ? reflog_action : "rebase");
@@ -622,7 +619,10 @@ static int reset_head(struct object_id *oid, const char *action,
 					 UPDATE_REFS_MSG_ON_ERR);
 	}
 
+leave_reset_head:
 	strbuf_release(&msg);
+	rollback_lock_file(&lock);
+	free((void *)desc.buffer);
 	return ret;
 }
 
-- 
gitgitgadget

