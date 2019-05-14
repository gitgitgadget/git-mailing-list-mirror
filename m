Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F2BC1F461
	for <e@80x24.org>; Tue, 14 May 2019 00:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfENAlr (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 20:41:47 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43294 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfENAlq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 20:41:46 -0400
Received: by mail-qt1-f193.google.com with SMTP id r3so17024669qtp.10
        for <git@vger.kernel.org>; Mon, 13 May 2019 17:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=t4gmuSAd3qqmoY9lmTsnfWFp44bzrDlYRtzmAJ3DsxU=;
        b=G1B0HpmAbX1sMTi2745DtO3vYX+6vQLcfgshxm+gu4HOo2AJM33DCCbT08DlnKzg/a
         SFkDysPN4kLBxxDA0TtHMtE6VQXxxS4p2IUUvN4ya2NX1r07qcyMXA9ykAWTKrHfDDJV
         tTu8vB7qyUU4P3/sVztSL/p57wx2UVf2xXqN13OSzP9Kvyyx3PRsNnUuxJbCruorGhXu
         jgKTEaTxbZcqbP25sTjCpM6uRbfQ7IJv0GqffLEE97jjrcTm+Gw66370rEKxrtI94swB
         8PnG2KYHJxMtiMW31h1uI5m5CLWLTmnioWPWNTp2r6GpG2YLcTpA126XtkVdMHbvgE0b
         RElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=t4gmuSAd3qqmoY9lmTsnfWFp44bzrDlYRtzmAJ3DsxU=;
        b=hD5u++ZtgBIHi3CxiB25E3ThmE6ncefwb34HbqfISShtC/vl7T7udYfUvY7UBWuDhr
         de98fOic0IiErST/dWrTSytNptPPDRpUA4SSsb1CurvzJYNA9glpKwDuRc/2Flu160im
         DPFaI+awa9bSq5gzM1KEY56Wh6ZsZQjE8lnxekJptXY2dcclgRXeRjyWlFXwIXVfd+5P
         4ldn7+ZJpiq+lIlLh/wIptJ5wfxSPKPrD+7wLSJIjAZ3c19SA41IB6FCRnxbb0ZIG1dT
         6EZzVpBlq1VwkaF3nPGMsUhAGjMA7gp3wLr3jL3XHwbKa7HwHnrpcn6/Dwp9xkVM+Phb
         jdoA==
X-Gm-Message-State: APjAAAXTCgX9BUjFZ3SOYrJeFdPSBX1ZthhCBeUmXRw8dmcOLNlgLXCe
        xMDbfV9e+0SPEIr+TZgKzcluKAvLJMM=
X-Google-Smtp-Source: APXvYqw/h9FBs/ZmUbcc8EFTqu9O47dw3Q7ws4mQ6WqM8vwl6yTuQ2h1TLY4MLjze8dmOWALncOJuA==
X-Received: by 2002:a05:6214:10e1:: with SMTP id q1mr25285911qvt.39.1557794502171;
        Mon, 13 May 2019 17:41:42 -0700 (PDT)
Received: from [10.0.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id g55sm12319538qtk.76.2019.05.13.17.41.41
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 17:41:41 -0700 (PDT)
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (v2.22.0-rc0)
Message-ID: <da4638d5-ecf9-07dd-2c65-ecc9d4af3ba3@gmail.com>
Date:   Mon, 13 May 2019 20:41:39 -0400
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

Please see the test-coverage report for code added between v2.21.0 and
v2.22.0-rc0. These lines are not tested by the test suite on Linux with
standard build options.

Thanks,
-Stolee


---

builtin/blame.c
a544fb08f8b builtin/blame.c   1005) die("no such ref: HEAD");

builtin/branch.c
0ecb1fc7269 builtin/branch.c 452) die(_("could not resolve HEAD"));
0ecb1fc7269 builtin/branch.c 458) die(_("HEAD (%s) points outside of refs/heads/"), refname);

builtin/checkout.c
091e04bc8cb builtin/checkout.c  303) return;
a7256debd4b builtin/checkout.c  751) warning(_("staged changes in the following files may be lost: %s"),
091e04bc8cb builtin/checkout.c 1299) die(_("'%s' cannot be used with switching branches"),

builtin/commit-graph.c
61df89c8e55 105) die_errno(_("Could not open commit-graph '%s'"), graph_name);
61df89c8e55 109) return 1;

builtin/commit-tree.c
cbdeab98e87 builtin/commit-tree.c  56) die(_("not a valid object name %s"), arg);
cbdeab98e87 builtin/commit-tree.c  71) strbuf_addch(buf, '\n');
cbdeab98e87 builtin/commit-tree.c  78) static int parse_file_arg_callback(const struct option *opt,
cbdeab98e87 builtin/commit-tree.c  82) struct strbuf *buf = opt->value;
cbdeab98e87 builtin/commit-tree.c  84) BUG_ON_OPT_NEG_NOARG(unset, arg);
cbdeab98e87 builtin/commit-tree.c  86) if (buf->len)
cbdeab98e87 builtin/commit-tree.c  87) strbuf_addch(buf, '\n');
cbdeab98e87 builtin/commit-tree.c  88) if (!strcmp(arg, "-"))
cbdeab98e87 builtin/commit-tree.c  89) fd = 0;
cbdeab98e87 builtin/commit-tree.c  91) fd = open(arg, O_RDONLY);
cbdeab98e87 builtin/commit-tree.c  92) if (fd < 0)
cbdeab98e87 builtin/commit-tree.c  93) die_errno(_("git commit-tree: failed to open '%s'"), arg);
cbdeab98e87 builtin/commit-tree.c  95) if (strbuf_read(buf, fd, 0) < 0)
cbdeab98e87 builtin/commit-tree.c  96) die_errno(_("git commit-tree: failed to read '%s'"), arg);
cbdeab98e87 builtin/commit-tree.c  97) if (fd && close(fd))
cbdeab98e87 builtin/commit-tree.c  98) die_errno(_("git commit-tree: failed to close '%s'"), arg);
cbdeab98e87 builtin/commit-tree.c 100) return 0;
cbdeab98e87 builtin/commit-tree.c 133) die(_("must give exactly one tree"));
cbdeab98e87 builtin/commit-tree.c 140) die_errno(_("git commit-tree: failed to read"));

builtin/difftool.c
ebe4df59c45  69) return error("expected object ID, got '%s'", p);
ebe4df59c45  73) return error("expected object ID, got '%s'", p);
20de316e334 730) die(_("difftool requires worktree or --no-index"));

builtin/fsck.c
8d8c2a5aef0 builtin/fsck.c 271) static int mark_packed_unreachable_referents(const struct object_id *oid,
8d8c2a5aef0 builtin/fsck.c 276) mark_unreachable_referents(oid);
8d8c2a5aef0 builtin/fsck.c 277) return 0;

builtin/gc.c
bf3d70fe931 builtin/gc.c 126) die(_("failed to parse '%s' value '%s'"), var, value);

builtin/get-tar-commit-id.c
3548726cd7f builtin/get-tar-commit-id.c 40) return 1;
3548726cd7f builtin/get-tar-commit-id.c 42) return 1;

builtin/log.c
7954d365c64 builtin/log.c  254) static int estimate_commit_count(struct commit_list *list)
7954d365c64 builtin/log.c  292) int n = estimate_commit_count(list);
7954d365c64 builtin/log.c  336) static void setup_early_output(void)
7954d365c64 builtin/log.c  367) int n = estimate_commit_count(rev->commits);
7954d365c64 builtin/log.c  379) setup_early_output();
bc208ae3141 builtin/log.c  520) die(_("not a valid object name %s"), obj_name);
bc208ae3141 builtin/log.c  544) return error(_("could not read object %s"), oid_to_hex(oid));
bc208ae3141 builtin/log.c  663) ret = error(_("unknown type: %d"), o->type);
bc208ae3141 builtin/log.c  918) die(_("need exactly one range"));
bc208ae3141 builtin/log.c  928) die(_("not a range"));
bc208ae3141 builtin/log.c 1051) die(_("cover letter needs email format"));
bc208ae3141 builtin/log.c 1221) die(_("two output directories?"));
bc208ae3141 builtin/log.c 1332) die(_("unknown commit %s"), base_commit);
bc208ae3141 builtin/log.c 1342) die(_("failed to resolve '%s' as a valid ref"), upstream);
bc208ae3141 builtin/log.c 1351) die(_("failed to get upstream, if you want to record base commit automatically,\n"
bc208ae3141 builtin/log.c 1371) die(_("failed to find exact merge base"));
bc208ae3141 builtin/log.c 1750) die_errno(_("could not create directory '%s'"),
bc208ae3141 builtin/log.c 1952) die(_("failed to create output files"));
bc208ae3141 builtin/log.c 2076) die(_("unknown commit %s"), head);
bc208ae3141 builtin/log.c 2078) die(_("unknown commit %s"), upstream);
bc208ae3141 builtin/log.c 2090) die(_("unknown commit %s"), limit);

builtin/ls-files.c
7cb7283adb8 builtin/ls-files.c 115) printf("  ctime: %u:%u\n", sd->sd_ctime.sec, sd->sd_ctime.nsec);
7cb7283adb8 builtin/ls-files.c 116) printf("  mtime: %u:%u\n", sd->sd_mtime.sec, sd->sd_mtime.nsec);
7cb7283adb8 builtin/ls-files.c 117) printf("  dev: %u\tino: %u\n", sd->sd_dev, sd->sd_ino);
7cb7283adb8 builtin/ls-files.c 118) printf("  uid: %u\tgid: %u\n", sd->sd_uid, sd->sd_gid);
7cb7283adb8 builtin/ls-files.c 119) printf("  size: %u\tflags: %x\n", sd->sd_size, ce->ce_flags);

builtin/prune-packed.c
9b0bd87ed2a builtin/prune-packed.c 67) usage_msg_opt(_("too many arguments"),

builtin/prune.c
d55a30bb1db builtin/prune.c  43) progress = start_delayed_progress(_("Checking connectivity"), 0);

builtin/pull.c
d540b70c85c  652) argv_array_pushf(&args, "--cleanup=%s", cleanup_arg);

