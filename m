Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50F2E20248
	for <e@80x24.org>; Mon,  4 Mar 2019 10:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfCDKtz (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 05:49:55 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55419 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfCDKtz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 05:49:55 -0500
Received: by mail-wm1-f68.google.com with SMTP id q187so4132483wme.5
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 02:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=bwFwe8H47tSsTTFnU47rWNyTid23oJgmP2tTDvrjG8k=;
        b=AtMopWk59XazhffjOEYQmGgDeWTo5HcI0qvxXNgaknYlQYlsmJtVbxxLZWv0H1CKA+
         iJ8jFtU5vmo70xXB1NLKEW8Xmw82ePLFxkllKBiqFz2hnZl4RNG/PEWgD0T0VNxS7rHZ
         SMTlvm6KR35vHNg3O07I5GmSE5Lux3A3s0ArSyTZIDLlcCySnMKPHYsKkQfuR5jH+v65
         UiYFMDxF3GDgAOWR3VO4TnlbUp5BOC8PLVlW0LSiCkCECIg042h0zGfQrKOOI7YrlnJj
         dF+vQuavM2go4MUHLisn9MVprP0iKdge9DAMaYGvImbex6AFbTwYKJ1hwU8M0z3CMyRG
         1Smg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bwFwe8H47tSsTTFnU47rWNyTid23oJgmP2tTDvrjG8k=;
        b=IxxOd0wEMVuI87DffLAQ2dvRXLa3p7rHyDyIOOtwX7IzDrhx33C8Uo9kCqjB6Meoii
         sCYzuFkhDo5vtO1xZU6UwR+E9tqlop7AheLpGWeZEUrrCgymYBKvrNOYhN155CDgau+4
         s1+olvyTyXoIOVg7Yo9NJs1PgBebtDqhqWrXIkAlpb8XG89HHV++uUe5FUWMQVFhf0ML
         Fla7wwH5aK2KVpc3EsddX7LHQ3qhQOD+feChS9DRKQKTLTBZYPz5E0xmOZKPDNJKoMDi
         8lW1ElpCdRSqHcKvbmP0zL7dzC2F9PimwIx4iyFEYDGOATVHoNmL5d9uj/9sHi9kLovO
         tTRA==
X-Gm-Message-State: AHQUAuZTJt63Vf+4R18Oq4zVn/qU/metpqQ3ZfphrktlZZbVkkYPf+xZ
        FonAJazJBET34xcmE8em+ro=
X-Google-Smtp-Source: APXvYqxHk7GR+q6Ax9EkXuVk4sBR6CGBDQYLKfHA+eoYO+/k8tdRVy/wb935N0yDfMMzd+7O97M6iw==
X-Received: by 2002:a1c:1d15:: with SMTP id d21mr10135542wmd.132.1551696590324;
        Mon, 04 Mar 2019 02:49:50 -0800 (PST)
Received: from [192.168.1.7] ([31.223.156.225])
        by smtp.gmail.com with ESMTPSA id v2sm8913730wme.29.2019.03.04.02.49.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 02:49:49 -0800 (PST)
Subject: End of Outreachy internship
To:     =?UTF-8?Q?Slavica_=c4=90uki=c4=87_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.103.v4.git.gitgitgadget@gmail.com>
 <pull.103.v5.git.gitgitgadget@gmail.com>
From:   Slavica Djukic <slavicadj.ip2018@gmail.com>
Message-ID: <917cc2e8-f35e-4882-141a-2de22149be48@gmail.com>
Date:   Mon, 4 Mar 2019 11:49:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <pull.103.v5.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

Today is officially the last day of my Outreachy internship.
I wanted to say a few things about my experience and future of the
project I worked on.
Project was "Turn git add -i into built-in" with Johannes Schindelin
as my mentor.

I truly had amazing time, I learned so much about
coding and Git itself, went to Git Merge and FOSDEM and had a chance
to meet great people.
I've never contributed before to open-source, and now that I did,
I find it invaluable experience.
Although my obligations at this point don't allow me to work on
the project, I will try my best to contribute in the future to Git
or/and other great open-source projects.
That said, my mentor Johannes Schindelin will continue to work on
the project from now on.

What is implemented in this project so far:
commands: status and help, helper functions like highlight_prefix(),
find_unique_prefixes(), is_valid_prefix(), etc., but most importantly:
list_and_choose() and list_modified().
Most of the add -i commands will use those two functions to collect,
show the data and let the user make a choice.

What is left to be done:
In the current patch series, I got a lot of suggestion from Junio,
and I applied all of them -- the only thing left is correcting
list_and_choose more to make it type-independent.
In the future, all the other commands: update, revert, add untracked,
patch, diff and quit.

I would like to thank all reviewers for useful suggestions and
comprehension.
And thousand thanks to Johannes Schindelin, who turned out to be
the most amazing mentor.

-Slavica Djukic

On 20-Feb-19 12:41 PM, Slavica Đukić via GitGitGadget wrote:
> This is the first version of a patch series to start porting
> git-add--interactive from Perl to C. Daniel Ferreira's patch series used as
> a head start:
> https://public-inbox.org/git/1494907234-28903-1-git-send-email-bnmvco@gmail.com/t/#u
>
> Changes since v4:
>
>   * rename print_modified to list_modifed
>   * the big change was implementing list_and_choose, which resulted in code
>     refactoring, i.e. separating list_modified and status_cmd and making
>     status_cmd use both list_modified and list_and_choose
>   * implement struct choice instead of struct stuff_item as main data
>     structure for list_and_choose
>   * introduce list_only option and implement support for !list_only users
>   * introduce highlighting of unique prefixes
>
> Note that authorship handling is slightly changed. In some of the commits, I
> used Original-patch-by instead of listing Daniel Ferreira as author.
>
> Also, I would like to point out that my Outreachy internship is going to
> finish on March 4 and I would really appreciate reviews before it does.
>
> Daniel Ferreira (3):
>    diff: export diffstat interface
>    add--helper: create builtin helper for interactive add
>    add--interactive.perl: use add--helper --status for status_cmd
>
> Slavica Djukic (7):
>    add-interactive.c: implement list_modified
>    add-interactive.c: implement list_and_choose
>    add-interactive.c: implement status command
>    add-interactive.c: add support for list_only option
>    add-interactive.c: implement show-help command
>    t3701-add-interactive: test add_i_show_help()
>    add--interactive.perl: use add--helper --show-help for help_cmd
>
>   .gitignore                 |   1 +
>   Makefile                   |   2 +
>   add-interactive.c          | 819 +++++++++++++++++++++++++++++++++++++
>   add-interactive.h          |  10 +
>   builtin.h                  |   1 +
>   builtin/add--helper.c      |  43 ++
>   diff.c                     |  36 +-
>   diff.h                     |  18 +
>   git-add--interactive.perl  |  17 +-
>   git.c                      |   1 +
>   t/t3701-add-interactive.sh |  24 ++
>   11 files changed, 937 insertions(+), 35 deletions(-)
>   create mode 100644 add-interactive.c
>   create mode 100644 add-interactive.h
>   create mode 100644 builtin/add--helper.c
>
>
> base-commit: ca1b4116483b397e78483376296bcd23916ab553
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-103%2FslavicaDj%2Fadd-i-v5
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-103/slavicaDj/add-i-v5
> Pull-Request: https://github.com/gitgitgadget/git/pull/103
>
> Range-diff vs v4:
>
>    1:  737767b6f4 !  1:  d839f0c082 diff: export diffstat interface
>       @@ -11,6 +11,7 @@
>            how the show_* functions used by diff_flush() do it. One example is the
>            builtin implementation of git-add--interactive's status.
>        
>       +    Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>            Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
>            Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
>        
>    2:  91b1963125 !  2:  304c3863b1 add--helper: create builtin helper for interactive add
>       @@ -2,8 +2,8 @@
>        
>            add--helper: create builtin helper for interactive add
>        
>       -    Create a builtin helper for git-add--interactive, which right now is not
>       -    able to do anything.
>       +    Create a builtin helper for git-add--interactive, which at this point
>       +    is not doing anything.
>        
>            This is the first step in an effort to convert git-add--interactive.perl
>            to a C builtin, in search for better portability, expressibility and
>       @@ -13,6 +13,7 @@
>            remove the last "big" Git script to have Perl as a dependency, allowing
>            most Git users to have a NOPERL build running without big losses.
>        
>       +    Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>            Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
>            Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
>        
>    3:  d247ef69fe !  3:  8790ffaa39 add-interactive.c: implement status command
>       @@ -1,17 +1,12 @@
>       -Author: Daniel Ferreira <bnmvco@gmail.com>
>       +Author: Slavica Djukic <slawica92@hotmail.com>
>        
>       -    add-interactive.c: implement status command
>       +    add-interactive.c: implement list_modified
>        
>       -    Add new files: add-interactive.c and add-interactive.h, which
>       -    will be used for implementing "application logic" of git add -i,
>       -    whereas add--helper.c will be used mostly for parsing the command line.
>       -    We're a bit lax with the command-line parsing, as the command is
>       -    intended to be called only by one internal user: the add--interactive script.
>       +    Implement list_modified from Perl, which will be used
>       +    by most of the *_cmd functions, including status in the
>       +    following commit.
>        
>       -    Implement add --interactive's status command in add-interactive.c and
>       -    use it in builtin add--helper.c.
>       -
>       -    It prints a numstat comparing changed files between a) the worktree and
>       +    It lists a numstat comparing changed files between a) the worktree and
>            the index; b) the index and the HEAD.
>        
>            To do so, we use run_diff_index() and run_diff_files() to get changed
>       @@ -19,11 +14,13 @@
>            combination of a hashmap and qsort() to print the result in
>            O(n) + O(n lg n) complexity.
>        
>       -    This is the first interactive add command implemented in C of those
>       -    anticipated by the previous commit, which introduced
>       -    the add--helper built-in.
>       +    Add new file: add-interactive.c which will be used for implementing
>       +    "application logic" of git add -i (alongside with add-interactive.h,
>       +    added in later commit), whereas add--helper.c will be used mostly
>       +    for parsing the command line.
>        
>       -    Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
>       +    Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>       +    Original-patch-by: Daniel Ferreira <bnmvco@gmail.com>
>            Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
>        
>         diff --git a/Makefile b/Makefile
>       @@ -43,7 +40,6 @@
>         --- /dev/null
>         +++ b/add-interactive.c
>        @@
>       -+#include "add-interactive.h"
>        +#include "cache.h"
>        +#include "commit.h"
>        +#include "color.h"
>       @@ -51,8 +47,6 @@
>        +#include "diffcore.h"
>        +#include "revision.h"
>        +
>       -+#define HEADER_INDENT "      "
>       -+
>        +enum collection_phase {
>        +	WORKTREE,
>        +	INDEX
>       @@ -75,66 +69,8 @@
>        +	struct hashmap file_map;
>        +};
>        +
>       -+static int use_color = -1;
>       -+enum color_add_i {
>       -+	COLOR_PROMPT,
>       -+	COLOR_HEADER,
>       -+	COLOR_HELP,
>       -+	COLOR_ERROR
>       -+};
>       -+
>       -+static char colors[][COLOR_MAXLEN] = {
>       -+	GIT_COLOR_BOLD_BLUE, /* Prompt */
>       -+	GIT_COLOR_BOLD,      /* Header */
>       -+	GIT_COLOR_BOLD_RED,  /* Help */
>       -+	GIT_COLOR_BOLD_RED   /* Error */
>       -+};
>       -+
>       -+static const char *get_color(enum color_add_i ix)
>       -+{
>       -+	if (want_color(use_color))
>       -+		return colors[ix];
>       -+	return "";
>       -+}
>       -+
>       -+static int parse_color_slot(const char *slot)
>       -+{
>       -+	if (!strcasecmp(slot, "prompt"))
>       -+		return COLOR_PROMPT;
>       -+	if (!strcasecmp(slot, "header"))
>       -+		return COLOR_HEADER;
>       -+	if (!strcasecmp(slot, "help"))
>       -+		return COLOR_HELP;
>       -+	if (!strcasecmp(slot, "error"))
>       -+		return COLOR_ERROR;
>       -+
>       -+	return -1;
>       -+}
>       -+
>       -+int add_i_config(const char *var,
>       -+		const char *value, void *cbdata)
>       -+{
>       -+	const char *name;
>       -+
>       -+	if (!strcmp(var, "color.interactive")) {
>       -+		use_color = git_config_colorbool(var, value);
>       -+		return 0;
>       -+	}
>       -+
>       -+	if (skip_prefix(var, "color.interactive.", &name)) {
>       -+		int slot = parse_color_slot(name);
>       -+		if (slot < 0)
>       -+			return 0;
>       -+		if (!value)
>       -+			return config_error_nonbool(var);
>       -+		return color_parse(value, colors[slot]);
>       -+	}
>       -+
>       -+	return git_default_config(var, value, cbdata);
>       -+}
>       -+
>        +static int hash_cmp(const void *unused_cmp_data, const void *entry,
>       -+			const void *entry_or_key, const void *keydata)
>       ++		    const void *entry_or_key, const void *keydata)
>        +{
>        +	const struct file_stat *e1 = entry, *e2 = entry_or_key;
>        +	const char *name = keydata ? keydata : e2->name;
>       @@ -151,8 +87,8 @@
>        +}
>        +
>        +static void collect_changes_cb(struct diff_queue_struct *q,
>       -+					 struct diff_options *options,
>       -+					 void *data)
>       ++			       struct diff_options *options,
>       ++			       void *data)
>        +{
>        +	struct collection_status *s = data;
>        +	struct diffstat_t stat = { 0 };
>       @@ -222,128 +158,73 @@
>        +	run_diff_index(&rev, 1);
>        +}
>        +
>       -+void add_i_print_modified(void)
>       ++static int is_inital_commit(void)
>        +{
>       -+	int i = 0;
>       -+	struct collection_status s;
>       -+	/* TRANSLATORS: you can adjust this to align "git add -i" status menu */
>       -+	const char *modified_fmt = _("%12s %12s %s");
>       -+	const char *header_color = get_color(COLOR_HEADER);
>        +	struct object_id sha1;
>       ++	if (get_oid("HEAD", &sha1))
>       ++		return 1;
>       ++	return 0;
>       ++}
>       ++
>       ++static const char *get_diff_reference(void)
>       ++{
>       ++	if(is_inital_commit())
>       ++		return empty_tree_oid_hex();
>       ++	return "HEAD";
>       ++}
>       ++
>       ++static void filter_files(const char *filter, struct hashmap *file_map,
>       ++			 struct file_stat **files)
>       ++{
>       ++
>       ++	for (int i = 0; i < hashmap_get_size(file_map); i++) {
>       ++		struct file_stat *f = files[i];
>       ++
>       ++		if ((!(f->worktree.added || f->worktree.deleted)) &&
>       ++		   (!strcmp(filter, "file-only")))
>       ++				hashmap_remove(file_map, f, NULL);
>        +
>       ++		if ((!(f->index.added || f->index.deleted)) &&
>       ++		   (!strcmp(filter, "index-only")))
>       ++				hashmap_remove(file_map, f, NULL);
>       ++	}
>       ++}
>       ++
>       ++static struct collection_status *list_modified(struct repository *r, const char *filter)
>       ++{
>       ++	int i = 0;
>       ++	struct collection_status *s = xcalloc(1, sizeof(*s));
>        +	struct hashmap_iter iter;
>        +	struct file_stat **files;
>        +	struct file_stat *entry;
>        +
>       -+	if (read_cache() < 0)
>       -+		return;
>       ++	if (repo_read_index(r) < 0) {
>       ++		printf("\n");
>       ++		return NULL;
>       ++	}
>        +
>       -+	s.reference = !get_oid("HEAD", &sha1) ? "HEAD": empty_tree_oid_hex();
>       -+	hashmap_init(&s.file_map, hash_cmp, NULL, 0);
>       ++	s->reference = get_diff_reference();
>       ++	hashmap_init(&s->file_map, hash_cmp, NULL, 0);
>        +
>       -+	collect_changes_worktree(&s);
>       -+	collect_changes_index(&s);
>       ++	collect_changes_worktree(s);
>       ++	collect_changes_index(s);
>        +
>       -+	if (hashmap_get_size(&s.file_map) < 1) {
>       ++	if (hashmap_get_size(&s->file_map) < 1) {
>        +		printf("\n");
>       -+		return;
>       ++		return NULL;
>        +	}
>        +
>       -+	printf(HEADER_INDENT);
>       -+	color_fprintf(stdout, header_color, modified_fmt, _("staged"),
>       -+			_("unstaged"), _("path"));
>       -+	printf("\n");
>       -+
>       -+	hashmap_iter_init(&s.file_map, &iter);
>       ++	hashmap_iter_init(&s->file_map, &iter);
>        +
>       -+	files = xcalloc(hashmap_get_size(&s.file_map), sizeof(struct file_stat *));
>       ++	files = xcalloc(hashmap_get_size(&s->file_map), sizeof(struct file_stat *));
>        +	while ((entry = hashmap_iter_next(&iter))) {
>        +		files[i++] = entry;
>        +	}
>       -+	QSORT(files, hashmap_get_size(&s.file_map), alphabetical_cmp);
>       ++	QSORT(files, hashmap_get_size(&s->file_map), alphabetical_cmp);
>        +
>       -+	for (i = 0; i < hashmap_get_size(&s.file_map); i++) {
>       -+		struct file_stat *f = files[i];
>       -+
>       -+		char worktree_changes[50];
>       -+		char index_changes[50];
>       -+
>       -+		if (f->worktree.added || f->worktree.deleted)
>       -+			snprintf(worktree_changes, 50, "+%"PRIuMAX"/-%"PRIuMAX, f->worktree.added,
>       -+					f->worktree.deleted);
>       -+		else
>       -+			snprintf(worktree_changes, 50, "%s", _("nothing"));
>       -+
>       -+		if (f->index.added || f->index.deleted)
>       -+			snprintf(index_changes, 50, "+%"PRIuMAX"/-%"PRIuMAX, f->index.added,
>       -+					f->index.deleted);
>       -+		else
>       -+			snprintf(index_changes, 50, "%s", _("unchanged"));
>       -+
>       -+		printf(" %2d: ", i + 1);
>       -+		printf(modified_fmt, index_changes, worktree_changes, f->name);
>       -+		printf("\n");
>       -+	}
>       -+	printf("\n");
>       ++	if (filter)
>       ++		filter_files(filter, &s->file_map, files);
>        +
>        +	free(files);
>       -+	hashmap_free(&s.file_map, 1);
>       ++	return s;
>        +}
>       -
>       - diff --git a/add-interactive.h b/add-interactive.h
>       - new file mode 100644
>       - --- /dev/null
>       - +++ b/add-interactive.h
>       -@@
>       -+#ifndef ADD_INTERACTIVE_H
>       -+#define ADD_INTERACTIVE_H
>       -+
>       -+int add_i_config(const char *var, const char *value, void *cbdata);
>       -+
>       -+void add_i_print_modified(void);
>       -+
>       -+#endif
>       - \ No newline at end of file
>       -
>       - diff --git a/builtin/add--helper.c b/builtin/add--helper.c
>       - --- a/builtin/add--helper.c
>       - +++ b/builtin/add--helper.c
>       -@@
>       -+#include "add-interactive.h"
>       - #include "builtin.h"
>       -+#include "config.h"
>       -+#include "revision.h"
>       -+
>       -+static const char * const builtin_add_helper_usage[] = {
>       -+	N_("git add-interactive--helper <command>"),
>       -+	NULL
>       -+};
>       -+
>       -+enum cmd_mode {
>       -+	DEFAULT = 0,
>       -+	STATUS
>       -+};
>       -
>       - int cmd_add__helper(int argc, const char **argv, const char *prefix)
>       - {
>       -+	enum cmd_mode mode = DEFAULT;
>       -+
>       -+	struct option options[] = {
>       -+		OPT_CMDMODE(0, "status", &mode,
>       -+			 N_("print status information with diffstat"), STATUS),
>       -+		OPT_END()
>       -+	};
>       -+
>       -+	git_config(add_i_config, NULL);
>       -+	argc = parse_options(argc, argv, NULL, options,
>       -+			     builtin_add_helper_usage,
>       -+			     PARSE_OPT_KEEP_ARGV0);
>       -+
>       -+	if (mode == STATUS)
>       -+		add_i_print_modified();
>       -+	else
>       -+		usage_with_options(builtin_add_helper_usage,
>       -+				   options);
>       -+
>       - 	return 0;
>       - }
>    -:  ---------- >  4:  a97b29d274 add-interactive.c: implement list_and_choose
>    -:  ---------- >  5:  9a72aabe6c add-interactive.c: implement status command
>    4:  fb3f9378ac !  6:  883963ee6e add--interactive.perl: use add--helper --status for status_cmd
>       @@ -14,6 +14,7 @@
>            the fact that it would be hard to test, we'll pass on adding
>            a regression test for this.
>        
>       +    Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>            Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
>            Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
>            Signed-off-by: Ã†var ArnfjÃ¶rÃ° Bjarmason <avarab@gmail.com>
>    -:  ---------- >  7:  7912f37517 add-interactive.c: add support for list_only option
>    5:  ab16afd1d5 !  8:  441321fc3d add-interactive.c: implement show-help command
>       @@ -10,31 +10,32 @@
>            handle_builtin and re-routed to the help command, without ever
>            calling cmd_add__helper().
>        
>       +    Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>            Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
>        
>         diff --git a/add-interactive.c b/add-interactive.c
>         --- a/add-interactive.c
>         +++ b/add-interactive.c
>        @@
>       - 	free(files);
>       - 	hashmap_free(&s.file_map, 1);
>       + 	free(s);
>       + 	free_choices(&choices);
>         }
>        +
>        +void add_i_show_help(void)
>        +{
>        +	const char *help_color = get_color(COLOR_HELP);
>        +	color_fprintf_ln(stdout, help_color, "status        - %s",
>       -+			_("show paths with changes"));
>       ++			 _("show paths with changes"));
>        +	color_fprintf_ln(stdout, help_color, "update        - %s",
>       -+			_("add working tree state to the staged set of changes"));
>       ++			 _("add working tree state to the staged set of changes"));
>        +	color_fprintf_ln(stdout, help_color, "revert        - %s",
>       -+			_("revert staged set of changes back to the HEAD version"));
>       ++			 _("revert staged set of changes back to the HEAD version"));
>        +	color_fprintf_ln(stdout, help_color, "patch         - %s",
>       -+			_("pick hunks and update selectively"));
>       ++			 _("pick hunks and update selectively"));
>        +	color_fprintf_ln(stdout, help_color, "diff          - %s",
>       -+			_("view diff between HEAD and index"));
>       ++			 _("view diff between HEAD and index"));
>        +	color_fprintf_ln(stdout, help_color, "add untracked - %s",
>       -+			_("add contents of untracked files to the staged set of changes"));
>       ++			 _("add contents of untracked files to the staged set of changes"));
>        +}
>        
>         diff --git a/add-interactive.h b/add-interactive.h
>       @@ -42,13 +43,11 @@
>         +++ b/add-interactive.h
>        @@
>         
>       - void add_i_print_modified(void);
>       + void add_i_status(void);
>         
>       --#endif
>       - \ No newline at end of file
>        +void add_i_show_help(void);
>        +
>       -+#endif
>       + #endif
>        
>         diff --git a/builtin/add--helper.c b/builtin/add--helper.c
>         --- a/builtin/add--helper.c
>       @@ -66,16 +65,16 @@
>        @@
>         	struct option options[] = {
>         		OPT_CMDMODE(0, "status", &mode,
>       - 			 N_("print status information with diffstat"), STATUS),
>       + 			    N_("print status information with diffstat"), STATUS),
>        +		OPT_CMDMODE(0, "show-help", &mode,
>       -+			 N_("show help"), HELP),
>       ++			    N_("show help"), HELP),
>         		OPT_END()
>         	};
>         
>        @@
>         
>         	if (mode == STATUS)
>       - 		add_i_print_modified();
>       + 		add_i_status();
>        +	else if (mode == HELP)
>        +		add_i_show_help();
>         	else
>    6:  0a27304a84 !  9:  315ae8b211 t3701-add-interactive: test add_i_show_help()
>       @@ -11,6 +11,7 @@
>            Prefix git add -i call with GIT_PAGER_IN_USE=true TERM=vt100
>            to force colored output on Windows.
>        
>       +    Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>            Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
>        
>         diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
>    7:  ca2a7c4375 ! 10:  2b4bdce730 add--interactive.perl: use add--helper --show-help for help_cmd
>       @@ -12,6 +12,7 @@
>            to print the numstat, also here we forgo adding a regression test:
>            the Perl script is on its way out (and this patch is part of that journey).
>        
>       +    Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>            Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
>            Signed-off-by: Ã†var ArnfjÃ¶rÃ° Bjarmason <avarab@gmail.com>
>        
>
