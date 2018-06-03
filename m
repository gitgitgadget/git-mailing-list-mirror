Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 964F71F403
	for <e@80x24.org>; Sun,  3 Jun 2018 16:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751433AbeFCQfp (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 12:35:45 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:39785 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751300AbeFCQex (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 12:34:53 -0400
Received: by mail-lf0-f67.google.com with SMTP id t134-v6so21557596lff.6
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 09:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7gNq+GhUecZfiJFXov0UQnsOTztgHMxQTJw9jt+xgvM=;
        b=n/Uy532VQQ58HBBK2vPEBI2jwFJBAXedDav1+q1uRNKAOtP9PXUmktdifMfX3WraB/
         sFgdBNvAhBsyD9IBTCIurQaQjx7i34JcINhcbSzfKNgoB90nr6qmHToc1gMPsebhsLs9
         IoduDovWanK2IXTn+CBZOln5jgHIb9dYQVkEPWkR1lF3vA+qXRTJlnvtTlSL0MqmgH67
         hI7v2Ld5dE2hdniSTP0jZSOnbmtSysmolO7uUDYFSOCNg5W1NUP93zlPCQi9LuQdyCSS
         /59SZtAwJj7lgsbepnki9e7gfN/jq1RJo80DzWn1H0+Cm446r1TRE/X7tz66Q8zZvBrr
         zfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7gNq+GhUecZfiJFXov0UQnsOTztgHMxQTJw9jt+xgvM=;
        b=f5fOECLq7dPD77Sfg7XvpTNuAALu+TNLyY7zKiFaEf7DIpsCsRXrt+KOfiqNE2+oGu
         SYqpTzaX8VHWvjKNCLb4NDHAgS88ZlxIgLWnPOlKjbAx5weoWaHwbnjul4/WUsFy1c0V
         rt4HtMQ0Am7LnvrE+B/prfBKR86NJ+mohCMOQmh4KVehK6N/K8RiOrOr/C+ewjIYO74i
         a4eQ/WIQncaA1I0epLZ6bX5hq8+QmYnmSSs0KzXhAUiIKi/LNHbqz2YiNOnMOMFNLtgc
         AiWV+Y9lYt0Wtkz8zRUtX2QD0nnSeSnx0m3HZKVOoEJsCwRmrFwMAi9b6JX9SEwAvnhF
         gM5A==
X-Gm-Message-State: ALKqPwfmZk3E5w9SY+Md3BvimA5Ntw16Gyh35IQrVE15qVZfaJPg890h
        oOhSKzEybgFo0jgOr1Eqr3c+DQ==
X-Google-Smtp-Source: ADUXVKJ6+5ZGjNaL6HXaTCUEt8GB6esZ/o9vonPySKFNHkdhHU6wWW5D5Qxj0MIuTGcWji8uV+qOug==
X-Received: by 2002:a2e:28b:: with SMTP id y11-v6mr12673915lje.27.1528043691627;
        Sun, 03 Jun 2018 09:34:51 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v79-v6sm4726895lfd.32.2018.06.03.09.34.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jun 2018 09:34:51 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 09/23] config.c: mark more strings for translation
Date:   Sun,  3 Jun 2018 18:34:06 +0200
Message-Id: <20180603163420.13702-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180603163420.13702-1-pclouds@gmail.com>
References: <20180602043241.9941-1-pclouds@gmail.com>
 <20180603163420.13702-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 config.c                  | 76 +++++++++++++++++++--------------------
 t/t1305-config-include.sh |  2 +-
 2 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/config.c b/config.c
index ec08db1d1b..96b6020819 100644
--- a/config.c
+++ b/config.c
@@ -116,12 +116,12 @@ static long config_buf_ftell(struct config_source *conf)
 }
 
 #define MAX_INCLUDE_DEPTH 10