builtin/rebase.c
0609b741a43  146) static int add_exec_commands(struct string_list *commands)
0609b741a43  148) const char *todo_file = rebase_path_todo();
0609b741a43  149) struct todo_list todo_list = TODO_LIST_INIT;
0609b741a43  152) if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
0609b741a43  153) return error_errno(_("could not read '%s'."), todo_file);
0609b741a43  155) if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
0609b741a43  157) todo_list_release(&todo_list);
0609b741a43  158) return error(_("unusable todo list: '%s'"), todo_file);
0609b741a43  161) todo_list_add_exec_commands(&todo_list, commands);
0609b741a43  162) res = todo_list_write_to_file(the_repository, &todo_list,
0609b741a43  164) todo_list_release(&todo_list);
0609b741a43  166) if (res)
0609b741a43  167) return error_errno(_("could not write '%s'."), todo_file);
0609b741a43  168) return 0;
0609b741a43  171) static int rearrange_squash_in_todo_file(void)
0609b741a43  173) const char *todo_file = rebase_path_todo();
0609b741a43  174) struct todo_list todo_list = TODO_LIST_INIT;
0609b741a43  175) int res = 0;
0609b741a43  177) if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
0609b741a43  178) return error_errno(_("could not read '%s'."), todo_file);
0609b741a43  179) if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
0609b741a43  181) todo_list_release(&todo_list);
0609b741a43  182) return error(_("unusable todo list: '%s'"), todo_file);
0609b741a43  185) res = todo_list_rearrange_squash(&todo_list);
0609b741a43  186) if (!res)
0609b741a43  187) res = todo_list_write_to_file(the_repository, &todo_list,
0609b741a43  190) todo_list_release(&todo_list);
0609b741a43  192) if (res)
0609b741a43  193) return error_errno(_("could not write '%s'."), todo_file);
0609b741a43  194) return 0;
0609b741a43  204) return error_errno(_("could not read '%s'."), todo_file);
0609b741a43  208) todo_list_release(&todo_list);
0609b741a43  209) return error(_("unusable todo list: '%s'"), todo_file);
0609b741a43  217) return error_errno(_("could not write '%s'."), todo_file);
0609b741a43  229) return error_errno(_("could not read '%s'."), todo_file);
0609b741a43  235) res = error_errno(_("could not write '%s'"), todo_file);
0609b741a43  252) return error(_("no HEAD?"));
c44c24621da  279) return error_errno(_("could not create temporary %s"), merge_dir());
0609b741a43  285) return error_errno(_("could not mark as interactive"));
0609b741a43  314) return -1;
0609b741a43  318) return -1;
0609b741a43  323) free(revisions);
0609b741a43  324) free(shortrevisions);
0609b741a43  326) return -1;
7d3488eb893  335) argv_array_push(&make_script_args,
0ea0847ef0f  336) oid_to_hex(&opts->restrict_revision->object.oid));
0609b741a43  343) error(_("could not generate todo list"));
460bc3ce738  382) die(_("a base commit must be provided with --upstream or --onto"));
460bc3ce738  419) ret = rearrange_squash_in_todo_file();
460bc3ce738  420) break;
460bc3ce738  422) struct string_list commands = STRING_LIST_INIT_DUP;
460bc3ce738  424) split_exec_commands(opts->cmd, &commands);
460bc3ce738  425) ret = add_exec_commands(&commands);
460bc3ce738  426) string_list_clear(&commands, 0);
460bc3ce738  427) break;
0609b741a43  509) usage_with_options(builtin_rebase_interactive_usage, options);
73fdc535d26  515) opts.squash_onto = &squash_onto;
0609b741a43  518) warning(_("--[no-]rebase-cousins has no effect without "
cbd29ead92d  883) } else if (old_orig)
cbd29ead92d  884) delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
b3a5d5a80ce 1557) if (is_interactive(&options))
b3a5d5a80ce 1558) trace2_cmd_mode("interactive");
b3a5d5a80ce 1559) else if (exec.nr)
b3a5d5a80ce 1560) trace2_cmd_mode("interactive-exec");
b3a5d5a80ce 1562) trace2_cmd_mode(action_names[action]);

builtin/replace.c
f8e44a81bf8 builtin/replace.c 383) return error(_("could not parse %s as a commit"), argv[i]);
ee521ec4cb0 builtin/replace.c 490) return error(_("new commit is the same as the old one: '%s'"),

builtin/show-branch.c
7fdff47432b builtin/show-branch.c 756) read_ref_at(get_main_ref_store(the_repository),
7fdff47432b builtin/show-branch.c 769) if (read_ref_at(get_main_ref_store(the_repository),

builtin/stash.c
8a0fc8d19df builtin/stash--helper.c  127) die(_("'%s' is not a stash-like commit"), revision);
8a0fc8d19df builtin/stash--helper.c  160) free_stash_info(info);
8a0fc8d19df builtin/stash--helper.c  161) fprintf_ln(stderr, _("No stash entries found."));
8a0fc8d19df builtin/stash--helper.c  162) return -1;
8a0fc8d19df builtin/stash--helper.c  197) free_stash_info(info);
4e2dd393031 builtin/stash--helper.c  224) return error(_("git stash clear with parameters is "
8a0fc8d19df builtin/stash--helper.c  240) return -1;
8a0fc8d19df builtin/stash--helper.c  248) return -1;
8a0fc8d19df builtin/stash--helper.c  264) return error(_("unable to write new index file"));
8a0fc8d19df builtin/stash--helper.c  372) remove_path(stash_index_path.buf);
8a0fc8d19df builtin/stash--helper.c  373) return -1;
8a0fc8d19df builtin/stash--helper.c  400) return -1;
8a0fc8d19df builtin/stash--helper.c  403) return error(_("cannot apply a stash in the middle of a merge"));
8a0fc8d19df builtin/stash--helper.c  413) strbuf_release(&out);
8a0fc8d19df builtin/stash--helper.c  414) return error(_("could not generate diff %s^!."),
8a0fc8d19df builtin/stash--helper.c  421) return error(_("conflicts in index."
8a0fc8d19df builtin/stash--helper.c  427) return error(_("could not save index tree"));
8a0fc8d19df builtin/stash--helper.c  434) return error(_("could not restore untracked files from stash"));
8a0fc8d19df builtin/stash--helper.c  465) return -1;
8a0fc8d19df builtin/stash--helper.c  470) strbuf_release(&out);
8a0fc8d19df builtin/stash--helper.c  475) strbuf_release(&out);
8a0fc8d19df builtin/stash--helper.c  476) return -1;
4e2dd393031 builtin/stash--helper.c  552) return error(_("%s: Could not drop stash entry"),
c4de61d7a95 builtin/stash--helper.c  627) printf_ln(_("The stash entry is kept in case "
dc7bd382b10 builtin/stash--helper.c  761) free_stash_info(&info);
40af1468343 builtin/stash.c          762) usage_with_options(git_stash_show_usage, options);
41e0dd55c43 builtin/stash--helper.c  782) stash_msg = "Created via \"git stash store\".";
41e0dd55c43 builtin/stash--helper.c  788) if (!quiet) {
41e0dd55c43 builtin/stash--helper.c  789) fprintf_ln(stderr, _("Cannot update %s with %s"),
41e0dd55c43 builtin/stash--helper.c  792) return -1;
41e0dd55c43 builtin/stash--helper.c  816) if (!quiet)
41e0dd55c43 builtin/stash--helper.c  817) fprintf_ln(stderr, _("\"git stash store\" requires one "
41e0dd55c43 builtin/stash--helper.c  819) return -1;
d4788af875c builtin/stash--helper.c  902) return -1;
d4788af875c builtin/stash--helper.c  967) ret = -1;
d4788af875c builtin/stash--helper.c  968) goto done;
d4788af875c builtin/stash--helper.c  973) ret = -1;
d4788af875c builtin/stash--helper.c  974) goto done;
d4788af875c builtin/stash--helper.c  979) ret = -1;
d4788af875c builtin/stash--helper.c  980) goto done;
d4788af875c builtin/stash--helper.c 1006) ret = -1;
d4788af875c builtin/stash--helper.c 1007) goto done;
d4788af875c builtin/stash--helper.c 1018) ret = -1;
d4788af875c builtin/stash--helper.c 1019) goto done;
d4788af875c builtin/stash--helper.c 1025) ret = -1;
d4788af875c builtin/stash--helper.c 1026) goto done;
d4788af875c builtin/stash--helper.c 1033) ret = -1;
d4788af875c builtin/stash--helper.c 1034) goto done;
d4788af875c builtin/stash--helper.c 1072) ret = -1;
d4788af875c builtin/stash--helper.c 1073) goto done;
d4788af875c builtin/stash--helper.c 1079) ret = -1;
d4788af875c builtin/stash--helper.c 1080) goto done;
d4788af875c builtin/stash--helper.c 1091) ret = -1;
d4788af875c builtin/stash--helper.c 1092) goto done;
d4788af875c builtin/stash--helper.c 1097) ret = -1;
d4788af875c builtin/stash--helper.c 1098) goto done;
1ac528c0b0c builtin/stash--helper.c 1135) fprintf_ln(stderr, _("You do not have "
d4788af875c builtin/stash--helper.c 1144) ret = 1;
d4788af875c builtin/stash--helper.c 1145) goto done;
1ac528c0b0c builtin/stash--helper.c 1161) if (!quiet)
1ac528c0b0c builtin/stash--helper.c 1162) fprintf_ln(stderr, _("Cannot save the current "
d4788af875c builtin/stash--helper.c 1164) ret = -1;
d4788af875c builtin/stash--helper.c 1165) goto done;
1ac528c0b0c builtin/stash--helper.c 1170) if (!quiet)
1ac528c0b0c builtin/stash--helper.c 1171) fprintf_ln(stderr, _("Cannot save "
d4788af875c builtin/stash--helper.c 1173) ret = -1;
d4788af875c builtin/stash--helper.c 1174) goto done;
1ac528c0b0c builtin/stash--helper.c 1181) if (!quiet)
1ac528c0b0c builtin/stash--helper.c 1182) fprintf_ln(stderr, _("Cannot save the current "
d4788af875c builtin/stash--helper.c 1184) goto done;
1ac528c0b0c builtin/stash--helper.c 1218) if (!quiet)
1ac528c0b0c builtin/stash--helper.c 1219) fprintf_ln(stderr, _("Cannot record "
d4788af875c builtin/stash--helper.c 1221) ret = -1;
d4788af875c builtin/stash--helper.c 1222) goto done;
d553f538b8a builtin/stash--helper.c 1293) ret = -1;
d553f538b8a builtin/stash--helper.c 1294) goto done;
d553f538b8a builtin/stash--helper.c 1304) ret = -1;
1ac528c0b0c builtin/stash--helper.c 1305) if (!quiet)
1ac528c0b0c builtin/stash--helper.c 1306) fprintf_ln(stderr, _("Cannot initialize stash"));
d553f538b8a builtin/stash--helper.c 1307) goto done;
d553f538b8a builtin/stash--helper.c 1319) ret = -1;
1ac528c0b0c builtin/stash--helper.c 1320) if (!quiet)
1ac528c0b0c builtin/stash--helper.c 1321) fprintf_ln(stderr, _("Cannot save the current status"));
d553f538b8a builtin/stash--helper.c 1322) goto done;
d553f538b8a builtin/stash--helper.c 1339) ret = -1;
d553f538b8a builtin/stash--helper.c 1359) ret = -1;
d553f538b8a builtin/stash--helper.c 1360) goto done;
d553f538b8a builtin/stash--helper.c 1369) ret = -1;
d553f538b8a builtin/stash--helper.c 1370) goto done;
d553f538b8a builtin/stash--helper.c 1378) ret = -1;
d553f538b8a builtin/stash--helper.c 1387) ret = -1;
d553f538b8a builtin/stash--helper.c 1398) ret = -1;
d553f538b8a builtin/stash--helper.c 1399) goto done;
d553f538b8a builtin/stash--helper.c 1408) ret = -1;
d553f538b8a builtin/stash--helper.c 1409) goto done;
d553f538b8a builtin/stash--helper.c 1417) ret = -1;
d553f538b8a builtin/stash--helper.c 1443) ret = -1;
7906af0cb84 builtin/stash.c         1536) return env;
90a462725ef builtin/stash.c         1564) const char *path = mkpath("%s/git-legacy-stash",
90a462725ef builtin/stash.c         1567) if (sane_execvp(path, (char **)argv) < 0)
90a462725ef builtin/stash.c         1568) die_errno(_("could not exec %s"), path);
40af1468343 builtin/stash.c         1611) usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
40af1468343 builtin/stash.c         1639) continue;

builtin/tag.c
01dc801adad builtin/tag.c 226) die(_("bad object type."));

