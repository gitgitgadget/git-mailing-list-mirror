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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D2291F463
	for <e@80x24.org>; Thu, 19 Sep 2019 14:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403870AbfISOXn (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 10:23:43 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]:33255 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403857AbfISOXm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 10:23:42 -0400
Received: by mail-qk1-f181.google.com with SMTP id x134so3604216qkb.0
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 07:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=QhcBmUbmN7blQk804JxuLBCIsh3BQd8YVUugd79ozCE=;
        b=eQW1H065BpFto5HsLvFG0Acgnl3zqJViQWW9ZZAk70M42NF7kbnha1Qddpgxj9O18m
         /stgWXwMMhD/XNcCy8kFqfNn9A7KXkOnc8uL6IoROhw6nMmvReO4QAjvOvkAkOM4kt2Y
         pN4zBEwihKN3u4ezUkUQWCKcP481UPoujeVv9kL+nLQLH+TblEaMrlHnTt4KFsTKt7j9
         ZFH3J6yoRQpr9Fv1cb8zTLYXnGV6+b+A4TtBrFV1SZbP7QBQlHpGASmrcIqPXgls3noE
         wDUo2w6Qj95GBSGQ3JqPakiP3Xa7l9m3mkt0M61HjLrZWu1B7HlnH8JEtGuceo0FCBnA
         6wYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=QhcBmUbmN7blQk804JxuLBCIsh3BQd8YVUugd79ozCE=;
        b=AqjS+f/00QEuDhw6GJG09K+vJGgFPSSIEnSAib4Mz8d9RNl1T+zN0jYiT87elykBTC
         Sz2MScuEUrVewRzzbf2YZRKBimFf2ncJuMSCnerrh9LY8KlgZ1yoWge4tuRsiiK6I1Yz
         j70Bt9AfPmJ894Ouzd6kSPL2ZnUWc3+0kGQmpArI+9kM8se9y1W1zO1z9aYcNdW2Rhf4
         Tpd/PZBDkqYvWuOkdPh6CHqxtGhLbwcLXXAKyBj4lnhZel9nCLpzo0MjREZkN5q2e1w3
         GdTxJ4cgvSbyE4izfIwMz9sXhU/vSxxZZQihpP5JgV8rgnaW/zAOi/MWfF+PjOTg4wiS
         uMfQ==
X-Gm-Message-State: APjAAAV+KcGMQJPLRbgi/DXOynSDfVl/rkFG+/14j5O425I6Y1NKmNYL
        +C4sbmt9i9eaTSDGObdd3SbZ5CW7XIQ=
X-Google-Smtp-Source: APXvYqyasd0CoIUBycy7U91LGvWGPIJLqIcVhQxkY5GYn+FiUiLmVnL1/bI8f0GUkM5nrsXZL3b0Zw==
X-Received: by 2002:a37:488d:: with SMTP id v135mr2834632qka.284.1568903020395;
        Thu, 19 Sep 2019 07:23:40 -0700 (PDT)
Received: from [10.0.1.19] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id q44sm5494118qtk.16.2019.09.19.07.23.39
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2019 07:23:39 -0700 (PDT)
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (Sept 19)
Message-ID: <9fdd15ab-b2dc-f5fa-9969-90bd57014ff5@gmail.com>
Date:   Thu, 19 Sep 2019 10:23:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is today's test coverage report.

It's been a while, because I intended to modify the code to add commit-by-commit grouping of the uncovered lines. However, that is not a simple change and I haven't gotten around to it. Hopefully I can do it soon, or someone could contribute one on https://github.com/derrickstolee/git-test-coverage ;)

Thanks,
-Stolee

[1] https://derrickstolee.github.io/git-test-coverage/reports/2019-09-19.htm
[2] https://derrickstolee.github.io/git-test-coverage/reports/2019-09-19.txt

---

pu	6185f37155d4d7761f8ecee61a3e30c3f82361c1
jch	13ab3aebd5a7b54884ad3d7261ab1a1ffcd27dd8
next	18eeb5a2650ef4d662f5c9bb888cac8694753ba5
master	4c86140027f4a0d2caaa3ab4bd8bfc5ce3c11c8a
master@{1}	ff66981f4593aec0f3b3eeace0eacb7dbe44fd8c


