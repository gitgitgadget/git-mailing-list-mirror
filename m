Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93A7E211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 15:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbeLFPmP (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 10:42:15 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35650 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbeLFPmP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 10:42:15 -0500
Received: by mail-lj1-f196.google.com with SMTP id x85-v6so831359ljb.2
        for <git@vger.kernel.org>; Thu, 06 Dec 2018 07:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9evXNk/+H2Fvlvhwd7uCBCwJh/ZmvRZ3enmmhcWDXtY=;
        b=r9Gpw0vplr1CWCidevu5pjWnv5M5KPVKsh6icJqnOJzvFZX28P24nlAqtdo+smNcJU
         66MFZoh4ESnCYx0EgNKDKUjF80WxJJTUTp2Rh7MRB54AIXq1ZX+W0LVo2/bTsMnOFOmU
         K3/5ZNDg8J0xP+ToaTbTAuc7S2Q+Q45u9VB5vc5Nk8FfK+4l7UFstd/2gJrKODtpq+iF
         csfdeU6mKaB3OZGNs+ASx16YMszdxvcXltJ6xLfUlhBlrR/vRuJTwpAkOtd60Vi2NmSi
         wChIkdpIpXDDXwBVlBAlM1/+K1FBbe211rfxMTKvJMLR4smYmOhCr+QnI23zRN8FOAfP
         60/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9evXNk/+H2Fvlvhwd7uCBCwJh/ZmvRZ3enmmhcWDXtY=;
        b=CFV7jQSzcWaQhZ9amFRJ5OFaJQgalcEMrj680geOR1G15GemVb6elKejhPP/51j3t9
         EMMeQHGOcCoWWsThVPbRWavZfH0OVH6bHLfOcz0jyOaFtHmRf0mM4hdDbXeB5L3jBzTZ
         JV2djJ2thC33LrBxmsnMblyYpkf5idcVPm+RUuyZxiwjDzTmmimqHU5T4ICDBbd2qL46
         dV32wVp+Wz+CGAUCciHA/9zJ1mwSgJ7PVFc01kgXv39IvAZ4vNzo+UQw8pbgwI2dYgLG
         wjvB0UQAohJwPCRbAJuAxi5Bc9jh/fERCUNrix02ycEPI0Fh2QiGhPCdIfq9kwM54Mr3
         9V4w==
X-Gm-Message-State: AA+aEWaInaxb1268+bUwmQ223yZBXTBknPnsAkNhcKolgPAl1OqHoDcR
        5v9keA1nVOpQczv7qW8TdLZIaMn8
X-Google-Smtp-Source: AFSGD/VZatNRv4OZ0h6My1a81XxQpO19oCLSvHbJkK/kDLl5eUNq7xRQKdcQ+IQ9hVTOttMsRZrUWA==
X-Received: by 2002:a2e:3603:: with SMTP id d3-v6mr18394957lja.46.1544110931797;
        Thu, 06 Dec 2018 07:42:11 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id i13-v6sm115250ljg.82.2018.12.06.07.42.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 07:42:10 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] Indent code with TABs
Date:   Thu,  6 Dec 2018 16:42:06 +0100
Message-Id: <20181206154206.16197-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.461.g47d1d16d8d
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We indent with TABs and sometimes for fine alignment, TABs followed by
spaces, but never all spaces (unless the indentation is less than 8
columns). Indenting with spaces slips through in some places. Fix
them.

