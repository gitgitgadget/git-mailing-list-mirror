Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A6FB1F461
	for <e@80x24.org>; Tue, 14 May 2019 01:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfENBKQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 21:10:16 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44458 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfENBKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 21:10:16 -0400
Received: by mail-qt1-f196.google.com with SMTP id f24so12695586qtk.11
        for <git@vger.kernel.org>; Mon, 13 May 2019 18:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=rFLRCTZ+d8hf7UVoR2Dvl1qaVQ09MwHnxJ0roT1aHnQ=;
        b=OB0UZBDjMmZzynCV3L50ZOJ5Du/LyLd78WpXPxWS3HfBnLifs4qU6hdm34IPMzX+eD
         Dcidg5qOycW74oIeq8aLVIZXMIHf9M5aKW536Ib9N2AaeX99TiBb+5N81AdwotS18pIc
         t+E6mgjar6TWyDgrpfjAz9jT+Qrh6p/y6KXf+sF8i11wHvAkoTxV952rOzop5o+rhHZL
         qBI5N+iPcUDt3kLXnMES8MGn4bsknyYFtlhCnxCQ4alSYJCWnyjAnmB+3AoeW2JkjVfE
         OBf+6IZXwSjDIIYkTCDABBsfm6cjIC9iiayVYCtf+1Mr76qSNS1qpZDOcPXHg9b7GLMf
         U4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=rFLRCTZ+d8hf7UVoR2Dvl1qaVQ09MwHnxJ0roT1aHnQ=;
        b=qyeyzOn1+A4i3m5/zhkneRyJgSJwEZS8MBWPd2uqDB2x3yi9+MaCxaostMUBC7I1YW
         /y/RZpM346sEIGUA5HBHyRnW7LTd1o+HAeNExSX7JhuOGg81IJsHaZSSxwgHjZoDPfZ/
         DDy4fsBbb+wNRLKSXtTVXW0kzs5Bk9lOTQI38vJWpGMCeUNGdWnq+oRf+VYpbPWlvDNZ
         12oxUaGZjW5rHeIk9pBNoISgWWpfwTNwxanMZsk7HunLRhLgiNugRSKQbqkzMMBgH9ef
         B+atJfuynd1sfBAX0iPqFgpw3vvd3BASwUGQ9U7Hc/H8+bJg5FMH7J1XEEcHbhZZEtc9
         4UNw==
X-Gm-Message-State: APjAAAWwwvyRrsQ22d3Pax6F8lHnGVUe8NpXzNc736Oov2nnhbeYfx4Q
        DluhC7Hcmi0AGsQdgmyGDlS7g4/44Ls=
X-Google-Smtp-Source: APXvYqzjSdYplz4JhDO3HRVl8gn9VY9EwVZoSfUuXPB9p8ypAIQBho5lWeiDFQJzp01kMdWuDa45sQ==
X-Received: by 2002:ac8:16b4:: with SMTP id r49mr19146713qtj.157.1557796214116;
        Mon, 13 May 2019 18:10:14 -0700 (PDT)
Received: from [10.0.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id k54sm5563053qtk.54.2019.05.13.18.10.13
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 18:10:13 -0700 (PDT)
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (May 13, 2019)
Message-ID: <35cf6040-3f6a-14d3-a387-a6914a028aea@gmail.com>
Date:   Mon, 13 May 2019 21:10:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is today's test coverage report. You can view it in HTML [1] or text [2]
form, and below.

Thanks,
-Stolee

[1] https://derrickstolee.github.io/git-test-coverage/reports/2019-05-13.htm
[2] https://derrickstolee.github.io/git-test-coverage/reports/2019-05-13.txt

---

pu	7965c284718b7b0dfb5ed346e2adfdf5da23ee10
jch	70abaa9ec89a67d1a7e826673a32fadc7e931d88
next	e745c3d227fefd28dbcf0011398e178098d621e4
master	ab15ad1a3b4b04a29415aef8c9afa2f64fc194a2
master@{1}	6a6c0f10a70a6eb101c213b09ae82a9cad252743


Uncovered code in 'pu' not in 'jch'
--------------------------------------------------------

blame.c
d0738d94 618)     ent->ignored == next->ignored &&
a5c91678 619)     ent->unblamable == next->unblamable) {

builtin/blame.c
a5c91678 493) memset(hex, '0', length);

