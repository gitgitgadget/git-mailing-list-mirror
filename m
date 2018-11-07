Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 068CD1F453
	for <e@80x24.org>; Wed,  7 Nov 2018 14:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeKHAIW (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 19:08:22 -0500
Received: from mail-qk1-f179.google.com ([209.85.222.179]:32824 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbeKHAIV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 19:08:21 -0500
Received: by mail-qk1-f179.google.com with SMTP id o89so21180451qko.0
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 06:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=9GDyuMpHuooo4n+30iTRBSKhpU8jVyjBfMgPoYTp0Ms=;
        b=HFKvZe6uaFuHLRHrCdspgwV8+gIu/O8PkT/BQ1ua011/iVXoiaZnjRrkDqQrMXOsoI
         cehMQIDoy1cN3dGSVXMWS1OjRmKqE7bJCncUblqSEVThfoh0Sw2y3qh49JoQBldnVxPz
         zkyNpG5xOeLAiwD7MM2ufSzJPoBwj2aXGDpkG04ZsPgUSHX3X3s0oDBvO3ypGDqrDDYB
         E27XicvoAnT/MIgg8jlQ1bvCxFt0zIi8ZwPUCYtMzjPyBqybtfONBirbmBYAVLcGnbZ5
         B7OKhdyQkmcV6QSTVGQijUpLibYWfCN2Zebz1yKoS5wcDToNUBa2nAN+YQIuP7kCKPOB
         e3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=9GDyuMpHuooo4n+30iTRBSKhpU8jVyjBfMgPoYTp0Ms=;
        b=oCb4PDwZM1mId+COWyCkmXyEfF2Y5kyFiaQBRq7kC6d6DlGhYG4efDvxRKMriRLLuD
         u6qlBKwz784bToUK4nbCO466kEGO9xqav6MH7gxwFapE7B7JBJLLMcJ+XAZBvgTHZukL
         iCoTYWiQvAT2vC7oR7XRv3W9MERPhgkVjSNZhBcW3QufgQtZ/YkHqI3kowvJIByP3USs
         ARwwrfbaL8QXZh37IH2COEUwkpCNLjoa265KolG8yXU0DhdQ3yKTRfQO6Vce+9VLCoRC
         7cFvprIWT8mL2EWZPRyETg2Pf4W3/LpxJwNKik75z3WHvkYjQk3Z3ck/ZsNcQa0lSO+1
         a7ww==
X-Gm-Message-State: AGRZ1gLmFXFMoJCwTRBGyYXNGytq8UzcpLCyXALNGqwlZXDRMxANlInZ
        8wZRFvbs/9ms7+iz5oDBkFfkUyt/
X-Google-Smtp-Source: AJdET5eR9Y1+2PHLzVA7gFsUm45a4luu9/EVd0W8IBQMv82DnWdvQGeB9HJf5iLeW/Tg3Xkto9R9Iw==
X-Received: by 2002:ac8:1909:: with SMTP id t9mr421951qtj.327.1541601461567;
        Wed, 07 Nov 2018 06:37:41 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c400:6517:325:d866? ([2001:4898:8010:0:ad36:6517:325:d866])
        by smtp.gmail.com with ESMTPSA id f11-v6sm388422qth.28.2018.11.07.06.37.40
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 06:37:40 -0800 (PST)
To:     Git List <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (Wednesday, Nov 7)
Message-ID: <37a9e335-32ee-4828-af29-45f63b05af1f@gmail.com>
Date:   Wed, 7 Nov 2018 09:37:40 -0500
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

Here is the coverage report for today.

Thanks,

-Stolee

[1] https://dev.azure.com/git/git/_build/results?buildId=251&view=logs

---

pu: 381b31f0006e46fe041e7fc6e5f7b19da5ccd889
jch: ab76604d6537afa18c9d8588c08f699c1f539659
next: 8438c0b2453a7207c9c45756f5e37dfe283db602
master: 8858448bb49332d353febc078ce4a3abcc962efe
master@{1}: d582ea202b626dcc6c3b01e1e11a296d9badd730

Uncovered code in 'pu' not in 'jch'
--------------------------------------

builtin/blame.c
381b31f000 builtin/blame.c    200) 
repo_unuse_commit_buffer(the_repository, commit, message);
74e8221b52 builtin/blame.c    928) blame_date_width = sizeof("Thu Oct 19 
16:00");
74e8221b52 builtin/blame.c    929) break;

