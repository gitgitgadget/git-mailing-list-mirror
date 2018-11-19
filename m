Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B23A71F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 02:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeKSNRN (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 08:17:13 -0500
Received: from mail-yw1-f46.google.com ([209.85.161.46]:44170 "EHLO
        mail-yw1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbeKSNRN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 08:17:13 -0500
Received: by mail-yw1-f46.google.com with SMTP id k6-v6so12356019ywa.11
        for <git@vger.kernel.org>; Sun, 18 Nov 2018 18:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=JCiWluVNer8R1Jcb6JIm7E9Z8SUQogJ+/OjkCqqvtr8=;
        b=pR6xjo8V6yQ/Xc4QBt81UNn6pS3WuZw23XxwhRaFyzsBgTEgMepXiA/qHImcH6Uy82
         BW2Cx9UeIRcEfkEVOyw9y8+BOznyiInkNdUloXEXgU145Ce+sWGNKAEz2U/MWcjDaKL7
         Xvmlg7BNIRsZ2ivsuEoaO1jC3vhMzrKgll94wjfkqc/O0id0YjHVSFXyBdjMmCXRPKYO
         LWuWE6MZSvEMosHEsNvW/yx9V4S7KFCj9LoRmJCB/iXcBaQEEnaefw4Te+dnAr2WG7cd
         O5qDBcuiNm7H+AUCIieQlRDf2jyz2+z2ekcb3OjSgEhq2yI3keKNkkNRARjBTlWkOccI
         /G8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=JCiWluVNer8R1Jcb6JIm7E9Z8SUQogJ+/OjkCqqvtr8=;
        b=OjMT4Z5i5ICs/0LAg0OT9A2ZcI82jv/PFWUscC4zyiNU4p7wuAvLc6O9yC46cWoyjO
         wJKr0PnXydCnmjAUlFCRXNjt9fmmaJ5cgU17xNT4RKiw8PJDLb0I/BtEPAbFL2ELsFEC
         NgjW595XW+XJpAcPWY2A793GnQrgTwbK5HDhyLFE8zTMc65t08JbYlO/4Q4vU2O74YmI
         O2ALdIMm7kNvviji8tTtvkowIu4esY2fQN9ZLpKJnimYTZ/2I/lgVQ4BnGCBRQmeAtTq
         kw1i3DtZJrcwTRSNbMxUysDI7rAAjs0YhuoBLG8F+y9iZOnSJdlu7OzIj18X6/6RFoUN
         ELjw==
X-Gm-Message-State: AGRZ1gIv1/H2nfcgx8j0aDNXYcTy1pwZhQtyS6/HCdmQRTqruOJAnHTw
        5sx5We4jOhBKMu/kjPGTo4F4iRoZ
X-Google-Smtp-Source: AJdET5fYR8MoUpCwB1IjFQzPSe0b2y3SGYoEmRTNqm6n5FyCRjVv10p8bzFdHmo7rLxv4U52mTsBww==
X-Received: by 2002:a81:20d4:: with SMTP id g203mr2406891ywg.142.1542596098671;
        Sun, 18 Nov 2018 18:54:58 -0800 (PST)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id u65-v6sm1128953ywd.79.2018.11.18.18.54.57
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 18:54:58 -0800 (PST)
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (v2.20.0-rc0)
Message-ID: <9e293b1b-1845-1772-409b-031c0bf4d17b@gmail.com>
Date:   Sun, 18 Nov 2018 21:54:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a test coverage report for the uncovered lines introduced in 
v2.20.0-rc0 compared to v2.19.1.

Thanks,

-Stolee

[1] https://dev.azure.com/git/git/_build/results?buildId=263&view=logs

---


apply.c
eccb5a5f3d 4071) return get_oid_hex(p->old_oid_prefix, oid);
517fe807d6 4776) BUG_ON_OPT_NEG(unset);
735ca208c5 4830) return -1;

blame.c
a470beea39  113)  !strcmp(r->index->cache[-1 - pos]->name, path))
a470beea39  272) int pos = index_name_pos(r->index, path, len);
a470beea39  274) mode = r->index->cache[pos]->ce_mode;

builtin/add.c
d1664e73ad builtin/add.c 458) die(_("index file corrupt"));

builtin/am.c
2abf350385 1362) repo_init_revisions(the_repository, &rev_info, NULL);
fce5664805 2117) *opt_value = PATCH_FORMAT_UNKNOWN;

builtin/blame.c
517fe807d6 builtin/blame.c    759) BUG_ON_OPT_NEG(unset);

builtin/cat-file.c
98f425b453 builtin/cat-file.c  56) die("unable to stream %s to stdout", 
oid_to_hex(oid));
0eb8d3767c builtin/cat-file.c 609) return error(_("only one batch option 
may be specified"));

builtin/checkout.c
fa655d8411 builtin/checkout.c  539) return 0;
fa655d8411 builtin/checkout.c  953) return error(_("index file corrupt"));

builtin/difftool.c
4a7e27e957 441) if (oideq(&loid, &roid))

builtin/fast-export.c
4a7e27e957 builtin/fast-export.c  387) if (oideq(&ospec->oid, &spec->oid) &&

builtin/fetch.c
builtin/fsck.c
b29759d89a builtin/fsck.c 613) fprintf(stderr, "Checking %s link\n", 
head_ref_name);
b29759d89a builtin/fsck.c 618) return error("Invalid %s", head_ref_name);
454ea2e4d7 builtin/fsck.c 769) for (p = get_all_packs(the_repository); p;
66ec0390e7 builtin/fsck.c 888) midx_argv[2] = "--object-dir";
66ec0390e7 builtin/fsck.c 889) midx_argv[3] = alt->path;
66ec0390e7 builtin/fsck.c 890) if (run_command(&midx_verify))
66ec0390e7 builtin/fsck.c 891) errors_found |= ERROR_COMMIT_GRAPH;

builtin/gc.c
3029970275 builtin/gc.c 461) ret = error_errno(_("cannot stat '%s'"), 
gc_log_path);
3029970275 builtin/gc.c 470) ret = error_errno(_("cannot read '%s'"), 
gc_log_path);
fec2ed2187 builtin/gc.c 495) die(FAILED_RUN, pack_refs_cmd.argv[0]);
fec2ed2187 builtin/gc.c 498) die(FAILED_RUN, reflog.argv[0]);
3029970275 builtin/gc.c 585) exit(128);
fec2ed2187 builtin/gc.c 637) die(FAILED_RUN, repack.argv[0]);
fec2ed2187 builtin/gc.c 647) die(FAILED_RUN, prune.argv[0]);
fec2ed2187 builtin/gc.c 654) die(FAILED_RUN, prune_worktrees.argv[0]);
fec2ed2187 builtin/gc.c 658) die(FAILED_RUN, rerere.argv[0]);

builtin/grep.c
76e9bdc437 builtin/grep.c  424) grep_read_unlock();
fd6263fb73 builtin/grep.c 1051) warning(_("invalid option combination, 
ignoring --threads"));
fd6263fb73 builtin/grep.c 1057) die(_("invalid number of threads 
specified (%d)"), num_threads);

builtin/help.c
e6e76baaf4 builtin/help.c 429) if (!exclude_guides || alias[0] == '!') {
e6e76baaf4 builtin/help.c 430) printf_ln(_("'%s' is aliased to '%s'"), 
cmd, alias);
e6e76baaf4 builtin/help.c 431) free(alias);
e6e76baaf4 builtin/help.c 432) exit(0);
e6e76baaf4 builtin/help.c 441) fprintf_ln(stderr, _("'%s' is aliased to 
'%s'"), cmd, alias);
e6e76baaf4 builtin/help.c 442) count = split_cmdline(alias, &argv);
e6e76baaf4 builtin/help.c 443) if (count < 0)
e6e76baaf4 builtin/help.c 444) die(_("bad alias.%s string: %s"), cmd,
e6e76baaf4 builtin/help.c 446) free(argv);
e6e76baaf4 builtin/help.c 448) return alias;

