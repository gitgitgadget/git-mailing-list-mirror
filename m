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
	by dcvr.yhbt.net (Postfix) with ESMTP id 60CC41F462
	for <e@80x24.org>; Fri,  7 Jun 2019 01:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfFGBTO (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 21:19:14 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38999 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfFGBTN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 21:19:13 -0400
Received: by mail-qt1-f195.google.com with SMTP id i34so491108qta.6
        for <git@vger.kernel.org>; Thu, 06 Jun 2019 18:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=KCaKdEeQjjAuMsnLho/K2n9y7wzT8Us2xoQOEsFoBNo=;
        b=d+QaqfWwXCAzdKGAx8iZxohptYHZA+mfuvXrt5OVg+ZFLnEXnZZuOE8L8BjIBk5b/L
         oWeLsfvrVJrCWCcvClH1LcyVxaxxpNNTEt1QOTcdxH+ZLWpYpWOjasiqdo51rvXfMF1m
         81dsVd5HPndhqQYRian6PoMfi0TpCV39zJZ8MnPiV0lptoTGeYqNfgyzA/wHbiTl6ZxB
         9Vs1mJHdfaKPKJH/xvhqPf0+KZoLdTE0dMeqY4poKNh/rm6UauiJBAZt1MpwBp+cZFDC
         IDAsJcKaFnGq6CIns9xj7sjie9hF4Pw+MuM2fVK0r+xwbJP+zRRTXBNvEa3z3wkKPSYw
         MhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=KCaKdEeQjjAuMsnLho/K2n9y7wzT8Us2xoQOEsFoBNo=;
        b=F4yJpiOw8epOW745g+OzQxYkEKfQ0Zw68a/QNgP1lXxv4er38wwdQ881HC442b/sdv
         RZoYPrlv6qKndqpMdrd2zNmFOVu/NfBloiXdQP5ymL2P4QpFH++xr9OZKeZo54KOWXBY
         aRrqLVmG4I9N36c3/l0t7Uc7bsskYj2E82kuhUYBUkOQw+pSoLs1ggkYQfhkiyLfRXVR
         P1IQtF/7kSRWvkFXJu6TxnyQ8YcA5iFe/eNsnMfMgIKlv12cIdCI9jfIDOnGP7snzyII
         l3eZB6zpuj22Lp4Kx8Aqr2mT8mQGhc5lw5FA1DjTPhjNC8aHG1qmIkc9p0qyZmLXE7pE
         WhiA==
X-Gm-Message-State: APjAAAU00//MYLj7nFvMD5z72NkDSanVvLDa4+g0E7NKKoI5ItuVnWX+
        CNWRQ7Dj1Ld0+hkYvu1YqHwD+dwg
X-Google-Smtp-Source: APXvYqypdywdV0LwuVDi8iB84cgc39Wm8YPalkly7LdtXfGswcjbEU/1MmDS7/LZXoFHjtAbLWzgKQ==
X-Received: by 2002:a0c:96e7:: with SMTP id b36mr4148251qvd.155.1559870351859;
        Thu, 06 Jun 2019 18:19:11 -0700 (PDT)
Received: from [10.0.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id q24sm374954qtq.58.2019.06.06.18.19.10
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 18:19:10 -0700 (PDT)
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (Thursday, June 6 2019)
Message-ID: <396091fc-5572-19a5-4f18-61c258590dd5@gmail.com>
Date:   Thu, 6 Jun 2019 21:19:08 -0400
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

[1] https://derrickstolee.github.io/git-test-coverage/reports/2019-06-06.htm
[2] https://derrickstolee.github.io/git-test-coverage/reports/2019-06-06.txt

---

pu	4f91bbec8a3cc2fff435fb3dbb0dfa5f9d223141
jch	e1895a3c3b1fef6d1bc80251d09598e219d3908d
next	ee3066bb6536c68f973b3c0ffaaa13f4bfda5ea3
master	74583d89127e21255c12dd3c8a3bf60b497d7d03
master@{1}	aa25c82427ae70aebf3b8f970f2afd54e9a2a8c6


Uncovered code in 'pu' not in 'jch'
--------------------------------------------------------

blame.c
170072f9 846)     (result[i] >= most_certain_line_a ||
170072f9 847)      second_best_result[i] >= most_certain_line_a)) {
170072f9 848) certainties[i] = CERTAINTY_NOT_CALCULATED;
170072f9 951) max_search_distance_b = 0;
1fc73384 998) return;
8934ac8c 1190)     ent->ignored == next->ignored &&
8934ac8c 1191)     ent->unblamable == next->unblamable) {
43885768 1607) continue;
ae3f36de 2425) continue;

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
b472070f 2302) target ? hash_to_hex(target->hash) : base_url,

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
Barret Rhoden	8934ac8c blame: add config options for the output of ignored or unblamable lines
Barret Rhoden	43885768 blame: use the fingerprint heuristic to match ignored lines
Barret Rhoden	ae3f36de blame: add the ability to ignore commits and their changes
Christian Couder	dcc8b4e9 promisor-remote: implement promisor_remote_get_direct()
Christian Couder	b21a55f3 promisor-remote: parse remote.*.partialclonefilter
Christian Couder	7bdf0926 promisor-remote: use repository_format_partial_clone
Christian Couder	0ba08c05 Remove fetch-object.{c,h} in favor of promisor-remote.{c,h}
Christian Couder	54248706 Add initial support for many promisor remotes
Christian Couder	7b6e1b04 Move core_partial_clone_filter_default to promisor-remote.c
Denton Liu	f39a9c65 remote: add --save-to-push option to git remote set-url
Jonathan Tan	a8d662e3 upload-pack: refactor reading of pack-objects out
Jonathan Tan	820a5361 upload-pack: send part of packfile response as uri
Junio C Hamano	b472070f Merge branch 'jt/fetch-cdn-offload' into pu
Michael Platings	170072f9 blame: add a fingerprint heuristic to match ignored lines