builtin/worktree.c
7af01f23678 302) die_errno(_("could not create directory of '%s'"),

combine-diff.c
d76ce4f7346   89)     filename_changed(p->parent[j].status))
d76ce4f7346   90) strbuf_release(&p->parent[j].path);
d76ce4f7346  992) dump_quoted_path("--- ", "", "/dev/null",
d76ce4f7346 1000) dump_quoted_path("--- ", "", "/dev/null",
d76ce4f7346 1273) write_name_quoted(p->path, stdout,

commit-graph.c
61df89c8e55   89) close(*fd);
61df89c8e55   90) return 0;
93b4405ffe4  218) error(_("commit-graph improper chunk offset %08x%08x"), (uint32_t)(chunk_offset >> 32),
93b4405ffe4  255) error(_("commit-graph chunk id %08x appears multiple times"), chunk_id);
43d35618055  315) die("dying as requested by the '%s' variable on commit-graph load!",
93b4405ffe4 1187) graph_report(_("failed to parse commit %s from commit-graph"),
93b4405ffe4 1253) graph_report(_("commit-graph parent list for commit %s terminates early"),
93b4405ffe4 1258) graph_report(_("commit-graph has generation number zero for commit %s, but non-zero elsewhere"),

diff-no-index.c
16bb3d714dc 263) warning(_("Not a git repository. Use --no-index to "
16bb3d714dc 299) return 1;

diff.c
84b5089e41c 4682) count = strtoul(end+1, &end, 10);
84b5089e41c 4684) return error(_("invalid --stat value: %s"), value);
84b5089e41c 4689) return error(_("%s expects a numerical value"),
84b5089e41c 4694) return error(_("%s expects a numerical value"),
84b5089e41c 4699) return error(_("%s expects a numerical value"),
84b5089e41c 4704) return error(_("%s expects a numerical value"),
d2d3f273009 4806) return error(_("unknown change class '%c' in --diff-filter=%s"),
5a749d9f97c 4830) return error(_("unknown value after ws-error-highlight=%.*s"),
a75f28cbda5 4844) return error(_("unable to resolve '%s'"), arg);
ced4e179fea 4893) else if (*arg != '/')
ced4e179fea 4894) return error(_("%s expects <n>/<m> form"), opt->long_name);
ced4e179fea 4896) arg++;
ced4e179fea 4897) opt2 = parse_rename_score(&arg);
ced4e179fea 4900) return error(_("%s expects <n>/<m> form"), opt->long_name);
af2f3680918 4912) return error(_("%s expects a character, got '%s'"),
59311a9820d 4924) options->color_moved = COLOR_MOVED_NO;
bb9872904e0 4947) return 0;
7d7942b7967 4976) options->flags.stat_with_summary = 0;
10f35b1cc01 4984) static int diff_opt_diff_algorithm(const struct option *opt,
10f35b1cc01 4987) struct diff_options *options = opt->value;
10f35b1cc01 4988) long value = parse_algorithm_value(arg);
10f35b1cc01 4990) BUG_ON_OPT_NEG(unset);
10f35b1cc01 4991) if (value < 0)
10f35b1cc01 4992) return error(_("option diff-algorithm accepts \"myers\", "
10f35b1cc01 4996) DIFF_XDL_CLR(options, NEED_MINIMAL);
10f35b1cc01 4997) options->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
10f35b1cc01 4998) options->xdl_opts |= value;
10f35b1cc01 4999) return 0;
7f64850d364 5028) return error(_("invalid argument to %s"), opt->long_name);
f476308b273 5048) return error(_("invalid argument to %s"), opt->long_name);
125dcea9633 5186) return error(_("failed to parse --submodule option parameter: '%s'"),
d473e2e0e8e 5216) return error(_("%s expects a numerical value"), "--unified");
e9fb39b668d 5240) return error(_("bad --word-diff argument: %s"), arg);

dir.c
entry.c
fast-import.c
28d055bde94  960) && (pack_size + PACK_SIZE_THRESHOLD + s.total_out) > max_packsize)
28d055bde94 1056) if ((max_packsize
28d055bde94 1057) && (pack_size + PACK_SIZE_THRESHOLD + len) > max_packsize)
28d055bde94 1058) || (pack_size + PACK_SIZE_THRESHOLD + len) < pack_size)
28d055bde94 2071)     tmp_hex_oid_len > hexsz ||
28d055bde94 2085) if (tmp_hex_oid_len == hexsz && !get_oid_hex(hex_oid, &oid)) {
7ffde293f2e 2262) parse_cat_blob(v);
28d055bde94 2566) if (!buf || size < the_hash_algo->hexsz + 6)
7ffde293f2e 2640) parse_cat_blob(v);
28d055bde94 2855) cat_blob_write(output, the_hash_algo->hexsz + 1);
28d055bde94 2885) const unsigned hexsz = the_hash_algo->hexsz;
28d055bde94 2920) if (size < hexsz + strlen("object ") ||
28d055bde94 2925) if (size < hexsz + strlen("tree ") ||
ef479a12bd9 2957) static void print_ls(int mode, const unsigned char *hash, const char *path)
5056bb7646c 3326) parse_ls(v, NULL);
7ffde293f2e 3328) parse_cat_blob(v);
cf7b857a77b 3330) parse_get_mark(v);

fetch-pack.c
37c80012f14  196) die_errno(_("unable to write to remote"));
37c80012f14 1171) die_errno(_("unable to write request to remote"));
1339078f5e6 1314) prepare_shallow_info(si, shallows);
1339078f5e6 1315) if (si->nr_ours || si->nr_theirs)
1339078f5e6 1316) alternate_shallow_file =
1339078f5e6 1317) setup_temporary_shallow(si->shallow);
1339078f5e6 1319) alternate_shallow_file = NULL;

git.c
ee4512ed481 162) trace2_cmd_name("_query_");
ee4512ed481 166) trace2_cmd_name("_query_");
ee4512ed481 170) trace2_cmd_name("_query_");

help.c
057ab54b664 help.c         389) if (sb.buf[0] == '-')
057ab54b664 help.c         390) string_list_remove(list, sb.buf + 1, 0);

http-walker.c
2bf1db78627 http-walker.c 445) hash_to_hex(target->hash));

http.c
05dfc7cac4a 2094) fprintf(stderr, "Getting index for pack %s\n", hash_to_hex(hash));
ddc56d4710f 2176)     (*data == '\n' || *data == '\0')) {
05dfc7cac4a 2291) hash_to_hex(target->hash),
eed0e60f02b 2433) the_hash_algo->init_fn(&freq->c);

ident.c
39ab4d0951b 452) break;
39ab4d0951b 454) name = getenv("GIT_AUTHOR_NAME");
39ab4d0951b 455) email = getenv("GIT_AUTHOR_EMAIL");
39ab4d0951b 456) break;
39ab4d0951b 515) return config_error_nonbool(var);
39ab4d0951b 525) return config_error_nonbool(var);
39ab4d0951b 535) return config_error_nonbool(var);
39ab4d0951b 545) return config_error_nonbool(var);

merge-recursive.c
259ccb6cc32  322) strbuf_addstr(&opt->obuf, _("(bad commit)\n"));
259ccb6cc32  345) return err(opt, _("add_cacheinfo failed for path '%s'; merge aborting."), path);
259ccb6cc32  354) return err(opt, _("add_cacheinfo failed to refresh for path '%s'; merge aborting."), path);
259ccb6cc32  437) err(opt, _("error building trees"));
259ccb6cc32  692) ce = index_file_exists(opt->repo->index, path, strlen(path),
259ccb6cc32  886) return err(opt, msg, path, _(": perhaps a D/F conflict?"));
259ccb6cc32  887) return err(opt, msg, path, "");
8daec1df03d  936) return err(opt, _("cannot read object %s '%s'"),
8daec1df03d  939) ret = err(opt, _("blob expected for %s '%s'"),
259ccb6cc32  963) ret = err(opt, _("failed to open '%s': %s"),
259ccb6cc32  974) ret = err(opt, _("failed to symlink '%s': %s"),
259ccb6cc32  978) ret = err(opt,
8daec1df03d  980)   contents->mode, oid_to_hex(&contents->oid), path);
259ccb6cc32 1182) output(opt, 1, _("Failed to merge submodule %s (commits not present)"), path);
259ccb6cc32 1199) } else if (show(opt, 2))
259ccb6cc32 1200) output(opt, 2, _("Fast-forwarding submodule %s"), path);
259ccb6cc32 1208) if (show(opt, 3)) {
259ccb6cc32 1209) output(opt, 3, _("Fast-forwarding submodule %s to the following commit:"), path);
259ccb6cc32 1210) output_commit_title(opt, commit_a);
259ccb6cc32 1211) } else if (show(opt, 2))
259ccb6cc32 1212) output(opt, 2, _("Fast-forwarding submodule %s"), path);
e3de888ca05 1277) return merge_mode_and_contents(opt, o, b, a,
259ccb6cc32 1325) ret = err(opt, _("Failed to execute internal merge"));
259ccb6cc32 1330) ret = err(opt, _("Unable to add %s to database"),
8c8e5bd6eb3 1403) return -1;
8c8e5bd6eb3 1408) return -1;
8daec1df03d 1746) if (update_file(opt, 0, add, a->path))
8daec1df03d 1753) if (update_file(opt, 0, add, b->path))
259ccb6cc32 2929) return err(opt, _("cannot read object %s"), oid_to_hex(oid));
259ccb6cc32 2932) return err(opt, _("object %s is not a blob"), oid_to_hex(oid));
259ccb6cc32 3068) remove_file_from_index(opt->repo->index, path);
8c8e5bd6eb3 3122) return -1;
8daec1df03d 3362) } else if (!o_valid && !a_valid && !b_valid) {
8daec1df03d 3367) remove_file(opt, 1, path, !a->mode);
259ccb6cc32 3462) unpack_trees_finish(opt);
259ccb6cc32 3556) return err(opt, _("merge returned no commit"));
259ccb6cc32 3622) return err(opt, _("Could not parse object '%s'"),
259ccb6cc32 3638) return err(opt, _("Unable to write index."));
8c8e5bd6eb3 3661) } else if (!strcasecmp(value, "conflict")) {
8c8e5bd6eb3 3662) opt->detect_directory_renames = 1;
259ccb6cc32 3704) opt->subtree_shift = "";
259ccb6cc32 3708) opt->xdl_opts = DIFF_WITH_ALG(opt, PATIENCE_DIFF);
259ccb6cc32 3710) opt->xdl_opts = DIFF_WITH_ALG(opt, HISTOGRAM_DIFF);
259ccb6cc32 3716) DIFF_XDL_CLR(opt, NEED_MINIMAL);
259ccb6cc32 3717) opt->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
259ccb6cc32 3718) opt->xdl_opts |= value;
259ccb6cc32 3727) DIFF_XDL_SET(opt, IGNORE_CR_AT_EOL);
259ccb6cc32 3729) opt->renormalize = 1;
259ccb6cc32 3731) opt->renormalize = 0;

pack-bitmap.c
0dd49248916  192) error("Duplicate entry in bitmap index: %s", hash_to_hex(hash));
4828ce9871f  312) goto failed;

pack-objects.c
c409d108b85 122) void oe_map_new_pack(struct packing_data *pack)

pack-revindex.c
4828ce9871f 166) return -1;
4828ce9871f 197) return NULL;

packfile.c
fc78915674f  475) ret = p->pack_name; /* we only have a base */
4828ce9871f 2038) return -1;

pager.c
eee73d1dceb 103) pager_process->trace2_child_class = "pager";

parse-options-cb.c
d8774183901  26) v = the_hash_algo->hexsz;
7d3488eb893  99) int parse_opt_commit(const struct option *opt, const char *arg, int unset)
7d3488eb893 103) struct commit **target = opt->value;
7d3488eb893 105) if (!arg)
7d3488eb893 106) return -1;
7d3488eb893 107) if (get_oid(arg, &oid))
7d3488eb893 108) return error("malformed object name %s", arg);
7d3488eb893 109) commit = lookup_commit_reference(the_repository, &oid);
7d3488eb893 110) if (!commit)
7d3488eb893 111) return error("no such commit %s", arg);
7d3488eb893 112) *target = commit;
7d3488eb893 113) return 0;
338985317eb 132) int parse_opt_object_id(const struct option *opt, const char *arg, int unset)
338985317eb 135) struct object_id *target = opt->value;
338985317eb 137) if (unset) {
338985317eb 138) *target = null_oid;
338985317eb 139) return 0;
338985317eb 141) if (!arg)
338985317eb 142) return -1;
338985317eb 143) if (get_oid(arg, &oid))
338985317eb 144) return error(_("malformed object name '%s'"), arg);
338985317eb 145) *target = oid;
338985317eb 146) return 0;