builtin/log.c
517fe807d6 builtin/log.c 1196) BUG_ON_OPT_NEG(unset);
2e6fd71a52 builtin/log.c 1472) die(_("failed to infer range-diff ranges"));
ee6cbf712e builtin/log.c 1818) die(_("--interdiff requires 
--cover-letter or single patch"));
8631bf1cdd builtin/log.c 1828) else if (!rdiff_prev)
8631bf1cdd builtin/log.c 1829) die(_("--creation-factor requires 
--range-diff"));
40ce41604d builtin/log.c 1833) die(_("--range-diff requires 
--cover-letter or single patch"));

builtin/multi-pack-index.c
6d68e6a461 35) usage_with_options(builtin_multi_pack_index_usage,
6d68e6a461 39) die(_("too many arguments"));
6d68e6a461 48) die(_("unrecognized verb: %s"), argv[0]);

builtin/pack-objects.c
6a22d52126 builtin/pack-objects.c 1091) continue;
2fa233a554 builtin/pack-objects.c 1512) hashcpy(base_oid.hash, base_sha1);
2fa233a554 builtin/pack-objects.c 1513) if 
(!in_same_island(&delta->idx.oid, &base_oid))
2fa233a554 builtin/pack-objects.c 1514) return 0;
28b8a73080 builtin/pack-objects.c 2793) depth++;
108f530385 builtin/pack-objects.c 2797) oe_set_tree_depth(&to_pack, ent, 
depth);
454ea2e4d7 builtin/pack-objects.c 2981) p = get_all_packs(the_repository);

builtin/pack-redundant.c
454ea2e4d7 builtin/pack-redundant.c 580) struct packed_git *p = 
get_all_packs(the_repository);
454ea2e4d7 builtin/pack-redundant.c 595) struct packed_git *p = 
get_all_packs(the_repository);

builtin/pull.c
01a31f3bca 565) die(_("unable to access commit %s"),

builtin/rebase--interactive.c
53bbcfbde7 builtin/rebase--interactive2.c  24) return error(_("no HEAD?"));
53bbcfbde7 builtin/rebase--interactive2.c  51) return 
error_errno(_("could not create temporary %s"), path_state_dir());
53bbcfbde7 builtin/rebase--interactive2.c  57) return 
error_errno(_("could not mark as interactive"));
53bbcfbde7 builtin/rebase--interactive2.c  77) return -1;
53bbcfbde7 builtin/rebase--interactive2.c  81) return -1;
53bbcfbde7 builtin/rebase--interactive2.c  87) free(revisions);
53bbcfbde7 builtin/rebase--interactive2.c  88) free(shortrevisions);
53bbcfbde7 builtin/rebase--interactive2.c  90) return -1;
53bbcfbde7 builtin/rebase--interactive2.c  98) free(revisions);
53bbcfbde7 builtin/rebase--interactive2.c  99) free(shortrevisions);
53bbcfbde7 builtin/rebase--interactive2.c 101) return 
error_errno(_("could not open %s"), rebase_path_todo());
53bbcfbde7 builtin/rebase--interactive2.c 106) 
argv_array_push(&make_script_args, restrict_revision);
53bbcfbde7 builtin/rebase--interactive2.c 114) error(_("could not 
generate todo list"));
53bbcfbde7 builtin/rebase--interactive2.c 206) 
usage_with_options(builtin_rebase_interactive_usage, options);
53bbcfbde7 builtin/rebase--interactive2.c 220) 
warning(_("--[no-]rebase-cousins has no effect without "
0af129b2ed builtin/rebase--interactive2.c 226) die(_("a base commit must 
be provided with --upstream or --onto"));
34b47315d9 builtin/rebase--interactive.c  261) ret = rearrange_squash();
34b47315d9 builtin/rebase--interactive.c  262) break;
34b47315d9 builtin/rebase--interactive.c  264) ret = 
sequencer_add_exec_commands(cmd);
34b47315d9 builtin/rebase--interactive.c  265) break;

builtin/rebase.c
62c23938fa   55) return env;
55071ea248   65) strbuf_trim(&out);
55071ea248   66) ret = !strcmp("true", out.buf);
55071ea248   67) strbuf_release(&out);
002ee2fe68  119) die(_("%s requires an interactive rebase"), option);
f95736288a  152) return error_errno(_("could not read '%s'"), path);
f95736288a  166) return -1;
f95736288a  171) return error(_("could not get 'onto': '%s'"), buf.buf);
f95736288a  182) return -1;
f95736288a  183) } else if (read_one(state_dir_path("head", opts), &buf))
f95736288a  184) return -1;
f95736288a  186) return error(_("invalid orig-head: '%s'"), buf.buf);
f95736288a  190) return -1;
f95736288a  192) opts->flags &= ~REBASE_NO_QUIET;
73d51ed0a5  200) opts->signoff = 1;
73d51ed0a5  201) opts->flags |= REBASE_FORCE;
ead98c111b  208) return -1;
12026a412c  223) return -1;
ba1905a5fe  231) return -1;
ba1905a5fe  239) return -1;
6defce2b02  259) return error(_("Could not read '%s'"), path);
6defce2b02  277) res = error(_("Cannot store %s"), autostash.buf);
6defce2b02  281) return res;
bc24382c2b  379) argv_array_pushf(&child.args,
bc24382c2b  381) oid_to_hex(&opts->restrict_revision->object.oid));
ac7f467fef  515) struct strbuf dir = STRBUF_INIT;
6defce2b02  517) apply_autostash(opts);
ac7f467fef  518) strbuf_addstr(&dir, opts->state_dir);
ac7f467fef  519) remove_dir_recursively(&dir, 0);
ac7f467fef  520) strbuf_release(&dir);
ac7f467fef  521) die("Nothing to do");
3249c1251e  556) ret = -1;
3249c1251e  557) goto leave_reset_head;
bac2a1e36f  561) ret = error(_("could not determine HEAD revision"));
bac2a1e36f  562) goto leave_reset_head;
3249c1251e  580) ret = error(_("could not read index"));
3249c1251e  581) goto leave_reset_head;
bac2a1e36f  585) ret = error(_("failed to find tree of %s"), 
oid_to_hex(oid));
bac2a1e36f  586) goto leave_reset_head;
3249c1251e  590) ret = error(_("failed to find tree of %s"), 
oid_to_hex(oid));
3249c1251e  591) goto leave_reset_head;
ac7f467fef  603) ret = error(_("could not write index"));
3249c1251e  604) goto leave_reset_head;
ac7f467fef  621) } else if (old_orig)
ac7f467fef  622) delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
bff014dac7  655) opts->flags &= !REBASE_DIFFSTAT;
9a48a615b4  689) return 1;
9a48a615b4  705) return 0;
55071ea248  916) const char *path = mkpath("%s/git-legacy-rebase",
55071ea248  919) if (sane_execvp(path, (char **)argv) < 0)
55071ea248  920) die_errno(_("could not exec %s"), path);
0eabf4b95c  938) die(_("It looks like 'git am' is in progress. Cannot 
rebase."));
f28d40d3a9  975) usage_with_options(builtin_rebase_usage,
f95736288a  995) die(_("Cannot read HEAD"));
f95736288a  999) die(_("could not read index"));
f95736288a 1013) exit(1);
122420c295 1026) die(_("could not discard worktree changes"));
122420c295 1029) exit(1);
5e5d96197c 1040) exit(1);
5e5d96197c 1044) die(_("could not move back to %s"),
5a61494539 1055) die(_("could not remove '%s'"), options.state_dir);
c54dacb50e 1074) const char *last_slash = strrchr(options.state_dir, '/');
c54dacb50e 1075) const char *state_dir_base =
c54dacb50e 1076) last_slash ? last_slash + 1 : options.state_dir;
c54dacb50e 1077) const char *cmd_live_rebase =
c54dacb50e 1079) strbuf_reset(&buf);
c54dacb50e 1080) strbuf_addf(&buf, "rm -fr \"%s\"", options.state_dir);
c54dacb50e 1081) die(_("It seems that there is already a %s directory, 
and\n"
3c3588c7d3 1138) else if (strcmp("no-rebase-cousins", rebase_merges))
3c3588c7d3 1139) die(_("Unknown mode: %s"), rebase_merges);
ba1905a5fe 1161) die(_("--strategy requires --merge or --interactive"));
cda614e489 1179) strbuf_addstr(&options.git_format_patch_opt, " 
--progress");
ac7f467fef 1188) options.state_dir = apply_dir();
ac7f467fef 1189) break;
ac7f467fef 1261) die(_("invalid upstream '%s'"), options.upstream_name);
9dba809a69 1267) die(_("Could not create new root commit"));
e65123a71d 1317) die(_("fatal: no such branch/commit '%s'"),
ac7f467fef 1325) die(_("No such ref: %s"), "HEAD");
ac7f467fef 1337) die(_("Could not resolve HEAD to a revision"));
e0333e5c63 1350) die(_("could not read index"));
6defce2b02 1377) die(_("Cannot autostash"));
6defce2b02 1380) die(_("Unexpected stash response: '%s'"),
6defce2b02 1386) die(_("Could not create directory for '%s'"),
6defce2b02 1392) die(_("could not reset --hard"));
e65123a71d 1436) ret = !!error(_("could not parse '%s'"),
e65123a71d 1438) goto cleanup;
e65123a71d 1447) ret = !!error(_("could not switch to "
1ed9c14ff2 1457)  resolve_ref_unsafe("HEAD", 0, NULL, &flag))
1ed9c14ff2 1458) puts(_("HEAD is up to date."));
9a48a615b4 1467)  resolve_ref_unsafe("HEAD", 0, NULL, &flag))
9a48a615b4 1468) puts(_("HEAD is up to date, rebase forced."));