Uncovered code in 'jch' not in 'next'
--------------------------------------------------------

builtin/branch.c
1fde99cf 841) die(_("The -a, and -r, options to 'git branch' do not take a branch name.\n"

builtin/checkout.c

builtin/commit.c

builtin/gc.c

builtin/rebase.c
d559f502 759) ret = error(_("could not remove '%s'"),
526c03b5 1272) goto done;
10572de1 1288) goto done;
d559f502 1675) error(_("could not remove '%s'"),

commit-graph.c
a53af50b 269) chunk_repeated = 1;
a53af50b 339) warning(_("commit-graph has no base graphs chunk"));
a53af50b 340) return 0;
cd556367 344) n--;
a53af50b 346) if (!oideq(&oids[n], &cur_g->oid) ||
a53af50b 347)     !hasheq(oids[n].hash, g->chunk_base_graphs + g->hash_len * n)) {
a53af50b 348) warning(_("commit-graph chain does not match"));
a53af50b 349) return 0;
cd556367 353) cur_g = cur_g->base_graph;
cd556367 380) free(chain_name);
cd556367 381) return NULL;
cd556367 388) return NULL;
cd556367 396) warning(_("invalid commit-graph chain: line '%s' not a hash"),
cd556367 398) valid = 0;
cd556367 399) break;
c6b73769 414) valid = 0;
2d06258b 531) BUG("NULL commit-graph");
2d06258b 537) BUG("position %d is beyond the scope of this commit-graph (%d local + %d base commits)",
2d06258b 598) BUG("position %d is beyond the scope of this commit-graph (%d local + %d base commits)",
4ece4fc1 945) if (find_commit_in_graph(parent->item,
4ece4fc1 948) edge_value = pos;
4ece4fc1 1043) continue;
d83160e8 1165) error(_("error opening index for %s"), packname.buf);
d83160e8 1166) return 1;
63a8be62 1205) continue;
93ba1867 1228) display_progress(ctx->progress, ctx->approx_nr_objects);
4ece4fc1 1317) error(_("failed to write correct number of base graph ids"));
4ece4fc1 1318) return -1;
8520d7fc 1350) error(_("unable to create leading directories of %s"),
8520d7fc 1352) return errno;
4ece4fc1 1362) error(_("unable to create '%s'"), ctx->graph_name);
4ece4fc1 1363) return -1;
4ece4fc1 1437) return -1;
4ece4fc1 1463) error(_("unable to open commit-graph chain file"));
4ece4fc1 1464) return -1;
da09c6fe 1475) error(_("failed to rename base commit-graph file"));
4ece4fc1 1495) error(_("failed to rename temporary commit-graph file"));
4ece4fc1 1496) return -1;
00a8cb54 1523)     (max_commits && num_commits > max_commits))) {
c6b73769 1525) break;
c6b73769 1540) ctx->num_commit_graphs_after = 1;
c6b73769 1541) ctx->new_base_graph = NULL;
0e2ec504 1617) duplicates++;
0e2ec504 1620) ctx->commits.list[last_distinct + 1] = ctx->commits.list[i];
0e2ec504 1628) ctx->num_extra_edges += num_parents - 2;
00a8cb54 1788) ctx->oids.alloc = split_opts->max_commits;
efeb229e 1824) error(_("the commit graph format cannot write %d commits"), count_distinct);
efeb229e 1825) res = 1;
efeb229e 1826) goto cleanup;
efeb229e 1835) error(_("too many commits to write graph"));
efeb229e 1836) res = 1;
efeb229e 1837) goto cleanup;

