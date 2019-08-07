Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75C351F731
	for <e@80x24.org>; Wed,  7 Aug 2019 13:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388242AbfHGN0a (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 09:26:30 -0400
Received: from mail-yw1-f52.google.com ([209.85.161.52]:44030 "EHLO
        mail-yw1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388213AbfHGN03 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 09:26:29 -0400
Received: by mail-yw1-f52.google.com with SMTP id n205so32323053ywb.10
        for <git@vger.kernel.org>; Wed, 07 Aug 2019 06:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=581Ir/5212NnjXk5Np2E4vdQZdAjilx/DKpbTuu39Lo=;
        b=Aq49YJcbxdEG6+jdhOWBsx36+x/TFuJf63qQaAUoengzrF4tztQKaHpK8svDpJnGGC
         KATLpPNIY1uUMJE0Gx7uvTMiQea89hInfXJ7qLRWVjR1rfyfReycvB8nlTaZBJDMNxUc
         Gh0nA2q2A3buu9hDR3bOhU81NFDNUbvUILC+4MJn3utsdRQvpdZXbXMru3eq4rMdtsDz
         3CZhz8Y/nLRtht24wiuYooF6JJQbxiaCnaKoDNogDSfshtdKEmTyoiJj2XArOQEVG00S
         wLbBPCiI6aOgUXDoXjV4zpVLrjkpEyuv2ZUGyHzInQ75imj19SlS6WX3gAumKXKUtwnw
         Ookg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=581Ir/5212NnjXk5Np2E4vdQZdAjilx/DKpbTuu39Lo=;
        b=bnXx76UtjwLoT2djH6BrRP96uSjlF8nlYMACRDf1uoVtkJNy5ytCeQ3dKbhJdLmZqC
         rr2mFUEjHp7Zjj/rIxXBATkHnaqV7sF/Z2xrCBoWdPsy30Miotf2D2AI3FMW3GXcCX7x
         yrPMxXD9sUg2VRb26ZvL52E22AWnXckQLeVIEQwKZmYV2H4zq+q6DbQtAmPZumwYJB9g
         OpGFE2G2XriqPeE6P/alQqebLj7Kjuey5g2uu2J0V2v581NnCm9EPRDKVN73ltpOS/XZ
         HjchPeSf2czo8G/Q26QAyaRIgMQYncQ7L3PruxaL5Hjaf8kYiAryzJxo3jOXe/hqpFbQ
         S3LQ==
X-Gm-Message-State: APjAAAVUFe/Lxccg9wS5k0wIwdYMv+ao56ITHLa/Dqe40otXwfHMHlN6
        IKJRaDbaMnjhOaq9A71Hsc20FGh2h7E=
X-Google-Smtp-Source: APXvYqw6C+ARjBjNWqvtKPgi7WuaJUEjZDPcfjfkYj7o5urFx3YTEzUepsqKwKlTlYcqBtnC515NtA==
X-Received: by 2002:a81:3795:: with SMTP id e143mr6144751ywa.508.1565184387991;
        Wed, 07 Aug 2019 06:26:27 -0700 (PDT)
Received: from [192.168.1.12] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id v135sm20805929ywc.53.2019.08.07.06.26.27
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 06:26:27 -0700 (PDT)
To:     GIT Mailing-list <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (Wed, Aug 7)
Message-ID: <f4f5ca36-641a-2170-cdbd-fd503a4e15a3@gmail.com>
Date:   Wed, 7 Aug 2019 09:26:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is today's test coverage report.

Thanks,
-Stolee

[1] https://derrickstolee.github.io/git-test-coverage/reports/2019-08-07.htm
[2] https://derrickstolee.github.io/git-test-coverage/reports/2019-08-07.txt

---

pu	6e4c1a0bf4bbb62125a3a213c7417ff2d2c7d12d
jch	2965e59c16454ff427f464cbab2ac0908b5dc657
next	deed80330f2f849fecaf1d22eaf715b93ef96954
master	7c20df84bd21ec0215358381844274fa10515017
master@{1}	026dd738a6e5f1e42ef0f390feacb5ed6acc4ee8


Uncovered code in 'pu' not in 'jch'
--------------------------------------------------------

builtin/fetch-pack.c

builtin/pack-objects.c
820a5361 862) BUG("configured exclusion wasn't configured");
820a5361 2799) die(_("value of uploadpack.blobpackfileuri must be "
820a5361 2802) die(_("object already configured in another "

builtin/rebase.c
657b2646 128) strbuf_addstr(&buf, opts->strategy_opts);
b5f2b06d 543) opts.flags |= REBASE_FORCE;
526c03b5 1302) goto done;
10572de1 1318) goto done;
657b2646 1898) die(_("cannot combine '--rebase-merges' with "

builtin/remote.c
f39a9c65 1551) die(_("--save-to-push cannot be used with other options"));
f39a9c65 1575) die(_("--save-to-push can only be used when only one url is defined"));