parse-options.c
3ebbe289896 257) rc = (*numopt->ll_callback)(p, numopt, arg, 0);
5205749d2ca 534) static int show_gitcomp(const struct option *opts)
5205749d2ca 613) return show_gitcomp(options);

pkt-line.c
37c80012f14  92) die_errno(_("unable to write flush packet"));
37c80012f14  99) die_errno(_("unable to write delim packet"));

pretty.c
4f732e0fd7a 1077) return 0;
4f732e0fd7a 1114) return 0;

progress.c
545dc345ebd 127) fprintf(stderr, "  %s%*s", counters_sb->buf,
545dc345ebd 130) clear_len = progress->title_len + 1 < cols ?
545dc345ebd 131)     cols - progress->title_len : 0;
545dc345ebd 132) fprintf(stderr, "%s:%*s\n  %s%s",
545dc345ebd 135) progress->split = 1;
9d81ecb52b5 266) struct progress *start_delayed_sparse_progress(const char *title,
9d81ecb52b5 269) return start_progress_delay(title, total, 2, 1);

protocol.c
8cbeba06325 38) die("unknown value for %s: %s", git_test_k, git_test_v);

reachable.c
fde67d68966 172) return lookup_tag(r, oid);
fde67d68966 176) die("BUG: unknown object type %d", type);
fde67d68966 189) die("unable to create object '%s'", oid_to_hex(oid));

rebase-interactive.c
6ca89c6f399  26) warning(_("unrecognized setting %s for option "
a930eb03a82 105) return error_errno(_("could not write '%s'"), todo_file);
a930eb03a82 108) return error(_("could not copy '%s' to '%s'."), todo_file,
6ca89c6f399 167) goto leave_check;

refs.c
567009033f7  630)  refs_reflog_exists(refs, ref))

remote-curl.c
ed8b4132c8e  157) die(_("invalid quoting in push-option value: '%s'"), value);
aa1edf14f93  355) die(_("invalid server response; expected service, got flush packet"));
ed8b4132c8e  446) die(_("repository '%s' not found"),
c1284b21f24  447)     transport_anonymize_url(url.buf));
aa1edf14f93  584) die(_("shouldn't have EOF when not gentle on EOF"));
ed8b4132c8e  664) error(_("unable to rewind rpc post data - try increasing http.postBuffer"));
ed8b4132c8e  764) die(_("cannot handle pushes this big"));
ed8b4132c8e  879) die(_("cannot deflate request; zlib deflate error %d"), ret);
ed8b4132c8e  883) die(_("cannot deflate request; zlib end error %d"), ret);
ed8b4132c8e 1014) die(_("dumb http transport does not support shallow capabilities"));
ed8b4132c8e 1076) die(_("cannot fetch by sha1 over smart http"));
ed8b4132c8e 1120) die(_("protocol error: expected sha/ref, got %s'"), p);
9c9492e8aaf 1123) else if (!*q)
ed8b4132c8e 1126) die(_("protocol error: expected sha/ref, got %s'"), p);
ed8b4132c8e 1138) die(_("http transport does not support %s"), buf->buf);
ed8b4132c8e 1252) die(_("http transport does not support %s"), buf->buf);
a97d00799a1 1305) rpc.protocol_header = NULL;
a97d00799a1 1306) strbuf_release(&buf);
ed8b4132c8e 1360) error(_("remote-curl: usage: git remote-curl <remote> [<url>]"));
ed8b4132c8e 1392) error(_("remote-curl: error reading command stream from git"));
ed8b4132c8e 1399) die(_("remote-curl: fetch attempted without a local repo"));
ed8b4132c8e 1439) error(_("remote-curl: unknown command '%s' from git"), buf.buf);

remote.c
revision.c
8320b1dbe7d  956) prio_queue_put(queue, p);
d76ce4f7346 2643) die("--combined-all-paths makes no sense without -c or --cc");

run-command.c
ee4512ed481  239) int ec = errno;
ee4512ed481  240) trace2_exec_result(exec_id, ec);
ee4512ed481  241) errno = ec;
ee4512ed481  997) int ret = wait_or_whine(cmd->pid, cmd->argv[0], 1);
ee4512ed481  998) trace2_child_exit(cmd, ret);
ee4512ed481  999) return ret;
ee4512ed481 1021) int run_command_v_opt_tr2(const char **argv, int opt, const char *tr2_class)
ee4512ed481 1023) return run_command_v_opt_cd_env_tr2(argv, opt, NULL, NULL, tr2_class);

sequencer.c
d74f3e58114  176) opts->explicit_cleanup = 1;
d74f3e58114  179) opts->explicit_cleanup = 1;
dc42e9a83a9  542) static const char *describe_cleanup_mode(int cleanup_mode)
dc42e9a83a9  549) if (cleanup_mode < ARRAY_SIZE(modes))
dc42e9a83a9  550) return modes[cleanup_mode];
4a72486de97 2184) return error_errno("unable to open '%s'", todo_file);
4a72486de97 2188) eol--; /* strip Carriage Return */
4a72486de97 2190) goto fail;
4a72486de97 2196) goto fail;
b07d9bfd171 2300) error_errno("unable to open '%s'", todo_path);
b07d9bfd171 2301) return 0;
dc42e9a83a9 2455) else if (!strcmp(key, "options.default-msg-cleanup")) {
dc42e9a83a9 2456) opts->explicit_cleanup = 1;
dc42e9a83a9 2457) opts->default_msg_cleanup = get_cleanup_mode(value, 1);
f59199d5faa 2836) res |= git_config_set_in_file_gently(opts_file,
f59199d5faa 2867) res |= git_config_set_in_file_gently(opts_file,
f59199d5faa 2868) "options.gpg-sign", opts->gpg_sign);
dc42e9a83a9 2883) res |= git_config_set_in_file_gently(opts_file,
dc42e9a83a9 2885) describe_cleanup_mode(opts->default_msg_cleanup));
616d7740cfb 4811) strbuf_addstr(buf, " -c");
6ca89c6f399 4859) goto out;
878056005e9 4863) res = -1;
6ca89c6f399 4864) goto out;
6ca89c6f399 4873) fprintf(stderr, _(edit_todo_list_advice));
6bfeb7f1b50 4989) todo_list_release(&new_todo);
94bcad79796 4995) todo_list_release(&new_todo);
94bcad79796 4996) return error_errno(_("could not write '%s'"), todo_file);

server-info.c
4ecbd6492cd 148) } else if (line.buf[0] == 'D') {
4ecbd6492cd 151) } else if (line.buf[0] == 'T') {
b83a3089b58 153) goto out_stale;

sha1-file.c
95399788d15 sha1-file.c  198) return GIT_HASH_UNKNOWN;

sha1-name.c
c931ba4e780 sha1-name.c 1219) object = deref_tag(cb->repo, object, path,

strbuf.c
5ef264dbdbc  259) die("`pos' is too far after the end of the buffer");
5ef264dbdbc  266) return; /* nothing to do */
5ef264dbdbc  268) die("you want to use way too much memory");
fd2015b323d  448) return 0;

trace2.c
ee4512ed481 129) static void tr2main_signal_handler(int signo)
ee4512ed481 136) us_now = getnanotime() / 1000;
ee4512ed481 137) us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
ee4512ed481 139) for_each_wanted_builtin (j, tgt_j)
ee4512ed481 140) if (tgt_j->pfn_signal)
ee4512ed481 141) tgt_j->pfn_signal(us_elapsed_absolute, signo);
ee4512ed481 143) sigchain_pop(signo);
ee4512ed481 144) raise(signo);
ee4512ed481 145) }
ee4512ed481 158) return;
ee4512ed481 249) void trace2_cmd_path_fl(const char *file, int line, const char *pathname)
ee4512ed481 254) if (!trace2_enabled)
ee4512ed481 255) return;
ee4512ed481 257) for_each_wanted_builtin (j, tgt_j)
ee4512ed481 258) if (tgt_j->pfn_command_path_fl)
ee4512ed481 259) tgt_j->pfn_command_path_fl(file, line, pathname);
ee4512ed481 287) for_each_wanted_builtin (j, tgt_j)
ee4512ed481 288) if (tgt_j->pfn_command_mode_fl)
ee4512ed481 289) tgt_j->pfn_command_mode_fl(file, line, mode);
ee4512ed481 301) for_each_wanted_builtin (j, tgt_j)
ee4512ed481 302) if (tgt_j->pfn_alias_fl)
ee4512ed481 303) tgt_j->pfn_alias_fl(file, line, alias, argv);
ee4512ed481 320) tr2_cfg_set_fl(file, line, key, value);
ee4512ed481 364) us_elapsed_child = 0;
ee4512ed481 387) us_now = getnanotime() / 1000;
ee4512ed481 388) us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
ee4512ed481 390) exec_id = tr2tls_locked_increment(&tr2_next_exec_id);
ee4512ed481 392) for_each_wanted_builtin (j, tgt_j)
ee4512ed481 393) if (tgt_j->pfn_exec_fl)
ee4512ed481 394) tgt_j->pfn_exec_fl(file, line, us_elapsed_absolute,
ee4512ed481 397) return exec_id;
ee4512ed481 400) void trace2_exec_result_fl(const char *file, int line, int exec_id, int code)
ee4512ed481 407) if (!trace2_enabled)
ee4512ed481 408) return;
ee4512ed481 410) us_now = getnanotime() / 1000;
ee4512ed481 411) us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
ee4512ed481 413) for_each_wanted_builtin (j, tgt_j)
ee4512ed481 414) if (tgt_j->pfn_exec_result_fl)
ee4512ed481 415) tgt_j->pfn_exec_result_fl(
ee4512ed481 419) void trace2_thread_start_fl(const char *file, int line, const char *thread_name)
ee4512ed481 426) if (!trace2_enabled)
ee4512ed481 427) return;
ee4512ed481 429) if (tr2tls_is_main_thread()) {
ee4512ed481 439) trace2_region_enter_printf_fl(file, line, NULL, NULL, NULL,
ee4512ed481 442) return;
ee4512ed481 445) us_now = getnanotime() / 1000;
ee4512ed481 446) us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
a089724958a 448) tr2tls_create_self(thread_name, us_now);
ee4512ed481 450) for_each_wanted_builtin (j, tgt_j)
ee4512ed481 451) if (tgt_j->pfn_thread_start_fl)
ee4512ed481 452) tgt_j->pfn_thread_start_fl(file, line,
ee4512ed481 456) void trace2_thread_exit_fl(const char *file, int line)
ee4512ed481 464) if (!trace2_enabled)
ee4512ed481 465) return;
ee4512ed481 467) if (tr2tls_is_main_thread()) {
ee4512ed481 478) trace2_region_leave_printf_fl(file, line, NULL, NULL, NULL,
ee4512ed481 480) return;
ee4512ed481 483) us_now = getnanotime() / 1000;
ee4512ed481 484) us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
ee4512ed481 491) tr2tls_pop_unwind_self();
ee4512ed481 492) us_elapsed_thread = tr2tls_region_elasped_self(us_now);
ee4512ed481 494) for_each_wanted_builtin (j, tgt_j)
ee4512ed481 495) if (tgt_j->pfn_thread_exit_fl)
ee4512ed481 496) tgt_j->pfn_thread_exit_fl(file, line,
ee4512ed481 500) tr2tls_unset_self();
ee4512ed481 510) return;
ee4512ed481 526) return;
ee4512ed481 548) us_now = getnanotime() / 1000;
ee4512ed481 549) us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
ee4512ed481 558) for_each_wanted_builtin (j, tgt_j)
ee4512ed481 559) if (tgt_j->pfn_region_enter_printf_va_fl)
ee4512ed481 560) tgt_j->pfn_region_enter_printf_va_fl(
ee4512ed481 564) tr2tls_push_self(us_now);
ee4512ed481 619) us_now = getnanotime() / 1000;
ee4512ed481 620) us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
ee4512ed481 628) us_elapsed_region = tr2tls_region_elasped_self(us_now);
ee4512ed481 630) tr2tls_pop_self();
ee4512ed481 636) for_each_wanted_builtin (j, tgt_j)
ee4512ed481 637) if (tgt_j->pfn_region_leave_printf_va_fl)
ee4512ed481 638) tgt_j->pfn_region_leave_printf_va_fl(
ee4512ed481 692) return;
ee4512ed481 714) strbuf_addf(&buf_string, "%" PRIdMAX, value);
ee4512ed481 715) trace2_data_string_fl(file, line, category, repo, key, buf_string.buf);
ee4512ed481 716) strbuf_release(&buf_string);
ee4512ed481 719) void trace2_data_json_fl(const char *file, int line, const char *category,
ee4512ed481 729) if (!trace2_enabled)
ee4512ed481 730) return;
ee4512ed481 732) us_now = getnanotime() / 1000;
ee4512ed481 733) us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
ee4512ed481 734) us_elapsed_region = tr2tls_region_elasped_self(us_now);
ee4512ed481 736) for_each_wanted_builtin (j, tgt_j)
22a7338318e 737) if (tgt_j->pfn_data_json_fl)
ee4512ed481 738) tgt_j->pfn_data_json_fl(file, line, us_elapsed_absolute,
ee4512ed481 743) void trace2_printf_va_fl(const char *file, int line, const char *fmt,
ee4512ed481 751) if (!trace2_enabled)
ee4512ed481 752) return;
ee4512ed481 754) us_now = getnanotime() / 1000;
ee4512ed481 755) us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
ee4512ed481 761) for_each_wanted_builtin (j, tgt_j)
ee4512ed481 762) if (tgt_j->pfn_printf_va_fl)
ee4512ed481 763) tgt_j->pfn_printf_va_fl(file, line, us_elapsed_absolute,
ee4512ed481 767) void trace2_printf_fl(const char *file, int line, const char *fmt, ...)
ee4512ed481 771) va_start(ap, fmt);
ee4512ed481 772) trace2_printf_va_fl(file, line, fmt, ap);
ee4512ed481 773) va_end(ap);
ee4512ed481 774) }

