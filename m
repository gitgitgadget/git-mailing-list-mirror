Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HEXHASH_WORD,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87E481F461
	for <e@80x24.org>; Thu, 20 Jun 2019 16:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfFTQul (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 12:50:41 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]:42570 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfFTQuk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 12:50:40 -0400
Received: by mail-qk1-f176.google.com with SMTP id b18so2363126qkc.9
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 09:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=GdzHybnTL4MMi2kVbU4gRTI67NiDh0z8DebyXPE14q4=;
        b=CPmIex8lC5jGHVb0x/3zj9f/F/4cJuN+INsid+jvve5Txo2KE29FVhPHh3bsxmiE4/
         Jod781V401x1eyYCLi79IV8+aHmxEUFo+OvTCHgIiIKHUvz3quxWBxsikHw9Xe1iRHA8
         DzJx9mVpBjy6AQqcboac3zZP14OG9ArQYlh6SI91iC19obvafos9cz6/LNL3+pEW0FaN
         VviYTz2K5j5iDbhZIqWuG+9lRVI1jmXcY1CAX9L+tpyc5uS+HlvgJrjzzBs7lJ0zG1dH
         ra56GP0bH/ojCRCKDXHbRuNSN08mkXxNvy5/N96pCr4LUguPipUesOIZggN4O7o7EQbA
         92+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=GdzHybnTL4MMi2kVbU4gRTI67NiDh0z8DebyXPE14q4=;
        b=jy72vNENvZZ9DkteMqM1iaW9hN9BOxz4b2q+QL4WbnZuHTswf73tOx6ADLILy09kXz
         q6N7ImIEMH/wtASAGnpz1qCOEVW1AcUchkMDrLOolEJLD7eCeE+peaSzw3VqRQOPS+SG
         nJcQ194iDjd74pJKV8bX9HSlaV4TGAdBMgngLoGYLdYhExAfSF7a7aKxeOUrAVIvSs+C
         0mARUpBG7Sfg2AbLiLxi8Q4qtWcuAQdMljoi51j9vZpAl/mkV/+1ZQ++7m3znWsBiucu
         yBoXyDaAIDPAzh1HEBUNglWriN2ivQyHoZ1AfAKEnI4tNFNgoGB3cdMZm6kgG4eg1n1e
         Aa0w==
X-Gm-Message-State: APjAAAXxI/txbwcmLPkG7pkQI3HiZw2oBfBnStgLbaoFvv+8sskr411Z
        Wzqz0aQojNHpylrYv4L5kajAA88x
X-Google-Smtp-Source: APXvYqxQej59xpW4nJuH6b60CjQtmhyWGMNqo9KiGgRP8NQS8EnXdgyAylDfHYugKtKY2UIIB8kztQ==
X-Received: by 2002:a37:6312:: with SMTP id x18mr109190384qkb.300.1561049439042;
        Thu, 20 Jun 2019 09:50:39 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:a934:2ce3:312e:b671? ([2001:4898:a800:1012:5a68:2ce3:312e:b671])
        by smtp.gmail.com with ESMTPSA id r5sm98523qkc.42.2019.06.20.09.50.38
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 09:50:38 -0700 (PDT)
To:     Git List <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (Thurs, June 20)
Message-ID: <159ea9a6-1537-8ecc-d707-d7c131e8d9ec@gmail.com>
Date:   Thu, 20 Jun 2019 12:50:38 -0400
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

Thanks,
-Stolee

[1] https://derrickstolee.github.io/git-test-coverage/reports/2019-06-20.htm
[2] https://derrickstolee.github.io/git-test-coverage/reports/2019-06-20.txt

---

pu	3f0adadc5dcf9bbc8a1f8a8075b3adca93cfa6a8
jch	956887a8ce1b8d4faa043b5780895e9c811c9b07
next	172b71a6c5b95846749746f7d63238d5f702bb00
master	a6a95cd1b46e48e5fe06bdbb0839a67ebeef4682
master@{1}	0aae918dd929862d3ce0ea2960897787bb269a3b


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

builtin/rev-list.c
9b93d269 476) die(

fetch-pack.c
820a5361 1384) die("expected '<hash> <uri>', got: %s\n", reader->line);
820a5361 1389) die("expected DELIM");
820a5361 1516) die("fetch-pack: unable to spawn http-fetch");
820a5361 1520) die("fetch-pack: expected keep then TAB at start of http-fetch output");
820a5361 1525) die("fetch-pack: expected hash then LF at end of http-fetch output");
820a5361 1532) die("fetch-pack: unable to finish http-fetch");
820a5361 1536) die("fetch-pack: pack downloaded from %s does not match expected hash %.*s",
820a5361 1537)     uri, (int) the_hash_algo->hexsz,
820a5361 1538)     packfile_uris.items[i].string);

http-fetch.c

http.c
eee30324 2304) target ? hash_to_hex(target->hash) : base_url,