builtin/reflog.c
c9ef0d95eb builtin/reflog.c 580) all_worktrees = 0;
c9ef0d95eb builtin/reflog.c 616) continue;

builtin/remote.c
5025425dff builtin/remote.c  864) return error(_("No such remote: 
'%s'"), name);

builtin/repack.c
16d75fa48d  48) use_delta_islands = git_config_bool(var, value);
16d75fa48d  49) return 0;
2f0c9e9a9b 239) die("repack: Expecting full hex object ID lines only 
from pack-objects.");
2f0c9e9a9b 411) die("repack: Expecting full hex object ID lines only 
from pack-objects.");

builtin/rerere.c
2373b65059 builtin/rerere.c  79) warning(_("'git rerere forget' without 
paths is deprecated"));
2373b65059 builtin/rerere.c 111) die(_("unable to generate diff for 
'%s'"), rerere_path(id, NULL));

builtin/rev-list.c
7c0fe330d5 builtin/rev-list.c 227) die("unexpected missing %s object '%s'",
7c0fe330d5 builtin/rev-list.c 228)     type_name(obj->type), 
oid_to_hex(&obj->oid));

builtin/show-branch.c
9001dc2a74 builtin/show-branch.c 430) if (get_oid(refname + ofs, &tmp) 
|| !oideq(&tmp, oid))
517fe807d6 builtin/show-branch.c 607) BUG_ON_OPT_NEG(unset);

builtin/show-ref.c
517fe807d6 builtin/show-ref.c 154) BUG_ON_OPT_NEG(unset);

builtin/submodule--helper.c
ee69b2a90c 1469) die(_("Invalid update mode '%s' for submodule path '%s'"),
ee69b2a90c 1473) die(_("Invalid update mode '%s' configured for 
submodule path '%s'"),
ee69b2a90c 1476) out->type = sub->update_strategy.type;
ee69b2a90c 1477) out->command = sub->update_strategy.command;
ee69b2a90c 1497) die("submodule--helper update-module-clone expects 
<just-cloned> <path> [<update>]");
e0a862fdaf 1648) url = sub->url;
74d4731da1 2057) die(_("could not get a repository handle for submodule 
'%s'"), path);

builtin/unpack-objects.c
4a7e27e957 builtin/unpack-objects.c 306) if (oideq(&info->base_oid, 
&obj_list[nr].oid) ||

builtin/update-index.c
4a7e27e957 builtin/update-index.c  672) if (oideq(&ce_2->oid, &ce_3->oid) &&

builtin/worktree.c
e5353bef55  60) error_errno(_("failed to delete '%s'"), sb.buf);
e19831c94f 251)     die(_("unable to re-add worktree '%s'"), path);
68a6b3a1bd 793) die(_("cannot move a locked working tree, lock reason: 
%s\nuse 'move -f -f' to override or unlock first"),
f4143101cb 906) die(_("cannot remove a locked working tree, lock reason: 
%s\nuse 'remove -f -f' to override or unlock first"),

bundle.c
2c8ee1f53c 267) error_errno(_("unable to dup bundle descriptor"));
2c8ee1f53c 268) child_process_clear(&pack_objects);
2c8ee1f53c 269) return -1;
2c8ee1f53c 478) rollback_lock_file(&lock);

cache-tree.c
combine-diff.c
0074c9110d  377) state->sline[state->nb-1].p_lno =
0074c9110d  378) xcalloc(state->num_parent, sizeof(unsigned long));

commit-graph.c
20fd6d5799   79) return 0;
6cc017431c  275) return 0;

commit-reach.c
5227c38566 134) return ret;
5227c38566 282) return 1;
5227c38566 314) return ret;
5227c38566 317) return ret;
1d614d41e5 395) return 0;
1d614d41e5 401) return 0;
1d614d41e5 405) return 0;
4fbcca4eff 538) return 1;
b67f6b26e3 559) continue;
b67f6b26e3 570) from->objects[i].item->flags |= assign_flag;
b67f6b26e3 571) continue;
b67f6b26e3 577) result = 0;
b67f6b26e3 578) goto cleanup;

config.c
c780b9cfe8 2303) return val;
c780b9cfe8 2306) if (is_bool)
c780b9cfe8 2307) return val ? 0 : 1;
c780b9cfe8 2309) return val;

date.c
c27cc94fad  904) tm->tm_mon = number-1;
c27cc94fad  908) else if (number > 69 && number < 100)
c27cc94fad  909) tm->tm_year = number;
c27cc94fad  910) else if (number < 38)
c27cc94fad  911) tm->tm_year = 100 + number;
c27cc94fad  952) pending_number(tm, num);

delta-islands.c
c8d521faf7  53) memcpy(b, old, size);
c8d521faf7  73) return 1;
c8d521faf7 118) return 0;
c8d521faf7 130) return 0;
c8d521faf7 187) b->refcount--;
c8d521faf7 188) b = kh_value(island_marks, pos) = island_bitmap_new(b);
c8d521faf7 202) continue;
c8d521faf7 212) obj = ((struct tag *)obj)->tagged;
c8d521faf7 213) if (obj) {
c8d521faf7 214) parse_object(the_repository, &obj->oid);
c8d521faf7 215) marks = create_or_get_island_marks(obj);
c8d521faf7 216) island_bitmap_set(marks, island_counter);
c8d521faf7 248) return;
c8d521faf7 268) progress_state = start_progress(_("Propagating island 
marks"), nr);
c8d521faf7 286) die(_("bad tree object %s"), oid_to_hex(&ent->idx.oid));
c8d521faf7 293) continue;
c8d521faf7 297) continue;
c8d521faf7 321) return config_error_nonbool(k);
c8d521faf7 330) die(_("failed to load island regex for '%s': %s"), k, 
re.buf);
c8d521faf7 386) warning(_("island regex from config has "
c8d521faf7 397) strbuf_addch(&island_name, '-');
c8d521faf7 433) continue;
c8d521faf7 436) list[dst] = list[src];

diff-lib.c
9001dc2a74 diff-lib.c 346)     (!oideq(oid, &old_entry->oid) || 
!oideq(&old_entry->oid, &new_entry->oid))) {

diff.c
b78ea5fc35 4130) add_external_diff_name(o->repo, &argv, other, two);

dir.c
8a2c174677  287) name = to_free = xmemdupz(name, namelen);
c46c406ae1 2282) trace_performance_leave("read directory %.*s", len, path);

entry.c
b878579ae7 402) static void mark_colliding_entries(const struct checkout 
*state,
b878579ae7 405) int i, trust_ino = check_stat;
b878579ae7 411) ce->ce_flags |= CE_MATCHED;
b878579ae7 413) for (i = 0; i < state->istate->cache_nr; i++) {
b878579ae7 414) struct cache_entry *dup = state->istate->cache[i];
b878579ae7 416) if (dup == ce)
b878579ae7 417) break;
b878579ae7 419) if (dup->ce_flags & (CE_MATCHED | CE_VALID | 
CE_SKIP_WORKTREE))
b878579ae7 420) continue;
b878579ae7 422) if ((trust_ino && dup->ce_stat_data.sd_ino == st->st_ino) ||
b878579ae7 423)     (!trust_ino && !fspathcmp(ce->name, dup->name))) {
b878579ae7 424) dup->ce_flags |= CE_MATCHED;
b878579ae7 425) break;
b878579ae7 428) }
b878579ae7 488) mark_colliding_entries(state, ce, &st);

fsck.c
fb8952077d  214) die_errno("Could not read '%s'", path);

git.c
a9a60b94cc 322) fprintf_ln(stderr, _("'%s' is aliased to '%s'"),
c6d75bc17a 735) string_list_clear(&cmd_list, 0);

gpg-interface.c
4de9394dcb 155) break;

