Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43F7A1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 13:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbeJ0WI1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 18:08:27 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]:44827 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbeJ0WI1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 18:08:27 -0400
Received: by mail-qk1-f175.google.com with SMTP id n12so2349602qkh.11
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 06:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=a/hGspUFmSlvlkXlU1SaCgzT4ZeYA36gBpaIlCPcp6w=;
        b=izKn8rAh3631CbmQ55kd1545yfvPm10v6ePa4pMRQHNyU+H4dhKguLGIop4mFNY10l
         WgpydyxfpR6tc6on97wOTCBgpfEzew6VEbXSsCNU783iJkhPxSHWmLlHCyWcdayKZkRn
         qHD8dMTTVj3yEi7CkAEmMVXrd9xhf5qdcAoHNeLnpcqkFLRDRdZcZndR+lNLkzSmm+tW
         9ank8AF5vOdCio2qIyyModa81uBjdk0d6NWvAWIBGGa/wtGZoEpXbiy3RgJtcbKmC4kD
         9+LkwOHywugpQRVNORIjMQ7fEgRHmgYmBNmeDYJ1VyPbzBPBd8BQJf1Hdey2S9aNfOQS
         SD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=a/hGspUFmSlvlkXlU1SaCgzT4ZeYA36gBpaIlCPcp6w=;
        b=IS70lHB45kHESg0LD4gp3Bg9s3TCLZZ7Aqq52H9C5Wcx8bjSRl75JfUNv2DBurKGE6
         guUzftiu7+gAcOQV/kVHpYG2NUVf/H2mcDzpg9wRV190TzGkKzO+eh4uTXvw2Fvi2ziw
         CDMHbh7E6YPbn0Uw3mWJcYkqrO/bqIvDxg7hJCYxl2UJ5RBTUXDJmu26HrYd+LZjU8tz
         VNs0quEdPLwoUoAHd3Z+x8J+UCzti3OL9c6j5kneN22wB4rfUPVF3NCPvw0epTBkZdsN
         Om3hbKJUdcRes275+35OLsINw7rRlkX2biUqEHUhC8QB8Vwm4oSDsNDCuzxdIS1rQ4k3
         R8Mg==
X-Gm-Message-State: AGRZ1gL1u5k6tRzOoHv8HtuYLFvVmr66mq0pObE/Vb6y5kyFwn2IZs5X
        Q+9vwVsJ8jDEvcLAQ1VFRqc6KdAq
X-Google-Smtp-Source: AJdET5elhikqVj4Zcu4THh5e0DrgT+S6uNXx9x/AJ63fs4o5Zr9zRJoL4tf1ProAVs33uk6H6uzfLA==
X-Received: by 2002:a37:7dc4:: with SMTP id y187-v6mr6670957qkc.211.1540646843212;
        Sat, 27 Oct 2018 06:27:23 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id c8-v6sm9122658qkb.81.2018.10.27.06.27.22
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 06:27:22 -0700 (PDT)
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (Saturday, Oct 27)
Message-ID: <5db6213b-b7d0-b995-de80-9671604416a5@gmail.com>
Date:   Sat, 27 Oct 2018 09:27:21 -0400
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
diff A B' to discover _new_lines of code that are not covered. This 
report ignores lines including "BUG(".

This report takes the output of these results after running on four 
branches:

         pu: a5dda2204a27a14f65171e29307400194b522051
        jch: 280dd2581eb7191db037cf1243dd64fd200455ba
       next: 0250525e6984e0e5e803c7e2e3417279b036f1c9
     master: c670b1f876521c9f7cd40184bf7ed05aad843433
master@{1}: c4df23f7927d8d00e666a3c8d1b3375f1dc8a3c1


Uncovered in pu not in jch
--------------------------
(Note: t4041-diff-submodule-option.sh failed with extra test options, so 
some lines that
would be covered by that test run were not covered.)

builtin/blame.c
a5dda2204a builtin/blame.c    200) 
repo_unuse_commit_buffer(the_repository, commit, message);
74e8221b52 builtin/blame.c    924) blame_date_width = sizeof("Thu Oct 19 
16:00");
74e8221b52 builtin/blame.c    925) break;

builtin/describe.c
a5dda2204a builtin/describe.c 257) repo_parse_commit(the_repository, p);

builtin/fsck.c
b29759d89a builtin/fsck.c 613) fprintf(stderr, "Checking %s link\n", 
head_ref_name);
b29759d89a builtin/fsck.c 618) return error("Invalid %s", head_ref_name);

builtin/grep.c
c22b820141 builtin/grep.c  442) grep_read_unlock();

builtin/pack-objects.c
a5dda2204a builtin/pack-objects.c 2852) if 
(!repo_has_object_file(the_repository, &obj->oid) && 
is_promisor_object(&obj->oid))

