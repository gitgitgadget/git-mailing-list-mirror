Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HEXHASH_WORD,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDC031F461
	for <e@80x24.org>; Thu, 27 Jun 2019 17:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfF0RFg (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 13:05:36 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39654 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfF0RFg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 13:05:36 -0400
Received: by mail-qt1-f196.google.com with SMTP id i34so3235251qta.6
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 10:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=1sgiwoMx/bzsMJzoD9HKvcUf9x7z+hf2LvvtbWqS8J8=;
        b=qfCgK/PixCwWihbvxO+iC8Cdbz9D9ChL4z13gCelqDeSp8+GF2nr0qtua/B+yjTpb4
         EfXlomYAOhdFI5dbcb7t3xAMSlkVO1zumAjh+Fg4yfJRddHR41gIVmsUo02KwxnreaG1
         +q2jFKu3XMdD7pYRrWAbbzFXO/cdgNrNenM9iuT8q021+bQrV4fdc2WGiW0Lo4gQifO7
         toSGoKOE4YMiW6QO+Y1DJ+tiIT1Ptfd00pwwij2USjap1Lrm8shu7pHxNxhhC2/iDbuU
         XStRqBlcQTgE/hfJS76q08Pyd0txovID6sToeu0Md0iJJGxWzoHRIGjI1816VZdd+dV3
         U0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=1sgiwoMx/bzsMJzoD9HKvcUf9x7z+hf2LvvtbWqS8J8=;
        b=FuRcvuYscTh69NTKTV3d/4I9H7xkT7HBlTUmUlkBJc3WWXP+koManfDg0FSRXmie6l
         YXNT8V2tUu7+Yey7reTkKTCkFWOgovYni+WWRC+sTqldMN7gWYXYncB1bSlTjeWe8Ym4
         m6ZiIBv8TupHnkmuvyhSUO5TqW2WYP3CFQfc6ahky1V5vuAOD+KsKG7mTQN2b4i3HCXT
         9ssaebhnfXmEod9RnKmucR/MHCUCalAAJEtf6tu3PbK1ndt6M3dAJNmGTQYrNJy9Oswr
         iHdBm/lPAA42IjVmbdG2ApygGQZXUiOsxFOD8W7kHz2+iKb7WDEbRbiZn/VE00m4ECLf
         KcYA==
X-Gm-Message-State: APjAAAVfLSShiXoke3dT/NVXQ+0S82Gi06FTpBLiuSzB4fMIXkIX2u+X
        FzVam+T81otFTgdM8gwIFCF+NL9H
X-Google-Smtp-Source: APXvYqzvwJpEuWkaxUmkP8QQTmzABhTS8mdYqR6mfjsfzRUW8tWQl9fHnFyeQmVezPd4zEJYr9lFqQ==
X-Received: by 2002:a0c:b897:: with SMTP id y23mr4391325qvf.44.1561655134183;
        Thu, 27 Jun 2019 10:05:34 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:9905:3db8:5a6f:f512? ([2001:4898:a800:1010:4a3b:3db8:5a6f:f512])
        by smtp.gmail.com with ESMTPSA id o57sm1080283qtj.37.2019.06.27.10.05.33
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:05:33 -0700 (PDT)
To:     Git List <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (Thurs. June 27)
Message-ID: <49d98293-9f0b-44e9-cb07-d6b7ac791eb6@gmail.com>
Date:   Thu, 27 Jun 2019 13:05:33 -0400
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

[1] https://derrickstolee.github.io/git-test-coverage/reports/2019-06-27.htm
[2] https://derrickstolee.github.io/git-test-coverage/reports/2019-06-27.txt

---

pu	f8df19e612605e564ac8006e61428c8b95391624
jch	e1093b448f0c8fd5069bcff6cd20af2e1ab1bcef
next	ee2e6308ae95ce7ba2fabedcc43f5f741e71c152
master	8dca754b1e874719a732bc9ab7b0e14b21b1bc10
master@{1}	origin/maint


Uncovered code in 'pu' not in 'jch'
--------------------------------------------------------

archive.c
47f956bd 421) err = get_tree_entry(ar_args->repo,
47f956bd 422)      &tree->object.oid,

