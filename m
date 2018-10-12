Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 745E01F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 12:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbeJLUcN (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 16:32:13 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:46747 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbeJLUcM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 16:32:12 -0400
Received: by mail-qt1-f170.google.com with SMTP id d8-v6so13667621qtk.13
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 05:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=MXy/IpgZ3H2J4HqjEbctcekoT4yeTsW+2T5QNzvZZ6c=;
        b=P76X0WeNyubNFqoEAwYr5quRCYZf/bbEkXXnMqNn6x/bFqOwk0FxmxKh/jgHYGaHJ7
         UU0ZX2zngP/9VvRb/2p2GinqaCsb69cv02NhP/ZWOfDBCmUZdIt1yd46QOkLN/25hNBp
         mS4rIehgxFh/0y12pCU08q5DsPy4cC2GpOBdYulufFwbitlBO/Vu/7AzfqzRAUeErPCq
         YnCWQnY5P87h48U8xGI5Sjjl+jcN7QyCEGyP+5VyYBKSmS9BwM6VAfDnr1AUJ8HGecOa
         wV7+vUIrCQLCBsFdT+AOgGHOjD/zXKpkpzd6EmSG4pt6u46YQ3DBveTipc6k5IjpB69B
         unyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=MXy/IpgZ3H2J4HqjEbctcekoT4yeTsW+2T5QNzvZZ6c=;
        b=tbSgm+F8iP8+XyYb35d4cPmN400QVVFxmwcg6sHvlmgj1TVsUlMJo0zqoWQDYmfGku
         rVG2fcXWYhYyRUodHhsdSGVkukUMfBrotKt30iaipm+TR7XcW24nmGkynldB9bq55yrq
         uVxaoGuIqE85ajdbzhqecNIQyB8c2xkA/hgG+YGJcutDRaNBO3kR5mikuJtmE6+Jl08U
         oCvyKubNm2F3lCWkAfYfZeLyohryqSqYKckZ7dwt46Ac7qwcLeeSI2bgQ0X80Yb5KcgU
         URuuIE/Y1a86NFfra/X6gvEhST8UQUS3OWgTBHe9cH2yZQdQZ6pv7xrjZq47EqHBDByQ
         Wz0A==
X-Gm-Message-State: ABuFfohNGKSYs8q1Is7TbEUeo/8/3/4OV0pwdhK5fkRoQO6lScPgBMbJ
        WqT+C4v/bBz2tmheHzGGnPETunyX
X-Google-Smtp-Source: ACcGV617CYb3P3dZrRMSTBulKODSDlU5hwHMB9Z5NRseQh+aM8doEW9IWB75XhZHri+S90wZ+6/u/Q==
X-Received: by 2002:a0c:d032:: with SMTP id u47-v6mr5808257qvg.245.1539349186785;
        Fri, 12 Oct 2018 05:59:46 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:e9ec:1ddb:856c:2858? ([2001:4898:8010:0:d322:1ddb:856c:2858])
        by smtp.gmail.com with ESMTPSA id c36-v6sm1033925qta.56.2018.10.12.05.59.45
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 05:59:46 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (Friday, Oct 12)
To:     Git List <git@vger.kernel.org>
Message-ID: <e30a9c05-87d8-1f2b-182c-6d6a5fefe43c@gmail.com>
Date:   Fri, 12 Oct 2018 08:59:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


In an effort to ensure new code is reasonably covered by the test suite, 
we now have contrib/coverage-diff.sh to combine the gcov output from 
'make coverage-test ; make coverage-report' with the output from 'git 
diff A B' to discover _new_ lines of code that are not covered.

This report takes the output of these results after running on four 
branches:

         pu: 13cafb433ca0dd31b3ea229a79cc8507aa89ee19 (tests are broken, 
so coverage not reported)

        jch: fda196ac82002ede984896861cf28a354044d1a0

       next: 76f2f5c1e34c4dbef1029e2984c2892894c444ce

     master: 04861070400d3ca9d487bd0d736ca818b9ffe371

      maint: cae598d9980661a978e2df4fb338518f7bf09572

I ran the test suite on each of these branches on an Ubuntu Linux VM, 
and I'm missing some dependencies (like apache, svn, and perforce) so 
not all tests are run.

I submit this output without comment. I'm taking a look especially at my 
own lines to see where coverage can be improved.

Thanks,

-Stolee

Uncovered code new in jch, compared to next. Build logs at [1]
--------------------------------------------------------------

builtin/archive.c
e001fd3a50 builtin/archive.c  78) die(_("git archive: expected ACK/NAK, 
got a flush packet"));
e001fd3a50 builtin/archive.c  80) if (starts_with(reader.line, "NACK "))
e001fd3a50 builtin/archive.c  81) die(_("git archive: NACK %s"), 
reader.line + 5);
e001fd3a50 builtin/archive.c  82) if (starts_with(reader.line, "ERR "))
e001fd3a50 builtin/archive.c  83) die(_("remote error: %s"), reader.line 
+ 4);
e001fd3a50 builtin/archive.c  84) die(_("git archive: protocol error"));
e001fd3a50 builtin/archive.c  89) die(_("git archive: expected a flush"));
fb19d32f05 builtin/archive.c  99) if (version != discover_version(&reader))
fb19d32f05 builtin/archive.c 100) die(_("git archive: received different 
protocol versions in subsequent requests"));

builtin/fetch.c
7bbc53a589 builtin/fetch.c  385) continue; /* can this happen??? */

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
0af129b2ed builtin/rebase--interactive2.c 267) BUG("invalid command 
'%d'", command);

builtin/rebase.c
55071ea248   61) strbuf_trim(&out);
55071ea248   62) ret = !strcmp("true", out.buf);
55071ea248   63) strbuf_release(&out);
002ee2fe68  115) die(_("%s requires an interactive rebase"), option);
f95736288a  148) return error_errno(_("could not read '%s'"), path);
f95736288a  162) return -1;
f95736288a  167) return error(_("could not get 'onto': '%s'"), buf.buf);
f95736288a  178) return -1;
f95736288a  179) } else if (read_one(state_dir_path("head", opts), &buf))
f95736288a  180) return -1;
f95736288a  182) return error(_("invalid orig-head: '%s'"), buf.buf);
f95736288a  186) return -1;
f95736288a  188) opts->flags &= ~REBASE_NO_QUIET;
73d51ed0a5  196) opts->signoff = 1;
73d51ed0a5  197) opts->flags |= REBASE_FORCE;
ead98c111b  204) return -1;
12026a412c  219) return -1;
ba1905a5fe  227) return -1;
ba1905a5fe  235) return -1;
6defce2b02  255) return error(_("Could not read '%s'"), path);
6defce2b02  271) res = error(_("Cannot store %s"), autostash.buf);
6defce2b02  275) return res;
bc24382c2b  373) argv_array_pushf(&child.args,
bc24382c2b  375) oid_to_hex(&opts->restrict_revision->object.oid));
ac7f467fef  488) BUG("Unhandled rebase type %d", opts->type);
ac7f467fef  507) struct strbuf dir = STRBUF_INIT;
6defce2b02  509) apply_autostash(opts);
ac7f467fef  510) strbuf_addstr(&dir, opts->state_dir);
ac7f467fef  511) remove_dir_recursively(&dir, 0);
ac7f467fef  512) strbuf_release(&dir);
ac7f467fef  513) die("Nothing to do");
d4c569f8f4  540) BUG("Not a fully qualified branch: '%s'", 
switch_to_branch);
ac7f467fef  543) return -1;
ac7f467fef  547) rollback_lock_file(&lock);
ac7f467fef  548) return error(_("could not determine HEAD revision"));
ac7f467fef  565) rollback_lock_file(&lock);
ac7f467fef  566) return error(_("could not read index"));
ac7f467fef  570) error(_("failed to find tree of %s"), oid_to_hex(oid));
ac7f467fef  571) rollback_lock_file(&lock);
ac7f467fef  572) free((void *)desc.buffer);
ac7f467fef  573) return -1;
ac7f467fef  586) ret = error(_("could not write index"));
ac7f467fef  590) return ret;
ac7f467fef  606) } else if (old_orig)
ac7f467fef  607) delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
bff014dac7  635) opts->flags &= !REBASE_DIFFSTAT;
9a48a615b4  669) return 1;
9a48a615b4  685) return 0;
55071ea248  893) const char *path = mkpath("%s/git-legacy-rebase",
55071ea248  896) if (sane_execvp(path, (char **)argv) < 0)
55071ea248  897) die_errno(_("could not exec %s"), path);
55071ea248  899) BUG("sane_execvp() returned???");
0eabf4b95c  915) die(_("It looks like 'git am' is in progress. Cannot 
rebase."));
f28d40d3a9  952) usage_with_options(builtin_rebase_usage,
f95736288a  972) die(_("Cannot read HEAD"));
f95736288a  976) die(_("could not read index"));
f95736288a  990) exit(1);
122420c295 1002) die(_("could not discard worktree changes"));
122420c295 1004) exit(1);
5e5d96197c 1015) exit(1);
5e5d96197c 1018) die(_("could not move back to %s"),
5a61494539 1028) die(_("could not remove '%s'"), options.state_dir);
51e9ea6da7 1042) BUG("action: %d", action);
c54dacb50e 1047) const char *last_slash = strrchr(options.state_dir, '/');
c54dacb50e 1048) const char *state_dir_base =
c54dacb50e 1049) last_slash ? last_slash + 1 : options.state_dir;
c54dacb50e 1050) const char *cmd_live_rebase =
c54dacb50e 1052) strbuf_reset(&buf);
c54dacb50e 1053) strbuf_addf(&buf, "rm -fr \"%s\"", options.state_dir);
c54dacb50e 1054) die(_("It seems that there is already a %s directory, 
and\n"
53f9e5be94 1078) strbuf_addstr(&options.git_am_opt, " --ignore-date");
53f9e5be94 1079) options.flags |= REBASE_FORCE;
7998dbe1ec 1091) strbuf_addf(&options.git_am_opt, " -C%d", opt_c);
3c3588c7d3 1123) else if (strcmp("no-rebase-cousins", rebase_merges))
3c3588c7d3 1124) die(_("Unknown mode: %s"), rebase_merges);
ba1905a5fe 1146) die(_("--strategy requires --merge or --interactive"));
ba1905a5fe 1156) BUG("unhandled rebase type (%d)", options.type);
cda614e489 1164) strbuf_addstr(&options.git_format_patch_opt, " 
--progress");
ac7f467fef 1173) options.state_dir = apply_dir();
ac7f467fef 1174) break;
ac7f467fef 1251) die(_("invalid upstream '%s'"), options.upstream_name);
9dba809a69 1257) die(_("Could not create new root commit"));
e65123a71d 1307) die(_("fatal: no such branch/commit '%s'"),
ac7f467fef 1315) die(_("No such ref: %s"), "HEAD");
ac7f467fef 1327) die(_("Could not resolve HEAD to a revision"));
e65123a71d 1329) BUG("unexpected number of arguments left to parse");
e0333e5c63 1340) die(_("could not read index"));
6defce2b02 1367) die(_("Cannot autostash"));
6defce2b02 1370) die(_("Unexpected stash response: '%s'"),
6defce2b02 1376) die(_("Could not create directory for '%s'"),
6defce2b02 1382) die(_("could not reset --hard"));
e65123a71d 1426) ret = !!error(_("could not parse '%s'"),
e65123a71d 1428) goto cleanup;
e65123a71d 1437) ret = !!error(_("could not switch to "
1ed9c14ff2 1447)  resolve_ref_unsafe("HEAD", 0, NULL, &flag))
1ed9c14ff2 1448) puts(_("HEAD is up to date."));
9a48a615b4 1457)  resolve_ref_unsafe("HEAD", 0, NULL, &flag))
9a48a615b4 1458) puts(_("HEAD is up to date, rebase forced."));

