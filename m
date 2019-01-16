Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 306141F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 18:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfAPSWh (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 13:22:37 -0500
Received: from mail-qt1-f174.google.com ([209.85.160.174]:45618 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728453AbfAPSWg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 13:22:36 -0500
Received: by mail-qt1-f174.google.com with SMTP id e5so8248220qtr.12
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 10:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=ax4TW2iuQtWyejD+/Nu5jVdQr7fj6/J4tlJbBX6cT14=;
        b=F3mEqXYvmYDSgcbmOpRJi7BzgLIwhGt1lflrHNXLUPTaJLN68+0W2ZFruSBwffsNvn
         9XnjNLAMrJ+AKaUASQVVXz9aQ8qmhqrSvDMUqm5FTheWdO+b93zibQrwfuSnpJ+BM2R/
         En1K/Nt8XUst+UxyClmm3/rl6TMANlJUX3Q1fEGCEY7eOHDcQf4nuWPQgijIgwe42Uej
         c1A1JSGtspCw7u7npXEb2NUOCjHYEDxRnvgh8eHc7nEMYKyJyMrlWIrKIZW5UatnEVuY
         wKnBFIUM0hEGEOaC2b0q2TmYMD+66yekIO8Rs5mgvs3cSoZc/lhd7v6A8JbAgEEOzJa2
         GzNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=ax4TW2iuQtWyejD+/Nu5jVdQr7fj6/J4tlJbBX6cT14=;
        b=rNH8puoetXbLp18OMBuxU1AAiJsq+18jmnJ9Wxav0rmGjSFqlvZmGABiBFtKTqJYAD
         LvZZQpLuhDNjBx7oRoLxx5/QGmvKiikrPl1hOF8/MZjTCY3AvRB/EEGCIcymD/mTDxth
         niWL9kU/48yAlU9+mdFZOsK684/THMqy66iWevMPgZUgekbkD1AeE6nGw/T96l8yWalP
         NcFoqYkMK7SSUcIcv2ICm5yoiRkx9bpx6NN7xohT/slymi49RfErL+TqPnYPMxr9crQK
         pznU+FcTukI+dCPyHmdf9Zu78MyiQkmZanQ9iRYfku2iji/dcywv7ZZguXLv/CSNGMR8
         Dtfg==
X-Gm-Message-State: AJcUukf4NyjxZus88jHD7ilzD4rfcsSh6E7zUYEFcUf1okRUJDwoGkoH
        P66WYZKQcs9n3jL9us0CueKxrHfM
X-Google-Smtp-Source: ALg8bN5Pyuq12ihz8qgIVpAiNbQ1x0AaVLC7TTBB8hZpdZ5mX8rEUjCmLpL10LYh5SKA2Ykm3uYxdg==
X-Received: by 2002:ac8:4454:: with SMTP id m20mr7912418qtn.381.1547662952555;
        Wed, 16 Jan 2019 10:22:32 -0800 (PST)
Received: from [10.0.1.15] ([98.122.160.2])
        by smtp.gmail.com with ESMTPSA id l51sm51659576qtk.11.2019.01.16.10.22.31
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 10:22:31 -0800 (PST)
To:     GIT Mailing-list <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (Wed Jan 16)
Message-ID: <6d0c229d-70ab-3d2a-1093-983cb5091af0@gmail.com>
Date:   Wed, 16 Jan 2019 13:22:30 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is today's test coverage report.

Thanks,
-Stolee

[1] https://dev.azure.com/git/git/_build/results?buildId=303

---

pu: 8df4a8d850bb2115f6e24d1e45a2d58700f66ece
jch: 7529c1c1876fbd86faf08d8e45080e5bdde0ca9a
next: 40155ab247a57ccc696d2ded09336b2c5203e832
master: 77556354bb7ac50450e3b28999e3576969869068
master@{1}: ecbdaf0899161c067986e9d9d564586d4b045d62

Uncovered code in 'pu' not in 'jch'
--------------------------------------

bisect.c
9192bb22fd  661) mark_edges_uninteresting(revs, NULL, 0);

builtin/blame.c
080448fbe8 builtin/blame.c    930) blame_date_width = sizeof("Thu Oct 19 
16:00");
080448fbe8 builtin/blame.c    931) break;

builtin/config.c
a12c1ff3a5 builtin/config.c      110) die(_("$HOME not set"));
a12c1ff3a5 builtin/config.c      122) given_config_source.file = 
git_etc_gitconfig();
6f11fd5edb builtin/config.c      503) die(_("unknown config source"));
6f11fd5edb builtin/config.c      509) die(_("invalid key pattern: %s"), 
key);

builtin/diff-tree.c
e1ff0a32e4 builtin/diff-tree.c 169) repo_read_index(the_repository);

builtin/pack-redundant.c
a338d10395 builtin/pack-redundant.c 347) return 0;
cb7e0336fc builtin/pack-redundant.c 461) 
llist_sorted_difference_inplace(all_objects, pl->remaining_objects);
cb7e0336fc builtin/pack-redundant.c 490) 
llist_sorted_difference_inplace(all_objects, alt->remaining_objects);

builtin/rebase--interactive.c
e5b1c9d929 builtin/rebase--interactive.c   24) return 
error_errno(_("could not read '%s'."), todo_file);
e5b1c9d929 builtin/rebase--interactive.c   31) return 
error_errno(_("could not write '%s'"), todo_file);
4d55dfd767 builtin/rebase--interactive.c   46) return 
error_errno(_("could not read '%s'."), todo_file);
4d55dfd767 builtin/rebase--interactive.c   50) 
todo_list_release(&todo_list);
4d55dfd767 builtin/rebase--interactive.c   51) return error(_("unusable 
todo list: '%s'"), todo_file);
4d55dfd767 builtin/rebase--interactive.c   59) return 
error_errno(_("could not write '%s'."), todo_file);
febebd99b6 builtin/rebase--interactive.c  313) ret = 
rearrange_squash_in_todo_file(the_repository);
8414c890aa builtin/rebase--interactive.c  316) ret = 
sequencer_add_exec_commands(the_repository, &commands);

