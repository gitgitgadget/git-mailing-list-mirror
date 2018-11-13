Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB2DE1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 18:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732517AbeKNEFG (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 23:05:06 -0500
Received: from mail-qk1-f173.google.com ([209.85.222.173]:45808 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732511AbeKNEFG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 23:05:06 -0500
Received: by mail-qk1-f173.google.com with SMTP id d135so21033497qkc.12
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 10:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=BEfHKTvlI2byKj4I/SV27f46tbYGfDTdFc9R0uOaFpQ=;
        b=LcYbTKNQ9T62OoDNPuXTtV63ruBvsNp3MS/m1YhKwfNTwq5ucSumjLayKiTgvsjFCm
         bF4GcZl6vrOJod8N3DBGPRX1V2+JSKvS3KHpDr2+dTl4Iv5rL7T9Yz7M8PkQ7vJMjtLF
         ZlpVaWJixD5GI0U7GuVfN0Hf3ejXEc1UP4dyTQI67xl6mAdmn0TfspN8w+LuGrIClRZa
         OrJDGQHcxVvS3MkMJ4bdYxcjQxedxAEeaydGFgAnopeO695O+wAdisC49Mt568340CxS
         cwaWf1XcxfUvAD+vIBg7dv7Cz7dOTpP7fov/e4Stklj7XY0uZsSFbFOju+o1T90adv65
         VY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=BEfHKTvlI2byKj4I/SV27f46tbYGfDTdFc9R0uOaFpQ=;
        b=NAws7s5nWw8dcZBnMcNVFyJg0P/FHF62xFKC5thyDru3GmFc4gOA4Ksa9wiYSBjll8
         XvX4tFfVAvrUuazDKtk/4BCX4q76CmnvreootCXYi2Evm8PsZxPzJX5y63/+ItEIEeHb
         kxGodX6sCEmhg/4lZZL9t5/o+rFxJZZl+U1TnRpNx5EIU5RCYoQseuoxjqvkR9h19eiy
         mQqx2Ukpk0H2pzZMRYfzG6/t6KZS66QdVOtzxHX/zoJ8edOIJ+bolYeeqSyI5rUD0UnK
         h/0whh5nZw7inu1IUt3Fxud64OUhrCXJpHSrStfE63TbwzkYt+oCsbeAjj1sJH/beUtF
         ZrCA==
X-Gm-Message-State: AGRZ1gKEppVSYNmRIl3FRojblLpJnNBRx0am4Ski9unElmf68UB5ByNk
        EYC0dpWirvSU/+khW56OpPEA6i9U
X-Google-Smtp-Source: AJdET5eADUPoiYbaDfWBZeRiuqL5h9qdQuJ1uWIujqyX6qTF2Jwj9iWka4cy8fHUi9uSxREcqMDS9g==
X-Received: by 2002:ac8:5314:: with SMTP id t20mr5880138qtn.328.1542132351776;
        Tue, 13 Nov 2018 10:05:51 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:b86f:fd67:3f75:fa3? ([2001:4898:8010:0:a1a5:fd67:3f75:fa3])
        by smtp.gmail.com with ESMTPSA id m14sm8898829qka.21.2018.11.13.10.05.50
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 10:05:51 -0800 (PST)
To:     Git List <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (Tuesday, Nov 13)
Message-ID: <97be3e21-6a8c-9718-5161-37318f6d685f@gmail.com>
Date:   Tue, 13 Nov 2018 13:05:50 -0500
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

Here is the test coverage report for today.

Thanks,
-Stolee

[1] https://dev.azure.com/git/git/_build/results?buildId=256&view=logs

---

pu: a849d4c48bb308cdf3f9d7dc84251d92b4d7ff03
jch: e3cb78b4131db2f98330ff110525db31c6abff16
next: 17fedb746fde9e40924a6ce11c0976a097eb126b
master: d166e6afe5f257217836ef24a73764eba390c58d
master@{1}: 8858448bb49332d353febc078ce4a3abcc962efe

Uncovered code in 'pu' not in 'jch'
--------------------------------------

builtin/blame.c
a849d4c48b builtin/blame.c    200) 
repo_unuse_commit_buffer(the_repository, commit, message);
74e8221b52 builtin/blame.c    928) blame_date_width = sizeof("Thu Oct 19 
16:00");
74e8221b52 builtin/blame.c    929) break;