builtin/rebase--interactive.c
6424061be4 builtin/rebase--interactive.c   23) return 
error_errno(_("could not read '%s'."), todo_file);
6424061be4 builtin/rebase--interactive.c   28) return 
error_errno(_("could not write '%s'"), todo_file);
7ccfac40bc builtin/rebase--interactive.c   43) return 
error_errno(_("could not read '%s'."), todo_file);
7ccfac40bc builtin/rebase--interactive.c   46) 
todo_list_release(&todo_list);
7ccfac40bc builtin/rebase--interactive.c   47) return error(_("unusable 
todo list: '%s'"), todo_file);
9787d17d40 builtin/rebase--interactive.c  294) ret = 
rearrange_squash_in_todo_file();

builtin/reflog.c
c9ef0d95eb builtin/reflog.c 581) all_worktrees = 0;
c9ef0d95eb builtin/reflog.c 617) continue;

date.c
74e8221b52  113) die("Timestamp too large for this system: %"PRItime, time);
74e8221b52  216) if (tm->tm_mon == human_tm->tm_mon) {
74e8221b52  217) if (tm->tm_mday > human_tm->tm_mday) {
74e8221b52  219) } else if (tm->tm_mday == human_tm->tm_mday) {
74e8221b52  220) hide.date = hide.wday = 1;
74e8221b52  221) } else if (tm->tm_mday + 5 > human_tm->tm_mday) {
74e8221b52  223) hide.date = 1;
74e8221b52  231) gettimeofday(&now, NULL);
74e8221b52  232) show_date_relative(time, tz, &now, buf);
74e8221b52  233) return;
74e8221b52  246) hide.seconds = 1;
74e8221b52  247) hide.tz |= !hide.date;
74e8221b52  248) hide.wday = hide.time = !hide.year;
74e8221b52  262) strbuf_rtrim(buf);
74e8221b52  287) gettimeofday(&now, NULL);
74e8221b52  290) human_tz = local_time_tzoffset(now.tv_sec, &human_tm);
74e8221b52  886) static int auto_date_style(void)
74e8221b52  888) return (isatty(1) || pager_in_use()) ? DATE_HUMAN : 
DATE_NORMAL;
74e8221b52  909) return DATE_HUMAN;
74e8221b52  911) return auto_date_style();

fsck.c
a5dda2204a  858) repo_unuse_commit_buffer(the_repository, commit, buffer);
a5dda2204a  878) repo_read_object_file(the_repository,
a5dda2204a  879)       &tag->object.oid, &type, &size);

http-push.c
a5dda2204a 1635) if (!repo_has_object_file(the_repository, &head_oid))
a5dda2204a 1642) if (!repo_has_object_file(the_repository, 
&remote_ref->old_oid))

merge-recursive.c
4cdc48e412 1585) return -1;
4cdc48e412 1588) return -1;
4cdc48e412 1594) return -1;
4cdc48e412 1596) if (update_file(o, 1, b_oid, b_mode, collide_path))
4cdc48e412 1597) return -1;
4cdc48e412 1664) return -1;
4cdc48e412 1667) return -1;
4cdc48e412 1670) return -1;
b58ae691c0 1703) return -1;
387361a6a7 1738) return -1;
387361a6a7 1786) return -1;
387361a6a7 1795) new_path = unique_path(o, a->path, ci->branch1);
387361a6a7 1796) output(o, 1, _("Refusing to lose untracked file"
387361a6a7 1802) return -1;
387361a6a7 1805) return -1;
387361a6a7 1815) return -1;
387361a6a7 1831) return -1;
387361a6a7 1834) return -1;

midx.c
1dcd9f2043  184) return;

negotiator/default.c
a5dda2204a  71) if (repo_parse_commit(the_repository, commit))

packfile.c
dc7d664335  350) close_midx(o->multi_pack_index);
dc7d664335  351) o->multi_pack_index = NULL;

rebase-interactive.c
b74a37a5a7  26) warning(_("unrecognized setting %s for option "
6424061be4 107) return error_errno(_("could not write '%s''"), todo_file);
6424061be4 110) return error(_("could not copy '%s' to '%s'."), todo_file,
b74a37a5a7 174) goto leave_check;

refs.c
3a3b9d8cde  657) return 0;

refs/files-backend.c
revision.c
a5dda2204a  726) if (repo_parse_commit(the_repository, p) < 0)