trace2/tr2_cfg.c
ee4512ed481 20) return tr2_cfg_count_patterns;
ee4512ed481 32) strbuf_setlen(buf, buf->len - 1);
ee4512ed481 82) void tr2_cfg_set_fl(const char *file, int line, const char *key,
ee4512ed481 85) struct tr2_cfg_data data = { file, line };
ee4512ed481 87) if (tr2_cfg_load_patterns() > 0)
ee4512ed481 88) tr2_cfg_cb(key, value, &data);
ee4512ed481 89) }

trace2/tr2_dst.c
ee4512ed481  11) static int tr2_dst_want_warning(void)
ee4512ed481  15) if (tr2env_dst_debug == -1) {
bce9db6de97  16) const char *env_value = tr2_sysenv_get(TR2_SYSENV_DST_DEBUG);
ee4512ed481  17) if (!env_value || !*env_value)
ee4512ed481  18) tr2env_dst_debug = 0;
ee4512ed481  20) tr2env_dst_debug = atoi(env_value) > 0;
ee4512ed481  23) return tr2env_dst_debug;
a4d3a283db5  45) sid = last_slash + 1;
a4d3a283db5  55) strbuf_setlen(&path, base_path_len);
a4d3a283db5  56) strbuf_addf(&path, ".%d", attempt_count);
a4d3a283db5  65) if (tr2_dst_want_warning())
a4d3a283db5  66) warning("trace2: could not open '%.*s' for '%s' tracing: %s",
5b2d1c0c6ec  69) strerror(errno));
a4d3a283db5  71) tr2_dst_trace_disable(dst);
a4d3a283db5  72) strbuf_release(&path);
a4d3a283db5  73) return 0;
ee4512ed481  89) if (tr2_dst_want_warning())
ee4512ed481  90) warning("trace2: could not open '%s' for '%s' tracing: %s",
bce9db6de97  93) strerror(errno));
ee4512ed481  95) tr2_dst_trace_disable(dst);
ee4512ed481  96) return 0;
ee4512ed481 111) static int tr2_dst_try_uds_connect(const char *path, int sock_type, int *out_fd)
ee4512ed481 116) fd = socket(AF_UNIX, sock_type, 0);
ee4512ed481 117) if (fd == -1)
ee4512ed481 118) return errno;
ee4512ed481 120) sa.sun_family = AF_UNIX;
ee4512ed481 121) strlcpy(sa.sun_path, path, sizeof(sa.sun_path));
ee4512ed481 123) if (connect(fd, (struct sockaddr *)&sa, sizeof(sa)) == -1) {
ee4512ed481 124) int e = errno;
ee4512ed481 125) close(fd);
ee4512ed481 126) return e;
ee4512ed481 129) *out_fd = fd;
ee4512ed481 130) return 0;
ee4512ed481 136) static int tr2_dst_try_unix_domain_socket(struct tr2_dst *dst,
ee4512ed481 139) unsigned int uds_try = 0;
ee4512ed481 142) const char *path = NULL;
ee4512ed481 155) if (skip_prefix(tgt_value, PREFIX_AF_UNIX_STREAM, &path))
ee4512ed481 156) uds_try |= TR2_DST_UDS_TRY_STREAM;
ee4512ed481 158) else if (skip_prefix(tgt_value, PREFIX_AF_UNIX_DGRAM, &path))
ee4512ed481 159) uds_try |= TR2_DST_UDS_TRY_DGRAM;
ee4512ed481 161) else if (skip_prefix(tgt_value, PREFIX_AF_UNIX, &path))
ee4512ed481 162) uds_try |= TR2_DST_UDS_TRY_STREAM | TR2_DST_UDS_TRY_DGRAM;
ee4512ed481 164) if (!path || !*path) {
ee4512ed481 165) if (tr2_dst_want_warning())
ee4512ed481 166) warning("trace2: invalid AF_UNIX value '%s' for '%s' tracing",
ee4512ed481 170) tr2_dst_trace_disable(dst);
ee4512ed481 171) return 0;
ee4512ed481 174) if (!is_absolute_path(path) ||
ee4512ed481 175)     strlen(path) >= sizeof(((struct sockaddr_un *)0)->sun_path)) {
ee4512ed481 176) if (tr2_dst_want_warning())
ee4512ed481 177) warning("trace2: invalid AF_UNIX path '%s' for '%s' tracing",
ee4512ed481 180) tr2_dst_trace_disable(dst);
ee4512ed481 181) return 0;
ee4512ed481 184) if (uds_try & TR2_DST_UDS_TRY_STREAM) {
ee4512ed481 185) e = tr2_dst_try_uds_connect(path, SOCK_STREAM, &fd);
ee4512ed481 186) if (!e)
ee4512ed481 187) goto connected;
ee4512ed481 188) if (e != EPROTOTYPE)
ee4512ed481 189) goto error;
ee4512ed481 191) if (uds_try & TR2_DST_UDS_TRY_DGRAM) {
ee4512ed481 192) e = tr2_dst_try_uds_connect(path, SOCK_DGRAM, &fd);
ee4512ed481 193) if (!e)
ee4512ed481 194) goto connected;
ee4512ed481 198) if (tr2_dst_want_warning())
ee4512ed481 199) warning("trace2: could not connect to socket '%s' for '%s' tracing: %s",
ee4512ed481 203) tr2_dst_trace_disable(dst);
ee4512ed481 204) return 0;
ee4512ed481 207) dst->fd = fd;
ee4512ed481 208) dst->need_close = 1;
ee4512ed481 209) dst->initialized = 1;
ee4512ed481 211) return dst->fd;
ee4512ed481 215) static void tr2_dst_malformed_warning(struct tr2_dst *dst,
ee4512ed481 218) struct strbuf buf = STRBUF_INIT;
ee4512ed481 220) strbuf_addf(&buf, "trace2: unknown value for '%s': '%s'",
ee4512ed481 222) warning("%s", buf.buf);
ee4512ed481 224) strbuf_release(&buf);
ee4512ed481 225) }
ee4512ed481 246) dst->fd = STDERR_FILENO;
ee4512ed481 247) return dst->fd;
ee4512ed481 251) dst->fd = atoi(tgt_value);
ee4512ed481 252) return dst->fd;
ee4512ed481 263) if (starts_with(tgt_value, PREFIX_AF_UNIX))
ee4512ed481 264) return tr2_dst_try_unix_domain_socket(dst, tgt_value);
ee4512ed481 268) tr2_dst_malformed_warning(dst, tgt_value);
ee4512ed481 269) tr2_dst_trace_disable(dst);
ee4512ed481 270) return 0;
ee4512ed481 302) if (tr2_dst_want_warning())
bce9db6de97 303) warning("unable to write trace to '%s': %s",
ee4512ed481 305) strerror(errno));
ee4512ed481 306) tr2_dst_trace_disable(dst);

trace2/tr2_sid.c
08881b9a4c8  44) strbuf_add(&tr2sid_buf, "Localhost", 9);
ee4512ed481  74) return;
ee4512ed481 104) tr2_sid_compute();

trace2/tr2_sysenv.c
bce9db6de97  70) return 0;
bce9db6de97 113) const char *tr2_sysenv_display_name(enum tr2_sysenv_variable var)
bce9db6de97 115) if (var >= TR2_SYSENV_MUST_BE_LAST)
bce9db6de97 118) return tr2_sysenv_settings[var].env_var_name;

trace2/tr2_tbuf.c
ee4512ed481  4) void tr2_tbuf_local_time(struct tr2_tbuf *tb)
ee4512ed481 10) gettimeofday(&tv, NULL);
ee4512ed481 11) secs = tv.tv_sec;
ee4512ed481 12) localtime_r(&secs, &tm);
ee4512ed481 14) xsnprintf(tb->buf, sizeof(tb->buf), "%02d:%02d:%02d.%06ld", tm.tm_hour,
ee4512ed481 15)   tm.tm_min, tm.tm_sec, (long)tv.tv_usec);
ee4512ed481 16) }