help.c
26c7d06783 help.c         500) static int get_alias(const char *var, 
const char *value, void *data)
26c7d06783 help.c         502) struct string_list *list = data;
26c7d06783 help.c         504) if (skip_prefix(var, "alias.", &var))
26c7d06783 help.c         505) string_list_append(list, var)->util = 
xstrdup(value);
26c7d06783 help.c         507) return 0;
26c7d06783 help.c         530) printf("\n%s\n", _("Command aliases"));
26c7d06783 help.c         531) ALLOC_ARRAY(aliases, alias_list.nr + 1);
26c7d06783 help.c         532) for (i = 0; i < alias_list.nr; i++) {
26c7d06783 help.c         533) aliases[i].name = alias_list.items[i].string;
26c7d06783 help.c         534) aliases[i].help = alias_list.items[i].util;
26c7d06783 help.c         535) aliases[i].category = 1;
26c7d06783 help.c         537) aliases[alias_list.nr].name = NULL;
26c7d06783 help.c         538) print_command_list(aliases, 1, longest);
26c7d06783 help.c         539) free(aliases);

http.c
21084e84a4  316) free(http_ssl_backend);
21084e84a4  317) http_ssl_backend = xstrdup_or_null(value);
21084e84a4  318) return 0;
93aef7c79b  322) http_schannel_check_revoke = git_config_bool(var, value);
93aef7c79b  323) return 0;
b67d40adbb  327) http_schannel_use_ssl_cainfo = git_config_bool(var, value);
b67d40adbb  328) return 0;
93aef7c79b  833)     !http_schannel_check_revoke) {
93aef7c79b  835) curl_easy_setopt(result, CURLOPT_SSL_OPTIONS, 
CURLSSLOPT_NO_REVOKE);
b67d40adbb  883)     !http_schannel_use_ssl_cainfo) {
b67d40adbb  884) curl_easy_setopt(result, CURLOPT_CAINFO, NULL);

ident.c
501afcb8b0 172) strbuf_addstr(&git_default_email, email);
501afcb8b0 173) free((char *)email);

list-objects-filter-options.c
bc5975d24f  55) if (errbuf) {
bc5975d24f  56) strbuf_addstr(
bc5975d24f  60) return 1;
cc0b05a4cc  86) if (errbuf)

list-objects-filter.c
list-objects.c
f447a499db 200) ctx->show_object(obj, base->buf, ctx->show_data);

ll-merge.c
d64324cb60 380) marker_size = DEFAULT_CONFLICT_MARKER_SIZE;

log-tree.c
4a7e27e957 477) if (oideq(&parent->item->object.oid, oid))

mailinfo.c
3aa4d81f88  992) len--;
3aa4d81f88  998) handle_filter(mi, prev);
3aa4d81f88  999) strbuf_reset(prev);
3aa4d81f88 1090) handle_filter(mi, &prev);

midx.c
4d80560c54   58) error_errno(_("failed to read %s"), midx_name);
4d80560c54   59) goto cleanup_fail;
4d80560c54   65) error(_("multi-pack-index file %s is too small"), 
midx_name);
4d80560c54   66) goto cleanup_fail;
0d5b3a5ef7  146) die(_("multi-pack-index missing required OID lookup 
chunk"));
662148c435  148) die(_("multi-pack-index missing required object offsets 
chunk"));
4d80560c54  173) munmap(midx_map, midx_size);
4d80560c54  175) close(fd);
1dcd9f2043  184) return;
3715a6335c  266) return 0;
fe1ed56f5e  413) warning(_("failed to open pack-index '%s'"),
fe1ed56f5e  415) close_pack(packs->list[packs->nr]);
fe1ed56f5e  416) FREE_AND_NULL(packs->list[packs->nr]);
fe1ed56f5e  417) return;
a40498a126  490) return 1;
fe1ed56f5e  507) die(_("failed to locate object %d in packfile"), 
cur_object);
fc59e74844  769) die_errno(_("unable to create leading directories of %s"),
525e18c04b  943) die(_("failed to clear multi-pack-index at %s"), midx);
56ee7ff156  969) return 0;
cc6af73c02 1010) midx_report(_("failed to load pack-index for packfile %s"),
cc6af73c02 1011)     e.p->pack_name);
cc6af73c02 1012) break;

name-hash.c
2179045fd0 532) die(_("unable to create lazy_dir thread: %s"), 
strerror(err));
2179045fd0 554) die(_("unable to create lazy_name thread: %s"), 
strerror(err));
2179045fd0 560) die(_("unable to join lazy_name thread: %s"), 
strerror(err));

oidmap.c
cc00e5ce6b 11) return !oideq(&entry_->oid,

oidset.c
8b2f8cbcb1 29) kh_del_oid(&set->set, pos);
8b2f8cbcb1 30) return 1;

pack-bitmap.c
30cdc33fba 1130) return 0;

pack-objects.c
108f530385 172) REALLOC_ARRAY(pdata->tree_depth, pdata->nr_alloc);
fe0ac2fb7f 175) REALLOC_ARRAY(pdata->layer, pdata->nr_alloc);
108f530385 192) pdata->tree_depth[pdata->nr_objects - 1] = 0;
fe0ac2fb7f 195) pdata->layer[pdata->nr_objects - 1] = 0;

packfile.c
1127a98cce  117) return error("index file %s is too small", path);
1127a98cce  119) return error("empty data");
fe1ed56f5e  211) if (open_pack_index(p))
fe1ed56f5e  212) return 0;
fe1ed56f5e  213) level1_ofs = p->index_data;
17c35c8969  490) break;
17c35c8969  548) return 0;

preload-index.c
ae9af12287  63) struct progress_data *pd = p->progress;
ae9af12287  65) pthread_mutex_lock(&pd->mutex);
ae9af12287  66) pd->n += last_nr - nr;
ae9af12287  67) display_progress(pd->progress, pd->n);
ae9af12287  68) pthread_mutex_unlock(&pd->mutex);
ae9af12287  69) last_nr = nr;
ae9af12287  83) struct progress_data *pd = p->progress;
ae9af12287  85) pthread_mutex_lock(&pd->mutex);
ae9af12287  86) display_progress(pd->progress, pd->n + last_nr);
ae9af12287  87) pthread_mutex_unlock(&pd->mutex);
ae9af12287 118) pd.progress = start_delayed_progress(_("Refreshing 
index"), index->cache_nr);
ae9af12287 119) pthread_mutex_init(&pd.mutex, NULL);
ae9af12287 132) p->progress = &pd;
2179045fd0 137) die(_("unable to create threaded lstat: %s"), 
strerror(err));

