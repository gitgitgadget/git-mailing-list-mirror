Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DB0F2023D
	for <e@80x24.org>; Sat, 20 May 2017 06:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756588AbdETGDr (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 02:03:47 -0400
Received: from mail.aegee.org ([144.76.142.78]:56981 "EHLO mail.aegee.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753877AbdETGDq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 02:03:46 -0400
X-Greylist: delayed 749 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 May 2017 02:03:45 EDT
Received: from mail.your-server.de (localhost [127.0.0.1])
        by mail.aegee.org (8.15.2/8.15.2) with ESMTP id v4K5qSSd030537;
        Sat, 20 May 2017 05:52:28 GMT
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.aegee.org v4K5qSSd030537
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aegee.org; s=k4096;
        t=1495259548; i=dkim+sm-localhost@aegee.org; r=y;
        bh=ByYdKqunmwinVu1Sco11GvJ/35AWBedoSd6WN3qTbw8=;
        h=From:To:Cc:Subject:Date;
        b=pNjZlmKoZgkO2+5whTPqAcNlUBVqnOYWSB6X9QBozMnGC70GbS07UF+d2Bhkw/paL
         huuceV9b5ZeUIQDtjD+GlIIo+QFBbB0sgSl9PFxOfmN1y1n0Z4v6N+MzamuLOSOnAa
         iWzhZ11aejdhth7osJolu3Co0zr8HWIG8t7BlqylbVhDm2XysyCImTvTt+t/XKu/zQ
         +M9zIvbYlG4o+bzNNx94z0U40SYTStJyiaQYuH4sHZfuk/VIMbkTLKuYx2ANuwEtpg
         AMtHSJzpN9pptdzFli2tp2YF1dXkrtdn6rixgJ5zQRTNwhHCv7m1oN8+L/qGcJM29w
         XVZO6hwqYP/pWjC2vgJsicUlDuY0RiIXudqaVYtNa6T6TZUOspk85VjcC3WoaQRwt6
         PnwkC4h19XZWrPi4Mo1s7lXRUU5+/DdMWZhWIWT4UBDwyV7DUhcy6Cjy7O60Fybe5C
         38ottLutO/mOwweq6qAO/fUCUjohb6HaXl1QbCIvvhxcanU3QIWNZ4Qqeno8oZSFbn
         DMCHwECHabCzsyZ6gnGWfMKN+rt1DxJMscmaRJsnJxj5lXchNHws0Y8TAenKJYRdJu
         9XiAqSvIztHD122WRM72Kod+/6QvQTHxD1/OVsAl3GRvPaQ/UT1WK3FnXj7fS+hsel
         ATT2j5JKm0crV7bTFQvXR8tY=
Authentication-Results: mail.aegee.org; dkim=none
From:   =?UTF-8?q?=D0=94=D0=B8=D0=BB=D1=8F=D0=BD=20=D0=9F=D0=B0=D0=BB=D0=B0=D1=83=D0=B7=D0=BE=D0=B2?= 
        <git-dpa@aegee.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=D0=94=D0=B8=D0=BB=D1=8F=D0=BD=20=D0=9F=D0=B0=D0=BB=D0=B0?=
         =?UTF-8?q?=D1=83=D0=B7=D0=BE=D0=B2?= <git-dpa@aegee.org>
Subject: [PATCH] Remove useless assignments
Date:   Sat, 20 May 2017 05:52:16 +0000
Message-Id: <20170520055216.30470-1-git-dpa@aegee.org>
X-Mailer: git-send-email 2.12.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail.aegee.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Дилян Палаузов <git-dpa@aegee.org>

diff --git a/archive.c b/archive.c
index 60b889198..e2534d186 100644
--- a/archive.c
+++ b/archive.c
@@ -503,7 +503,7 @@ int write_archive(int argc, const char **argv, const char *prefix,
 	init_tar_archiver();
 	init_zip_archiver();
 
-	argc = parse_archive_args(argc, argv, &ar, &args, name_hint, remote);
+	parse_archive_args(argc, argv, &ar, &args, name_hint, remote);
 	if (!startup_info->have_repository) {
 		/*
 		 * We know this will die() with an error, so we could just
diff --git a/builtin/add.c b/builtin/add.c
index 9f53f020d..fc1481273 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -211,7 +211,7 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 	init_revisions(&rev, prefix);
 	rev.diffopt.context = 7;
 
-	argc = setup_revisions(argc, argv, &rev, NULL);
+	setup_revisions(argc, argv, &rev, NULL);
 	rev.diffopt.output_format = DIFF_FORMAT_PATCH;
 	rev.diffopt.use_color = 0;
 	DIFF_OPT_SET(&rev.diffopt, IGNORE_DIRTY_SUBMODULES);
diff --git a/builtin/help.c b/builtin/help.c
index 49f7a07f8..3d24b084e 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -453,7 +453,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	int nongit;
 	enum help_format parsed_help_format;
 
-	argc = parse_options(argc, argv, prefix, builtin_help_options,
+	parse_options(argc, argv, prefix, builtin_help_options,
 			builtin_help_usage, 0);
 	parsed_help_format = help_format;
 
diff --git a/builtin/merge.c b/builtin/merge.c
index 703827f00..337efef6f 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -795,7 +795,7 @@ static int merge_trivial(struct commit *head, struct commit_list *remoteheads)
 	write_tree_trivial(&result_tree);
 	printf(_("Wonderful.\n"));
 	pptr = commit_list_append(head, pptr);
-	pptr = commit_list_append(remoteheads->item, pptr);
+	commit_list_append(remoteheads->item, pptr);
 	prepare_to_commit(remoteheads);
 	if (commit_tree(merge_msg.buf, merge_msg.len, result_tree.hash, parents,
 			result_commit.hash, NULL, sign_commit))
diff --git a/builtin/notes.c b/builtin/notes.c
index 7b891471c..6ec753383 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -1015,7 +1015,7 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 	else if (!strcmp(argv[0], "get-ref"))
 		result = get_ref(argc, argv, prefix);
 	else {
-		result = error(_("unknown subcommand: %s"), argv[0]);
+		error(_("unknown subcommand: %s"), argv[0]);
 		usage_with_options(git_notes_usage, options);
 	}
 
diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
index c026299e7..73f424d9f 100644
--- a/builtin/prune-packed.c
+++ b/builtin/prune-packed.c
@@ -59,7 +59,7 @@ int cmd_prune_packed(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, prefix, prune_packed_options,
+	parse_options(argc, argv, prefix, prune_packed_options,
 			     prune_packed_usage, 0);
 
 	prune_packed_objects(opts);
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 0bb36d584..0fa779103 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -498,7 +498,7 @@ static const char *check_nonce(const char *buf, size_t len)
 	char *nonce = find_header(buf, len, "nonce");
 	timestamp_t stamp, ostamp;
 	char *bohmac, *expect = NULL;
-	const char *retval = NONCE_BAD;
+	const char *retval;
 
 	if (!nonce) {
 		retval = NONCE_MISSING;
diff --git a/builtin/reset.c b/builtin/reset.c
index fc3b906c4..f547efd8d 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -291,7 +291,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 
-	argc = parse_options(argc, argv, prefix, options, git_reset_usage,
+	parse_options(argc, argv, prefix, options, git_reset_usage,
 						PARSE_OPT_KEEP_DASHDASH);
 	parse_args(&pathspec, argv, prefix, patch_mode, &rev);
 
diff --git a/diffcore-rename.c b/diffcore-rename.c
index f7444c86b..632e19089 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -580,7 +580,7 @@ void diffcore_rename(struct diff_options *options)
 
 	rename_count += find_renames(mx, dst_cnt, minimum_score, 0);
 	if (detect_rename == DIFF_DETECT_COPY)
-		rename_count += find_renames(mx, dst_cnt, minimum_score, 1);
+		find_renames(mx, dst_cnt, minimum_score, 1);
 	free(mx);
 
  cleanup:
diff --git a/fast-import.c b/fast-import.c
index cf58f875b..0369363b2 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2054,7 +2054,7 @@ static int validate_raw_date(const char *src, struct strbuf *result)
 
 	errno = 0;
 
-	num = strtoul(src, &endp, 10);
+	strtoul(src, &endp, 10);
 	/* NEEDSWORK: perhaps check for reasonable values? */
 	if (errno || endp == src || *endp != ' ')
 		return -1;
diff --git a/fsck.c b/fsck.c
index d589341cd..35d421c08 100644
--- a/fsck.c
+++ b/fsck.c
@@ -703,7 +703,6 @@ static int fsck_ident(const char **ident, struct object *obj, struct fsck_option
 	    !isdigit(p[4]) ||
 	    (p[5] != '\n'))
 		return report(options, obj, FSCK_MSG_BAD_TIMEZONE, "invalid author/committer line - bad time zone");
-	p += 6;
 	return 0;
 }
 
diff --git a/ref-filter.c b/ref-filter.c
index 1fc5e9970..2d06b98ce 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1634,10 +1634,6 @@ static int match_name_as_path(const struct ref_filter *filter, const char *refna
 {
 	const char **pattern = filter->name_patterns;
 	int namelen = strlen(refname);
-	unsigned flags = WM_PATHNAME;
-
-	if (filter->ignore_case)
-		flags |= WM_CASEFOLD;
 
 	for (; *pattern; pattern++) {
 		const char *p = *pattern;
diff --git a/t/helper/test-lazy-init-name-hash.c b/t/helper/test-lazy-init-name-hash.c
index 6368a8934..29a16a61b 100644
--- a/t/helper/test-lazy-init-name-hash.c
+++ b/t/helper/test-lazy-init-name-hash.c
@@ -209,7 +209,7 @@ int cmd_main(int argc, const char **argv)
 
 	prefix = setup_git_directory();
 
-	argc = parse_options(argc, argv, prefix, options, usage, 0);
+	parse_options(argc, argv, prefix, options, usage, 0);
 
 	/*
 	 * istate->dir_hash is only created when ignore_case is set.
diff --git a/wrapper.c b/wrapper.c
index d83741770..ad7b63a0f 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -485,7 +485,7 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
 		template[2] = letters[v % num_letters]; v /= num_letters;
 		template[3] = letters[v % num_letters]; v /= num_letters;
 		template[4] = letters[v % num_letters]; v /= num_letters;
-		template[5] = letters[v % num_letters]; v /= num_letters;
+		template[5] = letters[v % num_letters];
 
 		fd = open(pattern, O_CREAT | O_EXCL | O_RDWR, mode);
 		if (fd >= 0)
-- 
2.12.3