trace2/tr2_tgt_event.c
bce9db6de97  56) tr2env_event_max_nesting_levels = max_nesting;
bce9db6de97  61) tr2env_event_be_brief = want_brief;
ee4512ed481  96)     !strcmp(event_name, "atexit")) {
ee4512ed481 161) static void fn_signal(uint64_t us_elapsed_absolute, int signo)
ee4512ed481 163) const char *event_name = "signal";
ee4512ed481 164) struct json_writer jw = JSON_WRITER_INIT;
ee4512ed481 165) double t_abs = (double)us_elapsed_absolute / 1000000.0;
ee4512ed481 167) jw_object_begin(&jw, 0);
ee4512ed481 168) event_fmt_prepare(event_name, __FILE__, __LINE__, NULL, &jw);
ee4512ed481 169) jw_object_double(&jw, "t_abs", 6, t_abs);
ee4512ed481 170) jw_object_intmax(&jw, "signo", signo);
ee4512ed481 171) jw_end(&jw);
ee4512ed481 173) tr2_dst_write_line(&tr2dst_event, &jw.json);
ee4512ed481 174) jw_release(&jw);
ee4512ed481 175) }
ee4512ed481 209) if (fmt && *fmt) {
ee4512ed481 210) jw_object_string(jw, field_name, fmt);
ee4512ed481 211) return;
ee4512ed481 238) static void fn_command_path_fl(const char *file, int line, const char *pathname)
ee4512ed481 240) const char *event_name = "cmd_path";
ee4512ed481 241) struct json_writer jw = JSON_WRITER_INIT;
ee4512ed481 243) jw_object_begin(&jw, 0);
ee4512ed481 244) event_fmt_prepare(event_name, file, line, NULL, &jw);
ee4512ed481 245) jw_object_string(&jw, "path", pathname);
ee4512ed481 246) jw_end(&jw);
ee4512ed481 248) tr2_dst_write_line(&tr2dst_event, &jw.json);
ee4512ed481 249) jw_release(&jw);
ee4512ed481 250) }
ee4512ed481 269) static void fn_command_mode_fl(const char *file, int line, const char *mode)
ee4512ed481 271) const char *event_name = "cmd_mode";
ee4512ed481 272) struct json_writer jw = JSON_WRITER_INIT;
ee4512ed481 274) jw_object_begin(&jw, 0);
ee4512ed481 275) event_fmt_prepare(event_name, file, line, NULL, &jw);
ee4512ed481 276) jw_object_string(&jw, "name", mode);
ee4512ed481 277) jw_end(&jw);
ee4512ed481 279) tr2_dst_write_line(&tr2dst_event, &jw.json);
ee4512ed481 280) jw_release(&jw);
ee4512ed481 281) }
ee4512ed481 283) static void fn_alias_fl(const char *file, int line, const char *alias,
ee4512ed481 286) const char *event_name = "alias";
ee4512ed481 287) struct json_writer jw = JSON_WRITER_INIT;
ee4512ed481 289) jw_object_begin(&jw, 0);
ee4512ed481 290) event_fmt_prepare(event_name, file, line, NULL, &jw);
ee4512ed481 291) jw_object_string(&jw, "alias", alias);
ee4512ed481 292) jw_object_inline_begin_array(&jw, "argv");
ee4512ed481 293) jw_array_argv(&jw, argv);
ee4512ed481 294) jw_end(&jw);
ee4512ed481 295) jw_end(&jw);
ee4512ed481 297) tr2_dst_write_line(&tr2dst_event, &jw.json);
ee4512ed481 298) jw_release(&jw);
ee4512ed481 299) }
ee4512ed481 312) jw_object_string(&jw, "child_class", "hook");
ee4512ed481 313) jw_object_string(&jw, "hook_name", cmd->trace2_hook_name);
ee4512ed481 320) jw_object_string(&jw, "cd", cmd->dir);
ee4512ed481 324) jw_array_string(&jw, "git");
ee4512ed481 354) static void fn_thread_start_fl(const char *file, int line,
ee4512ed481 357) const char *event_name = "thread_start";
ee4512ed481 358) struct json_writer jw = JSON_WRITER_INIT;
ee4512ed481 360) jw_object_begin(&jw, 0);
ee4512ed481 361) event_fmt_prepare(event_name, file, line, NULL, &jw);
ee4512ed481 362) jw_end(&jw);
ee4512ed481 364) tr2_dst_write_line(&tr2dst_event, &jw.json);
ee4512ed481 365) jw_release(&jw);
ee4512ed481 366) }
ee4512ed481 368) static void fn_thread_exit_fl(const char *file, int line,
ee4512ed481 372) const char *event_name = "thread_exit";
ee4512ed481 373) struct json_writer jw = JSON_WRITER_INIT;
ee4512ed481 374) double t_rel = (double)us_elapsed_thread / 1000000.0;
ee4512ed481 376) jw_object_begin(&jw, 0);
ee4512ed481 377) event_fmt_prepare(event_name, file, line, NULL, &jw);
ee4512ed481 378) jw_object_double(&jw, "t_rel", 6, t_rel);
ee4512ed481 379) jw_end(&jw);
ee4512ed481 381) tr2_dst_write_line(&tr2dst_event, &jw.json);
ee4512ed481 382) jw_release(&jw);
ee4512ed481 383) }
ee4512ed481 385) static void fn_exec_fl(const char *file, int line, uint64_t us_elapsed_absolute,
ee4512ed481 388) const char *event_name = "exec";
ee4512ed481 389) struct json_writer jw = JSON_WRITER_INIT;
ee4512ed481 391) jw_object_begin(&jw, 0);
ee4512ed481 392) event_fmt_prepare(event_name, file, line, NULL, &jw);
ee4512ed481 393) jw_object_intmax(&jw, "exec_id", exec_id);
ee4512ed481 394) if (exe)
ee4512ed481 395) jw_object_string(&jw, "exe", exe);
ee4512ed481 396) jw_object_inline_begin_array(&jw, "argv");
ee4512ed481 397) jw_array_argv(&jw, argv);
ee4512ed481 398) jw_end(&jw);
ee4512ed481 399) jw_end(&jw);
ee4512ed481 401) tr2_dst_write_line(&tr2dst_event, &jw.json);
ee4512ed481 402) jw_release(&jw);
ee4512ed481 403) }
ee4512ed481 405) static void fn_exec_result_fl(const char *file, int line,
ee4512ed481 409) const char *event_name = "exec_result";
ee4512ed481 410) struct json_writer jw = JSON_WRITER_INIT;
ee4512ed481 412) jw_object_begin(&jw, 0);
ee4512ed481 413) event_fmt_prepare(event_name, file, line, NULL, &jw);
ee4512ed481 414) jw_object_intmax(&jw, "exec_id", exec_id);
ee4512ed481 415) jw_object_intmax(&jw, "code", code);
ee4512ed481 416) jw_end(&jw);
ee4512ed481 418) tr2_dst_write_line(&tr2dst_event, &jw.json);
ee4512ed481 419) jw_release(&jw);
ee4512ed481 420) }
ee4512ed481 453) static void fn_region_enter_printf_va_fl(const char *file, int line,
ee4512ed481 460) const char *event_name = "region_enter";
ee4512ed481 461) struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
bce9db6de97 462) if (ctx->nr_open_regions <= tr2env_event_max_nesting_levels) {
ee4512ed481 463) struct json_writer jw = JSON_WRITER_INIT;
ee4512ed481 465) jw_object_begin(&jw, 0);
ee4512ed481 466) event_fmt_prepare(event_name, file, line, repo, &jw);
ee4512ed481 467) jw_object_intmax(&jw, "nesting", ctx->nr_open_regions);
ee4512ed481 468) if (category)
ee4512ed481 469) jw_object_string(&jw, "category", category);
ee4512ed481 470) if (label)
ee4512ed481 471) jw_object_string(&jw, "label", label);
ee4512ed481 472) maybe_add_string_va(&jw, "msg", fmt, ap);
ee4512ed481 473) jw_end(&jw);
ee4512ed481 475) tr2_dst_write_line(&tr2dst_event, &jw.json);
ee4512ed481 476) jw_release(&jw);
ee4512ed481 478) }
ee4512ed481 480) static void fn_region_leave_printf_va_fl(
ee4512ed481 485) const char *event_name = "region_leave";
ee4512ed481 486) struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
bce9db6de97 487) if (ctx->nr_open_regions <= tr2env_event_max_nesting_levels) {
ee4512ed481 488) struct json_writer jw = JSON_WRITER_INIT;
ee4512ed481 489) double t_rel = (double)us_elapsed_region / 1000000.0;
ee4512ed481 491) jw_object_begin(&jw, 0);
ee4512ed481 492) event_fmt_prepare(event_name, file, line, repo, &jw);
ee4512ed481 493) jw_object_double(&jw, "t_rel", 6, t_rel);
ee4512ed481 494) jw_object_intmax(&jw, "nesting", ctx->nr_open_regions);
ee4512ed481 495) if (category)
ee4512ed481 496) jw_object_string(&jw, "category", category);
ee4512ed481 497) if (label)
ee4512ed481 498) jw_object_string(&jw, "label", label);
ee4512ed481 499) maybe_add_string_va(&jw, "msg", fmt, ap);
ee4512ed481 500) jw_end(&jw);
ee4512ed481 502) tr2_dst_write_line(&tr2dst_event, &jw.json);
ee4512ed481 503) jw_release(&jw);
ee4512ed481 505) }
ee4512ed481 534) static void fn_data_json_fl(const char *file, int line,
ee4512ed481 540) const char *event_name = "data_json";
ee4512ed481 541) struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
bce9db6de97 542) if (ctx->nr_open_regions <= tr2env_event_max_nesting_levels) {
ee4512ed481 543) struct json_writer jw = JSON_WRITER_INIT;
ee4512ed481 544) double t_abs = (double)us_elapsed_absolute / 1000000.0;
ee4512ed481 545) double t_rel = (double)us_elapsed_region / 1000000.0;
ee4512ed481 547) jw_object_begin(&jw, 0);
ee4512ed481 548) event_fmt_prepare(event_name, file, line, repo, &jw);
ee4512ed481 549) jw_object_double(&jw, "t_abs", 6, t_abs);
ee4512ed481 550) jw_object_double(&jw, "t_rel", 6, t_rel);
ee4512ed481 551) jw_object_intmax(&jw, "nesting", ctx->nr_open_regions);
ee4512ed481 552) jw_object_string(&jw, "category", category);
ee4512ed481 553) jw_object_string(&jw, "key", key);
ee4512ed481 554) jw_object_sub_jw(&jw, "value", value);
ee4512ed481 555) jw_end(&jw);
ee4512ed481 557) tr2_dst_write_line(&tr2dst_event, &jw.json);
ee4512ed481 558) jw_release(&jw);
ee4512ed481 560) }