builtin/rev-list.c
7c0fe330d5 builtin/rev-list.c 227) die("unexpected missing %s object '%s'",
7c0fe330d5 builtin/rev-list.c 228)     type_name(obj->type), 
oid_to_hex(&obj->oid));
250edfa8c8 builtin/rev-list.c 434) bisect_flags |= BISECT_FIND_ALL;

builtin/stash.c
93871263d1 builtin/stash--helper.c  130) free_stash_info(info);
93871263d1 builtin/stash--helper.c  131) error(_("'%s' is not a 
stash-like commit"), revision);
93871263d1 builtin/stash--helper.c  132) exit(128);
93871263d1 builtin/stash--helper.c  165) free_stash_info(info);
93871263d1 builtin/stash--helper.c  166) fprintf_ln(stderr, _("No stash 
entries found."));
93871263d1 builtin/stash--helper.c  167) return -1;
93871263d1 builtin/stash--helper.c  202) free_stash_info(info);
31f109a361 builtin/stash--helper.c  229) return error(_("git stash clear 
with parameters is unimplemented"));
93871263d1 builtin/stash--helper.c  244) return -1;
93871263d1 builtin/stash--helper.c  252) return -1;
93871263d1 builtin/stash--helper.c  265) return -1;
93871263d1 builtin/stash--helper.c  268) return error(_("unable to write 
new index file"));
93871263d1 builtin/stash--helper.c  374) remove_path(stash_index_path.buf);
93871263d1 builtin/stash--helper.c  375) return -1;
93871263d1 builtin/stash--helper.c  402) return -1;
93871263d1 builtin/stash--helper.c  405) return error(_("Cannot apply a 
stash in the middle of a merge"));
93871263d1 builtin/stash--helper.c  415) strbuf_release(&out);
93871263d1 builtin/stash--helper.c  416) return -1;
93871263d1 builtin/stash--helper.c  422) return -1;
93871263d1 builtin/stash--helper.c  427) return -1;
93871263d1 builtin/stash--helper.c  434) return error(_("Could not 
restore untracked files from stash"));
93871263d1 builtin/stash--helper.c  465) return -1;
93871263d1 builtin/stash--helper.c  470) strbuf_release(&out);
93871263d1 builtin/stash--helper.c  475) strbuf_release(&out);
93871263d1 builtin/stash--helper.c  476) return -1;
31f109a361 builtin/stash--helper.c  551) return error(_("%s: Could not 
drop stash entry"),
b3513da4bd builtin/stash--helper.c  623) printf_ln(_("The stash entry is 
kept in case you need it again."));
8ceb24b2c3 builtin/stash--helper.c  754) free_stash_info(&info);
129f0b0a00 builtin/stash.c          755) 
usage_with_options(git_stash_show_usage, options);
0ac06fb81f builtin/stash--helper.c  808) fprintf_ln(stderr, _("\"git 
stash store\" requires one <commit> argument"));
0ac06fb81f builtin/stash--helper.c  809) return -1;
f6f191b3f2 builtin/stash--helper.c  884) return 1;
f6f191b3f2 builtin/stash--helper.c  925) ret = -1;
f6f191b3f2 builtin/stash--helper.c  926) goto done;
f6f191b3f2 builtin/stash--helper.c  931) ret = -1;
f6f191b3f2 builtin/stash--helper.c  932) goto done;
f6f191b3f2 builtin/stash--helper.c  937) ret = -1;
f6f191b3f2 builtin/stash--helper.c  938) goto done;
f6f191b3f2 builtin/stash--helper.c  966) ret = -1;
f6f191b3f2 builtin/stash--helper.c  967) goto done;
f6f191b3f2 builtin/stash--helper.c  978) ret = -1;
f6f191b3f2 builtin/stash--helper.c  979) goto done;
f6f191b3f2 builtin/stash--helper.c  984) ret = -1;
f6f191b3f2 builtin/stash--helper.c  985) goto done;
f6f191b3f2 builtin/stash--helper.c  992) ret = -1;
f6f191b3f2 builtin/stash--helper.c  993) goto done;
f6f191b3f2 builtin/stash--helper.c 1018) ret = -1;
f6f191b3f2 builtin/stash--helper.c 1019) goto done;
f6f191b3f2 builtin/stash--helper.c 1031) ret = -1;
f6f191b3f2 builtin/stash--helper.c 1032) goto done;
f6f191b3f2 builtin/stash--helper.c 1037) ret = -1;
f6f191b3f2 builtin/stash--helper.c 1038) goto done;
f6f191b3f2 builtin/stash--helper.c 1049) ret = -1;
f6f191b3f2 builtin/stash--helper.c 1050) goto done;
f6f191b3f2 builtin/stash--helper.c 1055) ret = -1;
f6f191b3f2 builtin/stash--helper.c 1056) goto done;
8002b9e626 builtin/stash--helper.c 1089) fprintf_ln(stderr, _("You do 
not have the initial commit yet"));
8002b9e626 builtin/stash--helper.c 1110) if (!quiet)
8002b9e626 builtin/stash--helper.c 1111) fprintf_ln(stderr, _("Cannot 
save the current index state"));
f6f191b3f2 builtin/stash--helper.c 1112) ret = -1;
f6f191b3f2 builtin/stash--helper.c 1113) *stash_msg = NULL;
f6f191b3f2 builtin/stash--helper.c 1114) goto done;
8002b9e626 builtin/stash--helper.c 1119) if (!quiet)
8002b9e626 builtin/stash--helper.c 1120) fprintf_ln(stderr, _("Cannot 
save the untracked files"));
f6f191b3f2 builtin/stash--helper.c 1121) ret = -1;
f6f191b3f2 builtin/stash--helper.c 1122) *stash_msg = NULL;
f6f191b3f2 builtin/stash--helper.c 1123) goto done;
8002b9e626 builtin/stash--helper.c 1131) if (!quiet)
8002b9e626 builtin/stash--helper.c 1132) fprintf_ln(stderr, _("Cannot 
save the current worktree state"));
f6f191b3f2 builtin/stash--helper.c 1133) goto done;
8002b9e626 builtin/stash--helper.c 1139) if (!quiet)
8002b9e626 builtin/stash--helper.c 1140) fprintf_ln(stderr, _("Cannot 
save the current worktree state"));
f6f191b3f2 builtin/stash--helper.c 1141) ret = -1;
f6f191b3f2 builtin/stash--helper.c 1142) *stash_msg = NULL;
f6f191b3f2 builtin/stash--helper.c 1143) goto done;
8002b9e626 builtin/stash--helper.c 1166) if (!quiet)
8002b9e626 builtin/stash--helper.c 1167) fprintf_ln(stderr, _("Cannot 
record working tree state"));
f6f191b3f2 builtin/stash--helper.c 1168) ret = -1;
f6f191b3f2 builtin/stash--helper.c 1169) goto done;
48c061fa44 builtin/stash--helper.c 1251) return -1;
8002b9e626 builtin/stash--helper.c 1260) if (!quiet)
8002b9e626 builtin/stash--helper.c 1261) fprintf_ln(stderr, _("Cannot 
initialize stash"));
48c061fa44 builtin/stash--helper.c 1262) return -1;
8002b9e626 builtin/stash--helper.c 1272) if (!quiet)
8002b9e626 builtin/stash--helper.c 1273) fprintf_ln(stderr, _("Cannot 
save the current status"));
48c061fa44 builtin/stash--helper.c 1274) ret = -1;
48c061fa44 builtin/stash--helper.c 1275) goto done;
48c061fa44 builtin/stash--helper.c 1292) ret = -1;
48c061fa44 builtin/stash--helper.c 1311) ret = -1;
48c061fa44 builtin/stash--helper.c 1312) goto done;
48c061fa44 builtin/stash--helper.c 1321) ret = -1;
48c061fa44 builtin/stash--helper.c 1322) goto done;
48c061fa44 builtin/stash--helper.c 1330) ret = -1;
48c061fa44 builtin/stash--helper.c 1339) ret = -1;
48c061fa44 builtin/stash--helper.c 1350) ret = -1;
48c061fa44 builtin/stash--helper.c 1359) ret = -1;
48c061fa44 builtin/stash--helper.c 1360) goto done;
48c061fa44 builtin/stash--helper.c 1368) ret = -1;
48c061fa44 builtin/stash--helper.c 1394) ret = -1;
129f0b0a00 builtin/stash.c         1524) 
usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
129f0b0a00 builtin/stash.c         1554) continue;

