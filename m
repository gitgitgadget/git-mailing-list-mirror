Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8953D1F453
	for <e@80x24.org>; Thu,  1 Nov 2018 16:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbeKBBT1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 21:19:27 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]:37526 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728431AbeKBBT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 21:19:26 -0400
Received: by mail-qk1-f177.google.com with SMTP id 131so12603610qkd.4
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 09:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=oFwPrB/jUoF/RfwahUmrqpMvbw8cQpy7SN4sb1Sqpf8=;
        b=E3ZVN3hFwyeRAGDiuda/X1uXoU5MIzKh1Rg4FaErb4iWJmFK+jasOEAmrGxk+jsZBS
         cpX50sCljQknX9ioXnDQyLOot+1oAZRNl11jPzI69keNLMlm8c2eybDTaW4/sdwk1Plk
         tOCzMvHhzTb9Jx3zki12vvWeiCjQma0LsVXetOb3YOzRV/0fLRqh46xIkXsevbl95cOX
         V0/HsaGbNzuFLRxMHWoe5Ujg68OrLq8Obc4VSyUL7vlXTAd5R32ZQDQF4U4DH+rB9Jb3
         UQGdr7VmyF5wA+b7OcU+dQTTtluyy1022cQnkDDVIV2jmfluxdjTI7VYdZ9E6HNlcqYV
         kGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=oFwPrB/jUoF/RfwahUmrqpMvbw8cQpy7SN4sb1Sqpf8=;
        b=NWjBmRzL2KZxPi7UlnI3Jm9zPnb98VwN5i+uHh43Nk3LvjnREcRuRqLcXzR9lu4rQl
         kl2yt1Qnnpejzj6UzgjO3SzWwTOE6o1E1T5V67oHsjw3gEq6X32+hbJsDCk5TYH1TPdW
         3nDjHhfFCqgckDKusM9oaaKR+/SBz9HiIAi+8xsucDr83TAmVMTTmqwH4l/ZSBlrLWMf
         uEYiyDEWUF4P3zQ61RpswBkKS1+DbamrEb+xNdGmL7r9kn0ud6F1jvwQFQOm85DkJMP0
         OGG1YEY+CZytHWFwp40ZG2IO8yqewsG7f/ODiDK9Ma4ztQSZKpiV/dXnaFO2Ajk236DI
         vncQ==
X-Gm-Message-State: AGRZ1gJXI0rpy/0kkyzCyKnZDA4+CY+nw1h/7tviTS+82gEZvc9P4RVj
        fZNZb8nDhyJZE1brK1EHrAYJyzp9
X-Google-Smtp-Source: AJdET5eTnOT5EorBpaiV+OzhNQw9T/YvFMXN3oI9t4c/QS3v6IjSXiO/o0Q2mvjcOIg+5ZLBop+5/w==
X-Received: by 2002:a37:d6ce:: with SMTP id p75mr7049182qkl.270.1541088946391;
        Thu, 01 Nov 2018 09:15:46 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:eddc:3ff3:d342:de1b? ([2001:4898:8010:0:d712:3ff3:d342:de1b])
        by smtp.gmail.com with ESMTPSA id t128-v6sm19741225qkh.80.2018.11.01.09.15.45
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 09:15:45 -0700 (PDT)
To:     Git List <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (Thursday, Nov 1) Part A
Message-ID: <a29f3e8a-afd4-1f6d-f4ea-d69dc8746d79@gmail.com>
Date:   Thu, 1 Nov 2018 12:15:45 -0400
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

Today's test report doesn't contain any information for the 'master'
branch because the ref was not updated before this run (see 'master' and
'master@{1}' are the same below). If 'master' updates today, then I will
rerun the build and send the report for new lines in 'next' and 'master'.

Thanks,
-Stolee

[1] https://git.visualstudio.com/git/_build/results?buildId=237&view=logs

---

pu: f86906bb5aab712b2a63746c4a643efd6ce19d5b
jch: ce1cd767b7bb0e53083d26b4d60257e3ec0eaeb4
next: 0c4a18a71f0e8e4f10970951c5f8875f429eaef7
master: 4ede3d42dfb57f9a41ac96a1f216c62eb7566cc2
master@{1}: 4ede3d42dfb57f9a41ac96a1f216c62eb7566cc2