http.c
65de540e 2302) target ? hash_to_hex(target->hash) : base_url,

promisor-remote.c
0ba08c05 25) die(_("Remote with no URL"));
54248706 61) warning(_("promisor remote name cannot begin with '/': %s"),
54248706 63) return NULL;
7bdf0926 93) previous->next = r->next;
7b6e1b04 108) return git_config_string(&core_partial_clone_filter_default,
b21a55f3 139) return 0;
dcc8b4e9 202) static int remove_fetched_oids(struct object_id **oids, int oid_nr, int to_free)
dcc8b4e9 204) int i, missing_nr = 0;
dcc8b4e9 205) int *missing = xcalloc(oid_nr, sizeof(*missing));
dcc8b4e9 206) struct object_id *old_oids = *oids;
dcc8b4e9 208) int old_fetch_if_missing = fetch_if_missing;
dcc8b4e9 210) fetch_if_missing = 0;
dcc8b4e9 212) for (i = 0; i < oid_nr; i++)
dcc8b4e9 213) if (oid_object_info_extended(the_repository, &old_oids[i], NULL, 0)) {
dcc8b4e9 214) missing[i] = 1;
dcc8b4e9 215) missing_nr++;
dcc8b4e9 218) fetch_if_missing = old_fetch_if_missing;
dcc8b4e9 220) if (missing_nr) {
dcc8b4e9 221) int j = 0;
dcc8b4e9 222) new_oids = xcalloc(missing_nr, sizeof(*new_oids));
dcc8b4e9 223) for (i = 0; i < oid_nr; i++)
dcc8b4e9 224) if (missing[i])
dcc8b4e9 225) oidcpy(&new_oids[j++], &old_oids[i]);
dcc8b4e9 226) *oids = new_oids;
dcc8b4e9 227) if (to_free)
dcc8b4e9 228) free(old_oids);
dcc8b4e9 231) free(missing);
dcc8b4e9 233) return missing_nr;
dcc8b4e9 248) if (missing_nr == 1)
dcc8b4e9 249) continue;
dcc8b4e9 250) missing_nr = remove_fetched_oids(&missing_oids, missing_nr, to_free);
dcc8b4e9 251) if (missing_nr) {
dcc8b4e9 252) to_free = 1;
dcc8b4e9 253) continue;
dcc8b4e9 261) free(missing_oids);

ref-filter.c
2582083f 93) keydata_aka_refname ? keydata_aka_refname : k->wt->head_ref);

upload-pack.c
a8d662e3 130) return readsz;
820a5361 149) BUG("packfile_uris requires sideband-all");
a8d662e3 355) send_client_data(1, output_state.buffer, output_state.used);
820a5361 1386) string_list_clear(&data->uri_protocols, 0);

Commits introducting uncovered code:
Barret Rhoden	d0738d94 blame: add config options to handle output for ignored lines
Barret Rhoden	a5c91678 blame: add the ability to ignore commits and their changes
Christian Couder	0ba08c05 Remove fetch-object.{c,h} in favor of promisor-remote.{c,h}
Christian Couder	54248706 Add initial support for many promisor remotes
Christian Couder	7bdf0926 promisor-remote: use repository_format_partial_clone
Christian Couder	7b6e1b04 Move core_partial_clone_filter_default to promisor-remote.c
Christian Couder	b21a55f3 promisor-remote: parse remote.*.partialclonefilter
Christian Couder	dcc8b4e9 promisor-remote: implement promisor_remote_get_direct()
Jonathan Tan	a8d662e3 upload-pack: refactor reading of pack-objects out
Jonathan Tan	820a5361 upload-pack: send part of packfile response as uri
Junio C Hamano	65de540e Merge branch 'jt/fetch-cdn-offload' into pu
Nickolai Belakovski	2582083f ref-filter: add worktreepath atom


Uncovered code in 'jch' not in 'next'
--------------------------------------------------------

builtin/difftool.c
f3a3a021 731) die(_("--dir-diff is incompatible with --no-index"));