builtin/describe.c
a849d4c48b builtin/describe.c 257) repo_parse_commit(the_repository, p);

builtin/pack-objects.c
a849d4c48b builtin/pack-objects.c 2832) if 
(!repo_has_object_file(the_repository, &obj->oid) && 
is_promisor_object(&obj->oid))

builtin/remote.c
b7f4e371e7 builtin/remote.c 1551) die(_("--save-to-push cannot be used 
with other options"));
b7f4e371e7 builtin/remote.c 1575) die(_("--save-to-push can only be used 
when only one url is defined"));

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
a849d4c48b 2935) buf = repo_read_object_file(the_repository, oid, &type, 
&size);
a849d4c48b 3041) buf = repo_read_object_file(the_repository, oid, &unused,

fsck.c
a849d4c48b  858) repo_unuse_commit_buffer(the_repository, commit, buffer);
a849d4c48b  878) repo_read_object_file(the_repository,
a849d4c48b  879)       &tag->object.oid, &type, &size);

http-push.c
a849d4c48b 1635) if (!repo_has_object_file(the_repository, &head_oid))
a849d4c48b 1642) if (!repo_has_object_file(the_repository, 
&remote_ref->old_oid))

negotiator/default.c
a849d4c48b  71) if (repo_parse_commit(the_repository, commit))

remote.c
879b6a9e6f 1140) return error(_("dst ref %s receives from more than one 
src."),

revision.c
a849d4c48b  726) if (repo_parse_commit(the_repository, p) < 0)

sequencer.c
a849d4c48b 1643) repo_unuse_commit_buffer(the_repository, head_commit,
a849d4c48b 3914) repo_unuse_commit_buffer(the_repository,

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
a849d4c48b 108) if (repo_parse_commit(the_repository, commit))

wrapper.c
5efde212fc  70) die("Out of memory, malloc failed (tried to allocate %" 
PRIuMAX " bytes)",
5efde212fc  73) error("Out of memory, malloc failed (tried to allocate 
%" PRIuMAX " bytes)",

Commits introducing uncovered code:
Ævar Arnfjörð Bjarmason      879b6a9e6: i18n: remote.c: mark error(...) 
messages for translation
Denton Liu      b7f4e371e: remote: add --save-to-push option to git 
remote set-url
Junio C Hamano      a849d4c48: merge-fix/dl/remote-save-to-push
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

archive.c
c6e7965ddf 399) die(_("not a valid object name: %s"), name);
c6e7965ddf 412) die(_("not a tree object: %s"), oid_to_hex(&oid));
c6e7965ddf 422) die(_("current working directory is untracked"));