builtin/describe.c
381b31f000 builtin/describe.c 257) repo_parse_commit(the_repository, p);

builtin/pack-objects.c
381b31f000 builtin/pack-objects.c 2832) if 
(!repo_has_object_file(the_repository, &obj->oid) && 
is_promisor_object(&obj->oid))

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

diff.c
b613de67c4  316) ret |= COLOR_MOVED_WS_ERROR;
b613de67c4  348) unsigned cm = parse_color_moved_ws(value);
b613de67c4  349) if (cm & COLOR_MOVED_WS_ERROR)

fast-import.c
381b31f000 2935) buf = repo_read_object_file(the_repository, oid, &type, 
&size);
381b31f000 3041) buf = repo_read_object_file(the_repository, oid, &unused,

fsck.c
381b31f000  858) repo_unuse_commit_buffer(the_repository, commit, buffer);
381b31f000  878) repo_read_object_file(the_repository,
381b31f000  879)       &tag->object.oid, &type, &size);

http-push.c
381b31f000 1635) if (!repo_has_object_file(the_repository, &head_oid))
381b31f000 1642) if (!repo_has_object_file(the_repository, 
&remote_ref->old_oid))

negotiator/default.c
381b31f000  71) if (repo_parse_commit(the_repository, commit))

remote.c
879b6a9e6f 1140) return error(_("dst ref %s receives from more than one 
src."),

revision.c
381b31f000  726) if (repo_parse_commit(the_repository, p) < 0)

sequencer.c
381b31f000 1624) repo_unuse_commit_buffer(the_repository, head_commit,
381b31f000 3868) repo_unuse_commit_buffer(the_repository,

sha1-array.c
bba406749a 91) oidcpy(&oids[dst], &oids[src]);

submodule.c
b303ef65e7  524) the_repository->submodule_prefix :
e2419f7e30 1378) strbuf_release(&gitdir);
7454fe5cb6 1501) struct get_next_submodule_task *task = task_cb;
7454fe5cb6 1505) get_next_submodule_task_release(task);
7454fe5cb6 1532) return 0;
7454fe5cb6 1536) goto out;
7454fe5cb6 1551) return 0;

tree.c
381b31f000 108) if (repo_parse_commit(the_repository, commit))

wrapper.c
5efde212fc  70) die("Out of memory, malloc failed (tried to allocate %" 
PRIuMAX " bytes)",
5efde212fc  73) error("Out of memory, malloc failed (tried to allocate 
%" PRIuMAX " bytes)",

Commits introducing uncovered code:
Ævar Arnfjörð Bjarmason      879b6a9e6: i18n: remote.c: mark error(...) 
messages for translation
Junio C Hamano      381b31f00: treewide: apply cocci patch
Linus Torvalds      74e8221b5: Add 'human' date format
Martin Koegler      5efde212f: zlib.c: use size_t for size
Stefan Beller      7454fe5cb: fetch: try fetching submodules if needed 
objects were not fetched
Stefan Beller      b303ef65e: submodule: use submodule repos for object 
lookup
Stefan Beller      b613de67c: diff: differentiate error handling in 
parse_color_moved_ws
Stefan Beller      bba406749: sha1-array: provide oid_array_filter
Stefan Beller      e2419f7e3: submodule: migrate get_next_submodule to 
use repository structs



Uncovered code in 'jch' not in 'next'
----------------------------------------

apply.c
517fe807d6 4776) BUG_ON_OPT_NEG(unset);
735ca208c5 4830) return -1;

archive.c
8a705c4638 399) die(_("not a valid object name: %s"), name);
8a705c4638 412) die(_("not a tree object: %s"), oid_to_hex(&oid));
8a705c4638 422) die(_("current working directory is untracked"));