builtin/upload-archive.c
e001fd3a50 builtin/upload-archive.c 111) if (version == protocol_v0 || 
version == protocol_v1)
e001fd3a50 builtin/upload-archive.c 112) packet_write_fmt(1, "NACK 
unable to spawn subprocess\n");
e001fd3a50 builtin/upload-archive.c 113) else if (version == protocol_v2)
e001fd3a50 builtin/upload-archive.c 114) error_clnt("unable to spawn 
subprocess\n");

config.c
c780b9cfe8 2298) return val;
c780b9cfe8 2301) if (is_bool)
c780b9cfe8 2302) return val ? 0 : 1;
c780b9cfe8 2304) return val;

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

http-backend.c
fb19d32f05 646) argv[1] = ".";
fb19d32f05 647) argv[2] = NULL;

list-objects-filter-options.c
bc5975d24f  55) if (errbuf) {
bc5975d24f  56) strbuf_addstr(
bc5975d24f  60) return 1;
cc0b05a4cc  86) if (errbuf)

list-objects-filter.c
696aa73905  47) BUG("unknown filter_situation: %d", filter_situation);
bc5975d24f 101) BUG("unknown filter_situation: %d", filter_situation);
696aa73905 152) BUG("unknown filter_situation: %d", filter_situation);
696aa73905 257) BUG("unknown filter_situation: %d", filter_situation);
696aa73905 438) BUG("invalid list-objects filter choice: %d",

list-objects.c
f447a499db 197) ctx->show_object(obj, base->buf, ctx->show_data);

midx.c
e43d2dcce1  285) if (hasheq(oid.hash,
e43d2dcce1  286)    p->bad_object_sha1 + the_hash_algo->rawsz * i))

oidset.c
8b2f8cbcb1 29) kh_del_oid(&set->set, pos);
8b2f8cbcb1 30) return 1;

packfile.c
fb571c5fa7  117) return error("index file %s is too small", path);
fb571c5fa7  119) return error("empty data");

preload-index.c
ae9af12287  73) struct progress_data *pd = p->progress;
ae9af12287  75) pthread_mutex_lock(&pd->mutex);
ae9af12287  76) pd->n += last_nr - nr;
ae9af12287  77) display_progress(pd->progress, pd->n);
ae9af12287  78) pthread_mutex_unlock(&pd->mutex);
ae9af12287  79) last_nr = nr;
ae9af12287  93) struct progress_data *pd = p->progress;
ae9af12287  95) pthread_mutex_lock(&pd->mutex);
ae9af12287  96) display_progress(pd->progress, pd->n + last_nr);
ae9af12287  97) pthread_mutex_unlock(&pd->mutex);
ae9af12287 128) pd.progress = start_delayed_progress(_("Refreshing 
index"), index->cache_nr);
ae9af12287 129) pthread_mutex_init(&pd.mutex, NULL);
ae9af12287 140) p->progress = &pd;

prio-queue.c
2d181390f3 94) return queue->array[queue->nr - 1].data;