Uncovered code in 'pu' not in 'jch'
--------------------------------------

builtin/blame.c
f86906bb5a builtin/blame.c    200) 
repo_unuse_commit_buffer(the_repository, commit, message);
74e8221b52 builtin/blame.c    924) blame_date_width = sizeof("Thu Oct 19 
16:00");
74e8221b52 builtin/blame.c    925) break;

builtin/describe.c
f86906bb5a builtin/describe.c 257) repo_parse_commit(the_repository, p);

builtin/fsck.c
209830491c builtin/fsck.c 622) fprintf_ln(stderr, _("Checking %s link"), 
head_ref_name);
209830491c builtin/fsck.c 627) return error(_("invalid %s"), head_ref_name);

builtin/grep.c
76e9bdc437 builtin/grep.c  429) grep_read_unlock();

builtin/pack-objects.c
f86906bb5a builtin/pack-objects.c 2832) if 
(!repo_has_object_file(the_repository, &obj->oid) && 
is_promisor_object(&obj->oid))

builtin/reflog.c
c9ef0d95eb builtin/reflog.c 585) all_worktrees = 0;
c9ef0d95eb builtin/reflog.c 621) continue;

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
f86906bb5a  858) repo_unuse_commit_buffer(the_repository, commit, buffer);
f86906bb5a  878) repo_read_object_file(the_repository,
f86906bb5a  879)       &tag->object.oid, &type, &size);

http-push.c
f86906bb5a 1635) if (!repo_has_object_file(the_repository, &head_oid))
f86906bb5a 1642) if (!repo_has_object_file(the_repository, 
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

negotiator/default.c
f86906bb5a  71) if (repo_parse_commit(the_repository, commit))

refs.c
3a3b9d8cde  657) return 0;

refs/files-backend.c
remote.c
879b6a9e6f 1140) return error(_("dst ref %s receives from more than one 
src."),

revision.c
f86906bb5a  726) if (repo_parse_commit(the_repository, p) < 0)

sequencer.c
f86906bb5a 1624) repo_unuse_commit_buffer(the_repository, head_commit,
f86906bb5a 3868) repo_unuse_commit_buffer(the_repository,

sha1-array.c
bba406749a 91) oidcpy(&oids[dst], &oids[src]);

submodule-config.c
bcbc780d14 740) return CONFIG_INVALID_KEY;
45f5ef3d77 755) warning(_("Could not update .gitmodules entry %s"), key);

submodule.c
b303ef65e7  524) the_repository->submodule_prefix :
e2419f7e30 1378) strbuf_release(&gitdir);
7454fe5cb6 1501) struct get_next_submodule_task *task = task_cb;
7454fe5cb6 1505) get_next_submodule_task_release(task);
7454fe5cb6 1532) return 0;
7454fe5cb6 1536) goto out;
7454fe5cb6 1551) return 0;

tree.c
f86906bb5a 108) if (repo_parse_commit(the_repository, commit))

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
Ævar Arnfjörð Bjarmason      879b6a9e6: i18n: remote.c: mark error(...) 
messages for translation
Antonio Ospite      45f5ef3d7: submodule: factor out a 
config_set_in_gitmodules_file_gently function
Antonio Ospite      76e9bdc43: submodule: support reading .gitmodules 
when it's not in the working tree
Antonio Ospite      bcbc780d1: submodule: add a 
print_config_from_gitmodules() helper
Elijah Newren      387361a6a: merge-recursive: improve 
rename/rename(1to2)/add[/add] handling
Elijah Newren      4cdc48e41: merge-recursive: new function for better 
colliding conflict resolutions
Elijah Newren      b58ae691c: merge-recursive: fix rename/add conflict 
handling
Junio C Hamano      209830491: Merge branch 
'nd/per-worktree-ref-iteration' into pu
Junio C Hamano      f86906bb5: treewide: apply cocci patch
Linus Torvalds      74e8221b5: Add 'human' date format
Martin Koegler      5efde212f: zlib.c: use size_t for size
Nguyễn Thái Ngọc Duy      3a3b9d8cd: refs: new ref types to make 
per-worktree refs visible to all worktrees
Nguyễn Thái Ngọc Duy      ab3e1f78a: revision.c: better error reporting 
on ref from different worktrees
Nguyễn Thái Ngọc Duy      c9ef0d95e: reflog expire: cover reflog from 
all worktrees
Stefan Beller      7454fe5cb: fetch: try fetching submodules if needed 
objects were not fetched
Stefan Beller      b303ef65e: submodule: use submodule repos for object 
lookup
Stefan Beller      bba406749: sha1-array: provide oid_array_filter
Stefan Beller      e2419f7e3: submodule: migrate get_next_submodule to 
use repository structs