builtin/fast-export.c
6a362638 81) static int parse_opt_reencode_mode(const struct option *opt,
6a362638 84) if (unset || !strcmp(arg, "abort"))
6a362638 85) reencode_mode = REENCODE_ABORT;
6a362638 86) else if (!strcmp(arg, "yes"))
6a362638 87) reencode_mode = REENCODE_PLEASE;
6a362638 88) else if (!strcmp(arg, "no"))
6a362638 89) reencode_mode = REENCODE_NEVER;
6a362638 91) return error("Unknown reencoding mode: %s", arg);
6a362638 92) return 0;
6a362638 654) switch(reencode_mode) {
6a362638 656) reencoded = reencode_string(message, "UTF-8", encoding);
6a362638 657) break;
6a362638 659) break;
6a362638 661) die("Encountered commit-specific encoding %s in commit "
6a362638 663)     encoding, oid_to_hex(&commit->object.oid));
17683839 675) printf("encoding %s\n", encoding);

builtin/gc.c
efeb229e 691) return 1;

builtin/merge.c
324d237f 1290) usage_msg_opt(_("--quit expects no arguments"),

builtin/rebase.c
526c03b5 1274) goto done;
10572de1 1290) goto done;

builtin/remote.c
f39a9c65 1551) die(_("--save-to-push cannot be used with other options"));
f39a9c65 1575) die(_("--save-to-push can only be used when only one url is defined"));

builtin/worktree.c
722abec7 297) BUG("How come '%s' becomes empty after sanitization?", sb.buf);

builtin/write-tree.c
76a7bc09 53) die("%s: prefix %s not found", me, tree_prefix);

commit-graph.c
d83160e8 906) error(_("error opening index for %s"), packname.buf);
d83160e8 907) return 1;
63a8be62 946) continue;
93ba1867 969) display_progress(ctx->progress, ctx->approx_nr_objects);
8520d7fc 1039) error(_("unable to create leading directories of %s"),
8520d7fc 1041) return errno;
efeb229e 1158) error(_("the commit graph format cannot write %d commits"), count_distinct);
efeb229e 1159) res = 1;
efeb229e 1160) goto cleanup;
efeb229e 1169) error(_("too many commits to write graph"));
efeb229e 1170) res = 1;
efeb229e 1171) goto cleanup;

fast-import.c
328bd099 2612) read_next_command();
328bd099 2679) strbuf_addf(&new_data,

read-cache.c
ee70c128 1723) if (advice_unknown_index_extension) {
ee70c128 1724) warning(_("ignoring optional %.4s index extension"), ext);
ee70c128 1725) advise(_("This is likely due to the file having been written by a newer\n"
7bd9631b 2211) src_offset += load_cache_entries_threaded(istate, mmap, mmap_size, nr_threads, ieot);

refs.c
722abec7 111) sanitized->buf[sanitized->len-1] = '-';
722abec7 170) if (sanitized)
722abec7 171) strbuf_addch(sanitized, '-');
722abec7 173) return -1;
722abec7 178) strbuf_complete(sanitized, '/');
722abec7 215) BUG("sanitizing refname '%s' check returned error", refname);

sha1-name.c
af96fe33 161) return;

t/helper/test-read-cache.c
dc76852d 29) die("%s not in index", name);

upload-pack.c
8e712ef6 1073) precomposed_unicode = git_config_bool(var, value);

Commits introducting uncovered code:
Denton Liu	526c03b5 rebase: refactor can_fast_forward into goto tower
Denton Liu	10572de1 rebase: fast-forward --onto in more cases
Denton Liu	f39a9c65 remote: add --save-to-push option to git remote set-url
Derrick Stolee	efeb229e commit-graph: return with errors during write
Derrick Stolee	d83160e8 commit-graph: extract fill_oids_from_packs()
Derrick Stolee	63a8be62 commit-graph: extract fill_oids_from_commit_hex()
Derrick Stolee	93ba1867 commit-graph: extract fill_oids_from_all_packs()
Derrick Stolee	8520d7fc commit-graph: extract write_commit_graph_file()
Derrick Stolee	af96fe33 midx: add packs to packed_git linked list
Elijah Newren	328bd099 fast-import: support 'encoding' commit header
Elijah Newren	6a362638 fast-export: do automatic reencoding of commit messages only if requested
Elijah Newren	17683839 fast-export: avoid stripping encoding header if we cannot reencode
Elijah Newren	8e712ef6 Honor core.precomposeUnicode in more places
Jeff King	76a7bc09 cmd_{read,write}_tree: rename "unused" variable that is used
Jeff King	7bd9631b read-cache: drop unused parameter from threaded load
Johannes Schindelin	dc76852d fsmonitor: demonstrate that it is not refreshed after discard_index()
Johannes Schindelin	f3a3a021 difftool --no-index: error out on --dir-diff (and don't crash)
Jonathan Nieder	ee70c128 index: offer advice for unknown index extensions
Nguyễn Thái Ngọc Duy	722abec7 worktree add: sanitize worktree names
Nguyễn Thái Ngọc Duy	324d237f merge: add --quit


Uncovered code in 'next' not in 'master'
--------------------------------------------------------

http.c
5c3d5a38 2329) return posn / eltsize;