builtin/stash.c
f6bbd78127 builtin/stash--helper.c  128) die(_("'%s' is not a stash-like 
commit"), revision);
f6bbd78127 builtin/stash--helper.c  161) free_stash_info(info);
f6bbd78127 builtin/stash--helper.c  162) fprintf_ln(stderr, _("No stash 
entries found."));
f6bbd78127 builtin/stash--helper.c  163) return -1;
f6bbd78127 builtin/stash--helper.c  198) free_stash_info(info);
cdca49bc4c builtin/stash--helper.c  225) return error(_("git stash clear 
with parameters is "
f6bbd78127 builtin/stash--helper.c  241) return -1;
f6bbd78127 builtin/stash--helper.c  249) return -1;
f6bbd78127 builtin/stash--helper.c  262) return -1;
f6bbd78127 builtin/stash--helper.c  265) return error(_("unable to write 
new index file"));
f6bbd78127 builtin/stash--helper.c  377) remove_path(stash_index_path.buf);
f6bbd78127 builtin/stash--helper.c  378) return -1;
f6bbd78127 builtin/stash--helper.c  405) return -1;
f6bbd78127 builtin/stash--helper.c  408) return error(_("cannot apply a 
stash in the middle of a merge"));
f6bbd78127 builtin/stash--helper.c  418) strbuf_release(&out);
f6bbd78127 builtin/stash--helper.c  419) return error(_("could not 
generate diff %s^!."),
f6bbd78127 builtin/stash--helper.c  426) return error(_("conflicts in 
index."
f6bbd78127 builtin/stash--helper.c  432) return error(_("could not save 
index tree"));
f6bbd78127 builtin/stash--helper.c  439) return error(_("could not 
restore untracked files from stash"));
f6bbd78127 builtin/stash--helper.c  470) return -1;
f6bbd78127 builtin/stash--helper.c  475) strbuf_release(&out);
f6bbd78127 builtin/stash--helper.c  480) strbuf_release(&out);
f6bbd78127 builtin/stash--helper.c  481) return -1;
cdca49bc4c builtin/stash--helper.c  557) return error(_("%s: Could not 
drop stash entry"),
e1d01876a4 builtin/stash--helper.c  632) printf_ln(_("The stash entry is 
kept in case "
b4493f269e builtin/stash--helper.c  766) free_stash_info(&info);
51809c70ca builtin/stash.c          767) 
usage_with_options(git_stash_show_usage, options);
847eb0b0a8 builtin/stash--helper.c  783) stash_msg = "Created via \"git 
stash store\".";
847eb0b0a8 builtin/stash--helper.c  789) if (!quiet) {
847eb0b0a8 builtin/stash--helper.c  790) fprintf_ln(stderr, _("Cannot 
update %s with %s"),
847eb0b0a8 builtin/stash--helper.c  793) return -1;
847eb0b0a8 builtin/stash--helper.c  817) if (!quiet)
847eb0b0a8 builtin/stash--helper.c  818) fprintf_ln(stderr, _("\"git 
stash store\" requires one "
847eb0b0a8 builtin/stash--helper.c  820) return -1;
1f5a011d90 builtin/stash--helper.c  903) return -1;
1f5a011d90 builtin/stash--helper.c  963) ret = -1;
1f5a011d90 builtin/stash--helper.c  964) goto done;
1f5a011d90 builtin/stash--helper.c  969) ret = -1;
1f5a011d90 builtin/stash--helper.c  970) goto done;
1f5a011d90 builtin/stash--helper.c  975) ret = -1;
1f5a011d90 builtin/stash--helper.c  976) goto done;
1f5a011d90 builtin/stash--helper.c 1002) ret = -1;
1f5a011d90 builtin/stash--helper.c 1003) goto done;
1f5a011d90 builtin/stash--helper.c 1014) ret = -1;
1f5a011d90 builtin/stash--helper.c 1015) goto done;
1f5a011d90 builtin/stash--helper.c 1021) ret = -1;
1f5a011d90 builtin/stash--helper.c 1022) goto done;
1f5a011d90 builtin/stash--helper.c 1029) ret = -1;
1f5a011d90 builtin/stash--helper.c 1030) goto done;
1f5a011d90 builtin/stash--helper.c 1055) ret = -1;
1f5a011d90 builtin/stash--helper.c 1056) goto done;
1f5a011d90 builtin/stash--helper.c 1067) ret = -1;
1f5a011d90 builtin/stash--helper.c 1068) goto done;
1f5a011d90 builtin/stash--helper.c 1074) ret = -1;
1f5a011d90 builtin/stash--helper.c 1075) goto done;
1f5a011d90 builtin/stash--helper.c 1086) ret = -1;
1f5a011d90 builtin/stash--helper.c 1087) goto done;
1f5a011d90 builtin/stash--helper.c 1092) ret = -1;
1f5a011d90 builtin/stash--helper.c 1093) goto done;
9a95010a11 builtin/stash--helper.c 1129) fprintf_ln(stderr, _("You do 
not have "
1f5a011d90 builtin/stash--helper.c 1138) ret = 1;
1f5a011d90 builtin/stash--helper.c 1139) goto done;
9a95010a11 builtin/stash--helper.c 1155) if (!quiet)
9a95010a11 builtin/stash--helper.c 1156) fprintf_ln(stderr, _("Cannot 
save the current "
1f5a011d90 builtin/stash--helper.c 1158) ret = -1;
1f5a011d90 builtin/stash--helper.c 1159) goto done;
9a95010a11 builtin/stash--helper.c 1164) if (!quiet)
9a95010a11 builtin/stash--helper.c 1165) fprintf_ln(stderr, _("Cannot save "
1f5a011d90 builtin/stash--helper.c 1167) ret = -1;
1f5a011d90 builtin/stash--helper.c 1168) goto done;
9a95010a11 builtin/stash--helper.c 1175) if (!quiet)
9a95010a11 builtin/stash--helper.c 1176) fprintf_ln(stderr, _("Cannot 
save the current "
1f5a011d90 builtin/stash--helper.c 1178) goto done;
9a95010a11 builtin/stash--helper.c 1184) if (!quiet)
9a95010a11 builtin/stash--helper.c 1185) fprintf_ln(stderr, _("Cannot 
save the current "
1f5a011d90 builtin/stash--helper.c 1187) ret = -1;
1f5a011d90 builtin/stash--helper.c 1188) goto done;
9a95010a11 builtin/stash--helper.c 1212) if (!quiet)
9a95010a11 builtin/stash--helper.c 1213) fprintf_ln(stderr, _("Cannot 
record "
1f5a011d90 builtin/stash--helper.c 1215) ret = -1;
1f5a011d90 builtin/stash--helper.c 1216) goto done;
fa38428f76 builtin/stash--helper.c 1285) ret = -1;
fa38428f76 builtin/stash--helper.c 1286) goto done;
fa38428f76 builtin/stash--helper.c 1296) ret = -1;
9a95010a11 builtin/stash--helper.c 1297) if (!quiet)
9a95010a11 builtin/stash--helper.c 1298) fprintf_ln(stderr, _("Cannot 
initialize stash"));
fa38428f76 builtin/stash--helper.c 1299) goto done;
fa38428f76 builtin/stash--helper.c 1311) ret = -1;
9a95010a11 builtin/stash--helper.c 1312) if (!quiet)
9a95010a11 builtin/stash--helper.c 1313) fprintf_ln(stderr, _("Cannot 
save the current status"));
fa38428f76 builtin/stash--helper.c 1314) goto done;
fa38428f76 builtin/stash--helper.c 1331) ret = -1;
fa38428f76 builtin/stash--helper.c 1350) ret = -1;
fa38428f76 builtin/stash--helper.c 1351) goto done;
fa38428f76 builtin/stash--helper.c 1360) ret = -1;
fa38428f76 builtin/stash--helper.c 1361) goto done;
fa38428f76 builtin/stash--helper.c 1369) ret = -1;
fa38428f76 builtin/stash--helper.c 1378) ret = -1;
fa38428f76 builtin/stash--helper.c 1389) ret = -1;
fa38428f76 builtin/stash--helper.c 1390) goto done;
fa38428f76 builtin/stash--helper.c 1399) ret = -1;
fa38428f76 builtin/stash--helper.c 1400) goto done;
fa38428f76 builtin/stash--helper.c 1408) ret = -1;
fa38428f76 builtin/stash--helper.c 1434) ret = -1;
bec65d5b78 builtin/stash.c         1526) return env;
26799a208f builtin/stash.c         1554) const char *path = 
mkpath("%s/git-legacy-stash",
26799a208f builtin/stash.c         1557) if (sane_execvp(path, (char 
**)argv) < 0)
26799a208f builtin/stash.c         1558) die_errno(_("could not exec 
%s"), path);
51809c70ca builtin/stash.c         1601) 
usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
51809c70ca builtin/stash.c         1629) continue;