Uncovered code in 'jch' not in 'next'
----------------------------------------

archive.c
48a40549d5 399) die(_("'%s' is not a valid object name"), name);
48a40549d5 412) die(_("%s is not a tree object"), oid_to_hex(&oid));
48a40549d5 422) die(_("current working directory is untracked"));

attr.c
847aa0ff7a  369) fprintf(stderr, _("%s not allowed: %s:%d\n"),

builtin/branch.c
0ecb1fc726 builtin/branch.c 452) die(_("could not resolve HEAD"));
0ecb1fc726 builtin/branch.c 458) die(_("HEAD (%s) points outside of 
refs/heads/"), refname);

builtin/cat-file.c
98f425b453 builtin/cat-file.c  56) die("unable to stream %s to stdout", 
oid_to_hex(oid));

builtin/fetch.c
builtin/fsck.c
09120ea781 builtin/fsck.c 154) objerror(parent, _("wrong object type in 
link"));
09120ea781 builtin/fsck.c 265) printf_ln(_("unreachable %s %s"), 
printable_type(obj),
09120ea781 builtin/fsck.c 293) error(_("could not create lost-found"));
09120ea781 builtin/fsck.c 300) die_errno(_("could not write '%s'"), 
filename);
09120ea781 builtin/fsck.c 304) die_errno(_("could not finish '%s'"),
09120ea781 builtin/fsck.c 321) fprintf_ln(stderr, _("Checking %s"), 
describe_object(obj));
09120ea781 builtin/fsck.c 339) fprintf_ln(stderr, _("Checking 
connectivity (%d objects)"), max);
09120ea781 builtin/fsck.c 358) fprintf_ln(stderr, _("Checking %s %s"),
09120ea781 builtin/fsck.c 371) printf_ln(_("root %s"),
09120ea781 builtin/fsck.c 407) return error(_("%s: object corrupt or 
missing"),
09120ea781 builtin/fsck.c 446) fprintf_ln(stderr, _("Checking reflog 
%s->%s"),
09120ea781 builtin/fsck.c 545) error(_("%s: object could not be parsed: 
%s"),
09120ea781 builtin/fsck.c 580) fprintf_ln(stderr, _("Checking object 
directory"));
09120ea781 builtin/fsck.c 596) fprintf_ln(stderr, _("Checking HEAD link"));
09120ea781 builtin/fsck.c 601) return error(_("invalid HEAD"));
09120ea781 builtin/fsck.c 628) fprintf_ln(stderr, _("Checking cache tree"));
09120ea781 builtin/fsck.c 644) err |= objerror(obj, _("non-tree in 
cache-tree"));

builtin/grep.c
389f2f2d79 builtin/grep.c 1034) die(_("invalid number of threads 
specified (%d)"), num_threads);

builtin/merge.c
35408df41e builtin/merge.c  131) return error(_("option `%s' requires a 
value"), opt->long_name);

builtin/reflog.c
b9c4009cca builtin/reflog.c 563) usage(_(reflog_expire_usage));
b9c4009cca builtin/reflog.c 605) status |= error(_("%s points 
nowhere!"), argv[i]);
b9c4009cca builtin/reflog.c 651) usage(_(reflog_delete_usage));
b9c4009cca builtin/reflog.c 657) return error(_("nothing to delete?"));
b9c4009cca builtin/reflog.c 666) status |= error(_("not a reflog: %s"), 
argv[i]);
b9c4009cca builtin/reflog.c 671) status |= error(_("no reflog for 
'%s'"), argv[i]);
b9c4009cca builtin/reflog.c 706) usage(_(reflog_exists_usage));
b9c4009cca builtin/reflog.c 714) usage(_(reflog_exists_usage));
b9c4009cca builtin/reflog.c 717) die(_("invalid ref format: %s"), 
argv[start]);

builtin/repack.c
eb6c5a15dc 200) die(_("could not start pack-objects to repack promisor 
objects"));
479fbb285c 239) die(_("repack: Expecting full hex object ID lines only 
from pack-objects."));
eb6c5a15dc 250) die_errno(("unable to create '%s'"), promisor_name);
479fbb285c 411) die(_("repack: Expecting full hex object ID lines only 
from pack-objects."));

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

git.c
b63c352c11 341) die_errno(_("while expanding alias '%s': '%s'"),
b63c352c11 350) die(_("alias '%s' changes environment variables.\n"
b63c352c11 358) die(_("empty alias for %s"), alias_command);
b63c352c11 361) die(_("recursive alias: %s"), alias_command);
b63c352c11 436) die_errno(_("write failure on standard output"));
b63c352c11 438) die(_("unknown write failure on standard output"));
b63c352c11 440) die_errno(_("close failed on standard output"));
b63c352c11 770) die(_("cannot handle %s as a builtin"), cmd);