sequencer.c
a5dda2204a 1597) repo_unuse_commit_buffer(the_repository, head_commit,
a5dda2204a 3821) repo_unuse_commit_buffer(the_repository,
b5d6062402 4486) strbuf_insert(buf, todo_list->items[insert].offset_in_buf +
b5d6062402 4498) int sequencer_add_exec_commands(const char *commands)
06d8136126 4505) return error_errno(_("could not read '%s'."), todo_file);
b5d6062402 4507) if (todo_list_parse_insn_buffer(todo_list.buf.buf, 
&todo_list)) {
b5d6062402 4512) todo_list_add_exec_commands(&todo_list, commands);
b5d6062402 4513) res = write_message(todo_list.buf.buf, 
todo_list.buf.len, todo_file, 0);
0cce4a2756 4514) todo_list_release(&todo_list);
b5d6062402 4516) return res;
b74a37a5a7 4576) goto out;
b74a37a5a7 4581) goto out;
b8dac44d10 4721) todo_list_release(&new_todo);
009173ed7b 4726) todo_list_release(&new_todo);
009173ed7b 4727) return error_errno(_("could not write '%s'"), todo_file);
9787d17d40 4921) int rearrange_squash_in_todo_file(void)
9787d17d40 4923) const char *todo_file = rebase_path_todo();
9787d17d40 4924) struct todo_list todo_list = TODO_LIST_INIT;
9787d17d40 4925) int res = 0;
9787d17d40 4927) if (strbuf_read_file_or_whine(&todo_list.buf, 
todo_file) < 0)
9787d17d40 4928) return -1;
9787d17d40 4929) if (todo_list_parse_insn_buffer(todo_list.buf.buf, 
&todo_list) < 0) {
9787d17d40 4930) todo_list_release(&todo_list);
9787d17d40 4931) return -1;
9787d17d40 4934) res = todo_list_rearrange_squash(&todo_list);
9787d17d40 4935) if (!res)
9787d17d40 4936) res = rewrite_file(todo_file, todo_list.buf.buf, 
todo_list.buf.len);
9787d17d40 4938) todo_list_release(&todo_list);

setup.c
58b284a2e9  413) return config_error_nonbool(var);

sha1-array.c
7fdf90d541 91) oidcpy(&oids[dst], &oids[src]);

submodule-config.c
bcbc780d14 740) return CONFIG_INVALID_KEY;
45f5ef3d77 755) warning(_("Could not update .gitmodules entry %s"), key);

submodule.c
b303ef65e7  524) the_repository->submodule_prefix :
060675d4fc 1378) strbuf_release(&gitdir);
183be9660a 1501) struct get_next_submodule_task *task = task_cb;
183be9660a 1505) get_next_submodule_task_release(task);
183be9660a 1532) return 0;
183be9660a 1536) goto out;
183be9660a 1551) return 0;

tree.c
a5dda2204a 108) if (repo_parse_commit(the_repository, commit))

worktree.c
3a3b9d8cde 495) return -1;
3a3b9d8cde 508) return -1;
3a3b9d8cde 517) return -1;
ab3e1f78ae 537) break;

wrapper.c
5efde212fc  70) die("Out of memory, malloc failed (tried to allocate %" 
PRIuMAX " bytes)",
5efde212fc  73) error("Out of memory, malloc failed (tried to allocate 
%" PRIuMAX " bytes)",

Commits introducing uncovered code:
Alban Gruin      009173ed7: sequencer: change complete_action() to use 
the refactored functions
Alban Gruin      06d813612: sequencer: fix a call to error() in 
transform_todo_file()
Alban Gruin      6424061be: rebase-interactive: rewrite edit_todo_list() 
to handle the initial edit
Alban Gruin      7ccfac40b: rebase--interactive: move 
transform_todo_file() to rebase--interactive.c
Alban Gruin      9787d17d4: sequencer: refactor rearrange_squash() to 
work on a todo_list
Alban Gruin      b5d606240: sequencer: refactor 
sequencer_add_exec_commands() to work on a todo_list
Alban Gruin      b74a37a5a: sequencer: refactor check_todo_list() to 
work on a todo_list
Alban Gruin      b8dac44d1: sequencer: refactor skip_unnecessary_picks() 
to work on a todo_list
Antonio Ospite      45f5ef3d7: submodule: factor out a 
config_set_in_gitmodules_file_gently function
Antonio Ospite      bcbc780d1: submodule: add a 
print_config_from_gitmodules() helper
Antonio Ospite      c22b82014: submodule: support reading .gitmodules 
when it's not in the working tree
Derrick Stolee      1dcd9f204: midx: close multi-pack-index on repack
Derrick Stolee      dc7d66433: packfile: close multi-pack-index in 
close_all_packs
Elijah Newren      387361a6a: merge-recursive: improve 
rename/rename(1to2)/add[/add] handling
Elijah Newren      4cdc48e41: merge-recursive: new function for better 
colliding conflict resolutions
Elijah Newren      b58ae691c: merge-recursive: fix rename/add conflict 
handling
Junio C Hamano      a5dda2204: treewide: apply cocci patch
Liam Beguin      0cce4a275: rebase -i -x: add exec commands via the 
rebase--helper
Linus Torvalds      74e8221b5: Add 'human' date format
Martin Koegler      5efde212f: zlib.c: use size_t for size
Nguyễn Thái Ngọc Duy      3a3b9d8cd: refs: new ref types to make 
per-worktree refs visible to all worktrees
Nguyễn Thái Ngọc Duy      58b284a2e: worktree: add per-worktree config files
Nguyễn Thái Ngọc Duy      ab3e1f78a: revision.c: better error reporting 
on ref from different worktrees
Nguyễn Thái Ngọc Duy      b29759d89: fsck: check HEAD and reflog from 
other worktrees
Nguyễn Thái Ngọc Duy      c9ef0d95e: reflog expire: cover reflog from 
all worktrees
Stefan Beller      060675d4f: submodule: migrate get_next_submodule to 
use repository structs
Stefan Beller      183be9660: fetch: try fetching submodules if needed 
objects were not fetched
Stefan Beller      7fdf90d54: sha1-array: provide oid_array_filter
Stefan Beller      b303ef65e: submodule: use submodule repos for object 
lookup