read-cache.c
ae9af12287 1490) progress = start_delayed_progress(_("Refresh index"),
ae9af12287 1491)   istate->cache_nr);
ae9af12287 1539) display_progress(progress, i);
ae9af12287 1572) display_progress(progress, istate->cache_nr);
ae9af12287 1573) stop_progress(&progress);
252d079cbd 1784) const unsigned char *cp = (const unsigned char *)name;
252d079cbd 1788) strip_len = decode_varint(&cp);
77ff1127a4 1789) if (previous_ce) {
77ff1127a4 1790) previous_len = previous_ce->ce_namelen;
77ff1127a4 1791) if (previous_len < strip_len)
252d079cbd 1792) die(_("malformed name field in the index, near path '%s'"),
77ff1127a4 1793) previous_ce->name);
77ff1127a4 1794) copy_len = previous_len - strip_len;
252d079cbd 1796) name = (const char *)cp;
252d079cbd 1802) len += copy_len;
252d079cbd 1823) if (copy_len)
252d079cbd 1824) memcpy(ce->name, previous_ce->name, copy_len);
252d079cbd 1825) memcpy(ce->name + copy_len, name, len + 1 - copy_len);
252d079cbd 1826) *ent_size = (name - ((char *)ondisk)) + len + 1 - copy_len;
abb4bb8384 1959) munmap((void *)p->mmap, p->mmap_size);
abb4bb8384 1960) die(_("index file corrupt"));
77ff1127a4 2001) mem_pool_init(&istate->ce_mem_pool,
77ff1127a4 2039) static void *load_cache_entries_thread(void *_data)
77ff1127a4 2041) struct load_cache_entries_thread_data *p = _data;
77ff1127a4 2045) for (i = p->ieot_start; i < p->ieot_start + 
p->ieot_blocks; i++) {
77ff1127a4 2046) p->consumed += load_cache_entry_block(p->istate, 
p->ce_mem_pool,
77ff1127a4 2047) p->offset, p->ieot->entries[i].nr, p->mmap, 
p->ieot->entries[i].offset, NULL);
77ff1127a4 2048) p->offset += p->ieot->entries[i].nr;
77ff1127a4 2050) return NULL;
77ff1127a4 2053) static unsigned long load_cache_entries_threaded(struct 
index_state *istate, const char *mmap, size_t mmap_size,
77ff1127a4 2058) unsigned long consumed = 0;
77ff1127a4 2061) if (istate->name_hash_initialized)
77ff1127a4 2064) mem_pool_init(&istate->ce_mem_pool, 0);
77ff1127a4 2067) if (nr_threads > ieot->nr)
77ff1127a4 2068) nr_threads = ieot->nr;
77ff1127a4 2069) data = xcalloc(nr_threads, sizeof(*data));
77ff1127a4 2071) offset = ieot_start = 0;
77ff1127a4 2072) ieot_blocks = DIV_ROUND_UP(ieot->nr, nr_threads);
77ff1127a4 2073) for (i = 0; i < nr_threads; i++) {
77ff1127a4 2074) struct load_cache_entries_thread_data *p = &data[i];
77ff1127a4 2077) if (ieot_start + ieot_blocks > ieot->nr)
77ff1127a4 2078) ieot_blocks = ieot->nr - ieot_start;
77ff1127a4 2080) p->istate = istate;
77ff1127a4 2081) p->offset = offset;
77ff1127a4 2082) p->mmap = mmap;
77ff1127a4 2083) p->ieot = ieot;
77ff1127a4 2084) p->ieot_start = ieot_start;
77ff1127a4 2085) p->ieot_blocks = ieot_blocks;
77ff1127a4 2088) nr = 0;
77ff1127a4 2089) for (j = p->ieot_start; j < p->ieot_start + 
p->ieot_blocks; j++)
77ff1127a4 2090) nr += p->ieot->entries[j].nr;
77ff1127a4 2091) if (istate->version == 4) {
77ff1127a4 2092) mem_pool_init(&p->ce_mem_pool,
77ff1127a4 2095) mem_pool_init(&p->ce_mem_pool,
77ff1127a4 2099) err = pthread_create(&p->pthread, NULL, 
load_cache_entries_thread, p);
77ff1127a4 2100) if (err)
77ff1127a4 2101) die(_("unable to create load_cache_entries thread: 
%s"), strerror(err));
77ff1127a4 2104) for (j = 0; j < ieot_blocks; j++)
77ff1127a4 2105) offset += ieot->entries[ieot_start + j].nr;
77ff1127a4 2106) ieot_start += ieot_blocks;
77ff1127a4 2109) for (i = 0; i < nr_threads; i++) {
77ff1127a4 2110) struct load_cache_entries_thread_data *p = &data[i];
77ff1127a4 2112) err = pthread_join(p->pthread, NULL);
77ff1127a4 2113) if (err)
77ff1127a4 2114) die(_("unable to join load_cache_entries thread: %s"), 
strerror(err));
77ff1127a4 2115) mem_pool_combine(istate->ce_mem_pool, p->ce_mem_pool);
77ff1127a4 2116) consumed += p->consumed;
77ff1127a4 2119) free(data);
77ff1127a4 2121) return consumed;
abb4bb8384 2193) extension_offset = read_eoie_extension(mmap, mmap_size);
abb4bb8384 2194) if (extension_offset) {
abb4bb8384 2197) p.src_offset = extension_offset;
abb4bb8384 2198) err = pthread_create(&p.pthread, NULL, 
load_index_extensions, &p);
abb4bb8384 2199) if (err)
abb4bb8384 2200) die(_("unable to create load_index_extensions thread: 
%s"), strerror(err));
abb4bb8384 2202) nr_threads--;
77ff1127a4 2211) ieot = read_ieot_extension(mmap, mmap_size, 
extension_offset);
77ff1127a4 2214) src_offset += load_cache_entries_threaded(istate, mmap, 
mmap_size, src_offset, nr_threads, ieot);
77ff1127a4 2215) free(ieot);
abb4bb8384 2225) int ret = pthread_join(p.pthread, NULL);
abb4bb8384 2226) if (ret)
abb4bb8384 2227) die(_("unable to join load_index_extensions thread: 
%s"), strerror(ret));
3255089ada 2769) ieot_blocks = nr_threads;
77ff1127a4 2770) if (ieot_blocks > istate->cache_nr)
77ff1127a4 2771) ieot_blocks = istate->cache_nr;
3255089ada 2779) ieot = xcalloc(1, sizeof(struct index_entry_offset_table)
3255089ada 2780) + (ieot_blocks * sizeof(struct index_entry_offset)));
77ff1127a4 2781) ieot_entries = DIV_ROUND_UP(entries, ieot_blocks);
3255089ada 2787) free(ieot);
3b1d9e045e 2788) return -1;
3255089ada 2814) ieot->entries[ieot->nr].nr = nr;
3255089ada 2815) ieot->entries[ieot->nr].offset = offset;
3255089ada 2816) ieot->nr++;
3255089ada 2822) if (previous_name)
3255089ada 2823) previous_name->buf[0] = 0;
3255089ada 2824) nr = 0;
3255089ada 2825) offset = lseek(newfd, 0, SEEK_CUR);
3255089ada 2826) if (offset < 0) {
3255089ada 2827) free(ieot);
3255089ada 2828) return -1;
3255089ada 2830) offset += write_buffer_len;
3255089ada 2840) ieot->entries[ieot->nr].nr = nr;
3255089ada 2841) ieot->entries[ieot->nr].offset = offset;
3255089ada 2842) ieot->nr++;
3255089ada 2854) free(ieot);
3b1d9e045e 2855) return -1;
3255089ada 2868) struct strbuf sb = STRBUF_INIT;
3255089ada 2870) write_ieot_extension(&sb, ieot);
3255089ada 2871) err = write_index_ext_header(&c, &eoie_c, newfd, 
CACHE_EXT_INDEXENTRYOFFSETTABLE, sb.len) < 0
3255089ada 2872) || ce_write(&c, newfd, sb.buf, sb.len) < 0;
3255089ada 2873) strbuf_release(&sb);
3255089ada 2874) free(ieot);
3255089ada 2875) if (err)
3255089ada 2876) return -1;
3b1d9e045e 3363) static size_t read_eoie_extension(const char *mmap, 
size_t mmap_size)
3b1d9e045e 3381) if (mmap_size < sizeof(struct cache_header) + 
EOIE_SIZE_WITH_HEADER + the_hash_algo->rawsz)
3b1d9e045e 3382) return 0;
3b1d9e045e 3385) index = eoie = mmap + mmap_size - EOIE_SIZE_WITH_HEADER 
- the_hash_algo->rawsz;
3b1d9e045e 3386) if (CACHE_EXT(index) != CACHE_EXT_ENDOFINDEXENTRIES)
3b1d9e045e 3387) return 0;
3b1d9e045e 3388) index += sizeof(uint32_t);
3b1d9e045e 3391) extsize = get_be32(index);
3b1d9e045e 3392) if (extsize != EOIE_SIZE)
3b1d9e045e 3393) return 0;
3b1d9e045e 3394) index += sizeof(uint32_t);
3b1d9e045e 3400) offset = get_be32(index);
3b1d9e045e 3401) if (mmap + offset < mmap + sizeof(struct cache_header))
3b1d9e045e 3402) return 0;
3b1d9e045e 3403) if (mmap + offset >= eoie)
3b1d9e045e 3404) return 0;
3b1d9e045e 3405) index += sizeof(uint32_t);
3b1d9e045e 3416) src_offset = offset;
3b1d9e045e 3417) the_hash_algo->init_fn(&c);
3b1d9e045e 3418) while (src_offset < mmap_size - the_hash_algo->rawsz - 
EOIE_SIZE_WITH_HEADER) {
3b1d9e045e 3426) memcpy(&extsize, mmap + src_offset + 4, 4);
3b1d9e045e 3427) extsize = ntohl(extsize);
3b1d9e045e 3430) if (src_offset + 8 + extsize < src_offset)
3b1d9e045e 3431) return 0;
3b1d9e045e 3433) the_hash_algo->update_fn(&c, mmap + src_offset, 8);
3b1d9e045e 3435) src_offset += 8;
3b1d9e045e 3436) src_offset += extsize;
3b1d9e045e 3438) the_hash_algo->final_fn(hash, &c);
3b1d9e045e 3439) if (!hasheq(hash, (const unsigned char *)index))
3b1d9e045e 3440) return 0;
3b1d9e045e 3443) if (src_offset != mmap_size - the_hash_algo->rawsz - 
EOIE_SIZE_WITH_HEADER)
3b1d9e045e 3444) return 0;
3b1d9e045e 3446) return offset;
3255089ada 3465) static struct index_entry_offset_table 
*read_ieot_extension(const char *mmap, size_t mmap_size, size_t offset)
3255089ada 3467)        const char *index = NULL;
3255089ada 3473)        if (!offset)
3255089ada 3474)        return NULL;
3255089ada 3475)        while (offset <= mmap_size - 
the_hash_algo->rawsz - 8) {
3255089ada 3476)        extsize = get_be32(mmap + offset + 4);
3255089ada 3477)        if (CACHE_EXT((mmap + offset)) == 
CACHE_EXT_INDEXENTRYOFFSETTABLE) {
3255089ada 3478)        index = mmap + offset + 4 + 4;
3255089ada 3479)        break;
3255089ada 3481)        offset += 8;
3255089ada 3482)        offset += extsize;
3255089ada 3484)        if (!index)
3255089ada 3485)        return NULL;
3255089ada 3488)        ext_version = get_be32(index);
3255089ada 3489)        if (ext_version != IEOT_VERSION) {
3255089ada 3490)        error("invalid IEOT version %d", ext_version);
3255089ada 3491)        return NULL;
3255089ada 3493)        index += sizeof(uint32_t);
3255089ada 3496)        nr = (extsize - sizeof(uint32_t)) / 
(sizeof(uint32_t) + sizeof(uint32_t));
3255089ada 3497)        if (!nr) {
3255089ada 3498)        error("invalid number of IEOT entries %d", nr);
3255089ada 3499)        return NULL;
3255089ada 3501)        ieot = xmalloc(sizeof(struct 
index_entry_offset_table)
3255089ada 3502)        + (nr * sizeof(struct index_entry_offset)));
3255089ada 3503)        ieot->nr = nr;
3255089ada 3504)        for (i = 0; i < nr; i++) {
3255089ada 3505)        ieot->entries[i].offset = get_be32(index);
3255089ada 3506)        index += sizeof(uint32_t);
3255089ada 3507)        ieot->entries[i].nr = get_be32(index);
3255089ada 3508)        index += sizeof(uint32_t);
3255089ada 3511)        return ieot;
3255089ada 3514) static void write_ieot_extension(struct strbuf *sb, 
struct index_entry_offset_table *ieot)
3255089ada 3520)        put_be32(&buffer, IEOT_VERSION);
3255089ada 3521)        strbuf_add(sb, &buffer, sizeof(uint32_t));
3255089ada 3524)        for (i = 0; i < ieot->nr; i++) {
3255089ada 3527)        put_be32(&buffer, ieot->entries[i].offset);
3255089ada 3528)        strbuf_add(sb, &buffer, sizeof(uint32_t));
3255089ada 3531)        put_be32(&buffer, ieot->entries[i].nr);
3255089ada 3532)        strbuf_add(sb, &buffer, sizeof(uint32_t));
3255089ada 3534) }