hex.c
b3a41547ce  93) char *sha1_to_hex_r(char *buffer, const unsigned char *sha1)
b3a41547ce  95) return hash_to_hex_algop_r(buffer, sha1, 
&hash_algos[GIT_HASH_SHA1]);
b3a41547ce 116) char *hash_to_hex(const unsigned char *hash)
b3a41547ce 118) return hash_to_hex_algop(hash, the_hash_algo);

midx.c
1dcd9f2043  184) return;

name-hash.c
31bfd155d8 532) die(_("unable to create lazy_dir thread: %s"), 
strerror(err));
31bfd155d8 554) die(_("unable to create lazy_name thread: %s"), 
strerror(err));
31bfd155d8 560) die(_("unable to join lazy_name thread: %s"), 
strerror(err));

parse-options-cb.c
35408df41e  21) return error(_("option `%s' expects a numerical value"),
35408df41e  58) return error(_("option `%s' expects \"always\", 
\"auto\", or \"never\""),

parse-options.c
35408df41e  88) return error(_("%s takes no value"), optname(opt, flags));
35408df41e  90) return error(_("%s isn't available"), optname(opt, flags));
35408df41e  92) return error(_("%s takes no value"), optname(opt, flags));
35408df41e 178) return error(_("%s expects a numerical value"),
35408df41e 194) return error(_("%s expects a non-negative integer value"
e0948db833 356) error(_("did you mean `--%s` (with two dashes ?)"), arg);
e0948db833 651) error(_("unknown non-ascii option in string: `%s'"),
35408df41e 785) strbuf_addf(&sb, "option `no-%s'", opt->long_name);

preload-index.c
31bfd155d8 137) die(_("unable to create threaded lstat: %s"), 
strerror(err));

