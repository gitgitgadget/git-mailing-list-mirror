Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2563A1F454
	for <e@80x24.org>; Mon, 15 Oct 2018 16:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbeJPAKp (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 20:10:45 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]:44080 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbeJPAKo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 20:10:44 -0400
Received: by mail-qk1-f171.google.com with SMTP id y8-v6so12178957qka.11
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 09:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=rxCGgYGKGWk+JE9aNVetVPM2Z9xfESOdgxrO8BnQ87U=;
        b=vH4dwLaI92qy0+8qEs/yJXvTj0gZSPMMqjrxRZ+56KS4IhJ/0iFMX74trlnH5r1eU5
         iJwbnGOI0f18YlpFh1plFR15hRh7yNyZFtJm1IV0qNTWZOYDA1Rmf7uNSOWJLuLrYcyr
         KdHrV8bY/DNmn+fQg03dy9pyKT1r3Ki7KaCoNEMTsAknrM9E+FVIT7YcxDMIoaNfPrzh
         6ui8FsVa8r+Tmr6EW8UH/CFF4BP+H+lCsIn8+FT9o7RZwOzWOwyYPGjGg6NyXmlIDIbA
         mnZp8IxSKlAhcSg3WfGYpHgCjJoK9BsJyNJox9/p3UDMVx4h7Nt3nEc0UxFJoSYFyKZ7
         /i3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=rxCGgYGKGWk+JE9aNVetVPM2Z9xfESOdgxrO8BnQ87U=;
        b=QDjxfSf1RhM0OuDNMziNS+4us6dSCAgitquyKhl1d1iL0ruCpPd8U6Jo657PhEivje
         B45Rro50dboUVoZe8RX1Jd2PgxXQVcnXkMtqi3cfAxgZYcDNkDTfvXOxVEUcf1SGk9Ee
         qWm1dlUi5gATsZc492ywPo9zWTfhsRWz/EAN2ePc+/lG5MMCTF1RYo9HA38dvpiJNdEN
         kDwndsuRbk3Q8dPEQJufb9qNit7eU99SwYi6YpQw99TA9FsjcMDIe7rdo7AH+wzyBo68
         dLUglqN38nqvwuCd9YSw119O4HFRJBuHUbGsPy4UmYRPGJ6WjgfXpRpJie+iAztCTjeE
         0BGw==
X-Gm-Message-State: ABuFfoiC7yXqb0eLZjVgD3pBrL/qgeU9o/88Vq5LTE/zbe9Wa5hCzEQc
        fkIJj2uLm5h7Xy1CLX3fXTAVVQOW
X-Google-Smtp-Source: ACcGV61ARV4JePQa3jRO8DwGqFLdHiQd69U+jBclSZBPKFz7TShjvGno68xL7XbAMOtLwD6Kw18CgA==
X-Received: by 2002:a37:94c6:: with SMTP id w189-v6mr16702999qkd.277.1539620686334;
        Mon, 15 Oct 2018 09:24:46 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:a017:1942:43e1:ced3? ([2001:4898:8010:0:894d:1942:43e1:ced3])
        by smtp.gmail.com with ESMTPSA id n30-v6sm6348953qte.37.2018.10.15.09.24.45
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 09:24:45 -0700 (PDT)
To:     Git List <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (Monday, Oct 15)
Message-ID: <6be9fe04-138d-01b7-91c1-6c029ab7c9be@gmail.com>
Date:   Mon, 15 Oct 2018 12:24:44 -0400
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
diff A B' to discover _new_ lines of code that are not covered. This 
report ignores lines including "BUG(".

This report takes the output of these results after running on four 
branches:

         pu: 78bfaf7bc1efe6892fe4dbedf9ed80f9dd48146c

        jch: d67e018e0f57ebbb4fa0354a58a0a6d47e25a948

       next: 152ad8e3369ac77026886a2910e3a407c281df35

     master: 5a0cc8aca797dbd7d2be3b67458ff880ed45cddf

      maint: 04861070400d3ca9d487bd0d736ca818b9ffe371

I ran the test suite on each of these branches on an Ubuntu Linux VM, 
and I'm missing some dependencies (like apache, svn, and perforce) so 
not all tests are run.

I submit this output without comment. I'm taking a look especially at my 
own lines to see where coverage can be improved.

Thanks,

-Stolee

Uncovered code in 'pu' (12227c8) and not in 'jch' (22f2f0f)
-----------------------------------------------------------
builtin/blame.c
74e8221b52 builtin/blame.c    924) blame_date_width = sizeof("Thu Oct 19 
16:00");
74e8221b52 builtin/blame.c    925) break;

