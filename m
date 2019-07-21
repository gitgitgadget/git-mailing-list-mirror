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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9312C1F461
	for <e@80x24.org>; Sun, 21 Jul 2019 16:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbfGUQTX (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Jul 2019 12:19:23 -0400
Received: from mail-qt1-f171.google.com ([209.85.160.171]:46315 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfGUQTX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Jul 2019 12:19:23 -0400
Received: by mail-qt1-f171.google.com with SMTP id h21so36003686qtn.13
        for <git@vger.kernel.org>; Sun, 21 Jul 2019 09:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=XPUM4qqu7fLAwJN3AArkHIhL//r22Dke9Ii/EHX1u34=;
        b=lgaBmv7RsYwng68ZUxMsffkw/9Cu/yfIFjcwR01dBfk/Bo/FIHtX9XrwLH6LbSFNPK
         Z7wBIZsTs2Md9pebCybiCRElJbp9ZXsHlOMQq96uD4O/HaqVPjB0gPb38shR+E+hW3aS
         XxihD8Yh9NfWVHyvGH35yBp6LifLu1hf+RwDzh/sKu+ov/x8D1zKUaEE8qHtllcYkQ6d
         5icnTL4SVMT9Pw/x3C0SjIb0+f/ppRyU22IkdbSTWWRVheozPU2Qgpo05D7AYdAkPlOy
         97YVkveuLaYGRsP7y9ysqLbDNiDA+dMR05C8sNe38yJ3uxIUExA1hSJvnZOf1TIvRDi6
         j/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=XPUM4qqu7fLAwJN3AArkHIhL//r22Dke9Ii/EHX1u34=;
        b=EMxsaxt+FYipsGtCj8n1eafaQ4kK9jIubIAsP/1/E75OxR/V3HazHYXWQeYVq69cqB
         7tmFHYarSIxUn/lWmZ7jP7OuTU9d/UrCdPneXzOCNtwwGSX+LaWvJ7JxgBhomtawWD9d
         ZP+hfnWOfTzBOl1fKbCPreMRZQnyuveoVK60EgM1orilBjMhDDtmffdoT0sTJC39DZOK
         Mv+gfoCBVyESt07XR8W8VBfDzvZiI1j4oDWcicNlYU4UZzZ2XO9jG860FDAJA1R8VS/+
         j4hCrYvTyeMnfM27Wum+cG217gJxFT+5n/2Hstp8S8nCrJEt3a7uJlyDtHaExcrMhG+/
         aQ8w==
X-Gm-Message-State: APjAAAX0GedzQNuR5Ndz38Apy/SX9lodmhK1fQvXOpPRV1UwbUiJVbXX
        vkAta0RU1cCwiTDFCjAtFlOVmBXJ
X-Google-Smtp-Source: APXvYqzGQbWBmp3cBQ8cIU/92j5Cby/xa8okj+d0vW4kwmsVvZMi3aaZndeGoLmJqxzzLSpsUGS77g==
X-Received: by 2002:ac8:c45:: with SMTP id l5mr44475853qti.63.1563725960715;
        Sun, 21 Jul 2019 09:19:20 -0700 (PDT)
Received: from [10.0.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id 18sm17930195qkh.77.2019.07.21.09.19.19
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jul 2019 09:19:19 -0700 (PDT)
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (July 21)
Message-ID: <4ab8a4ad-045a-46fc-5046-bb90e86e5ace@gmail.com>
Date:   Sun, 21 Jul 2019 12:19:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is today's test coverage report. If anyone is interested, I now also have a way to generate these reports based on a topic branch on any public Git repo. Let me know if you would like me to run a build and give you the text report directly. I've used it myself for work in progress before submitting to the list.

Thanks,
-Stolee

[1] https://derrickstolee.github.io/git-test-coverage/reports/2019-07-21.htm
[2] https://derrickstolee.github.io/git-test-coverage/reports/2019-07-21.txt

---

pu	f241bac7a79724c13f8107bb7dad54f9bc93b0c8
jch	8eb0e318ed95f59f4b2724296d8a8e05d60f36b6
next	102302147b47505b8667bbd7a42e242728b3a860
master	9c9b961d7eb15fb583a2a812088713a68a85f1c0
master@{1}	6d5b26420848ec3bc7eae46a7ffa54f20276249d


Uncovered code in 'pu' not in 'jch'
--------------------------------------------------------

add-interactive.c
d31f31d1 20) static void init_color(struct repository *r, struct add_i_state *s,
d31f31d1 24) char *key = xstrfmt("color.interactive.%s", slot_name);
d31f31d1 27) if (!s->use_color)
d31f31d1 28) dst[0] = '\0';
d31f31d1 29) else if (repo_config_get_value(r, key, &value) ||
d31f31d1 30)  color_parse(value, dst))
d31f31d1 31) strlcpy(dst, default_color, COLOR_MAXLEN);
d31f31d1 33) free(key);
d31f31d1 34) }
d31f31d1 36) static int init_add_i_state(struct repository *r, struct add_i_state *s)
d31f31d1 40) s->r = r;
d31f31d1 42) if (repo_config_get_value(r, "color.interactive", &value))
d31f31d1 43) s->use_color = -1;
d31f31d1 45) s->use_color =
d31f31d1 46) git_config_colorbool("color.interactive", value);
d31f31d1 47) s->use_color = want_color(s->use_color);
d31f31d1 49) init_color(r, s, "header", s->header_color, GIT_COLOR_BOLD);
ec4ddbf6 50) init_color(r, s, "help", s->help_color, GIT_COLOR_BOLD_RED);
253cdc20 51) init_color(r, s, "prompt", s->prompt_color, GIT_COLOR_BOLD_BLUE);
253cdc20 52) init_color(r, s, "error", s->error_color, GIT_COLOR_BOLD_RED);
253cdc20 53) init_color(r, s, "reset", s->reset_color, GIT_COLOR_RESET);
d31f31d1 55) return 0;
928e9d0d 58) static ssize_t find_unique(const char *string,
928e9d0d 61) ssize_t found = -1, i;
928e9d0d 63) for (i = 0; i < nr; i++) {
928e9d0d 64) struct prefix_item *item = list[i];
928e9d0d 65) if (!starts_with(item->name, string))
928e9d0d 66) continue;
928e9d0d 67) if (found >= 0)
928e9d0d 68) return -1;
928e9d0d 69) found = i;
928e9d0d 72) return found;
928e9d0d 83) static void list(struct prefix_item **list, size_t nr,
81e604c5 86) int i, last_lf = 0;
bcbdcd36 88) if (!nr)
bcbdcd36 89) return;
bcbdcd36 91) if (opts->header)
d31f31d1 92) color_fprintf_ln(stdout, s->header_color,
bcbdcd36 95) for (i = 0; i < nr; i++) {
bcbdcd36 96) opts->print_item(i, list[i], opts->print_item_data);
81e604c5 98) if ((opts->columns) && ((i + 1) % (opts->columns))) {
81e604c5 99) putchar('\t');
81e604c5 100) last_lf = 0;
81e604c5 103) putchar('\n');
81e604c5 104) last_lf = 1;
81e604c5 108) if (!last_lf)
bcbdcd36 109) putchar('\n');
928e9d0d 127) static ssize_t list_and_choose(struct prefix_item **items, size_t nr,
81e604c5 131) struct strbuf input = STRBUF_INIT;
81e604c5 132) ssize_t res = LIST_AND_CHOOSE_ERROR;
928e9d0d 134) find_unique_prefixes(items, nr, 1, 4);
81e604c5 139) strbuf_reset(&input);
81e604c5 141) list(items, nr, s, &opts->list_opts);
253cdc20 143) color_fprintf(stdout, s->prompt_color, "%s", opts->prompt);
253cdc20 144) fputs("> ", stdout);
81e604c5 145) fflush(stdout);
81e604c5 147) if (strbuf_getline(&input, stdin) == EOF) {
81e604c5 148) putchar('\n');
81e604c5 149) res = LIST_AND_CHOOSE_QUIT;
81e604c5 150) break;
81e604c5 152) strbuf_trim(&input);
81e604c5 154) if (!input.len)
81e604c5 155) break;
ec4ddbf6 157) if (!strcmp(input.buf, "?")) {
ec4ddbf6 158) opts->print_help(s);
ec4ddbf6 159) continue;
81e604c5 162) p = input.buf;
81e604c5 164) size_t sep = strcspn(p, " \t\r\n,");
81e604c5 165) ssize_t index = -1;
81e604c5 167) if (!sep) {
81e604c5 168) if (!*p)
81e604c5 169) break;
81e604c5 170) p++;
81e604c5 171) continue;
81e604c5 174) if (isdigit(*p)) {
81e604c5 175) index = strtoul(p, &endp, 10) - 1;
81e604c5 176) if (endp != p + sep)
81e604c5 177) index = -1;
81e604c5 180) p[sep] = '\0';
928e9d0d 181) if (index < 0)
928e9d0d 182) index = find_unique(p, items, nr);
81e604c5 184) if (index < 0 || index >= nr)
253cdc20 185) color_fprintf_ln(stdout, s->error_color,
81e604c5 188) res = index;
81e604c5 189) break;
81e604c5 192) p += sep + 1;
81e604c5 193) }
81e604c5 195) if (res != LIST_AND_CHOOSE_ERROR)
81e604c5 196) break;
bcbdcd36 197) }
81e604c5 199) strbuf_release(&input);
81e604c5 200) return res;
bcbdcd36 216) static void add_file_item(struct file_list *list, const char *name)
bcbdcd36 220) FLEXPTR_ALLOC_STR(item, item.name, name);
bcbdcd36 222) ALLOC_GROW(list->file, list->nr + 1, list->alloc);
bcbdcd36 223) list->file[list->nr++] = item;
bcbdcd36 224) }
bcbdcd36 226) static void reset_file_list(struct file_list *list)
bcbdcd36 230) for (i = 0; i < list->nr; i++)
bcbdcd36 231) free(list->file[i]);
bcbdcd36 232) list->nr = 0;
bcbdcd36 233) }
bcbdcd36 235) static void release_file_list(struct file_list *list)
bcbdcd36 237) reset_file_list(list);
bcbdcd36 238) FREE_AND_NULL(list->file);
bcbdcd36 239) list->alloc = 0;
bcbdcd36 240) }
bcbdcd36 242) static int file_item_cmp(const void *a, const void *b)
bcbdcd36 244) const struct file_item * const *f1 = a;
bcbdcd36 245) const struct file_item * const *f2 = b;
bcbdcd36 247) return strcmp((*f1)->item.name, (*f2)->item.name);
bcbdcd36 256) static int pathname_entry_cmp(const void *unused_cmp_data,
bcbdcd36 260) const struct pathname_entry *e1 = entry, *e2 = entry_or_key;
bcbdcd36 262) return strcmp(e1->pathname,
bcbdcd36 275) static void collect_changes_cb(struct diff_queue_struct *q,
bcbdcd36 279) struct collection_status *s = data;
bcbdcd36 280) struct diffstat_t stat = { 0 };
bcbdcd36 283) if (!q->nr)
bcbdcd36 284) return;
bcbdcd36 286) compute_diffstat(options, &stat, q);
bcbdcd36 288) for (i = 0; i < stat.nr; i++) {
bcbdcd36 289) const char *name = stat.files[i]->name;
bcbdcd36 290) int hash = strhash(name);
bcbdcd36 296) entry = hashmap_get_from_hash(&s->file_map, hash, name);
bcbdcd36 297) if (entry)
bcbdcd36 298) file_index = entry->index;
bcbdcd36 300) FLEX_ALLOC_STR(entry, pathname, name);
bcbdcd36 301) hashmap_entry_init(entry, hash);
bcbdcd36 302) entry->index = file_index = s->list->nr;
bcbdcd36 303) hashmap_add(&s->file_map, entry);
bcbdcd36 305) add_file_item(s->list, name);
bcbdcd36 307) file = s->list->file[file_index];
bcbdcd36 309) adddel = s->phase == FROM_INDEX ? &file->index : &file->worktree;
bcbdcd36 310) adddel->seen = 1;
bcbdcd36 311) adddel->add = stat.files[i]->added;
bcbdcd36 312) adddel->del = stat.files[i]->deleted;
bcbdcd36 313) if (stat.files[i]->is_binary)
bcbdcd36 314) adddel->binary = 1;
bcbdcd36 318) static int get_modified_files(struct repository *r, struct file_list *list,
bcbdcd36 322) int is_initial = !resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
bcbdcd36 324) struct collection_status s = { FROM_WORKTREE };
bcbdcd36 326) if (repo_read_index_preload(r, ps, 0) < 0)
bcbdcd36 327) return error(_("could not read index"));
bcbdcd36 329) s.list = list;
bcbdcd36 330) hashmap_init(&s.file_map, pathname_entry_cmp, NULL, 0);
bcbdcd36 332) for (s.phase = FROM_WORKTREE; s.phase <= FROM_INDEX; s.phase++) {
bcbdcd36 334) struct setup_revision_opt opt = { 0 };
bcbdcd36 336) opt.def = is_initial ?
bcbdcd36 337) empty_tree_oid_hex() : oid_to_hex(&head_oid);
bcbdcd36 339) init_revisions(&rev, NULL);
bcbdcd36 340) setup_revisions(0, NULL, &rev, &opt);
bcbdcd36 342) rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
bcbdcd36 343) rev.diffopt.format_callback = collect_changes_cb;
bcbdcd36 344) rev.diffopt.format_callback_data = &s;
bcbdcd36 346) if (ps)
bcbdcd36 347) copy_pathspec(&rev.prune_data, ps);
bcbdcd36 349) if (s.phase == FROM_INDEX)
bcbdcd36 350) run_diff_index(&rev, 1);
bcbdcd36 352) rev.diffopt.flags.ignore_dirty_submodules = 1;
bcbdcd36 353) run_diff_files(&rev, 0);
bcbdcd36 356) hashmap_free(&s.file_map, 1);
bcbdcd36 359) QSORT(list->file, list->nr, file_item_cmp);
bcbdcd36 361) return 0;
bcbdcd36 364) static void populate_wi_changes(struct strbuf *buf,
bcbdcd36 367) if (ad->binary)
bcbdcd36 368) strbuf_addstr(buf, _("binary"));
bcbdcd36 369) else if (ad->seen)
bcbdcd36 370) strbuf_addf(buf, "+%"PRIuMAX"/-%"PRIuMAX,
bcbdcd36 371)     (uintmax_t)ad->add, (uintmax_t)ad->del);
bcbdcd36 373) strbuf_addstr(buf, no_changes);
bcbdcd36 374) }
928e9d0d 377) static int is_valid_prefix(const char *prefix, size_t prefix_len)
928e9d0d 379) return prefix_len && prefix &&
928e9d0d 385) strcspn(prefix, " \t\r\n,") >= prefix_len &&	/* separators */
928e9d0d 386) *prefix != '-' &&				/* deselection */
928e9d0d 387) !isdigit(*prefix) &&				/* selection */
928e9d0d 388) (prefix_len != 1 ||
928e9d0d 389)  (*prefix != '*' &&				/* "all" wildcard */
928e9d0d 390)   *prefix != '?'));				/* prompt help */
928e9d0d 398) static void print_file_item(int i, struct prefix_item *item,
bcbdcd36 401) struct file_item *c = (struct file_item *)item;
bcbdcd36 402) struct print_file_item_data *d = print_file_item_data;
bcbdcd36 404) strbuf_reset(&d->index);
bcbdcd36 405) strbuf_reset(&d->worktree);
bcbdcd36 406) strbuf_reset(&d->buf);
bcbdcd36 408) populate_wi_changes(&d->worktree, &c->worktree, _("nothing"));
bcbdcd36 409) populate_wi_changes(&d->index, &c->index, _("unchanged"));
bcbdcd36 410) strbuf_addf(&d->buf, d->modified_fmt,
bcbdcd36 413) printf(" %2d: %s", i + 1, d->buf.buf);
bcbdcd36 414) }
d31f31d1 416) static int run_status(struct add_i_state *s, const struct pathspec *ps,
bcbdcd36 419) reset_file_list(files);
d31f31d1 421) if (get_modified_files(s->r, files, ps) < 0)
bcbdcd36 422) return -1;
bcbdcd36 424) if (files->nr)
928e9d0d 425) list((struct prefix_item **)files->file, files->nr, s, opts);
bcbdcd36 426) putchar('\n');
bcbdcd36 428) return 0;
f3665cfd 431) static int run_help(struct add_i_state *s, const struct pathspec *ps,
f3665cfd 434) const char *help_color = s->help_color;
f3665cfd 436) color_fprintf_ln(stdout, help_color, "status        - %s",
f3665cfd 438) color_fprintf_ln(stdout, help_color, "update        - %s",
f3665cfd 440) color_fprintf_ln(stdout, help_color, "revert        - %s",
f3665cfd 442) color_fprintf_ln(stdout, help_color, "patch         - %s",
f3665cfd 444) color_fprintf_ln(stdout, help_color, "diff          - %s",
f3665cfd 446) color_fprintf_ln(stdout, help_color, "add untracked - %s",
f3665cfd 449) return 0;
928e9d0d 456) static void print_command_item(int i, struct prefix_item *item,
253cdc20 459) struct print_command_item_data *d = print_command_item_data;
928e9d0d 461) if (!item->prefix_length ||
928e9d0d 462)     !is_valid_prefix(item->name, item->prefix_length))
928e9d0d 463) printf(" %2d: %s", i + 1, item->name);
253cdc20 465) printf(" %2d: %s%.*s%s%s", i + 1,
253cdc20 466)        d->color, (int)item->prefix_length, item->name, d->reset,
928e9d0d 467)        item->name + item->prefix_length);
81e604c5 468) }
ec4ddbf6 476) static void command_prompt_help(struct add_i_state *s)
ec4ddbf6 478) const char *help_color = s->help_color;
ec4ddbf6 479) color_fprintf_ln(stdout, help_color, "%s", _("Prompt help:"));
ec4ddbf6 480) color_fprintf_ln(stdout, help_color, "1          - %s",
ec4ddbf6 482) color_fprintf_ln(stdout, help_color, "foo        - %s",
ec4ddbf6 484) color_fprintf_ln(stdout, help_color, "           - %s",
ec4ddbf6 486) }
db07a815 488) int run_add_i(struct repository *r, const struct pathspec *ps)
d31f31d1 490) struct add_i_state s = { NULL };
81e604c5 492) struct list_and_choose_options main_loop_opts = {
f3665cfd 497) status = { { "status" }, run_status },
f3665cfd 498) help = { { "help" }, run_help };
81e604c5 499) struct command_item *commands[] = {
bcbdcd36 504) struct print_file_item_data print_file_item_data = {
bcbdcd36 507) struct list_options opts = {
bcbdcd36 510) struct strbuf header = STRBUF_INIT;
bcbdcd36 511) struct file_list files = { NULL };
bcbdcd36 513) int res = 0;
d31f31d1 515) if (init_add_i_state(r, &s))
d31f31d1 516) return error("could not parse `add -i` config");
253cdc20 522) if (s.use_color) {
253cdc20 523) data.color = s.prompt_color;
253cdc20 524) data.reset = s.reset_color;
253cdc20 526) data.color = "[";
253cdc20 527) data.reset = "]";
bcbdcd36 530) strbuf_addstr(&header, "      ");
bcbdcd36 531) strbuf_addf(&header, print_file_item_data.modified_fmt,
bcbdcd36 533) opts.header = header.buf;
74265dd7 535) repo_refresh_and_write_index(r, REFRESH_QUIET, 1);
d31f31d1 536) if (run_status(&s, ps, &files, &opts) < 0)
74265dd7 537) res = -1;
928e9d0d 540) i = list_and_choose((struct prefix_item **)commands,
81e604c5 542) if (i == LIST_AND_CHOOSE_QUIT) {
81e604c5 543) printf(_("Bye.\n"));
81e604c5 544) res = 0;
81e604c5 545) break;
81e604c5 547) if (i != LIST_AND_CHOOSE_ERROR)
81e604c5 548) res = commands[i]->command(&s, ps, &files, &opts);
81e604c5 549) }
bcbdcd36 551) release_file_list(&files);
bcbdcd36 552) strbuf_release(&print_file_item_data.buf);
bcbdcd36 553) strbuf_release(&print_file_item_data.index);
bcbdcd36 554) strbuf_release(&print_file_item_data.worktree);
bcbdcd36 555) strbuf_release(&header);
bcbdcd36 557) return res;

