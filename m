Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC5541F461
	for <e@80x24.org>; Fri, 17 May 2019 18:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbfEQSlw (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 14:41:52 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44925 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728816AbfEQSlw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 14:41:52 -0400
Received: by mail-ed1-f65.google.com with SMTP id b8so11867490edm.11
        for <git@vger.kernel.org>; Fri, 17 May 2019 11:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CPxc0G+3MkkeQbN/pEM3v9xiJ3NU5rYrdnfDTynh4UM=;
        b=oJ5KYp01ePEXXRwD4PqfmUWEwvH9ovhDx0h8rFgVpK5ba9X1z7Lwt/YqTtzzno1gU4
         dzPTS67oXpI4LvwNSDIkG5tUaB4mV2tzEdYYCqafUjxfWYhIM515IaLOhFXh0IAKLkXX
         tita8sF0Yb0c3zvjI3c3Ad6Juabyy0Xu+K9rgFdZXk8vFxOeCUDjhSiSNnJj6bI/AAnH
         rfrfawI6DSmgbYVsT1XZqYRLcVjM4u+pXChBA2/glwic+0hJHNMN4KDVzfYiUZzw/EA/
         lvIfQYyRYG/E7QBeF8ACHvhMV0XN3thqRO7U4RBsnhYvZZsRxGRkFrC4tQtqd3plq3/p
         mWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CPxc0G+3MkkeQbN/pEM3v9xiJ3NU5rYrdnfDTynh4UM=;
        b=mg19lj04WGDPFzvrzzY8tAksS4dmoQ/HJpgEtl0cO1lkjw53BEp4O7qBvrE6ylXuIO
         Uz0HPafmRu1WaQ7W/0ku5nxuLlFWcdopyqWGOWgJinQ8ABHYx5aD/Z+fYASBSyx2+Xw+
         ZmjJwKWKjuk7sFv6kea8uBrd4s6ZeaTAKrJvWDP1ZhHFxhxvlTBnl28ee1fwincNkE+c
         d1aimaSaiGqoBQYoipmjla5j1GLRgx6/t1NiqtL2F5Wnn8WdrhlKoXF/s/k+jYgeKDhd
         0hl+NT4KbhxEf+/4hQubmFl5cG1zU/l0zoILWuRrwZrYQd5cg7Gf8t1zTpkWWb3HhPYU
         +IdQ==
X-Gm-Message-State: APjAAAUVmk+vKOqcTG0HRYGBvSRzLYYqEu6MEHQJYnp9FaDYGShTT55v
        jbwu8lYbMKmlx1CWpIP8RrXmL5c8
X-Google-Smtp-Source: APXvYqwEMqvJ7lTDnZ6mg4PTMIx5xdZY67WQzlZ7+req48JcsIIDMhSIa3X3KHs8XMW9Vvu9XeZq6g==
X-Received: by 2002:a50:8818:: with SMTP id b24mr59908052edb.28.1558118509832;
        Fri, 17 May 2019 11:41:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h5sm2923626ede.74.2019.05.17.11.41.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 11:41:49 -0700 (PDT)
Date:   Fri, 17 May 2019 11:41:49 -0700 (PDT)
X-Google-Original-Date: Fri, 17 May 2019 18:41:46 GMT
Message-Id: <0e948f639fb5209f07f8e3eb356b5886c41ff2be.1558118506.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.208.git.gitgitgadget@gmail.com>
References: <pull.208.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/3] packfile: close_all_packs to close_object_store
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The close_all_packs() method is now responsible for more than just pack-files.
It also closes the commit-graph and the multi-pack-index. Rename the function
to be more descriptive of its larger role. The name also fits because the
input parameter is a raw_object_store.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/am.c           | 2 +-
 builtin/clone.c        | 2 +-
 builtin/fetch.c        | 2 +-
 builtin/gc.c           | 4 ++--
 builtin/merge.c        | 2 +-
 builtin/rebase.c       | 2 +-
 builtin/receive-pack.c | 2 +-
 builtin/repack.c       | 2 +-
 object.c               | 2 +-
 packfile.c             | 2 +-
 packfile.h             | 2 +-
 11 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 58a2aef28b..9315d32d2a 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1800,7 +1800,7 @@ static void am_run(struct am_state *state, int resume)
 	 */
 	if (!state->rebasing) {
 		am_destroy(state);
-		close_all_packs(the_repository->objects);
+		close_object_store(the_repository->objects);
 		run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
 	}
 }