builtin/branch.c
ba8ba9df26 builtin/branch.c 452) die(_("could not resolve HEAD"));
ba8ba9df26 builtin/branch.c 458) die(_("HEAD (%s) points outside of 
refs/heads/"), refname);

builtin/grep.c
a8ace17bd4 builtin/grep.c  439) grep_read_unlock();

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

git.c
a9a60b94cc 322) fprintf_ln(stderr, _("'%s' is aliased to '%s'"),

rebase-interactive.c
b74a37a5a7  26) warning(_("unrecognized setting %s for option "
6424061be4 107) return error_errno(_("could not write '%s''"), todo_file);
6424061be4 110) return error(_("could not copy '%s' to '%s'."), todo_file,
b74a37a5a7 174) goto leave_check;

sequencer.c
b5d6062402 4425) strbuf_insert(buf, todo_list->items[insert].offset_in_buf +
b5d6062402 4437) int sequencer_add_exec_commands(const char *commands)
06d8136126 4444) return error_errno(_("could not read '%s'."), todo_file);
b5d6062402 4446) if (todo_list_parse_insn_buffer(todo_list.buf.buf, 
&todo_list)) {
b5d6062402 4451) todo_list_add_exec_commands(&todo_list, commands);
b5d6062402 4452) res = write_message(todo_list.buf.buf, 
todo_list.buf.len, todo_file, 0);
0cce4a2756 4453) todo_list_release(&todo_list);
b5d6062402 4455) return res;
b74a37a5a7 4515) goto out;
b74a37a5a7 4520) goto out;
b8dac44d10 4660) todo_list_release(&new_todo);
009173ed7b 4665) todo_list_release(&new_todo);
009173ed7b 4666) return error_errno(_("could not write '%s'"), todo_file);
9787d17d40 4859) int rearrange_squash_in_todo_file(void)
9787d17d40 4861) const char *todo_file = rebase_path_todo();
9787d17d40 4862) struct todo_list todo_list = TODO_LIST_INIT;
9787d17d40 4863) int res = 0;
9787d17d40 4865) if (strbuf_read_file_or_whine(&todo_list.buf, 
todo_file) < 0)
9787d17d40 4866) return -1;
9787d17d40 4867) if (todo_list_parse_insn_buffer(todo_list.buf.buf, 
&todo_list) < 0) {
9787d17d40 4868) todo_list_release(&todo_list);
9787d17d40 4869) return -1;
9787d17d40 4872) res = todo_list_rearrange_squash(&todo_list);
9787d17d40 4873) if (!res)
9787d17d40 4874) res = rewrite_file(todo_file, todo_list.buf.buf, 
todo_list.buf.len);
9787d17d40 4876) todo_list_release(&todo_list);

submodule-config.c
bcbc780d14 739) return CONFIG_INVALID_KEY;
45f5ef3d77 754) warning(_("Could not update .gitmodules entry %s"), key);

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
Antonio Ospite      a8ace17bd: submodule: support reading .gitmodules 
when it's not in the working tree
Antonio Ospite      bcbc780d1: submodule: add a 
print_config_from_gitmodules() helper
Daniels Umanovskis      ba8ba9df2: branch: introduce --show-current 
display option
Liam Beguin      0cce4a275: rebase -i -x: add exec commands via the 
rebase--helper
Linus Torvalds      74e8221b5: Add 'human' date format
Martin Koegler      5efde212f: zlib.c: use size_t for size
Rasmus Villemoes      a9a60b94c: git.c: handle_alias: prepend alias info 
when first argument is -h
Rasmus Villemoes      e6e76baaf: help: redirect to aliased commands for 
"git cmd --help"

Uncovered code in 'jch' (22f2f0f) and not in 'next' (152ad8e)
-------------------------------------------------------------
apply.c
eccb5a5f3d 4071) return get_oid_hex(p->old_oid_prefix, oid);

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

packfile.c
1127a98cce  117) return error("index file %s is too small", path);
1127a98cce  119) return error("empty data");

prio-queue.c
2d181390f3 94) return queue->array[queue->nr - 1].data;

rebase-interactive.c
64a43cbd5d 62) return error_errno(_("could not read '%s'."), todo_file);
64a43cbd5d 66) strbuf_release(&buf);
64a43cbd5d 67) return -1;
a9f5476fbc 75) return error_errno(_("could not read '%s'."), todo_file);
a9f5476fbc 79) strbuf_release(&buf);
a9f5476fbc 80) return -1;
64a43cbd5d 86) return -1;