list-objects-filter-options.c
d3d10e56 44) BUG("filter_options already populated");
d3d10e56 236) die(_("multiple filter-specs cannot be combined"));
9b93d269 286) BUG("no filter_spec available for this filter");
1e43301f 321) return;

list-objects-filter.c
1e43301f 583) BUG("expected oidset to be cleared already");

list-objects.c
aa36553a 210) ctx->show_object(obj, base->buf, ctx->show_data);

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
9b93d269 221) sq_quote_buf(&buf, spec);
a8d662e3 354) send_client_data(1, output_state.buffer, output_state.used);
820a5361 1387) string_list_clear(&data->uri_protocols, 0);

wrapper.c

Commits introducting uncovered code:
Barret Rhoden	1fc73384 blame: optionally track line fingerprints during fill_blame_origin()
Barret Rhoden	4c2c1b89 blame: use the fingerprint heuristic to match ignored lines
Barret Rhoden	ae3f36de blame: add the ability to ignore commits and their changes
Christian Couder	dcc8b4e9 promisor-remote: implement promisor_remote_get_direct()
Christian Couder	b21a55f3 promisor-remote: parse remote.*.partialclonefilter
Christian Couder	7b6e1b04 Move core_partial_clone_filter_default to promisor-remote.c
Christian Couder	7bdf0926 promisor-remote: use repository_format_partial_clone
Christian Couder	0ba08c05 Remove fetch-object.{c,h} in favor of promisor-remote.{c,h}
Christian Couder	54248706 Add initial support for many promisor remotes
Denton Liu	f39a9c65 remote: add --save-to-push option to git remote set-url
Jonathan Tan	820a5361 upload-pack: send part of packfile response as uri
Jonathan Tan	a8d662e3 upload-pack: refactor reading of pack-objects out
Junio C Hamano	eee30324 Merge branch 'jt/fetch-cdn-offload' into pu
Matthew DeVore	1e43301f list-objects-filter: implement composite filters
Matthew DeVore	d3d10e56 list-objects-filter-options: move error check up
Matthew DeVore	9b93d269 list-objects-filter-options: make filter_spec a string_list
Matthew DeVore	aa36553a list-objects-filter: make API easier to use


Uncovered code in 'jch' not in 'next'
--------------------------------------------------------

builtin/branch.c
1fde99cf 841) die(_("The -a, and -r, options to 'git branch' do not take a branch name.\n"

builtin/checkout.c

builtin/commit-graph.c
c2bc6e6a 203) return 1;

builtin/commit.c
e103f727 1677) return 1;

builtin/gc.c

builtin/multi-pack-index.c

builtin/rebase.c
d559f502 759) ret = error(_("could not remove '%s'"),
526c03b5 1272) goto done;
10572de1 1288) goto done;
d559f502 1675) error(_("could not remove '%s'"),

commit-graph.c
118bd570 277) chunk_repeated = 1;
118bd570 347) warning(_("commit-graph has no base graphs chunk"));
118bd570 348) return 0;
5c84b339 401) break;
d4f4d60f 550) BUG("NULL commit-graph");
d4f4d60f 553) die(_("invalid commit position. commit-graph is likely corrupt"));
d4f4d60f 613) die(_("invalid commit position. commit-graph is likely corrupt"));
6c622f9f 1057) continue;
ef5b83f2 1179) error(_("error opening index for %s"), packname.buf);
ef5b83f2 1180) return -1;
4c9efe85 1219) continue;
b2c83060 1242) display_progress(ctx->progress, ctx->approx_nr_objects);
6c622f9f 1331) error(_("failed to write correct number of base graph ids"));
6c622f9f 1332) return -1;
238def57 1364) error(_("unable to create leading directories of %s"),
238def57 1366) return -1;
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
e103f727 1842) error(_("the commit graph format cannot write %d commits"), count_distinct);
e103f727 1843) res = -1;
e103f727 1844) goto cleanup;
e103f727 1853) error(_("too many commits to write graph"));
e103f727 1854) res = -1;
e103f727 1855) goto cleanup;

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
19cfa0e0 42) hashmap_entry_init(&entry, sha1hash(key->hash));

packfile.c
8434e85d 372) strbuf_release(&buf);
8434e85d 373) return;
921d49be 1303) COPY_ARRAY(poi_stack, small_poi_stack, poi_stack_nr);
921d49be 1713) COPY_ARRAY(delta_stack, small_delta_stack,

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
28438e84 1500) strbuf_addstr(&desc, _("no branch"));

sequencer.c
37e9ee5c 293) ret = -1;
37e9ee5c 311) ret = error(_("could not remove '%s'"), buf.buf);
6bd767d1 2669) in_progress_error = _("revert is already in progress");
6bd767d1 2670) in_progress_advice =
6bd767d1 2672) break;
6bd767d1 2679) BUG("unexpected action in create_seq_dir");
f4b0f3c8 2779) return error(_("cannot resolve HEAD"));
f4b0f3c8 2862) if (!rollback_is_safe())
f4b0f3c8 2863) goto give_advice;
f4b0f3c8 2875) BUG("unexpected action in sequencer_skip");
f4b0f3c8 2879) return error(_("failed to skip the commit"));