rebase-interactive.c
64a43cbd5d 62) return error_errno(_("could not read '%s'."), todo_file);
64a43cbd5d 66) strbuf_release(&buf);
64a43cbd5d 67) return -1;
a9f5476fbc 75) return error_errno(_("could not read '%s'."), todo_file);
a9f5476fbc 79) strbuf_release(&buf);
a9f5476fbc 80) return -1;
64a43cbd5d 86) return -1;

ref-filter.c
f0062d3b74 1039) v->s = xstrdup("");
f0062d3b74 1302) free((char *)to_free);
f0062d3b74 1303) return xstrdup("");
f0062d3b74 1340) free((char *)to_free);
f0062d3b74 1341) return xstrdup("");
f0062d3b74 1391) *s = xstrdup("=");
f0062d3b74 1393) *s = xstrdup("<");
f0062d3b74 1518) ref->symref = xstrdup("");
f0062d3b74 1587) v->s = xstrdup("");

refs.c
3a3b9d8cde  661) return 0;
4a6067cda5 1431) return 0;

refs/files-backend.c
refs/packed-backend.c
9001dc2a74 1163) } else if (!oideq(&update->old_oid, iter->oid)) {

refs/ref-cache.c
9001dc2a74 275) if (!oideq(&ref1->u.value.oid, &ref2->u.value.oid))

remote.c
85daa01f6b 1219) continue;
85daa01f6b 1225) continue;

rerere.c
2373b65059  217) die(_("corrupt MERGE_RR"));
2373b65059  226) die(_("corrupt MERGE_RR"));
2373b65059  229) die(_("corrupt MERGE_RR"));
2373b65059  264) die(_("unable to write rerere record"));
2373b65059  269) die(_("unable to write rerere record"));
4af32207bc  376) break;
4af32207bc  380) strbuf_addbuf(&two, &conflict);
c0f16f8e14  384) break;
c0f16f8e14  388) break;
c0f16f8e14  392) break;
2373b65059  480) return error_errno(_("could not open '%s'"), path);
2373b65059  485) error_errno(_("could not write '%s'"), output);
2373b65059  495) error(_("there were errors while writing '%s' (%s)"),
2373b65059  498) io.io.wrerror = error_errno(_("failed to flush '%s'"), 
path);
2373b65059  565) return error(_("index file corrupt"));
2373b65059  599) return error(_("index file corrupt"));
2373b65059  684) warning_errno(_("failed utime() on '%s'"),
2373b65059  690) return error_errno(_("could not open '%s'"), path);
2373b65059  692) error_errno(_("could not write '%s'"), path);
2373b65059  694) return error_errno(_("writing '%s' failed"), path);
2373b65059  720) die(_("unable to write new index file"));
2373b65059  803) die_errno(_("cannot unlink stray '%s'"), path);
2373b65059 1057) error(_("failed to update conflicted state in '%s'"), 
path);
2373b65059 1075) error(_("no remembered resolution for '%s'"), path);
2373b65059 1077) error_errno(_("cannot unlink '%s'"), filename);
2373b65059 1111) return error(_("index file corrupt"));
2373b65059 1199) die_errno(_("unable to open rr-cache directory"));

revision.c
2abf350385 1538) if (ce_path_match(istate, ce, &revs->prune_data, NULL)) {
2abf350385 1544) while ((i+1 < istate->cache_nr) &&
2abf350385 1545)        ce_same_name(ce, istate->cache[i+1]))
b45424181e 2942) return;
b45424181e 2945) return;
b45424181e 2951) c->object.flags |= UNINTERESTING;
b45424181e 2954) return;
b45424181e 2957) mark_parents_uninteresting(c);
b45424181e 2980) return;
b45424181e 2983) return;
b45424181e 3048) continue;
f0d9cc4196 3097) if (!revs->ignore_missing_links)
f0d9cc4196 3098) die("Failed to traverse parents of commit %s",
f0d9cc4196 3099)     oid_to_hex(&commit->object.oid));
b45424181e 3107) continue;
4a7e27e957 3473)     oideq(&p->item->object.oid, &commit->object.oid))

run-command.c
2179045fd0 1229) error(_("cannot create async thread: %s"), strerror(err));

send-pack.c
c0e40a2d66 207) close(fd[1]);

sequencer.c
bcd33ec25f  683) np = strchrnul(buf, '\n');
bcd33ec25f  684) return error(_("no key present in '%.*s'"),
bcd33ec25f  695) return error(_("unable to dequote value of '%s'"),
bcd33ec25f  737) goto finish;
bcd33ec25f  742) name_i = error(_("'GIT_AUTHOR_NAME' already given"));
bcd33ec25f  747) email_i = error(_("'GIT_AUTHOR_EMAIL' already given"));
bcd33ec25f  752) date_i = error(_("'GIT_AUTHOR_DATE' already given"));
bcd33ec25f  756) err = error(_("unknown variable '%s'"),
bcd33ec25f  761) error(_("missing 'GIT_AUTHOR_NAME'"));
bcd33ec25f  763) error(_("missing 'GIT_AUTHOR_EMAIL'"));
bcd33ec25f  765) error(_("missing 'GIT_AUTHOR_DATE'"));
65850686cf 2329) return;
65850686cf 2426) write_file(rebase_path_quiet(), "%s\n", quiet);
2c58483a59 3427) return error(_("could not checkout %s"), commit);
4df66c40b0 3441) return error(_("%s: not a valid OID"), orig_head);
71f82465b1 3461) fprintf(stderr, _("Stopped at HEAD\n"));
b97e187364 4827) return -1;
b97e187364 4830) return -1;
b97e187364 4836) return error_errno(_("could not read '%s'."), todo_file);
b97e187364 4839) todo_list_release(&todo_list);
b97e187364 4840) return error(_("unusable todo list: '%s'"), todo_file);
b97e187364 4859) todo_list_release(&todo_list);
b97e187364 4860) return -1;
b97e187364 4864) return error(_("could not copy '%s' to '%s'."), todo_file,
b97e187364 4868) return error(_("could not transform the todo list"));
b97e187364 4897) return error(_("could not transform the todo list"));
b97e187364 4900) return error(_("could not skip unnecessary pick 
commands"));
b97e187364 4906) return -1;

setup.c
58b284a2e9  413) return config_error_nonbool(var);