Imported code and compat/ are left alone on purpose. The former should
remain as close as upstream as possible. The latter pretty much has
separate maintainers, it's up to them to decide.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Should be quite safe to merge since "git diff -b" is empty

 archive-tar.c     |   2 +-
 archive.c         |   4 +-
 builtin/add.c     |   2 +-
 builtin/gc.c      |   2 +-
 cache-tree.c      |   2 +-
 convert.c         |   6 +--
 git-compat-util.h |   2 +-
 parse-options.c   |   2 +-
 parse-options.h   |   6 +--
 quote.c           |   2 +-
 read-cache.c      | 118 +++++++++++++++++++++++-----------------------
 revision.c        |   4 +-
 symlinks.c        |   2 +-
 13 files changed, 77 insertions(+), 77 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index a58e1a8ebf..4aabd566fb 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -142,7 +142,7 @@ static int stream_blocked(const struct object_id *oid)
  * string and appends it to a struct strbuf.
  */
 static void strbuf_append_ext_header(struct strbuf *sb, const char *keyword,
-                                     const char *value, unsigned int valuelen)
+				     const char *value, unsigned int valuelen)
 {
 	int len, tmp;
 
diff --git a/archive.c b/archive.c
index fd556c28e4..c2fe16ad33 100644
--- a/archive.c
+++ b/archive.c
@@ -36,8 +36,8 @@ void init_archivers(void)
 }
 
 static void format_subst(const struct commit *commit,
-                         const char *src, size_t len,
-                         struct strbuf *buf)
+			 const char *src, size_t len,
+			 struct strbuf *buf)
 {
 	char *to_free = NULL;
 	struct strbuf fmt = STRBUF_INIT;
diff --git a/builtin/add.c b/builtin/add.c
index f65c172299..12247b48fd 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -176,7 +176,7 @@ static void refresh(int verbose, const struct pathspec *pathspec)
 			die(_("pathspec '%s' did not match any files"),
 			    pathspec->items[i].match);
 	}