revision.c
4943d28849 2931) return;
4943d28849 2934) return;
4943d28849 2937) c->object.flags |= UNINTERESTING;
4943d28849 2940) return;
4943d28849 2943) mark_parents_uninteresting(c);
4943d28849 2966) return;
4943d28849 2969) return;
4943d28849 2974) return;
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

split-index.c
e3d837989e 335) ce->ce_flags |= CE_UPDATE_IN_BASE;

strbuf.c
f95736288a  127) --sb->len;

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
brian m. carlson      2f0c9e9a9: builtin/repack: replace hard-coded 
constants
brian m. carlson      eccb5a5f3: apply: rename new_sha1_prefix and 
old_sha1_prefix
Derrick Stolee      2d181390f: prio-queue: add 'peek' operation
Derrick Stolee      4943d2884: revision.c: refactor basic topo-order logic
Derrick Stolee      6c04ff300: revision.c: begin refactoring 
--topo-order logic
Joel Teichroeb      3d5ec65ce: stash: convert apply to builtin
Joel Teichroeb      5bf62a19c: stash: convert pop to builtin
Joel Teichroeb      700577117: stash: convert drop and clear to builtin
Johannes Schindelin      71f82465b: rebase -i: introduce the 'break' command
Johannes Schindelin      bc24382c2: builtin rebase: prepare for builtin 
rebase -i
Josh Steadmon      1127a98cc: fuzz: add fuzz testing for packfile indices.
Junio C Hamano      7bbc53a58: fetch: replace string-list used as a 
look-up table with a hashmap
Paul-Sebastian Ungureanu      104eb50d1: stash: convert show to builtin
Paul-Sebastian Ungureanu      193c3e351: stash: convert 
`stash--helper.c` into `stash.c`
Paul-Sebastian Ungureanu      1a0f0409a: stash: convert push to builtin
Paul-Sebastian Ungureanu      813904a0c: stash: convert store to builtin
Paul-Sebastian Ungureanu      9f630e748: stash: convert create to builtin
Paul-Sebastian Ungureanu      c2cc69f19: stash: make push -q quiet
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
SZEDER Gábor      e3d837989: split-index: don't compare cached data of 
entries already marked for split index


Uncovered code in 'next' (152ad8e) and not in 'master' (5a0cc8a)
----------------------------------------------------------------
blame.c
a470beea39  113)  !strcmp(r->index->cache[-1 - pos]->name, path))
a470beea39  272) int pos = index_name_pos(r->index, path, len);
a470beea39  274) mode = r->index->cache[pos]->ce_mode;

builtin/am.c
2abf350385 1414) repo_init_revisions(the_repository, &rev_info, NULL);

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

builtin/pack-objects.c
2fa233a554 builtin/pack-objects.c 1512) hashcpy(base_oid.hash, base_sha1);
2fa233a554 builtin/pack-objects.c 1513) if 
(!in_same_island(&delta->idx.oid, &base_oid))
2fa233a554 builtin/pack-objects.c 1514) return 0;

builtin/rev-list.c
7c0fe330d5 builtin/rev-list.c 227) die("unexpected missing %s object '%s'",
7c0fe330d5 builtin/rev-list.c 228)     type_name(obj->type), 
oid_to_hex(&obj->oid));

builtin/upload-archive.c
e001fd3a50 builtin/upload-archive.c 111) if (version == protocol_v0 || 
version == protocol_v1)
e001fd3a50 builtin/upload-archive.c 112) packet_write_fmt(1, "NACK 
unable to spawn subprocess\n");
e001fd3a50 builtin/upload-archive.c 113) else if (version == protocol_v2)
e001fd3a50 builtin/upload-archive.c 114) error_clnt("unable to spawn 
subprocess\n");

commit-graph.c
5cef295f28   67) return 0;
20fd6d5799   79) return 0;

config.c
c780b9cfe8 2298) return val;
c780b9cfe8 2301) if (is_bool)
c780b9cfe8 2302) return val ? 0 : 1;
c780b9cfe8 2304) return val;

diff.c
b78ea5fc35 4130) add_external_diff_name(o->repo, &argv, other, two);

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
list-objects.c
f447a499db 197) ctx->show_object(obj, base->buf, ctx->show_data);

midx.c
e43d2dcce1  285) if (hasheq(oid.hash,
e43d2dcce1  286)    p->bad_object_sha1 + the_hash_algo->rawsz * i))

oidset.c
8b2f8cbcb1 29) kh_del_oid(&set->set, pos);
8b2f8cbcb1 30) return 1;

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

refs.c
4a6067cda5 1405) return 0;