builtin/add.c
db07a815 196) return !!run_add_i(the_repository, pathspec);

builtin/cat-file.c
b14ed5ad 529) warning("This repository uses promisor remotes. Some objects may not be loaded.");

builtin/fetch-pack.c

builtin/pack-objects.c
820a5361 859) BUG("configured exclusion wasn't configured");
820a5361 2794) die(_("value of uploadpack.blobpackfileuri must be "
820a5361 2797) die(_("object already configured in another "

builtin/rebase.c
526c03b5 1272) goto done;
10572de1 1288) goto done;

builtin/remote.c
f39a9c65 1551) die(_("--save-to-push cannot be used with other options"));
f39a9c65 1575) die(_("--save-to-push can only be used when only one url is defined"));

builtin/rev-list.c
cf9ceb5a 476) die(

fetch-pack.c
820a5361 1397) die("expected '<hash> <uri>', got: %s\n", reader->line);
820a5361 1402) die("expected DELIM");
820a5361 1529) die("fetch-pack: unable to spawn http-fetch");
820a5361 1533) die("fetch-pack: expected keep then TAB at start of http-fetch output");
820a5361 1538) die("fetch-pack: expected hash then LF at end of http-fetch output");
820a5361 1545) die("fetch-pack: unable to finish http-fetch");
820a5361 1549) die("fetch-pack: pack downloaded from %s does not match expected hash %.*s",
820a5361 1550)     uri, (int) the_hash_algo->hexsz,
820a5361 1551)     packfile_uris.items[i].string);