read-cache.c
ae9af12287 1490) progress = start_delayed_progress(_("Refresh index"),
ae9af12287 1491)   istate->cache_nr);
ae9af12287 1533) display_progress(progress, i);
ae9af12287 1566) display_progress(progress, istate->cache_nr);
ae9af12287 1567) stop_progress(&progress);
252d079cbd 1778) const unsigned char *cp = (const unsigned char *)name;
252d079cbd 1782) strip_len = decode_varint(&cp);
77ff1127a4 1783) if (previous_ce) {
77ff1127a4 1784) previous_len = previous_ce->ce_namelen;
77ff1127a4 1785) if (previous_len < strip_len)
252d079cbd 1786) die(_("malformed name field in the index, near path '%s'"),
77ff1127a4 1787) previous_ce->name);
77ff1127a4 1788) copy_len = previous_len - strip_len;
77ff1127a4 1790) copy_len = 0;
252d079cbd 1792) name = (const char *)cp;
252d079cbd 1798) len += copy_len;
252d079cbd 1819) if (copy_len)
252d079cbd 1820) memcpy(ce->name, previous_ce->name, copy_len);
252d079cbd 1821) memcpy(ce->name + copy_len, name, len + 1 - copy_len);
252d079cbd 1822) *ent_size = (name - ((char *)ondisk)) + len + 1 - copy_len;
abb4bb8384 1959) munmap((void *)p->mmap, p->mmap_size);
abb4bb8384 1960) die(_("index file corrupt"));
77ff1127a4 2001) mem_pool_init(&istate->ce_mem_pool,
77ff1127a4 2041) static void *load_cache_entries_thread(void *_data)
77ff1127a4 2043) struct load_cache_entries_thread_data *p = _data;
77ff1127a4 2047) for (i = p->ieot_start; i < p->ieot_start + 
p->ieot_blocks; i++) {
77ff1127a4 2048) p->consumed += load_cache_entry_block(p->istate, 
p->ce_mem_pool,
77ff1127a4 2049) p->offset, p->ieot->entries[i].nr, p->mmap, 
p->ieot->entries[i].offset, NULL);
77ff1127a4 2050) p->offset += p->ieot->entries[i].nr;
77ff1127a4 2052) return NULL;
77ff1127a4 2055) static unsigned long load_cache_entries_threaded(struct 
index_state *istate, const char *mmap, size_t mmap_size,
77ff1127a4 2060) unsigned long consumed = 0;
77ff1127a4 2063) if (istate->name_hash_initialized)
77ff1127a4 2064) BUG("the name hash isn't thread safe");
77ff1127a4 2066) mem_pool_init(&istate->ce_mem_pool, 0);
77ff1127a4 2069) if (nr_threads > ieot->nr)
77ff1127a4 2070) nr_threads = ieot->nr;
77ff1127a4 2071) data = xcalloc(nr_threads, sizeof(*data));
77ff1127a4 2073) offset = ieot_start = 0;
77ff1127a4 2074) ieot_blocks = DIV_ROUND_UP(ieot->nr, nr_threads);
77ff1127a4 2075) for (i = 0; i < nr_threads; i++) {
77ff1127a4 2076) struct load_cache_entries_thread_data *p = &data[i];
77ff1127a4 2079) if (ieot_start + ieot_blocks > ieot->nr)
77ff1127a4 2080) ieot_blocks = ieot->nr - ieot_start;
77ff1127a4 2082) p->istate = istate;
77ff1127a4 2083) p->offset = offset;
77ff1127a4 2084) p->mmap = mmap;
77ff1127a4 2085) p->ieot = ieot;
77ff1127a4 2086) p->ieot_start = ieot_start;
77ff1127a4 2087) p->ieot_blocks = ieot_blocks;
77ff1127a4 2090) nr = 0;
77ff1127a4 2091) for (j = p->ieot_start; j < p->ieot_start + 
p->ieot_blocks; j++)
77ff1127a4 2092) nr += p->ieot->entries[j].nr;
77ff1127a4 2093) if (istate->version == 4) {
77ff1127a4 2094) mem_pool_init(&p->ce_mem_pool,
77ff1127a4 2097) mem_pool_init(&p->ce_mem_pool,
77ff1127a4 2101) err = pthread_create(&p->pthread, NULL, 
load_cache_entries_thread, p);
77ff1127a4 2102) if (err)
77ff1127a4 2103) die(_("unable to create load_cache_entries thread: 
%s"), strerror(err));
77ff1127a4 2106) for (j = 0; j < ieot_blocks; j++)
77ff1127a4 2107) offset += ieot->entries[ieot_start + j].nr;
77ff1127a4 2108) ieot_start += ieot_blocks;
77ff1127a4 2111) for (i = 0; i < nr_threads; i++) {
77ff1127a4 2112) struct load_cache_entries_thread_data *p = &data[i];
77ff1127a4 2114) err = pthread_join(p->pthread, NULL);
77ff1127a4 2115) if (err)
77ff1127a4 2116) die(_("unable to join load_cache_entries thread: %s"), 
strerror(err));
77ff1127a4 2117) mem_pool_combine(istate->ce_mem_pool, p->ce_mem_pool);
77ff1127a4 2118) consumed += p->consumed;
77ff1127a4 2121) free(data);
77ff1127a4 2123) return consumed;
77ff1127a4 2192) nr_threads = cpus;
abb4bb8384 2196) extension_offset = read_eoie_extension(mmap, mmap_size);
abb4bb8384 2197) if (extension_offset) {
abb4bb8384 2200) p.src_offset = extension_offset;
abb4bb8384 2201) err = pthread_create(&p.pthread, NULL, 
load_index_extensions, &p);
abb4bb8384 2202) if (err)
abb4bb8384 2203) die(_("unable to create load_index_extensions thread: 
%s"), strerror(err));
abb4bb8384 2205) nr_threads--;
77ff1127a4 2214) ieot = read_ieot_extension(mmap, mmap_size, 
extension_offset);
77ff1127a4 2217) src_offset += load_cache_entries_threaded(istate, mmap, 
mmap_size, src_offset, nr_threads, ieot);
77ff1127a4 2218) free(ieot);
abb4bb8384 2232) int ret = pthread_join(p.pthread, NULL);
abb4bb8384 2233) if (ret)
abb4bb8384 2234) die(_("unable to join load_index_extensions thread: 
%s"), strerror(ret));
3255089ada 2775) ieot_blocks = nr_threads;
77ff1127a4 2776) if (ieot_blocks > istate->cache_nr)
77ff1127a4 2777) ieot_blocks = istate->cache_nr;
3255089ada 2785) ieot = xcalloc(1, sizeof(struct index_entry_offset_table)
3255089ada 2786) + (ieot_blocks * sizeof(struct index_entry_offset)));
77ff1127a4 2787) ieot_entries = DIV_ROUND_UP(entries, ieot_blocks);
3255089ada 2794) free(ieot);
3b1d9e045e 2795) return -1;
3255089ada 2821) ieot->entries[ieot->nr].nr = nr;
3255089ada 2822) ieot->entries[ieot->nr].offset = offset;
3255089ada 2823) ieot->nr++;
3255089ada 2829) if (previous_name)
3255089ada 2830) previous_name->buf[0] = 0;
3255089ada 2831) nr = 0;
3255089ada 2832) offset = lseek(newfd, 0, SEEK_CUR);
3255089ada 2833) if (offset < 0) {
3255089ada 2834) free(ieot);
3255089ada 2835) return -1;
3255089ada 2837) offset += write_buffer_len;
3255089ada 2847) ieot->entries[ieot->nr].nr = nr;
3255089ada 2848) ieot->entries[ieot->nr].offset = offset;
3255089ada 2849) ieot->nr++;
3255089ada 2861) free(ieot);
3b1d9e045e 2862) return -1;
3255089ada 2876) struct strbuf sb = STRBUF_INIT;
3255089ada 2878) write_ieot_extension(&sb, ieot);
3255089ada 2879) err = write_index_ext_header(&c, &eoie_c, newfd, 
CACHE_EXT_INDEXENTRYOFFSETTABLE, sb.len) < 0
3255089ada 2880) || ce_write(&c, newfd, sb.buf, sb.len) < 0;
3255089ada 2881) strbuf_release(&sb);
3255089ada 2882) free(ieot);
3255089ada 2883) if (err)
3255089ada 2884) return -1;
3b1d9e045e 3372) static size_t read_eoie_extension(const char *mmap, 
size_t mmap_size)
3b1d9e045e 3390) if (mmap_size < sizeof(struct cache_header) + 
EOIE_SIZE_WITH_HEADER + the_hash_algo->rawsz)
3b1d9e045e 3391) return 0;
3b1d9e045e 3394) index = eoie = mmap + mmap_size - EOIE_SIZE_WITH_HEADER 
- the_hash_algo->rawsz;
3b1d9e045e 3395) if (CACHE_EXT(index) != CACHE_EXT_ENDOFINDEXENTRIES)
3b1d9e045e 3396) return 0;
3b1d9e045e 3397) index += sizeof(uint32_t);
3b1d9e045e 3400) extsize = get_be32(index);
3b1d9e045e 3401) if (extsize != EOIE_SIZE)
3b1d9e045e 3402) return 0;
3b1d9e045e 3403) index += sizeof(uint32_t);
3b1d9e045e 3409) offset = get_be32(index);
3b1d9e045e 3410) if (mmap + offset < mmap + sizeof(struct cache_header))
3b1d9e045e 3411) return 0;
3b1d9e045e 3412) if (mmap + offset >= eoie)
3b1d9e045e 3413) return 0;
3b1d9e045e 3414) index += sizeof(uint32_t);
3b1d9e045e 3425) src_offset = offset;
3b1d9e045e 3426) the_hash_algo->init_fn(&c);
3b1d9e045e 3427) while (src_offset < mmap_size - the_hash_algo->rawsz - 
EOIE_SIZE_WITH_HEADER) {
3b1d9e045e 3435) memcpy(&extsize, mmap + src_offset + 4, 4);
3b1d9e045e 3436) extsize = ntohl(extsize);
3b1d9e045e 3439) if (src_offset + 8 + extsize < src_offset)
3b1d9e045e 3440) return 0;
3b1d9e045e 3442) the_hash_algo->update_fn(&c, mmap + src_offset, 8);
3b1d9e045e 3444) src_offset += 8;
3b1d9e045e 3445) src_offset += extsize;
3b1d9e045e 3447) the_hash_algo->final_fn(hash, &c);
3b1d9e045e 3448) if (!hasheq(hash, (const unsigned char *)index))
3b1d9e045e 3449) return 0;
3b1d9e045e 3452) if (src_offset != mmap_size - the_hash_algo->rawsz - 
EOIE_SIZE_WITH_HEADER)
3b1d9e045e 3453) return 0;
3b1d9e045e 3455) return offset;
3255089ada 3475) static struct index_entry_offset_table 
*read_ieot_extension(const char *mmap, size_t mmap_size, size_t offset)
3255089ada 3477)        const char *index = NULL;
3255089ada 3483)        if (!offset)
3255089ada 3484)        return NULL;
3255089ada 3485)        while (offset <= mmap_size - 
the_hash_algo->rawsz - 8) {
3255089ada 3486)        extsize = get_be32(mmap + offset + 4);
3255089ada 3487)        if (CACHE_EXT((mmap + offset)) == 
CACHE_EXT_INDEXENTRYOFFSETTABLE) {
3255089ada 3488)        index = mmap + offset + 4 + 4;
3255089ada 3489)        break;
3255089ada 3491)        offset += 8;
3255089ada 3492)        offset += extsize;
3255089ada 3494)        if (!index)
3255089ada 3495)        return NULL;
3255089ada 3498)        ext_version = get_be32(index);
3255089ada 3499)        if (ext_version != IEOT_VERSION) {
3255089ada 3500)        error("invalid IEOT version %d", ext_version);
3255089ada 3501)        return NULL;
3255089ada 3503)        index += sizeof(uint32_t);
3255089ada 3506)        nr = (extsize - sizeof(uint32_t)) / 
(sizeof(uint32_t) + sizeof(uint32_t));
3255089ada 3507)        if (!nr) {
3255089ada 3508)        error("invalid number of IEOT entries %d", nr);
3255089ada 3509)        return NULL;
3255089ada 3511)        ieot = xmalloc(sizeof(struct 
index_entry_offset_table)
3255089ada 3512)        + (nr * sizeof(struct index_entry_offset)));
3255089ada 3513)        ieot->nr = nr;
3255089ada 3514)        for (i = 0; i < nr; i++) {
3255089ada 3515)        ieot->entries[i].offset = get_be32(index);
3255089ada 3516)        index += sizeof(uint32_t);
3255089ada 3517)        ieot->entries[i].nr = get_be32(index);
3255089ada 3518)        index += sizeof(uint32_t);
3255089ada 3521)        return ieot;
3255089ada 3524) static void write_ieot_extension(struct strbuf *sb, 
struct index_entry_offset_table *ieot)
3255089ada 3530)        put_be32(&buffer, IEOT_VERSION);
3255089ada 3531)        strbuf_add(sb, &buffer, sizeof(uint32_t));
3255089ada 3534)        for (i = 0; i < ieot->nr; i++) {
3255089ada 3537)        put_be32(&buffer, ieot->entries[i].offset);
3255089ada 3538)        strbuf_add(sb, &buffer, sizeof(uint32_t));
3255089ada 3541)        put_be32(&buffer, ieot->entries[i].nr);
3255089ada 3542)        strbuf_add(sb, &buffer, sizeof(uint32_t));
3255089ada 3544) }