Uncovered code in 'pu' not in 'jch'
--------------------------------------------------------

builtin/fetch-pack.c

builtin/pack-objects.c
820a5361 995) BUG("configured exclusion wasn't configured");
820a5361 2931) die(_("value of uploadpack.blobpackfileuri must be "
820a5361 2934) die(_("object already configured in another "

builtin/rebase.c
1406adc0 1897) die(_("cannot combine '--rebase-merges' with "

builtin/receive-pack.c
fabec2c5 433) the_hash_algo->init_fn(&ctx);
fabec2c5 434) the_hash_algo->update_fn(&ctx, key_in, key_len);
fabec2c5 435) the_hash_algo->final_fn(key, &ctx);

builtin/replace.c
28ba1830 275) if (strbuf_read(&result, cmd.out, the_hash_algo->hexsz + 1) < 0) {

builtin/rev-parse.c
7e0d029f 735) abbrev = hexsz;

builtin/submodule--helper.c
8d4d86b0 427) printf("%06o %s U\t", ce->ce_mode, oid_to_hex(&null_oid));

fetch-pack.c
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
390b015a 2305) target ? hash_to_hex(target->hash) : base_url,

packfile.c
d6f3fabd 1457) return;

protocol.c

read-cache.c
ee70c128 1743) if (advice_unknown_index_extension) {
ee70c128 1744) warning(_("ignoring optional %.4s index extension"), ext);
ee70c128 1745) advise(_("This is likely due to the file having been written by a newer\n"

remote-curl.c

sequencer.c
7c5b2e1d 832) free(kv.items[name_i].util);
7c5b2e1d 836) free(kv.items[email_i].util);
7c5b2e1d 840) free(kv.items[date_i].util);
ccafcb32 884) static char *read_author_date_or_null(void)
ccafcb32 888) if (read_author_script(rebase_path_author_script(),
ccafcb32 890) return NULL;
ccafcb32 891) return date;
7258d3d1 902) error(_("malformed ident line"));
7258d3d1 903) return NULL;
7258d3d1 912) static void push_dates(struct child_process *child)
7258d3d1 914) time_t now = time(NULL);
7258d3d1 915) struct strbuf date = STRBUF_INIT;
7258d3d1 917) strbuf_addf(&date, "@%"PRIuMAX, (uintmax_t)now);
7258d3d1 918) argv_array_pushf(&child->env_array, "GIT_AUTHOR_DATE=%s", date.buf);
7258d3d1 919) argv_array_pushf(&child->env_array, "GIT_COMMITTER_DATE=%s", date.buf);
7258d3d1 920) strbuf_release(&date);
7258d3d1 921) }
ccafcb32 983) int res = -1;
ccafcb32 984) struct strbuf datebuf = STRBUF_INIT;
ccafcb32 985) char *date = read_author_date_or_null();
ccafcb32 987) if (!date)
ccafcb32 988) return -1;
ccafcb32 990) strbuf_addf(&datebuf, "@%s", date);
ccafcb32 991) res = setenv("GIT_COMMITTER_DATE", datebuf.buf, 1);
ccafcb32 993) strbuf_release(&datebuf);
ccafcb32 994) free(date);
ccafcb32 996) if (res)
ccafcb32 997) return -1;
7258d3d1 1016) push_dates(&cmd);
ccafcb32 1428) return error(_("malformed ident line"));
ccafcb32 1430) return error(_("corrupted author without date information"));
7258d3d1 1488) res = -1;
7258d3d1 1489) goto out;
7258d3d1 3605) push_dates(&cmd);

sha1-file.c
d6f3fabd 1571) return;
d6f3fabd 1580) return;

upload-pack.c
a8d662e3 130) return readsz;
820a5361 149) BUG("packfile_uris requires sideband-all");
a8d662e3 354) send_client_data(1, output_state.buffer, output_state.used);
820a5361 1387) string_list_clear(&data->uri_protocols, 0);

