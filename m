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
	by dcvr.yhbt.net (Postfix) with ESMTP id 259531F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 06:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbfJHGsz (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 02:48:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40420 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbfJHGsy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 02:48:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so9210271wrv.7
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 23:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kYQjLVg9dKacN/WBqtDPSlSmGROx1dcFMkMkQL/5eeI=;
        b=uRdUCr8vm5YwX3bXEcwYhAUszPUDdNLqgZiWpLaYqIHlbZsAL4El0Ifj+pS9ZJhc/l
         h+atyGlbbuDmwPBAq4tQmscMM75kvycM3grsfz7aXwZrd51Ie7l51dNSp3dVJQ4+dd/W
         B8K0F3aozLiLuVQyYmAzhbrR+884xGMYf8350XtMcTRHZ+3YA5AKlp3gP4FD0pr4zp9x
         Z4T4NvNxB1se4Pz0HGyGOdP3ZnvK7Jv4S83RkFqPIWQhuXZCVpOTbmwTsib5L/6Lc7nC
         gNpacTsXMGmBuGjiC/LxA6NOVYrUkubi5euT8I5ap1xMIHtzgkW36R9rxCLslDl2cWT8
         k08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kYQjLVg9dKacN/WBqtDPSlSmGROx1dcFMkMkQL/5eeI=;
        b=ii76a/XP9XZZtenjHFNADXtV9VyGRnlojzc/p9dXpYeNBbRmEIwvjkg5QpIUH3bdlV
         PRVaWKhErrPrrjoHZ7/R1Zy9CKErFMtqtR97XBZPVIjy46xRFe5goWqMRGuFoTAL5MkP
         cIOwBEceQMg/8ADlpdopQjP/j1EB4sKl+Aip2xrO0K58/A5KBpP5UrC9HG6agd+zM2Q8
         NaIL0aKTwS+LmfC0+kakK7e835K0Y6c8/ZTl2i5tFt/fmWD3AnrgMxX4kZkUsjl369IV
         dhGx8fSyDue5D9SnsUVG6qX23eOXSicxnBmFWUW5guynqHwDSWCY3WUHYh+ht9LLGxzR
         yPgw==
X-Gm-Message-State: APjAAAUlorbpprgdJjl8H5SclLpXEAg+Dp+nVewbYOjOCQm2Ma+RRxM5
        yYgIMU5cTn/n3KOikwxYOLYG/nlg
X-Google-Smtp-Source: APXvYqyCYJ2hIHPc6QWbPmbXFbSVu5y4P0k0ytqpDng8huhEMp+4/VTW7+XVRECMH3f53UwCusva3g==
X-Received: by 2002:adf:ea12:: with SMTP id q18mr14869271wrm.323.1570517331840;
        Mon, 07 Oct 2019 23:48:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a192sm1674881wma.1.2019.10.07.23.48.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 23:48:51 -0700 (PDT)
Date:   Mon, 07 Oct 2019 23:48:51 -0700 (PDT)
X-Google-Original-Date: Tue, 08 Oct 2019 06:48:49 GMT
Message-Id: <81648344bbab4219c0bfc60d1e5f02473ea7d495.1570517329.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.378.git.gitgitgadget@gmail.com>
References: <pull.378.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] Add a helper to reverse index_pos_to_insert_pos()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We have just introduced the helper `index_pos_to_insert_pos()` to help
avoiding underflows when returning `-1 - pos` for cases where we want to
return an insert position, using the ones' complement (as `int`).

As pointed out during the review of the patch series that introduced it,
this helper wants to be accompanied by a helper that reverse that ones'
complement, for clarity. This patch does exactly that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 blame.c           | 5 +++--
 builtin/mv.c      | 2 +-
 cache.h           | 5 +++++
 merge-recursive.c | 4 ++--
 read-cache.c      | 2 +-
 rerere.c          | 2 +-
 sha1-name.c       | 2 +-
 submodule.c       | 2 +-
 unpack-trees.c    | 2 +-
 9 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/blame.c b/blame.c