Uncovered in jch not in next
----------------------------

builtin/branch.c
0ecb1fc726 builtin/branch.c 452) die(_("could not resolve HEAD"));
0ecb1fc726 builtin/branch.c 458) die(_("HEAD (%s) points outside of 
refs/heads/"), refname);

builtin/fetch.c
c806111692 builtin/fetch.c  373) continue; /* can this happen??? */

builtin/stash.c
3d5ec65ce8 builtin/stash--helper.c  126) error(_("'%s' is not a 
stash-like commit"), revision);
3d5ec65ce8 builtin/stash--helper.c  127) free_stash_info(info);
3d5ec65ce8 builtin/stash--helper.c  128) exit(128);
3d5ec65ce8 builtin/stash--helper.c  161) free_stash_info(info);
3d5ec65ce8 builtin/stash--helper.c  162) fprintf_ln(stderr, _("No stash 
entries found."));
3d5ec65ce8 builtin/stash--helper.c  163) return -1;
3d5ec65ce8 builtin/stash--helper.c  198) free_stash_info(info);
7005771171 builtin/stash--helper.c  225) return error(_("git stash clear 
with parameters is "
3d5ec65ce8 builtin/stash--helper.c  241) return -1;
3d5ec65ce8 builtin/stash--helper.c  249) return -1;
3d5ec65ce8 builtin/stash--helper.c  262) return -1;
3d5ec65ce8 builtin/stash--helper.c  265) return error(_("unable to write 
new index file"));
3d5ec65ce8 builtin/stash--helper.c  377) remove_path(stash_index_path.buf);
3d5ec65ce8 builtin/stash--helper.c  378) return -1;
3d5ec65ce8 builtin/stash--helper.c  405) return -1;
3d5ec65ce8 builtin/stash--helper.c  408) return error(_("cannot apply a 
stash in the middle of a merge"));
3d5ec65ce8 builtin/stash--helper.c  418) strbuf_release(&out);
3d5ec65ce8 builtin/stash--helper.c  419) return error(_("Could not 
generate diff %s^!."),
3d5ec65ce8 builtin/stash--helper.c  426) return error(_("Conflicts in 
index."
3d5ec65ce8 builtin/stash--helper.c  432) return error(_("Could not save 
index tree"));
3d5ec65ce8 builtin/stash--helper.c  439) return error(_("could not 
restore untracked files from stash"));
3d5ec65ce8 builtin/stash--helper.c  470) return -1;
3d5ec65ce8 builtin/stash--helper.c  475) strbuf_release(&out);
3d5ec65ce8 builtin/stash--helper.c  480) strbuf_release(&out);
3d5ec65ce8 builtin/stash--helper.c  481) return -1;
7005771171 builtin/stash--helper.c  557) return error(_("%s: Could not 
drop stash entry"),
5bf62a19c0 builtin/stash--helper.c  632) printf_ln(_("The stash entry is 
kept in case "
104eb50d14 builtin/stash--helper.c  766) free_stash_info(&info);
193c3e3516 builtin/stash.c          767) 
usage_with_options(git_stash_show_usage, options);
813904a0ce builtin/stash--helper.c  783) stash_msg = "Created via \"git 
stash store\".";
813904a0ce builtin/stash--helper.c  789) if (!quiet) {
813904a0ce builtin/stash--helper.c  790) fprintf_ln(stderr, _("Cannot 
update %s with %s"),
813904a0ce builtin/stash--helper.c  793) return -1;
813904a0ce builtin/stash--helper.c  817) if (!quiet)
813904a0ce builtin/stash--helper.c  818) fprintf_ln(stderr, _("\"git 
stash store\" requires one "
813904a0ce builtin/stash--helper.c  820) return -1;
9f630e7480 builtin/stash--helper.c  902) return -1;
9f630e7480 builtin/stash--helper.c  962) ret = -1;
9f630e7480 builtin/stash--helper.c  963) goto done;
9f630e7480 builtin/stash--helper.c  968) ret = -1;
9f630e7480 builtin/stash--helper.c  969) goto done;
9f630e7480 builtin/stash--helper.c  974) ret = -1;
9f630e7480 builtin/stash--helper.c  975) goto done;
9f630e7480 builtin/stash--helper.c 1001) ret = -1;
9f630e7480 builtin/stash--helper.c 1002) goto done;
9f630e7480 builtin/stash--helper.c 1013) ret = -1;
9f630e7480 builtin/stash--helper.c 1014) goto done;
9f630e7480 builtin/stash--helper.c 1020) ret = -1;
9f630e7480 builtin/stash--helper.c 1021) goto done;
9f630e7480 builtin/stash--helper.c 1028) ret = -1;
9f630e7480 builtin/stash--helper.c 1029) goto done;
9f630e7480 builtin/stash--helper.c 1054) ret = -1;
9f630e7480 builtin/stash--helper.c 1055) goto done;
9f630e7480 builtin/stash--helper.c 1067) ret = -1;
9f630e7480 builtin/stash--helper.c 1068) goto done;
9f630e7480 builtin/stash--helper.c 1074) ret = -1;
9f630e7480 builtin/stash--helper.c 1075) goto done;
9f630e7480 builtin/stash--helper.c 1086) ret = -1;
9f630e7480 builtin/stash--helper.c 1087) goto done;
9f630e7480 builtin/stash--helper.c 1092) ret = -1;
9f630e7480 builtin/stash--helper.c 1093) goto done;
c2cc69f192 builtin/stash--helper.c 1128) fprintf_ln(stderr, _("You do 
not have "
9f630e7480 builtin/stash--helper.c 1137) ret = 1;
9f630e7480 builtin/stash--helper.c 1138) goto done;
c2cc69f192 builtin/stash--helper.c 1154) if (!quiet)
c2cc69f192 builtin/stash--helper.c 1155) fprintf_ln(stderr, _("Cannot 
save the current "
9f630e7480 builtin/stash--helper.c 1157) ret = -1;
9f630e7480 builtin/stash--helper.c 1158) goto done;
c2cc69f192 builtin/stash--helper.c 1163) if (!quiet)
c2cc69f192 builtin/stash--helper.c 1164) fprintf_ln(stderr, _("Cannot save "
9f630e7480 builtin/stash--helper.c 1166) ret = -1;
9f630e7480 builtin/stash--helper.c 1167) goto done;
c2cc69f192 builtin/stash--helper.c 1174) if (!quiet)
c2cc69f192 builtin/stash--helper.c 1175) fprintf_ln(stderr, _("Cannot 
save the current "
9f630e7480 builtin/stash--helper.c 1177) goto done;
c2cc69f192 builtin/stash--helper.c 1183) if (!quiet)
c2cc69f192 builtin/stash--helper.c 1184) fprintf_ln(stderr, _("Cannot 
save the current "
9f630e7480 builtin/stash--helper.c 1186) ret = -1;
9f630e7480 builtin/stash--helper.c 1187) goto done;
c2cc69f192 builtin/stash--helper.c 1213) if (!quiet)
c2cc69f192 builtin/stash--helper.c 1214) fprintf_ln(stderr, _("Cannot 
record "
9f630e7480 builtin/stash--helper.c 1216) ret = -1;
9f630e7480 builtin/stash--helper.c 1217) goto done;
1a0f0409a7 builtin/stash--helper.c 1289) ret = -1;
1a0f0409a7 builtin/stash--helper.c 1290) goto done;
1a0f0409a7 builtin/stash--helper.c 1300) ret = -1;
c2cc69f192 builtin/stash--helper.c 1301) if (!quiet)
c2cc69f192 builtin/stash--helper.c 1302) fprintf_ln(stderr, _("Cannot 
initialize stash"));
1a0f0409a7 builtin/stash--helper.c 1303) goto done;
1a0f0409a7 builtin/stash--helper.c 1313) ret = -1;
c2cc69f192 builtin/stash--helper.c 1314) if (!quiet)
c2cc69f192 builtin/stash--helper.c 1315) fprintf_ln(stderr, _("Cannot 
save the current status"));
1a0f0409a7 builtin/stash--helper.c 1316) goto done;
1a0f0409a7 builtin/stash--helper.c 1333) ret = -1;
1a0f0409a7 builtin/stash--helper.c 1352) ret = -1;
1a0f0409a7 builtin/stash--helper.c 1353) goto done;
1a0f0409a7 builtin/stash--helper.c 1362) ret = -1;
1a0f0409a7 builtin/stash--helper.c 1363) goto done;
1a0f0409a7 builtin/stash--helper.c 1371) ret = -1;
1a0f0409a7 builtin/stash--helper.c 1380) ret = -1;
1a0f0409a7 builtin/stash--helper.c 1391) ret = -1;
1a0f0409a7 builtin/stash--helper.c 1392) goto done;
1a0f0409a7 builtin/stash--helper.c 1401) ret = -1;
1a0f0409a7 builtin/stash--helper.c 1402) goto done;
1a0f0409a7 builtin/stash--helper.c 1410) ret = -1;
1a0f0409a7 builtin/stash--helper.c 1436) ret = -1;
193c3e3516 builtin/stash.c         1568) 
usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
193c3e3516 builtin/stash.c         1596) continue;

