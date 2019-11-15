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
	by dcvr.yhbt.net (Postfix) with ESMTP id 10BC11F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 11:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfKOLLe (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 06:11:34 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42717 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbfKOLL3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 06:11:29 -0500
Received: by mail-wr1-f68.google.com with SMTP id a15so10516486wrf.9
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 03:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=lJQ2WGr3MfSsDJkCQj2oQttYDfevOMbXuCs8U7gTQt0=;
        b=sBuOP9pcftvEL/vxeb04r4dfL/+h2DCE86hhyYqfHJlA8JeJqWPZkvJYj9WVR8Wrf2
         Mf6C92qiKP8VrX2pvqBRw7UhlZSkKp2PG4Zqu7+swQETq052lNjw3hScocmX/vCdbycv
         SkfHAnwOE7pPLxvcq/NQMOF054RM41uY9gme9WZ9gVmT6mbEeJoc8dWbhppcVgLXz37n
         CWHNtT133h7OA6GOoNjGN/lCntow7usZA19WvussrOApR9RSfV6gmVsjJg/Rp5ZWp0jh
         cfDTsp8BPay3cfVVELUv7iTH7MzmAySAowBOLEtW2OwZe2JyhSzVqYpNovwwqe5lF9ie
         7+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=lJQ2WGr3MfSsDJkCQj2oQttYDfevOMbXuCs8U7gTQt0=;
        b=kHimFYuxF5ki0l4sMDkLC876wRNRWlOwewNR1LUCK7ukLJzmnHgX4G4bgW5mVW8O/E
         v2wCl5Cn+6+8fcCxuGo6sXPtcJ34saMCU4bffAIcm8+K1/QnuwFDIF0jxiQu9p/pWUaE
         woRkb16dAHKMgqlEKmbGMDkfgegiza3Ppp4pDxnp91DOk1RpqMifKJgKk1HJtBZJ6msO
         hEy+m0PNvDy+gqwojYlYzz+wVqzqd5SgZ7Yd403JLAN/3O1aZNhcFrdWWieNne71Oqli
         oBZZ5zfO4P7yoB+ZCIvLZfYUJtGeekThm+tNfBYn8FVCTp4BKfxAGC/5oAdpE92307eR
         QMjA==
X-Gm-Message-State: APjAAAXe+ZmULEHQT1l++i8KS9lR/6n+kavjpLLSZ52FXMdFdM5pjBkm
        Bc73IJZ8HHfBJii/Hcv0eXyuKqMy
X-Google-Smtp-Source: APXvYqxiulX75bAN9XyHg3ywM1mYgjBQZ7stWEIwQmJc9C6z+XS/8dpluB+OynyH0anIz/NfjSQ6FQ==
X-Received: by 2002:adf:81e5:: with SMTP id 92mr14094045wra.41.1573816284281;
        Fri, 15 Nov 2019 03:11:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 91sm11905162wrm.42.2019.11.15.03.11.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 03:11:23 -0800 (PST)
Message-Id: <4836191271fb260df837d431c55a1d8316edbdb4.1573816280.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v7.git.1573816280.gitgitgadget@gmail.com>
References: <pull.170.v6.git.1573648866.gitgitgadget@gmail.com>
        <pull.170.v7.git.1573816280.gitgitgadget@gmail.com>
From:   "Daniel Ferreira via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 Nov 2019 11:11:14 +0000
Subject: [PATCH v7 3/9] built-in add -i: implement the `status` command
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     "Jeff Hostetler <git@jeffhostetler.com>, Jeff King" <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Daniel Ferreira <bnmvco@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Daniel Ferreira <bnmvco@gmail.com>

This implements the `status` command of `git add -i`. The data
structures introduced in this commit will be extended later, as needed.

At this point, we re-implement only part of the `list_and_choose()`
function of the Perl script `git-add--interactive.perl` and call it
`list()`. It does not yet color anything, or do columns, or allow user
input.

Over the course of the next commits, we will introduce a
`list_and_choose()` function that uses `list()` to display the list of
options and let the user choose one or more of the displayed items. This
will be used to implement the main loop of the built-in `git add -i`, at
which point the new `status` command can actually be used.

Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
Signed-off-by: Slavica Đukić <slawica92@hotmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 251 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 250 insertions(+), 1 deletion(-)

diff --git a/add-interactive.c b/add-interactive.c
index 482e458dc6..aa35184d87 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -1,7 +1,256 @@
 #include "cache.h"
 #include "add-interactive.h"
+#include "diffcore.h"
+#include "revision.h"
+#include "refs.h"
+#include "string-list.h"
+
+struct add_i_state {
+	struct repository *r;
+};
+
+static void init_add_i_state(struct add_i_state *s, struct repository *r)
+{
+       s->r = r;
+}
+
+struct list_options {
+	const char *header;
+	void (*print_item)(int i, struct string_list_item *item, void *print_item_data);
+	void *print_item_data;
+};
+
+static void list(struct string_list *list, struct list_options *opts)
+{
+	int i;
+
+	if (!list->nr)
+		return;
+
+	if (opts->header)
+		printf("%s\n", opts->header);
+
+	for (i = 0; i < list->nr; i++) {
+		opts->print_item(i, list->items + i, opts->print_item_data);
+		putchar('\n');
+	}
+}
+
+struct adddel {
+	uintmax_t add, del;
+	unsigned seen:1, binary:1;
+};
+
+struct file_item {
+	struct adddel index, worktree;
+};
+
+static void add_file_item(struct string_list *files, const char *name)
+{
+	struct file_item *item = xcalloc(sizeof(*item), 1);
+
+	string_list_append(files, name)->util = item;
+}
+
+struct pathname_entry {
+	struct hashmap_entry ent;
+	const char *name;
+	struct file_item *item;
+};
+
+static int pathname_entry_cmp(const void *unused_cmp_data,
+			      const struct hashmap_entry *he1,
+			      const struct hashmap_entry *he2,
+			      const void *name)
+{
+	const struct pathname_entry *e1 =
+		container_of(he1, const struct pathname_entry, ent);
+	const struct pathname_entry *e2 =
+		container_of(he2, const struct pathname_entry, ent);
+
+	return strcmp(e1->name, name ? (const char *)name : e2->name);
+}
+
+struct collection_status {
+	enum { FROM_WORKTREE = 0, FROM_INDEX = 1 } phase;
+
+	const char *reference;
+
+	struct string_list *files;
+	struct hashmap file_map;
+};
+
+static void collect_changes_cb(struct diff_queue_struct *q,
+			       struct diff_options *options,
+			       void *data)
+{
+	struct collection_status *s = data;
+	struct diffstat_t stat = { 0 };
+	int i;
+
+	if (!q->nr)
+		return;
+
+	compute_diffstat(options, &stat, q);
+
+	for (i = 0; i < stat.nr; i++) {
+		const char *name = stat.files[i]->name;
+		int hash = strhash(name);
+		struct pathname_entry *entry;
+		struct file_item *file_item;
+		struct adddel *adddel;
+
+		entry = hashmap_get_entry_from_hash(&s->file_map, hash, name,
+						    struct pathname_entry, ent);
+		if (!entry) {
+			add_file_item(s->files, name);
+
+			entry = xcalloc(sizeof(*entry), 1);
+			hashmap_entry_init(&entry->ent, hash);
+			entry->name = s->files->items[s->files->nr - 1].string;
+			entry->item = s->files->items[s->files->nr - 1].util;
+			hashmap_add(&s->file_map, &entry->ent);
+		}
+
+		file_item = entry->item;
+		adddel = s->phase == FROM_INDEX ?
+			&file_item->index : &file_item->worktree;
+		adddel->seen = 1;
+		adddel->add = stat.files[i]->added;
+		adddel->del = stat.files[i]->deleted;
+		if (stat.files[i]->is_binary)
+			adddel->binary = 1;
+	}
+	free_diffstat_info(&stat);
+}
+
+static int get_modified_files(struct repository *r, struct string_list *files,
+			      const struct pathspec *ps)
+{
+	struct object_id head_oid;
+	int is_initial = !resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
+					     &head_oid, NULL);
+	struct collection_status s = { FROM_WORKTREE };
+
+	if (discard_index(r->index) < 0 ||
+	    repo_read_index_preload(r, ps, 0) < 0)
+		return error(_("could not read index"));
+
+	string_list_clear(files, 1);
+	s.files = files;
+	hashmap_init(&s.file_map, pathname_entry_cmp, NULL, 0);
+
+	for (s.phase = FROM_WORKTREE; s.phase <= FROM_INDEX; s.phase++) {
+		struct rev_info rev;
+		struct setup_revision_opt opt = { 0 };
+
+		opt.def = is_initial ?
+			empty_tree_oid_hex() : oid_to_hex(&head_oid);
+
+		init_revisions(&rev, NULL);
+		setup_revisions(0, NULL, &rev, &opt);
+
+		rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
+		rev.diffopt.format_callback = collect_changes_cb;
+		rev.diffopt.format_callback_data = &s;
+
+		if (ps)
+			copy_pathspec(&rev.prune_data, ps);
+
+		if (s.phase == FROM_INDEX)
+			run_diff_index(&rev, 1);
+		else {
+			rev.diffopt.flags.ignore_dirty_submodules = 1;
+			run_diff_files(&rev, 0);
+		}
+	}
+	hashmap_free_entries(&s.file_map, struct pathname_entry, ent);
+
+	/* While the diffs are ordered already, we ran *two* diffs... */
+	string_list_sort(files);
+
+	return 0;
+}
+
+static void render_adddel(struct strbuf *buf,
+				struct adddel *ad, const char *no_changes)
+{
+	if (ad->binary)
+		strbuf_addstr(buf, _("binary"));
+	else if (ad->seen)
+		strbuf_addf(buf, "+%"PRIuMAX"/-%"PRIuMAX,
+			    (uintmax_t)ad->add, (uintmax_t)ad->del);
+	else
+		strbuf_addstr(buf, no_changes);
+}
+
+struct print_file_item_data {
+	const char *modified_fmt;
+	struct strbuf buf, index, worktree;
+};
+
+static void print_file_item(int i, struct string_list_item *item,
+			    void *print_file_item_data)
+{
+	struct file_item *c = item->util;
+	struct print_file_item_data *d = print_file_item_data;
+
+	strbuf_reset(&d->index);
+	strbuf_reset(&d->worktree);
+	strbuf_reset(&d->buf);
+
+	render_adddel(&d->worktree, &c->worktree, _("nothing"));
+	render_adddel(&d->index, &c->index, _("unchanged"));
+	strbuf_addf(&d->buf, d->modified_fmt,
+		    d->index.buf, d->worktree.buf, item->string);
+
+	printf(" %2d: %s", i + 1, d->buf.buf);
+}
+
+static int run_status(struct add_i_state *s, const struct pathspec *ps,
+		      struct string_list *files, struct list_options *opts)
+{
+	if (get_modified_files(s->r, files, ps) < 0)
+		return -1;
+
+	list(files, opts);
+	putchar('\n');
+
+	return 0;
+}
 
 int run_add_i(struct repository *r, const struct pathspec *ps)
 {
-	die(_("No commands are available in the built-in `git add -i` yet!"));
+	struct add_i_state s = { NULL };
+	struct print_file_item_data print_file_item_data = {
+		"%12s %12s %s", STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
+	};
+	struct list_options opts = {
+		NULL, print_file_item, &print_file_item_data
+	};
+	struct strbuf header = STRBUF_INIT;
+	struct string_list files = STRING_LIST_INIT_DUP;
+	int res = 0;
+
+	init_add_i_state(&s, r);
+	strbuf_addstr(&header, "      ");
+	strbuf_addf(&header, print_file_item_data.modified_fmt,
+		    _("staged"), _("unstaged"), _("path"));
+	opts.header = header.buf;
+
+	if (discard_index(r->index) < 0 ||
+	    repo_read_index(r) < 0 ||
+	    repo_refresh_and_write_index(r, REFRESH_QUIET, 0, 1,
+					 NULL, NULL, NULL) < 0)
+		warning(_("could not refresh index"));
+
+	res = run_status(&s, ps, &files, &opts);
+
+	string_list_clear(&files, 1);
+	strbuf_release(&print_file_item_data.buf);
+	strbuf_release(&print_file_item_data.index);
+	strbuf_release(&print_file_item_data.worktree);
+	strbuf_release(&header);
+
+	return res;
 }
-- 
gitgitgadget