config.c
8f7c7f5555 2147) int repo_config_set_gently(struct repository *r,
8f7c7f5555 2150) char *path = repo_git_path(r, "config");
8f7c7f5555 2151) int ret = git_config_set_multivar_in_file_gently(path, 
key, value, NULL, 0);
8f7c7f5555 2152) free(path);
8f7c7f5555 2153) return ret;
8f7c7f5555 2156) void repo_config_set(struct repository *r, const char 
*key, const char *value)
8f7c7f5555 2158) if (!repo_config_set_gently(r, key, value))
8f7c7f5555 2159) return;
8f7c7f5555 2160) if (value)
8f7c7f5555 2161) die(_("could not set '%s' to '%s'"), key, value);
8f7c7f5555 2163) die(_("could not unset '%s'"), key);
8f7c7f5555 2166) int repo_config_set_worktree_gently(struct repository *r,
8f7c7f5555 2172) path = get_worktree_config(r);
8f7c7f5555 2173) if (!path)
8f7c7f5555 2174) return CONFIG_INVALID_FILE;
8f7c7f5555 2175) ret = git_config_set_multivar_in_file_gently(path, key, 
value, NULL, 0);
8f7c7f5555 2176) free(path);
8f7c7f5555 2177) return ret;

date.c
080448fbe8  113) die("Timestamp too large for this system: %"PRItime, time);
080448fbe8  223) hide.date = 1;
080448fbe8  886) static int auto_date_style(void)
080448fbe8  888) return (isatty(1) || pager_in_use()) ? DATE_HUMAN : 
DATE_NORMAL;
080448fbe8  911) return auto_date_style();

list-objects.c
9192bb22fd 241) continue;
9192bb22fd 250) parent->object.flags |= SHOWN;
9192bb22fd 251) show_edge(parent);
9192bb22fd 272) tree->object.flags |= UNINTERESTING;
9192bb22fd 287) commit->object.flags |= SHOWN;
9192bb22fd 288) show_edge(commit);

merge-recursive.c
0d6caa2d08  433) for (i = 0; i < istate->cache_nr; i++) {
0d6caa2d08  434) const struct cache_entry *ce = istate->cache[i];
0d6caa2d08  443) istate->cache_tree = cache_tree();
0d6caa2d08  733) ce = index_file_exists(o->repo->index, path, strlen(path),
0d6caa2d08 3193) remove_file_from_index(o->repo->index, path);

pretty.c
4681fe38e1 1069) return 0;
b755bf6f83 1107)     match_placeholder_arg(p, "=on", end) ||
b755bf6f83 1108)     match_placeholder_arg(p, "=true", end)) {

protocol.c
6da1f1a920  37) die(_("Unrecognized protocol version"));
6da1f1a920  39) die(_("Unrecognized protocol_version"));

rebase-interactive.c
c27b32f0ec  26) warning(_("unrecognized setting %s for option "
e5b1c9d929 102) return error(_("could not copy '%s' to '%s'."), todo_file,
c27b32f0ec 164) goto leave_check;

remote-curl.c
6da1f1a920  344) return 0;
34a9469d6a  373) die("invalid server response; expected service, got 
flush packet");
34a9469d6a  397) d->proto_git = 1;

repository.c
revision.c
9949aaeef4  169) return;
9949aaeef4  172) return;
9949aaeef4  195) break;
8446350be2  218) continue;

sequencer.c
e1ff0a32e4 3950) res = error_dirty_index(r, opts);
8414c890aa 4571) int sequencer_add_exec_commands(struct repository *r,
8414c890aa 4579) return error_errno(_("could not read '%s'."), todo_file);
8414c890aa 4581) if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, 
&todo_list)) {
8414c890aa 4586) todo_list_add_exec_commands(&todo_list, commands);
8414c890aa 4587) res = todo_list_write_to_file(r, &todo_list, todo_file, 
NULL, NULL, -1, 0);
0cce4a2756 4588) todo_list_release(&todo_list);
8414c890aa 4590) if (res)
8414c890aa 4591) return error_errno(_("could not write '%s'."), todo_file);
8414c890aa 4592) return 0;
cf18b3f6c9 4626) strbuf_addstr(buf, " -c");
878056005e 4673) res = -1;
c27b32f0ec 4674) goto out;
c27b32f0ec 4679) goto out;
c27b32f0ec 4688) fprintf(stderr, _(edit_todo_list_advice));
98b29e0607 4806) todo_list_release(&new_todo);
c1c074e0cc 4812) todo_list_release(&new_todo);
c1c074e0cc 4813) return error_errno(_("could not write '%s'"), todo_file);
febebd99b6 4990) int rearrange_squash_in_todo_file(struct repository *r)
febebd99b6 4992) const char *todo_file = rebase_path_todo();
febebd99b6 4993) struct todo_list todo_list = TODO_LIST_INIT;
febebd99b6 4994) int res = 0;
febebd99b6 4996) if (strbuf_read_file_or_whine(&todo_list.buf, 
todo_file) < 0)
febebd99b6 4997) return -1;
febebd99b6 4998) if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, 
&todo_list) < 0) {
febebd99b6 4999) todo_list_release(&todo_list);
febebd99b6 5000) return -1;
febebd99b6 5003) res = todo_list_rearrange_squash(&todo_list);
febebd99b6 5004) if (!res)
febebd99b6 5005) res = todo_list_write_to_file(r, &todo_list, todo_file, 
NULL, NULL, -1, 0);
febebd99b6 5007) todo_list_release(&todo_list);
febebd99b6 5009) if (res)
febebd99b6 5010) return error_errno(_("could not write '%s'."), todo_file);
febebd99b6 5011) return 0;