trace2/tr2_tgt_normal.c
ee4512ed481  53) tr2_tbuf_local_time(&tb_now);
ee4512ed481  54) strbuf_addstr(buf, tb_now.buf);
ee4512ed481  55) strbuf_addch(buf, ' ');
ee4512ed481  57) if (file && *file)
ee4512ed481  58) strbuf_addf(buf, "%s:%d ", file, line);
ee4512ed481  59) while (buf->len < TR2FMT_NORMAL_FL_WIDTH)
ee4512ed481  60) strbuf_addch(buf, ' ');
ee4512ed481 106) static void fn_signal(uint64_t us_elapsed_absolute, int signo)
ee4512ed481 108) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed481 109) double elapsed = (double)us_elapsed_absolute / 1000000.0;
ee4512ed481 111) strbuf_addf(&buf_payload, "signal elapsed:%.6f code:%d", elapsed,
ee4512ed481 113) normal_io_write_fl(__FILE__, __LINE__, &buf_payload);
ee4512ed481 114) strbuf_release(&buf_payload);
ee4512ed481 115) }
ee4512ed481 139) if (fmt && *fmt) {
ee4512ed481 140) strbuf_addstr(buf, fmt);
ee4512ed481 141) return;
ee4512ed481 156) static void fn_command_path_fl(const char *file, int line, const char *pathname)
ee4512ed481 158) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed481 160) strbuf_addf(&buf_payload, "cmd_path %s", pathname);
ee4512ed481 161) normal_io_write_fl(file, line, &buf_payload);
ee4512ed481 162) strbuf_release(&buf_payload);
ee4512ed481 163) }
ee4512ed481 177) static void fn_command_mode_fl(const char *file, int line, const char *mode)
ee4512ed481 179) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed481 181) strbuf_addf(&buf_payload, "cmd_mode %s", mode);
ee4512ed481 182) normal_io_write_fl(file, line, &buf_payload);
ee4512ed481 183) strbuf_release(&buf_payload);
ee4512ed481 184) }
ee4512ed481 186) static void fn_alias_fl(const char *file, int line, const char *alias,
ee4512ed481 189) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed481 191) strbuf_addf(&buf_payload, "alias %s ->", alias);
ee4512ed481 192) sq_quote_argv_pretty(&buf_payload, argv);
ee4512ed481 193) normal_io_write_fl(file, line, &buf_payload);
ee4512ed481 194) strbuf_release(&buf_payload);
ee4512ed481 195) }
ee4512ed481 197) static void fn_child_start_fl(const char *file, int line,
ee4512ed481 201) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed481 203) strbuf_addf(&buf_payload, "child_start[%d] ", cmd->trace2_child_id);
ee4512ed481 205) if (cmd->dir) {
ee4512ed481 206) strbuf_addstr(&buf_payload, " cd");
ee4512ed481 207) sq_quote_buf_pretty(&buf_payload, cmd->dir);
ee4512ed481 208) strbuf_addstr(&buf_payload, "; ");
ee4512ed481 216) if (cmd->git_cmd)
ee4512ed481 217) strbuf_addstr(&buf_payload, "git");
ee4512ed481 218) sq_quote_argv_pretty(&buf_payload, cmd->argv);
ee4512ed481 220) normal_io_write_fl(file, line, &buf_payload);
ee4512ed481 221) strbuf_release(&buf_payload);
ee4512ed481 222) }
ee4512ed481 224) static void fn_child_exit_fl(const char *file, int line,
ee4512ed481 228) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed481 229) double elapsed = (double)us_elapsed_child / 1000000.0;
ee4512ed481 231) strbuf_addf(&buf_payload, "child_exit[%d] pid:%d code:%d elapsed:%.6f",
ee4512ed481 233) normal_io_write_fl(file, line, &buf_payload);
ee4512ed481 234) strbuf_release(&buf_payload);
ee4512ed481 235) }
ee4512ed481 237) static void fn_exec_fl(const char *file, int line, uint64_t us_elapsed_absolute,
ee4512ed481 240) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed481 242) strbuf_addf(&buf_payload, "exec[%d] ", exec_id);
ee4512ed481 243) if (exe)
ee4512ed481 244) strbuf_addstr(&buf_payload, exe);
ee4512ed481 245) sq_quote_argv_pretty(&buf_payload, argv);
ee4512ed481 246) normal_io_write_fl(file, line, &buf_payload);
ee4512ed481 247) strbuf_release(&buf_payload);
ee4512ed481 248) }
ee4512ed481 250) static void fn_exec_result_fl(const char *file, int line,
ee4512ed481 254) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed481 256) strbuf_addf(&buf_payload, "exec_result[%d] code:%d", exec_id, code);
ee4512ed481 257) if (code > 0)
ee4512ed481 258) strbuf_addf(&buf_payload, " err:%s", strerror(code));
ee4512ed481 259) normal_io_write_fl(file, line, &buf_payload);
ee4512ed481 260) strbuf_release(&buf_payload);
ee4512ed481 261) }
ee4512ed481 263) static void fn_param_fl(const char *file, int line, const char *param,
ee4512ed481 266) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed481 268) strbuf_addf(&buf_payload, "def_param %s=%s", param, value);
ee4512ed481 269) normal_io_write_fl(file, line, &buf_payload);
ee4512ed481 270) strbuf_release(&buf_payload);
ee4512ed481 271) }
ee4512ed481 284) static void fn_printf_va_fl(const char *file, int line,
ee4512ed481 288) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed481 290) maybe_append_string_va(&buf_payload, fmt, ap);
ee4512ed481 291) normal_io_write_fl(file, line, &buf_payload);
ee4512ed481 292) strbuf_release(&buf_payload);
ee4512ed481 293) }

trace2/tr2_tgt_perf.c
ee4512ed481  83) tr2_tbuf_local_time(&tb_now);
ee4512ed481  84) strbuf_addstr(buf, tb_now.buf);
ee4512ed481  85) strbuf_addch(buf, ' ');
ee4512ed481  87) if (file && *file)
ee4512ed481  88) strbuf_addf(buf, "%s:%d ", file, line);
ee4512ed481  89) while (buf->len < TR2FMT_PERF_FL_WIDTH)
ee4512ed481  90) strbuf_addch(buf, ' ');
ee4512ed481  92) strbuf_addstr(buf, "| ");
ee4512ed481 125) strbuf_addbuf(buf, &dots);
ee4512ed481 126) len_indent -= dots.len;
ee4512ed481 188) static void fn_signal(uint64_t us_elapsed_absolute, int signo)
ee4512ed481 190) const char *event_name = "signal";
ee4512ed481 191) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed481 193) strbuf_addf(&buf_payload, "signo:%d", signo);
ee4512ed481 195) perf_io_write_fl(__FILE__, __LINE__, event_name, NULL,
ee4512ed481 197) strbuf_release(&buf_payload);
ee4512ed481 198) }
ee4512ed481 224) if (fmt && *fmt) {
ee4512ed481 225) strbuf_addstr(buf, fmt);
ee4512ed481 226) return;
ee4512ed481 243) static void fn_command_path_fl(const char *file, int line, const char *pathname)
ee4512ed481 245) const char *event_name = "cmd_path";
ee4512ed481 246) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed481 248) strbuf_addstr(&buf_payload, pathname);
ee4512ed481 250) perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
ee4512ed481 252) strbuf_release(&buf_payload);
ee4512ed481 253) }
ee4512ed481 270) static void fn_command_mode_fl(const char *file, int line, const char *mode)
ee4512ed481 272) const char *event_name = "cmd_mode";
ee4512ed481 273) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed481 275) strbuf_addstr(&buf_payload, mode);
ee4512ed481 277) perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
ee4512ed481 279) strbuf_release(&buf_payload);
ee4512ed481 280) }
ee4512ed481 282) static void fn_alias_fl(const char *file, int line, const char *alias,
ee4512ed481 285) const char *event_name = "alias";
ee4512ed481 286) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed481 288) strbuf_addf(&buf_payload, "alias:%s argv:", alias);
ee4512ed481 289) sq_quote_argv_pretty(&buf_payload, argv);
ee4512ed481 291) perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
ee4512ed481 293) strbuf_release(&buf_payload);
ee4512ed481 294) }
ee4512ed481 304) strbuf_addf(&buf_payload, "[ch%d] class:hook hook:%s",
ee4512ed481 314) strbuf_addstr(&buf_payload, " cd:");
ee4512ed481 315) sq_quote_buf_pretty(&buf_payload, cmd->dir);
ee4512ed481 320) strbuf_addstr(&buf_payload, " git");
ee4512ed481 342) static void fn_thread_start_fl(const char *file, int line,
ee4512ed481 345) const char *event_name = "thread_start";
ee4512ed481 346) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed481 348) perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
ee4512ed481 350) strbuf_release(&buf_payload);
ee4512ed481 351) }
ee4512ed481 353) static void fn_thread_exit_fl(const char *file, int line,
ee4512ed481 357) const char *event_name = "thread_exit";
ee4512ed481 358) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed481 360) perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
ee4512ed481 362) strbuf_release(&buf_payload);
ee4512ed481 363) }
ee4512ed481 365) static void fn_exec_fl(const char *file, int line, uint64_t us_elapsed_absolute,
ee4512ed481 368) const char *event_name = "exec";
ee4512ed481 369) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed481 371) strbuf_addf(&buf_payload, "id:%d ", exec_id);
ee4512ed481 372) strbuf_addstr(&buf_payload, "argv:");
ee4512ed481 373) if (exe)
ee4512ed481 374) strbuf_addf(&buf_payload, " %s", exe);
ee4512ed481 375) sq_quote_argv_pretty(&buf_payload, argv);
ee4512ed481 377) perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
ee4512ed481 379) strbuf_release(&buf_payload);
ee4512ed481 380) }
ee4512ed481 382) static void fn_exec_result_fl(const char *file, int line,
ee4512ed481 386) const char *event_name = "exec_result";
ee4512ed481 387) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed481 389) strbuf_addf(&buf_payload, "id:%d code:%d", exec_id, code);
ee4512ed481 390) if (code > 0)
ee4512ed481 391) strbuf_addf(&buf_payload, " err:%s", strerror(code));
ee4512ed481 393) perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
ee4512ed481 395) strbuf_release(&buf_payload);
ee4512ed481 396) }
ee4512ed481 398) static void fn_param_fl(const char *file, int line, const char *param,
ee4512ed481 401) const char *event_name = "def_param";
ee4512ed481 402) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed481 404) strbuf_addf(&buf_payload, "%s:%s", param, value);
ee4512ed481 406) perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
ee4512ed481 408) strbuf_release(&buf_payload);
ee4512ed481 409) }
ee4512ed481 425) static void fn_region_enter_printf_va_fl(const char *file, int line,
ee4512ed481 432) const char *event_name = "region_enter";
ee4512ed481 433) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed481 435) if (label)
ee4512ed481 436) strbuf_addf(&buf_payload, "label:%s ", label);
ee4512ed481 437) maybe_append_string_va(&buf_payload, fmt, ap);
ee4512ed481 439) perf_io_write_fl(file, line, event_name, repo, &us_elapsed_absolute,
ee4512ed481 441) strbuf_release(&buf_payload);
ee4512ed481 442) }
ee4512ed481 444) static void fn_region_leave_printf_va_fl(
ee4512ed481 449) const char *event_name = "region_leave";
ee4512ed481 450) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed481 452) if (label)
ee4512ed481 453) strbuf_addf(&buf_payload, "label:%s ", label);
ee4512ed481 454) maybe_append_string_va(&buf_payload, fmt, ap);
ee4512ed481 456) perf_io_write_fl(file, line, event_name, repo, &us_elapsed_absolute,
ee4512ed481 458) strbuf_release(&buf_payload);
ee4512ed481 459) }
ee4512ed481 461) static void fn_data_fl(const char *file, int line, uint64_t us_elapsed_absolute,
ee4512ed481 466) const char *event_name = "data";
ee4512ed481 467) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed481 469) strbuf_addf(&buf_payload, "%s:%s", key, value);
ee4512ed481 471) perf_io_write_fl(file, line, event_name, repo, &us_elapsed_absolute,
ee4512ed481 473) strbuf_release(&buf_payload);
ee4512ed481 474) }
ee4512ed481 476) static void fn_data_json_fl(const char *file, int line,
ee4512ed481 482) const char *event_name = "data_json";
ee4512ed481 483) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed481 485) strbuf_addf(&buf_payload, "%s:%s", key, value->json.buf);
ee4512ed481 487) perf_io_write_fl(file, line, event_name, repo, &us_elapsed_absolute,
ee4512ed481 489) strbuf_release(&buf_payload);
ee4512ed481 490) }
ee4512ed481 492) static void fn_printf_va_fl(const char *file, int line,
ee4512ed481 496) const char *event_name = "printf";
ee4512ed481 497) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed481 499) maybe_append_string_va(&buf_payload, fmt, ap);
ee4512ed481 501) perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
ee4512ed481 503) strbuf_release(&buf_payload);
ee4512ed481 504) }

trace2/tr2_tls.c
ee4512ed481  52) strbuf_addf(&ctx->thread_name, "th%02d:", ctx->thread_id);
ee4512ed481  55) strbuf_setlen(&ctx->thread_name, TR2_MAX_THREAD_NAME);
a089724958a  72) ctx = tr2tls_create_self("unknown", getnanotime() / 1000);
ee4512ed481  77) int tr2tls_is_main_thread(void)
ee4512ed481  79) struct tr2tls_thread_ctx *ctx = pthread_getspecific(tr2tls_key);
ee4512ed481  81) return ctx == tr2tls_thread_main;
ee4512ed481  96) void tr2tls_push_self(uint64_t us_now)
ee4512ed481  98) struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
ee4512ed481 100) ALLOC_GROW(ctx->array_us_start, ctx->nr_open_regions + 1, ctx->alloc);
ee4512ed481 101) ctx->array_us_start[ctx->nr_open_regions++] = us_now;
ee4512ed481 102) }
ee4512ed481 104) void tr2tls_pop_self(void)
ee4512ed481 106) struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
ee4512ed481 108) if (!ctx->nr_open_regions)
ee4512ed481 111) ctx->nr_open_regions--;
ee4512ed481 112) }
ee4512ed481 119) tr2tls_pop_self();
ee4512ed481 129) return 0;
ee4512ed481 139) return 0;