Commits introducting uncovered code:
brian m. carlson	fabec2c5 builtin/receive-pack: switch to use the_hash_algo
brian m. carlson	28ba1830 builtin/replace: make hash size independent
brian m. carlson	7e0d029f builtin/rev-parse: switch to use the_hash_algo
brian m. carlson	8d4d86b0 cache: remove null_sha1
Jonathan Nieder	ee70c128 index: offer advice for unknown index extensions
Jonathan Tan	820a5361 upload-pack: send part of packfile response as uri
Jonathan Tan	a8d662e3 upload-pack: refactor reading of pack-objects out
Junio C Hamano	390b015a Merge branch 'jt/fetch-cdn-offload' into pu
Matheus Tavares	d6f3fabd object-store: add lock to read_object_file_extended()
Rohit Ashiwal	1406adc0 rebase -i: add --ignore-whitespace flag
Rohit Ashiwal	7c5b2e1d sequencer: allow callers of read_author_script() to ignore fields
Rohit Ashiwal	ccafcb32 rebase -i: support --committer-date-is-author-date
Rohit Ashiwal	7258d3d1 rebase -i: support --ignore-date


Uncovered code in 'jch' not in 'next'
--------------------------------------------------------

builtin/am.c
14151aad 1696) die(_("unable to write index file"));

builtin/pack-objects.c
7c59828b 1136) return 1;
7c59828b 2694) (reuse_packfile_bitmap &&
7c59828b 2695)  bitmap_walk_contains(bitmap_git, reuse_packfile_bitmap, oid));
d35b73c5 2847) allow_pack_reuse = git_config_bool(k, v);
d35b73c5 2848) return 0;

builtin/stash.c
0ac924d8 1135) ret = -1;
0ac924d8 1136) goto done;

commit-graph.c
fbab552a 483) die("dying as requested by the '%s' variable on commit-graph load!",

dir.c
89a1f4aa 374) return MATCHED_RECURSIVELY_LEADING_PATHSPEC;

name-hash.c
5a0c3ea1 98) hashmap_remove(&istate->dir_hash, &dir->ent, NULL);

pack-bitmap.c
7c59828b 791) return; /* broken packfile, punt */
7c59828b 808) return;
7c59828b 811) return;
7c59828b 823) return;
7c59828b 861) i = bitmap_git->pack->num_objects / BITS_IN_EWORD;
934b7d0a 903) return 0;

read-cache.c
14151aad 1489) return -1;

sequencer.c
a47ba3c7 3917) res = error_errno(_("could not stat '%s'"),
a47ba3c7 3923) res = -1; /* message was printed */

sha1-name.c
59fa5f5a 1172) return MISSING_OBJECT;
59fa5f5a 1178) return MISSING_OBJECT;

t/helper/test-hashmap.c
92b660d9 106) hashmap_entry_init(&entries[i]->ent, hashes[i]);
e1c7b970 107) hashmap_add(&map, &entries[i]->ent);
92b660d9 119) hashmap_entry_init(&entries[i]->ent, hashes[i]);
e1c7b970 120) hashmap_add(&map, &entries[i]->ent);

t/helper/test-lazy-init-name-hash.c
7a558228 46) printf("dir %08x %7d %s\n", dir->ent._hash, dir->nr, dir->name);
7a558228 52) printf("name %08x %s\n", ce->ent._hash, ce->name);

t/helper/test-progress.c
2bb74b53 48) die("need a title for the progress output");
2bb74b53 59) die("invalid input: '%s'\n", line.buf);
2bb74b53 67) die("invalid input: '%s'\n", line.buf);
2bb74b53 70) die("invalid input: '%s'\n", line.buf);

