Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A76821F597
	for <e@80x24.org>; Sat, 21 Jul 2018 07:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbeGUIlz (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 04:41:55 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39037 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbeGUIly (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 04:41:54 -0400
Received: by mail-lj1-f194.google.com with SMTP id l15-v6so12892633lji.6
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 00:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VHgy4lgFPBQxApH8cNnklankwh1/VJMab2mdtkP4Du4=;
        b=ctmLY6UgD0zwH3/VwVWSAw939ZNMo83KtOU2Fv8IvQ73ObhkjTFEAxKIKu23yE9Fwu
         ZIV0HqrtCJ5Tf+jav7L150RP+yHAc/y2OTYdLOuGOnUUQaVViL4LmQiV1OUZ+3pQVGTb
         f2lBaESsTVzLOgsic4uaHc6lYIFhsgn105u3SsdTCk7kCMQNTmvUju77aeHyVZmJjlX/
         Q/e4wv1Zei9KIgSoElXgTDEUIpSBBVlRZKtx4TjkK+EPJFyyWU+/m2USjTvx0SS2cR/T
         4i4vs6YAJ1uZkVaVUAiA0uyi3cuz2LlaIQHplnAMJr1nRP0pqkJzSKb3Z9O5Je3mSy4D
         GXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VHgy4lgFPBQxApH8cNnklankwh1/VJMab2mdtkP4Du4=;
        b=bQQOxs7OkowAnGyfZ+UO3u4rZkY/oVao9kn/lZp4Lbih//qEG7UewwLvyvYMyuMJTo
         C69z7xXgj47HhyAyd0RTT19JUA55GiacYh2hsND03HloGJx1o99QbWeXLZFamvN2gmmM
         U4lwWJJL55CUF6nvts/BLxLrMrEV3A9bdUH7waxucFDCO4lOs4IsqcpDapxZNsA1BeOb
         c64h8LQahXi6mHuhc80r93t06Hxvxuqaaga2ugd2k0mxYiIwOgTpUDarnzi2WSv2MYxR
         99/o7/9r3UWUGmvS/j9V13jcsrGcq5Jg8K/1/iqJC3UyQEQW9oTg5JxilRRxaPPGtXyI
         Dq0g==
X-Gm-Message-State: AOUpUlFlB81VqLz5u0OoEGAubJq/zHIBT111D5rKHWT8T2Uc0rAdpfEm
        2au6fX7I6Y6NrFWcS0woM8o=
X-Google-Smtp-Source: AAOMgperiTvUfixvPPo5S82I2+HbObURc9qVbejyGKhLm78nCLtBwg5lswy2N3m/Tx3HiocH6PVL2g==
X-Received: by 2002:a2e:40c:: with SMTP id 12-v6mr3760961lje.146.1532159403246;
        Sat, 21 Jul 2018 00:50:03 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n3-v6sm759898lji.96.2018.07.21.00.50.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 00:50:02 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        stolee@gmail.com
Subject: [PATCH v3 07/23] builtin/replace.c: mark more strings for translation
Date:   Sat, 21 Jul 2018 09:49:25 +0200
Message-Id: <20180721074941.14632-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.656.gda699b98b3
In-Reply-To: <20180721074941.14632-1-pclouds@gmail.com>
References: <20180718161101.19765-1-pclouds@gmail.com>
 <20180721074941.14632-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/replace.c | 74 +++++++++++++++++++++++------------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 5926ad11de..e879ace277 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -54,7 +54,7 @@ static int show_reference(const char *refname, const struct object_id *oid,
 			enum object_type obj_type, repl_type;
 
 			if (get_oid(refname, &object))
-				return error("failed to resolve '%s' as a valid ref", refname);
+				return error(_("failed to resolve '%s' as a valid ref"), refname);
 
 			obj_type = oid_object_info(the_repository, &object,
 						   NULL);
@@ -83,8 +83,8 @@ static int list_replace_refs(const char *pattern, const char *format)
 	else if (!strcmp(format, "long"))
 		data.format = REPLACE_FORMAT_LONG;
 	else
-		return error("invalid replace format '%s'\n"
-			     "valid formats are 'short', 'medium' and 'long'",
+		return error(_("invalid replace format '%s'\n"
+			       "valid formats are 'short', 'medium' and 'long'"),
 			     format);
 
 	for_each_replace_ref(the_repository, show_reference, (void *)&data);
@@ -118,7 +118,7 @@ static int for_each_replace_name(const char **argv, each_replace_name_fn fn)
 		full_hex = ref.buf + base_len;
 
 		if (read_ref(ref.buf, &oid)) {
-			error("replace ref '%s' not found", full_hex);
+			error(_("replace ref '%s' not found"), full_hex);
 			had_error = 1;
 			continue;
 		}
@@ -134,7 +134,7 @@ static int delete_replace_ref(const char *name, const char *ref,
 {
 	if (delete_ref(NULL, ref, oid, 0))
 		return 1;
-	printf_ln("Deleted replace ref '%s'", name);
+	printf_ln(_("Deleted replace ref '%s'"), name);
 	return 0;
 }
 
@@ -146,12 +146,12 @@ static int check_ref_valid(struct object_id *object,
 	strbuf_reset(ref);
 	strbuf_addf(ref, "%s%s", git_replace_ref_base, oid_to_hex(object));
 	if (check_refname_format(ref->buf, 0))
-		return error("'%s' is not a valid ref name", ref->buf);
+		return error(_("'%s' is not a valid ref name"), ref->buf);
 
 	if (read_ref(ref->buf, prev))
 		oidclr(prev);
 	else if (!force)
-		return error("replace ref '%s' already exists", ref->buf);
+		return error(_("replace ref '%s' already exists"), ref->buf);
 	return 0;
 }
 
@@ -171,10 +171,10 @@ static int replace_object_oid(const char *object_ref,
 	obj_type = oid_object_info(the_repository, object, NULL);
 	repl_type = oid_object_info(the_repository, repl, NULL);
 	if (!force && obj_type != repl_type)
-		return error("Objects must be of the same type.\n"
-			     "'%s' points to a replaced object of type '%s'\n"
-			     "while '%s' points to a replacement object of "
-			     "type '%s'.",
+		return error(_("Objects must be of the same type.\n"
+			       "'%s' points to a replaced object of type '%s'\n"
+			       "while '%s' points to a replacement object of "
+			       "type '%s'."),
 			     object_ref, type_name(obj_type),
 			     replace_ref, type_name(repl_type));
 
@@ -200,10 +200,10 @@ static int replace_object(const char *object_ref, const char *replace_ref, int f
 	struct object_id object, repl;
 
 	if (get_oid(object_ref, &object))
-		return error("failed to resolve '%s' as a valid ref",
+		return error(_("failed to resolve '%s' as a valid ref"),
 			     object_ref);
 	if (get_oid(replace_ref, &repl))
-		return error("failed to resolve '%s' as a valid ref",
+		return error(_("failed to resolve '%s' as a valid ref"),
 			     replace_ref);
 
 	return replace_object_oid(object_ref, &object, replace_ref, &repl, force);
@@ -222,7 +222,7 @@ static int export_object(const struct object_id *oid, enum object_type type,
 
 	fd = open(filename, O_WRONLY | O_CREAT | O_TRUNC, 0666);
 	if (fd < 0)
-		return error_errno("unable to open %s for writing", filename);
+		return error_errno(_("unable to open %s for writing"), filename);
 
 	argv_array_push(&cmd.args, "--no-replace-objects");
 	argv_array_push(&cmd.args, "cat-file");
@@ -235,7 +235,7 @@ static int export_object(const struct object_id *oid, enum object_type type,
 	cmd.out = fd;
 
 	if (run_command(&cmd))
-		return error("cat-file reported failure");
+		return error(_("cat-file reported failure"));
 	return 0;
 }
 
@@ -251,7 +251,7 @@ static int import_object(struct object_id *oid, enum object_type type,
 
 	fd = open(filename, O_RDONLY);
 	if (fd < 0)
-		return error_errno("unable to open %s for reading", filename);
+		return error_errno(_("unable to open %s for reading"), filename);
 
 	if (!raw && type == OBJ_TREE) {
 		const char *argv[] = { "mktree", NULL };
@@ -265,11 +265,11 @@ static int import_object(struct object_id *oid, enum object_type type,
 
 		if (start_command(&cmd)) {
 			close(fd);
-			return error("unable to spawn mktree");
+			return error(_("unable to spawn mktree"));
 		}
 
 		if (strbuf_read(&result, cmd.out, 41) < 0) {
-			error_errno("unable to read from mktree");
+			error_errno(_("unable to read from mktree"));
 			close(fd);
 			close(cmd.out);
 			return -1;
@@ -278,11 +278,11 @@ static int import_object(struct object_id *oid, enum object_type type,
 
 		if (finish_command(&cmd)) {
 			strbuf_release(&result);
-			return error("mktree reported failure");
+			return error(_("mktree reported failure"));
 		}
 		if (get_oid_hex(result.buf, oid) < 0) {
 			strbuf_release(&result);
-			return error("mktree did not return an object name");
+			return error(_("mktree did not return an object name"));
 		}
 
 		strbuf_release(&result);
@@ -291,12 +291,12 @@ static int import_object(struct object_id *oid, enum object_type type,
 		int flags = HASH_FORMAT_CHECK | HASH_WRITE_OBJECT;
 
 		if (fstat(fd, &st) < 0) {
-			error_errno("unable to fstat %s", filename);
+			error_errno(_("unable to fstat %s"), filename);
 			close(fd);
 			return -1;
 		}
 		if (index_fd(oid, fd, &st, type, NULL, flags) < 0)
-			return error("unable to write object to database");
+			return error(_("unable to write object to database"));
 		/* index_fd close()s fd for us */
 	}
 
@@ -315,11 +315,11 @@ static int edit_and_replace(const char *object_ref, int force, int raw)
 	struct strbuf ref = STRBUF_INIT;
 
 	if (get_oid(object_ref, &old_oid) < 0)
-		return error("not a valid object name: '%s'", object_ref);
+		return error(_("not a valid object name: '%s'"), object_ref);
 
 	type = oid_object_info(the_repository, &old_oid, NULL);
 	if (type < 0)
-		return error("unable to get object type for %s",
+		return error(_("unable to get object type for %s"),
 			     oid_to_hex(&old_oid));
 
 	if (check_ref_valid(&old_oid, &prev, &ref, force)) {
@@ -335,7 +335,7 @@ static int edit_and_replace(const char *object_ref, int force, int raw)
 	}
 	if (launch_editor(tmpfile, NULL, NULL) < 0) {
 		free(tmpfile);
-		return error("editing object file failed");
+		return error(_("editing object file failed"));
 	}
 	if (import_object(&new_oid, type, raw, tmpfile)) {
 		free(tmpfile);
@@ -344,7 +344,7 @@ static int edit_and_replace(const char *object_ref, int force, int raw)
 	free(tmpfile);
 
 	if (!oidcmp(&old_oid, &new_oid))
-		return error("new object is the same as the old one: '%s'", oid_to_hex(&old_oid));
+		return error(_("new object is the same as the old one: '%s'"), oid_to_hex(&old_oid));
 
 	return replace_object_oid(object_ref, &old_oid, "replacement", &new_oid, force);
 }
@@ -476,10 +476,10 @@ static int create_graft(int argc, const char **argv, int force, int gentle)
 
 	if (!oidcmp(&old_oid, &new_oid)) {
 		if (gentle) {
-			warning("graft for '%s' unnecessary", oid_to_hex(&old_oid));
+			warning(_("graft for '%s' unnecessary"), oid_to_hex(&old_oid));
 			return 0;
 		}
-		return error("new commit is the same as the old one: '%s'", oid_to_hex(&old_oid));
+		return error(_("new commit is the same as the old one: '%s'"), oid_to_hex(&old_oid));
 	}
 
 	return replace_object_oid(old_ref, &old_oid, "replacement", &new_oid, force);
@@ -553,7 +553,7 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 		cmdmode = argc ? MODE_REPLACE : MODE_LIST;
 
 	if (format && cmdmode != MODE_LIST)
-		usage_msg_opt("--format cannot be used when not listing",
+		usage_msg_opt(_("--format cannot be used when not listing"),
 			      git_replace_usage, options);
 
 	if (force &&
@@ -561,47 +561,47 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 	    cmdmode != MODE_EDIT &&
 	    cmdmode != MODE_GRAFT &&
 	    cmdmode != MODE_CONVERT_GRAFT_FILE)
-		usage_msg_opt("-f only makes sense when writing a replacement",
+		usage_msg_opt(_("-f only makes sense when writing a replacement"),
 			      git_replace_usage, options);
 
 	if (raw && cmdmode != MODE_EDIT)
-		usage_msg_opt("--raw only makes sense with --edit",
+		usage_msg_opt(_("--raw only makes sense with --edit"),
 			      git_replace_usage, options);
 
 	switch (cmdmode) {
 	case MODE_DELETE:
 		if (argc < 1)
-			usage_msg_opt("-d needs at least one argument",
+			usage_msg_opt(_("-d needs at least one argument"),
 				      git_replace_usage, options);
 		return for_each_replace_name(argv, delete_replace_ref);
 
 	case MODE_REPLACE:
 		if (argc != 2)
-			usage_msg_opt("bad number of arguments",
+			usage_msg_opt(_("bad number of arguments"),
 				      git_replace_usage, options);
 		return replace_object(argv[0], argv[1], force);
 
 	case MODE_EDIT:
 		if (argc != 1)
-			usage_msg_opt("-e needs exactly one argument",
+			usage_msg_opt(_("-e needs exactly one argument"),
 				      git_replace_usage, options);
 		return edit_and_replace(argv[0], force, raw);
 
 	case MODE_GRAFT:
 		if (argc < 1)
-			usage_msg_opt("-g needs at least one argument",
+			usage_msg_opt(_("-g needs at least one argument"),
 				      git_replace_usage, options);
 		return create_graft(argc, argv, force, 0);
 
 	case MODE_CONVERT_GRAFT_FILE:
 		if (argc != 0)
-			usage_msg_opt("--convert-graft-file takes no argument",
+			usage_msg_opt(_("--convert-graft-file takes no argument"),
 				      git_replace_usage, options);
 		return !!convert_graft_file(force);
 
 	case MODE_LIST:
 		if (argc > 1)
-			usage_msg_opt("only one pattern can be given with -l",
+			usage_msg_opt(_("only one pattern can be given with -l"),
 				      git_replace_usage, options);
 		return list_replace_refs(argv[0], format);
 
-- 
2.18.0.656.gda699b98b3

