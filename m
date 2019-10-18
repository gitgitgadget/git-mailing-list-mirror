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
	by dcvr.yhbt.net (Postfix) with ESMTP id B1B761F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 00:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438772AbfJRAHV (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 20:07:21 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:38428 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438751AbfJRAHG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 20:07:06 -0400
Received: by mail-wr1-f44.google.com with SMTP id o15so3819887wru.5
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 17:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Xni1uLjDM4pgMaKEPx5YLiPfbVpKilFm3IyFzb3zTpM=;
        b=keQGbK7xlyueQCBCmU1b+GNMaTr7b63Ppq4RF2sRXe0Owma9ls5CLX590+ahjXFSck
         8ZBCIU0b8pARDiY/ycbLOaYcCVOx+6yDYrR3hKUTbV8XRT0FnVs+EnACeZArC4W9gCFy
         LVMhOXep29F8I7YcfUgeKZdJkzGFRrZsfW5fvlA9Luy0h9jCWS6OuG0PYwxcidk/s8F+
         FJcWbARwpPCyuITq93JbQJE37uSpsy4WbJNq9+ySWhM1WFSL86gMWsBBkuS6D5TslAJA
         7CSACdLIIXHlzWQogO+efMYXZKWBJyx68gRDxSTacAZOZ3q6Kuv0GYx9LhaKZ2WniKCd
         /yIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Xni1uLjDM4pgMaKEPx5YLiPfbVpKilFm3IyFzb3zTpM=;
        b=tgqIRyFuYGeeVaFCuHMbjhDqTrmhmSkA3lSQYSNpOaUXEnjFVv+qm0WynxppLsLukj
         Ekq5W3NG/JWcO229TQnyUvX4/bsAeccL7CP2hc9r6D5wQPCQwweN274TS2/ubyOM5oYc
         /TZ6Jxy6R+7R5nN6z5wp5qPVlwAoAzhh/Ni7vY6A9notrayzZOOQP6giyrlHnR263RlU
         tIICBVYqMS58THsZaWJ5FGLCI/S3dRhishnOkANpuRuSwkhPHnTaJyLSrTvq8NtlHFwu
         2C9bMGSGE6Vfh6qpHBIRezSzDld1hKeceyoTrooDZRF2wUAPt+HrJT5Z+C9WqoPSphKY
         dZ6g==
X-Gm-Message-State: APjAAAWOacCuOsXididOjSHhsm4nryk30M2ed9+n7e7K9+v/G6oAXNWl
        fiOsYwNzDIfVdHkO/8zc8Y6DPbMe
X-Google-Smtp-Source: APXvYqxP3QycmNIDeQyZBmzAEGP657FRn6j9ageeC9OwIB4R+cXbyAwg06t4Ld38Bf2bl7wtR+Uijg==
X-Received: by 2002:adf:a157:: with SMTP id r23mr4980523wrr.51.1571357221840;
        Thu, 17 Oct 2019 17:07:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r140sm4335287wme.47.2019.10.17.17.07.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 17:07:01 -0700 (PDT)
Message-Id: <2e42eafb5db6192829e9e206e9e9905b31f8e8a6.1571357219.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.405.git.1571357219.gitgitgadget@gmail.com>
References: <pull.405.git.1571357219.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 18 Oct 2019 00:06:59 +0000
Subject: [PATCH 1/1] config: add documentation to config.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Heba Waly <heba.waly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heba Waly <heba.waly@gmail.com>

This commit is copying and summarizing the documentation from
documentation/technical/api-config.txt to comments in config.h

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 config.h | 327 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 327 insertions(+)

diff --git a/config.h b/config.h
index f0ed464004..fa999a2ba0 100644
--- a/config.h
+++ b/config.h
@@ -4,6 +4,40 @@
 #include "hashmap.h"
 #include "string-list.h"
 
+
+/**
+ * The config API gives callers a way to access Git configuration files
+ * (and files which have the same syntax). See linkgit:git-config[1] for a
+ * discussion of the config file syntax.
+ *
+ * General Usage
+ * -------------
+ *
+ * Config files are parsed linearly, and each variable found is passed to a
+ * caller-provided callback function. The callback function is responsible
+ * for any actions to be taken on the config option, and is free to ignore
+ * some options. It is not uncommon for the configuration to be parsed
+ * several times during the run of a Git program, with different callbacks
+ * picking out different variables useful to themselves.
+ *
+ * A config callback function takes three parameters:
+ *
+ * - the name of the parsed variable. This is in canonical "flat" form: the
+ *   section, subsection, and variable segments will be separated by dots,
+ *   and the section and variable segments will be all lowercase. E.g.,
+ *   `core.ignorecase`, `diff.SomeType.textconv`.
+ *
+ * - the value of the found variable, as a string. If the variable had no
+ *   value specified, the value will be NULL (typically this means it
+ *   should be interpreted as boolean true).
+ *
+ * - a void pointer passed in by the caller of the config API; this can
+ *   contain callback-specific data
+ *
+ * A config callback should return 0 for success, or -1 if the variable
+ * could not be parsed properly.
+ */
+
 struct object_id;
 
 /* git_config_parse_key() returns these negated: */
@@ -73,6 +107,11 @@ struct config_options {
 
 typedef int (*config_fn_t)(const char *, const char *, void *);
 int git_default_config(const char *, const char *, void *);
+
+/**
+ * Read a specific file in git-config format.
+ * This function takes the same callback and data parameters as `git_config`.
+ */
 int git_config_from_file(config_fn_t fn, const char *, void *);
 int git_config_from_file_with_options(config_fn_t fn, const char *,
 				      void *,
@@ -88,33 +127,152 @@ void git_config_push_parameter(const char *text);
 int git_config_from_parameters(config_fn_t fn, void *data);
 void read_early_config(config_fn_t cb, void *data);
 void read_very_early_config(config_fn_t cb, void *data);
+
+/**
+ * Most programs will simply want to look up variables in all config files
+ * that Git knows about, using the normal precedence rules. To do this,
+ * call `git_config` with a callback function and void data pointer.
+ *
+ * `git_config` will read all config sources in order of increasing
+ * priority. Thus a callback should typically overwrite previously-seen
+ * entries with new ones (e.g., if both the user-wide `~/.gitconfig` and
+ * repo-specific `.git/config` contain `color.ui`, the config machinery
+ * will first feed the user-wide one to the callback, and then the
+ * repo-specific one; by overwriting, the higher-priority repo-specific
+ * value is left at the end).
+ */
 void git_config(config_fn_t fn, void *);
+
+/**
+ * Lets the caller examine config while adjusting some of the default
+ * behavior of `git_config`. It should almost never be used by "regular"
+ * Git code that is looking up configuration variables.
+ * It is intended for advanced callers like `git-config`, which are
+ * intentionally tweaking the normal config-lookup process.
+ * It takes two extra parameters:
+ *
+ * `config_source`::
+ * If this parameter is non-NULL, it specifies the source to parse for
+ * configuration, rather than looking in the usual files. See `struct
+ * git_config_source` in `config.h` for details. Regular `git_config` defaults
+ * to `NULL`.
+ *
+ * `opts`::
+ * Specify options to adjust the behavior of parsing config files. See `struct
+ * config_options` in `config.h` for details. As an example: regular `git_config`
+ * sets `opts.respect_includes` to `1` by default.
+ */
 int config_with_options(config_fn_t fn, void *,
 			struct git_config_source *config_source,
 			const struct config_options *opts);
+
+/**
+ * Value Parsing Helpers
+ * ---------------------
+ *
+ * To aid in parsing string values, the config API provides callbacks with
+ * a number of helper functions
+ */
+
 int git_parse_ssize_t(const char *, ssize_t *);
 int git_parse_ulong(const char *, unsigned long *);
+
+/**
+ * Same as `git_config_bool`, except that it returns -1 on error rather
+ * than dying.
+ */
 int git_parse_maybe_bool(const char *);
+
+/**
+ * Parse the string to an integer, including unit factors. Dies on error;
+ * otherwise, returns the parsed result.
+ */
 int git_config_int(const char *, const char *);
 int64_t git_config_int64(const char *, const char *);
+
+/**
+ * Identical to `git_config_int`, but for unsigned longs.
+ */
 unsigned long git_config_ulong(const char *, const char *);
 ssize_t git_config_ssize_t(const char *, const char *);
+
+/**
+ * Same as `git_config_bool`, except that integers are returned as-is, and
+ * an `is_bool` flag is unset.
+ */
 int git_config_bool_or_int(const char *, const char *, int *);
+
+/**
+ * Parse a string into a boolean value, respecting keywords like "true" and
+ * "false". Integer values are converted into true/false values (when they
+ * are non-zero or zero, respectively). Other values cause a die(). If
+ * parsing is successful, the return value is the result.
+ */
 int git_config_bool(const char *, const char *);
+
+/**
+ * Allocates and copies the value string into the `dest` parameter; if no
+ * string is given, prints an error message and returns -1.
+ */
 int git_config_string(const char **, const char *, const char *);
+
+/**
+ * Similar to `git_config_string`, but expands `~` or `~user` into the
+ * user's home directory when found at the beginning of the path.
+ */
 int git_config_pathname(const char **, const char *, const char *);
 int git_config_expiry_date(timestamp_t *, const char *, const char *);
 int git_config_color(char *, const char *, const char *);
 int git_config_set_in_file_gently(const char *, const char *, const char *);
+
+/**
+ * write config values to a specific config file
+ * takes a key/value pair as parameter.
+ */
 void git_config_set_in_file(const char *, const char *, const char *);
 int git_config_set_gently(const char *, const char *);
+
+/**
+ * write config values to `.git/config`
+ * takes a key/value pair as parameter.
+ */
 void git_config_set(const char *, const char *);
 int git_config_parse_key(const char *, char **, int *);
 int git_config_key_is_valid(const char *key);
 int git_config_set_multivar_gently(const char *, const char *, const char *, int);
 void git_config_set_multivar(const char *, const char *, const char *, int);
 int git_config_set_multivar_in_file_gently(const char *, const char *, const char *, const char *, int);
+
+/**
+ * takes four parameters:
+ *
+ * - the name of the file, as a string, to which key/value pairs will be written.
+ *
+ * - the name of key, as a string. This is in canonical "flat" form: the section,
+ *   subsection, and variable segments will be separated by dots, and the section
+ *   and variable segments will be all lowercase.
+ *   E.g., `core.ignorecase`, `diff.SomeType.textconv`.
+ *
+ * - the value of the variable, as a string. If value is equal to NULL, it will
+ *   remove the matching key from the config file.
+ *
+ * - the value regex, as a string. It will disregard key/value pairs where value
+ *   does not match.
+ *
+ * - a multi_replace value, as an int. If value is equal to zero, nothing or only
+ *   one matching key/value is replaced, else all matching key/values (regardless
+ *   how many) are removed, before the new pair is written.
+ *
+ * It returns 0 on success.
+ */
 void git_config_set_multivar_in_file(const char *, const char *, const char *, const char *, int);
+
+/**
+ * rename or remove sections in the config file
+ * parameters `old_name` and `new_name`
+ * If NULL is passed through `new_name` parameter,
+ * the section will be removed from the config file.
+ */
 int git_config_rename_section(const char *, const char *);
 int git_config_rename_section_in_file(const char *, const char *, const char *);
 int git_config_copy_section(const char *, const char *);
@@ -142,6 +300,30 @@ enum config_scope current_config_scope(void);
 const char *current_config_origin_type(void);
 const char *current_config_name(void);
 
+/**
+ * Include Directives
+ * ------------------
+ *
+ * By default, the config parser does not respect include directives.
+ * However, a caller can use the special `git_config_include` wrapper
+ * callback to support them. To do so, you simply wrap your "real" callback
+ * function and data pointer in a `struct config_include_data`, and pass
+ * the wrapper to the regular config-reading functions. For example:
+ *
+ * -------------------------------------------
+ * int read_file_with_include(const char *file, config_fn_t fn, void *data)
+ * {
+ * struct config_include_data inc = CONFIG_INCLUDE_INIT;
+ * inc.fn = fn;
+ * inc.data = data;
+ * return git_config_from_file(git_config_include, file, &inc);
+ * }
+ * -------------------------------------------
+ *
+ * `git_config` respects includes automatically. The lower-level
+ * `git_config_from_file` does not.
+ *
+ */
 struct config_include_data {
 	int depth;
 	config_fn_t fn;
@@ -169,6 +351,33 @@ int parse_config_key(const char *var,
 		     const char **subsection, int *subsection_len,
 		     const char **key);
 
+/**
+ * Custom Configsets
+ * -----------------
+ *
+ * A `config_set` can be used to construct an in-memory cache for
+ * config-like files that the caller specifies (i.e., files like `.gitmodules`,
+ * `~/.gitconfig` etc.). For example,
+ *
+ * ----------------------------------------
+ * struct config_set gm_config;
+ * git_configset_init(&gm_config);
+ * int b;
+ * //we add config files to the config_set
+ * git_configset_add_file(&gm_config, ".gitmodules");
+ * git_configset_add_file(&gm_config, ".gitmodules_alt");
+ *
+ * if (!git_configset_get_bool(gm_config, "submodule.frotz.ignore", &b)) {
+ * //hack hack hack
+ * }
+ *
+ * when we are done with the configset:
+ * git_configset_clear(&gm_config);
+ * ----------------------------------------
+ *
+ * Configset API provides functions for the above mentioned work flow
+ */
+
 struct config_set_element {
 	struct hashmap_entry ent;
 	char *key;
@@ -197,15 +406,45 @@ struct config_set {
 	struct configset_list list;
 };
 
+/**
+ * Initializes the config_set `cs`.
+ */
 void git_configset_init(struct config_set *cs);
+
+/**
+ * Parses the file and adds the variable-value pairs to the `config_set`,
+ * dies if there is an error in parsing the file. Returns 0 on success, or
+ * -1 if the file does not exist or is inaccessible. The user has to decide
+ * if he wants to free the incomplete configset or continue using it when
+ * the function returns -1.
+ */
 int git_configset_add_file(struct config_set *cs, const char *filename);
+
+/**
+ * Finds and returns the value list, sorted in order of increasing priority
+ * for the configuration variable `key` and config set `cs`. When the
+ * configuration variable `key` is not found, returns NULL. The caller
+ * should not free or modify the returned pointer, as it is owned by the cache.
+ */
 const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key);
+
+/**
+ * Clears `config_set` structure, removes all saved variable-value pairs.
+ */
 void git_configset_clear(struct config_set *cs);
 
 /*
  * These functions return 1 if not found, and 0 if found, leaving the found
  * value in the 'dest' pointer.
  */
+
+/*
+ * Finds the highest-priority value for the configuration variable `key`
+ * and config set `cs`, stores the pointer to it in `value` and returns 0.
+ * When the configuration variable `key` is not found, returns 1 without
+ * touching `value`. The caller should not free or modify `value`, as it
+ * is owned by the cache.
+ */
 int git_configset_get_value(struct config_set *cs, const char *key, const char **dest);
 int git_configset_get_string_const(struct config_set *cs, const char *key, const char **dest);
 int git_configset_get_string(struct config_set *cs, const char *key, char **dest);
@@ -240,16 +479,92 @@ int repo_config_get_maybe_bool(struct repository *repo,
 int repo_config_get_pathname(struct repository *repo,
 			     const char *key, const char **dest);
 
+/**
+ * Querying For Specific Variables
+ * -------------------------------
+ *
+ * For programs wanting to query for specific variables in a non-callback
+ * manner, the config API provides two functions `git_config_get_value`
+ * and `git_config_get_value_multi`. They both read values from an internal
+ * cache generated previously from reading the config files.
+ */
+
+/**
+ * Finds the highest-priority value for the configuration variable `key`,
+ * stores the pointer to it in `value` and returns 0. When the
+ * configuration variable `key` is not found, returns 1 without touching
+ * `value`. The caller should not free or modify `value`, as it is owned
+ * by the cache.
+ */
 int git_config_get_value(const char *key, const char **value);
+
+/**
+ * Finds and returns the value list, sorted in order of increasing priority
+ * for the configuration variable `key`. When the configuration variable
+ * `key` is not found, returns NULL. The caller should not free or modify
+ * the returned pointer, as it is owned by the cache.
+ */
 const struct string_list *git_config_get_value_multi(const char *key);
+
+/**
+ * Resets and invalidates the config cache.
+ */
 void git_config_clear(void);
+
+/**
+ * Allocates and copies the retrieved string into the `dest` parameter for
+ * the configuration variable `key`; if NULL string is given, prints an
+ * error message and returns -1. When the configuration variable `key` is
+ * not found, returns 1 without touching `dest`.
+ */
 int git_config_get_string_const(const char *key, const char **dest);
+
+/**
+ * Similar to `git_config_get_string_const`, except that retrieved value
+ * copied into the `dest` parameter is a mutable string.
+ */
 int git_config_get_string(const char *key, char **dest);
+
+/**
+ * Finds and parses the value to an integer for the configuration variable
+ * `key`. Dies on error; otherwise, stores the value of the parsed integer in
+ * `dest` and returns 0. When the configuration variable `key` is not found,
+ * returns 1 without touching `dest`.
+ */
 int git_config_get_int(const char *key, int *dest);
+
+/**
+ * Similar to `git_config_get_int` but for unsigned longs.
+ */
 int git_config_get_ulong(const char *key, unsigned long *dest);
+
+/**
+ * Finds and parses the value into a boolean value, for the configuration
+ * variable `key` respecting keywords like "true" and "false". Integer
+ * values are converted into true/false values (when they are non-zero or
+ * zero, respectively). Other values cause a die(). If parsing is successful,
+ * stores the value of the parsed result in `dest` and returns 0. When the
+ * configuration variable `key` is not found, returns 1 without touching
+ * `dest`.
+ */
 int git_config_get_bool(const char *key, int *dest);
+
+/**
+ * Similar to `git_config_get_bool`, except that integers are copied as-is,
+ * and `is_bool` flag is unset.
+ */
 int git_config_get_bool_or_int(const char *key, int *is_bool, int *dest);
+
+/**
+ * Similar to `git_config_get_bool`, except that it returns -1 on error
+ * rather than dying.
+ */
 int git_config_get_maybe_bool(const char *key, int *dest);
+
+/**
+ * Similar to `git_config_get_string`, but expands `~` or `~user` into
+ * the user's home directory when found at the beginning of the path.
+ */
 int git_config_get_pathname(const char *key, const char **dest);
 int git_config_get_index_threads(int *dest);
 int git_config_get_untracked_cache(void);
@@ -270,7 +585,19 @@ struct key_value_info {
 	enum config_scope scope;
 };
 
+/**
+ * First prints the error message specified by the caller in `err` and then
+ * dies printing the line number and the file name of the highest priority
+ * value for the configuration variable `key`.
+ */
 NORETURN void git_die_config(const char *key, const char *err, ...) __attribute__((format(printf, 2, 3)));
+
+/**
+ * Helper function which formats the die error message according to the
+ * parameters entered. Used by `git_die_config()`. It can be used by callers
+ * handling `git_config_get_value_multi()` to print the correct error message
+ * for the desired value.
+ */
 NORETURN void git_die_config_linenr(const char *key, const char *filename, int linenr);
 
 #define LOOKUP_CONFIG(mapping, var) \
-- 
gitgitgadget