strbuf.c
bfc3fe33f6  259) die("`pos' is too far after the end of the buffer");
bfc3fe33f6  266) return; /* nothing to do */
bfc3fe33f6  268) die("you want to use way too much memory");
18f8e81091  448) return 0;

wrapper.c
5efde212fc  70) die("Out of memory, malloc failed (tried to allocate %" 
PRIuMAX " bytes)",
5efde212fc  73) error("Out of memory, malloc failed (tried to allocate 
%" PRIuMAX " bytes)",

Commits introducing uncovered code:
Alban Gruin      4d55dfd76: rebase-interactive: move 
transform_todo_file() to rebase--interactive.c
Alban Gruin      8414c890a: sequencer: refactor 
sequencer_add_exec_commands() to work on a todo_list
Alban Gruin      98b29e060: sequencer: refactor skip_unnecessary_picks() 
to work on a todo_list
Alban Gruin      c1c074e0c: sequencer: change complete_action() to use 
the refactored functions
Alban Gruin      c27b32f0e: sequencer: refactor check_todo_list() to 
work on a todo_list
Alban Gruin      cf18b3f6c: sequencer: introduce todo_list_write_to_file()
Alban Gruin      e5b1c9d92: rebase-interactive: rewrite edit_todo_list() 
to handle the initial edit
Alban Gruin      febebd99b: sequencer: refactor rearrange_squash() to 
work on a todo_list
Anders Waldenborg      18f8e8109: strbuf: separate callback for 
strbuf_expand:ing literals
Anders Waldenborg      4681fe38e: pretty: allow showing specific trailers
Anders Waldenborg      b755bf6f8: pretty: allow %(trailers) options with 
explicit value
Derrick Stolee      8446350be: revision: add mark_tree_uninteresting_sparse
Derrick Stolee      9192bb22f: list-objects: consume sparse tree walk
Derrick Stolee      9949aaeef: revision: implement sparse algorithm
Jeff King      34a9469d6: remote-curl: refactor smart-http discovery
Jiang Xin      a338d1039: pack-redundant: consistent sort method
Jiang Xin      cb7e0336f: pack-redundant: rename pack_list.all_objects
Joel Teichroeb      cdca49bc4: stash: convert drop and clear to builtin
Joel Teichroeb      e1d01876a: stash: convert pop to builtin
Joel Teichroeb      f6bbd7812: stash: convert apply to builtin
Johannes Schindelin      26799a208: stash: optionally use the scripted 
version again
Johannes Schindelin      bec65d5b7: tests: add a special setup where 
stash.useBuiltin is off
Josh Steadmon      6da1f1a92: protocol: advertise multiple supported 
versions
Liam Beguin      0cce4a275: rebase -i -x: add exec commands via the 
rebase--helper
Linus Torvalds      080448fbe: Add 'human' date format
Martin Koegler      5efde212f: zlib.c: use size_t for size
Nguyễn Thái Ngọc Duy      0d6caa2d0: merge-recursive.c: remove implicit 
dependency on the_index
Nguyễn Thái Ngọc Duy      6f11fd5ed: config: add --move-to
Nguyễn Thái Ngọc Duy      8f7c7f555: config.c: add 
repo_config_set_worktree_gently()
Nguyễn Thái Ngọc Duy      a12c1ff3a: config: factor out 
set_config_source_file()
Nguyễn Thái Ngọc Duy      e1ff0a32e: read-cache.c: kill read_index()
Paul-Sebastian Ungureanu      1f5a011d9: stash: convert create to builtin
Paul-Sebastian Ungureanu      51809c70c: stash: convert 
`stash--helper.c` into `stash.c`
Paul-Sebastian Ungureanu      847eb0b0a: stash: convert store to builtin
Paul-Sebastian Ungureanu      9a95010a1: stash: make push -q quiet
Paul-Sebastian Ungureanu      b4493f269: stash: convert show to builtin
Paul-Sebastian Ungureanu      bfc3fe33f: strbuf.c: add 
`strbuf_insertf()` and `strbuf_vinsertf()`
Paul-Sebastian Ungureanu      fa38428f7: stash: convert push to builtin
René Scharfe      878056005: sequencer: factor out 
strbuf_read_file_or_whine()



Uncovered code in 'jch' not in 'next'
----------------------------------------

builtin/archive.c
01f9ec64c8 builtin/archive.c  63) if (starts_with(reader.line, "NACK "))
01f9ec64c8 builtin/archive.c  64) die(_("git archive: NACK %s"), 
reader.line + 5);