attr.c
ad8f8f4aed  369) fprintf_ln(stderr, _("%s not allowed: %s:%d"),

blame.c
fb998eae6c 1717) obj = deref_tag(revs->repo, obj, NULL, 0);
fb998eae6c 1724) head_commit = lookup_commit_reference_gently(revs->repo,

builtin/branch.c
0ecb1fc726 builtin/branch.c 456) die(_("could not resolve HEAD"));
0ecb1fc726 builtin/branch.c 462) die(_("HEAD (%s) points outside of 
refs/heads/"), refname);

builtin/bundle.c
74ae4b638d builtin/bundle.c 64) return !!unbundle(the_repository, 
&header, bundle_fd, 0) ||

builtin/fsck.c
674ba34038 builtin/fsck.c  87) ret = _("unknown");
674ba34038 builtin/fsck.c 167) objerror(parent, _("wrong object type in 
link"));
674ba34038 builtin/fsck.c 278) printf_ln(_("unreachable %s %s"), 
printable_type(obj),
674ba34038 builtin/fsck.c 306) error(_("could not create lost-found"));
674ba34038 builtin/fsck.c 313) die_errno(_("could not write '%s'"), 
filename);
674ba34038 builtin/fsck.c 317) die_errno(_("could not finish '%s'"),
674ba34038 builtin/fsck.c 334) fprintf_ln(stderr, _("Checking %s"), 
describe_object(obj));
674ba34038 builtin/fsck.c 352) fprintf_ln(stderr, _("Checking 
connectivity (%d objects)"), max);
674ba34038 builtin/fsck.c 371) fprintf_ln(stderr, _("Checking %s %s"),
674ba34038 builtin/fsck.c 384) printf_ln(_("root %s"),
674ba34038 builtin/fsck.c 420) return error(_("%s: object corrupt or 
missing"),
674ba34038 builtin/fsck.c 459) fprintf_ln(stderr, _("Checking reflog 
%s->%s"),
674ba34038 builtin/fsck.c 583) error(_("%s: object could not be parsed: 
%s"),
674ba34038 builtin/fsck.c 618) fprintf_ln(stderr, _("Checking object 
directory"));
287d68a44b builtin/fsck.c 636) fprintf_ln(stderr, _("Checking %s link"), 
head_ref_name);
287d68a44b builtin/fsck.c 641) return error(_("invalid %s"), head_ref_name);
674ba34038 builtin/fsck.c 670) fprintf_ln(stderr, _("Checking cache tree"));
674ba34038 builtin/fsck.c 686) err |= objerror(obj, _("non-tree in 
cache-tree"));

builtin/merge.c
9440b831ad builtin/merge.c  131) return error(_("option `%s' requires a 
value"), opt->long_name);

builtin/pack-objects.c
ca473cef91 builtin/pack-objects.c 2086) die(_("object %s inconsistent 
object length (%"PRIuMAX" vs %"PRIuMAX")"),
ca473cef91 builtin/pack-objects.c 2087) oid_to_hex(&trg_entry->idx.oid), 
(uintmax_t)sz,
ca473cef91 builtin/pack-objects.c 2113) die(_("object %s inconsistent 
object length (%"PRIuMAX" vs %"PRIuMAX")"),
ca473cef91 builtin/pack-objects.c 2114) oid_to_hex(&src_entry->idx.oid), 
(uintmax_t)sz,

builtin/rebase--interactive.c
005af339c9 builtin/rebase--interactive.c  262) ret = 
rearrange_squash(the_repository);
005af339c9 builtin/rebase--interactive.c  265) ret = 
sequencer_add_exec_commands(the_repository, cmd);

builtin/rebase.c
3249c1251e  544) ret = -1;
3249c1251e  545) goto leave_reset_head;
bac2a1e36f  549) ret = error(_("could not determine HEAD revision"));
bac2a1e36f  550) goto leave_reset_head;
3249c1251e  568) ret = error(_("could not read index"));
3249c1251e  569) goto leave_reset_head;
bac2a1e36f  573) ret = error(_("failed to find tree of %s"), 
oid_to_hex(oid));
bac2a1e36f  574) goto leave_reset_head;
3249c1251e  578) ret = error(_("failed to find tree of %s"), 
oid_to_hex(oid));
3249c1251e  579) goto leave_reset_head;
3249c1251e  592) goto leave_reset_head;

builtin/reflog.c
dd509db342 builtin/reflog.c 592) usage(_(reflog_expire_usage));
dd509db342 builtin/reflog.c 643) status |= error(_("%s points 
nowhere!"), argv[i]);
dd509db342 builtin/reflog.c 689) usage(_(reflog_delete_usage));
dd509db342 builtin/reflog.c 695) return error(_("no reflog specified to 
delete"));
dd509db342 builtin/reflog.c 704) status |= error(_("not a reflog: %s"), 
argv[i]);
dd509db342 builtin/reflog.c 709) status |= error(_("no reflog for 
'%s'"), argv[i]);
dd509db342 builtin/reflog.c 744) usage(_(reflog_exists_usage));
dd509db342 builtin/reflog.c 752) usage(_(reflog_exists_usage));
dd509db342 builtin/reflog.c 755) die(_("invalid ref format: %s"), 
argv[start]);