parse-options.c
5c387428 282) return 0;
5c387428 481) BUG("OPT_ALIAS() should not remain at this point. "
5c387428 661) BUG("An alias must have long option name");
5c387428 670) BUG("No please. Nested aliases are not supported.");
5c387428 685) BUG("could not find source option '%s' of alias '%s'",

Commits introducting uncovered code:
Mike Hommey	5c3d5a38 Make fread/fwrite-like functions in http.c more like fread/fwrite.
Nguyễn Thái Ngọc Duy	5c387428 parse-options: don't emit "ambiguous option" for aliases


Uncovered code in 'master' not in 'master@{1}'
--------------------------------------------------------

builtin/rebase.c
0609b741 146) static int add_exec_commands(struct string_list *commands)
0609b741 148) const char *todo_file = rebase_path_todo();
0609b741 149) struct todo_list todo_list = TODO_LIST_INIT;
0609b741 152) if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
0609b741 153) return error_errno(_("could not read '%s'."), todo_file);
0609b741 155) if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
0609b741 157) todo_list_release(&todo_list);
0609b741 158) return error(_("unusable todo list: '%s'"), todo_file);
0609b741 161) todo_list_add_exec_commands(&todo_list, commands);
0609b741 162) res = todo_list_write_to_file(the_repository, &todo_list,
0609b741 164) todo_list_release(&todo_list);
0609b741 166) if (res)
0609b741 167) return error_errno(_("could not write '%s'."), todo_file);
0609b741 168) return 0;
0609b741 171) static int rearrange_squash_in_todo_file(void)
0609b741 173) const char *todo_file = rebase_path_todo();
0609b741 174) struct todo_list todo_list = TODO_LIST_INIT;
0609b741 175) int res = 0;
0609b741 177) if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
0609b741 178) return error_errno(_("could not read '%s'."), todo_file);
0609b741 179) if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
0609b741 181) todo_list_release(&todo_list);
0609b741 182) return error(_("unusable todo list: '%s'"), todo_file);
0609b741 185) res = todo_list_rearrange_squash(&todo_list);
0609b741 186) if (!res)
0609b741 187) res = todo_list_write_to_file(the_repository, &todo_list,
0609b741 190) todo_list_release(&todo_list);
0609b741 192) if (res)
0609b741 193) return error_errno(_("could not write '%s'."), todo_file);
0609b741 194) return 0;
0609b741 204) return error_errno(_("could not read '%s'."), todo_file);
0609b741 208) todo_list_release(&todo_list);
0609b741 209) return error(_("unusable todo list: '%s'"), todo_file);
0609b741 217) return error_errno(_("could not write '%s'."), todo_file);
0609b741 229) return error_errno(_("could not read '%s'."), todo_file);
0609b741 235) res = error_errno(_("could not write '%s'"), todo_file);
0609b741 252) return error(_("no HEAD?"));
c44c2462 279) return error_errno(_("could not create temporary %s"), merge_dir());
0609b741 285) return error_errno(_("could not mark as interactive"));
0609b741 314) return -1;
0609b741 318) return -1;
0609b741 323) free(revisions);
0609b741 324) free(shortrevisions);
0609b741 326) return -1;
7d3488eb 335) argv_array_push(&make_script_args,
0ea0847e 336) oid_to_hex(&opts->restrict_revision->object.oid));
0609b741 343) error(_("could not generate todo list"));
0609b741 348) BUG("unusable todo list");
460bc3ce 382) die(_("a base commit must be provided with --upstream or --onto"));
460bc3ce 419) ret = rearrange_squash_in_todo_file();
460bc3ce 420) break;
460bc3ce 422) struct string_list commands = STRING_LIST_INIT_DUP;
460bc3ce 424) split_exec_commands(opts->cmd, &commands);
460bc3ce 425) ret = add_exec_commands(&commands);
460bc3ce 426) string_list_clear(&commands, 0);
460bc3ce 427) break;
460bc3ce 430) BUG("invalid command '%d'", command);
0609b741 509) usage_with_options(builtin_rebase_interactive_usage, options);
73fdc535 515) opts.squash_onto = &squash_onto;
0609b741 518) warning(_("--[no-]rebase-cousins has no effect without "

parse-options-cb.c
7d3488eb 99) int parse_opt_commit(const struct option *opt, const char *arg, int unset)
7d3488eb 103) struct commit **target = opt->value;
7d3488eb 105) if (!arg)
7d3488eb 106) return -1;
7d3488eb 107) if (get_oid(arg, &oid))
7d3488eb 108) return error("malformed object name %s", arg);
7d3488eb 109) commit = lookup_commit_reference(the_repository, &oid);
7d3488eb 110) if (!commit)
7d3488eb 111) return error("no such commit %s", arg);
7d3488eb 112) *target = commit;
7d3488eb 113) return 0;
33898531 132) int parse_opt_object_id(const struct option *opt, const char *arg, int unset)
33898531 135) struct object_id *target = opt->value;
33898531 137) if (unset) {
33898531 138) *target = null_oid;
33898531 139) return 0;
33898531 141) if (!arg)
33898531 142) return -1;
33898531 143) if (get_oid(arg, &oid))
33898531 144) return error(_("malformed object name '%s'"), arg);
33898531 145) *target = oid;
33898531 146) return 0;