fetch-pack.c
8e036647 921) else if (args->depth > 0 || is_repository_shallow(r))
820a5361 1397) die("expected '<hash> <uri>', got: %s\n", reader->line);
820a5361 1402) die("expected DELIM");
820a5361 1530) die("fetch-pack: unable to spawn http-fetch");
820a5361 1534) die("fetch-pack: expected keep then TAB at start of http-fetch output");
820a5361 1539) die("fetch-pack: expected hash then LF at end of http-fetch output");
820a5361 1546) die("fetch-pack: unable to finish http-fetch");
820a5361 1550) die("fetch-pack: pack downloaded from %s does not match expected hash %.*s",
820a5361 1551)     uri, (int) the_hash_algo->hexsz,
820a5361 1552)     packfile_uris.items[i].string);

http-fetch.c

http.c
959b1067 2304) target ? hash_to_hex(target->hash) : base_url,

protocol.c

remote-curl.c

repo-settings.c
8e036647 47) r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_DEFAULT;
88f274c5 54) UPDATE_DEFAULT(r->settings.core_commit_graph, 1);
88f274c5 55) UPDATE_DEFAULT(r->settings.gc_write_commit_graph, 1);
8e036647 62) UPDATE_DEFAULT(r->settings.pack_use_sparse, 1);
8e036647 63) UPDATE_DEFAULT(r->settings.merge_directory_renames, MERGE_DIRECTORY_RENAMES_TRUE);
8e036647 64) UPDATE_DEFAULT(r->settings.fetch_negotiation_algorithm, FETCH_NEGOTIATION_SKIPPING);

sequencer.c
4d72c7c4 841) free(kv.items[date_i].util);
b5f2b06d 891) return NULL;
b5f2b06d 1004)     setenv_committer_date_to_author_date())
b5f2b06d 1005) return 1;
62cde645 1033) if (!author)
62cde645 1034) BUG("ignore-date can only be used with "
62cde645 1037) ignore_author_date(&author);
62cde645 1073) argv_array_pushf(&cmd.args, "--date=%ld", time(NULL));
b5f2b06d 1454) return -1;
b5f2b06d 1477) int len = strlen(author);
b5f2b06d 1478) char *idx = memchr(author, '>', len);
b5f2b06d 1480) ++idx;
b5f2b06d 1481) date = malloc(author + len - idx);
b5f2b06d 1482) memcpy(date, idx, author + len - idx);
b5f2b06d 1483) setenv("GIT_COMMITTER_DATE", date, 1);
b5f2b06d 1484) free(date);
62cde645 3644) argv_array_pushf(&cmd.args,

trace2/tr2_tgt_perf.c
371df1be 88) fl_end_col = buf->len + TR2FMT_PERF_FL_WIDTH;
371df1be 90) if (file && *file) {
371df1be 91) struct strbuf buf_fl = STRBUF_INIT;
371df1be 93) strbuf_addf(&buf_fl, "%s:%d", file, line);
371df1be 95) if (buf_fl.len <= TR2FMT_PERF_FL_WIDTH)
371df1be 96) strbuf_addbuf(buf, &buf_fl);
371df1be 98) size_t avail = TR2FMT_PERF_FL_WIDTH - 3;
371df1be 99) strbuf_addstr(buf, "...");
371df1be 100) strbuf_add(buf,
371df1be 101)    &buf_fl.buf[buf_fl.len - avail],
371df1be 105) strbuf_release(&buf_fl);
371df1be 108) while (buf->len < fl_end_col)
371df1be 111) strbuf_addstr(buf, " | ");
24dcacf7 458) strbuf_rtrim(&buf_payload);
24dcacf7 476) strbuf_rtrim(&buf_payload);

upload-pack.c
a8d662e3 130) return readsz;
820a5361 149) BUG("packfile_uris requires sideband-all");
a8d662e3 354) send_client_data(1, output_state.buffer, output_state.used);
820a5361 1387) string_list_clear(&data->uri_protocols, 0);

wrapper.c

Commits introducting uncovered code:
Denton Liu	526c03b5 rebase: refactor can_fast_forward into goto tower
Denton Liu	10572de1 rebase: fast-forward --onto in more cases
Denton Liu	f39a9c65 remote: add --save-to-push option to git remote set-url
Derrick Stolee	88f274c5 repo-settings: add feature.manyCommits setting
Derrick Stolee	8e036647 repo-settings: create feature.experimental setting
Jeff Hostetler	24dcacf7 trace2: trim whitespace in region messages in perf target format
Jeff Hostetler	371df1be trace2: cleanup column alignment in perf target format
Jonathan Tan	a8d662e3 upload-pack: refactor reading of pack-objects out
Jonathan Tan	820a5361 upload-pack: send part of packfile response as uri
Junio C Hamano	959b1067 Merge branch 'jt/fetch-cdn-offload' into pu
Rohit Ashiwal	4d72c7c4 sequencer: add NULL checks under read_author_script
Rohit Ashiwal	b5f2b06d rebase -i: support --committer-date-is-author-date
Rohit Ashiwal	657b2646 rebase -i: add --ignore-whitespace flag
Rohit Ashiwal	62cde645 rebase -i: support --ignore-date


