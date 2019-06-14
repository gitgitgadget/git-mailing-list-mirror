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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FFE61F462
	for <e@80x24.org>; Fri, 14 Jun 2019 10:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfFNKXy (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 06:23:54 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]:33275 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfFNKXx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 06:23:53 -0400
Received: by mail-qk1-f172.google.com with SMTP id r6so1331035qkc.0
        for <git@vger.kernel.org>; Fri, 14 Jun 2019 03:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=os5mqyQCIuD78nTBF7Q4IGCwxbdzNjSr15r/wE0rc0Q=;
        b=jkvRv1/AgTsR7UBFybwo58yLzQqVNzgdvBaoOr45qyWKNyEDodS2FQ1Ozy2YB60uN0
         rsQoRzfvSFA4+cWkOdAlJ68Z8YU0gw1glq67AMuzBWPK8J5uM788ADivckL0tdmeAJ88
         y9qjka4nvJvTzlOG7gn1+wREBGXniWc5aNsizkpzkSYvaVbYp/awr8bu6+vQD22VMmd9
         ZC4t8shvPZwcLQjNJm8Pn6BFyyoTmdcBFu5ASIdFFtu2dmEtOcm1nFTlBUZ9r/Wk8zkX
         4przXdSkzFuUNkpsp1EhWtxUY0meux7zf3IWvajt1nvtstjGTfVBSZ+B2kYsXtiV598s
         VbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=os5mqyQCIuD78nTBF7Q4IGCwxbdzNjSr15r/wE0rc0Q=;
        b=LZL5K6PUTz7hUjNg+BG+FHqeJhw+Nosu7AnsMiEiGQY/2Ky8p5NQ+eNy2v4lBsMYPH
         YLlC9IjPfk54f8BhNAB5jjA3KEjqzxROdtLDi+OVOt5uC6p7J8P9lM6O8/4djkbxa7za
         GI9ZjygU5ryXd20XbToIJGDzot9hPw/1ihXn2jFYzKVlj9+h/tp4ft2On/Kjww+BGmOj
         V4SUKBucH83T8M8RCm/TLgX0hwt3ppWGc4peUYE1sievFeh7aYm4/2ZyIE46x1B0hp8x
         6UrV8i+U8O+r7YU2GoUq9a0v1P1yVsRsBsKew9KObyWZkivQPPlSshhAb8lFAcHPM247
         cC6g==
X-Gm-Message-State: APjAAAU52yw96wX9uXgDAKMK5Hm12jK8PXSechPlpk2O072Vi/wx+Rl+
        /yd7Kdjm55N5+PM5op0V4LiNzBrW
X-Google-Smtp-Source: APXvYqxx2y1loaQoyBvO0Eig6bkLxj3JXaDRoNdO2gEtEUcnZ4R3flVyAt7vumA6t8+O74BD4fpGFw==
X-Received: by 2002:a37:6587:: with SMTP id z129mr42656780qkb.295.1560507832145;
        Fri, 14 Jun 2019 03:23:52 -0700 (PDT)
Received: from [10.0.1.15] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id w30sm1429841qtb.28.2019.06.14.03.23.48
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 03:23:51 -0700 (PDT)
To:     GIT Mailing-list <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (Friday, June 14)
Message-ID: <121d899d-3ead-e90f-b62a-a6414b70508d@gmail.com>
Date:   Fri, 14 Jun 2019 06:23:42 -0400
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

Here is today's test coverage report.

-Stolee

[1] https://derrickstolee.github.io/git-test-coverage/reports/2019-06-14.htm
[2] https://derrickstolee.github.io/git-test-coverage/reports/2019-06-14.txt

---

pu	d3545145f9e3f092c0031535c51c6c88e4646c44
jch	c7b1a102ca91f3fc04951c551da7a92f9113b6c4
next	d03e0c960ffbffc6714d0e076319c44163f03ac5
master	0aae918dd929862d3ce0ea2960897787bb269a3b
master@{1}	v2.22.0


Uncovered code in 'pu' not in 'jch'
--------------------------------------------------------

blame.c
1fc73384 990) return;
4c2c1b89 1599) continue;
ae3f36de 2417) continue;

builtin/blame.c

builtin/cat-file.c

builtin/fetch-pack.c

builtin/pack-objects.c

builtin/remote.c
f39a9c65 1551) die(_("--save-to-push cannot be used with other options"));
f39a9c65 1575) die(_("--save-to-push can only be used when only one url is defined"));