builtin/submodule--helper.c
e0a862fdaf 1648) url = sub->url;

hex.c
b3a41547ce  93) char *sha1_to_hex_r(char *buffer, const unsigned char *sha1)
b3a41547ce  95) return hash_to_hex_algop_r(buffer, sha1, 
&hash_algos[GIT_HASH_SHA1]);
b3a41547ce 116) char *hash_to_hex(const unsigned char *hash)
b3a41547ce 118) return hash_to_hex_algop(hash, the_hash_algo);

revision.c
a63d88e595 2932) return;
a63d88e595 2935) return;
a63d88e595 2941) c->object.flags |= UNINTERESTING;
a63d88e595 2944) return;
a63d88e595 2947) mark_parents_uninteresting(c);
a63d88e595 2970) return;
a63d88e595 2973) return;
a63d88e595 2978) return;
a63d88e595 3042) continue;
f33f8de6af 3090) if (!revs->ignore_missing_links)
f33f8de6af 3091) die("Failed to traverse parents of commit %s",
a63d88e595 3092) oid_to_hex(&commit->object.oid));
a63d88e595 3100) continue;

sequencer.c
08b6ba5cc0  683) np = strchrnul(buf, '\n');
08b6ba5cc0  684) return error(_("unable to parse '%.*s'"),
08b6ba5cc0  695) return error(_("unable to dequote value of '%s'"),
08b6ba5cc0  737) goto finish;
08b6ba5cc0  742) name_i = error(_("'GIT_AUTHOR_NAME' already given"));
08b6ba5cc0  747) email_i = error(_("'GIT_AUTHOR_EMAIL' already given"));
08b6ba5cc0  752) date_i = error(_("'GIT_AUTHOR_DATE' already given"));
08b6ba5cc0  756) err = error(_("unknown variable '%s'"),
08b6ba5cc0  761) error(_("missing 'GIT_AUTHOR_NAME'"));
08b6ba5cc0  763) error(_("missing 'GIT_AUTHOR_EMAIL'"));
08b6ba5cc0  765) error(_("missing 'GIT_AUTHOR_DATE'"));