attr.c
aa4fa3fa79  369) fprintf_ln(stderr, _("%s not allowed: %s:%d"),

builtin/am.c
fce5664805 2117) *opt_value = PATCH_FORMAT_UNKNOWN;

builtin/blame.c
517fe807d6 builtin/blame.c    759) BUG_ON_OPT_NEG(unset);

builtin/branch.c
0ecb1fc726 builtin/branch.c 452) die(_("could not resolve HEAD"));
0ecb1fc726 builtin/branch.c 458) die(_("HEAD (%s) points outside of 
refs/heads/"), refname);

builtin/cat-file.c
0eb8d3767c builtin/cat-file.c 609) return error(_("only one batch option 
may be specified"));

builtin/fsck.c
0a995c2567 builtin/fsck.c  87) ret = _("unknown");
0a995c2567 builtin/fsck.c 164) objerror(parent, _("wrong object type in 
link"));
0a995c2567 builtin/fsck.c 275) printf_ln(_("unreachable %s %s"), 
printable_type(obj),
0a995c2567 builtin/fsck.c 303) error(_("could not create lost-found"));
0a995c2567 builtin/fsck.c 310) die_errno(_("could not write '%s'"), 
filename);
0a995c2567 builtin/fsck.c 314) die_errno(_("could not finish '%s'"),
0a995c2567 builtin/fsck.c 331) fprintf_ln(stderr, _("Checking %s"), 
describe_object(obj));
0a995c2567 builtin/fsck.c 349) fprintf_ln(stderr, _("Checking 
connectivity (%d objects)"), max);
0a995c2567 builtin/fsck.c 368) fprintf_ln(stderr, _("Checking %s %s"),
0a995c2567 builtin/fsck.c 381) printf_ln(_("root %s"),
0a995c2567 builtin/fsck.c 417) return error(_("%s: object corrupt or 
missing"),
0a995c2567 builtin/fsck.c 456) fprintf_ln(stderr, _("Checking reflog 
%s->%s"),
0a995c2567 builtin/fsck.c 580) error(_("%s: object could not be parsed: 
%s"),
0a995c2567 builtin/fsck.c 615) fprintf_ln(stderr, _("Checking object 
directory"));
e4d034baf2 builtin/fsck.c 633) fprintf_ln(stderr, _("Checking %s link"), 
head_ref_name);
e4d034baf2 builtin/fsck.c 638) return error(_("invalid %s"), head_ref_name);
0a995c2567 builtin/fsck.c 667) fprintf_ln(stderr, _("Checking cache tree"));
0a995c2567 builtin/fsck.c 683) err |= objerror(obj, _("non-tree in 
cache-tree"));

builtin/grep.c
fd6263fb73 builtin/grep.c 1051) warning(_("invalid option combination, 
ignoring --threads"));
fd6263fb73 builtin/grep.c 1057) die(_("invalid number of threads 
specified (%d)"), num_threads);

builtin/log.c
517fe807d6 builtin/log.c 1196) BUG_ON_OPT_NEG(unset);

builtin/merge.c
23c0ab7312 builtin/merge.c  131) return error(_("option `%s' requires a 
value"), opt->long_name);

builtin/pull.c
01a31f3bca 565) die(_("unable to access commit %s"),

builtin/read-tree.c
517fe807d6 builtin/read-tree.c  47) BUG_ON_OPT_NEG(unset);

builtin/reflog.c
977e72ca96 builtin/reflog.c 592) usage(_(reflog_expire_usage));
977e72ca96 builtin/reflog.c 643) status |= error(_("%s points 
nowhere!"), argv[i]);
977e72ca96 builtin/reflog.c 689) usage(_(reflog_delete_usage));
977e72ca96 builtin/reflog.c 695) return error(_("no reflog specified to 
delete"));
977e72ca96 builtin/reflog.c 704) status |= error(_("not a reflog: %s"), 
argv[i]);
977e72ca96 builtin/reflog.c 709) status |= error(_("no reflog for 
'%s'"), argv[i]);
977e72ca96 builtin/reflog.c 744) usage(_(reflog_exists_usage));
977e72ca96 builtin/reflog.c 752) usage(_(reflog_exists_usage));
977e72ca96 builtin/reflog.c 755) die(_("invalid ref format: %s"), 
argv[start]);

builtin/repack.c
0e1a23ceca 200) die(_("could not start pack-objects to repack promisor 
objects"));
e4d034baf2 239) die(_("repack: Expecting full hex object ID lines only 
from pack-objects."));
0e1a23ceca 250) die_errno(_("unable to create '%s'"), promisor_name);
e4d034baf2 411) die(_("repack: Expecting full hex object ID lines only 
from pack-objects."));

builtin/show-branch.c
517fe807d6 builtin/show-branch.c 607) BUG_ON_OPT_NEG(unset);

builtin/show-ref.c
517fe807d6 builtin/show-ref.c 154) BUG_ON_OPT_NEG(unset);

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
4a4f8ae763 341) die_errno(_("while expanding alias '%s': '%s'"),
4a4f8ae763 350) die(_("alias '%s' changes environment variables.\n"
4a4f8ae763 358) die(_("empty alias for %s"), alias_command);
4a4f8ae763 361) die(_("recursive alias: %s"), alias_command);
4a4f8ae763 412) die(_("%s doesn't support --super-prefix"), p->cmd);
4a4f8ae763 436) die_errno(_("write failure on standard output"));
4a4f8ae763 438) die(_("unknown write failure on standard output"));
4a4f8ae763 440) die_errno(_("close failed on standard output"));
4a4f8ae763 658) die(_("%s doesn't support --super-prefix"), argv[0]);
4a4f8ae763 770) die(_("cannot handle %s as a builtin"), cmd);