http-fetch.c

http.c
4706acc5 2304) target ? hash_to_hex(target->hash) : base_url,

list-objects-filter-options.c
f56f7642 44) BUG("filter_options already populated");
f56f7642 236) die(_("multiple filter-specs cannot be combined"));
cf9ceb5a 286) BUG("no filter_spec available for this filter");
e987df5f 321) return;

list-objects-filter.c
e987df5f 585) BUG("expected oidset to be cleared already");

list-objects.c
9430147c 210) ctx->show_object(obj, base->buf, ctx->show_data);

prefix-map.c
1f3e3049 48) break;
1f3e3049 61) continue; /* non-unique prefix */
1f3e3049 64) BUG("unexpected prefix length: %d != %d (%s != %s)",

promisor-remote.c
db27dca5 25) die(_("Remote with no URL"));
48de3158 61) warning(_("promisor remote name cannot begin with '/': %s"),
48de3158 63) return NULL;
faf2abf4 93) previous->next = r->next;
4ca9474e 108) return git_config_string(&core_partial_clone_filter_default,
fa3d1b63 139) return 0;
9e27beaa 202) static int remove_fetched_oids(struct repository *repo,
9e27beaa 206) int i, remaining_nr = 0;
9e27beaa 207) int *remaining = xcalloc(oid_nr, sizeof(*remaining));
9e27beaa 208) struct object_id *old_oids = *oids;
9e27beaa 211) for (i = 0; i < oid_nr; i++)
9e27beaa 212) if (oid_object_info_extended(repo, &old_oids[i], NULL,
9e27beaa 214) remaining[i] = 1;
9e27beaa 215) remaining_nr++;
9e27beaa 218) if (remaining_nr) {
9e27beaa 219) int j = 0;
9e27beaa 220) new_oids = xcalloc(remaining_nr, sizeof(*new_oids));
9e27beaa 221) for (i = 0; i < oid_nr; i++)
9e27beaa 222) if (remaining[i])
9e27beaa 223) oidcpy(&new_oids[j++], &old_oids[i]);
9e27beaa 224) *oids = new_oids;
9e27beaa 225) if (to_free)
9e27beaa 226) free(old_oids);
9e27beaa 229) free(remaining);
9e27beaa 231) return remaining_nr;
9e27beaa 248) if (remaining_nr == 1)
9e27beaa 249) continue;
9e27beaa 250) remaining_nr = remove_fetched_oids(repo, &remaining_oids,
9e27beaa 252) if (remaining_nr) {
9e27beaa 253) to_free = 1;
9e27beaa 254) continue;
9e27beaa 262) free(remaining_oids);