builtin/cat-file.c
b14ed5ad 529) warning("This repository uses promisor remotes. Some objects may not be loaded.");

builtin/clone.c
fbb4a33c 407) die_errno(_("failed to create directory '%s'"), pathname);
fbb4a33c 409) die_errno(_("failed to stat '%s'"), pathname);
d95432d7 428) die_errno(_("failed to start iterator over '%s'"), src->buf);
d95432d7 466) strbuf_setlen(src, src_len);
d95432d7 467) die(_("failed to iterate over '%s'"), src->buf);

builtin/env--helper.c
b4f207f3 23) die(_("unrecognized --type argument, %s"), arg);
b4f207f3 67) default_int = 0;
b4f207f3 82) default_ulong = 0;
b4f207f3 90) BUG("unknown <type> value");

builtin/fetch-pack.c

builtin/pack-objects.c
820a5361 859) BUG("configured exclusion wasn't configured");
820a5361 2794) die(_("value of uploadpack.blobpackfileuri must be "
820a5361 2797) die(_("object already configured in another "

builtin/remote.c
f39a9c65 1551) die(_("--save-to-push cannot be used with other options"));
f39a9c65 1575) die(_("--save-to-push can only be used when only one url is defined"));

builtin/rev-list.c
9b93d269 476) die(

config.c
2e43cd4c 998)     value, name, cf->name, _(error_type));
2e43cd4c 1007)     value, name, cf->name, _(error_type));
2e43cd4c 1010)     value, name, cf->name, _(error_type));
2e43cd4c 1013)     value, name, cf->name, _(error_type));

dir-iterator.c
50e85c40 92) warning_errno("error closing directory '%s'",
655af733 126) warning_errno("failed to stat '%s'", iter->base.path.buf);
655af733 159) goto error_out;
50e85c40 174) warning_errno("error reading directory '%s'",
655af733 176) if (iter->flags & DIR_ITERATOR_PEDANTIC)
655af733 177) goto error_out;
655af733 188) if (errno != ENOENT && iter->flags & DIR_ITERATOR_PEDANTIC)
655af733 189) goto error_out;
c40f077a 216) int saved_errno = errno;
c40f077a 218) errno = saved_errno;
c40f077a 219) warning_errno("error closing directory '%s'",

fast-import.c
35d7cdbe 2565) char *buf = read_object_with_reference(the_repository,
35d7cdbe 2566)        &n->oid,

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
3d908bb8 2304) target ? hash_to_hex(target->hash) : base_url,

list-objects-filter-options.c
d3d10e56 44) BUG("filter_options already populated");
d3d10e56 236) die(_("multiple filter-specs cannot be combined"));
9b93d269 286) BUG("no filter_spec available for this filter");
1e43301f 321) return;

list-objects-filter.c
1e43301f 583) BUG("expected oidset to be cleared already");

list-objects.c
aa36553a 210) ctx->show_object(obj, base->buf, ctx->show_data);

match-trees.c
3fe87a7f 294) if (get_tree_entry(r, hash2, del_prefix, shifted, &mode))

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

repo-settings.c
0a01e977 13) int rate = git_config_int(key, value);
0a01e977 14) if (rate >= 3) {
0a01e977 15) UPDATE_DEFAULT(rs->core_commit_graph, 1);
0a01e977 16) UPDATE_DEFAULT(rs->gc_write_commit_graph, 1);
c5c84f32 17) UPDATE_DEFAULT(rs->index_version, 4);
3172404b 19) if (rate >= 5) {
3172404b 20) UPDATE_DEFAULT(rs->pack_use_sparse, 1);
0a01e977 22) return 0;

strbuf.c
fb819691 818) strbuf_addf(buf, "%u.%2.2u ",
fb819691 822) strbuf_addstr(buf, _("GiB"));

t/helper/test-dir-iterator.c
655af733 24) die("invalid option '%s'", *argv);
655af733 28) die("dir-iterator needs exactly one non-option argument");
9bd70db7 46) printf("[?] ");