hex.c
b3a41547ce  93) char *sha1_to_hex_r(char *buffer, const unsigned char *sha1)
b3a41547ce  95) return hash_to_hex_algop_r(buffer, sha1, 
&hash_algos[GIT_HASH_SHA1]);
b3a41547ce 116) char *hash_to_hex(const unsigned char *hash)
b3a41547ce 118) return hash_to_hex_algop(hash, the_hash_algo);

merge-recursive.c
55ea0bf4c1 1584) return -1;
55ea0bf4c1 1587) return -1;
55ea0bf4c1 1593) return -1;
55ea0bf4c1 1596) return -1;
55ea0bf4c1 1663) return -1;
55ea0bf4c1 1666) return -1;
55ea0bf4c1 1669) return -1;
143dc79002 1702) return -1;
f10ffbb2ff 1737) return -1;
f10ffbb2ff 1785) return -1;
f10ffbb2ff 1801) return -1;
f10ffbb2ff 1804) return -1;
f10ffbb2ff 1814) return -1;
f10ffbb2ff 1830) return -1;
f10ffbb2ff 1833) return -1;

midx.c
name-hash.c
2179045fd0 532) die(_("unable to create lazy_dir thread: %s"), 
strerror(err));
2179045fd0 554) die(_("unable to create lazy_name thread: %s"), 
strerror(err));
2179045fd0 560) die(_("unable to join lazy_name thread: %s"), 
strerror(err));

parse-options-cb.c
23c0ab7312  21) return error(_("option `%s' expects a numerical value"),
23c0ab7312  51) return error(_("option `%s' expects \"always\", 
\"auto\", or \"never\""),

parse-options.c
23c0ab7312  88) return error(_("%s takes no value"), optname(opt, flags));
23c0ab7312  90) return error(_("%s isn't available"), optname(opt, flags));
23c0ab7312  92) return error(_("%s takes no value"), optname(opt, flags));
23c0ab7312 178) return error(_("%s expects a numerical value"),
23c0ab7312 194) return error(_("%s expects a non-negative integer value"
e7dd7bc3fd 356) error(_("did you mean `--%s` (with two dashes ?)"), arg);
e7dd7bc3fd 651) error(_("unknown non-ascii option in string: `%s'"),
23c0ab7312 785) strbuf_addf(&sb, "option `no-%s'", opt->long_name);