protocol.c

remote-curl.c

repository.c
74265dd7 279) int repo_refresh_and_write_index(struct repository *r,
74265dd7 282) struct lock_file lock_file = LOCK_INIT;
74265dd7 285) if (repo_read_index_preload(r, NULL, 0) < 0)
74265dd7 286) return error(_("could not read index"));
74265dd7 287) fd = repo_hold_locked_index(r, &lock_file, 0);
74265dd7 288) if (!gentle && fd < 0)
74265dd7 289) return error(_("could not lock index for writing"));
74265dd7 290) refresh_index(r->index, flags, NULL, NULL, NULL);
74265dd7 291) if (0 <= fd)
74265dd7 292) repo_update_index_if_able(r, &lock_file);
74265dd7 293) rollback_lock_file(&lock_file);
74265dd7 295) return 0;

t/helper/test-prefix-map.c
1f3e3049 16) va_start(ap, fmt);
1f3e3049 17) fprintf(stderr, "%s:%d: ", file, (int)line_no);
1f3e3049 18) vfprintf(stderr, fmt, ap);
1f3e3049 19) fputc('\n', stderr);
1f3e3049 20) va_end(ap);
1f3e3049 22) failed_count++;

upload-pack.c
a8d662e3 130) return readsz;
820a5361 149) BUG("packfile_uris requires sideband-all");
cf9ceb5a 221) sq_quote_buf(&buf, spec);
a8d662e3 354) send_client_data(1, output_state.buffer, output_state.used);
820a5361 1387) string_list_clear(&data->uri_protocols, 0);