config.c
07b2c0ea 283) return 0;

read-cache.c
ee70c128 1723) if (advice_unknown_index_extension) {
ee70c128 1724) warning(_("ignoring optional %.4s index extension"), ext);
ee70c128 1725) advise(_("This is likely due to the file having been written by a newer\n"

ref-filter.c
2582083f 93) keydata_aka_refname ? keydata_aka_refname : k->wt->head_ref);

sequencer.c
37e9ee5c 293) ret = -1;
37e9ee5c 311) ret = error(_("could not remove '%s'"), buf.buf);

Commits introducting uncovered code:
Denton Liu	07b2c0ea config: learn the "onbranch:" includeIf condition
Denton Liu	526c03b5 rebase: refactor can_fast_forward into goto tower
Denton Liu	10572de1 rebase: fast-forward --onto in more cases
Derrick Stolee	0e2ec504 commit-graph: merge commit-graph chains
Derrick Stolee	efeb229e commit-graph: return with errors during write
Derrick Stolee	00a8cb54 commit-graph: create options for split files
Derrick Stolee	da09c6fe commit-graph: add --split option to builtin
Derrick Stolee	8520d7fc commit-graph: extract write_commit_graph_file()
Derrick Stolee	63a8be62 commit-graph: extract fill_oids_from_commit_hex()
Derrick Stolee	93ba1867 commit-graph: extract fill_oids_from_all_packs()
Derrick Stolee	4ece4fc1 commit-graph: write commit-graph chains
Derrick Stolee	2d06258b commit-graph: prepare for commit-graph chains
Derrick Stolee	c6b73769 commit-graph: allow cross-alternate chains
Derrick Stolee	cd556367 commit-graph: load commit-graph chains
Derrick Stolee	a53af50b commit-graph: add base graphs chunk
Derrick Stolee	d83160e8 commit-graph: extract fill_oids_from_packs()
Jonathan Nieder	ee70c128 index: offer advice for unknown index extensions
Nickolai Belakovski	2582083f ref-filter: add worktreepath atom
Philip Oakley	1fde99cf doc branch: provide examples for listing remote tracking branches
Phillip Wood	37e9ee5c sequencer: return errors from sequencer_remove_state()
Phillip Wood	d559f502 rebase --abort/--quit: cleanup refs/rewritten


