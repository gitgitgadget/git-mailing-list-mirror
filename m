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
	by dcvr.yhbt.net (Postfix) with ESMTP id D21F81F4B7
	for <e@80x24.org>; Tue, 27 Aug 2019 12:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbfH0M55 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 08:57:57 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39276 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfH0M55 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 08:57:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id i63so2915399wmg.4
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 05:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JPvJ99WRtH5Gsj3AkCwGNVF0oHD8DCD4LRREEAnvJus=;
        b=MxHhyIttwD2INWzm1Zp+SGXFol1lfkFFpK0Tm8EB2hN3qOy9qG6wJepBlTwZLZkael
         VV3JXK9qg6tq2JzhFQr0ucHs+LjumObZIfff64BCPtqHXNKeQYTekItM3o5gVEj/vJFJ
         eqcd2Tr77bhKYSDvhMELewEesEXpTVGlDKAYPk203xHmnh/SAoj6nKc8IEcsPeLeDfEv
         1IfesxPcGuAwCCjY4aCC3Zvlh+ie8tXTzKMptVcJSmpxI02Lk/Qi2NMdeNZMAASAyYwk
         2KO+kgxpPn38myIR0MyC53Hwgw1Rxn2kqazCSwXWcEHqSX0Xi458NGbZ+u9IQ4PKSrPU
         Wslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JPvJ99WRtH5Gsj3AkCwGNVF0oHD8DCD4LRREEAnvJus=;
        b=GOfNJHITTw6TqUxglbxw3HP5Pkqg9OlXDRksU8UlJNj0Nqx7yU74gYUIMaytLjwtgW
         kWVM1HG6Snb7L8N3Bn3gVXrPT4FfgQ2aSHo7nFbbSp6sumxy7BIH03JGOU0cdhKGx3RX
         81eNP66FIt/lyhfOJ5aCgSmIxCusiiBHwWOPEP5vB4567Cma6G3ypRrKFr1+m0IE4OCn
         zEFoq+8Jr0ODYsSLuXM4vM6YYyR8VRHdovNssVa5x8HgssrBjsYDLxygMJ/YDKNgtUpQ
         LmuGZmgP1zufGQHSH20G+CoVpQ2NJ8mUGmsV+49oWj2vZVEJuP9I9BgsJnlrq5If//yF
         0d/g==
X-Gm-Message-State: APjAAAXNbjxarf4EnsigHopdor0g71l/NWf9QtFO0dYYsFriqPzUCo5s
        Qx0BNrksJZ6KwzjTHWKbIk7/89JHDQ8=
X-Google-Smtp-Source: APXvYqwC4c9fjnjR/2cDPKm5QQ14aETHZTrUcYJmN41my7RH4rViGvtUDIGFR8JvlC0hiHQ0ZvSfQQ==
X-Received: by 2002:a1c:9648:: with SMTP id y69mr26403533wmd.122.1566910673891;
        Tue, 27 Aug 2019 05:57:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p69sm4047969wme.36.2019.08.27.05.57.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 05:57:53 -0700 (PDT)
Date:   Tue, 27 Aug 2019 05:57:53 -0700 (PDT)
X-Google-Original-Date: Tue, 27 Aug 2019 12:57:41 GMT
Message-Id: <pull.170.v4.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v3.git.gitgitgadget@gmail.com>
References: <pull.170.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 00/11] git add -i: add a rudimentary version in C (supporting only status and help 
 so far)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the first leg on the long journey to a fully built-in git add -i 