builtin/repack.c
c83d950e59 200) die(_("could not start pack-objects to repack promisor 
objects"));
287d68a44b 239) die(_("repack: Expecting full hex object ID lines only 
from pack-objects."));
c83d950e59 250) die_errno(_("unable to create '%s'"), promisor_name);
287d68a44b 411) die(_("repack: Expecting full hex object ID lines only 
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

bundle.c
74ae4b638d 380) struct commit *one = lookup_commit_reference(revs->repo, 
&oid);

delta-islands.c
385cb64ff3 216) parse_object(r, &obj->oid);

fast-import.c
ca473cef91 2958) strbuf_addf(&line, "%s %s %"PRIuMAX"\n", oid_to_hex(oid),

git.c
8aa8c14097 341) die_errno(_("while expanding alias '%s': '%s'"),
8aa8c14097 350) die(_("alias '%s' changes environment variables.\n"
8aa8c14097 358) die(_("empty alias for %s"), alias_command);
8aa8c14097 361) die(_("recursive alias: %s"), alias_command);
8aa8c14097 412) die(_("%s doesn't support --super-prefix"), p->cmd);
8aa8c14097 436) die_errno(_("write failure on standard output"));
8aa8c14097 438) die(_("unknown write failure on standard output"));
8aa8c14097 440) die_errno(_("close failed on standard output"));
8aa8c14097 658) die(_("%s doesn't support --super-prefix"), argv[0]);
8aa8c14097 770) die(_("cannot handle %s as a builtin"), cmd);

hex.c
b3a41547ce  93) char *sha1_to_hex_r(char *buffer, const unsigned char *sha1)
b3a41547ce  95) return hash_to_hex_algop_r(buffer, sha1, 
&hash_algos[GIT_HASH_SHA1]);
b3a41547ce 116) char *hash_to_hex(const unsigned char *hash)
b3a41547ce 118) return hash_to_hex_algop(hash, the_hash_algo);

http-walker.c
b69fb867b4 http-walker.c 550) loose_object_path(the_repository, &buf, 
req->sha1);

http.c
d73019feb4  289) return git_config_string(&curl_http_version, var, value);
d73019feb4  797) static int get_curl_http_version_opt(const char 
*version_string, long *opt)
d73019feb4  808) for (i = 0; i < ARRAY_SIZE(choice); i++) {
d73019feb4  809) if (!strcmp(version_string, choice[i].name)) {
d73019feb4  810) *opt = choice[i].opt_token;
d73019feb4  811) return 0;
d73019feb4  815) warning("unknown value given to http.version: '%s'", 
version_string);
d73019feb4  816) return -1; /* not found */
d73019feb4  841) if (!get_curl_http_version_opt(curl_http_version, &opt)) {
d73019feb4  843) curl_easy_setopt(result, CURLOPT_HTTP_VERSION, opt);

merge-recursive.c
37b65ce36b 1584) return -1;
37b65ce36b 1587) return -1;
37b65ce36b 1593) return -1;
37b65ce36b 1596) return -1;
37b65ce36b 1663) return -1;
37b65ce36b 1666) return -1;
37b65ce36b 1669) return -1;
7f8671656f 1702) return -1;
48c9cb9d6d 1758) return -1;
48c9cb9d6d 1806) return -1;
48c9cb9d6d 1812) return -1;
48c9cb9d6d 1815) return -1;
48c9cb9d6d 1825) return -1;
48c9cb9d6d 1831) return -1;
48c9cb9d6d 1834) return -1;