sha1-file.c
2f90b9d9b4 sha1-file.c  172) int hash_algo_by_name(const char *name)
2f90b9d9b4 sha1-file.c  175) if (!name)
2f90b9d9b4 sha1-file.c  176) return GIT_HASH_UNKNOWN;
2f90b9d9b4 sha1-file.c  177) for (i = 1; i < GIT_HASH_NALGOS; i++)
2f90b9d9b4 sha1-file.c  178) if (!strcmp(name, hash_algos[i].name))
2f90b9d9b4 sha1-file.c  179) return i;
2f90b9d9b4 sha1-file.c  180) return GIT_HASH_UNKNOWN;
2f90b9d9b4 sha1-file.c  183) int hash_algo_by_id(uint32_t format_id)
2f90b9d9b4 sha1-file.c  186) for (i = 1; i < GIT_HASH_NALGOS; i++)
2f90b9d9b4 sha1-file.c  187) if (format_id == hash_algos[i].format_id)
2f90b9d9b4 sha1-file.c  188) return i;
2f90b9d9b4 sha1-file.c  189) return GIT_HASH_UNKNOWN;

upload-pack.c
1d1243fe63 1403) deepen(INFINITE_DEPTH, data->deepen_relative, 
&data->shallows,

Commits introducing uncovered code:
brian m. carlson      2f90b9d9b: sha1-file: provide functions to look up 
hash algorithms
brian m. carlson      b3a41547c: hex: introduce functions to print 
arbitrary hashes
Daniels Umanovskis      0ecb1fc72: branch: introduce --show-current 
display option
Derrick Stolee      a63d88e59: revision.c: generation-based topo-order 
algorithm
Derrick Stolee      f33f8de6a: revision.c: begin refactoring 
--topo-order logic
Joel Teichroeb      3d5ec65ce: stash: convert apply to builtin
Joel Teichroeb      5bf62a19c: stash: convert pop to builtin
Joel Teichroeb      700577117: stash: convert drop and clear to builtin
Jonathan Tan      1d1243fe6: upload-pack: make want_obj not global
Junio C Hamano      c80611169: fetch: replace string-list used as a 
look-up table with a hashmap
Paul-Sebastian Ungureanu      104eb50d1: stash: convert show to builtin
Paul-Sebastian Ungureanu      193c3e351: stash: convert 
`stash--helper.c` into `stash.c`
Paul-Sebastian Ungureanu      1a0f0409a: stash: convert push to builtin
Paul-Sebastian Ungureanu      813904a0c: stash: convert store to builtin
Paul-Sebastian Ungureanu      9f630e748: stash: convert create to builtin
Paul-Sebastian Ungureanu      c2cc69f19: stash: make push -q quiet
Phillip Wood      08b6ba5cc: add read_author_script() to libgit
Stefan Beller      e0a862fda: submodule helper: convert relative URL to 
absolute URL if needed


Uncovered in next not in master
-------------------------------

apply.c
eccb5a5f3d 4071) return get_oid_hex(p->old_oid_prefix, oid);

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
ac7f467fef  507) struct strbuf dir = STRBUF_INIT;
6defce2b02  509) apply_autostash(opts);
ac7f467fef  510) strbuf_addstr(&dir, opts->state_dir);
ac7f467fef  511) remove_dir_recursively(&dir, 0);
ac7f467fef  512) strbuf_release(&dir);
ac7f467fef  513) die("Nothing to do");
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
cda614e489 1164) strbuf_addstr(&options.git_format_patch_opt, " 
--progress");
ac7f467fef 1173) options.state_dir = apply_dir();
ac7f467fef 1174) break;
ac7f467fef 1251) die(_("invalid upstream '%s'"), options.upstream_name);
9dba809a69 1257) die(_("Could not create new root commit"));
e65123a71d 1307) die(_("fatal: no such branch/commit '%s'"),
ac7f467fef 1315) die(_("No such ref: %s"), "HEAD");
ac7f467fef 1327) die(_("Could not resolve HEAD to a revision"));
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

