Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B78A91F453
	for <e@80x24.org>; Tue, 30 Oct 2018 14:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbeJ3XJs (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 19:09:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46889 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbeJ3XJr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 19:09:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id r64-v6so5898312pfb.13
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 07:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=q8+PCChIvI17zClm5NXMAMGHZU8A/a/avzv/EP3JNNA=;
        b=TF5D1ZZsGH5bWtw/RHjIuSAi65CK4ZbnFQtPkCaGFknqPk9/uuPrJAI2ClPMenCvD4
         LJzBPamrQOUsJOCHrzZPVkO+0gfs/oUdMxJOuRKIgIvqCdYS0fBG8uFQMvAGQitE45wm
         G6Bmgv0C9KDT/CwsMAWwnfjPJmzfBEda7983h5pL2nvJ60u4PzFUYI4WCLkHeTlJDsFq
         pRzsJo7h+aNB0U3FcX+YvjPcHo9xUpLNH+V4eBouJ8NkiMFjGUFQ3PsdByPf8OHIMMGZ
         55m+L9/nLa6ER71ETAsVTHON8SO7OVCUlNVdQRlyScZW6/dAEouvED/ICb9RF4VfojfE
         Snpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=q8+PCChIvI17zClm5NXMAMGHZU8A/a/avzv/EP3JNNA=;
        b=eZ5pdmTUGJt+5fgcZY+TAz4RNWu4icQ/wzdQfI1XHqaO1vGWlwZtIMzydxpdHBEgau
         FOru0rXhuBLiAqyAG1rSBUS8/+i8feEQ+HivFER1zAdULAmQrBqBuCxwCt1XemEIalw/
         eDHOgM6kBIiTfwRlxpEDfcohy7+pAas38zYRfDQSv2UiqCLJNyd1N+ifHlzQV5+Eparx
         nfmRjKwMomMxLMcuJ003pl3N5IoF7gVaTCQ+s1KSlQVuPxASZ+eKd+iXZR2KDTqKs/7u
         6cExjCNvXHXI9OK7GUYClWZsyQMGGC85dE1HoyvM0QSEmoz/cCwBCMD1pzA5utw0ORDc
         pbvw==
X-Gm-Message-State: AGRZ1gLsp2ow8eBjswF8+55TyApFFZpVVI2ujtJS1D+HCSVKUdWXbBrK
        zA1kKnOLlKQmAKfhUVv5kzV+Pnpc
X-Google-Smtp-Source: AJdET5fLnCzR9SfqSuVUSnLGPoQ3VCsG/58kd2vMwTIlmqx7Lphq3LGoch3tmP7J9sydNu3QmC3vsA==
X-Received: by 2002:a62:2606:: with SMTP id m6-v6mr3146189pfm.104.1540908968024;
        Tue, 30 Oct 2018 07:16:08 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id p64-v6sm22917036pfi.22.2018.10.30.07.16.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 07:16:07 -0700 (PDT)
Date:   Tue, 30 Oct 2018 07:16:07 -0700 (PDT)
X-Google-Original-Date: Tue, 30 Oct 2018 14:16:00 GMT
Message-Id: <ecbed3de5c704a5d54a910a527b60eb79f0d252e.1540908961.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.60.git.gitgitgadget@gmail.com>
References: <pull.60.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/3] remote: make add_missing_tags() linear
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, newren@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The add_missing_tags() method currently has quadratic behavior.
This is due to a linear number (based on number of tags T) of
calls to in_merge_bases_many, which has linear performance (based
on number of commits C in the repository).

Replace this O(T * C) algorithm with an O(T + C) algorithm by
using get_reachable_subset(). We ignore the return list and focus
instead on the reachable_flag assigned to the commits we care
about, because we need to interact with the tag ref and not just
the commit object.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 remote.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index 81f4f01b0..b850f2feb 100644
--- a/remote.c
+++ b/remote.c
@@ -1205,9 +1205,36 @@ static void add_missing_tags(struct ref *src, struct ref **dst, struct ref ***ds
 	 * sent to the other side.
 	 */
 	if (sent_tips.nr) {
+		const int reachable_flag = 1;
+		struct commit_list *found_commits;
+		struct commit **src_commits;
+		int nr_src_commits = 0, alloc_src_commits = 16;
+		ALLOC_ARRAY(src_commits, alloc_src_commits);
+
 		for_each_string_list_item(item, &src_tag) {
 			struct ref *ref = item->util;
+			struct commit *commit;
+
+			if (is_null_oid(&ref->new_oid))
+				continue;
+			commit = lookup_commit_reference_gently(the_repository,
+								&ref->new_oid,
+								1);
+			if (!commit)
+				/* not pushing a commit, which is not an error */
+				continue;
+
+			ALLOC_GROW(src_commits, nr_src_commits + 1, alloc_src_commits);
+			src_commits[nr_src_commits++] = commit;
+		}
+
+		found_commits = get_reachable_subset(sent_tips.tip, sent_tips.nr,
+						     src_commits, nr_src_commits,
+						     reachable_flag);
+
+		for_each_string_list_item(item, &src_tag) {
 			struct ref *dst_ref;
+			struct ref *ref = item->util;
 			struct commit *commit;
 
 			if (is_null_oid(&ref->new_oid))
@@ -1223,7 +1250,7 @@ static void add_missing_tags(struct ref *src, struct ref **dst, struct ref ***ds
 			 * Is this tag, which they do not have, reachable from
 			 * any of the commits we are sending?
 			 */
-			if (!in_merge_bases_many(commit, sent_tips.nr, sent_tips.tip))
+			if (!(commit->object.flags & reachable_flag))
 				continue;
 
 			/* Add it in */
@@ -1231,7 +1258,12 @@ static void add_missing_tags(struct ref *src, struct ref **dst, struct ref ***ds
 			oidcpy(&dst_ref->new_oid, &ref->new_oid);
 			dst_ref->peer_ref = copy_ref(ref);
 		}
+
+		clear_commit_marks_many(nr_src_commits, src_commits, reachable_flag);
+		free(src_commits);
+		free_commit_list(found_commits);
 	}
+
 	string_list_clear(&src_tag, 0);
 	free(sent_tips.tip);
 }
-- 
gitgitgadget
