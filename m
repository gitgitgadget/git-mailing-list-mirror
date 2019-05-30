Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D67CB1F462
	for <e@80x24.org>; Thu, 30 May 2019 12:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfE3Mwo (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 May 2019 08:52:44 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37068 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfE3Mwo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 May 2019 08:52:44 -0400
Received: by mail-qt1-f195.google.com with SMTP id y57so6753314qtk.4
        for <git@vger.kernel.org>; Thu, 30 May 2019 05:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=DiZaKQ+v7CzIGkERfsdc/hZH7qHRIB+U0ZsFvMwc69E=;
        b=N67KMcjlJr128/CukLDde0odKfB1F0pFV3vgRlqvJmcQo2Gmc6vKpKlJU+bdh89hVN
         aStGkO96rSqKQpywplbO/HlnBm3O6oT0h7lYZ40dS/XsUJAjN2WYjXEz/us4AIMrxhEN
         gLwBELrpf9c7A3F6yW18ety/MsQB3Okpu50PnvkfNh0QHRZt4LDCp5qQ+19b+2yZkrs3
         cK3jYSotUzkpPKwwXRru7jYgX2t8RtrwtNySUJGvuTb7OpdU0avk2+n4iIt/FbGSGU5F
         h29hg2t9y5+YYU+nkNQ+w+mL5BbWGs2jde/S3gtdRyMwfta6TtFB1Ds4YfmOx6kiOYsL
         HrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=DiZaKQ+v7CzIGkERfsdc/hZH7qHRIB+U0ZsFvMwc69E=;
        b=U8y5BWmJpXmDAo28sp6koAwT9uZXwDkKSejgCcnynQ3iJ956oOD9/AahW9jTRmcqLY
         NhWwXS/HmLlcVAGK/ODAb1cRorAERMkRrbeEtgV+RiV4COZLFxwWHXrhU6A/HYe3Gljc
         /refRdO+6H+TWokLyGoyVyBYs5eNjOoSypfQl+e4H3DgK3tKAzY/2FCHiwGbQUvLgREa
         oe6hH5wowUBpMRdRdfJgXX85Bx1XsqYoP5R4MXsLKlQ15eHdFMQjx1wvydmQF+KHUxDd
         4fcIDO8LR5NvObVjb4sxrnawsk5JYLkJIWK0wsXWRPKmXTUf/L/Bj8SZxbWJHA1Ycgro
         tx6Q==
X-Gm-Message-State: APjAAAX6pb6zbVFSi3colpxcvmcP46VIAXNOuaUYVa9cl1qDLlbvxus6
        43wh57E7pn9da58AzdUYHcoIUQK7
X-Google-Smtp-Source: APXvYqz/UyZPZXqXd4QdihKxrctJGEnABwXJ5nVqOuMKCNowWhYK81CMJTwfFe078304tjcxpM4tHQ==
X-Received: by 2002:ac8:1a39:: with SMTP id v54mr3337774qtj.21.1559220762979;
        Thu, 30 May 2019 05:52:42 -0700 (PDT)
Received: from [10.0.1.7] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id r54sm1576288qtr.41.2019.05.30.05.52.42
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 05:52:42 -0700 (PDT)
To:     GIT Mailing-list <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (Thursday, May 30th)
Message-ID: <2fb43bd3-71a7-fd92-e9b8-43e4eeed34cd@gmail.com>
Date:   Thu, 30 May 2019 08:52:41 -0400
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

Here is today's test coverage report. You can view it in HTML [1] or
download the plain-text version [2], also pasted below.

Thanks,
-Stolee

[1] https://derrickstolee.github.io/git-test-coverage/reports/2019-05-30.htm
[2] https://derrickstolee.github.io/git-test-coverage/reports/2019-05-30.txt

---

pu	1feae2a559816e6df62e994d4ffdc226dee6631a
jch	1605b8c0b5622510a96ef6a358adbd142cf8222e
next	5d7573a151b918062087822a2f0d7661dc4bd707
master	aa25c82427ae70aebf3b8f970f2afd54e9a2a8c6
master@{1}	ab15ad1a3b4b04a29415aef8c9afa2f64fc194a2


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
ee334603 2302) target ? hash_to_hex(target->hash) : base_url,

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
Junio C Hamano	ee334603 Merge branch 'jt/fetch-cdn-offload' into pu
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