builtin/repack.c
2f0c9e9a9b 239) die("repack: Expecting full hex object ID lines only 
from pack-objects.");
2f0c9e9a9b 411) die("repack: Expecting full hex object ID lines only 
from pack-objects.");

builtin/rev-list.c
7c0fe330d5 builtin/rev-list.c 227) die("unexpected missing %s object '%s'",
7c0fe330d5 builtin/rev-list.c 228)     type_name(obj->type), 
oid_to_hex(&obj->oid));

builtin/upload-archive.c
e001fd3a50 builtin/upload-archive.c 113) if (version == protocol_v0 || 
version == protocol_v1)
e001fd3a50 builtin/upload-archive.c 114) packet_write_fmt(1, "NACK 
unable to spawn subprocess\n");
e001fd3a50 builtin/upload-archive.c 115) else if (version == protocol_v2)
e001fd3a50 builtin/upload-archive.c 116) error_clnt("unable to spawn 
subprocess\n");

gpg-interface.c
4de9394dcb 155) break;

http-backend.c
fb19d32f05 646) argv[1] = ".";
fb19d32f05 647) argv[2] = NULL;

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

list-objects-filter-options.c
bc5975d24f  55) if (errbuf) {
bc5975d24f  56) strbuf_addstr(
bc5975d24f  60) return 1;
cc0b05a4cc  86) if (errbuf)

list-objects-filter.c
list-objects.c
f447a499db 200) ctx->show_object(obj, base->buf, ctx->show_data);

pretty.c
4de9394dcb 1264) if (c->signature_check.primary_key_fingerprint)
4de9394dcb 1265) strbuf_addstr(sb, 
c->signature_check.primary_key_fingerprint);
4de9394dcb 1266) break;

rebase-interactive.c
64a43cbd5d 62) return error_errno(_("could not read '%s'."), todo_file);
64a43cbd5d 66) strbuf_release(&buf);
64a43cbd5d 67) return -1;
a9f5476fbc 75) return error_errno(_("could not read '%s'."), todo_file);
a9f5476fbc 79) strbuf_release(&buf);
a9f5476fbc 80) return -1;
64a43cbd5d 86) return -1;

ref-filter.c
f0062d3b74 1035) v->s = xstrdup("");
f0062d3b74 1298) free((char *)to_free);
f0062d3b74 1299) return xstrdup("");
f0062d3b74 1336) free((char *)to_free);
f0062d3b74 1337) return xstrdup("");
f0062d3b74 1387) *s = xstrdup("=");
f0062d3b74 1389) *s = xstrdup("<");
f0062d3b74 1514) ref->symref = xstrdup("");
f0062d3b74 1583) v->s = xstrdup("");