wrapper.c

Commits introducting uncovered code:
Christian Couder	48de3158 Add initial support for many promisor remotes
Christian Couder	faf2abf4 promisor-remote: use repository_format_partial_clone
Christian Couder	4ca9474e Move core_partial_clone_filter_default to promisor-remote.c
Christian Couder	fa3d1b63 promisor-remote: parse remote.*.partialclonefilter
Christian Couder	9e27beaa promisor-remote: implement promisor_remote_get_direct()
Christian Couder	b14ed5ad Use promisor_remote_get_direct() and has_promisor_remote()
Christian Couder	db27dca5 Remove fetch-object.{c,h} in favor of promisor-remote.{c,h}
Daniel Ferreira	bcbdcd36 built-in add -i: implement the `status` command
Denton Liu	f39a9c65 remote: add --save-to-push option to git remote set-url
Denton Liu	10572de1 rebase: fast-forward --onto in more cases
Denton Liu	526c03b5 rebase: refactor can_fast_forward into goto tower
Johannes Schindelin	d31f31d1 built-in add -i: color the header in the `status` command
Johannes Schindelin	db07a815 Start to implement a built-in version of `git add --interactive`
Johannes Schindelin	f3665cfd built-in add -i: implement the `help` command
Johannes Schindelin	81e604c5 built-in add -i: implement the main loop
Johannes Schindelin	ec4ddbf6 built-in add -i: support `?` (prompt help)
Johannes Schindelin	74265dd7 built-in add -i: refresh the index before running `status`
Jonathan Tan	a8d662e3 upload-pack: refactor reading of pack-objects out
Jonathan Tan	820a5361 upload-pack: send part of packfile response as uri
Junio C Hamano	4706acc5 Merge branch 'jt/fetch-cdn-offload' into pu
Matthew DeVore	9430147c list-objects-filter: encapsulate filter components
Matthew DeVore	e987df5f list-objects-filter: implement composite filters
Matthew DeVore	f56f7642 list-objects-filter-options: move error check up
Matthew DeVore	cf9ceb5a list-objects-filter-options: make filter_spec a string_list
Slavica Djukic	928e9d0d built-in add -i: show unique prefixes of the commands
Slavica Djukic	253cdc20 built-in add -i: use color in the main loop
Slavica Djukic	1f3e3049 Add a function to determine unique prefixes for a list of strings