t/helper/test-match-trees.c
3fe87a7f 23) shift_tree(the_repository, &one->object.oid, &two->object.oid, &shifted, -1);

upload-pack.c
a8d662e3 130) return readsz;
820a5361 149) BUG("packfile_uris requires sideband-all");
9b93d269 221) sq_quote_buf(&buf, spec);
a8d662e3 354) send_client_data(1, output_state.buffer, output_state.used);
820a5361 1387) string_list_clear(&data->uri_protocols, 0);

wrapper.c

Commits introducting uncovered code:
Ævar Arnfjörð Bjarmason	b4f207f3 env--helper: new undocumented builtin wrapping git_env_*()
Ævar Arnfjörð Bjarmason	2e43cd4c config.c: refactor die_bad_number() to not call gettext() early
Christian Couder	fa3d1b63 promisor-remote: parse remote.*.partialclonefilter
Christian Couder	faf2abf4 promisor-remote: use repository_format_partial_clone
Christian Couder	4ca9474e Move core_partial_clone_filter_default to promisor-remote.c
Christian Couder	db27dca5 Remove fetch-object.{c,h} in favor of promisor-remote.{c,h}
Christian Couder	48de3158 Add initial support for many promisor remotes
Christian Couder	9e27beaa promisor-remote: implement promisor_remote_get_direct()
Christian Couder	b14ed5ad Use promisor_remote_get_direct() and has_promisor_remote()
Daniel Ferreira	9bd70db7 dir-iterator: add tests for dir-iterator API
Denton Liu	f39a9c65 remote: add --save-to-push option to git remote set-url
Derrick Stolee	0a01e977 repo-settings: create core.featureAdoptionRate setting
Derrick Stolee	c5c84f32 repo-settings: use index.version=4 by default
Derrick Stolee	3172404b repo-settings: pack.useSparse=true
Dimitriy Ryazantcev	fb819691 l10n: localizable upload progress messages
Jonathan Tan	820a5361 upload-pack: send part of packfile response as uri
Jonathan Tan	a8d662e3 upload-pack: refactor reading of pack-objects out
Junio C Hamano	3d908bb8 Merge branch 'jt/fetch-cdn-offload' into pu
Matheus Tavares	655af733 dir-iterator: add flags parameter to dir_iterator_begin
Matheus Tavares	50e85c40 dir-iterator: refactor state machine model
Matheus Tavares	d95432d7 clone: use dir-iterator to avoid explicit dir traversal
Matheus Tavares	fbb4a33c clone: extract function from copy_or_link_directory
Matheus Tavares	c40f077a dir-iterator: use warning_errno when possible
Matthew DeVore	aa36553a list-objects-filter: make API easier to use
Matthew DeVore	1e43301f list-objects-filter: implement composite filters
Matthew DeVore	d3d10e56 list-objects-filter-options: move error check up
Matthew DeVore	9b93d269 list-objects-filter-options: make filter_spec a string_list
Nguyễn Thái Ngọc Duy	35d7cdbe sha1-file.c: remove the_repo from read_object_with_reference()
Nguyễn Thái Ngọc Duy	3fe87a7f match-trees.c: remove the_repo from shift_tree*()
Nguyễn Thái Ngọc Duy	47f956bd tree-walk.c: remove the_repo from get_tree_entry()


Uncovered code in 'jch' not in 'next'
--------------------------------------------------------

blame.c
1fc73384 990) return;
a07a9776 1599) continue;
ae3f36de 2417) continue;

builtin/blame.c

builtin/checkout.c
d16dc428 1345) warning(_("you are switching branch while bisecting"));
3ec37ad1 1370) die(_("'%s' cannot be used with '%s'"), "--discard-changes", "--merge");
c9c935f6 1508) BUG("make up your mind, you need to take _something_");
183fb44f 1540) opts->checkout_index = 0;
183fb44f 1550) BUG("these flags should be non-negative by now");
c9c935f6 1611) die(_("could not resolve %s"), opts->from_treeish);

builtin/commit-graph.c
c2bc6e6a 203) return 1;