sequencer.c
65850686cf 2278) return;
65850686cf 2375) write_file(rebase_path_quiet(), "%s\n", quiet);
2c58483a59 3373) return error(_("could not checkout %s"), commit);
4df66c40b0 3387) return error(_("%s: not a valid OID"), orig_head);
71f82465b1 3407) fprintf(stderr, _("Stopped at HEAD\n"));
b97e187364 4771) return -1;
b97e187364 4774) return -1;
b97e187364 4780) return error_errno(_("could not read '%s'."), todo_file);
b97e187364 4783) todo_list_release(&todo_list);
b97e187364 4784) return error(_("unusable todo list: '%s'"), todo_file);
b97e187364 4803) todo_list_release(&todo_list);
b97e187364 4804) return -1;
b97e187364 4808) return error(_("could not copy '%s' to '%s'."), todo_file,
b97e187364 4812) return error(_("could not transform the todo list"));
b97e187364 4841) return error(_("could not transform the todo list"));
b97e187364 4844) return error(_("could not skip unnecessary pick 
commands"));
b97e187364 4850) return -1;

strbuf.c
f95736288a  127) --sb->len;

transport-helper.c
fb19d32f05  643) if (!data->connect && !data->stateless_connect)

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
Brendan Forster      93aef7c79: http: add support for disabling SSL 
revocation checks in cURL
brian m. carlson      2f0c9e9a9: builtin/repack: replace hard-coded 
constants
brian m. carlson      eccb5a5f3: apply: rename new_sha1_prefix and 
old_sha1_prefix
Johannes Schindelin      21084e84a: http: add support for selecting SSL 
backends at runtime
Johannes Schindelin      71f82465b: rebase -i: introduce the 'break' command
Johannes Schindelin      b67d40adb: http: when using Secure Channel, 
ignore sslCAInfo by default
Johannes Schindelin      bc24382c2: builtin rebase: prepare for builtin 
rebase -i
Josh Steadmon      e001fd3a5: archive: implement protocol v2 archive command
Josh Steadmon      fb19d32f0: archive: allow archive over HTTP(S) with 
proto v2
Matthew DeVore      7c0fe330d: rev-list: handle missing tree objects 
properly
Matthew DeVore      bc5975d24: list-objects-filter: implement filter tree:0
Matthew DeVore      cc0b05a4c: list-objects-filter-options: do not 
over-strbuf_init
Matthew DeVore      f447a499d: list-objects: store common func args in 
struct
Michał Górny      4de9394dc: gpg-interface.c: obtain primary key 
fingerprint as well
Olga Telezhnaya      f0062d3b7: ref-filter: free item->value and 
item->value->s
Pratik Karki      002ee2fe6: builtin rebase: support `keep-empty` option
Pratik Karki      0eabf4b95: builtin rebase: stop if `git am` is in progress
Pratik Karki      12026a412: builtin rebase: support `--gpg-sign` option
Pratik Karki      122420c29: builtin rebase: support --skip
Pratik Karki      1ed9c14ff: builtin rebase: support --force-rebase
Pratik Karki      3c3588c7d: builtin rebase: support 
--rebase-merges[=[no-]rebase-cousins]
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
Pratik Karki      e0333e5c6: builtin rebase: require a clean worktree
Pratik Karki      e65123a71: builtin rebase: support `git rebase 
<upstream> <switch-to>`
Pratik Karki      ead98c111: builtin rebase: support --rerere-autoupdate
Pratik Karki      f28d40d3a: builtin rebase: support --onto
Pratik Karki      f95736288: builtin rebase: support --continue


Uncovered in mater not in master@{1}
------------------------------------

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

git.c
a9a60b94cc 322) fprintf_ln(stderr, _("'%s' is aliased to '%s'"),

ident.c
501afcb8b0 172) strbuf_addstr(&git_default_email, email);
501afcb8b0 173) free((char *)email);

packfile.c
1127a98cce  117) return error("index file %s is too small", path);
1127a98cce  119) return error("empty data");

split-index.c
e3d837989e 335) ce->ce_flags |= CE_UPDATE_IN_BASE;

Commits introducing uncovered code:
Johannes Schindelin      501afcb8b: mingw: use domain information for 
default email
Josh Steadmon      1127a98cc: fuzz: add fuzz testing for packfile indices.
Rasmus Villemoes      a9a60b94c: git.c: handle_alias: prepend alias info 
when first argument is -h
Rasmus Villemoes      e6e76baaf: help: redirect to aliased commands for 
"git cmd --help"
SZEDER Gábor      e3d837989: split-index: don't compare cached data of 
entries already marked for split index