preload-index.c
2179045fd0 137) die(_("unable to create threaded lstat: %s"), 
strerror(err));

read-cache.c
567e20ae23  675) die(_("will not add file alias '%s' ('%s' already 
exists in index)"),
567e20ae23  676)     ce->name, alias->name);
567e20ae23  691) die(_("cannot create an empty blob in the object 
database"));
567e20ae23  712) return error(_("%s: can only add regular files, 
symbolic links or git-directories"), path);
567e20ae23  786) return error(_("unable to add '%s' to index"), path);
567e20ae23  822) error(_("invalid path '%s'"), path);
567e20ae23  848) error(_("invalid path '%s'"), path);
567e20ae23 1686) return error(_("bad signature 0x%08x"), 
hdr->hdr_signature);
567e20ae23 1689) return error(_("bad index version %d"), hdr_version);
567e20ae23 1728) return error(_("index uses %.4s extension, which we do 
not understand"),
567e20ae23 1730) fprintf_ln(stderr, _("ignoring %.4s extension"), ext);
567e20ae23 1777) die(_("unknown index entry format 0x%08x"), 
extended_flags);
567e20ae23 1848) die(_("unordered stage entries in index"));
567e20ae23 1851) die(_("multiple stage entries for merged file '%s'"),
567e20ae23 1854) die(_("unordered stage entries for '%s'"),
567e20ae23 2148) die_errno(_("%s: index file open failed"), path);
567e20ae23 2152) die_errno(_("%s: cannot stat the open index"), path);
567e20ae23 2156) die(_("%s: index file smaller than expected"), path);
567e20ae23 2160) die_errno(_("%s: unable to map index file"), path);
567e20ae23 2250) warning(_("could not freshen shared index '%s'"), 
shared_index);
567e20ae23 2285) die(_("broken index, expect %s in %s, got %s"),
567e20ae23 3071) error(_("cannot fix permission bits on '%s'"), 
get_tempfile_path(*temp));
567e20ae23 3217) return error(_("%s: cannot drop to stage #0"),

ref-filter.c
23c0ab7312 2326) return error(_("option `%s' is incompatible with 
--no-merged"),

remote.c
eafdc91bbc  362) warning(_("config remote shorthand cannot begin with 
'/': %s"),
eafdc91bbc  417) error(_("more than one uploadpack given, using the 
first"));
eafdc91bbc  683) die(_("key '%s' of pattern had no '*'"), key);
eafdc91bbc  693) die(_("value '%s' of pattern has no '*'"), value);
eafdc91bbc 1044) error(_("unable to delete '%s': remote ref does not 
exist"),
eafdc91bbc 1066) return error(_("dst ref %s receives from more than one 
src"),
eafdc91bbc 1785) die(_("couldn't find remote ref %s"), name);
eafdc91bbc 1798) error(_("* Ignoring funny ref '%s' locally"),
eafdc91bbc 1893) die(_("revision walk setup failed"));
eafdc91bbc 2166) return error(_("cannot parse expected object name '%s'"),

revision.c
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

run-command.c
2179045fd0 1229) error(_("cannot create async thread: %s"), strerror(err));

send-pack.c
c0e40a2d66 207) close(fd[1]);

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
Derrick Stolee      b45424181: revision.c: generation-based topo-order 
algorithm
Derrick Stolee      f0d9cc419: revision.c: begin refactoring 
--topo-order logic
Elijah Newren      143dc7900: merge-recursive: fix rename/add conflict 
handling
Elijah Newren      55ea0bf4c: merge-recursive: new function for better 
colliding conflict resolutions
Elijah Newren      f10ffbb2f: merge-recursive: improve 
rename/rename(1to2)/add[/add] handling
Jeff King      01a31f3bc: pull: handle --verify-signatures for unborn branch
Jeff King      0eb8d3767: cat-file: report an error on multiple --batch 
options
Jeff King      517fe807d: assert NOARG/NONEG behavior of parse-options 
callbacks
Jeff King      735ca208c: apply: return -1 from option callback instead 
of calling exit(1)
Jeff King      fce566480: am: handle --no-patch-format option
Joel Teichroeb      3d5ec65ce: stash: convert apply to builtin
Joel Teichroeb      5bf62a19c: stash: convert pop to builtin
Joel Teichroeb      700577117: stash: convert drop and clear to builtin
Junio C Hamano      e4d034baf: Merge branch 'nd/i18n' into jch
Nguyễn Thái Ngọc Duy      0a995c256: fsck: mark strings for translation
Nguyễn Thái Ngọc Duy      0e1a23cec: repack: mark more strings for 
translation
Nguyễn Thái Ngọc Duy      2179045fd: Clean up pthread_create() error 
handling
Nguyễn Thái Ngọc Duy      23c0ab731: parse-options: replace opterror() 
with optname()
Nguyễn Thái Ngọc Duy      4a4f8ae76: git.c: mark more strings for 
translation
Nguyễn Thái Ngọc Duy      567e20ae2: read-cache.c: mark more strings for 
translation
Nguyễn Thái Ngọc Duy      8a705c463: archive.c: mark more strings for 
translation
Nguyễn Thái Ngọc Duy      977e72ca9: reflog: mark strings for translation
Nguyễn Thái Ngọc Duy      aa4fa3fa7: attr.c: mark more string for 
translation
Nguyễn Thái Ngọc Duy      c0e40a2d6: send-pack.c: move async's #ifdef 
NO_PTHREADS back to run-command.c
Nguyễn Thái Ngọc Duy      e7dd7bc3f: parse-options.c: mark more strings 
for translation
Nguyễn Thái Ngọc Duy      eafdc91bb: remote.c: mark messages for translation
Nguyễn Thái Ngọc Duy      fd6263fb7: grep: clean up num_threads handling
Paul-Sebastian Ungureanu      104eb50d1: stash: convert show to builtin
Paul-Sebastian Ungureanu      193c3e351: stash: convert 
`stash--helper.c` into `stash.c`
Paul-Sebastian Ungureanu      1a0f0409a: stash: convert push to builtin
Paul-Sebastian Ungureanu      813904a0c: stash: convert store to builtin
Paul-Sebastian Ungureanu      9f630e748: stash: convert create to builtin
Paul-Sebastian Ungureanu      c2cc69f19: stash: make push -q quiet