rebase-interactive.c
64a43cbd5d 61) return error_errno(_("could not read '%s'."), todo_file);
64a43cbd5d 65) strbuf_release(&buf);
64a43cbd5d 66) return -1;
a9f5476fbc 74) return error_errno(_("could not read '%s'."), todo_file);
a9f5476fbc 78) strbuf_release(&buf);
a9f5476fbc 79) return -1;
64a43cbd5d 85) return -1;

revision.c
4943d28849 2931) return;
4943d28849 2934) return;
4943d28849 2937) c->object.flags |= UNINTERESTING;
4943d28849 2940) return;
4943d28849 2943) mark_parents_uninteresting(c);
4943d28849 2966) return;
4943d28849 2969) return;
4943d28849 2974) return;
4943d28849 3019) info->topo_queue.compare = compare_commits_by_commit_date;
4943d28849 3020) break;
4943d28849 3022) init_author_date_slab(&info->author_date);
4943d28849 3023) info->topo_queue.compare = compare_commits_by_author_date;
4943d28849 3024) info->topo_queue.cb_data = &info->author_date;
4943d28849 3025) break;
4943d28849 3038) continue;
4943d28849 3048) record_author_date(&info->author_date, c);
6c04ff3001 3086) if (!revs->ignore_missing_links)
6c04ff3001 3087) die("Failed to traverse parents of commit %s",
4943d28849 3088) oid_to_hex(&commit->object.oid));
4943d28849 3096) continue;

sequencer.c
65850686cf 2276) return;
65850686cf 2373) write_file(rebase_path_quiet(), "%s\n", quiet);
2c58483a59 3371) return error(_("could not checkout %s"), commit);
4df66c40b0 3385) return error(_("%s: not a valid OID"), orig_head);
b97e187364 4748) return -1;
b97e187364 4751) return -1;
b97e187364 4757) return error_errno(_("could not read '%s'."), todo_file);
b97e187364 4760) todo_list_release(&todo_list);
b97e187364 4761) return error(_("unusable todo list: '%s'"), todo_file);
b97e187364 4780) todo_list_release(&todo_list);
b97e187364 4781) return -1;
b97e187364 4785) return error(_("could not copy '%s' to '%s'."), todo_file,
b97e187364 4789) return error(_("could not transform the todo list"));
b97e187364 4818) return error(_("could not transform the todo list"));
b97e187364 4821) return error(_("could not skip unnecessary pick 
commands"));
b97e187364 4827) return -1;

split-index.c
568f3a6073 310) const unsigned int ondisk_flags =
568f3a6073 314) ce_flags = ce->ce_flags;
568f3a6073 315) base_flags = base->ce_flags;
568f3a6073 317) ce->ce_flags   &= ondisk_flags;
568f3a6073 318) base->ce_flags &= ondisk_flags;
568f3a6073 319) ret = memcmp(&ce->ce_stat_data, &base->ce_stat_data,
568f3a6073 322) ce->ce_flags = ce_flags;
568f3a6073 323) base->ce_flags = base_flags;
568f3a6073 324) if (ret)
568f3a6073 325) ce->ce_flags |= CE_UPDATE_IN_BASE;

strbuf.c
f95736288a  127) --sb->len;

transport-helper.c
fb19d32f05  643) if (!data->connect && !data->stateless_connect)

transport.c
99bcb883cb  299) BUG("buffer must be empty at the end of handshake()");