index 145eaf2faf..848355923d 100644
--- a/blame.c
+++ b/blame.c
@@ -109,8 +109,9 @@ static void verify_working_tree_path(struct repository *r,
 	pos = index_name_pos(r->index, path, strlen(path));
 	if (pos >= 0)
 		; /* path is in the index */
-	else if (-1 - pos < r->index->cache_nr &&
-		 !strcmp(r->index->cache[-1 - pos]->name, path))
+	else if (insert_pos_to_index_pos(pos) < r->index->cache_nr &&
+		 !strcmp(r->index->cache[insert_pos_to_index_pos(pos)]->name,
+			 path))
 		; /* path is in the index, unmerged */
 	else
 		die("no such path '%s' in HEAD", path);
diff --git a/builtin/mv.c b/builtin/mv.c
index be15ba7044..9ebb1ed0a2 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -102,7 +102,7 @@ static int index_range_of_same_dir(const char *src, int length,
 	if (first >= 0)
 		die(_("%.*s is in index"), len_w_slash, src_w_slash);
 
-	first = -1 - first;
+	first = insert_pos_to_index_pos(first);
 	for (last = first; last < active_nr; last++) {
 		const char *path = active_cache[last]->name;
 		if (strncmp(path, src_w_slash, len_w_slash))
diff --git a/cache.h b/cache.h
index 850e7b945a..8fb57db091 100644
--- a/cache.h
+++ b/cache.h
@@ -738,6 +738,11 @@ static inline int index_pos_to_insert_pos(uintmax_t pos)
 	return -1 - (int)pos;
 }
 
+static inline int insert_pos_to_index_pos(int pos)
+{
+	return -1 - pos;
+}
+
 #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
 #define ADD_CACHE_OK_TO_REPLACE 2	/* Ok to replace file/directory */
 #define ADD_CACHE_SKIP_DFCHECK 4	/* Ok to skip DF conflict checks */
diff --git a/merge-recursive.c b/merge-recursive.c
index d2e380b7ed..8dca01a279 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -753,7 +753,7 @@ static int dir_in_way(struct index_state *istate, const char *path,
 	pos = index_name_pos(istate, dirpath.buf, dirpath.len);
 
 	if (pos < 0)
-		pos = -1 - pos;
+		pos = insert_pos_to_index_pos(pos);
 	if (pos < istate->cache_nr &&
 	    !strncmp(dirpath.buf, istate->cache[pos]->name, dirpath.len)) {
 		strbuf_release(&dirpath);
@@ -822,7 +822,7 @@ static int would_lose_untracked(struct merge_options *opt, const char *path)
 	int pos = index_name_pos(istate, path, strlen(path));
 
 	if (pos < 0)
-		pos = -1 - pos;
+		pos = insert_pos_to_index_pos(pos);
 	while (pos < istate->cache_nr &&
 	       !strcmp(path, istate->cache[pos]->name)) {
 		/*
diff --git a/read-cache.c b/read-cache.c
index ec13953a21..ac3b0f8e5c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -641,7 +641,7 @@ static int index_name_pos_also_unmerged(struct index_state *istate,
 		return pos;
 
 	/* maybe unmerged? */
-	pos = -1 - pos;
+	pos = insert_pos_to_index_pos(pos);
 	if (pos >= istate->cache_nr ||
 			compare_name((ce = istate->cache[pos]), path, namelen))
 		return -1;
diff --git a/rerere.c b/rerere.c
index 17abb47321..122ebed5d8 100644
--- a/rerere.c
+++ b/rerere.c
@@ -154,7 +154,7 @@ static struct rerere_dir *find_rerere_dir(const char *hex)
 		rr_dir->status = NULL;
 		rr_dir->status_nr = 0;
 		rr_dir->status_alloc = 0;
-		pos = -1 - pos;
+		pos = insert_pos_to_index_pos(pos);
 
 		/* Make sure the array is big enough ... */
 		ALLOC_GROW(rerere_dir, rerere_dir_nr + 1, rerere_dir_alloc);
diff --git a/sha1-name.c b/sha1-name.c
index 49855ad24f..bee7ce39ee 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -98,7 +98,7 @@ static void find_short_object_filename(struct disambiguate_state *ds)
 		loose_objects = odb_loose_cache(odb, &ds->bin_pfx);
 		pos = oid_array_lookup(loose_objects, &ds->bin_pfx);
 		if (pos < 0)
-			pos = -1 - pos;
+			pos = insert_pos_to_index_pos(pos);
 		while (!ds->ambiguous && pos < loose_objects->nr) {
 			const struct object_id *oid;
 			oid = loose_objects->oid + pos;
diff --git a/submodule.c b/submodule.c
index 0f199c5137..4cab9100ea 100644
--- a/submodule.c
+++ b/submodule.c
@@ -37,7 +37,7 @@ int is_gitmodules_unmerged(const struct index_state *istate)
 {
 	int pos = index_name_pos(istate, GITMODULES_FILE, strlen(GITMODULES_FILE));
 	if (pos < 0) { /* .gitmodules not found or isn't merged */
-		pos = -1 - pos;
+		pos = insert_pos_to_index_pos(pos);
 		if (istate->cache_nr > pos) {  /* there is a .gitmodules */
 			const struct cache_entry *ce = istate->cache[pos];
 			if (ce_namelen(ce) == strlen(GITMODULES_FILE) &&
diff --git a/unpack-trees.c b/unpack-trees.c
index dab713203e..abb33ce259 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -553,7 +553,7 @@ static int locate_in_src_index(const struct cache_entry *ce,
 	int len = ce_namelen(ce);
 	int pos = index_name_pos(index, ce->name, len);
 	if (pos < 0)
-		pos = -1 - pos;
+		pos = insert_pos_to_index_pos(pos);
 	return pos;
 }
 
-- 
gitgitgadget
