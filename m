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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7752F1F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 12:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfKOMg0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 07:36:26 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40346 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbfKOMg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 07:36:26 -0500
Received: by mail-wm1-f68.google.com with SMTP id f3so10220146wmc.5
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 04:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yO8QELRYSOGRCMmUJzAAgtHHdp9045aexiyPkjpgcSE=;
        b=NBt0fehobPn3S6E5nUze+jUGGuOe9E/ZBTUj7i00QW/v0C9IOZfsIwH/kgCDu68yXJ
         zgUDDZG4oJ/8FCk8aBQIzCr1PF2XHARn7FItJOb6h0KTrNtTy4mHGXBOT8nWjoFEchss
         JZTLPxGhaZ9mfIKMla+2kOSQCDz6Xe1R5wBgvxQZRl0OEV+K4ky8eunCDZU7pfbY7WuQ
         zlRheyBoA+c/aE8EVhbulTkt+FnJPbtcOS+8tnhR+1ma5a/6R/5G4Miz/wv1w8Ik17XN
         Jra7npxpF2ILOTnpUowK9ByPXFfKsjmYUuSWxrnA9dTI1waJvoT9cQrfPpT4VI4s3qPw
         K+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yO8QELRYSOGRCMmUJzAAgtHHdp9045aexiyPkjpgcSE=;
        b=lQ5z2l2oKQrfsYV3dZc6/LBxXyP51Ijh2+n17tkvPj71mQ8B9BYL6N4v96jsJ9iJ5p
         mTdbw661+WMMWTUmSJNaO4uCnN7m6DJBUxKcEvWzmVvyZKW85RQ7U/8ZuBHmCqb2dYyP
         oqinfJ6bxPmZ1ZxqQH3B3CxFKDawEItVVZsX9YBMNCvRJMvYLN+ICB9Xj05RKsjJ/3BU
         GNzQjxEx+Wh6QoUSYFSFkTWsN8Rd/H2U6sV0hq+WEu0oW/37w14w6gXRaeCiovdS1uh7
         4ubCy/YK+bGYHqrW2+KyDkkfC2DzRD2C/CtFkAj3zksh6tgJkYjdsN9Nwfp3wQmeA4PV
         uYiA==
X-Gm-Message-State: APjAAAWAFhBtBodxWsB3mlwx5XBgkKEYfvW8z6SEkqppV8VMZAqsEpcu
        wZi/aLeAiBteI4GtWOOzTrcDC521
X-Google-Smtp-Source: APXvYqwGRjeKlExuzaDmH7VgbeP6secidQxRpC3Jn7RsGzGWT4+i3DQns/YK4brTfQO7CQADNE6lMQ==
X-Received: by 2002:a7b:ce11:: with SMTP id m17mr13074012wmc.123.1573821384234;
        Fri, 15 Nov 2019 04:36:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m15sm11753187wrq.97.2019.11.15.04.36.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 04:36:23 -0800 (PST)
Message-Id: <1844c4d55e21c40cbdbfdd73c82b4a1a074ff184.1573821382.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.171.git.1573821382.gitgitgadget@gmail.com>
References: <pull.171.git.1573821382.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 Nov 2019 12:36:15 +0000
Subject: [PATCH 1/8] built-in add -i: allow filtering the modified files list
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

In the `update` command of `git add -i`, we are primarily interested in the
list of modified files that have worktree (i.e. unstaged) changes.

At the same time, we need to determine _also_ the staged changes, to be
able to produce the full added/deleted information.

The Perl script version of `git add -i` has a parameter of the
`list_modified()` function for that matter. In C, we can be a lot more
precise, using an `enum`.

The C implementation of the filter also has an easier time to avoid
unnecessary work, simply by using an adaptive order of the `diff-index`
and `diff-files` phases, and then skipping files in the second phase
when they have not been seen in the first phase.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 5d89863bab..8ec930ac15 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -347,6 +347,7 @@ struct collection_status {
 
 	const char *reference;
 
+	unsigned skip_unseen:1;
 	struct string_list *files;
 	struct hashmap file_map;
 };
@@ -374,6 +375,9 @@ static void collect_changes_cb(struct diff_queue_struct *q,
 		entry = hashmap_get_entry_from_hash(&s->file_map, hash, name,
 						    struct pathname_entry, ent);
 		if (!entry) {
+			if (s->skip_unseen)
+				continue;
+
 			add_file_item(s->files, name);
 
 			entry = xcalloc(sizeof(*entry), 1);
@@ -395,13 +399,22 @@ static void collect_changes_cb(struct diff_queue_struct *q,
 	free_diffstat_info(&stat);
 }
 
-static int get_modified_files(struct repository *r, struct string_list *files,
+enum modified_files_filter {
+	NO_FILTER = 0,
+	WORKTREE_ONLY = 1,
+	INDEX_ONLY = 2,
+};
+
+static int get_modified_files(struct repository *r,
+			      enum modified_files_filter filter,
+			      struct string_list *files,
 			      const struct pathspec *ps)
 {
 	struct object_id head_oid;
 	int is_initial = !resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
 					     &head_oid, NULL);
 	struct collection_status s = { FROM_WORKTREE };
+	int i;
 
 	if (discard_index(r->index) < 0 ||
 	    repo_read_index_preload(r, ps, 0) < 0)
@@ -411,10 +424,16 @@ static int get_modified_files(struct repository *r, struct string_list *files,
 	s.files = files;
 	hashmap_init(&s.file_map, pathname_entry_cmp, NULL, 0);
 
-	for (s.phase = FROM_WORKTREE; s.phase <= FROM_INDEX; s.phase++) {
+	for (i = 0; i < 2; i++) {
 		struct rev_info rev;
 		struct setup_revision_opt opt = { 0 };
 
+		if (filter == INDEX_ONLY)
+			s.phase = i ? FROM_WORKTREE : FROM_INDEX;
+		else
+			s.phase = i ? FROM_INDEX : FROM_WORKTREE;
+		s.skip_unseen = filter && i;
+
 		opt.def = is_initial ?
 			empty_tree_oid_hex() : oid_to_hex(&head_oid);
 
@@ -498,7 +517,7 @@ static void print_file_item(int i, struct string_list_item *item,
 static int run_status(struct add_i_state *s, const struct pathspec *ps,
 		      struct string_list *files, struct list_options *opts)
 {
-	if (get_modified_files(s->r, files, ps) < 0)
+	if (get_modified_files(s->r, NO_FILTER, files, ps) < 0)
 		return -1;
 
 	list(s, files, opts);
-- 
gitgitgadget