revision.c
2abf350385 1525) if (ce_path_match(istate, ce, &revs->prune_data, NULL)) {
2abf350385 1531) while ((i+1 < istate->cache_nr) &&
2abf350385 1532)        ce_same_name(ce, istate->cache[i+1]))

transport-helper.c
fb19d32f05  643) if (!data->connect && !data->stateless_connect)

transport.c
wt-status.c
f3bd35fa0d  671) s->committable = 1;
73ba5d78b4 1953) if (s->state.rebase_in_progress ||
73ba5d78b4 1954)     s->state.rebase_interactive_in_progress)
73ba5d78b4 1955) branch_name = s->state.onto;
73ba5d78b4 1956) else if (s->state.detached_from)
73ba5d78b4 1957) branch_name = s->state.detached_from;

Commits introducing uncovered code:
Ben Peart      3255089ad: ieot: add Index Entry Offset Table (IEOT) 
extension
Ben Peart      3b1d9e045: eoie: add End of Index Entry (EOIE) extension
Ben Peart      77ff1127a: read-cache: load cache entries on worker threads
Ben Peart      abb4bb838: read-cache: load cache extensions on a worker 
thread
Ben Peart      c780b9cfe: config: add new index.threads config setting
Derrick Stolee      20fd6d579: commit-graph: not compatible with grafts
Derrick Stolee      5cef295f2: commit-graph: not compatible with 
uninitialized repo
Jeff King      2fa233a55: pack-objects: handle island check for 
"external" delta base
Jeff King      e43d2dcce: more oideq/hasheq conversions
Jonathan Nieder      302997027: gc: do not return error for prior errors 
in daemonized mode
Jonathan Nieder      fec2ed218: gc: exit with status 128 on failure
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
Nguyễn Thái Ngọc Duy      252d079cb: read-cache.c: optimize reading 
index format v4
Nguyễn Thái Ngọc Duy      26c7d0678: help -a: improve and make --verbose 
default
Nguyễn Thái Ngọc Duy      2abf35038: revision.c: remove implicit 
dependency on the_index
Nguyễn Thái Ngọc Duy      a470beea3: blame.c: rename "repo" argument to "r"
Nguyễn Thái Ngọc Duy      ae9af1228: status: show progress bar if 
refreshing the index takes too long
Nguyễn Thái Ngọc Duy      b78ea5fc3: diff.c: reduce implicit dependency 
on the_index
René Scharfe      8b2f8cbcb: oidset: use khash
Stefan Beller      4a6067cda: refs.c: migrate internal ref iteration to 
pass thru repository argument
Stephen P. Smith      73ba5d78b: roll wt_status_state into wt_status and 
populate in the collect phase
Stephen P. Smith      f3bd35fa0: wt-status.c: set the committable flag 
in the collect phase


Uncovered code in 'master' (5a0cc8a) and not in (fe8321ec05)
-----------------------------------------------------------------
builtin/fsck.c
66ec0390e7 builtin/fsck.c 862) midx_argv[2] = "--object-dir";
66ec0390e7 builtin/fsck.c 863) midx_argv[3] = alt->path;
66ec0390e7 builtin/fsck.c 864) if (run_command(&midx_verify))
66ec0390e7 builtin/fsck.c 865) errors_found |= ERROR_COMMIT_GRAPH;

fsck.c
fb8952077d  214) die_errno("Could not read '%s'", path);

midx.c
56ee7ff156  949) return 0;
cc6af73c02  990) midx_report(_("failed to load pack-index for packfile %s"),
cc6af73c02  991)     e.p->pack_name);
cc6af73c02  992) break;

Commits introducing uncovered code:
Derrick Stolee      56ee7ff15: multi-pack-index: add 'verify' verb
Derrick Stolee      66ec0390e: fsck: verify multi-pack-index
Derrick Stolee      cc6af73c0: multi-pack-index: verify object offsets
René Scharfe      fb8952077: fsck: use strbuf_getline() to read skiplist 
file


[1] https://dev.azure.com/git/git/_build/results?buildId=184&view=results
     Build running coverage-test for 'pu' and coverage-diff.sh against 'jch'

[2] https://dev.azure.com/git/git/_build/results?buildId=185&view=results
     Build running coverage-test for 'jch' and coverage-diff.sh against 
'next'

[3] https://dev.azure.com/git/git/_build/results?buildId=186&view=results
     Build running coverage-test for 'next' and coverage-diff.sh against 
'master'

[4] https://dev.azure.com/git/git/_build/results?buildId=187&view=logs
     Build running coverage-test for 'master' and coverage-diff.sh 
against 'master@{1}'