sequencer.c
4a72486d 2184) return error_errno("unable to open '%s'", todo_file);
4a72486d 2188) eol--; /* strip Carriage Return */
4a72486d 2190) goto fail;
4a72486d 2196) goto fail;
b07d9bfd 2300) error_errno("unable to open '%s'", todo_path);
b07d9bfd 2301) return 0;

trace2.c
a0897249 448) tr2tls_create_self(thread_name, us_now);
22a73383 737) if (tgt_j->pfn_data_json_fl)

trace2/tr2_dst.c
bce9db6d 16) const char *env_value = tr2_sysenv_get(TR2_SYSENV_DST_DEBUG);
5b2d1c0c 69) strerror(errno));
bce9db6d 93) strerror(errno));
bce9db6d 303) warning("unable to write trace to '%s': %s",

trace2/tr2_sid.c
08881b9a 44) strbuf_add(&tr2sid_buf, "Localhost", 9);

trace2/tr2_sysenv.c
bce9db6d 70) return 0;
bce9db6d 95) BUG("tr2_sysenv_get invalid var '%d'", var);
bce9db6d 113) const char *tr2_sysenv_display_name(enum tr2_sysenv_variable var)
bce9db6d 115) if (var >= TR2_SYSENV_MUST_BE_LAST)
bce9db6d 116) BUG("tr2_sysenv_get invalid var '%d'", var);
bce9db6d 118) return tr2_sysenv_settings[var].env_var_name;

trace2/tr2_tgt_event.c
bce9db6d 56) tr2env_event_max_nesting_levels = max_nesting;
bce9db6d 61) tr2env_event_be_brief = want_brief;
bce9db6d 542) if (ctx->nr_open_regions <= tr2env_event_max_nesting_levels) {

Commits introducting uncovered code:
Jeff Hostetler	a0897249 trace2: refactor setting process starting time
Jeff Hostetler	bce9db6d trace2: use system/global config for default trace2 settings
Jeff Hostetler	08881b9a trace2: make SIDs more unique
Josh Steadmon	22a73383 trace2: fix incorrect function pointer check
Junio C Hamano	5b2d1c0c Merge branch 'jh/trace2-sid-fix'
Phillip Wood	0609b741 rebase -i: combine rebase--interactive.c with rebase.c
Phillip Wood	c44c2462 rebase -i: remove duplication
Phillip Wood	7d3488eb rebase -i: use struct commit when parsing options
Phillip Wood	0ea0847e rebase -i: use struct rebase_options in do_interactive_rebase()
Phillip Wood	460bc3ce rebase -i: run without forking rebase--interactive
Phillip Wood	73fdc535 rebase -i: use struct rebase_options to parse args
Phillip Wood	33898531 rebase -i: use struct object_id for squash_onto
Phillip Wood	4a72486d fix cherry-pick/revert status after commit
Phillip Wood	b07d9bfd commit/reset: try to clean up sequencer state