Uncovered code in 'jch' not in 'next'
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

builtin/fetch.c
182f59da 1020) warning(_(warn_time_show_forced_updates),

builtin/rev-list.c
cf9ceb5a 476) die(

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

read-cache.c
ee70c128 1723) if (advice_unknown_index_extension) {
ee70c128 1724) warning(_("ignoring optional %.4s index extension"), ext);
ee70c128 1725) advise(_("This is likely due to the file having been written by a newer\n"

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

sequencer.c
e145d993 3368) (!opts->strategy || !strcmp(opts->strategy, "recursive")) ?

t/helper/test-prefix-map.c
1f3e3049 16) va_start(ap, fmt);
1f3e3049 17) fprintf(stderr, "%s:%d: ", file, (int)line_no);
1f3e3049 18) vfprintf(stderr, fmt, ap);
1f3e3049 19) fputc('\n', stderr);
1f3e3049 20) va_end(ap);
1f3e3049 22) failed_count++;

upload-pack.c
cf9ceb5a 148) sq_quote_buf(&buf, spec);

Commits introducting uncovered code:
Christian Couder	9e27beaa promisor-remote: implement promisor_remote_get_direct()
Christian Couder	fa3d1b63 promisor-remote: parse remote.*.partialclonefilter
Christian Couder	4ca9474e Move core_partial_clone_filter_default to promisor-remote.c
Christian Couder	faf2abf4 promisor-remote: use repository_format_partial_clone
Christian Couder	48de3158 Add initial support for many promisor remotes
Christian Couder	db27dca5 Remove fetch-object.{c,h} in favor of promisor-remote.{c,h}
Christian Couder	b14ed5ad Use promisor_remote_get_direct() and has_promisor_remote()
Daniel Ferreira	bcbdcd36 built-in add -i: implement the `status` command
Jean-Noël Avila	182f59da l10n: reformat some localized strings for v2.23.0
Johannes Schindelin	d31f31d1 built-in add -i: color the header in the `status` command
Johannes Schindelin	e145d993 rebase -r: support merge strategies other than `recursive`
Johannes Schindelin	db07a815 Start to implement a built-in version of `git add --interactive`
Johannes Schindelin	f3665cfd built-in add -i: implement the `help` command
Johannes Schindelin	81e604c5 built-in add -i: implement the main loop
Johannes Schindelin	ec4ddbf6 built-in add -i: support `?` (prompt help)
Johannes Schindelin	74265dd7 built-in add -i: refresh the index before running `status`
Jonathan Nieder	ee70c128 index: offer advice for unknown index extensions
Matthew DeVore	f56f7642 list-objects-filter-options: move error check up
Matthew DeVore	e987df5f list-objects-filter: implement composite filters
Matthew DeVore	9430147c list-objects-filter: encapsulate filter components
Matthew DeVore	cf9ceb5a list-objects-filter-options: make filter_spec a string_list
Slavica Djukic	1f3e3049 Add a function to determine unique prefixes for a list of strings
Slavica Djukic	928e9d0d built-in add -i: show unique prefixes of the commands
Slavica Djukic	253cdc20 built-in add -i: use color in the main loop


Uncovered code in 'next' not in 'master'
--------------------------------------------------------

tree-walk.c
5aa02f98 194) BUG("too small buffer passed to make_traverse_path");
5aa02f98 199) BUG("traverse_info pathlen does not match strings");
5aa02f98 208) BUG("traverse_info ran out of list items");

unpack-trees.c
90553847 1145) if (*info->prev->name)
90553847 1148) printf("%s", info->name);

Commits introducting uncovered code:
Jeff King	5aa02f98 tree-walk: harden make_traverse_path() length computations
Jeff King	90553847 tree-walk: drop oid from traverse_info


Uncovered code in 'master' not in 'master@{1}'
--------------------------------------------------------

builtin/pack-objects.c
25575015 1185) warning(_(no_closure_warning));

t/helper/test-dir-iterator.c
90421400 12) default: return "ESOMETHINGELSE";

Commits introducting uncovered code:
Jeff King	25575015 repack: silence warnings when auto-enabled bitmaps cannot be built
Junio C Hamano	90421400 test-dir-iterator: do not assume errno values