Uncovered code in 'next' not in 'master'
--------------------------------------------------------

builtin/am.c
97387c8b 1662) die("unable to read from stdin; aborting");
6e7baf24 2336) die(_("interactive mode requires patches on the command line"));

builtin/bisect--helper.c
7877ac3d 574) retval = error(_("invalid ref: '%s'"), start_head.buf);
7877ac3d 575) goto finish;

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

builtin/index-pack.c
8a30a1ef 1365) continue;

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

grep.c
de99eb0c 1784) BUG("grep call which could print a name requires "

list-objects-filter-options.c
5c03bc8b 94) strbuf_addf(errbuf, _("invalid filter-spec '%s'"), arg);

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
f4f476b6 110) ret = -1;
f4f476b6 111) goto out;
f4f476b6 123) goto out;
f4f476b6 125) goto out;
f4f476b6 134) if (uic.cur_fp)
f4f476b6 135) fclose(uic.cur_fp);

Commits introducting uncovered code:
Denton Liu	13cdf780 format-patch: teach format.notes config option
Elijah Newren	e80001f8 fast-export: do automatic reencoding of commit messages only if requested
Elijah Newren	ccbfc96d fast-export: avoid stripping encoding header if we cannot reencode
Elijah Newren	3edfcc65 fast-import: support 'encoding' commit header
Emily Shaffer	de99eb0c grep: fail if call could output and name is null
Eric Wong	f4f476b6 update-server-info: avoid needless overwrites
Jeff King	97387c8b am: read interactive input from stdin
Jeff King	6e7baf24 am: drop tty requirement for --interactive
Jeff King	76a7bc09 cmd_{read,write}_tree: rename "unused" variable that is used
Jeff King	7bd9631b read-cache: drop unused parameter from threaded load
Johannes Schindelin	7877ac3d bisect--helper: verify HEAD could be parsed before continuing
Jonathan Tan	8a30a1ef index-pack: prefetch missing REF_DELTA bases
Matthew DeVore	5c03bc8b list-objects-filter-options: error is localizeable
Nguyễn Thái Ngọc Duy	f3f8311e merge: add --quit
Nguyễn Thái Ngọc Duy	1de16aec worktree add: sanitize worktree names


Uncovered code in 'master' not in 'master@{1}'
--------------------------------------------------------

builtin/rebase.c
4c785c0e 1206) opts->flags &= ~REBASE_DIFFSTAT;

diff.c
8ef05193 5217) return error(_("%s expects a numerical value"), "--unified");

parse-options-cb.c
f7e68a08 20) return error(_("option `%s' expects a numerical value"),

parse-options.c
f7e68a08 199) return error(_("%s expects a numerical value"),

progress.c
1aed1a5f 131)     cols - progress->title_len - 1 : 0;

remote-curl.c
8a1569d6 1120) die(_("protocol error: expected sha/ref, got '%s'"), p);
8a1569d6 1126) die(_("protocol error: expected sha/ref, got '%s'"), p);

trace2/tr2_tls.c
5fdae9d3 87) return pthread_getspecific(tr2tls_key) == tr2tls_thread_main;

Commits introducting uncovered code:
Jeff Hostetler	5fdae9d3 trace2: fix tracing when NO_PTHREADS is defined
Jiang Xin	8a1569d6 i18n: fix typos found during l10n for git 2.22.0
Johannes Schindelin	4c785c0e rebase: replace incorrect logical negation by correct bitwise one
Nguyễn Thái Ngọc Duy	8ef05193 diff-parseopt: restore -U (no argument) behavior
Nguyễn Thái Ngọc Duy	f7e68a08 parse-options: check empty value in OPT_INTEGER and OPT_ABBREV
SZEDER Gábor	1aed1a5f progress: avoid empty line when breaking the progress line

