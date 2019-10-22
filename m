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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D7791F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 07:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387891AbfJVHFM (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 03:05:12 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35670 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387590AbfJVHFM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 03:05:12 -0400
Received: by mail-wm1-f68.google.com with SMTP id 14so8349069wmu.0
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 00:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PGW916URfYd08riYcDEs/cUxg+xgqV/LDf71OVinpG0=;
        b=DYaFWl1RLpgknQN5teoUOS2VcQbCHGyEF7ZWbzWKpePRqDF7v+2ioQ1kxMefoQKsGx
         Ev1SbJtH7AL7GzTzn3axNVkUgusNBF/9EGf/jmNkKbfk1DWEHvjhyfz80pIWneYZcV0t
         TcUiq7+IwVz5Y4yIPy6hHkmSeh7l8ZsxPnWSARDV92qSjww839Is7YvZXkeuYEZPlbD2
         WM0CN6FaHdCtO6lu4+sDs5ehScHTmOD900cErth/Zaa7w7YiEjNr+idE7ISV8057PeWR
         qfDuCJOuKIQrPcJuEHLaLiSUEoWdp9S+L2XYIzEjT4kk8C7Wdtoukuo+IJ0kq8xzJRrd
         jjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PGW916URfYd08riYcDEs/cUxg+xgqV/LDf71OVinpG0=;
        b=mguvBSdNLJzmdwV3k/JDAelLFQVWfAt9uakkGgXrwQyur8+aFTrFYRWltbDMWLBuE3
         fUvzIN6kEBVX4JnYOpoeR2pUxFwSf04xD/D3E3d9f6aqbsEX4bB9yRYtU48i1b9sZnXs
         LIcOPGNgil8VPG/5LHZBdcZFKH8zgLLK8ECsuxahDtgDm67BZnxV9Jb9UkE56aZ6sXu8
         Vd/zKiqnyZRb7AIAEBgL4QVJkF/YsUk5ud9mSaZj+pub9ObLRr6ZoFAnRqMjEbv+DqRE
         WuWfNGhVRP07o/OD5BplHMjmWgU3cX/M4YKKMdXD3V30dtHvRSQLnpPQBP1guz0SsuNl
         z1OA==
X-Gm-Message-State: APjAAAUKcAJIFOgxcjOTp8bA8j5iYFj6dTzz8C7DTaIYJLqtxarrWA8D
        IMH1fp3ei4Sn8krmTaTMSo37tiuZ
X-Google-Smtp-Source: APXvYqy9u7as+GI97bnnaW1a3ad2lmkn0JXZs8e5NLfFoa4fz8518iBYqdeAtFXdEgN66slADFYlEw==
X-Received: by 2002:a7b:cc6a:: with SMTP id n10mr1590871wmj.94.1571727907544;
        Tue, 22 Oct 2019 00:05:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o4sm28715689wre.91.2019.10.22.00.05.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 00:05:07 -0700 (PDT)
Message-Id: <pull.405.v2.git.1571727906.gitgitgadget@gmail.com>
In-Reply-To: <pull.405.git.1571357219.gitgitgadget@gmail.com>
References: <pull.405.git.1571357219.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Oct 2019 07:05:05 +0000
Subject: [PATCH v2 0/1] [Outreachy] config: move documentation to config.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the documentation from Documentation/technical/api-config.txt into
config.h

Signed-off-by: Heba Waly heba.waly@gmail.com [heba.waly@gmail.com]

Thanks for taking the time to contribute to Git! Please be advised that the
Git community does not use github.com for their contributions. Instead, we
use a mailing list (git@vger.kernel.org) for code submissions, code reviews,
and bug reports. Nevertheless, you can use GitGitGadget (
https://gitgitgadget.github.io/) to conveniently send your Pull Requests
commits to our mailing list.

Please read the "guidelines for contributing" linked above!

Heba Waly (1):
  config: move documentation to config.h

 Documentation/technical/api-config.txt | 319 -----------------------
 config.h                               | 336 +++++++++++++++++++++++++
 2 files changed, 336 insertions(+), 319 deletions(-)
 delete mode 100644 Documentation/technical/api-config.txt


base-commit: 108b97dc372828f0e72e56bbb40cae8e1e83ece6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-405%2FHebaWaly%2Fconfig_documentation-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-405/HebaWaly/config_documentation-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/405

Range-diff vs v1:

 1:  2e42eafb5d ! 1:  1a9aa33b46 config: add documentation to config.h
     @@ -1,12 +1,336 @@
      Author: Heba Waly <heba.waly@gmail.com>
      
     -    config: add documentation to config.h
     -
     -    This commit is copying and summarizing the documentation from
     -    documentation/technical/api-config.txt to comments in config.h
     +    config: move documentation to config.h
      
     +    Move the documentation from Documentation/technical/api-config.txt into
     +    config.h
          Signed-off-by: Heba Waly <heba.waly@gmail.com>
      
     + diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
     + deleted file mode 100644
     + --- a/Documentation/technical/api-config.txt
     + +++ /dev/null
     +@@
     +-config API
     +-==========
     +-
     +-The config API gives callers a way to access Git configuration files
     +-(and files which have the same syntax). See linkgit:git-config[1] for a
     +-discussion of the config file syntax.
     +-
     +-General Usage
     +--------------
     +-
     +-Config files are parsed linearly, and each variable found is passed to a
     +-caller-provided callback function. The callback function is responsible
     +-for any actions to be taken on the config option, and is free to ignore
     +-some options. It is not uncommon for the configuration to be parsed
     +-several times during the run of a Git program, with different callbacks
     +-picking out different variables useful to themselves.
     +-
     +-A config callback function takes three parameters:
     +-
     +-- the name of the parsed variable. This is in canonical "flat" form: the
     +-  section, subsection, and variable segments will be separated by dots,
     +-  and the section and variable segments will be all lowercase. E.g.,
     +-  `core.ignorecase`, `diff.SomeType.textconv`.
     +-
     +-- the value of the found variable, as a string. If the variable had no
     +-  value specified, the value will be NULL (typically this means it
     +-  should be interpreted as boolean true).
     +-
     +-- a void pointer passed in by the caller of the config API; this can
     +-  contain callback-specific data
     +-
     +-A config callback should return 0 for success, or -1 if the variable
     +-could not be parsed properly.
     +-
     +-Basic Config Querying
     +----------------------
     +-
     +-Most programs will simply want to look up variables in all config files
     +-that Git knows about, using the normal precedence rules. To do this,
     +-call `git_config` with a callback function and void data pointer.
     +-
     +-`git_config` will read all config sources in order of increasing
     +-priority. Thus a callback should typically overwrite previously-seen
     +-entries with new ones (e.g., if both the user-wide `~/.gitconfig` and
     +-repo-specific `.git/config` contain `color.ui`, the config machinery
     +-will first feed the user-wide one to the callback, and then the
     +-repo-specific one; by overwriting, the higher-priority repo-specific
     +-value is left at the end).
     +-
     +-The `config_with_options` function lets the caller examine config
     +-while adjusting some of the default behavior of `git_config`. It should
     +-almost never be used by "regular" Git code that is looking up
     +-configuration variables. It is intended for advanced callers like
     +-`git-config`, which are intentionally tweaking the normal config-lookup
     +-process. It takes two extra parameters:
     +-
     +-`config_source`::
     +-If this parameter is non-NULL, it specifies the source to parse for
     +-configuration, rather than looking in the usual files. See `struct
     +-git_config_source` in `config.h` for details. Regular `git_config` defaults
     +-to `NULL`.
     +-
     +-`opts`::
     +-Specify options to adjust the behavior of parsing config files. See `struct
     +-config_options` in `config.h` for details. As an example: regular `git_config`
     +-sets `opts.respect_includes` to `1` by default.
     +-
     +-Reading Specific Files
     +-----------------------
     +-
     +-To read a specific file in git-config format, use
     +-`git_config_from_file`. This takes the same callback and data parameters
     +-as `git_config`.
     +-
     +-Querying For Specific Variables
     +--------------------------------
     +-
     +-For programs wanting to query for specific variables in a non-callback
     +-manner, the config API provides two functions `git_config_get_value`
     +-and `git_config_get_value_multi`. They both read values from an internal
     +-cache generated previously from reading the config files.
     +-
     +-`int git_config_get_value(const char *key, const char **value)`::
     +-
     +-	Finds the highest-priority value for the configuration variable `key`,
     +-	stores the pointer to it in `value` and returns 0. When the
     +-	configuration variable `key` is not found, returns 1 without touching
     +-	`value`. The caller should not free or modify `value`, as it is owned
     +-	by the cache.
     +-
     +-`const struct string_list *git_config_get_value_multi(const char *key)`::
     +-
     +-	Finds and returns the value list, sorted in order of increasing priority
     +-	for the configuration variable `key`. When the configuration variable
     +-	`key` is not found, returns NULL. The caller should not free or modify
     +-	the returned pointer, as it is owned by the cache.
     +-
     +-`void git_config_clear(void)`::
     +-
     +-	Resets and invalidates the config cache.
     +-
     +-The config API also provides type specific API functions which do conversion
     +-as well as retrieval for the queried variable, including:
     +-
     +-`int git_config_get_int(const char *key, int *dest)`::
     +-
     +-	Finds and parses the value to an integer for the configuration variable
     +-	`key`. Dies on error; otherwise, stores the value of the parsed integer in
     +-	`dest` and returns 0. When the configuration variable `key` is not found,
     +-	returns 1 without touching `dest`.
     +-
     +-`int git_config_get_ulong(const char *key, unsigned long *dest)`::
     +-
     +-	Similar to `git_config_get_int` but for unsigned longs.
     +-
     +-`int git_config_get_bool(const char *key, int *dest)`::
     +-
     +-	Finds and parses the value into a boolean value, for the configuration
     +-	variable `key` respecting keywords like "true" and "false". Integer
     +-	values are converted into true/false values (when they are non-zero or
     +-	zero, respectively). Other values cause a die(). If parsing is successful,
     +-	stores the value of the parsed result in `dest` and returns 0. When the
     +-	configuration variable `key` is not found, returns 1 without touching
     +-	`dest`.
     +-
     +-`int git_config_get_bool_or_int(const char *key, int *is_bool, int *dest)`::
     +-
     +-	Similar to `git_config_get_bool`, except that integers are copied as-is,
     +-	and `is_bool` flag is unset.
     +-
     +-`int git_config_get_maybe_bool(const char *key, int *dest)`::
     +-
     +-	Similar to `git_config_get_bool`, except that it returns -1 on error
     +-	rather than dying.
     +-
     +-`int git_config_get_string_const(const char *key, const char **dest)`::
     +-
     +-	Allocates and copies the retrieved string into the `dest` parameter for
     +-	the configuration variable `key`; if NULL string is given, prints an
     +-	error message and returns -1. When the configuration variable `key` is
     +-	not found, returns 1 without touching `dest`.
     +-
     +-`int git_config_get_string(const char *key, char **dest)`::
     +-
     +-	Similar to `git_config_get_string_const`, except that retrieved value
     +-	copied into the `dest` parameter is a mutable string.
     +-
     +-`int git_config_get_pathname(const char *key, const char **dest)`::
     +-
     +-	Similar to `git_config_get_string`, but expands `~` or `~user` into
     +-	the user's home directory when found at the beginning of the path.
     +-
     +-`git_die_config(const char *key, const char *err, ...)`::
     +-
     +-	First prints the error message specified by the caller in `err` and then
     +-	dies printing the line number and the file name of the highest priority
     +-	value for the configuration variable `key`.
     +-
     +-`void git_die_config_linenr(const char *key, const char *filename, int linenr)`::
     +-
     +-	Helper function which formats the die error message according to the
     +-	parameters entered. Used by `git_die_config()`. It can be used by callers
     +-	handling `git_config_get_value_multi()` to print the correct error message
     +-	for the desired value.
     +-
     +-See test-config.c for usage examples.
     +-
     +-Value Parsing Helpers
     +----------------------
     +-
     +-To aid in parsing string values, the config API provides callbacks with
     +-a number of helper functions, including:
     +-
     +-`git_config_int`::
     +-Parse the string to an integer, including unit factors. Dies on error;
     +-otherwise, returns the parsed result.
     +-
     +-`git_config_ulong`::
     +-Identical to `git_config_int`, but for unsigned longs.
     +-
     +-`git_config_bool`::
     +-Parse a string into a boolean value, respecting keywords like "true" and
     +-"false". Integer values are converted into true/false values (when they
     +-are non-zero or zero, respectively). Other values cause a die(). If
     +-parsing is successful, the return value is the result.
     +-
     +-`git_config_bool_or_int`::
     +-Same as `git_config_bool`, except that integers are returned as-is, and
     +-an `is_bool` flag is unset.
     +-
     +-`git_parse_maybe_bool`::
     +-Same as `git_config_bool`, except that it returns -1 on error rather
     +-than dying.
     +-
     +-`git_config_string`::
     +-Allocates and copies the value string into the `dest` parameter; if no
     +-string is given, prints an error message and returns -1.
     +-
     +-`git_config_pathname`::
     +-Similar to `git_config_string`, but expands `~` or `~user` into the
     +-user's home directory when found at the beginning of the path.
     +-
     +-Include Directives
     +-------------------
     +-
     +-By default, the config parser does not respect include directives.
     +-However, a caller can use the special `git_config_include` wrapper
     +-callback to support them. To do so, you simply wrap your "real" callback
     +-function and data pointer in a `struct config_include_data`, and pass
     +-the wrapper to the regular config-reading functions. For example:
     +-
     +--------------------------------------------
     +-int read_file_with_include(const char *file, config_fn_t fn, void *data)
     +-{
     +-	struct config_include_data inc = CONFIG_INCLUDE_INIT;
     +-	inc.fn = fn;
     +-	inc.data = data;
     +-	return git_config_from_file(git_config_include, file, &inc);
     +-}
     +--------------------------------------------
     +-
     +-`git_config` respects includes automatically. The lower-level
     +-`git_config_from_file` does not.
     +-
     +-Custom Configsets
     +------------------
     +-
     +-A `config_set` can be used to construct an in-memory cache for
     +-config-like files that the caller specifies (i.e., files like `.gitmodules`,
     +-`~/.gitconfig` etc.). For example,
     +-
     +-----------------------------------------
     +-struct config_set gm_config;
     +-git_configset_init(&gm_config);
     +-int b;
     +-/* we add config files to the config_set */
     +-git_configset_add_file(&gm_config, ".gitmodules");
     +-git_configset_add_file(&gm_config, ".gitmodules_alt");
     +-
     +-if (!git_configset_get_bool(gm_config, "submodule.frotz.ignore", &b)) {
     +-	/* hack hack hack */
     +-}
     +-
     +-/* when we are done with the configset */
     +-git_configset_clear(&gm_config);
     +-----------------------------------------
     +-
     +-Configset API provides functions for the above mentioned work flow, including:
     +-
     +-`void git_configset_init(struct config_set *cs)`::
     +-
     +-	Initializes the config_set `cs`.
     +-
     +-`int git_configset_add_file(struct config_set *cs, const char *filename)`::
     +-
     +-	Parses the file and adds the variable-value pairs to the `config_set`,
     +-	dies if there is an error in parsing the file. Returns 0 on success, or
     +-	-1 if the file does not exist or is inaccessible. The user has to decide
     +-	if he wants to free the incomplete configset or continue using it when
     +-	the function returns -1.
     +-
     +-`int git_configset_get_value(struct config_set *cs, const char *key, const char **value)`::
     +-
     +-	Finds the highest-priority value for the configuration variable `key`
     +-	and config set `cs`, stores the pointer to it in `value` and returns 0.
     +-	When the configuration variable `key` is not found, returns 1 without
     +-	touching `value`. The caller should not free or modify `value`, as it
     +-	is owned by the cache.
     +-
     +-`const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key)`::
     +-
     +-	Finds and returns the value list, sorted in order of increasing priority
     +-	for the configuration variable `key` and config set `cs`. When the
     +-	configuration variable `key` is not found, returns NULL. The caller
     +-	should not free or modify the returned pointer, as it is owned by the cache.
     +-
     +-`void git_configset_clear(struct config_set *cs)`::
     +-
     +-	Clears `config_set` structure, removes all saved variable-value pairs.
     +-
     +-In addition to above functions, the `config_set` API provides type specific
     +-functions in the vein of `git_config_get_int` and family but with an extra
     +-parameter, pointer to struct `config_set`.
     +-They all behave similarly to the `git_config_get*()` family described in
     +-"Querying For Specific Variables" above.
     +-
     +-Writing Config Files
     +---------------------
     +-
     +-Git gives multiple entry points in the Config API to write config values to
     +-files namely `git_config_set_in_file` and `git_config_set`, which write to
     +-a specific config file or to `.git/config` respectively. They both take a
     +-key/value pair as parameter.
     +-In the end they both call `git_config_set_multivar_in_file` which takes four
     +-parameters:
     +-
     +-- the name of the file, as a string, to which key/value pairs will be written.
     +-
     +-- the name of key, as a string. This is in canonical "flat" form: the section,
     +-  subsection, and variable segments will be separated by dots, and the section
     +-  and variable segments will be all lowercase.
     +-  E.g., `core.ignorecase`, `diff.SomeType.textconv`.
     +-
     +-- the value of the variable, as a string. If value is equal to NULL, it will
     +-  remove the matching key from the config file.
     +-
     +-- the value regex, as a string. It will disregard key/value pairs where value
     +-  does not match.
     +-
     +-- a multi_replace value, as an int. If value is equal to zero, nothing or only
     +-  one matching key/value is replaced, else all matching key/values (regardless
     +-  how many) are removed, before the new pair is written.
     +-
     +-It returns 0 on success.
     +-
     +-Also, there are functions `git_config_rename_section` and
     +-`git_config_rename_section_in_file` with parameters `old_name` and `new_name`
     +-for renaming or removing sections in the config files. If NULL is passed
     +-through `new_name` parameter, the section will be removed from the config file.
     +
       diff --git a/config.h b/config.h
       --- a/config.h
       +++ b/config.h
     @@ -29,7 +353,16 @@
      + * some options. It is not uncommon for the configuration to be parsed
      + * several times during the run of a Git program, with different callbacks
      + * picking out different variables useful to themselves.
     -+ *
     ++ */
     ++
     + struct object_id;
     + 
     + /* git_config_parse_key() returns these negated: */
     +@@
     + 	} error_action;
     + };
     + 
     ++/**
      + * A config callback function takes three parameters:
      + *
      + * - the name of the parsed variable. This is in canonical "flat" form: the
     @@ -47,13 +380,8 @@
      + * A config callback should return 0 for success, or -1 if the variable
      + * could not be parsed properly.
      + */
     -+
     - struct object_id;
     - 
     - /* git_config_parse_key() returns these negated: */
     -@@
     - 
       typedef int (*config_fn_t)(const char *, const char *, void *);
     ++
       int git_default_config(const char *, const char *, void *);
      +
      +/**
     @@ -61,8 +389,10 @@
      + * This function takes the same callback and data parameters as `git_config`.
      + */
       int git_config_from_file(config_fn_t fn, const char *, void *);
     ++
       int git_config_from_file_with_options(config_fn_t fn, const char *,
       				      void *,
     + 				      const struct config_options *);
      @@
       int git_config_from_parameters(config_fn_t fn, void *data);
       void read_early_config(config_fn_t cb, void *data);
     @@ -91,13 +421,13 @@
      + * intentionally tweaking the normal config-lookup process.
      + * It takes two extra parameters:
      + *
     -+ * `config_source`::
     ++ * - `config_source`
      + * If this parameter is non-NULL, it specifies the source to parse for
      + * configuration, rather than looking in the usual files. See `struct
      + * git_config_source` in `config.h` for details. Regular `git_config` defaults
      + * to `NULL`.
      + *
     -+ * `opts`::
     ++ * - `opts`
      + * Specify options to adjust the behavior of parsing config files. See `struct
      + * config_options` in `config.h` for details. As an example: regular `git_config`
      + * sets `opts.respect_includes` to `1` by default.
     @@ -110,8 +440,7 @@
      + * Value Parsing Helpers
      + * ---------------------
      + *
     -+ * To aid in parsing string values, the config API provides callbacks with
     -+ * a number of helper functions
     ++ * The following helper functions aid in parsing string values
      + */
      +
       int git_parse_ssize_t(const char *, ssize_t *);
     @@ -128,12 +457,14 @@
      + * otherwise, returns the parsed result.
      + */
       int git_config_int(const char *, const char *);
     ++
       int64_t git_config_int64(const char *, const char *);
      +
      +/**
      + * Identical to `git_config_int`, but for unsigned longs.
      + */
       unsigned long git_config_ulong(const char *, const char *);
     ++
       ssize_t git_config_ssize_t(const char *, const char *);
      +
      +/**
     @@ -161,22 +492,24 @@
      + * user's home directory when found at the beginning of the path.
      + */
       int git_config_pathname(const char **, const char *, const char *);
     ++
       int git_config_expiry_date(timestamp_t *, const char *, const char *);
       int git_config_color(char *, const char *, const char *);
       int git_config_set_in_file_gently(const char *, const char *, const char *);
      +
      +/**
     -+ * write config values to a specific config file
     -+ * takes a key/value pair as parameter.
     ++ * write config values to a specific config file, takes a key/value pair as
     ++ * parameter.
      + */
       void git_config_set_in_file(const char *, const char *, const char *);
     ++
       int git_config_set_gently(const char *, const char *);
      +
      +/**
     -+ * write config values to `.git/config`
     -+ * takes a key/value pair as parameter.
     ++ * write config values to `.git/config`, takes a key/value pair as parameter.
      + */
       void git_config_set(const char *, const char *);
     ++
       int git_config_parse_key(const char *, char **, int *);
       int git_config_key_is_valid(const char *key);
       int git_config_set_multivar_gently(const char *, const char *, const char *, int);
     @@ -214,8 +547,10 @@
      + * the section will be removed from the config file.
      + */
       int git_config_rename_section(const char *, const char *);
     ++
       int git_config_rename_section_in_file(const char *, const char *, const char *);
       int git_config_copy_section(const char *, const char *);
     + int git_config_copy_section_in_file(const char *, const char *, const char *);
      @@
       const char *current_config_origin_type(void);
       const char *current_config_name(void);
     @@ -325,8 +660,10 @@
      + * is owned by the cache.
      + */
       int git_configset_get_value(struct config_set *cs, const char *key, const char **dest);
     ++
       int git_configset_get_string_const(struct config_set *cs, const char *key, const char **dest);
       int git_configset_get_string(struct config_set *cs, const char *key, char **dest);
     + int git_configset_get_int(struct config_set *cs, const char *key, int *dest);
      @@
       int repo_config_get_pathname(struct repository *repo,
       			     const char *key, const char **dest);
     @@ -418,8 +755,10 @@
      + * the user's home directory when found at the beginning of the path.
      + */
       int git_config_get_pathname(const char *key, const char **dest);
     ++
       int git_config_get_index_threads(int *dest);
       int git_config_get_untracked_cache(void);
     + int git_config_get_split_index(void);
      @@
       	enum config_scope scope;
       };

-- 
gitgitgadget