parse-options-cb.c
9440b831ad  21) return error(_("option `%s' expects a numerical value"),
9440b831ad  51) return error(_("option `%s' expects \"always\", 
\"auto\", or \"never\""),

parse-options.c
9440b831ad  88) return error(_("%s takes no value"), optname(opt, flags));
9440b831ad  90) return error(_("%s isn't available"), optname(opt, flags));
9440b831ad  92) return error(_("%s takes no value"), optname(opt, flags));
9440b831ad 178) return error(_("%s expects a numerical value"),
9440b831ad 194) return error(_("%s expects a non-negative integer value"
8900342628 356) error(_("did you mean `--%s` (with two dashes ?)"), arg);
8900342628 651) error(_("unknown non-ascii option in string: `%s'"),
9440b831ad 785) strbuf_addf(&sb, "option `no-%s'", opt->long_name);

protocol.c
c95f252809  37) die(_("Unrecognized protocol version"));
c95f252809  39) die(_("Unrecognized protocol_version"));

read-cache.c
9d0a9e9089  675) die(_("will not add file alias '%s' ('%s' already 
exists in index)"),
9d0a9e9089  676)     ce->name, alias->name);
9d0a9e9089  691) die(_("cannot create an empty blob in the object 
database"));
9d0a9e9089  712) return error(_("%s: can only add regular files, 
symbolic links or git-directories"), path);
9d0a9e9089  786) return error(_("unable to add '%s' to index"), path);
9d0a9e9089  822) error(_("invalid path '%s'"), path);
9d0a9e9089  848) error(_("invalid path '%s'"), path);
9d0a9e9089 1686) return error(_("bad signature 0x%08x"), 
hdr->hdr_signature);
9d0a9e9089 1689) return error(_("bad index version %d"), hdr_version);
9d0a9e9089 1728) return error(_("index uses %.4s extension, which we do 
not understand"),
9d0a9e9089 1730) fprintf_ln(stderr, _("ignoring %.4s extension"), ext);
9d0a9e9089 1777) die(_("unknown index entry format 0x%08x"), 
extended_flags);
9d0a9e9089 1848) die(_("unordered stage entries in index"));
9d0a9e9089 1851) die(_("multiple stage entries for merged file '%s'"),
9d0a9e9089 1854) die(_("unordered stage entries for '%s'"),
9d0a9e9089 2148) die_errno(_("%s: index file open failed"), path);
9d0a9e9089 2152) die_errno(_("%s: cannot stat the open index"), path);
9d0a9e9089 2156) die(_("%s: index file smaller than expected"), path);
9d0a9e9089 2160) die_errno(_("%s: unable to map index file"), path);
9d0a9e9089 2250) warning(_("could not freshen shared index '%s'"), 
shared_index);
9d0a9e9089 2285) die(_("broken index, expect %s in %s, got %s"),
9d0a9e9089 3071) error(_("cannot fix permission bits on '%s'"), 
get_tempfile_path(*temp));
9d0a9e9089 3217) return error(_("%s: cannot drop to stage #0"),

ref-filter.c
bbfc042ef9  238) oi_deref.info.sizep = &oi_deref.size;
bbfc042ef9  247) return strbuf_addf_ret(err, -1, _("unrecognized 
%%(objectsize) argument: %s"), arg);
ab0e367154  255) return strbuf_addf_ret(err, -1, _("%%(deltabase) does 
not take arguments"));
9440b831ad 2380) return error(_("option `%s' is incompatible with 
--no-merged"),

remote.c
0b9c3afdbf  362) warning(_("config remote shorthand cannot begin with 
'/': %s"),
0b9c3afdbf  417) error(_("more than one uploadpack given, using the 
first"));
0b9c3afdbf  683) die(_("key '%s' of pattern had no '*'"), key);
0b9c3afdbf  693) die(_("value '%s' of pattern has no '*'"), value);
0b9c3afdbf 1044) error(_("unable to delete '%s': remote ref does not 
exist"),
0b9c3afdbf 1066) return error(_("dst ref %s receives from more than one 
src"),
0b9c3afdbf 1785) die(_("couldn't find remote ref %s"), name);
0b9c3afdbf 1798) error(_("* Ignoring funny ref '%s' locally"),
0b9c3afdbf 1893) die(_("revision walk setup failed"));
0b9c3afdbf 2166) return error(_("cannot parse expected object name '%s'"),

sequencer.c
f11c958054  593) istate->cache_tree = cache_tree();
18e711a162 2387) opts->quiet = 1;
f11c958054 3977) res = error_dirty_index(r->index, opts);

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
f0eaf63819 sha1-file.c 2207) return r;