Commits introducting uncovered code:
Elijah Newren	89a1f4aa dir: if our pathspec might match files under a dir, recurse into it
Eric Wong	5a0c3ea1 hashmap_remove takes "const struct hashmap_entry *"
Eric Wong	92b660d9 hashmap_entry_init takes "struct hashmap_entry *"
Eric Wong	e1c7b970 hashmap_add takes "struct hashmap_entry *"
Eric Wong	7a558228 hashmap_entry: detect improper initialization
Jeff King	7c59828b pack-objects: improve partial packfile reuse
Jeff King	d35b73c5 pack-objects: introduce pack.allowPackReuse
Jeff King	fbab552a commit-graph: bump DIE_ON_LOAD check to actual load-time
Jeff King	934b7d0a pack-bitmap: introduce bitmap_walk_contains()
Phillip Wood	a47ba3c7 rebase -i: check for updated todo after squash and reword
René Scharfe	59fa5f5a sha1-name: check for overflow of N in "foo^N" and "foo~N"
SZEDER Gábor	2bb74b53 Test the progress display
Thomas Gummerer	14151aad factor out refresh_and_write_cache function
Thomas Gummerer	0ac924d8 stash: make sure to write refreshed cache


Uncovered code in 'next' not in 'master'
--------------------------------------------------------

builtin/am.c
0dfed92d 1276) die(_("missing author line in commit %s"),
0dfed92d 1277)       oid_to_hex(&commit->object.oid));

builtin/checkout.c
65c01c64 766) strbuf_add_unique_abbrev(&old_commit_shortname,
65c01c64 767)  &old_branch_info->commit->object.oid,
65c01c64 769) o.ancestor = old_commit_shortname.buf;

builtin/merge-recursive.c
9822175d 68) die_resolve_conflict("merge");

builtin/push.c
8e4c8af0 609) die(_("bad repository '%s'"), repo);
8e4c8af0 625) die(_("--all and --tags are incompatible"));
8e4c8af0 627) die(_("--all can't be combined with refspecs"));
8e4c8af0 631) die(_("--mirror and --tags are incompatible"));
8e4c8af0 636) die(_("--all and --mirror are incompatible"));

builtin/rebase.c
2b318aa6 1273) goto done;
c0efb4c1 1289) goto done;

cache-tree.c
724dd767 619) cache_tree_free(&index_state->cache_tree);
724dd767 620) cache_tree_valid = 0;
724dd767 633) return WRITE_TREE_PREFIX_ERROR;
724dd767 653) fprintf(stderr, "BUG: There are unmerged index entries:\n");
724dd767 654) for (i = 0; i < index_state->cache_nr; i++) {
724dd767 655) const struct cache_entry *ce = index_state->cache[i];
724dd767 656) if (ce_stage(ce))
724dd767 657) fprintf(stderr, "BUG: %d %.*s\n", ce_stage(ce),
724dd767 658) (int)ce_namelen(ce), ce->name);
724dd767 660) BUG("unmerged index entries when writing inmemory index");

connect.c
ebb8d2c9 921) path = host - 2; /* include the leading "//" */

merge-recursive.c
f836bf39 950) ret = err(opt, _("cannot read object %s '%s'"),
f836bf39 952) goto free_buf;
98a1d3d8 3677) return -1;
ff1bfa2c 3741)    oid_to_hex(merge_bases[i]));

pack-bitmap.c
dad3f060 712) object = parse_object_or_die(get_tagged_oid(tag), NULL);

pack-objects.c
3a37876b 185) BUG("duplicate object inserted into hash");

repo-settings.c
50f26bd0 57) UPDATE_DEFAULT_BOOL(r->settings.fetch_write_commit_graph, 1);

setup.c
e2683d51 952)     !is_dir_sep(dir->buf[min_offset - 1])) {
e2683d51 953) strbuf_addch(dir, '/');
e2683d51 954) min_offset++;