fetch-pack.c

http-fetch.c

http.c
39aed48e 2302) target ? hash_to_hex(target->hash) : base_url,

oidset.c

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

protocol.c

remote-curl.c

upload-pack.c
a8d662e3 130) return readsz;
820a5361 149) BUG("packfile_uris requires sideband-all");
a8d662e3 355) send_client_data(1, output_state.buffer, output_state.used);
820a5361 1386) string_list_clear(&data->uri_protocols, 0);

wrapper.c

Commits introducting uncovered code:
Barret Rhoden	1fc73384 blame: optionally track line fingerprints during fill_blame_origin()
Barret Rhoden	4c2c1b89 blame: use the fingerprint heuristic to match ignored lines
Barret Rhoden	ae3f36de blame: add the ability to ignore commits and their changes
Christian Couder	dcc8b4e9 promisor-remote: implement promisor_remote_get_direct()
Christian Couder	7b6e1b04 Move core_partial_clone_filter_default to promisor-remote.c
Christian Couder	b21a55f3 promisor-remote: parse remote.*.partialclonefilter
Christian Couder	54248706 Add initial support for many promisor remotes
Christian Couder	0ba08c05 Remove fetch-object.{c,h} in favor of promisor-remote.{c,h}
Christian Couder	7bdf0926 promisor-remote: use repository_format_partial_clone
Denton Liu	f39a9c65 remote: add --save-to-push option to git remote set-url
Jonathan Tan	a8d662e3 upload-pack: refactor reading of pack-objects out
Jonathan Tan	820a5361 upload-pack: send part of packfile response as uri
Junio C Hamano	39aed48e Merge branch 'jt/fetch-cdn-offload' into pu


Uncovered code in 'jch' not in 'next'
--------------------------------------------------------

builtin/branch.c
1fde99cf 841) die(_("The -a, and -r, options to 'git branch' do not take a branch name.\n"

builtin/checkout.c

builtin/commit.c

builtin/gc.c

builtin/multi-pack-index.c

builtin/rebase.c
d559f502 759) ret = error(_("could not remove '%s'"),
526c03b5 1272) goto done;
10572de1 1288) goto done;
d559f502 1675) error(_("could not remove '%s'"),

commit-graph.c
70621068 269) chunk_repeated = 1;
70621068 339) warning(_("commit-graph has no base graphs chunk"));
70621068 340) return 0;
3ff26fe3 391) break;
f0159bf5 540) BUG("NULL commit-graph");
f0159bf5 543) die(_("invalid commit position. commit-graph is likely corrupt"));
f0159bf5 603) die(_("invalid commit position. commit-graph is likely corrupt"));
5e5c46e6 1047) continue;
ef5b83f2 1169) error(_("error opening index for %s"), packname.buf);
ef5b83f2 1170) return -1;
4c9efe85 1209) continue;
b2c83060 1232) display_progress(ctx->progress, ctx->approx_nr_objects);
5e5c46e6 1321) error(_("failed to write correct number of base graph ids"));
5e5c46e6 1322) return -1;
238def57 1354) error(_("unable to create leading directories of %s"),
238def57 1356) return -1;
5e5c46e6 1366) error(_("unable to create '%s'"), ctx->graph_name);
5e5c46e6 1367) return -1;
5e5c46e6 1441) return -1;
5e5c46e6 1467) error(_("unable to open commit-graph chain file"));
5e5c46e6 1468) return -1;
efb38519 1479) error(_("failed to rename base commit-graph file"));
5e5c46e6 1499) error(_("failed to rename temporary commit-graph file"));
5e5c46e6 1500) return -1;
97e2eb8d 1529) break;
97e2eb8d 1544) ctx->num_commit_graphs_after = 1;
97e2eb8d 1545) ctx->new_base_graph = NULL;
857973d4 1621) die(_("unexpected duplicate commit id %s"),
857973d4 1622)     oid_to_hex(&ctx->commits.list[i]->object.oid));
e2cd6bfb 1789) ctx->oids.alloc = split_opts->max_commits;
e103f727 1825) error(_("the commit graph format cannot write %d commits"), count_distinct);
e103f727 1826) res = -1;
e103f727 1827) goto cleanup;
e103f727 1836) error(_("too many commits to write graph"));
e103f727 1837) res = -1;
e103f727 1838) goto cleanup;

config.c
07b2c0ea 283) return 0;

kwset.c
08e04506 45) BUG("Cannot allocate a negative amount: %ld", size);

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