builtin/fetch.c
cdbd70c4 88) fetch_show_forced_updates = git_config_bool(k, v);
cdbd70c4 89) return 0;
377444b4 1011) warning(_("It took %.2f seconds to check forced updates. You can use '--no-show-forced-updates'\n"),
377444b4 1013) warning(_("or run 'git config fetch.showForcedUpdates false' to avoid this check.\n"));

builtin/ls-files.c
272b3f2a 672) die(_("--debug-json cannot be used with other file selection options"));
272b3f2a 674) die(_("--debug-json cannot be used with %s"), "--resolve-undo");
272b3f2a 676) die(_("--debug-json cannot be used with %s"), "--with-tree");
272b3f2a 678) die(_("--debug-json cannot be used with %s"), "--debug");
272b3f2a 701) die("index file corrupt");

builtin/multi-pack-index.c

builtin/pull.c
3883c551 556) argv_array_push(&args, "--show-forced-updates");
3883c551 558) argv_array_push(&args, "--no-show-forced-updates");

builtin/rebase.c
d559f502 759) ret = error(_("could not remove '%s'"),
526c03b5 1272) goto done;
10572de1 1288) goto done;
d559f502 1675) error(_("could not remove '%s'"),

cache-tree.c
fd335a21 605) ret = NULL; /* not the whole tree */

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

config.c
07b2c0ea 283) return 0;

delta-islands.c
bdbdf42f 467) fprintf(stderr, _("Marked %d islands, done.\n"), island_counter);

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

fetch-pack.c
5a88583b 914) else if (args->depth > 0 || is_repository_shallow(the_repository))
0778b293 928) print_verbose(args, _("Server supports %s"), "multi_ack");
0778b293 936) print_verbose(args, _("Server supports %s"), "side-band");
5a88583b 974) } else if (args->deepen_since)
5a88583b 979) } else if (args->deepen_not)
5a88583b 983) else if (args->deepen_relative)

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

oidmap.c
0a66ac47 42) hashmap_entry_init(&entry, oidhash(key));

oidset.c

pack-bitmap-write.c
05805d74 378) static struct ewah_bitmap *find_reused_bitmap(const struct object_id *oid)
d2bc62b1 385) hash_pos = kh_get_oid_map(writer.reused, *oid);
05805d74 425) reused_bitmap = find_reused_bitmap(&chosen->object.oid);
05805d74 432) reused_bitmap = find_reused_bitmap(&cm->object.oid);

packfile.c
8434e85d 372) strbuf_release(&buf);
8434e85d 373) return;

pager.c
cd1096b2 197) fputs("\r\033[K", stderr);

progress.c
fbe464c0 121) fprintf(stderr, "  %s%s", counters_sb->buf,
fbe464c0 127) fprintf(stderr, "%s:\n  %s%s",

read-cache.c
8eeabe15 1752) ret = error(_("index uses %.4s extension, which we do not understand"),
ee70c128 1754) if (advice_unknown_index_extension) {
ee70c128 1755) warning(_("ignoring optional %.4s index extension"), ext);
ee70c128 1756) advise(_("This is likely due to the file having been written by a newer\n"
272b3f2a 2026) jw_object_true(jw, "assume_unchanged");
272b3f2a 2030) jw_object_true(jw, "skip_worktree");
272b3f2a 2032) jw_object_intmax(jw, "stage", ce_stage(ce));
f0f544da 2309) ieot = read_ieot_extension(istate, mmap, mmap_size, extension_offset);
f0f544da 3651) static struct index_entry_offset_table *read_ieot_extension(
f0f544da 3673) return do_read_ieot_extension(istate, index, extsize);

ref-filter.c
28438e84 1500) strbuf_addstr(&desc, _("no branch"));