builtin/bisect--helper.c
5e82c3dd22 builtin/bisect--helper.c 162) if (get_oid_commit(commit, &oid))
5e82c3dd22 builtin/bisect--helper.c 163) return error(_("'%s' is not a 
valid commit"), commit);
5e82c3dd22 builtin/bisect--helper.c 164) strbuf_addstr(&branch, commit);
5e82c3dd22 builtin/bisect--helper.c 172) strbuf_release(&branch);
5e82c3dd22 builtin/bisect--helper.c 173) argv_array_clear(&argv);
5e82c3dd22 builtin/bisect--helper.c 174) return error(_("could not check 
out original"
0f30233a11 builtin/bisect--helper.c 215) retval = error(_("Bad 
bisect_write argument: %s"), state);
0f30233a11 builtin/bisect--helper.c 216) goto finish;
0f30233a11 builtin/bisect--helper.c 220) retval = error(_("couldn't get 
the oid of the rev '%s'"), rev);
0f30233a11 builtin/bisect--helper.c 221) goto finish;
0f30233a11 builtin/bisect--helper.c 226) retval = -1;
0f30233a11 builtin/bisect--helper.c 227) goto finish;
0f30233a11 builtin/bisect--helper.c 232) retval = 
error_errno(_("couldn't open the file '%s'"), git_path_bisect_log());
0f30233a11 builtin/bisect--helper.c 233) goto finish;
129a6cf344 builtin/bisect--helper.c 329) yesno = git_prompt(_("Are you 
sure [Y/n]? "), PROMPT_ECHO);
129a6cf344 builtin/bisect--helper.c 330) if (starts_with(yesno, "N") || 
starts_with(yesno, "n"))
129a6cf344 builtin/bisect--helper.c 331) retval = -1;
129a6cf344 builtin/bisect--helper.c 332) goto finish;
129a6cf344 builtin/bisect--helper.c 338) retval = 
error(_(need_bisect_start_warning),
450ebb7359 builtin/bisect--helper.c 389) return error(_("invalid 
argument %s for 'git bisect terms'.\n"
06f5608c14 builtin/bisect--helper.c 404) return -1;
06f5608c14 builtin/bisect--helper.c 407) retval = -1;
06f5608c14 builtin/bisect--helper.c 408) goto finish;
06f5608c14 builtin/bisect--helper.c 413) retval = -1;
06f5608c14 builtin/bisect--helper.c 452) no_checkout = 1;
06f5608c14 builtin/bisect--helper.c 474)  !one_of(arg, "--term-good", 
"--term-bad", NULL)) {
06f5608c14 builtin/bisect--helper.c 475) return error(_("unrecognized 
option: '%s'"), arg);
06f5608c14 builtin/bisect--helper.c 510) if (get_oid("HEAD", &head_oid))
06f5608c14 builtin/bisect--helper.c 511) return error(_("bad HEAD - I 
need a HEAD"));
06f5608c14 builtin/bisect--helper.c 526) retval = error(_("checking out 
'%s' failed."
06f5608c14 builtin/bisect--helper.c 547) return error(_("won't bisect on 
cg-seek'ed tree"));
06f5608c14 builtin/bisect--helper.c 550) return error(_("bad HEAD - 
strange symbolic ref"));
06f5608c14 builtin/bisect--helper.c 558) return -1;
06f5608c14 builtin/bisect--helper.c 576) retval = -1;
06f5608c14 builtin/bisect--helper.c 577) goto finish;
06f5608c14 builtin/bisect--helper.c 588) retval = -1;
06f5608c14 builtin/bisect--helper.c 589) goto finish;
06f5608c14 builtin/bisect--helper.c 600) retval = -1;
5e82c3dd22 builtin/bisect--helper.c 677) return error(_("--bisect-reset 
requires either no argument or a commit"));
0f30233a11 builtin/bisect--helper.c 681) return error(_("--bisect-write 
requires either 4 or 5 arguments"));
4fbdbd5bff builtin/bisect--helper.c 687) return 
error(_("--check-and-set-terms requires 3 arguments"));
129a6cf344 builtin/bisect--helper.c 693) return 
error(_("--bisect-next-check requires 2 or 3 arguments"));

builtin/branch.c
711d28e2e4 builtin/branch.c 370) strbuf_addf(&local, 
"%s%%(if:notequals=*)%%(HEAD)%%(then)%%(if)%%(worktreepath)%%(then)%%(worktreepath) 
%%(end)%%(end)%s",
0ecb1fc726 builtin/branch.c 460) die(_("could not resolve HEAD"));
0ecb1fc726 builtin/branch.c 466) die(_("HEAD (%s) points outside of 
refs/heads/"), refname);

builtin/checkout.c
091e04bc8c builtin/checkout.c  302) return;
091e04bc8c builtin/checkout.c 1268) die(_("'%s' cannot be used with 
switching branches"),

builtin/fetch-pack.c
4316ff3068 builtin/fetch-pack.c 227) get_remote_refs(fd[1], &reader, 
&ref, 0, NULL, NULL);
4316ff3068 builtin/fetch-pack.c 228) break;

builtin/multi-pack-index.c
334e9745a6 49) die(_("--batch-size option is only for 'repack' 
subcommand"));

builtin/pull.c
b19eee9066 647) argv_array_push(&args, opt_cleanup);

builtin/rebase.c
3bd5f07101  258) write_file(state_dir_path("verbose", opts), "%s", "");
3bd5f07101  260) write_file(state_dir_path("strategy", opts), "%s",
3bd5f07101  263) write_file(state_dir_path("strategy_opts", opts), "%s",
3bd5f07101  270) write_file(state_dir_path("gpg_sign_opt", opts), "%s",
3bd5f07101  273) write_file(state_dir_path("strategy", opts), "--signoff");
2ead83aefb  396) ret = -1;
2ead83aefb  397) goto leave_reset_head;
2ead83aefb  401) ret = error(_("could not determine HEAD revision"));
2ead83aefb  402) goto leave_reset_head;
2ead83aefb  423) ret = error(_("could not read index"));
2ead83aefb  424) goto leave_reset_head;
2ead83aefb  428) ret = error(_("failed to find tree of %s"),
2ead83aefb  430) goto leave_reset_head;
2ead83aefb  434) ret = error(_("failed to find tree of %s"), 
oid_to_hex(oid));
2ead83aefb  435) goto leave_reset_head;
2ead83aefb  447) ret = error(_("could not write index"));
2ead83aefb  448) goto leave_reset_head;
2ead83aefb  466) } else if (old_orig)
2ead83aefb  467) delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
3bd5f07101  543) argv_array_push(&am.args, opts->gpg_sign_opt);
3bd5f07101  577) status = error_errno(_("could not write '%s'"),
3bd5f07101  579) free(rebased_patches);
3bd5f07101  580) argv_array_clear(&am.args);
3bd5f07101  581) return status;
3bd5f07101  590) argv_array_split(&format_patch.args,
3bd5f07101  591)  opts->git_format_patch_opt.buf);
3bd5f07101  599) unlink(rebased_patches);
3bd5f07101  600) free(rebased_patches);
3bd5f07101  601) argv_array_clear(&am.args);
3bd5f07101  603) reset_head(&opts->orig_head, "checkout", 
opts->head_name, 0,
3bd5f07101  605) error(_("\ngit encountered an error while preparing the "
3bd5f07101  612) strbuf_release(&revisions);
3bd5f07101  613) return status;
3bd5f07101  619) status = error_errno(_("could not read '%s'"),
3bd5f07101  621) free(rebased_patches);
3bd5f07101  622) argv_array_clear(&am.args);
3bd5f07101  623) return status;
3bd5f07101  635) argv_array_push(&am.args, opts->gpg_sign_opt);
81ef8ee75d  956) return -1;
d421afa0c6 1444) die(_("--reschedule-failed-exec requires an interactive 
rebase"));
d421afa0c6 1476) die(_("error: cannot combine '--preserve-merges' with "

builtin/receive-pack.c
01f9ec64c8 builtin/receive-pack.c 1587)     reader->line + 8);
01f9ec64c8 builtin/receive-pack.c 1621) die("protocol error: got an 
unexpected packet");

builtin/remote.c
f39a9c6547 builtin/remote.c 1551) die(_("--save-to-push cannot be used 
with other options"));
f39a9c6547 builtin/remote.c 1575) die(_("--save-to-push can only be used 
when only one url is defined"));

commit-graph.c
aa658574bf  127) return NULL;
aa658574bf  130) return NULL;
aa658574bf  186) free(graph);
aa658574bf  187) return NULL;
aa658574bf  222) free(graph);
aa658574bf  223) return NULL;

