Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HEXHASH_WORD,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAC9A1F461
	for <e@80x24.org>; Thu, 11 Jul 2019 01:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfGKBrw (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jul 2019 21:47:52 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38205 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbfGKBrv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jul 2019 21:47:51 -0400
Received: by mail-io1-f67.google.com with SMTP id j6so9047939ioa.5
        for <git@vger.kernel.org>; Wed, 10 Jul 2019 18:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Kp7GNyQiv0KhD8j0n/Nf5tmL1H3SpoeaWsF1fuY17Qw=;
        b=msLS/gDaSv2mNww786Bz2qVRkY/2Q7lnM+bzI8GI+oAyF70VhO7E2AouQtZr29SD7q
         JrcdgxDnpFoyKCL/0jD2c8C5x2Y5LN40nIuL6FGVym3CfZ4QBGLIkqw/r19v9PhJIRwy
         bVWLFiCuKFezCsFPKb/C4eGiTvmaH48ojuSnzno8H49kNa6gRiPDI2kjme1O/jCj4Yiz
         EH1hsJsZBt0noaOKO9aLyY/tYuYEGzA9uNSW/nrw/Fk3uEXdMhLuHso+K8/pVkJQAp7y
         3XM1GPna7ON10YYHu1w6f+1YgE86vjLU8fmD8FPri4v3TsUv/qIAT/b0YIRy+8IVvMo5
         L8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Kp7GNyQiv0KhD8j0n/Nf5tmL1H3SpoeaWsF1fuY17Qw=;
        b=JJO+NrLLPPIq8YGTEYGKEssu+lNw5OF2bh7pL5DVgviOHaBz3aye1TiM+dX2snS6J8
         tefWpjyupS48q/RIBhAydV/uUEbDH9QMEslkoprpCtg7+vlEVu0FYwO/3XSIu8xufktb
         YrT5QUWQ67yzdwqgiawYD2kPgSBbOV8/RljtFDZ9rNAjMq7m04+Xr9jJlJnjEPrD869B
         V7Dfpw5/gJdkieIXTugtzLCHbQpoFLrY7OY8SxCK8B9mi8cFSauvIsPcIbukocyEOjfN
         lv9hBUaMezC3E3vV4UmYpqVZ8BUCQtLcpIlt3s7W9V/uO6Jq22k7MzQxUQcPFDbsAsto
         XdmQ==
X-Gm-Message-State: APjAAAU8rNxSkIQgU6R02ir1CmePOoOtgdJjH76DjgcoWoaMY25NOW2n
        acWP0tf9ElfC0htucSYY1a9RAdm2
X-Google-Smtp-Source: APXvYqzb7xe8EggVAhVPQAMOF0rqY0TMjlbDzGQ7Kf1X/uraBcDEaa4wLoTUZLDcvp8Ul750QgZmaw==
X-Received: by 2002:a5d:8b52:: with SMTP id c18mr1382820iot.89.1562809670362;
        Wed, 10 Jul 2019 18:47:50 -0700 (PDT)
Received: from [192.168.0.114] ([199.102.122.24])
        by smtp.gmail.com with ESMTPSA id e26sm3305913iod.10.2019.07.10.18.47.48
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 18:47:49 -0700 (PDT)
To:     GIT Mailing-list <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (Wed. July 10)
Message-ID: <2f2925b8-8276-c2cb-595f-badaa5cedc1e@gmail.com>
Date:   Wed, 10 Jul 2019 21:47:47 -0400
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

Here is today's test coverage report.

Thanks,
-Stolee

[1] https://derrickstolee.github.io/git-test-coverage/reports/2019-07-10.htm
[2] https://derrickstolee.github.io/git-test-coverage/reports/2019-07-10.txt

---

pu	4b52dbde4091e50c06af0c7ea0e71426941019a6
jch	59741dc3e9aec4a485f18c8adb47ae91cb4641a6
next	20b46463406ef6ca70b1a63c5e26d4e2ead8dc13
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

builtin/rebase.c
d559f502 759) ret = error(_("could not remove '%s'"),
d559f502 1675) error(_("could not remove '%s'"),

builtin/remote.c
f39a9c65 1551) die(_("--save-to-push cannot be used with other options"));
f39a9c65 1575) die(_("--save-to-push can only be used when only one url is defined"));

fetch-pack.c

http-fetch.c

http.c
55cac500 2302) target ? hash_to_hex(target->hash) : base_url,

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

ref-filter.c
2582083f 93) keydata_aka_refname ? keydata_aka_refname : k->wt->head_ref);

remote-curl.c

sequencer.c
37e9ee5c 293) ret = -1;
37e9ee5c 311) ret = error(_("could not remove '%s'"), buf.buf);

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
Christian Couder	7b6e1b04 Move core_partial_clone_filter_default to promisor-remote.c
Christian Couder	dcc8b4e9 promisor-remote: implement promisor_remote_get_direct()
Christian Couder	b21a55f3 promisor-remote: parse remote.*.partialclonefilter
Christian Couder	7bdf0926 promisor-remote: use repository_format_partial_clone
Christian Couder	54248706 Add initial support for many promisor remotes
Christian Couder	0ba08c05 Remove fetch-object.{c,h} in favor of promisor-remote.{c,h}
Denton Liu	f39a9c65 remote: add --save-to-push option to git remote set-url
Jonathan Tan	a8d662e3 upload-pack: refactor reading of pack-objects out
Jonathan Tan	820a5361 upload-pack: send part of packfile response as uri
Junio C Hamano	55cac500 Merge branch 'jt/fetch-cdn-offload' into pu
Michael Platings	170072f9 blame: add a fingerprint heuristic to match ignored lines
Nickolai Belakovski	2582083f ref-filter: add worktreepath atom
Phillip Wood	d559f502 rebase --abort/--quit: cleanup refs/rewritten
Phillip Wood	37e9ee5c sequencer: return errors from sequencer_remove_state()


Uncovered code in 'jch' not in 'next'
--------------------------------------------------------

builtin/branch.c
1fde99cf 833) die(_("The -a, and -r, options to 'git branch' do not take a branch name.\n"

builtin/checkout.c

builtin/commit.c

builtin/gc.c
efeb229e 691) return 1;

builtin/rebase.c
526c03b5 1262) goto done;
10572de1 1278) goto done;

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

list-objects-filter-options.c
5c03bc8b 94) strbuf_addf(errbuf, _("invalid filter-spec '%s'"), arg);

read-cache.c
ee70c128 1723) if (advice_unknown_index_extension) {
ee70c128 1724) warning(_("ignoring optional %.4s index extension"), ext);
ee70c128 1725) advise(_("This is likely due to the file having been written by a newer\n"

Commits introducting uncovered code:
Denton Liu	526c03b5 rebase: refactor can_fast_forward into goto tower
Denton Liu	10572de1 rebase: fast-forward --onto in more cases
Derrick Stolee	efeb229e commit-graph: return with errors during write
Derrick Stolee	d83160e8 commit-graph: extract fill_oids_from_packs()
Derrick Stolee	63a8be62 commit-graph: extract fill_oids_from_commit_hex()
Derrick Stolee	93ba1867 commit-graph: extract fill_oids_from_all_packs()
Derrick Stolee	8520d7fc commit-graph: extract write_commit_graph_file()
Jonathan Nieder	ee70c128 index: offer advice for unknown index extensions
Matthew DeVore	5c03bc8b list-objects-filter-options: error is localizeable
Philip Oakley	1fde99cf doc branch: provide examples for listing remote tracking branches


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