diff --git a/builtin/clone.c b/builtin/clone.c
index 50bde99618..82ce682c80 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1240,7 +1240,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	transport_disconnect(transport);
 
 	if (option_dissociate) {
-		close_all_packs(the_repository->objects);
+		close_object_store(the_repository->objects);
 		dissociate_from_references();
 	}
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index b620fd54b4..3aec95608f 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1670,7 +1670,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 
 	string_list_clear(&list, 0);
 
-	close_all_packs(the_repository->objects);
+	close_object_store(the_repository->objects);
 
 	argv_array_pushl(&argv_gc_auto, "gc", "--auto", NULL);
 	if (verbosity < 0)
diff --git a/builtin/gc.c b/builtin/gc.c
index df2573f124..20c8f1bfe8 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -632,7 +632,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	gc_before_repack();
 
 	if (!repository_format_precious_objects) {
-		close_all_packs(the_repository->objects);
+		close_object_store(the_repository->objects);
 		if (run_command_v_opt(repack.argv, RUN_GIT_CMD))
 			die(FAILED_RUN, repack.argv[0]);
 
@@ -660,7 +660,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	report_garbage = report_pack_garbage;
 	reprepare_packed_git(the_repository);
 	if (pack_garbage.nr > 0) {
-		close_all_packs(the_repository->objects);
+		close_object_store(the_repository->objects);
 		clean_pack_garbage();
 	}
 
diff --git a/builtin/merge.c b/builtin/merge.c
index e47d77baee..72d7a7c909 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -449,7 +449,7 @@ static void finish(struct commit *head_commit,
 			 * We ignore errors in 'gc --auto', since the
 			 * user should see them.
 			 */
-			close_all_packs(the_repository->objects);
+			close_object_store(the_repository->objects);
 			run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
 		}
 	}
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 7c7bc13e91..ed30fcd633 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -328,7 +328,7 @@ static int finish_rebase(struct rebase_options *opts)
 
 	delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
 	apply_autostash(opts);
-	close_all_packs(the_repository->objects);
+	close_object_store(the_repository->objects);
 	/*
 	 * We ignore errors in 'gc --auto', since the
 	 * user should see them.
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index d58b7750b6..92cd1f508c 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2032,7 +2032,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 			proc.git_cmd = 1;
 			proc.argv = argv_gc_auto;
 
-			close_all_packs(the_repository->objects);
+			close_object_store(the_repository->objects);
 			if (!start_command(&proc)) {
 				if (use_sideband)
 					copy_to_sideband(proc.err, -1, NULL);
diff --git a/builtin/repack.c b/builtin/repack.c
index 67f8978043..4de8b6600c 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -419,7 +419,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (!names.nr && !po_args.quiet)
 		printf_ln(_("Nothing new to pack."));
 
-	close_all_packs(the_repository->objects);
+	close_object_store(the_repository->objects);
 
 	/*
 	 * Ok we have prepared all new packfiles.
diff --git a/object.c b/object.c
index e81d47a79c..cf1a2b7086 100644
--- a/object.c
+++ b/object.c
@@ -517,7 +517,7 @@ void raw_object_store_clear(struct raw_object_store *o)
 	o->loaded_alternates = 0;
 
 	INIT_LIST_HEAD(&o->packed_git_mru);
-	close_all_packs(o);
+	close_object_store(o);
 	o->packed_git = NULL;
 }
 
diff --git a/packfile.c b/packfile.c
index ce12bffe3e..017046fcf9 100644
--- a/packfile.c
+++ b/packfile.c
@@ -337,7 +337,7 @@ void close_pack(struct packed_git *p)
 	close_pack_index(p);
 }
 
-void close_all_packs(struct raw_object_store *o)
+void close_object_store(struct raw_object_store *o)
 {
 	struct packed_git *p;
 
diff --git a/packfile.h b/packfile.h
index d70c6d9afb..e95e389eb8 100644
--- a/packfile.h
+++ b/packfile.h
@@ -81,7 +81,7 @@ extern uint32_t get_pack_fanout(struct packed_git *p, uint32_t value);
 extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
 extern void close_pack_windows(struct packed_git *);
 extern void close_pack(struct packed_git *);
-extern void close_all_packs(struct raw_object_store *o);
+extern void close_object_store(struct raw_object_store *o);
 extern void unuse_pack(struct pack_window **);
 extern void clear_delta_base_cache(void);
 extern struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
-- 
gitgitgadget