-static const char include_depth_advice[] =
+static const char include_depth_advice[] = N_(
 "exceeded maximum include depth (%d) while including\n"
 "	%s\n"
 "from\n"
 "	%s\n"
-"Do you have circular includes?";
+"Do you have circular includes?");
 static int handle_path_include(const char *path, struct config_include_data *inc)
 {
 	int ret = 0;
@@ -133,7 +133,7 @@ static int handle_path_include(const char *path, struct config_include_data *inc
 
 	expanded = expand_user_path(path, 0);
 	if (!expanded)
-		return error("could not expand include path '%s'", path);
+		return error(_("could not expand include path '%s'"), path);
 	path = expanded;
 
 	/*
@@ -144,7 +144,7 @@ static int handle_path_include(const char *path, struct config_include_data *inc
 		char *slash;
 
 		if (!cf || !cf->path)
-			return error("relative config includes must come from files");
+			return error(_("relative config includes must come from files"));
 
 		slash = find_last_dir_sep(cf->path);
 		if (slash)
@@ -155,7 +155,7 @@ static int handle_path_include(const char *path, struct config_include_data *inc
 
 	if (!access_or_die(path, R_OK, 0)) {
 		if (++inc->depth > MAX_INCLUDE_DEPTH)
-			die(include_depth_advice, MAX_INCLUDE_DEPTH, path,
+			die(_(include_depth_advice), MAX_INCLUDE_DEPTH, path,
 			    !cf ? "<unknown>" :
 			    cf->name ? cf->name :
 			    "the command line");
@@ -342,13 +342,13 @@ static int git_config_parse_key_1(const char *key, char **store_key, int *basele
 
 	if (last_dot == NULL || last_dot == key) {
 		if (!quiet)
-			error("key does not contain a section: %s", key);
+			error(_("key does not contain a section: %s"), key);
 		return -CONFIG_NO_SECTION_OR_NAME;
 	}
 
 	if (!last_dot[1]) {
 		if (!quiet)
-			error("key does not contain variable name: %s", key);
+			error(_("key does not contain variable name: %s"), key);
 		return -CONFIG_NO_SECTION_OR_NAME;
 	}
 
@@ -372,13 +372,13 @@ static int git_config_parse_key_1(const char *key, char **store_key, int *basele
 			if (!iskeychar(c) ||
 			    (i == baselen + 1 && !isalpha(c))) {
 				if (!quiet)
-					error("invalid key: %s", key);
+					error(_("invalid key: %s"), key);
 				goto out_free_ret_1;
 			}
 			c = tolower(c);
 		} else if (c == '\n') {
 			if (!quiet)
-				error("invalid key (newline): %s", key);
+				error(_("invalid key (newline): %s"), key);
 			goto out_free_ret_1;
 		}
 		if (store_key)
@@ -414,7 +414,7 @@ int git_config_parse_parameter(const char *text,
 
 	pair = strbuf_split_str(text, '=', 2);
 	if (!pair[0])
-		return error("bogus config parameter: %s", text);
+		return error(_("bogus config parameter: %s"), text);
 
 	if (pair[0]->len && pair[0]->buf[pair[0]->len - 1] == '=') {
 		strbuf_setlen(pair[0], pair[0]->len - 1);
@@ -426,7 +426,7 @@ int git_config_parse_parameter(const char *text,
 	strbuf_trim(pair[0]);
 	if (!pair[0]->len) {
 		strbuf_list_free(pair);
-		return error("bogus config parameter: %s", text);
+		return error(_("bogus config parameter: %s"), text);
 	}
 
 	if (git_config_parse_key(pair[0]->buf, &canonical_name, NULL)) {
@@ -461,7 +461,7 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 	envw = xstrdup(env);
 
 	if (sq_dequote_to_argv(envw, &argv, &nr, &alloc) < 0) {
-		ret = error("bogus format in %s", CONFIG_DATA_ENVIRONMENT);
+		ret = error(_("bogus format in %s"), CONFIG_DATA_ENVIRONMENT);
 		goto out;
 	}
 
@@ -1154,7 +1154,7 @@ static int git_default_core_config(const char *var, const char *value)
 		else {
 			int abbrev = git_config_int(var, value);
 			if (abbrev < minimum_abbrev || abbrev > 40)
-				return error("abbrev length out of range: %d", abbrev);
+				return error(_("abbrev length out of range: %d"), abbrev);
 			default_abbrev = abbrev;
 		}
 		return 0;
@@ -1271,7 +1271,7 @@ static int git_default_core_config(const char *var, const char *value)
 			comment_line_char = value[0];
 			auto_comment_line_char = 0;
 		} else
-			return error("core.commentChar should only be one character");
+			return error(_("core.commentChar should only be one character"));
 		return 0;
 	}
 
@@ -1384,7 +1384,7 @@ static int git_default_branch_config(const char *var, const char *value)
 		else if (!strcmp(value, "always"))
 			autorebase = AUTOREBASE_ALWAYS;
 		else
-			return error("malformed value for %s", var);
+			return error(_("malformed value for %s"), var);
 		return 0;
 	}
 
@@ -1409,11 +1409,11 @@ static int git_default_push_config(const char *var, const char *value)
 			push_default = PUSH_DEFAULT_UPSTREAM;
 		else if (!strcmp(value, "current"))
 			push_default = PUSH_DEFAULT_CURRENT;
-		else {
-			error("malformed value for %s: %s", var, value);
-			return error("Must be one of nothing, matching, simple, "
-				     "upstream or current.");
-		}
+		else
+			return error(_("malformed value for %s: %s\n"
+				       "Must be one of nothing, matching, simple, "
+				       "upstream or current."),
+				     var, value);
 		return 0;
 	}
 
@@ -1589,10 +1589,10 @@ int git_config_from_blob_oid(config_fn_t fn,
 
 	buf = read_object_file(oid, &type, &size);
 	if (!buf)
-		return error("unable to load config blob object '%s'", name);
+		return error(_("unable to load config blob object '%s'"), name);
 	if (type != OBJ_BLOB) {
 		free(buf);
-		return error("reference '%s' does not point to a blob", name);
+		return error(_("reference '%s' does not point to a blob"), name);
 	}
 
 	ret = git_config_from_mem(fn, CONFIG_ORIGIN_BLOB, name, buf, size, data);
@@ -1608,7 +1608,7 @@ static int git_config_from_blob_ref(config_fn_t fn,
 	struct object_id oid;
 
 	if (get_oid(name, &oid) < 0)
-		return error("unable to resolve config blob '%s'", name);
+		return error(_("unable to resolve config blob '%s'"), name);
 	return git_config_from_blob_oid(fn, name, &oid, data);
 }
 
@@ -1638,7 +1638,7 @@ unsigned long git_env_ulong(const char *k, unsigned long val)
 {
 	const char *v = getenv(k);
 	if (v && !git_parse_ulong(v, &val))
-		die("failed to parse %s", k);
+		die(_("failed to parse %s"), k);
 	return val;
 }
 
@@ -2372,7 +2372,7 @@ static int store_aux_event(enum config_event_t type,
 
 	if (type == CONFIG_EVENT_SECTION) {
 		if (cf->var.len < 2 || cf->var.buf[cf->var.len - 1] != '.')
-			return error("invalid section name '%s'", cf->var.buf);
+			return error(_("invalid section name '%s'"), cf->var.buf);
 
 		/* Is this the section we were looking for? */
 		store->is_keys_section =
@@ -2428,7 +2428,7 @@ static int store_aux(const char *key, const char *value, void *cb)
 
 static int write_error(const char *filename)
 {
-	error("failed to write new configuration file %s", filename);
+	error(_("failed to write new configuration file %s"), filename);
 
 	/* Same error code as "failed to rename". */
 	return 4;
@@ -2679,7 +2679,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 	 */
 	fd = hold_lock_file_for_update(&lock, config_filename, 0);
 	if (fd < 0) {
-		error_errno("could not lock config file %s", config_filename);
+		error_errno(_("could not lock config file %s"), config_filename);
 		ret = CONFIG_NO_LOCK;
 		goto out_free;
 	}
@@ -2690,7 +2690,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 	in_fd = open(config_filename, O_RDONLY);
 	if ( in_fd < 0 ) {
 		if ( ENOENT != errno ) {
-			error_errno("opening %s", config_filename);
+			error_errno(_("opening %s"), config_filename);
 			ret = CONFIG_INVALID_FILE; /* same as "invalid config file" */
 			goto out_free;
 		}
@@ -2725,7 +2725,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 			store.value_regex = (regex_t*)xmalloc(sizeof(regex_t));
 			if (regcomp(store.value_regex, value_regex,
 					REG_EXTENDED)) {
-				error("invalid pattern: %s", value_regex);
+				error(_("invalid pattern: %s"), value_regex);
 				FREE_AND_NULL(store.value_regex);
 				ret = CONFIG_INVALID_PATTERN;
 				goto out_free;
@@ -2750,7 +2750,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 		if (git_config_from_file_with_options(store_aux,
 						      config_filename,
 						      &store, &opts)) {
-			error("invalid config file %s", config_filename);
+			error(_("invalid config file %s"), config_filename);
 			ret = CONFIG_INVALID_FILE;
 			goto out_free;
 		}
@@ -2774,7 +2774,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 		if (contents == MAP_FAILED) {
 			if (errno == ENODEV && S_ISDIR(st.st_mode))
 				errno = EISDIR;
-			error_errno("unable to mmap '%s'", config_filename);
+			error_errno(_("unable to mmap '%s'"), config_filename);
 			ret = CONFIG_INVALID_FILE;
 			contents = NULL;
 			goto out_free;
@@ -2783,7 +2783,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 		in_fd = -1;
 
 		if (chmod(get_lock_file_path(&lock), st.st_mode & 07777) < 0) {
-			error_errno("chmod on %s failed", get_lock_file_path(&lock));
+			error_errno(_("chmod on %s failed"), get_lock_file_path(&lock));
 			ret = CONFIG_NO_WRITE;
 			goto out_free;
 		}
@@ -2868,7 +2868,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 	}
 
 	if (commit_lock_file(&lock) < 0) {
-		error_errno("could not write config file %s", config_filename);
+		error_errno(_("could not write config file %s"), config_filename);
 		ret = CONFIG_NO_WRITE;
 		goto out_free;
 	}
@@ -2994,7 +2994,7 @@ static int git_config_copy_or_rename_section_in_file(const char *config_filename
 	memset(&store, 0, sizeof(store));
 
 	if (new_name && !section_name_is_ok(new_name)) {
-		ret = error("invalid section name: %s", new_name);
+		ret = error(_("invalid section name: %s"), new_name);
 		goto out_no_rollback;
 	}
 
@@ -3003,7 +3003,7 @@ static int git_config_copy_or_rename_section_in_file(const char *config_filename
 
 	out_fd = hold_lock_file_for_update(&lock, config_filename, 0);
 	if (out_fd < 0) {
-		ret = error("could not lock config file %s", config_filename);
+		ret = error(_("could not lock config file %s"), config_filename);
 		goto out;
 	}
 
@@ -3021,7 +3021,7 @@ static int git_config_copy_or_rename_section_in_file(const char *config_filename
 	}
 
 	if (chmod(get_lock_file_path(&lock), st.st_mode & 07777) < 0) {
-		ret = error_errno("chmod on %s failed",
+		ret = error_errno(_("chmod on %s failed"),
 				  get_lock_file_path(&lock));
 		goto out;
 	}
@@ -3118,7 +3118,7 @@ static int git_config_copy_or_rename_section_in_file(const char *config_filename
 	config_file = NULL;
 commit_and_out:
 	if (commit_lock_file(&lock) < 0)
-		ret = error_errno("could not write config file %s",
+		ret = error_errno(_("could not write config file %s"),
 				  config_filename);
 out:
 	if (config_file)
@@ -3161,7 +3161,7 @@ int git_config_copy_section(const char *old_name, const char *new_name)
 #undef config_error_nonbool
 int config_error_nonbool(const char *var)
 {
-	return error("missing value for '%s'", var);
+	return error(_("missing value for '%s'"), var);
 }
 
 int parse_config_key(const char *var,
diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index f035ee40a3..635918505d 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -310,7 +310,7 @@ test_expect_success 'include cycles are detected' '
 	cycle
 	EOF
 	test_must_fail git config --get-all test.value 2>stderr &&
-	grep "exceeded maximum include depth" stderr
+	test_i18ngrep "exceeded maximum include depth" stderr
 '
 
 test_done
-- 
2.18.0.rc0.333.g22e6ee6cdf