-        free(seen);
+	free(seen);
 }
 
 int run_add_interactive(const char *revision, const char *patch_mode,
diff --git a/builtin/gc.c b/builtin/gc.c
index 871a56f1c5..7696017cd4 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -317,7 +317,7 @@ static void add_repack_all_option(struct string_list *keep_pack)
 
 static void add_repack_incremental_option(void)
 {
-       argv_array_push(&repack, "--no-write-bitmap-index");
+	argv_array_push(&repack, "--no-write-bitmap-index");
 }
 
 static int need_to_gc(void)
diff --git a/cache-tree.c b/cache-tree.c
index 9d454d24bc..d6dbbebfb2 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -448,7 +448,7 @@ int cache_tree_update(struct index_state *istate, int flags)
 }
 
 static void write_one(struct strbuf *buffer, struct cache_tree *it,
-                      const char *path, int pathlen)
+		      const char *path, int pathlen)
 {
 	int i;
 
diff --git a/convert.c b/convert.c
index e0848226d2..5f60c11ce0 100644
--- a/convert.c
+++ b/convert.c
@@ -705,7 +705,7 @@ static int filter_buffer_or_fd(int in, int out, void *data)
 }
 
 static int apply_single_file_filter(const char *path, const char *src, size_t len, int fd,
-                        struct strbuf *dst, const char *cmd)
+				    struct strbuf *dst, const char *cmd)
 {
 	/*
 	 * Create a pipeline to have the command filter the buffer's
@@ -1091,7 +1091,7 @@ static int count_ident(const char *cp, unsigned long size)
 }
 
 static int ident_to_git(const char *path, const char *src, size_t len,
-                        struct strbuf *buf, int ident)
+			struct strbuf *buf, int ident)
 {
 	char *dst, *dollar;
 
@@ -1135,7 +1135,7 @@ static int ident_to_git(const char *path, const char *src, size_t len,
 }
 
 static int ident_to_worktree(const char *path, const char *src, size_t len,
-                             struct strbuf *buf, int ident)
+			     struct strbuf *buf, int ident)
 {
 	struct object_id oid;
 	char *to_free = NULL, *dollar, *spc;
diff --git a/git-compat-util.h b/git-compat-util.h
index 09b0102cae..f281aa5185 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -721,7 +721,7 @@ extern const char *githstrerror(int herror);
 #ifdef NO_MEMMEM
 #define memmem gitmemmem
 void *gitmemmem(const void *haystack, size_t haystacklen,
-                const void *needle, size_t needlelen);
+		const void *needle, size_t needlelen);
 #endif
 
 #ifdef OVERRIDE_STRDUP
diff --git a/parse-options.c b/parse-options.c
index 3b874a83a0..27353c8e8d 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -236,7 +236,7 @@ static int parse_short_opt(struct parse_opt_ctx_t *p, const struct option *optio
 }
 
 static int parse_long_opt(struct parse_opt_ctx_t *p, const char *arg,
-                          const struct option *options)
+			  const struct option *options)
 {
 	const struct option *all_opts = options;
 	const char *arg_end = strchrnul(arg, '=');
diff --git a/parse-options.h b/parse-options.h
index 6c4fe2016d..bd88f6424a 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -175,11 +175,11 @@ struct option {
  * Returns the number of arguments left in argv[].
  */
 extern int parse_options(int argc, const char **argv, const char *prefix,
-                         const struct option *options,
-                         const char * const usagestr[], int flags);
+			 const struct option *options,
+			 const char * const usagestr[], int flags);
 
 extern NORETURN void usage_with_options(const char * const *usagestr,
-                                        const struct option *options);
+					const struct option *options);
 
 extern NORETURN void usage_msg_opt(const char *msg,
 				   const char * const *usagestr,
diff --git a/quote.c b/quote.c
index c95dd2cafb..7f2aa6faa4 100644
--- a/quote.c
+++ b/quote.c
@@ -234,7 +234,7 @@ static size_t next_quote_pos(const char *s, ssize_t maxlen)
  *     Return value is the same as in (1).
  */
 static size_t quote_c_style_counted(const char *name, ssize_t maxlen,
-                                    struct strbuf *sb, FILE *fp, int no_dq)
+				    struct strbuf *sb, FILE *fp, int no_dq)
 {
 #undef EMIT
 #define EMIT(c)                                 \
diff --git a/read-cache.c b/read-cache.c
index bd45dc3e24..3428d34f34 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3494,71 +3494,71 @@ static void write_eoie_extension(struct strbuf *sb, git_hash_ctx *eoie_context,
 
 static struct index_entry_offset_table *read_ieot_extension(const char *mmap, size_t mmap_size, size_t offset)
 {
-       const char *index = NULL;
-       uint32_t extsize, ext_version;
-       struct index_entry_offset_table *ieot;
-       int i, nr;
-
-       /* find the IEOT extension */
-       if (!offset)
-	       return NULL;
-       while (offset <= mmap_size - the_hash_algo->rawsz - 8) {
-	       extsize = get_be32(mmap + offset + 4);
-	       if (CACHE_EXT((mmap + offset)) == CACHE_EXT_INDEXENTRYOFFSETTABLE) {
-		       index = mmap + offset + 4 + 4;
-		       break;
-	       }
-	       offset += 8;
-	       offset += extsize;
-       }
-       if (!index)
-	       return NULL;
-
-       /* validate the version is IEOT_VERSION */
-       ext_version = get_be32(index);
-       if (ext_version != IEOT_VERSION) {
-	       error("invalid IEOT version %d", ext_version);
-	       return NULL;
-       }
-       index += sizeof(uint32_t);
-
-       /* extension size - version bytes / bytes per entry */
-       nr = (extsize - sizeof(uint32_t)) / (sizeof(uint32_t) + sizeof(uint32_t));
-       if (!nr) {
-	       error("invalid number of IEOT entries %d", nr);
-	       return NULL;
-       }
-       ieot = xmalloc(sizeof(struct index_entry_offset_table)
-	       + (nr * sizeof(struct index_entry_offset)));
-       ieot->nr = nr;
-       for (i = 0; i < nr; i++) {
-	       ieot->entries[i].offset = get_be32(index);
-	       index += sizeof(uint32_t);
-	       ieot->entries[i].nr = get_be32(index);
-	       index += sizeof(uint32_t);
-       }
-
-       return ieot;
+	const char *index = NULL;
+	uint32_t extsize, ext_version;
+	struct index_entry_offset_table *ieot;
+	int i, nr;
+
+	/* find the IEOT extension */
+	if (!offset)
+		return NULL;
+	while (offset <= mmap_size - the_hash_algo->rawsz - 8) {
+		extsize = get_be32(mmap + offset + 4);
+		if (CACHE_EXT((mmap + offset)) == CACHE_EXT_INDEXENTRYOFFSETTABLE) {
+			index = mmap + offset + 4 + 4;
+			break;
+		}
+		offset += 8;
+		offset += extsize;
+	}
+	if (!index)
+		return NULL;
+
+	/* validate the version is IEOT_VERSION */
+	ext_version = get_be32(index);
+	if (ext_version != IEOT_VERSION) {
+		error("invalid IEOT version %d", ext_version);
+		return NULL;
+	}
+	index += sizeof(uint32_t);
+
+	/* extension size - version bytes / bytes per entry */
+	nr = (extsize - sizeof(uint32_t)) / (sizeof(uint32_t) + sizeof(uint32_t));
+	if (!nr) {
+		error("invalid number of IEOT entries %d", nr);
+		return NULL;
+	}
+	ieot = xmalloc(sizeof(struct index_entry_offset_table)
+		       + (nr * sizeof(struct index_entry_offset)));
+	ieot->nr = nr;
+	for (i = 0; i < nr; i++) {
+		ieot->entries[i].offset = get_be32(index);
+		index += sizeof(uint32_t);
+		ieot->entries[i].nr = get_be32(index);
+		index += sizeof(uint32_t);
+	}
+
+	return ieot;
 }
 
 static void write_ieot_extension(struct strbuf *sb, struct index_entry_offset_table *ieot)
 {
-       uint32_t buffer;
-       int i;
+	uint32_t buffer;
+	int i;
 
-       /* version */
-       put_be32(&buffer, IEOT_VERSION);
-       strbuf_add(sb, &buffer, sizeof(uint32_t));
+	/* version */
+	put_be32(&buffer, IEOT_VERSION);
+	strbuf_add(sb, &buffer, sizeof(uint32_t));
 
-       /* ieot */
-       for (i = 0; i < ieot->nr; i++) {
+	/* ieot */
+	for (i = 0; i < ieot->nr; i++) {
 
-	       /* offset */
-	       put_be32(&buffer, ieot->entries[i].offset);
-	       strbuf_add(sb, &buffer, sizeof(uint32_t));
+		/* offset */
+		put_be32(&buffer, ieot->entries[i].offset);
+		strbuf_add(sb, &buffer, sizeof(uint32_t));
 
-	       /* count */
-	       put_be32(&buffer, ieot->entries[i].nr);
-	       strbuf_add(sb, &buffer, sizeof(uint32_t));
-       }
+		/* count */
+		put_be32(&buffer, ieot->entries[i].nr);
+		strbuf_add(sb, &buffer, sizeof(uint32_t));
+	}
 }
diff --git a/revision.c b/revision.c
index 13e0519c02..f9ca1a8d53 100644
--- a/revision.c
+++ b/revision.c
@@ -1495,8 +1495,8 @@ void repo_init_revisions(struct repository *r,
 }
 
 static void add_pending_commit_list(struct rev_info *revs,
-                                    struct commit_list *commit_list,
-                                    unsigned int flags)
+				    struct commit_list *commit_list,
+				    unsigned int flags)
 {
 	while (commit_list) {
 		struct object *object = &commit_list->item->object;
diff --git a/symlinks.c b/symlinks.c
index 5261e8cf49..69d458a24d 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -221,7 +221,7 @@ int has_symlink_leading_path(const char *name, int len)
  */
 int check_leading_path(const char *name, int len)
 {
-    return threaded_check_leading_path(&default_cache, name, len);
+	return threaded_check_leading_path(&default_cache, name, len);
 }
 
 /*
-- 
2.20.0.rc2.461.g47d1d16d8d