sequencer.c
37e9ee5c 293) ret = -1;
37e9ee5c 311) ret = error(_("could not remove '%s'"), buf.buf);
30652115 2198)  (*bol == ' ' || *bol == '\t'))
30652115 2201) ret = -1;
516dc810 2668) in_progress_error = _("revert is already in progress");
516dc810 2669) in_progress_advice =
516dc810 2671) break;
516dc810 2678) BUG("unexpected action in create_seq_dir");
3fa2e2d8 2777) return error(_("cannot resolve HEAD"));
3fa2e2d8 2860) if (!rollback_is_safe())
3fa2e2d8 2861) goto give_advice;
3fa2e2d8 2873) BUG("unexpected action in sequencer_skip");
3fa2e2d8 2877) return error(_("failed to skip the commit"));

split-index.c
1f825794 29) goto done;

t/helper/test-example-decorate.c
0ebbcf70 29) one = lookup_unknown_object(&one_oid);
0ebbcf70 30) two = lookup_unknown_object(&two_oid);
0ebbcf70 59) three = lookup_unknown_object(&three_oid);

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

upload-pack.c
62b89d43 534) if (parse_oid_hex(namebuf, &oid, &p) || *p != '\n')
d0229abd 537) o = lookup_object(the_repository, &oid);

wt-status.c
0a53561a 1114) strbuf_addf(&sb, _("\n"

Commits introducting uncovered code:
Barret Rhoden	1fc73384 blame: optionally track line fingerprints during fill_blame_origin()
Barret Rhoden	ae3f36de blame: add the ability to ignore commits and their changes
Barret Rhoden	a07a9776 blame: use the fingerprint heuristic to match ignored lines
Christian Couder	11510dec t/helper: add test-oidmap.c
Denton Liu	07b2c0ea config: learn the "onbranch:" includeIf condition
Denton Liu	526c03b5 rebase: refactor can_fast_forward into goto tower
Denton Liu	10572de1 rebase: fast-forward --onto in more cases
Derrick Stolee	ce1e4a10 midx: implement midx_repack()
Derrick Stolee	8434e85d repack: refactor pack deletion for future use
Derrick Stolee	d01bf2e6 midx: refactor permutation logic and pack sorting
Derrick Stolee	1771be90 commit-graph: merge commit-graph chains
Derrick Stolee	c523035c commit-graph: allow cross-alternate chains
Derrick Stolee	135a7123 commit-graph: add --split option to builtin
Derrick Stolee	6c622f9f commit-graph: write commit-graph chains
Derrick Stolee	d4f4d60f commit-graph: prepare for commit-graph chains
Derrick Stolee	19575c7c multi-pack-index: implement 'expire' subcommand
Derrick Stolee	118bd570 commit-graph: add base graphs chunk
Derrick Stolee	3883c551 pull: add --[no-]show-forced-updates passthrough
Derrick Stolee	377444b4 fetch: warn about forced updates in branch listing
Derrick Stolee	5c84b339 commit-graph: load commit-graph chains
Derrick Stolee	cdbd70c4 fetch: add --[no-]show-forced-updates argument
Derrick Stolee	c2bc6e6a commit-graph: create options for split files
Jeff Hostetler	0a53561a status: warn when a/b calculation takes too long
Jeff King	d0229abd object: convert lookup_object() to use object_id
Jeff King	62b89d43 upload-pack: rename a "sha1" variable to "oid"
Jeff King	bdbdf42f delta-islands: respect progress flag
Jeff King	0ebbcf70 object: convert lookup_unknown_object() to use object_id
Jeff King	d2bc62b1 pack-bitmap: convert khash_sha1 maps into kh_oid_map
Jeff King	05805d74 pack-bitmap-write: convert some helpers to use object_id
Johannes Schindelin	08e04506 kwset: allow building with GCC 8
Jonathan Nieder	ee70c128 index: offer advice for unknown index extensions
Junio C Hamano	0a66ac47 Merge branch 'cc/test-oidmap' into jch
Matthew DeVore	28438e84 ref-filter: sort detached HEAD lines firstly
Nguyễn Thái Ngọc Duy	183fb44f restore: add --worktree and --staged
Nguyễn Thái Ngọc Duy	fd335a21 cache-tree.c: dump "TREE" extension as json
Nguyễn Thái Ngọc Duy	272b3f2a ls-files: add --json to dump the index
Nguyễn Thái Ngọc Duy	3ec37ad1 switch: add --discard-changes
Nguyễn Thái Ngọc Duy	3b2385cf dir.c: dump "UNTR" extension as json
Nguyễn Thái Ngọc Duy	1f825794 split-index.c: dump "link" extension as json
Nguyễn Thái Ngọc Duy	f0f544da read-cache.c: dump "IEOT" extension as json
Nguyễn Thái Ngọc Duy	5a88583b fetch-pack: print all relevant supported capabilities with -v -v
Nguyễn Thái Ngọc Duy	8eeabe15 read-cache.c: dump common extension info in json
Nguyễn Thái Ngọc Duy	c9c935f6 restore: take tree-ish from --source option instead
Nguyễn Thái Ngọc Duy	0778b293 fetch-pack: move capability names out of i18n strings
Nguyễn Thái Ngọc Duy	d16dc428 switch: allow to switch in the middle of bisect
Phillip Wood	30652115 status: do not report errors in sequencer/todo
Phillip Wood	d559f502 rebase --abort/--quit: cleanup refs/rewritten
Phillip Wood	37e9ee5c sequencer: return errors from sequencer_remove_state()
Rohit Ashiwal	516dc810 sequencer: add advice for revert
Rohit Ashiwal	3fa2e2d8 cherry-pick/revert: add --skip option
SZEDER Gábor	fbe464c0 progress: use term_clear_line()
SZEDER Gábor	cd1096b2 pager: add a helper function to clear the last line in the terminal


Uncovered code in 'next' not in 'master'
--------------------------------------------------------

builtin/branch.c
1fde99cf 841) die(_("The -a, and -r, options to 'git branch' do not take a branch name.\n"

builtin/commit.c

builtin/gc.c
e103f727 691) return 1;

commit-graph.c
ef5b83f2 906) error(_("error opening index for %s"), packname.buf);
ef5b83f2 907) return -1;
4c9efe85 946) continue;
b2c83060 969) display_progress(ctx->progress, ctx->approx_nr_objects);
238def57 1039) error(_("unable to create leading directories of %s"),
238def57 1041) return -1;
e103f727 1158) error(_("the commit graph format cannot write %d commits"), count_distinct);
e103f727 1159) res = -1;
e103f727 1160) goto cleanup;
e103f727 1169) error(_("too many commits to write graph"));
e103f727 1170) res = -1;
e103f727 1171) goto cleanup;

