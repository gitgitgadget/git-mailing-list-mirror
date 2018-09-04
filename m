Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 963F41F404
	for <e@80x24.org>; Tue,  4 Sep 2018 21:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbeIEByO (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 21:54:14 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:45318 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbeIEByO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 21:54:14 -0400
Received: by mail-pf1-f176.google.com with SMTP id i26-v6so2303579pfo.12
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 14:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KPjxsGpauR+NnQsqQxBLhz88QlYtsndNgdTxcBNmsTg=;
        b=meKJgAMDZC5LxIbQPE7/pc+sV8S9JIIFN1VYXSuiZpvK9CkcgH1ujUHezrFOjYCWvq
         HOlGfcfHTFNR5gCSaYbElh4cLsyiWMK/VhpjKmGUhdCEljzTKDV0YDCNh9fHOGdRgrj+
         ewC1lGNcOanIBfV+E0ENH52Qp2I5NIJt9Zw8/jOzvoaxDwLVlvpOPACB+tWg3iu5996y
         gQSlA18V/dR8Uen17dAt2akitlcfR/+dBVlQOCRTYn5nNE7Z6W6FoaB3cbmkn1ODVf1K
         hf3qZxUtwq41RBIRTt43kV/2dQD04MAvZPF08Ko2hZwsz2PCXAQG7/dhO29DL0WKOL7T
         b7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KPjxsGpauR+NnQsqQxBLhz88QlYtsndNgdTxcBNmsTg=;
        b=ucbmeThuA9K9Ba+2AW5MU/884a6ygQ5y0oGqq/iHprhTWkV2kPenbXEgJgTaEIgKtl
         jkNpVNght0tJ4Nf94Nbq6KoCm9bflTSsMycNXNEd43Dty7nO+K3DZYudsErZaN6TjfhF
         K9jA3v/6iwUmaip2jeJQk8DF1+9qXzwQPfqgsZbfa5CcaN7cop4FeeaSOegt/286gYZ0
         /7TP22V2zY/m3kbyJrSsTdsrannNTtAyMhqXjNNtpJBcD4l4BN+aqd0ZE8Dh5aqdbUHn
         8OB7xKIuigDStQmj2lhnOPnn/JJ+CoaLB/ljGc9CaivMOPBtlZixRlqUSevRpc7YcYqM
         NCOw==
X-Gm-Message-State: APzg51C29cX5V4RVmPK1rD2I/DsTI4rBOkI/ZX9iW91p3uQYVsmsxptp
        nwqVhpsjMWTmrebNDICJdCwbDwvb
X-Google-Smtp-Source: ANB0VdZgo/NQCfl43EPjKi5S430K0lFDNwfL4WxwNBgA7p5iZNw6soAniQxaCrM97lsRu+7j5arn0Q==
X-Received: by 2002:a62:9402:: with SMTP id m2-v6mr36627958pfe.3.1536096436951;
        Tue, 04 Sep 2018 14:27:16 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id r205-v6sm62195587pgr.11.2018.09.04.14.27.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 14:27:16 -0700 (PDT)
Date:   Tue, 04 Sep 2018 14:27:16 -0700 (PDT)
X-Google-Original-Date: Tue, 04 Sep 2018 21:27:00 GMT
Message-Id: <2ec0b744bf13b5991fb4205e7d665f807668de4f.1536096424.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.32.v2.git.gitgitgadget@gmail.com>
References: <20180808134830.19949-1-predatoramigo@gmail.com>
        <pull.32.v2.git.gitgitgadget@gmail.com>
From:   "Pratik Karki via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 07/11] builtin rebase: try to fast forward when possible
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Pratik Karki <predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pratik Karki <predatoramigo@gmail.com>

In this commit, we add support to fast forward.

Note: we will need the merge base later, therefore the call to
can_fast_forward() really needs to be the first one when testing whether
we can skip the rebase entirely (otherwise, it would make more sense to
skip the possibly expensive operation if, say, running an interactive
rebase).

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index afef0b0046..d67df28efc 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -20,6 +20,7 @@
 #include "commit.h"
 #include "diff.h"
 #include "wt-status.h"
+#include "revision.h"
 
 static char const * const builtin_rebase_usage[] = {
 	N_("git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] "
@@ -89,6 +90,12 @@ struct rebase_options {
 	struct strbuf git_am_opt;
 };
 
+static int is_interactive(struct rebase_options *opts)
+{
+	return opts->type == REBASE_INTERACTIVE ||
+		opts->type == REBASE_PRESERVE_MERGES;
+}
+
 /* Returns the filename prefixed by the state_dir */
 static const char *state_dir_path(const char *filename, struct rebase_options *opts)
 {
@@ -334,6 +341,46 @@ static int rebase_config(const char *var, const char *value, void *data)
 	return git_default_config(var, value, data);
 }
 
+/*
+ * Determines whether the commits in from..to are linear, i.e. contain
+ * no merge commits. This function *expects* `from` to be an ancestor of
+ * `to`.
+ */
+static int is_linear_history(struct commit *from, struct commit *to)
+{
+	while (to && to != from) {
+		parse_commit(to);
+		if (!to->parents)
+			return 1;
+		if (to->parents->next)
+			return 0;
+		to = to->parents->item;
+	}
+	return 1;
+}
+
+static int can_fast_forward(struct commit *onto, struct object_id *head_oid,
+			    struct object_id *merge_base)
+{
+	struct commit *head = lookup_commit(the_repository, head_oid);
+	struct commit_list *merge_bases;
+	int res;
+
+	if (!head)
+		return 0;
+
+	merge_bases = get_merge_bases(onto, head);
+	if (merge_bases && !merge_bases->next) {
+		oidcpy(merge_base, &merge_bases->item->object.oid);
+		res = !oidcmp(merge_base, &onto->object.oid);
+	} else {
+		oidcpy(merge_base, &null_oid);
+		res = 0;
+	}
+	free_commit_list(merge_bases);
+	return res && is_linear_history(onto, head);
+}
+
 int cmd_rebase(int argc, const char **argv, const char *prefix)
 {
 	struct rebase_options options = {
@@ -489,6 +536,31 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		goto cleanup;
 	}
 
+	/*
+	 * Now we are rebasing commits upstream..orig_head (or with --root,
+	 * everything leading up to orig_head) on top of onto.
+	 */
+
+	/*
+	 * Check if we are already based on onto with linear history,
+	 * but this should be done only when upstream and onto are the same
+	 * and if this is not an interactive rebase.
+	 */
+	if (can_fast_forward(options.onto, &options.orig_head, &merge_base) &&
+	    !is_interactive(&options) && !options.restrict_revision &&
+	    !oidcmp(&options.upstream->object.oid, &options.onto->object.oid)) {
+		int flag;
+
+		if (!(options.flags & REBASE_NO_QUIET))
+			; /* be quiet */
+		else if (!strcmp(branch_name, "HEAD") &&
+			 resolve_ref_unsafe("HEAD", 0, NULL, &flag))
+			puts(_("HEAD is up to date, rebase forced."));
+		else
+			printf(_("Current branch %s is up to date, rebase "
+				 "forced.\n"), branch_name);
+	}
+
 	/* If a hook exists, give it a chance to interrupt*/
 	if (!ok_to_skip_pre_rebase &&
 	    run_hook_le(NULL, "pre-rebase", options.upstream_arg,
-- 
gitgitgadget