Commits introducing uncovered code:
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
Ben Peart      3255089ad: ieot: add Index Entry Offset Table (IEOT) 
extension
Ben Peart      3b1d9e045: eoie: add End of Index Entry (EOIE) extension
Ben Peart      77ff1127a: read-cache: load cache entries on worker threads
Ben Peart      abb4bb838: read-cache: load cache extensions on a worker 
thread
Ben Peart      c780b9cfe: config: add new index.threads config setting
Derrick Stolee      2d181390f: prio-queue: add 'peek' operation
Derrick Stolee      4943d2884: revision.c: refactor basic topo-order logic
Derrick Stolee      6c04ff300: revision.c: begin refactoring 
--topo-order logic
Harald Nordgren      250edfa8c: bisect: create 'bisect_flags' parameter 
in find_bisection()
Jeff King      e43d2dcce: more oideq/hasheq conversions
Joel Teichroeb      31f109a36: stash: convert drop and clear to builtin
Joel Teichroeb      93871263d: stash: convert apply to builtin
Joel Teichroeb      b3513da4b: stash: convert pop to builtin
Johannes Schindelin      bc24382c2: builtin rebase: prepare for builtin 
rebase -i
Jonathan Tan      99bcb883c: transport: allow skipping of ref listing
Josh Steadmon      e001fd3a5: archive: implement protocol v2 archive command
Josh Steadmon      fb19d32f0: archive: allow archive over HTTP(S) with 
proto v2
Josh Steadmon      fb571c5fa: fuzz: add fuzz testing for packfile indices
Junio C Hamano      7bbc53a58: fetch: replace string-list used as a 
look-up table with a hashmap
Matthew DeVore      696aa7390: list-objects-filter: use BUG rather than die
Matthew DeVore      7c0fe330d: rev-list: handle missing tree objects 
properly
Matthew DeVore      bc5975d24: list-objects-filter: implement filter tree:0
Matthew DeVore      cc0b05a4c: list-objects-filter-options: do not 
over-strbuf_init
Matthew DeVore      f447a499d: list-objects: store common func args in 
struct
Nguyễn Thái Ngọc Duy      252d079cb: read-cache.c: optimize reading 
index format v4
Nguyễn Thái Ngọc Duy      26c7d0678: help -a: improve and make --verbose 
default
Nguyễn Thái Ngọc Duy      ae9af1228: status: show progress bar if 
refreshing the index takes too long
Paul-Sebastian Ungureanu      0ac06fb81: stash: convert store to builtin
Paul-Sebastian Ungureanu      129f0b0a0: stash: convert 
`stash--helper.c` into `stash.c`
Paul-Sebastian Ungureanu      48c061fa4: stash: convert push to builtin
Paul-Sebastian Ungureanu      8002b9e62: stash: make push -q quiet
Paul-Sebastian Ungureanu      8ceb24b2c: stash: convert show to builtin
Paul-Sebastian Ungureanu      f6f191b3f: stash: convert create to builtin
Pratik Karki      002ee2fe6: builtin rebase: support `keep-empty` option
Pratik Karki      0eabf4b95: builtin rebase: stop if `git am` is in progress
Pratik Karki      12026a412: builtin rebase: support `--gpg-sign` option
Pratik Karki      122420c29: builtin rebase: support --skip
Pratik Karki      1ed9c14ff: builtin rebase: support --force-rebase
Pratik Karki      3c3588c7d: builtin rebase: support 
--rebase-merges[=[no-]rebase-cousins]
Pratik Karki      51e9ea6da: builtin rebase: support --edit-todo and 
--show-current-patch
Pratik Karki      53f9e5be9: builtin rebase: support `ignore-date` option
Pratik Karki      55071ea24: rebase: start implementing it as a builtin
Pratik Karki      5a6149453: builtin rebase: support --quit
Pratik Karki      5e5d96197: builtin rebase: support --abort
Pratik Karki      6defce2b0: builtin rebase: support `--autostash` option
Pratik Karki      73d51ed0a: builtin rebase: support --signoff
Pratik Karki      7998dbe1e: builtin rebase: support `-C` and 
`--whitespace=<type>`
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
Pratik Karki      d4c569f8f: builtin rebase: only store fully-qualified 
refs in `options.head_name`
Pratik Karki      e0333e5c6: builtin rebase: require a clean worktree
Pratik Karki      e65123a71: builtin rebase: support `git rebase 
<upstream> <switch-to>`
Pratik Karki      ead98c111: builtin rebase: support --rerere-autoupdate
Pratik Karki      f28d40d3a: builtin rebase: support --onto
Pratik Karki      f95736288: builtin rebase: support --continue
René Scharfe      8b2f8cbcb: oidset: use khash
SZEDER Gábor      568f3a607: split-index: don't compare stat data of 
entries already marked for split index

Uncovered code new in next, compared to master. Build logs at [2]
-----------------------------------------------------------------

blame.c
a470beea39  113)  !strcmp(r->index->cache[-1 - pos]->name, path))
a470beea39  272) int pos = index_name_pos(r->index, path, len);
a470beea39  274) mode = r->index->cache[pos]->ce_mode;

builtin/am.c
2abf350385 1414) repo_init_revisions(the_repository, &rev_info, NULL);

builtin/gc.c
3029970275 builtin/gc.c 461) ret = error_errno(_("cannot stat '%s'"), 
gc_log_path);
3029970275 builtin/gc.c 470) ret = error_errno(_("cannot read '%s'"), 
gc_log_path);
fec2ed2187 builtin/gc.c 495) die(FAILED_RUN, pack_refs_cmd.argv[0]);
fec2ed2187 builtin/gc.c 498) die(FAILED_RUN, reflog.argv[0]);a
3029970275 builtin/gc.c 585) exit(128);
fec2ed2187 builtin/gc.c 637) die(FAILED_RUN, repack.argv[0]);
fec2ed2187 builtin/gc.c 647) die(FAILED_RUN, prune.argv[0]);
fec2ed2187 builtin/gc.c 654) die(FAILED_RUN, prune_worktrees.argv[0]);
fec2ed2187 builtin/gc.c 658) die(FAILED_RUN, rerere.argv[0]);

builtin/pack-objects.c
2fa233a554 builtin/pack-objects.c 1512) hashcpy(base_oid.hash, base_sha1);
2fa233a554 builtin/pack-objects.c 1513) if 
(!in_same_island(&delta->idx.oid, &base_oid))
2fa233a554 builtin/pack-objects.c 1514) return 0;

commit-graph.c
20fd6d5799   79) return 0;

diff.c
b78ea5fc35 4117) add_external_diff_name(o->repo, &argv, other, two);

refs.c
4a6067cda5 1405) return 0;

revision.c
2abf350385 1526) if (ce_path_match(istate, ce, &revs->prune_data, NULL)) {
2abf350385 1532) while ((i+1 < istate->cache_nr) &&
2abf350385 1533)        ce_same_name(ce, istate->cache[i+1]))

wt-status.c
f3bd35fa0d  671) s->committable = 1;
73ba5d78b4 1953) if (s->state.rebase_in_progress ||
73ba5d78b4 1954)     s->state.rebase_interactive_in_progress)
73ba5d78b4 1955) branch_name = s->state.onto;
73ba5d78b4 1956) else if (s->state.detached_from)
73ba5d78b4 1957) branch_name = s->state.detached_from;

Commits introducing uncovered code:
Derrick Stolee      20fd6d579: commit-graph: not compatible with grafts
Jeff King      2fa233a55: pack-objects: handle island check for 
"external" delta base
Jonathan Nieder      302997027: gc: do not return error for prior errors 
in daemonized mode
Jonathan Nieder      fec2ed218: gc: exit with status 128 on failure
Nguyễn Thái Ngọc Duy      2abf35038: revision.c: remove implicit 
dependency on the_index
Nguyễn Thái Ngọc Duy      a470beea3: blame.c: rename "repo" argument to "r"
Nguyễn Thái Ngọc Duy      b78ea5fc3: diff.c: reduce implicit dependency 
on the_index
Stefan Beller      4a6067cda: refs.c: migrate internal ref iteration to 
pass thru repository argument
Stephen P. Smith      73ba5d78b: roll wt_status_state into wt_status and 
populate in the collect phase
Stephen P. Smith      f3bd35fa0: wt-status.c: set the committable flag 
in the collect phase


Uncovered code new in master, compared to maint. Build logs at [3]
------------------------------------------------------------------

builtin/checkout.c
fa655d8411 builtin/checkout.c  537) return 0;
fa655d8411 builtin/checkout.c  951) return error(_("index file corrupt"));

builtin/commit.c
859fdc0c3c builtin/commit.c 1657) 
write_commit_graph_reachable(get_object_directory(), 0);

builtin/difftool.c
4a7e27e957 441) if (oideq(&loid, &roid))

builtin/fsck.c
454ea2e4d7 builtin/fsck.c 743) for (p = get_all_packs(the_repository); p;
66ec0390e7 builtin/fsck.c 862) midx_argv[2] = "--object-dir";
66ec0390e7 builtin/fsck.c 863) midx_argv[3] = alt->path;
66ec0390e7 builtin/fsck.c 864) if (run_command(&midx_verify))
66ec0390e7 builtin/fsck.c 865) errors_found |= ERROR_COMMIT_GRAPH;