sh-i18n--envsubst.c
568a05c5 252)   size_t j = j1 + ((j2 - j1) >> 1);

t/helper/test-oidmap.c
11510dec 52) if (get_oid(p1, &oid)) {
11510dec 53) printf("Unknown oid: %s\n", p1);
11510dec 54) continue;
11510dec 58) FLEX_ALLOC_STR(entry, name, p2);
11510dec 59) oidcpy(&entry->entry.oid, &oid);
11510dec 62) oidmap_put(&map, entry);
11510dec 97) if (get_oid(p1, &oid)) {
11510dec 98) printf("Unknown oid: %s\n", p1);
11510dec 99) continue;
11510dec 103) entry = oidmap_remove(&map, &oid);
11510dec 106) puts(entry ? entry->name : "NULL");
11510dec 107) free(entry);

Commits introducting uncovered code:
Christian Couder	19cfa0e0 oidmap: use sha1hash() instead of static hash() function
Christian Couder	11510dec t/helper: add test-oidmap.c
Denton Liu	526c03b5 rebase: refactor can_fast_forward into goto tower
Denton Liu	10572de1 rebase: fast-forward --onto in more cases
Denton Liu	07b2c0ea config: learn the "onbranch:" includeIf condition
Derrick Stolee	19575c7c multi-pack-index: implement 'expire' subcommand
Derrick Stolee	d01bf2e6 midx: refactor permutation logic and pack sorting
Derrick Stolee	8434e85d repack: refactor pack deletion for future use
Derrick Stolee	1771be90 commit-graph: merge commit-graph chains
Derrick Stolee	c523035c commit-graph: allow cross-alternate chains
Derrick Stolee	135a7123 commit-graph: add --split option to builtin
Derrick Stolee	238def57 commit-graph: extract write_commit_graph_file()
Derrick Stolee	4c9efe85 commit-graph: extract fill_oids_from_commit_hex()
Derrick Stolee	ce1e4a10 midx: implement midx_repack()
Derrick Stolee	ef5b83f2 commit-graph: extract fill_oids_from_packs()
Derrick Stolee	6c622f9f commit-graph: write commit-graph chains
Derrick Stolee	d4f4d60f commit-graph: prepare for commit-graph chains
Derrick Stolee	5c84b339 commit-graph: load commit-graph chains
Derrick Stolee	118bd570 commit-graph: add base graphs chunk
Derrick Stolee	e103f727 commit-graph: return with errors during write
Derrick Stolee	c2bc6e6a commit-graph: create options for split files
Derrick Stolee	b2c83060 commit-graph: extract fill_oids_from_all_packs()
Johannes Schindelin	08e04506 kwset: allow building with GCC 8
Jonathan Nieder	ee70c128 index: offer advice for unknown index extensions
Matthew DeVore	28438e84 ref-filter: sort detached HEAD lines firstly
Nickolai Belakovski	2582083f ref-filter: add worktreepath atom
Philip Oakley	1fde99cf doc branch: provide examples for listing remote tracking branches
Phillip Wood	37e9ee5c sequencer: return errors from sequencer_remove_state()
Phillip Wood	d559f502 rebase --abort/--quit: cleanup refs/rewritten
René Scharfe	921d49be use COPY_ARRAY for copying arrays
René Scharfe	568a05c5 cleanup: fix possible overflow errors in binary search, part 2
Rohit Ashiwal	6bd767d1 sequencer: add advice for revert
Rohit Ashiwal	f4b0f3c8 cherry-pick/revert: add --skip option
SZEDER Gábor	70d07115 progress: use term_clear_line()
SZEDER Gábor	0ec9e491 pager: add a helper function to clear the last line in the terminal


Uncovered code in 'next' not in 'master'
--------------------------------------------------------

list-objects-filter-options.c
5c03bc8b 94) strbuf_addf(errbuf, _("invalid filter-spec '%s'"), arg);

Commits introducting uncovered code:
Matthew DeVore	5c03bc8b list-objects-filter-options: error is localizeable


Uncovered code in 'master' not in 'master@{1}'
--------------------------------------------------------

builtin/am.c
97387c8b 1662) die("unable to read from stdin; aborting");
6e7baf24 2336) die(_("interactive mode requires patches on the command line"));

builtin/bisect--helper.c
7877ac3d 574) retval = error(_("invalid ref: '%s'"), start_head.buf);
7877ac3d 575) goto finish;

grep.c
de99eb0c 1784) BUG("grep call which could print a name requires "

Commits introducting uncovered code:
Emily Shaffer	de99eb0c grep: fail if call could output and name is null
Jeff King	97387c8b am: read interactive input from stdin
Jeff King	6e7baf24 am: drop tty requirement for --interactive
Johannes Schindelin	7877ac3d bisect--helper: verify HEAD could be parsed before continuing