Commits introducing uncovered code:
brian m. carlson      2f90b9d9b: sha1-file: provide functions to look up 
hash algorithms
brian m. carlson      b3a41547c: hex: introduce functions to print 
arbitrary hashes
Daniels Umanovskis      0ecb1fc72: branch: introduce --show-current 
display option
Elijah Newren      18e711a16: git-rebase, sequencer: extend --quiet 
option for the interactive machinery
Elijah Newren      37b65ce36: merge-recursive: new function for better 
colliding conflict resolutions
Elijah Newren      48c9cb9d6: merge-recursive: improve 
rename/rename(1to2)/add[/add] handling
Elijah Newren      7f8671656: merge-recursive: fix rename/add conflict 
handling
Force Charlie      d73019feb: http: add support selecting http version
Jeff King      b69fb867b: sha1_file_name(): overwrite buffer instead of 
appending
Jeff King      f0eaf6381: sha1-file: use an object_directory for the 
main object dir
Joel Teichroeb      3d5ec65ce: stash: convert apply to builtin
Joel Teichroeb      5bf62a19c: stash: convert pop to builtin
Joel Teichroeb      700577117: stash: convert drop and clear to builtin
Johannes Schindelin      3249c1251: rebase: consolidate clean-up code 
before leaving reset_head()
Johannes Schindelin      bac2a1e36: built-in rebase: reinstate `checkout 
-q` behavior where appropriate
Josh Steadmon      c95f25280: protocol: advertise multiple supported 
versions
Junio C Hamano      287d68a44: Merge branch 'nd/i18n' into jch
Nguyễn Thái Ngọc Duy      005af339c: sequencer.c: remove implicit 
dependency on the_repository
Nguyễn Thái Ngọc Duy      0b9c3afdb: remote.c: mark messages for translation
Nguyễn Thái Ngọc Duy      385cb64ff: delta-islands.c: remove 
the_repository references
Nguyễn Thái Ngọc Duy      674ba3403: fsck: mark strings for translation
Nguyễn Thái Ngọc Duy      74ae4b638: bundle.c: remove the_repository 
references
Nguyễn Thái Ngọc Duy      890034262: parse-options.c: mark more strings 
for translation
Nguyễn Thái Ngọc Duy      8aa8c1409: git.c: mark more strings for 
translation
Nguyễn Thái Ngọc Duy      9440b831a: parse-options: replace opterror() 
with optname()
Nguyễn Thái Ngọc Duy      9d0a9e908: read-cache.c: mark more strings for 
translation
Nguyễn Thái Ngọc Duy      ad8f8f4ae: attr.c: mark more string for 
translation
Nguyễn Thái Ngọc Duy      c6e7965dd: archive.c: mark more strings for 
translation
Nguyễn Thái Ngọc Duy      c83d950e5: repack: mark more strings for 
translation
Nguyễn Thái Ngọc Duy      dd509db34: reflog: mark strings for translation
Nguyễn Thái Ngọc Duy      f11c95805: sequencer.c: remove implicit 
dependency on the_index
Nguyễn Thái Ngọc Duy      fb998eae6: blame.c: remove implicit dependency 
the_repository
Olga Telezhnaya      ab0e36715: ref-filter: add deltabase option
Olga Telezhnaya      bbfc042ef: ref-filter: add objectsize:disk option
Paul-Sebastian Ungureanu      104eb50d1: stash: convert show to builtin
Paul-Sebastian Ungureanu      193c3e351: stash: convert 
`stash--helper.c` into `stash.c`
Paul-Sebastian Ungureanu      1a0f0409a: stash: convert push to builtin
Paul-Sebastian Ungureanu      813904a0c: stash: convert store to builtin
Paul-Sebastian Ungureanu      9f630e748: stash: convert create to builtin
Paul-Sebastian Ungureanu      c2cc69f19: stash: make push -q quiet
Torsten Bögershausen      ca473cef9: Upcast size_t variables to 
uintmax_t when printing