config.c
7e43b32b58 1488) return git_ident_config(var, value, cb);
7e43b32b58 1491) return git_ident_config(var, value, cb);

diff.c
b73bcbac4a  308) ret = 0;
21536d077f  812)        (s[off] == '\r' && off < len - 1))
21536d077f  813) off++;
b73bcbac4a 5112) options->color_moved_ws_handling = 0;

entry.c
fetch-pack.c
01f9ec64c8  154) die(_("git fetch-pack: expected a flush packet after 
shallow list"));
01f9ec64c8  358) die(_("invalid shallow line: %s"), reader.line);
01f9ec64c8  364) die(_("invalid unshallow line: %s"), reader.line);
01f9ec64c8  366) die(_("object not found: %s"), reader.line);
01f9ec64c8  369) die(_("error in object: %s"), reader.line);
01f9ec64c8  371) die(_("no shallow found: %s"), reader.line);
01f9ec64c8  374) die(_("expected shallow/unshallow, got %s"), reader.line);
7d268894d4 1128) packet_buf_write(&req_buf, "sideband-all");
7d268894d4 1350) reader.use_sideband = 1;
7d268894d4 1351) reader.me = "fetch-pack";

hex.c
47edb64997  93) char *sha1_to_hex_r(char *buffer, const unsigned char *sha1)
47edb64997  95) return hash_to_hex_algop_r(buffer, sha1, 
&hash_algos[GIT_HASH_SHA1]);
47edb64997 116) char *hash_to_hex(const unsigned char *hash)
47edb64997 118) return hash_to_hex_algop(hash, the_hash_algo);

http-push.c
ea82b2a085 1314) p = process_tree(lookup_tree(the_repository, &entry.oid),

http-walker.c
514c5fdd03 http-walker.c 550) loose_object_path(the_repository, &buf, 
&req->oid);

http.c
e6cf87b12d 1999) if (fflush(result)) {
e6cf87b12d 2000) error_errno("unable to flush a file");
e6cf87b12d 2001) return HTTP_START_FAILED;
e6cf87b12d 2003) rewind(result);
e6cf87b12d 2004) if (ftruncate(fileno(result), 0) < 0) {
e6cf87b12d 2005) error_errno("unable to truncate a file");
e6cf87b12d 2006) return HTTP_START_FAILED;
e6cf87b12d 2008) break;

ident.c
7e43b32b58 373) email = git_author_email.buf;
7e43b32b58 375) email = git_committer_email.buf;
7e43b32b58 394) name = git_author_name.buf;
7e43b32b58 396) name = git_committer_name.buf;
7e43b32b58 504) if (!value)
7e43b32b58 505) return config_error_nonbool(var);
7e43b32b58 506) strbuf_reset(&git_author_name);
7e43b32b58 507) strbuf_addstr(&git_author_name, value);
7e43b32b58 508) author_ident_explicitly_given |= IDENT_NAME_GIVEN;
7e43b32b58 509) ident_config_given |= IDENT_NAME_GIVEN;
7e43b32b58 510) return 0;
7e43b32b58 514) if (!value)
7e43b32b58 515) return config_error_nonbool(var);
7e43b32b58 516) strbuf_reset(&git_author_email);
7e43b32b58 517) strbuf_addstr(&git_author_email, value);
7e43b32b58 518) author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
7e43b32b58 519) ident_config_given |= IDENT_MAIL_GIVEN;
7e43b32b58 520) return 0;
7e43b32b58 524) if (!value)
7e43b32b58 525) return config_error_nonbool(var);
7e43b32b58 526) strbuf_reset(&git_committer_name);
7e43b32b58 527) strbuf_addstr(&git_committer_name, value);
7e43b32b58 528) committer_ident_explicitly_given |= IDENT_NAME_GIVEN;
7e43b32b58 529) ident_config_given |= IDENT_NAME_GIVEN;
7e43b32b58 530) return 0;
7e43b32b58 534) if (!value)
7e43b32b58 535) return config_error_nonbool(var);
7e43b32b58 536) strbuf_reset(&git_committer_email);
7e43b32b58 537) strbuf_addstr(&git_committer_email, value);
7e43b32b58 538) committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
7e43b32b58 539) ident_config_given |= IDENT_MAIL_GIVEN;
7e43b32b58 540) return 0;

list-objects-filter.c
c813a7c35f 199) return;

match-trees.c
f55ac4311a 231) hashcpy(tree_oid.hash, rewrite_here);
f55ac4311a 232) status = splice_tree(&tree_oid, subpath, oid2, &subtree);

midx.c
e7a330ee26  428) close_pack(packs->info[packs->nr].p);
e7a330ee26  429) FREE_AND_NULL(packs->info[packs->nr].p);
14b7185175  815) error(_("did not see pack-file %s to drop"),
14b7185175  817) drop_index++;
14b7185175  818) missing_drops++;
14b7185175  819) i--;
14b7185175  826) result = 1;
14b7185175  827) goto cleanup;
14b7185175 1073) return 0;
14b7185175 1088) continue;
14b7185175 1091) continue;
17d0bf5a7d 1142) return 0;
17d0bf5a7d 1151) continue;
17d0bf5a7d 1164) continue;
17d0bf5a7d 1187) error(_("could not start pack-objects"));
17d0bf5a7d 1188) result = 1;
17d0bf5a7d 1189) goto cleanup;
17d0bf5a7d 1206) error(_("could not finish pack-objects"));
17d0bf5a7d 1207) result = 1;
17d0bf5a7d 1208) goto cleanup;