read-cache.c
5257b0625a  675) die(_("will not add file alias '%s' ('%s' already 
exists in index)"),
5257b0625a  676)     ce->name, alias->name);
5257b0625a  691) die(_("cannot create an empty blob in the object 
database"));
5257b0625a  712) return error(_("%s: can only add regular files, 
symbolic links or git-directories"), path);
5257b0625a  786) return error(_("unable to add '%s' to index"), path);
5257b0625a  822) error(_("invalid path '%s'"), path);
5257b0625a  848) error(_("invalid path '%s'"), path);
5257b0625a 1686) return error(_("bad signature 0x%08x"), 
hdr->hdr_signature);
5257b0625a 1689) return error(_("bad index version %d"), hdr_version);
5257b0625a 1728) return error(_("index uses %.4s extension, which we do 
not understand"),
5257b0625a 1730) fprintf_ln(stderr, _("ignoring %.4s extension"), ext);
5257b0625a 1777) die(_("unknown index entry format 0x%08x"), 
extended_flags);
5257b0625a 1848) die(_("unordered stage entries in index"));
5257b0625a 1851) die(_("multiple stage entries for merged file '%s'"),
5257b0625a 1854) die(_("unordered stage entries for '%s'"),
5257b0625a 2148) die_errno(_("%s: index file open failed"), path);
5257b0625a 2152) die_errno(_("%s: cannot stat the open index"), path);
5257b0625a 2156) die(_("%s: index file smaller than expected"), path);
5257b0625a 2160) die_errno(_("%s: unable to map index file"), path);
5257b0625a 2252) warning(_("could not freshen shared index '%s'"), 
shared_index);
5257b0625a 2287) die(_("broken index, expect %s in %s, got %s"),
5257b0625a 3073) error(_("cannot fix permission bits on '%s'"), 
get_tempfile_path(*temp));
5257b0625a 3219) return error(_("%s: cannot drop to stage #0"),

ref-filter.c
35408df41e 2324) return error(_("option `%s' is incompatible with 
--no-merged"),

remote.c
a454d6a26b  362) warning(_("config remote shorthand cannot begin with 
'/': %s"),
a454d6a26b  417) error(_("more than one uploadpack given, using the 
first"));
a454d6a26b  683) die(_("key '%s' of pattern had no '*'"), key);
a454d6a26b  693) die(_("value '%s' of pattern has no '*'"), value);
a454d6a26b 1044) error(_("unable to delete '%s': remote ref does not 
exist"),
a454d6a26b 1066) return error(_("dst ref %s receives from more than one 
src"),
a454d6a26b 1753) die(_("couldn't find remote ref %s"), name);
a454d6a26b 1766) error(_("* Ignoring funny ref '%s' locally"),
a454d6a26b 1861) die(_("revision walk setup failed"));
a454d6a26b 2134) return error(_("cannot parse expected object name '%s'"),

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

run-command.c
31bfd155d8 1229) error(_("cannot create async thread: %s"), strerror(err));

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

Commits introducing uncovered code:
brian m. carlson      2f90b9d9b: sha1-file: provide functions to look up 
hash algorithms
brian m. carlson      b3a41547c: hex: introduce functions to print 
arbitrary hashes
Daniels Umanovskis      0ecb1fc72: branch: introduce --show-current 
display option
Derrick Stolee      1dcd9f204: midx: close multi-pack-index on repack
Derrick Stolee      a63d88e59: revision.c: generation-based topo-order 
algorithm
Derrick Stolee      f33f8de6a: revision.c: begin refactoring 
--topo-order logic
Jeff King      98f425b45: cat-file: handle streaming failures consistently
Joel Teichroeb      3d5ec65ce: stash: convert apply to builtin
Joel Teichroeb      5bf62a19c: stash: convert pop to builtin
Joel Teichroeb      700577117: stash: convert drop and clear to builtin
Junio C Hamano      479fbb285: Merge branch 'nd/i18n' into jch
Nguyễn Thái Ngọc Duy      09120ea78: fsck: mark strings for translation
Nguyễn Thái Ngọc Duy      31bfd155d: Clean up pthread_create() error 
handling
Nguyễn Thái Ngọc Duy      35408df41: parse-options: replace opterror() 
with optname()
Nguyễn Thái Ngọc Duy      389f2f2d7: grep: remove #ifdef NO_PTHREADS
Nguyễn Thái Ngọc Duy      48a40549d: archive.c: mark more strings for 
translation
Nguyễn Thái Ngọc Duy      5257b0625: read-cache.c: mark more strings for 
translation
Nguyễn Thái Ngọc Duy      847aa0ff7: attr.c: mark more string for 
translation
Nguyễn Thái Ngọc Duy      a454d6a26: remote.c: mark messages for translation
Nguyễn Thái Ngọc Duy      b63c352c1: git.c: mark more strings for 
translation
Nguyễn Thái Ngọc Duy      b9c4009cc: reflog: mark strings for translation
Nguyễn Thái Ngọc Duy      e0948db83: parse-options.c: mark more strings 
for translation
Nguyễn Thái Ngọc Duy      eb6c5a15d: repack: mark more strings for 
translation
Paul-Sebastian Ungureanu      104eb50d1: stash: convert show to builtin
Paul-Sebastian Ungureanu      193c3e351: stash: convert 
`stash--helper.c` into `stash.c`
Paul-Sebastian Ungureanu      1a0f0409a: stash: convert push to builtin
Paul-Sebastian Ungureanu      813904a0c: stash: convert store to builtin
Paul-Sebastian Ungureanu      9f630e748: stash: convert create to builtin
Paul-Sebastian Ungureanu      c2cc69f19: stash: make push -q quiet
Phillip Wood      bcd33ec25: add read_author_script() to libgit



Uncovered code in 'next' not in 'master'
--------------------------------------------

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
6defce2b02  273) res = error(_("Cannot store %s"), autostash.buf);
6defce2b02  277) return res;
bc24382c2b  375) argv_array_pushf(&child.args,
bc24382c2b  377) oid_to_hex(&opts->restrict_revision->object.oid));
ac7f467fef  509) struct strbuf dir = STRBUF_INIT;
6defce2b02  511) apply_autostash(opts);
ac7f467fef  512) strbuf_addstr(&dir, opts->state_dir);
ac7f467fef  513) remove_dir_recursively(&dir, 0);
ac7f467fef  514) strbuf_release(&dir);
ac7f467fef  515) die("Nothing to do");
ac7f467fef  545) return -1;
ac7f467fef  549) rollback_lock_file(&lock);
ac7f467fef  550) return error(_("could not determine HEAD revision"));
ac7f467fef  567) rollback_lock_file(&lock);
ac7f467fef  568) return error(_("could not read index"));
ac7f467fef  572) error(_("failed to find tree of %s"), oid_to_hex(oid));
ac7f467fef  573) rollback_lock_file(&lock);
ac7f467fef  574) free((void *)desc.buffer);
ac7f467fef  575) return -1;
ac7f467fef  588) ret = error(_("could not write index"));
ac7f467fef  592) return ret;
ac7f467fef  608) } else if (old_orig)
ac7f467fef  609) delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
bff014dac7  637) opts->flags &= !REBASE_DIFFSTAT;
9a48a615b4  671) return 1;
9a48a615b4  687) return 0;
55071ea248  895) const char *path = mkpath("%s/git-legacy-rebase",
55071ea248  898) if (sane_execvp(path, (char **)argv) < 0)
55071ea248  899) die_errno(_("could not exec %s"), path);
0eabf4b95c  917) die(_("It looks like 'git am' is in progress. Cannot 
rebase."));
f28d40d3a9  954) usage_with_options(builtin_rebase_usage,
f95736288a  974) die(_("Cannot read HEAD"));
f95736288a  978) die(_("could not read index"));
f95736288a  992) exit(1);
122420c295 1004) die(_("could not discard worktree changes"));
122420c295 1006) exit(1);
5e5d96197c 1017) exit(1);
5e5d96197c 1020) die(_("could not move back to %s"),
5a61494539 1030) die(_("could not remove '%s'"), options.state_dir);
c54dacb50e 1049) const char *last_slash = strrchr(options.state_dir, '/');
c54dacb50e 1050) const char *state_dir_base =
c54dacb50e 1051) last_slash ? last_slash + 1 : options.state_dir;
c54dacb50e 1052) const char *cmd_live_rebase =
c54dacb50e 1054) strbuf_reset(&buf);
c54dacb50e 1055) strbuf_addf(&buf, "rm -fr \"%s\"", options.state_dir);
c54dacb50e 1056) die(_("It seems that there is already a %s directory, 
and\n"
53f9e5be94 1080) strbuf_addstr(&options.git_am_opt, " --ignore-date");
53f9e5be94 1081) options.flags |= REBASE_FORCE;
7998dbe1ec 1093) strbuf_addf(&options.git_am_opt, " -C%d", opt_c);
3c3588c7d3 1125) else if (strcmp("no-rebase-cousins", rebase_merges))
3c3588c7d3 1126) die(_("Unknown mode: %s"), rebase_merges);
ba1905a5fe 1148) die(_("--strategy requires --merge or --interactive"));
cda614e489 1166) strbuf_addstr(&options.git_format_patch_opt, " 
--progress");
ac7f467fef 1175) options.state_dir = apply_dir();
ac7f467fef 1176) break;
ac7f467fef 1253) die(_("invalid upstream '%s'"), options.upstream_name);
9dba809a69 1259) die(_("Could not create new root commit"));
e65123a71d 1309) die(_("fatal: no such branch/commit '%s'"),
ac7f467fef 1317) die(_("No such ref: %s"), "HEAD");
ac7f467fef 1329) die(_("Could not resolve HEAD to a revision"));
e0333e5c63 1342) die(_("could not read index"));
6defce2b02 1369) die(_("Cannot autostash"));
6defce2b02 1372) die(_("Unexpected stash response: '%s'"),
6defce2b02 1378) die(_("Could not create directory for '%s'"),
6defce2b02 1384) die(_("could not reset --hard"));
e65123a71d 1428) ret = !!error(_("could not parse '%s'"),
e65123a71d 1430) goto cleanup;
e65123a71d 1439) ret = !!error(_("could not switch to "
1ed9c14ff2 1449)  resolve_ref_unsafe("HEAD", 0, NULL, &flag))
1ed9c14ff2 1450) puts(_("HEAD is up to date."));
9a48a615b4 1459)  resolve_ref_unsafe("HEAD", 0, NULL, &flag))
9a48a615b4 1460) puts(_("HEAD is up to date, rebase forced."));