Uncovered code in 'next' not in 'master'
--------------------------------------------

builtin/add.c
d1664e73ad builtin/add.c 458) die(_("index file corrupt"));

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

builtin/cat-file.c
98f425b453 builtin/cat-file.c  56) die("unable to stream %s to stdout", 
oid_to_hex(oid));

builtin/fetch.c
builtin/fsck.c
b29759d89a builtin/fsck.c 613) fprintf(stderr, "Checking %s link\n", 
head_ref_name);
b29759d89a builtin/fsck.c 618) return error("Invalid %s", head_ref_name);

builtin/grep.c
76e9bdc437 builtin/grep.c  439) grep_read_unlock();

builtin/reflog.c
c9ef0d95eb builtin/reflog.c 580) all_worktrees = 0;
c9ef0d95eb builtin/reflog.c 616) continue;

builtin/upload-archive.c
e001fd3a50 builtin/upload-archive.c 113) if (version == protocol_v0 || 
version == protocol_v1)
e001fd3a50 builtin/upload-archive.c 114) packet_write_fmt(1, "NACK 
unable to spawn subprocess\n");
e001fd3a50 builtin/upload-archive.c 115) else if (version == protocol_v2)
e001fd3a50 builtin/upload-archive.c 116) error_clnt("unable to spawn 
subprocess\n");

combine-diff.c
0074c9110d  377) state->sline[state->nb-1].p_lno =
0074c9110d  378) xcalloc(state->num_parent, sizeof(unsigned long));