trace2/tr2_dst.c
1fd881d4 218) warning("trace2: unknown value for '%s': '%s'",

trace2/tr2_tgt_normal.c
e3443055 189) strbuf_addf(&buf_payload, "alias %s -> ", alias);
e3443055 190) sq_append_quote_argv_pretty(&buf_payload, argv);
e3443055 201) strbuf_addf(&buf_payload, "child_start[%d]", cmd->trace2_child_id);
e3443055 204) strbuf_addstr(&buf_payload, " cd ");
e3443055 206) strbuf_addstr(&buf_payload, ";");
e3443055 214) strbuf_addch(&buf_payload, ' ');
e3443055 216) strbuf_addstr(&buf_payload, "git ");
e3443055 217) sq_append_quote_argv_pretty(&buf_payload, cmd->argv);
e3443055 242) if (exe) {
e3443055 244) strbuf_addch(&buf_payload, ' ');
e3443055 246) sq_append_quote_argv_pretty(&buf_payload, argv);

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
742ed633 302) strbuf_addf(&buf_payload, "alias:%s argv:[", alias);
742ed633 303) sq_append_quote_argv_pretty(&buf_payload, argv);
742ed633 304) strbuf_addch(&buf_payload, ']');
742ed633 335) strbuf_addstr(&buf_payload, "git");
742ed633 336) if (cmd->argv[0])
742ed633 337) strbuf_addch(&buf_payload, ' ');
742ed633 391) strbuf_addstr(&buf_payload, "argv:[");
742ed633 392) if (exe) {
742ed633 393) strbuf_addstr(&buf_payload, exe);
742ed633 394) if (argv[0])
742ed633 395) strbuf_addch(&buf_payload, ' ');
742ed633 397) sq_append_quote_argv_pretty(&buf_payload, argv);
742ed633 398) strbuf_addch(&buf_payload, ']');
da4589ce 459) strbuf_addf(&buf_payload, "label:%s", label);
da4589ce 460) if (fmt && *fmt) {
da4589ce 461) strbuf_addch(&buf_payload, ' ');
da4589ce 462) maybe_append_string_va(&buf_payload, fmt, ap);
da4589ce 479) strbuf_addf(&buf_payload, "label:%s", label);
da4589ce 480) if (fmt && *fmt) {
da4589ce 481) strbuf_addch(&buf_payload, ' ' );
da4589ce 482) maybe_append_string_va(&buf_payload, fmt, ap);

Commits introducting uncovered code:
Denton Liu	2b318aa6 rebase: refactor can_fast_forward into goto tower
Denton Liu	c0efb4c1 rebase: fast-forward --onto in more cases
Derrick Stolee	50f26bd0 fetch: add fetch.writeCommitGraph config setting
Elijah Newren	98a1d3d8 merge-recursive: exit early if index != head
Elijah Newren	65c01c64 checkout: provide better conflict hunk description with detached HEAD
Elijah Newren	9822175d Ensure index matches head before invoking merge machinery, round N
Elijah Newren	724dd767 cache-tree: share code between functions writing an index as a tree
Elijah Newren	f836bf39 merge-recursive: future-proof update_file_flags() against memory leaks
Elijah Newren	ff1bfa2c merge-recursive: use common name for ancestors/common/base_list
Jeff Hostetler	371df1be trace2: cleanup column alignment in perf target format
Jeff Hostetler	e3443055 trace2: cleanup whitespace in normal format
Jeff Hostetler	da4589ce trace2: trim whitespace in region messages in perf target format
Jeff Hostetler	742ed633 trace2: cleanup whitespace in perf format
Jeff King	3a37876b pack-objects: drop packlist index_pos optimization
Jeff King	0dfed92d git-am: handle missing "author" when parsing commit
Johannes Schindelin	e2683d51 Fix .git/ discovery at the root of UNC shares
René Scharfe	1fd881d4 trace2: use warning() directly in tr2_dst_malformed_warning()
René Scharfe	dad3f060 tag: factor out get_tagged_oid()
Thomas Gummerer	8e4c8af0 push: disallow --all and refspecs when remote.<name>.mirror is set
Torsten Bögershausen	ebb8d2c9 mingw: support UNC in git clone file://server/share/repo


Uncovered code in 'master' not in 'master@{1}'
--------------------------------------------------------

archive-tar.c
71d41ff6 161) BUG("pax extended header length miscalculated as %"PRIuMAX

builtin/cat-file.c
b14ed5ad 529) warning("This repository uses promisor remotes. Some objects may not be loaded.");