Uncovered code in 'jch' not in 'next'
--------------------------------------------------------

builtin/ls-files.c
272b3f2a 672) die(_("--debug-json cannot be used with other file selection options"));
272b3f2a 674) die(_("--debug-json cannot be used with %s"), "--resolve-undo");
272b3f2a 676) die(_("--debug-json cannot be used with %s"), "--with-tree");
272b3f2a 678) die(_("--debug-json cannot be used with %s"), "--debug");
272b3f2a 701) die("index file corrupt");

cache-tree.c
fd335a21 605) ret = NULL; /* not the whole tree */

dir.c
3b2385cf 2840) static void jw_object_untracked_cache_dir(struct json_writer *jw,
3b2385cf 2845) jw_object_bool(jw, "valid", ucd->valid);
3b2385cf 2846) jw_object_bool(jw, "check-only", ucd->check_only);
3b2385cf 2847) jw_object_stat_data(jw, "stat", &ucd->stat_data);
3b2385cf 2848) jw_object_string(jw, "exclude-oid", oid_to_hex(&ucd->exclude_oid));
3b2385cf 2849) jw_object_inline_begin_array(jw, "untracked");
3b2385cf 2850) for (i = 0; i < ucd->untracked_nr; i++)
3b2385cf 2851) jw_array_string(jw, ucd->untracked[i]);
3b2385cf 2852) jw_end(jw);
3b2385cf 2854) jw_object_inline_begin_object(jw, "dirs");
3b2385cf 2855) for (i = 0; i < ucd->dirs_nr; i++) {
3b2385cf 2856) jw_object_inline_begin_object(jw, ucd->dirs[i]->name);
3b2385cf 2857) jw_object_untracked_cache_dir(jw, ucd->dirs[i]);
3b2385cf 2858) jw_end(jw);
3b2385cf 2860) jw_end(jw);
3b2385cf 2861) }
3b2385cf 2958) jw_object_inline_begin_object(jw, "root");
3b2385cf 2959) jw_object_untracked_cache_dir(jw, uc->root);
3b2385cf 2960) jw_end(jw);

read-cache.c
8eeabe15 1754) ret = error(_("index uses %.4s extension, which we do not understand"),
ee70c128 1756) if (advice_unknown_index_extension) {
ee70c128 1757) warning(_("ignoring optional %.4s index extension"), ext);
ee70c128 1758) advise(_("This is likely due to the file having been written by a newer\n"
272b3f2a 2028) jw_object_true(jw, "assume_unchanged");
272b3f2a 2032) jw_object_true(jw, "skip_worktree");
272b3f2a 2034) jw_object_intmax(jw, "stage", ce_stage(ce));
f0f544da 2311) ieot = read_ieot_extension(istate, mmap, mmap_size, extension_offset);
f0f544da 3653) static struct index_entry_offset_table *read_ieot_extension(
f0f544da 3675) return do_read_ieot_extension(istate, index, extsize);

repo-settings.c
bbd04cf0 20) UPDATE_DEFAULT(rs->pack_use_sparse, 1);

split-index.c
1f825794 29) goto done;

Commits introducting uncovered code:
Derrick Stolee	bbd04cf0 repo-settings: pack.useSparse=true
Jonathan Nieder	ee70c128 index: offer advice for unknown index extensions
Nguyễn Thái Ngọc Duy	272b3f2a ls-files: add --json to dump the index
Nguyễn Thái Ngọc Duy	fd335a21 cache-tree.c: dump "TREE" extension as json
Nguyễn Thái Ngọc Duy	3b2385cf dir.c: dump "UNTR" extension as json
Nguyễn Thái Ngọc Duy	8eeabe15 read-cache.c: dump common extension info in json
Nguyễn Thái Ngọc Duy	f0f544da read-cache.c: dump "IEOT" extension as json
Nguyễn Thái Ngọc Duy	1f825794 split-index.c: dump "link" extension as json