name-hash.c
568a05c5 348) assert(begin >= 0);
568a05c5 350) int mid = begin + ((end - begin) >> 1);

packfile.c
921d49be 1275) COPY_ARRAY(poi_stack, small_poi_stack, poi_stack_nr);
921d49be 1685) COPY_ARRAY(delta_stack, small_delta_stack,

ref-filter.c
2582083f 93) keydata_aka_refname ? keydata_aka_refname : k->wt->head_ref);

sh-i18n--envsubst.c
568a05c5 252)   size_t j = j1 + ((j2 - j1) >> 1);

Commits introducting uncovered code:
Derrick Stolee	e103f727 commit-graph: return with errors during write
Derrick Stolee	ef5b83f2 commit-graph: extract fill_oids_from_packs()
Derrick Stolee	4c9efe85 commit-graph: extract fill_oids_from_commit_hex()
Derrick Stolee	b2c83060 commit-graph: extract fill_oids_from_all_packs()
Derrick Stolee	238def57 commit-graph: extract write_commit_graph_file()
Nickolai Belakovski	2582083f ref-filter: add worktreepath atom
Philip Oakley	1fde99cf doc branch: provide examples for listing remote tracking branches
René Scharfe	568a05c5 cleanup: fix possible overflow errors in binary search, part 2
René Scharfe	921d49be use COPY_ARRAY for copying arrays


Uncovered code in 'master' not in 'master@{1}'
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
Matthew DeVore	5c03bc8b list-objects-filter-options: error is localizeable
Nguyễn Thái Ngọc Duy	f3f8311e merge: add --quit
Nguyễn Thái Ngọc Duy	1de16aec worktree add: sanitize worktree names