packfile.c
9133688752  369) strbuf_release(&buf);
9133688752  370) return;

pkt-line.c
7d268894d4 502) retval = demultiplex_sideband(reader->me, reader->buffer,
7d268894d4 504) switch (retval) {
7d268894d4 509) goto nonprogress_received;
7d268894d4 511) if (reader->pktlen != 1)
7d268894d4 512) goto nonprogress_received;
7d268894d4 518) break;
7d268894d4 522) }

pretty.c
ad6f028f06 1204) return 0;

read-cache.c
ee70c12820 1736) if (advice_unknown_index_extension) {
ee70c12820 1737) warning(_("ignoring optional %.4s index extension"), ext);
ee70c12820 1738) advise(_("This is likely due to the file having been 
written by a newer\n"

ref-filter.c
a9fb549b1d  467) return 0;

remote-curl.c
01f9ec64c8  427) die("invalid server response; got '%s'", reader.line);
01f9ec64c8  439) }
b79bdd8c12  576) return size;

send-pack.c
01f9ec64c8 143) return error(_("unable to parse remote unpack status: 
%s"), reader->line);
01f9ec64c8 162) error("invalid ref status from remote: %s", reader->line);
01f9ec64c8 579) receive_unpack_status(&reader);

sequencer.c
899b49c446 2394) opts->quiet = 1;

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
514c5fdd03 sha1-file.c 1291) status = error(_("unable to parse %s 
header"), oid_to_hex(oid));
00a7760e81 sha1-file.c 2305) the_hash_algo->final_fn(real_oid.hash, &c);
00a7760e81 sha1-file.c 2306) if (!oideq(expected_oid, &real_oid)) {

sideband.c
8553d661ee 127) suffix = ANSI_SUFFIX;
8553d661ee 137) strbuf_addf(&outbuf,
8553d661ee 139)     outbuf.len ? "\n" : "", me);
8553d661ee 140) retval = SIDEBAND_PROTOCOL_ERROR;
8553d661ee 141) goto cleanup;
7d268894d4 149) die("remote error: %s", buf + 1);
8553d661ee 196) strbuf_addf(&outbuf, "%s%s: protocol error: bad band #%d",
8553d661ee 197)     outbuf.len ? "\n" : "", me, band);
8553d661ee 198) retval = SIDEBAND_PROTOCOL_ERROR;
8553d661ee 199) break;
7d268894d4 204) die("%s", outbuf.buf);

submodule.c
26f80ccfc1 1398) strbuf_release(&gitdir);
be76c21282 1521) struct fetch_task *task = task_cb;
be76c21282 1525) fetch_task_release(task);

tree-walk.c
0a3faa45b1  530) oidcpy(result, &oid);

tree.c
38111b0e9d 104) commit = lookup_commit(r, &entry.oid);

upload-pack.c
87c2d9d310  149) sq_quote_buf(&buf, expanded_filter_spec.buf);
01f9ec64c8  432) die("git upload-pack: expected SHA1 list, got '%s'", 
reader->line);
7d268894d4 1066) allow_sideband_all = git_config_bool(var, value);
8aba257018 1306)      allow_sideband_all) &&
8aba257018 1307)     !strcmp(arg, "sideband-all")) {
7d268894d4 1308) data->writer.use_sideband = 1;
7d268894d4 1309) continue;
bc2e795cea 1441) deepen(&data->writer, INFINITE_DEPTH, 
data->deepen_relative,
8aba257018 1544)    &allow_sideband_all_value) &&

worktree.c
ebefff3c73 465) clear_repository_format(&format);

wrapper.c
e3b1e3bdc0 701) die_errno(_("could not stat %s"), filename);

Commits introducing uncovered code:
brian m. carlson      0a3faa45b: tree-walk: copy object ID before use
brian m. carlson      2f90b9d9b: sha1-file: provide functions to look up 
hash algorithms
brian m. carlson      47edb6499: hex: introduce functions to print 
arbitrary hashes
brian m. carlson      ea82b2a08: tree-walk: store object_id in a 
separate member
brian m. carlson      f55ac4311: match-trees: use hashcpy to splice trees
Daniels Umanovskis      0ecb1fc72: branch: introduce --show-current 
display option
Denton Liu      b19eee906: merge: add scissors line on merge conflict
Denton Liu      f39a9c654: remote: add --save-to-push option to git 
remote set-url
Derrick Stolee      14b718517: multi-pack-index: implement 'expire' 
subcommand
Derrick Stolee      17d0bf5a7: midx: implement midx_repack()
Derrick Stolee      334e9745a: multi-pack-index: prepare 'repack' subcommand
Derrick Stolee      913368875: repack: refactor pack deletion for future use
Derrick Stolee      e7a330ee2: midx: refactor permutation logic and pack 
sorting
Elijah Newren      899b49c44: git-rebase, sequencer: extend --quiet 
option for the interactive machinery
Issac Trotts      ad6f028f0: log: add %S option (like --source) to log 
--format
Jeff King      00a7760e8: sha1-file: modernize loose header/stream functions
Jeff King      514c5fdd0: sha1-file: modernize loose object file functions
Johannes Schindelin      2ead83aef: rebase: move `reset_head()` into a 
better spot
Johannes Schindelin      3bd5f0710: built-in rebase: call `git am` directly
Johannes Schindelin      81ef8ee75: rebase: introduce a shortcut for 
--reschedule-failed-exec
Johannes Schindelin      d421afa0c: rebase: introduce 
--reschedule-failed-exec
Jonathan Nieder      ee70c1282: index: offer advice for unknown index 
extensions
Jonathan Tan      4316ff306: fetch-pack: support protocol version 2
Jonathan Tan      7d268894d: {fetch,upload}-pack: sideband v2 fetch response
Jonathan Tan      8553d661e: sideband: reverse its dependency on pkt-line
Jonathan Tan      8aba25701: tests: define GIT_TEST_SIDEBAND_ALL
Jonathan Tan      bc2e795ce: pkt-line: introduce struct packet_writer
Josh Steadmon      87c2d9d31: filter-options: expand scaled numbers
Josh Steadmon      aa658574b: commit-graph, fuzz: add fuzzer for 
commit-graph
Junio C Hamano      38111b0e9: Merge branch 'bc/tree-walk-oid' into jch
Martin Ågren      ebefff3c7: setup: add `clear_repository_format()`
Masaya Suzuki      01f9ec64c: Use packet_reader instead of packet_read_line
Masaya Suzuki      b79bdd8c1: remote-curl: unset CURLOPT_FAILONERROR
Masaya Suzuki      e6cf87b12: http: enable keep_error for HTTP requests
Matthew DeVore      c813a7c35: list-objects-filter: teach tree:# how to 
handle >0
Nickolai Belakovski      711d28e2e: branch: add an extra verbose output 
displaying worktree path for checked out branch
Nickolai Belakovski      a9fb549b1: ref-filter: add worktreepath atom
Phillip Wood      21536d077: diff --color-moved-ws: modify 
allow-indentation-change
Phillip Wood      b73bcbac4: diff: allow --no-color-moved-ws
Pranit Bauva      06f5608c1: bisect--helper: `bisect_start` shell 
function partially in C
Pranit Bauva      0f30233a1: bisect--helper: `bisect_write` shell 
function in C
Pranit Bauva      129a6cf34: bisect--helper: `bisect_next_check` shell 
function in C
Pranit Bauva      450ebb735: bisect--helper: `get_terms` & 
`bisect_terms` shell function in C
Pranit Bauva      4fbdbd5bf: bisect--helper: `check_and_set_terms` shell 
function in C
Pranit Bauva      5e82c3dd2: bisect--helper: `bisect_reset` shell 
function in C
Pranit Bauva      e3b1e3bdc: wrapper: move is_empty_file() and rename it 
as is_empty_or_missing_file()
Stefan Beller      26f80ccfc: submodule: migrate get_next_submodule to 
use repository structs
Stefan Beller      be76c2128: fetch: ensure submodule objects fetched
Thomas Gummerer      091e04bc8: checkout: introduce --{,no-}overlay option
William Hubbs      7e43b32b5: Add author and committer configuration 
settings