Uncovered code in 'next' not in 'master'
--------------------------------------------------------

apply.c
85c3713d 1187) cp = skip_tree_prefix(p_value, second, line + llen - second);

builtin/clean.c
b09364c4 198) warning_errno(_(msg_warn_lstat_failed), path->buf);

builtin/clone.c
14954b79 407) die_errno(_("failed to create directory '%s'"), pathname);
14954b79 409) die_errno(_("failed to stat '%s'"), pathname);
ff7ccc8c 428) die_errno(_("failed to start iterator over '%s'"), src->buf);
ff7ccc8c 466) strbuf_setlen(src, src_len);
ff7ccc8c 467) die(_("failed to iterate over '%s'"), src->buf);

builtin/env--helper.c
b4f207f3 23) die(_("unrecognized --type argument, %s"), arg);
b4f207f3 67) default_int = 0;
b4f207f3 82) default_ulong = 0;
b4f207f3 90) BUG("unknown <type> value");

builtin/log.c
f0596ecc 219) warning("%s\n", _(warn_unspecified_mailmap_msg));

config.c
2e43cd4c 998)     value, name, cf->name, _(error_type));
2e43cd4c 1007)     value, name, cf->name, _(error_type));
2e43cd4c 1010)     value, name, cf->name, _(error_type));
2e43cd4c 1013)     value, name, cf->name, _(error_type));

dir-iterator.c
3012397e 88) warning_errno("error closing directory '%s'",
fa1da7d2 122) warning_errno("failed to stat '%s'", iter->base.path.buf);
fa1da7d2 137) goto error_out;
3012397e 152) warning_errno("error reading directory '%s'",
fa1da7d2 154) if (iter->flags & DIR_ITERATOR_PEDANTIC)
fa1da7d2 155) goto error_out;
fa1da7d2 166) if (errno != ENOENT && iter->flags & DIR_ITERATOR_PEDANTIC)
fa1da7d2 167) goto error_out;
c9bba372 188) int saved_errno = errno;
c9bba372 190) errno = saved_errno;
c9bba372 191) warning_errno("error closing directory '%s'",

range-diff.c
44b67cb6 33) return size;
44b67cb6 95) strbuf_release(&contents);
b66885a3 117) die(_("could not parse git header '%.*s'"), (int)len, line);
b66885a3 135)     patch.old_mode != patch.new_mode)
b66885a3 136) strbuf_addf(&buf, " (mode change %06o => %06o)",
44b67cb6 181) strbuf_addstr(&buf, line);

t/helper/test-dir-iterator.c
fa1da7d2 24) die("invalid option '%s'", *argv);
fa1da7d2 28) die("dir-iterator needs exactly one non-option argument");
150791ad 46) printf("[?] ");

Commits introducting uncovered code:
Ævar Arnfjörð Bjarmason	b4f207f3 env--helper: new undocumented builtin wrapping git_env_*()
Ævar Arnfjörð Bjarmason	2e43cd4c config.c: refactor die_bad_number() to not call gettext() early
Ariadne Conill	f0596ecc log: add warning for unspecified log.mailmap setting
Daniel Ferreira	150791ad dir-iterator: add tests for dir-iterator API
Johannes Schindelin	b09364c4 clean: show an error message when the path is too long
Matheus Tavares	14954b79 clone: extract function from copy_or_link_directory
Matheus Tavares	ff7ccc8c clone: use dir-iterator to avoid explicit dir traversal
Matheus Tavares	3012397e dir-iterator: refactor state machine model
Matheus Tavares	fa1da7d2 dir-iterator: add flags parameter to dir_iterator_begin
Matheus Tavares	c9bba372 dir-iterator: use warning_errno when possible
Thomas Gummerer	85c3713d apply: only pass required data to git_header_name
Thomas Gummerer	44b67cb6 range-diff: split lines manually
Thomas Gummerer	b66885a3 range-diff: add section header instead of diff header


Uncovered code in 'master' not in 'master@{1}'
--------------------------------------------------------

archive.c
50ddb089 421) err = get_tree_entry(ar_args->repo,
50ddb089 422)      &tree->object.oid,

blame.c
1fc73384 990) return;
a07a9776 1599) continue;
ae3f36de 2416) continue;

builtin/blame.c

builtin/commit-graph.c
c2bc6e6a 203) return 1;

builtin/multi-pack-index.c

builtin/rebase.c
906b6394 1801) die(_("--reschedule-failed-exec requires "

commit-graph.c
118bd570 277) chunk_repeated = 1;
118bd570 347) warning(_("commit-graph has no base graphs chunk"));
118bd570 348) return 0;
5c84b339 401) break;
d4f4d60f 550) BUG("NULL commit-graph");
d4f4d60f 553) die(_("invalid commit position. commit-graph is likely corrupt"));
d4f4d60f 613) die(_("invalid commit position. commit-graph is likely corrupt"));
6c622f9f 1057) continue;
6c622f9f 1331) error(_("failed to write correct number of base graph ids"));
6c622f9f 1332) return -1;
6c622f9f 1376) error(_("unable to create '%s'"), ctx->graph_name);
6c622f9f 1377) return -1;
6c622f9f 1451) return -1;
6c622f9f 1477) error(_("unable to open commit-graph chain file"));
6c622f9f 1478) return -1;
135a7123 1489) error(_("failed to rename base commit-graph file"));
6c622f9f 1509) error(_("failed to rename temporary commit-graph file"));
6c622f9f 1510) return -1;
c523035c 1539) break;
c523035c 1554) ctx->num_commit_graphs_after = 1;
c523035c 1555) ctx->new_base_graph = NULL;
1771be90 1631) die(_("unexpected duplicate commit id %s"),
1771be90 1632)     oid_to_hex(&ctx->commits.list[i]->object.oid));
c2bc6e6a 1806) ctx->oids.alloc = split_opts->max_commits;