builtin/submodule--helper.c
e0a862fdaf 1648) url = sub->url;

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

sequencer.c
65850686cf 2279) return;
65850686cf 2376) write_file(rebase_path_quiet(), "%s\n", quiet);
2c58483a59 3374) return error(_("could not checkout %s"), commit);
4df66c40b0 3388) return error(_("%s: not a valid OID"), orig_head);
71f82465b1 3408) fprintf(stderr, _("Stopped at HEAD\n"));
b97e187364 4772) return -1;
b97e187364 4775) return -1;
b97e187364 4781) return error_errno(_("could not read '%s'."), todo_file);
b97e187364 4784) todo_list_release(&todo_list);
b97e187364 4785) return error(_("unusable todo list: '%s'"), todo_file);
b97e187364 4804) todo_list_release(&todo_list);
b97e187364 4805) return -1;
b97e187364 4809) return error(_("could not copy '%s' to '%s'."), todo_file,
b97e187364 4813) return error(_("could not transform the todo list"));
b97e187364 4842) return error(_("could not transform the todo list"));
b97e187364 4845) return error(_("could not skip unnecessary pick 
commands"));
b97e187364 4851) return -1;

setup.c
58b284a2e9  413) return config_error_nonbool(var);

strbuf.c
f95736288a  127) --sb->len;

transport-helper.c
fb19d32f05  643) if (!data->connect && !data->stateless_connect)

upload-pack.c
1d1243fe63 1403) deepen(INFINITE_DEPTH, data->deepen_relative, 
&data->shallows,

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
Johannes Schindelin      21084e84a: http: add support for selecting SSL 
backends at runtime
Johannes Schindelin      71f82465b: rebase -i: introduce the 'break' command
Johannes Schindelin      b67d40adb: http: when using Secure Channel, 
ignore sslCAInfo by default
Johannes Schindelin      bc24382c2: builtin rebase: prepare for builtin 
rebase -i
Jonathan Tan      1d1243fe6: upload-pack: make want_obj not global
Josh Steadmon      e001fd3a5: archive: implement protocol v2 archive command
Josh Steadmon      fb19d32f0: archive: allow archive over HTTP(S) with 
proto v2
Michał Górny      4de9394dc: gpg-interface.c: obtain primary key 
fingerprint as well
Nguyễn Thái Ngọc Duy      58b284a2e: worktree: add per-worktree config files
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
Stefan Beller      e0a862fda: submodule helper: convert relative URL to 
absolute URL if needed