sha1-file.c
67947c34ae sha1-file.c 2225) if (!hasheq(expected_sha1, real_sha1)) {

sha1-name.c
8aac67a174 sha1-name.c  162) return;

split-index.c
e3d837989e 335) ce->ce_flags |= CE_UPDATE_IN_BASE;

strbuf.c
f95736288a  127) --sb->len;

submodule-config.c
bcbc780d14 739) return CONFIG_INVALID_KEY;
45f5ef3d77 754) warning(_("Could not update .gitmodules entry %s"), key);

trace.c
c46c406ae1 189) now = getnanotime();
c46c406ae1 190) perf_start_times[perf_indent] = now;
c46c406ae1 191) if (perf_indent + 1 < ARRAY_SIZE(perf_start_times))
c46c406ae1 192) perf_indent++;
c46c406ae1 195) return now;
c46c406ae1 211) if (perf_indent >= strlen(space))
c46c406ae1 214) strbuf_addf(&buf, ":%.*s ", perf_indent, space);
c46c406ae1 317) void trace_performance_leave_fl(const char *file, int line,
c46c406ae1 323) if (perf_indent)
c46c406ae1 324) perf_indent--;
c46c406ae1 326) if (!format) /* Allow callers to leave without tracing 
anything */
c46c406ae1 327) return;
c46c406ae1 329) since = perf_start_times[perf_indent];
c46c406ae1 330) va_start(ap, format);
c46c406ae1 331) trace_performance_vprintf_fl(file, line, nanos - since, 
format, ap);
c46c406ae1 332) va_end(ap);
c46c406ae1 477) trace_performance_leave("git command:%s", command_line.buf);
c46c406ae1 485) if (!command_line.len)
c46c406ae1 490) trace_performance_enter();

transport.c
unpack-trees.c
b878579ae7  360) string_list_append(&list, ce->name);
b878579ae7  361) ce->ce_flags &= ~CE_MATCHED;
b878579ae7  368) warning(_("the following paths have collided (e.g. 
case-sensitive paths\n"
b878579ae7  372) for (i = 0; i < list.nr; i++)
b878579ae7  373) fprintf(stderr, "  '%s'\n", list.items[i].string);
f1e11c6510  777) free(tree_ce);
b4da37380b  778) return rc;
b4da37380b  785) printf("Unpacked %d entries from %s to %s using 
cache-tree\n",
b4da37380b  787)        o->src_index->cache[pos]->name,
b4da37380b  788)        o->src_index->cache[pos + nr_entries - 1]->name);

upload-pack.c
1d1243fe63 1403) deepen(INFINITE_DEPTH, data->deepen_relative, 
&data->shallows,

worktree.c
3a3b9d8cde 495) return -1;
3a3b9d8cde 508) return -1;
3a3b9d8cde 517) return -1;
ab3e1f78ae 537) break;

wt-status.c
f3bd35fa0d  671) s->committable = 1;
73ba5d78b4 1958) if (s->state.rebase_in_progress ||
73ba5d78b4 1959)     s->state.rebase_interactive_in_progress)
73ba5d78b4 1960) branch_name = s->state.onto;
73ba5d78b4 1961) else if (s->state.detached_from)
73ba5d78b4 1962) branch_name = s->state.detached_from;

xdiff-interface.c
xdiff/xutils.c
611e42a598 405) return -1;