fast-import.c
d3b4705a 2565) char *buf = read_object_with_reference(the_repository,
d3b4705a 2566)        &n->oid,

match-trees.c
90d34051 294) if (get_tree_entry(r, hash2, del_prefix, shifted, &mode))

midx.c
d01bf2e6 478) close_pack(packs->info[packs->nr].p);
d01bf2e6 479) FREE_AND_NULL(packs->info[packs->nr].p);
19575c7c 738) BUG("object %s is in an expired pack with int-id %d",
19575c7c 865) error(_("did not see pack-file %s to drop"),
19575c7c 867) drop_index++;
19575c7c 868) missing_drops++;
19575c7c 869) i--;
19575c7c 876) result = 1;
19575c7c 877) goto cleanup;
19575c7c 1194) return 0;
19575c7c 1209) continue;
ce1e4a10 1248) return 0;
ce1e4a10 1275) continue;
ce1e4a10 1295) continue;
ce1e4a10 1297) continue;
ce1e4a10 1329) return 0;
ce1e4a10 1350) error(_("could not start pack-objects"));
ce1e4a10 1351) result = 1;
ce1e4a10 1352) goto cleanup;
ce1e4a10 1369) error(_("could not finish pack-objects"));
ce1e4a10 1370) result = 1;
ce1e4a10 1371) goto cleanup;

oidset.c

packfile.c
8434e85d 372) strbuf_release(&buf);
8434e85d 373) return;

ref-filter.c
b31e2680 1967) break;

sequencer.c
ed5b1ca1 2198)  (*bol == ' ' || *bol == '\t'))
ed5b1ca1 2201) ret = -1;
6a1f9046 2668) in_progress_error = _("revert is already in progress");
6a1f9046 2669) in_progress_advice =
6a1f9046 2671) break;
6a1f9046 2678) BUG("unexpected action in create_seq_dir");
de81ca3f 2777) return error(_("cannot resolve HEAD"));
de81ca3f 2860) if (!rollback_is_safe())
de81ca3f 2861) goto give_advice;
de81ca3f 2873) BUG("unexpected action in sequencer_skip");
de81ca3f 2877) return error(_("failed to skip the commit"));

sha1-file.c
709dfa69 784) return;
709dfa69 792) warning(_("invalid line while parsing alternate refs: %s"),
709dfa69 794) break;
709dfa69 817) goto out;
709dfa69 819) goto out;
709dfa69 825) goto out;

strbuf.c
8f354a1f 818) strbuf_addf(buf,
8f354a1f 850) Q_("%u byte/s", "%u bytes/s", (unsigned)bytes),

t/helper/test-match-trees.c
90d34051 23) shift_tree(the_repository, &one->object.oid, &two->object.oid, &shifted, -1);

Commits introducting uncovered code:
Barret Rhoden	1fc73384 blame: optionally track line fingerprints during fill_blame_origin()
Barret Rhoden	a07a9776 blame: use the fingerprint heuristic to match ignored lines
Barret Rhoden	ae3f36de blame: add the ability to ignore commits and their changes
Derrick Stolee	ce1e4a10 midx: implement midx_repack()
Derrick Stolee	19575c7c multi-pack-index: implement 'expire' subcommand
Derrick Stolee	d01bf2e6 midx: refactor permutation logic and pack sorting
Derrick Stolee	1771be90 commit-graph: merge commit-graph chains
Derrick Stolee	c523035c commit-graph: allow cross-alternate chains
Derrick Stolee	6c622f9f commit-graph: write commit-graph chains
Derrick Stolee	8434e85d repack: refactor pack deletion for future use
Derrick Stolee	d4f4d60f commit-graph: prepare for commit-graph chains
Derrick Stolee	5c84b339 commit-graph: load commit-graph chains
Derrick Stolee	118bd570 commit-graph: add base graphs chunk
Derrick Stolee	c2bc6e6a commit-graph: create options for split files
Derrick Stolee	135a7123 commit-graph: add --split option to builtin
Dimitriy Ryazantcev	8f354a1f l10n: localizable upload progress messages
Jeff King	709dfa69 object-store.h: move for_each_alternate_ref() from transport.h
Johannes Schindelin	906b6394 rebase --am: ignore rebase.rescheduleFailedExec
Nguyễn Thái Ngọc Duy	d3b4705a sha1-file.c: remove the_repo from read_object_with_reference()
Nguyễn Thái Ngọc Duy	90d34051 match-trees.c: remove the_repo from shift_tree*()
Nguyễn Thái Ngọc Duy	50ddb089 tree-walk.c: remove the_repo from get_tree_entry()
Phillip Wood	ed5b1ca1 status: do not report errors in sequencer/todo
Rohit Ashiwal	6a1f9046 sequencer: add advice for revert
Rohit Ashiwal	de81ca3f cherry-pick/revert: add --skip option
Taylor Blau	b31e2680 ref-filter.c: find disjoint pattern prefixes