unpack-trees.c
191e9d2c2da 1699) return add_rejected_path(o, error_type, ce->name);
b165fac8c19 2346) return o->quiet ? -1 :

worktree.c
e8805af1c33 471) clear_repository_format(&format);

Commits introducing uncovered code:
Ævar Arnfjörð Bjarmason      43d3561805: commit-graph write: don't die if the existing graph is corrupt
Ævar Arnfjörð Bjarmason      61df89c8e5: commit-graph: don't early exit(1) on e.g. "git status"
Ævar Arnfjörð Bjarmason      93b4405ffe: commit-graph: improve & i18n error messages
Ævar Arnfjörð Bjarmason      bf3d70fe93: gc: handle & check gc.reflogExpire config
Alban Gruin      616d7740cf: sequencer: introduce todo_list_write_to_file()
Alban Gruin      6bfeb7f1b5: sequencer: refactor skip_unnecessary_picks() to work on a todo_list
Alban Gruin      6ca89c6f39: sequencer: refactor check_todo_list() to work on a todo_list
Alban Gruin      94bcad7979: sequencer: change complete_action() to use the refactored functions
Alban Gruin      a930eb03a8: rebase-interactive: rewrite edit_todo_list() to handle the initial edit
Anders Waldenborg      4f732e0fd7: pretty: allow %(trailers) options with explicit value
Anders Waldenborg      fd2015b323: strbuf: separate callback for strbuf_expand:ing literals
Brandon Richardson      cbdeab98e8: commit-tree: utilize parse-options api
brian m. carlson      05dfc7cac4: http: replace sha1_to_hex
brian m. carlson      0dd4924891: pack-bitmap: replace sha1_to_hex
brian m. carlson      28d055bde9: fast-import: make hash-size independent
brian m. carlson      2bf1db7862: http-walker: replace sha1_to_hex
brian m. carlson      95399788d1: hash: add a function to lookup hash algorithm by length
brian m. carlson      9c9492e8aa: remote-curl: make hash size independent
brian m. carlson      ebe4df59c4: builtin/difftool: use parse_oid_hex
brian m. carlson      eed0e60f02: http: compute hash of downloaded objects using the_hash_algo
brian m. carlson      ef479a12bd: fast-import: replace sha1_to_hex
Christian Couder      ee521ec4cb: replace: peel tag when passing a tag first to --graft
Christian Couder      f8e44a81bf: replace: peel tag when passing a tag as parent to --graft
Daniels Umanovskis      0ecb1fc726: branch: introduce --show-current display option
Denton Liu      01dc801ada: tag: fix formatting
Denton Liu      d540b70c85: merge: cleanup messages like commit
Elijah Newren      259ccb6cc3: merge-recursive: rename merge_options argument from 'o' to 'opt'
Elijah Newren      5056bb7646: fast-import: check most prominent commands first
Elijah Newren      7ffde293f2: fast-import: only allow cat-blob requests where it makes sense
Elijah Newren      8c8e5bd6eb: merge-recursive: switch directory rename detection default
Elijah Newren      8daec1df03: merge-recursive: switch from (oid,mode) pairs to a diff_filespec
Elijah Newren      cf7b857a77: fast-import: fix erroneous handling of get-mark with empty orphan commits
Elijah Newren      d76ce4f734: log,diff-tree: add --combined-all-paths option
Elijah Newren      e3de888ca0: merge-recursive: rename diff_filespec 'one' to 'o'
Jeff Hostetler      08881b9a4c: trace2: make SIDs more unique
Jeff Hostetler      9d81ecb52b: progress: add sparse mode to force 100% complete message
Jeff Hostetler      a089724958: trace2: refactor setting process starting time
Jeff Hostetler      b3a5d5a80c: trace2:data: add subverb for rebase
Jeff Hostetler      bce9db6de9: trace2: use system/global config for default trace2 settings
Jeff Hostetler      ee4512ed48: trace2: create new combined trace facility
Jeff Hostetler      eee73d1dce: trace2:data: add editor/pager child classification
Jeff King      057ab54b66: completion: fix multiple command removals
Jeff King      37c80012f1: fetch: avoid calling write_or_die()
Jeff King      4828ce9871: pack-revindex: open index if necessary
Jeff King      4ecbd6492c: server-info: use strbuf to read old info/packs file
Jeff King      5205749d2c: parse-options: drop unused ctx parameter from show_gitcomp()
Jeff King      7954d365c6: log: drop unused rev_info from early output
Jeff King      8320b1dbe7: revision: use a prio_queue to hold rewritten parents
Jeff King      8d8c2a5aef: fsck: always compute USED flags for unreachable objects
Jeff King      b83a3089b5: server-info: fix blind pointer arithmetic
Jeff King      c409d108b8: pack-objects: drop unused parameter from oe_map_new_pack()
Jeff King      d55a30bb1d: prune: lazily perform reachability traversal
Jeff King      ddc56d4710: http: simplify parsing of remote objects/info/packs
Jeff King      fc78915674: packfile: fix pack basename computation
Jeff King      fde67d6896: prune: use bitmaps for reachability traversal
Joel Teichroeb      4e2dd39303: stash: convert drop and clear to builtin
Joel Teichroeb      8a0fc8d19d: stash: convert apply to builtin
Joel Teichroeb      c4de61d7a9: stash: convert pop to builtin
Johannes Schindelin      20de316e33: difftool: allow running outside Git worktrees with --no-index
Johannes Schindelin      7906af0cb8: tests: add a special setup where stash.useBuiltin is off
Johannes Schindelin      90a462725e: stash: optionally use the scripted version again
Johannes Schindelin      c1284b21f2: curl: anonymize URLs in error messages and warnings
Johannes Schindelin      cbd29ead92: built-in rebase: set ORIG_HEAD just once, before the rebase
Johannes Schindelin      ed8b4132c8: remote-curl: mark all error messages for translation
Jonathan Tan      1339078f5e: fetch-pack: respect --no-update-shallow in v2
Jonathan Tan      8cbeba0632: tests: define GIT_TEST_PROTOCOL_VERSION
Jonathan Tan      a97d00799a: remote-curl: use post_rpc() for protocol v2 also
Josh Steadmon      22a7338318: trace2: fix incorrect function pointer check
Josh Steadmon      a4d3a283db: trace2: write to directory targets
Junio C Hamano      5b2d1c0c6e: Merge branch 'jh/trace2-sid-fix'
Junio C Hamano      aa1edf14f9: Merge branch 'js/remote-curl-i18n'
Junio C Hamano      bc208ae314: builtin/log: downcase the beginning of error messages
Martin Ågren      e8805af1c3: setup: fix memory leaks with `struct repository_format`
Michal Suchanek      7af01f2367: worktree: fix worktree add race
Nguyễn Thái Ngọc Duy      10f35b1cc0: diff-parseopt: convert --diff-algorithm
Nguyễn Thái Ngọc Duy      125dcea963: diff-parseopt: convert --submodule
Nguyễn Thái Ngọc Duy      16bb3d714d: diff --no-index: use parse_options() instead of diff_opt_parse()
Nguyễn Thái Ngọc Duy      191e9d2c2d: unpack-trees: keep gently check inside add_rejected_path
Nguyễn Thái Ngọc Duy      3ebbe28989: parse-options: allow ll_callback with OPTION_CALLBACK
Nguyễn Thái Ngọc Duy      567009033f: refs.c: add repo_dwim_log()
Nguyễn Thái Ngọc Duy      59311a9820: diff-parseopt: convert --[no-]color-moved
Nguyễn Thái Ngọc Duy      5a749d9f97: diff-parseopt: convert --ws-error-highlight
Nguyễn Thái Ngọc Duy      7d7942b796: diff-parseopt: convert --[no-]compact-summary
Nguyễn Thái Ngọc Duy      7f64850d36: diff-parseopt: convert -C|--find-copies
Nguyễn Thái Ngọc Duy      7fdff47432: refs.c: remove the_repo from read_ref_at()
Nguyễn Thái Ngọc Duy      84b5089e41: diff-parseopt: convert --stat*
Nguyễn Thái Ngọc Duy      a7256debd4: checkout.txt: note about losing staged changes with --merge
Nguyễn Thái Ngọc Duy      a75f28cbda: diff-parseopt: convert --find-object
Nguyễn Thái Ngọc Duy      af2f368091: diff-parseopt: convert --output-*
Nguyễn Thái Ngọc Duy      b165fac8c1: unpack-trees: rename "gently" flag to "quiet"
Nguyễn Thái Ngọc Duy      bb9872904e: diff.c: allow --no-color-moved-ws
Nguyễn Thái Ngọc Duy      c931ba4e78: sha1-name.c: remove the_repo from handle_one_ref()
Nguyễn Thái Ngọc Duy      ced4e179fe: diff-parseopt: convert -B|--break-rewrites
Nguyễn Thái Ngọc Duy      d2d3f27300: diff-parseopt: convert --diff-filter
Nguyễn Thái Ngọc Duy      d473e2e0e8: diff.c: convert -U|--unified
Nguyễn Thái Ngọc Duy      d877418390: diff-parseopt: convert --[no-]abbrev
Nguyễn Thái Ngọc Duy      e9fb39b668: diff-parseopt: convert --word-diff
Nguyễn Thái Ngọc Duy      f476308b27: diff-parseopt: convert -M|--find-renames
Paul-Sebastian Ungureanu      1ac528c0b0: stash: make push -q quiet
Paul-Sebastian Ungureanu      40af146834: stash: convert `stash--helper.c` into `stash.c`
Paul-Sebastian Ungureanu      41e0dd55c4: stash: convert store to builtin
Paul-Sebastian Ungureanu      5ef264dbdb: strbuf.c: add `strbuf_insertf()` and `strbuf_vinsertf()`
Paul-Sebastian Ungureanu      d4788af875: stash: convert create to builtin
Paul-Sebastian Ungureanu      d553f538b8: stash: convert push to builtin
Paul-Sebastian Ungureanu      dc7bd382b1: stash: convert show to builtin
Phillip Wood      0609b741a4: rebase -i: combine rebase--interactive.c with rebase.c
Phillip Wood      0ea0847ef0: rebase -i: use struct rebase_options in do_interactive_rebase()
Phillip Wood      338985317e: rebase -i: use struct object_id for squash_onto
Phillip Wood      460bc3ce73: rebase -i: run without forking rebase--interactive
Phillip Wood      4a72486de9: fix cherry-pick/revert status after commit
Phillip Wood      73fdc535d2: rebase -i: use struct rebase_options to parse args
Phillip Wood      7d3488eb89: rebase -i: use struct commit when parsing options
Phillip Wood      b07d9bfd17: commit/reset: try to clean up sequencer state
Phillip Wood      c44c24621d: rebase -i: remove duplication
Phillip Wood      d74f3e5811: sequencer: fix cleanup with --signoff and -x
Phillip Wood      dc42e9a83a: sequencer.c: save and restore cleanup mode
Phillip Wood      f59199d5fa: sequencer: break some long lines
Ramsay Jones      9b0bd87ed2: prune-packed: check for too many arguments
Rene Scharfe      3548726cd7: get-tar-commit-id: parse comment record
René Scharfe      878056005e: sequencer: factor out strbuf_read_file_or_whine()
SZEDER Gábor      545dc345eb: progress: break too long progress bar lines
SZEDER Gábor      a544fb08f8: blame: default to HEAD in a bare repo when no start commit is given
Thomas Gummerer      091e04bc8c: checkout: introduce --{,no-}overlay option
Thomas Gummerer      7cb7283adb: ls-files: use correct format string
William Hubbs      39ab4d0951: config: allow giving separate author and committer idents