Commits introducing uncovered code:
Ævar Arnfjörð Bjarmason      62c23938f: tests: add a special setup where 
rebase.useBuiltin is off
Alban Gruin      0af129b2e: rebase--interactive2: rewrite the submodes 
of interactive rebase in C
Alban Gruin      2c58483a5: rebase -i: rewrite setup_reflog_action() in C
Alban Gruin      34b47315d: rebase -i: move rebase--helper modes to 
rebase--interactive
Alban Gruin      4df66c40b: rebase -i: rewrite checkout_onto() in C
Alban Gruin      53bbcfbde: rebase -i: implement the main part of 
interactive rebase as a builtin
Alban Gruin      64a43cbd5: rebase -i: rewrite the edit-todo 
functionality in C
Alban Gruin      65850686c: rebase -i: rewrite write_basic_state() in C
Alban Gruin      a9f5476fb: sequencer: refactor append_todo_help() to 
write its message to a buffer
Alban Gruin      b97e18736: rebase -i: rewrite complete_action() in C
Antonio Ospite      45f5ef3d7: submodule: factor out a 
config_set_in_gitmodules_file_gently function
Antonio Ospite      76e9bdc43: submodule: support reading .gitmodules 
when it's not in the working tree
Antonio Ospite      bcbc780d1: submodule: add a 
print_config_from_gitmodules() helper
Ben Peart      3255089ad: ieot: add Index Entry Offset Table (IEOT) 
extension
Ben Peart      3b1d9e045: eoie: add End of Index Entry (EOIE) extension
Ben Peart      77ff1127a: read-cache: load cache entries on worker threads
Ben Peart      abb4bb838: read-cache: load cache extensions on a worker 
thread
Ben Peart      c780b9cfe: config: add new index.threads config setting
Ben Peart      d1664e73a: add: speed up cmd_add() by utilizing 
read_cache_preload()
Ben Peart      fa655d841: checkout: optimize "git checkout -b <new_branch>"
Brendan Forster      93aef7c79: http: add support for disabling SSL 
revocation checks in cURL
brian m. carlson      2f0c9e9a9: builtin/repack: replace hard-coded 
constants
brian m. carlson      eccb5a5f3: apply: rename new_sha1_prefix and 
old_sha1_prefix
Christian Couder      108f53038: pack-objects: move tree_depth into 
'struct packing_data'
Christian Couder      fe0ac2fb7: pack-objects: move 'layer' into 'struct 
packing_data'
Derrick Stolee      0d5b3a5ef: midx: write object ids in a chunk
Derrick Stolee      17c35c896: packfile: skip loading index if in 
multi-pack-index
Derrick Stolee      1d614d41e: commit-reach: move ref_newer from remote.c
Derrick Stolee      1dcd9f204: midx: close multi-pack-index on repack
Derrick Stolee      20fd6d579: commit-graph: not compatible with grafts
Derrick Stolee      3715a6335: midx: read objects from multi-pack-index
Derrick Stolee      454ea2e4d: treewide: use get_all_packs
Derrick Stolee      4d80560c5: multi-pack-index: load into memory
Derrick Stolee      4fbcca4ef: commit-reach: make can_all_from_reach... 
linear
Derrick Stolee      5227c3856: commit-reach: move walk methods from commit.c
Derrick Stolee      525e18c04: midx: clear midx on repack
Derrick Stolee      56ee7ff15: multi-pack-index: add 'verify' verb
Derrick Stolee      662148c43: midx: write object offsets
Derrick Stolee      66ec0390e: fsck: verify multi-pack-index
Derrick Stolee      6a22d5212: pack-objects: consider packs in 
multi-pack-index
Derrick Stolee      6cc017431: commit-reach: use can_all_from_reach
Derrick Stolee      6d68e6a46: multi-pack-index: provide more helpful 
usage info
Derrick Stolee      85daa01f6: remote: make add_missing_tags() linear
Derrick Stolee      8aac67a17: midx: use midx in abbreviation calculations
Derrick Stolee      a40498a12: midx: use existing midx when writing new one
Derrick Stolee      b45424181: revision.c: generation-based topo-order 
algorithm
Derrick Stolee      b67f6b26e: commit-reach: properly peel tags
Derrick Stolee      cc6af73c0: multi-pack-index: verify object offsets
Derrick Stolee      f0d9cc419: revision.c: begin refactoring 
--topo-order logic
Derrick Stolee      fc59e7484: midx: write header information to lockfile
Derrick Stolee      fe1ed56f5: midx: sort and deduplicate objects from 
packfiles
Duy Nguyen      b878579ae: clone: report duplicate entries on 
case-insensitive filesystems
Eric Sunshine      2e6fd71a5: format-patch: extend --range-diff to 
accept revision range
Eric Sunshine      40ce41604: format-patch: allow --range-diff to apply 
to a lone-patch
Eric Sunshine      68a6b3a1b: worktree: teach 'move' to override lock 
when --force given twice
Eric Sunshine      8631bf1cd: format-patch: add --creation-factor tweak 
for --range-diff
Eric Sunshine      e19831c94: worktree: teach 'add' to respect --force 
for registered but missing path
Eric Sunshine      e5353bef5: worktree: move delete_git_dir() earlier in 
file for upcoming new callers
Eric Sunshine      ee6cbf712: format-patch: allow --interdiff to apply 
to a lone-patch
Eric Sunshine      f4143101c: worktree: teach 'remove' to override lock 
when --force given twice
Jeff King      0074c9110: combine-diff: use an xdiff hunk callback
Jeff King      01a31f3bc: pull: handle --verify-signatures for unborn branch
Jeff King      0eb8d3767: cat-file: report an error on multiple --batch 
options
Jeff King      16d75fa48: repack: add delta-islands support
Jeff King      28b8a7308: pack-objects: add delta-islands support
Jeff King      2c8ee1f53: bundle: dup() output descriptor closer to 
point-of-use
Jeff King      2fa233a55: pack-objects: handle island check for 
"external" delta base
Jeff King      30cdc33fb: pack-bitmap: save "have" bitmap from walk
Jeff King      4a7e27e95: convert "oidcmp() == 0" to oideq()
Jeff King      517fe807d: assert NOARG/NONEG behavior of parse-options 
callbacks
Jeff King      611e42a59: xdiff: provide a separate emit callback for hunks
Jeff King      67947c34a: convert "hashcmp() != 0" to "!hasheq()"
Jeff King      735ca208c: apply: return -1 from option callback instead 
of calling exit(1)
Jeff King      8a2c17467: pathspec: handle non-terminated strings with 
:(attr)
Jeff King      9001dc2a7: convert "oidcmp() != 0" to "!oideq()"
Jeff King      98f425b45: cat-file: handle streaming failures consistently
Jeff King      c27cc94fa: approxidate: handle pending number for "specials"
Jeff King      c8d521faf: Add delta-islands.{c,h}
Jeff King      cc00e5ce6: convert hashmap comparison functions to oideq()
Jeff King      fce566480: am: handle --no-patch-format option
Johannes Schindelin      21084e84a: http: add support for selecting SSL 
backends at runtime
Johannes Schindelin      3249c1251: rebase: consolidate clean-up code 
before leaving reset_head()
Johannes Schindelin      501afcb8b: mingw: use domain information for 
default email
Johannes Schindelin      71f82465b: rebase -i: introduce the 'break' command
Johannes Schindelin      b67d40adb: http: when using Secure Channel, 
ignore sslCAInfo by default
Johannes Schindelin      bac2a1e36: built-in rebase: reinstate `checkout 
-q` behavior where appropriate
Johannes Schindelin      bc24382c2: builtin rebase: prepare for builtin 
rebase -i
Jonathan Nieder      302997027: gc: do not return error for prior errors 
in daemonized mode
Jonathan Nieder      fec2ed218: gc: exit with status 128 on failure
Jonathan Tan      1d1243fe6: upload-pack: make want_obj not global
Josh Steadmon      1127a98cc: fuzz: add fuzz testing for packfile indices.
Matthew DeVore      7c0fe330d: rev-list: handle missing tree objects 
properly
Matthew DeVore      bc5975d24: list-objects-filter: implement filter tree:0
Matthew DeVore      cc0b05a4c: list-objects-filter-options: do not 
over-strbuf_init
Matthew DeVore      f447a499d: list-objects: store common func args in 
struct
Michał Górny      4de9394dc: gpg-interface.c: obtain primary key 
fingerprint as well
Nguyễn Thái Ngọc Duy      2179045fd: Clean up pthread_create() error 
handling
Nguyễn Thái Ngọc Duy      252d079cb: read-cache.c: optimize reading 
index format v4
Nguyễn Thái Ngọc Duy      26c7d0678: help -a: improve and make --verbose 
default
Nguyễn Thái Ngọc Duy      2abf35038: revision.c: remove implicit 
dependency on the_index
Nguyễn Thái Ngọc Duy      3a3b9d8cd: refs: new ref types to make 
per-worktree refs visible to all worktrees
Nguyễn Thái Ngọc Duy      58b284a2e: worktree: add per-worktree config files
Nguyễn Thái Ngọc Duy      a470beea3: blame.c: rename "repo" argument to "r"
Nguyễn Thái Ngọc Duy      ab3e1f78a: revision.c: better error reporting 
on ref from different worktrees
Nguyễn Thái Ngọc Duy      ae9af1228: status: show progress bar if 
refreshing the index takes too long
Nguyễn Thái Ngọc Duy      b29759d89: fsck: check HEAD and reflog from 
other worktrees
Nguyễn Thái Ngọc Duy      b4da37380: unpack-trees: optimize walking same 
trees with cache-tree
Nguyễn Thái Ngọc Duy      b78ea5fc3: diff.c: reduce implicit dependency 
on the_index
Nguyễn Thái Ngọc Duy      c0e40a2d6: send-pack.c: move async's #ifdef 
NO_PTHREADS back to run-command.c
Nguyễn Thái Ngọc Duy      c46c406ae: trace.h: support nested performance 
tracing
Nguyễn Thái Ngọc Duy      c9ef0d95e: reflog expire: cover reflog from 
all worktrees
Nguyễn Thái Ngọc Duy      f1e11c651: unpack-trees: reduce malloc in 
cache-tree walk
Nguyễn Thái Ngọc Duy      fd6263fb7: grep: clean up num_threads handling
Olga Telezhnaya      f0062d3b7: ref-filter: free item->value and 
item->value->s
Phillip Wood      bcd33ec25: add read_author_script() to libgit
Pratik Karki      002ee2fe6: builtin rebase: support `keep-empty` option
Pratik Karki      0eabf4b95: builtin rebase: stop if `git am` is in progress
Pratik Karki      12026a412: builtin rebase: support `--gpg-sign` option
Pratik Karki      122420c29: builtin rebase: support --skip
Pratik Karki      1ed9c14ff: builtin rebase: support --force-rebase
Pratik Karki      3c3588c7d: builtin rebase: support 
--rebase-merges[=[no-]rebase-cousins]
Pratik Karki      55071ea24: rebase: start implementing it as a builtin
Pratik Karki      5a6149453: builtin rebase: support --quit
Pratik Karki      5e5d96197: builtin rebase: support --abort
Pratik Karki      6defce2b0: builtin rebase: support `--autostash` option
Pratik Karki      73d51ed0a: builtin rebase: support --signoff
Pratik Karki      9a48a615b: builtin rebase: try to fast forward when 
possible
Pratik Karki      9dba809a6: builtin rebase: support --root
Pratik Karki      ac7f467fe: builtin/rebase: support running "git rebase 
<upstream>"
Pratik Karki      ba1905a5f: builtin rebase: add support for custom 
merge strategies
Pratik Karki      bff014dac: builtin rebase: support the `verbose` and 
`diffstat` options
Pratik Karki      c54dacb50: builtin rebase: start a new rebase only if 
none is in progress
Pratik Karki      cda614e48: builtin rebase: show progress when 
connected to a terminal
Pratik Karki      e0333e5c6: builtin rebase: require a clean worktree
Pratik Karki      e65123a71: builtin rebase: support `git rebase 
<upstream> <switch-to>`
Pratik Karki      ead98c111: builtin rebase: support --rerere-autoupdate
Pratik Karki      f28d40d3a: builtin rebase: support --onto
Pratik Karki      f95736288: builtin rebase: support --continue
Rasmus Villemoes      a9a60b94c: git.c: handle_alias: prepend alias info 
when first argument is -h
Rasmus Villemoes      e6e76baaf: help: redirect to aliased commands for 
"git cmd --help"
René Scharfe      3aa4d81f8: mailinfo: support format=flowed
René Scharfe      8b2f8cbcb: oidset: use khash
René Scharfe      fb8952077: fsck: use strbuf_getline() to read skiplist 
file
Shulhan      5025425df: builtin/remote: quote remote name on error to 
display empty name
Stefan Beller      4a6067cda: refs.c: migrate internal ref iteration to 
pass thru repository argument
Stefan Beller      74d4731da: submodule--helper: replace 
connect-gitdir-workingtree by ensure-core-worktree
Stefan Beller      e0a862fda: submodule helper: convert relative URL to 
absolute URL if needed
Stefan Beller      ee69b2a90: submodule--helper: introduce new 
update-module-mode helper
Stephen P. Smith      73ba5d78b: roll wt_status_state into wt_status and 
populate in the collect phase
Stephen P. Smith      f3bd35fa0: wt-status.c: set the committable flag 
in the collect phase
SZEDER Gábor      e3d837989: split-index: don't compare cached data of 
entries already marked for split index
Thomas Gummerer      2373b6505: rerere: mark strings for translation
Thomas Gummerer      4af32207b: rerere: teach rerere to handle nested 
conflicts
Thomas Gummerer      c0f16f8e1: rerere: factor out handle_conflict function
Tim Schumacher      c6d75bc17: alias: add support for aliases of an alias
Torsten Bögershausen      d64324cb6: Make git_check_attr() a void function