Uncovered code in 'next' not in 'master'
--------------------------------------------

apply.c
517fe807d6 4776) BUG_ON_OPT_NEG(unset);
735ca208c5 4830) return -1;

builtin/am.c
fce5664805 2117) *opt_value = PATCH_FORMAT_UNKNOWN;

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

builtin/blame.c
517fe807d6 builtin/blame.c    759) BUG_ON_OPT_NEG(unset);

builtin/cat-file.c
0eb8d3767c builtin/cat-file.c 609) return error(_("only one batch option 
may be specified"));

builtin/grep.c
fd6263fb73 builtin/grep.c 1051) warning(_("invalid option combination, 
ignoring --threads"));
fd6263fb73 builtin/grep.c 1057) die(_("invalid number of threads 
specified (%d)"), num_threads);

builtin/log.c
517fe807d6 builtin/log.c 1196) BUG_ON_OPT_NEG(unset);

builtin/pull.c
01a31f3bca 565) die(_("unable to access commit %s"),

builtin/show-branch.c
517fe807d6 builtin/show-branch.c 607) BUG_ON_OPT_NEG(unset);

builtin/show-ref.c
517fe807d6 builtin/show-ref.c 154) BUG_ON_OPT_NEG(unset);

builtin/upload-archive.c
e001fd3a50 builtin/upload-archive.c 113) if (version == protocol_v0 || 
version == protocol_v1)
e001fd3a50 builtin/upload-archive.c 114) packet_write_fmt(1, "NACK 
unable to spawn subprocess\n");
e001fd3a50 builtin/upload-archive.c 115) else if (version == protocol_v2)
e001fd3a50 builtin/upload-archive.c 116) error_clnt("unable to spawn 
subprocess\n");

http-backend.c
fb19d32f05 646) argv[1] = ".";
fb19d32f05 647) argv[2] = NULL;

midx.c
name-hash.c
2179045fd0 532) die(_("unable to create lazy_dir thread: %s"), 
strerror(err));
2179045fd0 554) die(_("unable to create lazy_name thread: %s"), 
strerror(err));
2179045fd0 560) die(_("unable to join lazy_name thread: %s"), 
strerror(err));

preload-index.c
2179045fd0 137) die(_("unable to create threaded lstat: %s"), 
strerror(err));

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

transport-helper.c
fb19d32f05  643) if (!data->connect && !data->stateless_connect)

Commits introducing uncovered code:
Derrick Stolee      b45424181: revision.c: generation-based topo-order 
algorithm
Derrick Stolee      f0d9cc419: revision.c: begin refactoring 
--topo-order logic
Jeff King      01a31f3bc: pull: handle --verify-signatures for unborn branch
Jeff King      0eb8d3767: cat-file: report an error on multiple --batch 
options
Jeff King      517fe807d: assert NOARG/NONEG behavior of parse-options 
callbacks
Jeff King      735ca208c: apply: return -1 from option callback instead 
of calling exit(1)
Jeff King      fce566480: am: handle --no-patch-format option
Josh Steadmon      e001fd3a5: archive: implement protocol v2 archive command
Josh Steadmon      fb19d32f0: archive: allow archive over HTTP(S) with 
proto v2
Nguyễn Thái Ngọc Duy      2179045fd: Clean up pthread_create() error 
handling
Nguyễn Thái Ngọc Duy      c0e40a2d6: send-pack.c: move async's #ifdef 
NO_PTHREADS back to run-command.c
Nguyễn Thái Ngọc Duy      fd6263fb7: grep: clean up num_threads handling



Uncovered code in 'master' not in 'master@{1}'
----------------------------------------------------

builtin/add.c
d1664e73ad builtin/add.c 458) die(_("index file corrupt"));

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