date.c
c27cc94fad  904) tm->tm_mon = number-1;
c27cc94fad  908) else if (number > 69 && number < 100)
c27cc94fad  909) tm->tm_year = number;
c27cc94fad  910) else if (number < 38)
c27cc94fad  911) tm->tm_year = 100 + number;
c27cc94fad  952) pending_number(tm, num);

dir.c
8a2c174677  287) name = to_free = xmemdupz(name, namelen);

http-backend.c
fb19d32f05 646) argv[1] = ".";
fb19d32f05 647) argv[2] = NULL;

midx.c
1dcd9f2043  184) return;

refs.c
3a3b9d8cde  657) return 0;

refs/files-backend.c
remote.c
85daa01f6b 1219) continue;
85daa01f6b 1225) continue;

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

setup.c
58b284a2e9  413) return config_error_nonbool(var);

submodule-config.c
bcbc780d14 739) return CONFIG_INVALID_KEY;
45f5ef3d77 754) warning(_("Could not update .gitmodules entry %s"), key);

transport-helper.c
fb19d32f05  643) if (!data->connect && !data->stateless_connect)

worktree.c
3a3b9d8cde 495) return -1;
3a3b9d8cde 508) return -1;
3a3b9d8cde 517) return -1;
ab3e1f78ae 537) break;

xdiff-interface.c
xdiff/xutils.c
611e42a598 405) return -1;

Commits introducing uncovered code:
Antonio Ospite      45f5ef3d7: submodule: factor out a 
config_set_in_gitmodules_file_gently function
Antonio Ospite      76e9bdc43: submodule: support reading .gitmodules 
when it's not in the working tree
Antonio Ospite      bcbc780d1: submodule: add a 
print_config_from_gitmodules() helper
Ben Peart      d1664e73a: add: speed up cmd_add() by utilizing 
read_cache_preload()
Derrick Stolee      1dcd9f204: midx: close multi-pack-index on repack
Derrick Stolee      85daa01f6: remote: make add_missing_tags() linear
Jeff King      0074c9110: combine-diff: use an xdiff hunk callback
Jeff King      611e42a59: xdiff: provide a separate emit callback for hunks
Jeff King      8a2c17467: pathspec: handle non-terminated strings with 
:(attr)
Jeff King      98f425b45: cat-file: handle streaming failures consistently
Jeff King      c27cc94fa: approxidate: handle pending number for "specials"
Josh Steadmon      e001fd3a5: archive: implement protocol v2 archive command
Josh Steadmon      fb19d32f0: archive: allow archive over HTTP(S) with 
proto v2
Nguyễn Thái Ngọc Duy      3a3b9d8cd: refs: new ref types to make 
per-worktree refs visible to all worktrees
Nguyễn Thái Ngọc Duy      58b284a2e: worktree: add per-worktree config files
Nguyễn Thái Ngọc Duy      ab3e1f78a: revision.c: better error reporting 
on ref from different worktrees
Nguyễn Thái Ngọc Duy      b29759d89: fsck: check HEAD and reflog from 
other worktrees
Nguyễn Thái Ngọc Duy      c9ef0d95e: reflog expire: cover reflog from 
all worktrees
Phillip Wood      bcd33ec25: add read_author_script() to libgit



Uncovered code in 'master' not in 'master@{1}'
----------------------------------------------------

builtin/submodule--helper.c
e0a862fdaf 1648) url = sub->url;

gpg-interface.c
4de9394dcb 155) break;

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

upload-pack.c
1d1243fe63 1403) deepen(INFINITE_DEPTH, data->deepen_relative, 
&data->shallows,

Commits introducing uncovered code:
Brendan Forster      93aef7c79: http: add support for disabling SSL 
revocation checks in cURL
Johannes Schindelin      21084e84a: http: add support for selecting SSL 
backends at runtime
Johannes Schindelin      b67d40adb: http: when using Secure Channel, 
ignore sslCAInfo by default
Jonathan Tan      1d1243fe6: upload-pack: make want_obj not global
Michał Górny      4de9394dc: gpg-interface.c: obtain primary key 
fingerprint as well
Stefan Beller      e0a862fda: submodule helper: convert relative URL to 
absolute URL if needed