builtin/rebase.c
4c785c0e 1201) opts->flags &= ~REBASE_DIFFSTAT;

builtin/worktree.c
1de16aec 297) BUG("How come '%s' becomes empty after sanitization?", sb.buf);

builtin/write-tree.c
76a7bc09 53) die("%s: prefix %s not found", me, tree_prefix);

diff.c
8ef05193 5217) return error(_("%s expects a numerical value"), "--unified");

fast-import.c
3edfcc65 2612) read_next_command();
3edfcc65 2679) strbuf_addf(&new_data,

grep.c
de99eb0c 1784) BUG("grep call which could print a name requires "

parse-options-cb.c
f7e68a08 20) return error(_("option `%s' expects a numerical value"),

parse-options.c
f7e68a08 199) return error(_("%s expects a numerical value"),

progress.c
1aed1a5f 131)     cols - progress->title_len - 1 : 0;

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

trace2/tr2_tls.c
5fdae9d3 87) return pthread_getspecific(tr2tls_key) == tr2tls_thread_main;

Commits introducting uncovered code:
Denton Liu	13cdf780 format-patch: teach format.notes config option
Elijah Newren	e80001f8 fast-export: do automatic reencoding of commit messages only if requested
Elijah Newren	ccbfc96d fast-export: avoid stripping encoding header if we cannot reencode
Elijah Newren	3edfcc65 fast-import: support 'encoding' commit header
Emily Shaffer	de99eb0c grep: fail if call could output and name is null
Eric Wong	f4f476b6 update-server-info: avoid needless overwrites
Jeff Hostetler	5fdae9d3 trace2: fix tracing when NO_PTHREADS is defined
Jeff King	7bd9631b read-cache: drop unused parameter from threaded load
Jeff King	76a7bc09 cmd_{read,write}_tree: rename "unused" variable that is used
Jeff King	97387c8b am: read interactive input from stdin
Jeff King	6e7baf24 am: drop tty requirement for --interactive
Johannes Schindelin	7877ac3d bisect--helper: verify HEAD could be parsed before continuing
Johannes Schindelin	4c785c0e rebase: replace incorrect logical negation by correct bitwise one
Jonathan Tan	8a30a1ef index-pack: prefetch missing REF_DELTA bases
Nguyễn Thái Ngọc Duy	f3f8311e merge: add --quit
Nguyễn Thái Ngọc Duy	8ef05193 diff-parseopt: restore -U (no argument) behavior
Nguyễn Thái Ngọc Duy	f7e68a08 parse-options: check empty value in OPT_INTEGER and OPT_ABBREV
Nguyễn Thái Ngọc Duy	1de16aec worktree add: sanitize worktree names
SZEDER Gábor	1aed1a5f progress: avoid empty line when breaking the progress line


Uncovered code in 'master' not in 'master@{1}'
--------------------------------------------------------

builtin/difftool.c
f3a3a021 731) die(_("--dir-diff is incompatible with --no-index"));

http.c
5c3d5a38 2329) return posn / eltsize;

parse-options.c
5c387428 282) return 0;
5c387428 481) BUG("OPT_ALIAS() should not remain at this point. "
5c387428 661) BUG("An alias must have long option name");
5c387428 670) BUG("No please. Nested aliases are not supported.");
5c387428 685) BUG("could not find source option '%s' of alias '%s'",

sha1-name.c
af96fe33 161) return;

t/helper/test-read-cache.c
dc76852d 29) die("%s not in index", name);

upload-pack.c
8e712ef6 1073) precomposed_unicode = git_config_bool(var, value);

Commits introducting uncovered code:
Derrick Stolee	af96fe33 midx: add packs to packed_git linked list
Elijah Newren	8e712ef6 Honor core.precomposeUnicode in more places
Johannes Schindelin	f3a3a021 difftool --no-index: error out on --dir-diff (and don't crash)
Johannes Schindelin	dc76852d fsmonitor: demonstrate that it is not refreshed after discard_index()
Mike Hommey	5c3d5a38 Make fread/fwrite-like functions in http.c more like fread/fwrite.
Nguyễn Thái Ngọc Duy	5c387428 parse-options: don't emit "ambiguous option" for aliases