builtin/fetch.c
24bc1a12 1406) warning(_("not setting upstream for a remote remote-tracking branch"));

builtin/rev-list.c
cf9ceb5a 476) die(

fetch-pack.c
aaf633c2 911) else if (args->depth > 0 || is_repository_shallow(r))

list-objects-filter-options.c
f56f7642 44) BUG("filter_options already populated");
f56f7642 236) die(_("multiple filter-specs cannot be combined"));
cf9ceb5a 286) BUG("no filter_spec available for this filter");
e987df5f 321) return;

list-objects-filter.c
e987df5f 585) BUG("expected oidset to be cleared already");

list-objects.c
9430147c 210) ctx->show_object(obj, base->buf, ctx->show_data);

path.c
ce17feb1 1234) return -1;
ce17feb1 1238) return -1;
ce17feb1 1247) return -1;

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

ref-filter.c
8b3f33ef 1042) return xstrdup("");

repo-settings.c
aaf633c2 43) r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_DEFAULT;
aaf633c2 53) UPDATE_DEFAULT_BOOL(r->settings.pack_use_sparse, 1);
aaf633c2 54) UPDATE_DEFAULT_BOOL(r->settings.fetch_negotiation_algorithm, FETCH_NEGOTIATION_SKIPPING);

sequencer.c
e145d993 3368) (!opts->strategy || !strcmp(opts->strategy, "recursive")) ?

tree-walk.c
5aa02f98 194) BUG("too small buffer passed to make_traverse_path");
5aa02f98 199) BUG("traverse_info pathlen does not match strings");
5aa02f98 208) BUG("traverse_info ran out of list items");

unpack-trees.c
90553847 1145) if (*info->prev->name)
90553847 1148) printf("%s", info->name);

upload-pack.c
cf9ceb5a 148) sq_quote_buf(&buf, spec);

wrapper.c
9827d4c1 31) die("Out of memory, strdup failed");
9827d4c1 45) if (!gentle)
9827d4c1 46) die("Out of memory, malloc failed (tried to allocate %lu bytes)",
9827d4c1 49) error("Out of memory, malloc failed (tried to allocate %lu bytes)",
9827d4c1 51) return NULL;
9827d4c1 117) die("Out of memory, realloc failed");
9827d4c1 133) die("Out of memory, calloc failed");

Commits introducting uncovered code:
brian m. carlson	ce17feb1 path: add a function to check for path suffix
Christian Couder	db27dca5 Remove fetch-object.{c,h} in favor of promisor-remote.{c,h}
Christian Couder	b14ed5ad Use promisor_remote_get_direct() and has_promisor_remote()
Christian Couder	9e27beaa promisor-remote: implement promisor_remote_get_direct()
Christian Couder	fa3d1b63 promisor-remote: parse remote.*.partialclonefilter
Christian Couder	4ca9474e Move core_partial_clone_filter_default to promisor-remote.c
Christian Couder	faf2abf4 promisor-remote: use repository_format_partial_clone
Christian Couder	48de3158 Add initial support for many promisor remotes
Corentin BOMPARD	24bc1a12 pull, fetch: add --set-upstream option
Derrick Stolee	aaf633c2 repo-settings: create feature.experimental setting
Jeff King	5aa02f98 tree-walk: harden make_traverse_path() length computations
Jeff King	9827d4c1 packfile: drop release_pack_memory()
Jeff King	90553847 tree-walk: drop oid from traverse_info
Johannes Schindelin	e145d993 rebase -r: support merge strategies other than `recursive`
Matthew DeVore	9430147c list-objects-filter: encapsulate filter components
Matthew DeVore	e987df5f list-objects-filter: implement composite filters
Matthew DeVore	f56f7642 list-objects-filter-options: move error check up
Matthew DeVore	cf9ceb5a list-objects-filter-options: make filter_spec a string_list
Mischa POSLAWSKY	8b3f33ef ref-filter: initialize empty name or email fields
René Scharfe	71d41ff6 archive-tar: turn length miscalculation warning into BUG