Uncovered code in 'next' not in 'master'
--------------------------------------------

builtin/fetch.c
e01378753d builtin/fetch.c 1481) die(_("--filter can only be used with 
the remote "
e01378753d builtin/fetch.c 1650) die(_("--filter can only be used with 
the remote "

builtin/submodule--helper.c
builtin/worktree.c
00a6d4d1d2 752) found_submodules = 1;
00a6d4d1d2 753) break;

commit-graph.c
ref-filter.c
1867ce6cbe  236) oi_deref.info.sizep = &oi_deref.size;
1867ce6cbe  245) return strbuf_addf_ret(err, -1, _("unrecognized 
%%(objectsize) argument: %s"), arg);
33311fa1ad  253) return strbuf_addf_ret(err, -1, _("%%(deltabase) does 
not take arguments"));

setup.c
07098b81a4 1093) if (!nongit_ok)
07098b81a4 1094) die(_("not a git repository (or any parent up to mount 
point %s)\n"
07098b81a4 1097) *nongit_ok = 1;
07098b81a4 1098) break;

transport-helper.c
3b3357626e 1029) static int has_attribute(const char *attrs, const char 
*attr)

Commits introducing uncovered code:
Christian Couder      e01378753: fetch: fix extensions.partialclone name 
in error message
Erin Dahlgren      07098b81a: Simplify handling of 
setup_git_directory_gently() failure cases.
Nguyễn Thái Ngọc Duy      00a6d4d1d: worktree: allow to (re)move 
worktrees with uninitialized submodules
Nguyễn Thái Ngọc Duy      3b3357626: style: the opening '{' of a 
function is in a separate line
Olga Telezhnaya      1867ce6cb: ref-filter: add objectsize:disk option
Olga Telezhnaya      33311fa1a: ref-filter: add deltabase option



Uncovered code in 'master' not in 'master@{1}'
----------------------------------------------------

apply.c
0f086e6dca 3355) if (checkout_entry(ce, &costate, NULL, NULL) ||
0f086e6dca 3356)     lstat(ce->name, st))

pathspec.c
22af33bece 671) name = to_free = xmemdupz(name, namelen);

read-cache.c
ec36c42a63 3498) const char *index = NULL;
ec36c42a63 3504) if (!offset)
ec36c42a63 3505) return NULL;
ec36c42a63 3506) while (offset <= mmap_size - the_hash_algo->rawsz - 8) {
ec36c42a63 3507) extsize = get_be32(mmap + offset + 4);
ec36c42a63 3508) if (CACHE_EXT((mmap + offset)) == 
CACHE_EXT_INDEXENTRYOFFSETTABLE) {
ec36c42a63 3509) index = mmap + offset + 4 + 4;
ec36c42a63 3510) break;
ec36c42a63 3512) offset += 8;
ec36c42a63 3513) offset += extsize;
ec36c42a63 3515) if (!index)
ec36c42a63 3516) return NULL;
ec36c42a63 3519) ext_version = get_be32(index);
ec36c42a63 3520) if (ext_version != IEOT_VERSION) {
ec36c42a63 3521) error("invalid IEOT version %d", ext_version);
ec36c42a63 3522) return NULL;
ec36c42a63 3524) index += sizeof(uint32_t);
ec36c42a63 3527) nr = (extsize - sizeof(uint32_t)) / (sizeof(uint32_t) + 
sizeof(uint32_t));
ec36c42a63 3528) if (!nr) {
ec36c42a63 3529) error("invalid number of IEOT entries %d", nr);
ec36c42a63 3530) return NULL;
ec36c42a63 3532) ieot = xmalloc(sizeof(struct index_entry_offset_table)
ec36c42a63 3533)        + (nr * sizeof(struct index_entry_offset)));
ec36c42a63 3534) ieot->nr = nr;
ec36c42a63 3535) for (i = 0; i < nr; i++) {
ec36c42a63 3536) ieot->entries[i].offset = get_be32(index);
ec36c42a63 3537) index += sizeof(uint32_t);
ec36c42a63 3538) ieot->entries[i].nr = get_be32(index);
ec36c42a63 3539) index += sizeof(uint32_t);
ec36c42a63 3542) return ieot;

tree.c
e092073d64 104) commit = lookup_commit(r, entry.oid);

Commits introducing uncovered code:
Nguyễn Thái Ngọc Duy      0f086e6dc: checkout: print something when 
checking out paths
Nguyễn Thái Ngọc Duy      22af33bec: dir.c: move, rename and export 
match_attrs()
Nguyễn Thái Ngọc Duy      e092073d6: tree.c: make read_tree*() take 
'struct repository *'
Nguyễn Thái Ngọc Duy      ec36c42a6: Indent code with TABs