name-hash.c
568a05c5 348) assert(begin >= 0);
568a05c5 350) int mid = begin + ((end - begin) >> 1);

oidmap.c
3ff9c400 42) hashmap_entry_init(&entry, sha1hash(key->hash));

packfile.c
8434e85d 372) strbuf_release(&buf);
8434e85d 373) return;

pager.c
0ec9e491 197) fputs("\r\033[K", stderr);

progress.c
70d07115 121) fprintf(stderr, "  %s%s", counters_sb->buf,
70d07115 127) fprintf(stderr, "%s:\n  %s%s",

read-cache.c
ee70c128 1723) if (advice_unknown_index_extension) {
ee70c128 1724) warning(_("ignoring optional %.4s index extension"), ext);
ee70c128 1725) advise(_("This is likely due to the file having been written by a newer\n"

ref-filter.c
2582083f 93) keydata_aka_refname ? keydata_aka_refname : k->wt->head_ref);

sequencer.c
37e9ee5c 293) ret = -1;
37e9ee5c 311) ret = error(_("could not remove '%s'"), buf.buf);

sh-i18n--envsubst.c
568a05c5 252)   size_t j = j1 + ((j2 - j1) >> 1);

t/helper/test-oidmap.c
8b7e641f 60) if (get_oid(p1, &oid)) {
8b7e641f 61) printf("Unknown oid: %s\n", p1);
8b7e641f 62) continue;
8b7e641f 66) FLEX_ALLOC_STR(entry, name, p2);
8b7e641f 67) oidcpy(&entry->entry.oid, &oid);
8b7e641f 70) oidmap_put(&map, entry);
8b7e641f 105) if (get_oid(p1, &oid)) {
8b7e641f 106) printf("Unknown oid: %s\n", p1);
8b7e641f 107) continue;
8b7e641f 111) entry = oidmap_remove(&map, &oid);
8b7e641f 114) puts(entry ? entry->name : "NULL");
8b7e641f 115) free(entry);

Commits introducting uncovered code:
Christian Couder	8b7e641f t/helper: add test-oidmap.c
Christian Couder	3ff9c400 oidmap: use sha1hash() instead of static hash() function
Denton Liu	526c03b5 rebase: refactor can_fast_forward into goto tower
Denton Liu	10572de1 rebase: fast-forward --onto in more cases
Denton Liu	07b2c0ea config: learn the "onbranch:" includeIf condition
Derrick Stolee	19575c7c multi-pack-index: implement 'expire' subcommand
Derrick Stolee	8434e85d repack: refactor pack deletion for future use
Derrick Stolee	ce1e4a10 midx: implement midx_repack()
Derrick Stolee	d01bf2e6 midx: refactor permutation logic and pack sorting
Derrick Stolee	e103f727 commit-graph: return with errors during write
Derrick Stolee	e2cd6bfb commit-graph: create options for split files
Derrick Stolee	857973d4 commit-graph: merge commit-graph chains
Derrick Stolee	97e2eb8d commit-graph: allow cross-alternate chains
Derrick Stolee	238def57 commit-graph: extract write_commit_graph_file()
Derrick Stolee	b2c83060 commit-graph: extract fill_oids_from_all_packs()
Derrick Stolee	4c9efe85 commit-graph: extract fill_oids_from_commit_hex()
Derrick Stolee	ef5b83f2 commit-graph: extract fill_oids_from_packs()
Derrick Stolee	5e5c46e6 commit-graph: write commit-graph chains
Derrick Stolee	efb38519 commit-graph: add --split option to builtin
Derrick Stolee	f0159bf5 commit-graph: prepare for commit-graph chains
Derrick Stolee	70621068 commit-graph: add base graphs chunk
Derrick Stolee	3ff26fe3 commit-graph: load commit-graph chains
Johannes Schindelin	08e04506 kwset: allow building with GCC 8
Jonathan Nieder	ee70c128 index: offer advice for unknown index extensions
Nickolai Belakovski	2582083f ref-filter: add worktreepath atom
Philip Oakley	1fde99cf doc branch: provide examples for listing remote tracking branches
Phillip Wood	d559f502 rebase --abort/--quit: cleanup refs/rewritten
Phillip Wood	37e9ee5c sequencer: return errors from sequencer_remove_state()
René Scharfe	568a05c5 cleanup: fix possible overflow errors in binary search, part 2
SZEDER Gábor	70d07115 progress: use term_clear_line()
SZEDER Gábor	0ec9e491 pager: add a helper function to clear the last line in the terminal