builtin/log.c
2e6fd71a52 builtin/log.c 1461) die(_("failed to infer range-diff ranges"));
ee6cbf712e builtin/log.c 1807) die(_("--interdiff requires 
--cover-letter or single patch"));
8631bf1cdd builtin/log.c 1817) else if (!rdiff_prev)
8631bf1cdd builtin/log.c 1818) die(_("--creation-factor requires 
--range-diff"));
40ce41604d builtin/log.c 1822) die(_("--range-diff requires 
--cover-letter or single patch"));

builtin/multi-pack-index.c
6d68e6a461 35) usage_with_options(builtin_multi_pack_index_usage,
6d68e6a461 39) die(_("too many arguments"));
6d68e6a461 48) die(_("unrecognized verb: %s"), argv[0]);

builtin/pack-objects.c
6a22d52126 builtin/pack-objects.c 1079) if (fill_midx_entry(oid, &e, m)) {
6a22d52126 builtin/pack-objects.c 1080) struct packed_git *p = e.p;
6a22d52126 builtin/pack-objects.c 1083) if (p == *found_pack)
6a22d52126 builtin/pack-objects.c 1084) offset = *found_offset;
6a22d52126 builtin/pack-objects.c 1086) offset = 
find_pack_entry_one(oid->hash, p);
6a22d52126 builtin/pack-objects.c 1088) if (offset) {
6a22d52126 builtin/pack-objects.c 1089) if (!*found_pack) {
6a22d52126 builtin/pack-objects.c 1090) if (!is_pack_valid(p))
6a22d52126 builtin/pack-objects.c 1091) continue;
6a22d52126 builtin/pack-objects.c 1092) *found_offset = offset;
6a22d52126 builtin/pack-objects.c 1093) *found_pack = p;
6a22d52126 builtin/pack-objects.c 1095) want = 
want_found_object(exclude, p);
6a22d52126 builtin/pack-objects.c 1096) if (want != -1)
6a22d52126 builtin/pack-objects.c 1097) return want;
28b8a73080 builtin/pack-objects.c 2778) depth++;
108f530385 builtin/pack-objects.c 2782) oe_set_tree_depth(&to_pack, ent, 
depth);
454ea2e4d7 builtin/pack-objects.c 2966) p = get_all_packs(the_repository);

builtin/pack-redundant.c
454ea2e4d7 builtin/pack-redundant.c 580) struct packed_git *p = 
get_all_packs(the_repository);
454ea2e4d7 builtin/pack-redundant.c 595) struct packed_git *p = 
get_all_packs(the_repository);

builtin/remote.c
5025425dff builtin/remote.c  864) return error(_("No such remote: 
'%s'"), name);

builtin/repack.c
16d75fa48d  48) use_delta_islands = git_config_bool(var, value);
16d75fa48d  49) return 0;

builtin/rerere.c
2373b65059 builtin/rerere.c  78) warning(_("'git rerere forget' without 
paths is deprecated"));
2373b65059 builtin/rerere.c 110) die(_("unable to generate diff for 
'%s'"), rerere_path(id, NULL));

builtin/show-branch.c
9001dc2a74 builtin/show-branch.c 430) if (get_oid(refname + ofs, &tmp) 
|| !oideq(&tmp, oid))

builtin/submodule--helper.c
ee69b2a90c 1462) die(_("Invalid update mode '%s' for submodule path '%s'"),
ee69b2a90c 1466) die(_("Invalid update mode '%s' configured for 
submodule path '%s'"),
ee69b2a90c 1469) trace_printf("loaded thing");
ee69b2a90c 1470) out->type = sub->update_strategy.type;
ee69b2a90c 1471) out->command = sub->update_strategy.command;
ee69b2a90c 1491) die("submodule--helper update-module-clone expects 
<just-cloned> <path> [<update>]");
74d4731da1 2033) BUG("submodule--helper connect-gitdir-workingtree 
<name> <path>");
74d4731da1 2039) BUG("We could get the submodule handle before?");
74d4731da1 2042) die(_("could not get a repository handle for submodule 
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

cache-tree.c
4592e6080f 762) BUG("%s with flags 0x%x should not be in cache-tree",
4592e6080f 770) BUG("bad subtree '%.*s'", entlen, name);
4592e6080f 785) BUG("cache-tree for path %.*s does not match. "

commit-graph.c
6cc017431c  247) return 0;

commit-reach.c
5227c38566  63) BUG("bad generation skip %8x > %8x at %s",
5227c38566 134) return ret;
5227c38566 282) return 1;
5227c38566 314) return ret;
5227c38566 317) return ret;
5227c38566 323) return ret;
1d614d41e5 395) return 0;
1d614d41e5 401) return 0;
1d614d41e5 405) return 0;
920f93ca1c 459) return CONTAINS_NO;
920f93ca1c 484) cutoff = c->generation;
b67f6b26e3 559) continue;
b67f6b26e3 569) from->objects[i].item->flags |= assign_flag;
b67f6b26e3 570) continue;
b67f6b26e3 576) result = 0;
b67f6b26e3 577) goto cleanup;

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
9001dc2a74 diff-lib.c 345)     (!oideq(oid, &old_entry->oid) || 
!oideq(&old_entry->oid, &new_entry->oid))) {

dir.c
c46c406ae1 2275) trace_performance_leave("read directory %.*s", len, path);

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

ll-merge.c
d64324cb60 379) marker_size = DEFAULT_CONFLICT_MARKER_SIZE;

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
a40498a126  188) close_pack(m->packs[i]);
a40498a126  189) free(m->packs);
3715a6335c  262) return 0;
3715a6335c  278) return 0;
c39b02ae0a  283) nth_midxed_object_oid(&oid, m, pos);
c39b02ae0a  284) for (i = 0; i < p->num_bad_objects; i++)
c39b02ae0a  285) if (!hashcmp(oid.hash,
c39b02ae0a  286)      p->bad_object_sha1 + the_hash_algo->rawsz * i))
c39b02ae0a  287) return 0;
c4d25228eb  341) return 1;
396f257018  398) warning(_("failed to add packfile '%s'"),
396f257018  400) return;
fe1ed56f5e  404) warning(_("failed to open pack-index '%s'"),
fe1ed56f5e  406) close_pack(packs->list[packs->nr]);
fe1ed56f5e  407) FREE_AND_NULL(packs->list[packs->nr]);
fe1ed56f5e  408) return;
a40498a126  481) return 1;
fe1ed56f5e  498) die(_("failed to locate object %d in packfile"), 
cur_object);
32f3c541e3  611) BUG("incorrect pack-file order: %s before %s",
0d5b3a5ef7  673) BUG("OIDs not in order: %s >= %s",
662148c435  700) BUG("object %s requires a large offset (%"PRIx64") but 
the MIDX is not writing large offsets!",
fc59e74844  754) die_errno(_("unable to create leading directories of %s"),
a40498a126  784) goto cleanup;
32f3c541e3  843) BUG("incorrect chunk offsets: %"PRIu64" before %"PRIu64,
32f3c541e3  848) BUG("chunk offset %"PRIu64" is not properly aligned",
32f3c541e3  860) BUG("incorrect chunk offset (%"PRIu64" != %"PRIu64") 
for chunk id %"PRIx32,
32f3c541e3  887) BUG("trying to write unknown chunk id %"PRIx32,
32f3c541e3  893) BUG("incorrect final offset %"PRIu64" != %"PRIu64,
525e18c04b  923) die(_("failed to clear multi-pack-index at %s"), midx);
56ee7ff156  949) return 0;
cc6af73c02  990) midx_report(_("failed to load pack-index for packfile %s"),
cc6af73c02  991)     e.p->pack_name);
cc6af73c02  992) break;

pack-bitmap.c
30cdc33fba 1130) return 0;

pack-objects.c
108f530385 169) REALLOC_ARRAY(pdata->tree_depth, pdata->nr_alloc);
fe0ac2fb7f 172) REALLOC_ARRAY(pdata->layer, pdata->nr_alloc);
108f530385 189) pdata->tree_depth[pdata->nr_objects - 1] = 0;
fe0ac2fb7f 192) pdata->layer[pdata->nr_objects - 1] = 0;

packfile.c
fe1ed56f5e  205) if (open_pack_index(p))
fe1ed56f5e  206) return 0;
fe1ed56f5e  207) level1_ofs = p->index_data;
17c35c8969  479) break;
17c35c8969  483) return error("packfile %s index unavailable", 
p->pack_name);
17c35c8969  537) return 0;

refs/packed-backend.c
9001dc2a74 1163) } else if (!oideq(&update->old_oid, iter->oid)) {

refs/ref-cache.c
9001dc2a74 275) if (!oideq(&ref1->u.value.oid, &ref2->u.value.oid))