(next up: parts 2 [https://github.com/gitgitgadget/git/pull/171], 3
[https://github.com/gitgitgadget/git/pull/172], 4
[https://github.com/gitgitgadget/git/pull/173], 5
[https://github.com/gitgitgadget/git/pull/174], and 6
[https://github.com/gitgitgadget/git/pull/175]). Note: the latter PRs are
not necessarily up to date, and will be re-targeted to the appropriate
branches in https://github.com/gitster/git as soon as Junio picks them up.

This here patch series reflects the part that was submitted a couple of
times (see https://github.com/gitgitgadget/git/pull/103) during the
Outreachy project by Slavica Ðukic that continued the journey based on an
initial patch series by Daniel Ferreira.

It only implements the status and the help part, in the interest of making
the review remotely more reviewable.

As I am a heavy user of git add -p myself and use a patched version for
weeks already (it is so nice to not suffer over one second startup until the
MSYS2 Perl finally shows me anything, instead it feels instantaneous), I
integrated these patch series into Git for Windows' master already, as an
opt-in feature guarded by the config variable add.interactive.useBuiltin 
(and Git for Windows' installer is prepared to detect this version and offer
the option in the graphical user interface).

I had planned on submitting this before v2.22.0-rc0, but there was such a
backlog of builds from a big pushout that I had to wait ;-)

Changes since v3:

 * Rebased to v2.23.0 to reduce friction.
 * free_diffstat_info() is now made public as well, and used, to avoid a
   memory leak.
 * Prepared the patches for ew/hashmap (which is strict about the hashmap
   entries' type in hashmap_entry_init() and friends).
 * The private data types have been moved from prefix-map.h to prefix-map.c.
 * A lot of int types were converted to more appropriate size_t in 
   prefix-map.c.
 * A misleading parameter name list was renamed to the correct array.
 * The code comment above find_unique_prefixes() was (hopefully) improved.
 * The run_help() function's signature now reflects that most of the
   parameters are actually unused.

Changes since v2:

 * Rebased to master to avoid merge conflicts.
 * Renumbered the prefix-map test to avoid conflicts with two patch series
   that are currently in-flight in pu.

Changes since v1:

 * The config machinery was reworked completely, to not use a callback to 
   git_config(), but instead to query the config via the repo_config_get_*() 
   functions. This also prevents a future "Huh???" moment: the internal add
   --interactive API accepts a parameter of type struct repository *r, but
   the previous configuration did not use that to query the config (and
   could in the future be a repository other than the_repository).
   
   
 * As a consequence, the color sequences are no longer stored in file-local
   variables, but passed around via a struct.
   
   
 * Instead of using the magical constant -2 to quit the main loop, it is now
   defined as LIST_AND_CHOOSE_QUIT (and likewise, LIST_AND_CHOOSE_ERROR is
   defined as -1 and used where appropriate).
   
   
 * Improved the add_prefix_item() function by avoiding buffer overruns, not
   reusing the struct that is used for lookup also for adding the new item,
   and by strengthening the bug check.

Daniel Ferreira (2):
  diff: export diffstat interface
  built-in add -i: implement the `status` command

Johannes Schindelin (6):
  Start to implement a built-in version of `git add --interactive`
  built-in add -i: refresh the index before running `status`
  built-in add -i: color the header in the `status` command
  built-in add -i: implement the main loop
  built-in add -i: support `?` (prompt help)
  built-in add -i: implement the `help` command

Slavica Djukic (3):
  Add a function to determine unique prefixes for a list of strings
  built-in add -i: show unique prefixes of the commands
  built-in add -i: use color in the main loop

 Documentation/config/add.txt |   5 +
 Makefile                     |   3 +
 add-interactive.c            | 558 +++++++++++++++++++++++++++++++++++
 add-interactive.h            |   8 +
 builtin/add.c                |  10 +
 diff.c                       |  39 +--
 diff.h                       |  20 ++
 prefix-map.c                 | 123 ++++++++
 prefix-map.h                 |  29 ++
 repository.c                 |  19 ++
 repository.h                 |   7 +
 t/README                     |   4 +
 t/helper/test-prefix-map.c   |  58 ++++
 t/helper/test-tool.c         |   1 +
 t/helper/test-tool.h         |   1 +
 t/t0018-prefix-map.sh        |  10 +
 t/t3701-add-interactive.sh   |  25 ++
 17 files changed, 897 insertions(+), 23 deletions(-)
 create mode 100644 add-interactive.c
 create mode 100644 add-interactive.h
 create mode 100644 prefix-map.c
 create mode 100644 prefix-map.h
 create mode 100644 t/helper/test-prefix-map.c
 create mode 100755 t/t0018-prefix-map.sh


base-commit: 5fa0f5238b0cd46cfe7f6fa76c3f526ea98148d9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-170%2Fdscho%2Fadd-i-in-c-status-and-help-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-170/dscho/add-i-in-c-status-and-help-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/170

Range-diff vs v3:

  1:  0a5ec9345d =  1:  ad8752eca7 Start to implement a built-in version of `git add --interactive`
  2:  c7a377890d !  2:  38cc04c1d9 diff: export diffstat interface
     @@ -41,6 +41,15 @@
       static struct diffstat_file *diffstat_add(struct diffstat_t *diffstat,
       					  const char *name_a,
       					  const char *name_b)
     +@@
     + 	gather_dirstat(options, &dir, changed, "", 0);
     + }
     + 
     +-static void free_diffstat_info(struct diffstat_t *diffstat)
     ++void free_diffstat_info(struct diffstat_t *diffstat)
     + {
     + 	int i;
     + 	for (i = 0; i < diffstat->nr; i++) {
      @@
       	    dirstat_by_line) {
       		struct diffstat_t diffstat;
     @@ -109,6 +118,7 @@
       
      +void compute_diffstat(struct diff_options *options, struct diffstat_t *diffstat,
      +		      struct diff_queue_struct *q);
     ++void free_diffstat_info(struct diffstat_t *diffstat);
      +
       #define DIFF_SETUP_REVERSE      	1
       #define DIFF_SETUP_USE_SIZE_CACHE	4
  3:  b93b055ebe !  3:  ee3e40293c built-in add -i: implement the `status` command
     @@ -158,9 +158,9 @@
      +			file_index = entry->index;
      +		else {
      +			FLEX_ALLOC_STR(entry, pathname, name);
     -+			hashmap_entry_init(entry, hash);
     ++			hashmap_entry_init(&entry->ent, hash);
      +			entry->index = file_index = s->list->nr;
     -+			hashmap_add(&s->file_map, entry);
     ++			hashmap_add(&s->file_map, &entry->ent);
      +
      +			add_file_item(s->list, name);
      +		}
     @@ -173,6 +173,7 @@
      +		if (stat.files[i]->is_binary)
      +			adddel->binary = 1;
      +	}
     ++	free_diffstat_info(&stat);
      +}
      +
      +static int get_modified_files(struct repository *r, struct file_list *list,
  4:  daff24074a =  4:  3c855d9fa5 built-in add -i: refresh the index before running `status`
  5:  15f18f5b3e =  5:  24737a09f7 built-in add -i: color the header in the `status` command
  6:  175409aaae =  6:  ac67731cf1 built-in add -i: implement the main loop
  7:  3000d7d08d !  7:  c5a699b6b2 Add a function to determine unique prefixes for a list of strings
     @@ -19,7 +19,7 @@
          prefixes are stored in a hash map (for quick lookup times).
      
          To make sure that this function works as expected, we add a test using a
     -    special-purpose test helper that was added for that purpose.
     +    special-purpose test helper.
      
          Note: We expect the list of prefix items to be passed in as a list of
          pointers rather than as regular list to avoid having to copy information
     @@ -58,6 +58,19 @@
      +#include "cache.h"
      +#include "prefix-map.h"
      +
     ++struct prefix_map_entry {
     ++	struct hashmap_entry e;
     ++	const char *name;
     ++	size_t prefix_length;
     ++	/* if item is NULL, the prefix is not unique */
     ++	struct prefix_item *item;
     ++};
     ++
     ++struct prefix_map {
     ++	struct hashmap map;
     ++	size_t min_length, max_length;
     ++};
     ++
      +static int map_cmp(const void *unused_cmp_data,
      +		   const void *entry,
      +		   const void *entry_or_key,
     @@ -77,12 +90,12 @@
      +	result->name = name;
      +	result->prefix_length = prefix_length;
      +	result->item = item;
     -+	hashmap_entry_init(result, memhash(name, prefix_length));
     -+	hashmap_add(map, result);
     ++	hashmap_entry_init(&result->e, memhash(name, prefix_length));
     ++	hashmap_add(map, &result->e);
      +}
      +
      +static void init_prefix_map(struct prefix_map *prefix_map,
     -+			    int min_prefix_length, int max_prefix_length)
     ++			    size_t min_prefix_length, size_t max_prefix_length)
      +{
      +	hashmap_init(&prefix_map->map, map_cmp, NULL, 0);
      +	prefix_map->min_length = min_prefix_length;
     @@ -93,7 +106,7 @@
      +			    struct prefix_item *item)
      +{
      +	struct prefix_map_entry e = { { NULL } }, *e2;
     -+	int j;
     ++	size_t j;
      +
      +	e.item = item;
      +	e.name = item->name;
     @@ -105,8 +118,8 @@
      +			break;
      +
      +		e.prefix_length = j;
     -+		hashmap_entry_init(&e, memhash(e.name, j));
     -+		e2 = hashmap_get(&prefix_map->map, &e, NULL);
     ++		hashmap_entry_init(&e.e, memhash(e.name, j));
     ++		e2 = hashmap_get(&prefix_map->map, &e.e, NULL);
      +		if (!e2) {
      +			/* prefix is unique at this stage */
      +			item->prefix_length = j;
     @@ -119,7 +132,8 @@
      +
      +		if (j != e2->item->prefix_length || memcmp(e.name, e2->name, j))
      +			BUG("unexpected prefix length: %d != %d (%s != %s)",
     -+			    j, (int)e2->item->prefix_length, e.name, e2->name);
     ++			    (int)j, (int)e2->item->prefix_length,
     ++			    e.name, e2->name);
      +
      +		/* skip common prefix */
      +		for (; j < prefix_map->max_length && e.name[j]; j++) {
     @@ -153,15 +167,15 @@
      +	}
      +}
      +
     -+void find_unique_prefixes(struct prefix_item **list, size_t nr,
     -+			  int min_length, int max_length)
     ++void find_unique_prefixes(struct prefix_item **array, size_t nr,
     ++			  size_t min_length, size_t max_length)
      +{
     -+	int i;
     ++	size_t i;
      +	struct prefix_map prefix_map;
      +
      +	init_prefix_map(&prefix_map, min_length, max_length);
      +	for (i = 0; i < nr; i++)
     -+		add_prefix_item(&prefix_map, list[i]);
     ++		add_prefix_item(&prefix_map, array[i]);
      +	hashmap_free(&prefix_map.map, 1);
      +}
      
     @@ -180,25 +194,14 @@
      +	size_t prefix_length;
      +};
      +
     -+struct prefix_map_entry {
     -+	struct hashmap_entry e;
     -+	const char *name;
     -+	size_t prefix_length;
     -+	/* if item is NULL, the prefix is not unique */
     -+	struct prefix_item *item;
     -+};
     -+
     -+struct prefix_map {
     -+	struct hashmap map;
     -+	int min_length, max_length;
     -+};
     -+
      +/*
     -+ * Find unique prefixes in a given list of strings.
     ++ * Given an array of names, find unique prefixes (i.e. the first <n> characters
     ++ * that uniquely identify the names) and store the lengths of the unique
     ++ * prefixes in the 'prefix_length' field of the elements of the given array..
      + *
     -+ * Typically, the `struct prefix_item` information will be but a field in the
     -+ * actual item struct; For this reason, the `list` parameter is specified as a
     -+ * list of pointers to the items.
     ++ * Typically, the `struct prefix_item` information is a field in the actual
     ++ * item struct; For this reason, the `array` parameter is specified as an array
     ++ * of pointers to the items.
      + *
      + * The `min_length`/`max_length` parameters define what length the unique
      + * prefixes should have.
     @@ -206,8 +209,8 @@
      + * If no unique prefix could be found for a given item, its `prefix_length`
      + * will be set to 0.
      + */
     -+void find_unique_prefixes(struct prefix_item **list, size_t nr,
     -+			  int min_length, int max_length);
     ++void find_unique_prefixes(struct prefix_item **array, size_t nr,
     ++			  size_t min_length, size_t max_length);
      +
      +#endif
      
  8:  e23ddebfbf =  8:  bc7a74f697 built-in add -i: show unique prefixes of the commands
  9:  d8c012fce8 =  9:  74f73e26b4 built-in add -i: support `?` (prompt help)
 10:  8121a3ca1b = 10:  88001009bc built-in add -i: use color in the main loop
 11:  db70c6475d ! 11:  b27fbe289f built-in add -i: implement the `help` command
     @@ -18,22 +18,21 @@
       	return 0;
       }
       
     -+static int run_help(struct add_i_state *s, const struct pathspec *ps,
     -+		    struct file_list *files, struct list_options *opts)
     ++static int run_help(struct add_i_state *s, const struct pathspec *unused_ps,
     ++		    struct file_list *unused_files,
     ++		    struct list_options *unused_opts)
      +{
     -+	const char *help_color = s->help_color;
     -+
     -+	color_fprintf_ln(stdout, help_color, "status        - %s",
     ++	color_fprintf_ln(stdout, s->help_color, "status        - %s",
      +			 _("show paths with changes"));
     -+	color_fprintf_ln(stdout, help_color, "update        - %s",
     ++	color_fprintf_ln(stdout, s->help_color, "update        - %s",
      +			 _("add working tree state to the staged set of changes"));
     -+	color_fprintf_ln(stdout, help_color, "revert        - %s",
     ++	color_fprintf_ln(stdout, s->help_color, "revert        - %s",
      +			 _("revert staged set of changes back to the HEAD version"));
     -+	color_fprintf_ln(stdout, help_color, "patch         - %s",
     ++	color_fprintf_ln(stdout, s->help_color, "patch         - %s",
      +			 _("pick hunks and update selectively"));
     -+	color_fprintf_ln(stdout, help_color, "diff          - %s",
     ++	color_fprintf_ln(stdout, s->help_color, "diff          - %s",
      +			 _("view diff between HEAD and index"));
     -+	color_fprintf_ln(stdout, help_color, "add untracked - %s",
     ++	color_fprintf_ln(stdout, s->help_color, "add untracked - %s",
      +			 _("add contents of untracked files to the staged set of changes"));
      +
      +	return 0;

-- 
gitgitgadget