Uncovered code in 'next' not in 'master'
--------------------------------------------------------

builtin/am.c
97387c8b 1662) die("unable to read from stdin; aborting");
6e7baf24 2336) die(_("interactive mode requires patches on the command line"));

builtin/bisect--helper.c
7877ac3d 574) retval = error(_("invalid ref: '%s'"), start_head.buf);
7877ac3d 575) goto finish;

grep.c
de99eb0c 1784) BUG("grep call which could print a name requires "

list-objects-filter-options.c
5c03bc8b 94) strbuf_addf(errbuf, _("invalid filter-spec '%s'"), arg);

Commits introducting uncovered code:
Emily Shaffer	de99eb0c grep: fail if call could output and name is null
Jeff King	97387c8b am: read interactive input from stdin
Jeff King	6e7baf24 am: drop tty requirement for --interactive
Johannes Schindelin	7877ac3d bisect--helper: verify HEAD could be parsed before continuing
Matthew DeVore	5c03bc8b list-objects-filter-options: error is localizeable


Uncovered code in 'master' not in 'master@{1}'
--------------------------------------------------------

builtin/fast-export.c
e80001f8 81) static int parse_opt_reencode_mode(const struct option *opt,
e80001f8 84) if (unset) {
e80001f8 85) reencode_mode = REENCODE_ABORT;
e80001f8 86) return 0;
e80001f8 89) switch (git_parse_maybe_bool(arg)) {
e80001f8 91) reencode_mode = REENCODE_NO;
e80001f8 92) break;
e80001f8 94) reencode_mode = REENCODE_YES;
e80001f8 95) break;
e80001f8 97) if (!strcasecmp(arg, "abort"))
e80001f8 98) reencode_mode = REENCODE_ABORT;
e80001f8 100) return error("Unknown reencoding mode: %s", arg);
e80001f8 103) return 0;
e80001f8 665) switch(reencode_mode) {
e80001f8 667) reencoded = reencode_string(message, "UTF-8", encoding);
e80001f8 668) break;
e80001f8 670) break;
e80001f8 672) die("Encountered commit-specific encoding %s in commit "
e80001f8 674)     encoding, oid_to_hex(&commit->object.oid));
ccbfc96d 686) printf("encoding %s\n", encoding);

builtin/log.c
13cdf780 873) return 0;

builtin/merge.c
f3f8311e 1290) usage_msg_opt(_("--quit expects no arguments"),

builtin/worktree.c
1de16aec 297) BUG("How come '%s' becomes empty after sanitization?", sb.buf);

builtin/write-tree.c
76a7bc09 53) die("%s: prefix %s not found", me, tree_prefix);

fast-import.c
3edfcc65 2612) read_next_command();
3edfcc65 2679) strbuf_addf(&new_data,

read-cache.c
7bd9631b 2201) src_offset += load_cache_entries_threaded(istate, mmap, mmap_size, nr_threads, ieot);

refs.c
1de16aec 111) sanitized->buf[sanitized->len-1] = '-';
1de16aec 170) if (sanitized)
1de16aec 171) strbuf_addch(sanitized, '-');
1de16aec 173) return -1;
1de16aec 178) strbuf_complete(sanitized, '/');
1de16aec 215) BUG("sanitizing refname '%s' check returned error", refname);

server-info.c
f4f476b6 109) ret = -1;
f4f476b6 110) goto out;
f4f476b6 122) goto out;
f4f476b6 124) goto out;
f4f476b6 133) if (uic.cur_fp)
f4f476b6 134) fclose(uic.cur_fp);

Commits introducting uncovered code:
Denton Liu	13cdf780 format-patch: teach format.notes config option
Elijah Newren	e80001f8 fast-export: do automatic reencoding of commit messages only if requested
Elijah Newren	ccbfc96d fast-export: avoid stripping encoding header if we cannot reencode
Elijah Newren	3edfcc65 fast-import: support 'encoding' commit header
Eric Wong	f4f476b6 update-server-info: avoid needless overwrites
Jeff King	76a7bc09 cmd_{read,write}_tree: rename "unused" variable that is used
Jeff King	7bd9631b read-cache: drop unused parameter from threaded load
Nguyễn Thái Ngọc Duy	f3f8311e merge: add --quit
Nguyễn Thái Ngọc Duy	1de16aec worktree add: sanitize worktree names