rerere.c
2373b65059  216) die(_("corrupt MERGE_RR"));
2373b65059  225) die(_("corrupt MERGE_RR"));
2373b65059  228) die(_("corrupt MERGE_RR"));
2373b65059  263) die(_("unable to write rerere record"));
2373b65059  268) die(_("unable to write rerere record"));
4af32207bc  375) break;
4af32207bc  379) strbuf_addbuf(&two, &conflict);
c0f16f8e14  383) break;
c0f16f8e14  387) break;
c0f16f8e14  391) break;
2373b65059  476) return error_errno(_("could not open '%s'"), path);
2373b65059  481) error_errno(_("could not write '%s'"), output);
2373b65059  491) error(_("there were errors while writing '%s' (%s)"),
2373b65059  494) io.io.wrerror = error_errno(_("failed to flush '%s'"), 
path);
2373b65059  560) return error(_("index file corrupt"));
2373b65059  593) return error(_("index file corrupt"));
2373b65059  676) warning_errno(_("failed utime() on '%s'"),
2373b65059  682) return error_errno(_("could not open '%s'"), path);
2373b65059  684) error_errno(_("could not write '%s'"), path);
2373b65059  686) return error_errno(_("writing '%s' failed"), path);
2373b65059  712) die(_("unable to write new index file"));
2373b65059  794) die_errno(_("cannot unlink stray '%s'"), path);
2373b65059 1043) error(_("failed to update conflicted state in '%s'"), 
path);
2373b65059 1061) error(_("no remembered resolution for '%s'"), path);
2373b65059 1063) error_errno(_("cannot unlink '%s'"), filename);
2373b65059 1097) return error(_("index file corrupt"));
2373b65059 1185) die_errno(_("unable to open rr-cache directory"));

revision.c
4a7e27e957 3241)     oideq(&p->item->object.oid, &commit->object.oid))

sha1-file.c
67947c34ae sha1-file.c 2216) if (!hasheq(expected_sha1, real_sha1)) {

sha1-name.c
8aac67a174 sha1-name.c  154) static void unique_in_midx(struct 
multi_pack_index *m,
8aac67a174 sha1-name.c  157) uint32_t num, i, first = 0;
8aac67a174 sha1-name.c  158) const struct object_id *current = NULL;
8aac67a174 sha1-name.c  159) num = m->num_objects;
8aac67a174 sha1-name.c  161) if (!num)
8aac67a174 sha1-name.c  162) return;
8aac67a174 sha1-name.c  164) bsearch_midx(&ds->bin_pfx, m, &first);
8aac67a174 sha1-name.c  171) for (i = first; i < num && !ds->ambiguous; 
i++) {
8aac67a174 sha1-name.c  173) current = nth_midxed_object_oid(&oid, m, i);
8aac67a174 sha1-name.c  174) if (!match_sha(ds->len, ds->bin_pfx.hash, 
current->hash))
8aac67a174 sha1-name.c  175) break;
8aac67a174 sha1-name.c  176) update_candidates(ds, current);
8aac67a174 sha1-name.c  212)      m = m->next)
8aac67a174 sha1-name.c  213) unique_in_midx(m, ds);
8aac67a174 sha1-name.c  573) return;

trace.c
c46c406ae1 189) now = getnanotime();
c46c406ae1 190) perf_start_times[perf_indent] = now;
c46c406ae1 191) if (perf_indent + 1 < ARRAY_SIZE(perf_start_times))
c46c406ae1 192) perf_indent++;
c46c406ae1 194) BUG("Too deep indentation");
c46c406ae1 195) return now;
c46c406ae1 211) if (perf_indent >= strlen(space))
c46c406ae1 212) BUG("Too deep indentation");
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

unpack-trees.c
b878579ae7  360) string_list_append(&list, ce->name);
b878579ae7  361) ce->ce_flags &= ~CE_MATCHED;
b878579ae7  368) warning(_("the following paths have collided (e.g. 
case-sensitive paths\n"
b878579ae7  372) for (i = 0; i < list.nr; i++)
b878579ae7  373) fprintf(stderr, "  '%s'\n", list.items[i].string);
b4da37380b  715) BUG("This is a directory and should not exist in index");
b4da37380b  719) BUG("pos must point at the first entry in this directory");
b4da37380b  740) BUG("We need cache-tree to do this optimization");
f1e11c6510  777) free(tree_ce);
b4da37380b  778) return rc;
b4da37380b  785) printf("Unpacked %d entries from %s to %s using 
cache-tree\n",
b4da37380b  787)        o->src_index->cache[pos]->name,
b4da37380b  788)        o->src_index->cache[pos + nr_entries - 1]->name);
b4da37380b  811) BUG("Wrong condition to get here buddy");

Commits introducing uncovered code:
Ben Peart      fa655d841: checkout: optimize "git checkout -b <new_branch>"
Christian Couder      108f53038: pack-objects: move tree_depth into 
'struct packing_data'
Christian Couder      fe0ac2fb7: pack-objects: move 'layer' into 'struct 
packing_data'
Derrick Stolee      0d5b3a5ef: midx: write object ids in a chunk
Derrick Stolee      17c35c896: packfile: skip loading index if in 
multi-pack-index
Derrick Stolee      1d614d41e: commit-reach: move ref_newer from remote.c
Derrick Stolee      32f3c541e: multi-pack-index: write pack names in chunk
Derrick Stolee      3715a6335: midx: read objects from multi-pack-index
Derrick Stolee      396f25701: multi-pack-index: read packfile list
Derrick Stolee      454ea2e4d: treewide: use get_all_packs
Derrick Stolee      4d80560c5: multi-pack-index: load into memory
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
Derrick Stolee      859fdc0c3: commit-graph: define GIT_TEST_COMMIT_GRAPH
Derrick Stolee      8aac67a17: midx: use midx in abbreviation calculations
Derrick Stolee      920f93ca1: commit-reach: move commit_contains from 
ref-filter
Derrick Stolee      a40498a12: midx: use existing midx when writing new one
Derrick Stolee      b67f6b26e: commit-reach: properly peel tags
Derrick Stolee      c39b02ae0: midx: mark bad packed objects
Derrick Stolee      c4d25228e: config: create core.multiPackIndex setting
Derrick Stolee      cc6af73c0: multi-pack-index: verify object offsets
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
Jeff King      16d75fa48: repack: add delta-islands support
Jeff King      28b8a7308: pack-objects: add delta-islands support
Jeff King      30cdc33fb: pack-bitmap: save "have" bitmap from walk
Jeff King      4a7e27e95: convert "oidcmp() == 0" to oideq()
Jeff King      67947c34a: convert "hashcmp() != 0" to "!hasheq()"
Jeff King      9001dc2a7: convert "oidcmp() != 0" to "!oideq()"
Jeff King      c8d521faf: Add delta-islands.{c,h}
Nguyễn Thái Ngọc Duy      4592e6080: cache-tree: verify valid cache-tree 
in the test suite
Nguyễn Thái Ngọc Duy      b4da37380: unpack-trees: optimize walking same 
trees with cache-tree
Nguyễn Thái Ngọc Duy      c46c406ae: trace.h: support nested performance 
tracing
Nguyễn Thái Ngọc Duy      f1e11c651: unpack-trees: reduce malloc in 
cache-tree walk
René Scharfe      3aa4d81f8: mailinfo: support format=flowed
René Scharfe      fb8952077: fsck: use strbuf_getline() to read skiplist 
file
Shulhan      5025425df: builtin/remote: quote remote name on error to 
display empty name
Stefan Beller      74d4731da: submodule--helper: replace 
connect-gitdir-workingtree by ensure-core-worktree
Stefan Beller      ee69b2a90: submodule--helper: introduce new 
update-module-mode helper
Thomas Gummerer      2373b6505: rerere: mark strings for translation
Thomas Gummerer      4af32207b: rerere: teach rerere to handle nested 
conflicts
Thomas Gummerer      c0f16f8e1: rerere: factor out handle_conflict function
Torsten Bögershausen      d64324cb6: Make git_check_attr() a void function


[1] https://dev.azure.com/git/git/_build/results?buildId=172&view=logs
     Build running coverage-test for 'jch' and coverage-diff.sh against 
'next'

[2] https://git.visualstudio.com/git/_build/results?buildId=166&view=logs
     Build running coverage-test for 'next' and coverage-diff.sh against 
'master'

[3] https://dev.azure.com/git/git/_build/results?buildId=171&view=logs
     Build running coverage-test for 'master' and coverage-diff.sh 
against 'maint'
