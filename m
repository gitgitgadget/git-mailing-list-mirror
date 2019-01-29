Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E99AE1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 17:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfA2Rqo (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 12:46:44 -0500
Received: from mail-qt1-f181.google.com ([209.85.160.181]:35679 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfA2Rqn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 12:46:43 -0500
Received: by mail-qt1-f181.google.com with SMTP id v11so23218671qtc.2
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 09:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Ze2sCFX771YiWnFJ5FJsXYZdfbgjuLYlLMaC0D9ZA9g=;
        b=AJmM9YNTQNixpo7anWglkJEnNsdcF1mU9JciRmpfvLKmO6nSoiZILT9p5ju8aSlkAl
         BToVnDcayZkuXLtlAkuiaz3+zCu3OYqZ1XdL/JjmbX6fn4AsXkpv1KBa5q/PttGJBzhk
         fcarTWG0vqIJzRSkbRnI+ztozM2X5dvWfdtOAGczE8c3y3ch/kgrvx3peBfAOmJSszpe
         /oZUqFzrWOQWWdWz/RWzDT8Z3yroC3pRKFBtLvQwi4UFaLN5R/FCqYq17bw2FEP5WBmA
         jKOFshZqknyA6ow0eIX+Oj3WI5o+6vmX6ybtcTeyyBkrWVS0P2PY928YD/Rw7Wz/uQcg
         j7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Ze2sCFX771YiWnFJ5FJsXYZdfbgjuLYlLMaC0D9ZA9g=;
        b=YqdQd1WwtY+aB7LcEZyY25vk+e7gojJJBqGJkeS5tYH14zVfYV1rewcO45uLGUVzie
         mMmn6tZJr44WpzXbpB9spA/76RDjZbn4UayO+PJ+NCWbQp2jrQqRvVV3trDCESiQDSYA
         mW2QE/zEjmFK25LUV10RADbOpN17uCf0TVbsyGNISEFVrsGYYsAoJgwLwscovdfRswqK
         4pg6L5K6oh/8KHAfzTaHwT5n7jzJOpjRNNCVnqXt8MuD8iQVv06IxNwf6A9PPGQdcgFS
         H82axPId2z9z4dw2emXoetALuNb4jnB4vaIifknaVTnjRv8LA8UAwWNaDSpntOGAvWor
         Pyjw==
X-Gm-Message-State: AJcUukdsmf5Ar/DWIbaDjofbSmxXxZPjjeqioLzWtYtt8LIX82WjLsCH
        EFAWzblDlc6TNkZ9mEIppZNyap/N
X-Google-Smtp-Source: ALg8bN4gQC6oiwgdbkYOhtyrVkOeovevocbRcThLRvvDA1cjQeT8CYGguInXAtqhNolPRkgMew3aIw==
X-Received: by 2002:a0c:872a:: with SMTP id 39mr25190179qvh.1.1548783997431;
        Tue, 29 Jan 2019 09:46:37 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:788a:444c:e16b:27e? ([2001:4898:8010:2:61be:444c:e16b:27e])
        by smtp.gmail.com with ESMTPSA id x202sm71601251qka.67.2019.01.29.09.46.36
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 09:46:36 -0800 (PST)
To:     Git List <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (Tue. January 29, 2019)
Message-ID: <fbf5d384-6929-822c-ff63-9a149b11e774@gmail.com>
Date:   Tue, 29 Jan 2019 12:46:36 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is today's test coverage report.

Since the last report, I have overhauled the machinery for generating these
reports. The code is available on GitHub [1], and the reports are available
online in text [2] and HTML [3] form.

In addition to the two output formats, the code also has the ability to
ignore lines that are unimportant for coverage. This allows me to review
the report, and reduce the size of the next one. For this reason, I set
the comparison branch for 'master' to 'maint' so we can see what is
uncovered in that segment. If you wish to add ignored lines, then please
open a pull request against the GitHub repo [1].

One side effect is that some file names may appear with no uncovered code.
The ignored lines are visible by clicking a button on the HTML report [3].

The 'pu' versus 'jch' report looks rather large to me, but I did use prove
to run the tests, so the entire test suite did run (through failures). A
lot of the lines are related to trace2, so I'll add the GIT_TR2* variables
to my build when running with optional variables.

As always, I hope this is useful and I look forward to your feedback.

Thanks,
-Stolee

[1] https://github.com/derrickstolee/git-test-coverage
[2] https://derrickstolee.github.io/git-test-coverage/reports/2019-01-29.txt
[3] https://derrickstolee.github.io/git-test-coverage/reports/2019-01-29.htm

---

pu	c7baf85843ec1dc8272483baa2f84d0ec66ad882
jch	2ea90524518a3dfcb3cda871ef2b1a739075e5d9
next	aa96b0ce6b0fa4fa4cc6870f1a3aff3878967bfa
master	16a465bc018d09e9d7bbbdc5f40a7fb99c21f8ef
maint	0d0ac3826a3bbb9247e39e12623bbcfdd722f24c


Uncovered code in 'pu' not in 'jch'
--------------------------------------------------------

bisect.c
4f6d26b1 661) mark_edges_uninteresting(revs, NULL, 0);

blame.c
07d04b91 482)     ent->s_lno + ent->num_lines == next->s_lno &&
07d04b91 483)     ent->ignored == next->ignored) {
e7973c85 940) blame_origin_decref(e->suspect);
e7973c85 941) e->suspect = blame_origin_incref(parent);
e7973c85 942) e->s_lno += offset;
07d04b91 943) e->ignored = 1;
e7973c85 944) e->next = ignoredp;
b543bb1c 1497) same = 1;
b543bb1c 1503) blame_origin_decref(porigin);

builtin/blame.c
07d04b91 485) length--;
31653c1a 699) if (!value)
31653c1a 700) return config_error_nonbool(var);
a5481a6c 701) parse_date_format(value, &blame_date_mode);
31653c1a 702) return 0;
5817da01 777) return 0;
31653c1a 930) blame_date_width = sizeof("Thu, 19 Oct 2006 16:00:04 -0700");
31653c1a 931) break;
5817da01 998) usage_with_options(blame_opt_usage, options);

builtin/change.c
49854277 23) static int change_list(int argc, const char **argv, const char* prefix)
49854277 25) struct option options[] = {
49854277 31) struct ref_format format = REF_FORMAT_INIT;
49854277 35) argc = parse_options(argc, argv, prefix, options, builtin_list_usage, 0);
49854277 37) setup_ref_filter_porcelain_msg();
49854277 39) memset(&filter, 0, sizeof(filter));
49854277 40) memset(&array, 0, sizeof(array));
49854277 42) filter.kind = FILTER_REFS_CHANGES;
49854277 43) filter.name_patterns = argv;
49854277 45) filter_refs(&array, &filter, FILTER_REFS_CHANGES);
49854277 52) if (!format.format) {
49854277 53) format.format = "%(refname:lstrip=1)";
49854277 56) if (verify_ref_format(&format))
49854277 57) die(_("unable to parse format string"));
49854277 59) for (i = 0; i < array.nr; i++) {
49854277 60) show_ref_array_item(array.items[i], &format);
49854277 63) ref_array_clear(&array);
49854277 65) return 0;
73f8829d 76) static void init_update_state(struct update_state *state)
73f8829d 78) memset(state, 0, sizeof(*state));
73f8829d 79) state->content = "HEAD";
73f8829d 80) string_list_init(&state->replace, 0);
73f8829d 81) string_list_init(&state->origin, 0);
73f8829d 82) }
73f8829d 84) static void clear_update_state(struct update_state *state)
73f8829d 86) string_list_clear(&state->replace, 0);
73f8829d 87) string_list_clear(&state->origin, 0);
73f8829d 88) }
73f8829d 90) static int update_option_parse_replace(const struct option *opt,
73f8829d 93) struct update_state *state = opt->value;
73f8829d 94) string_list_append(&state->replace, arg);
73f8829d 95) return 0;
73f8829d 98) static int update_option_parse_origin(const struct option *opt,
73f8829d 101) struct update_state *state = opt->value;
73f8829d 102) string_list_append(&state->origin, arg);
73f8829d 103) return 0;
73f8829d 106) static int resolve_commit(const char *committish, struct object_id *result)
73f8829d 109) if (get_oid_committish(committish, result))
73f8829d 110) die(_("Failed to resolve '%s' as a valid revision."), committish);
73f8829d 111) commit = lookup_commit_reference(the_repository, result);
73f8829d 112) if (!commit)
73f8829d 113) die(_("Could not parse object '%s'."), committish);
73f8829d 114) oidcpy(result, &commit->object.oid);
73f8829d 115) return 0;
73f8829d 118) static void resolve_commit_list(const struct string_list *commitsish_list,
73f8829d 122) for (i = 0; i < commitsish_list->nr; i++) {
73f8829d 123) struct string_list_item *item = &commitsish_list->items[i];
73f8829d 125) resolve_commit(item->string, &next);
73f8829d 126) oid_array_append(result, &next);
73f8829d 128) }
73f8829d 134) static void get_metacommit_from_command_line(
73f8829d 137) resolve_commit(commands->content, &(result->content));
73f8829d 138) resolve_commit_list(&(commands->replace), &(result->replace));
73f8829d 139) resolve_commit_list(&(commands->origin), &(result->origin));
73f8829d 140) }
73f8829d 142) static int perform_update(
73f8829d 150) init_metacommit_data(&metacommit);
73f8829d 152) get_metacommit_from_command_line(state, &metacommit);
73f8829d 154) ret = record_metacommit(repo, &metacommit, state->change, state->options, err);
73f8829d 156) clear_metacommit_data(&metacommit);
73f8829d 158) return ret;
73f8829d 161) static int change_update(int argc, const char **argv, const char* prefix)
73f8829d 164) int force = 0;
73f8829d 165) int newchange = 0;
73f8829d 166) struct strbuf err = STRBUF_INIT;
73f8829d 168) struct option options[] = {
73f8829d 186) init_update_state(&state);
73f8829d 188) argc = parse_options(argc, argv, prefix, options, builtin_update_usage, 0);
73f8829d 190) if (force) state.options |= UPDATE_OPTION_FORCE;
73f8829d 191) if (newchange) state.options |= UPDATE_OPTION_NOAPPEND;
73f8829d 193) result = perform_update(the_repository, &state, &err);
73f8829d 195) if (result < 0) {
73f8829d 196) error("%s", err.buf);
73f8829d 197) strbuf_release(&err);
73f8829d 200) clear_update_state(&state);
73f8829d 202) return result;
73f8829d 216) if (argc < 1)
73f8829d 217) usage_with_options(builtin_change_usage, options);
49854277 218) else if (!strcmp(argv[0], "list"))
49854277 219) result = change_list(argc, argv, prefix);
73f8829d 220) else if (!strcmp(argv[0], "update"))
73f8829d 221) result = change_update(argc, argv, prefix);
73f8829d 223) error(_("Unknown subcommand: %s"), argv[0]);
73f8829d 224) usage_with_options(builtin_change_usage, options);
73f8829d 227) return result ? 1 : 0;

builtin/config.c
a12c1ff3 110) die(_("$HOME not set"));
a12c1ff3 122) given_config_source.file = git_etc_gitconfig();
1d28ff4c 401) error(_("invalid key pattern: %s"), key_);
6a83d902 402) FREE_AND_NULL(key_regexp);
9409c7a5 403) ret = CONFIG_INVALID_PATTERN;
1d28ff4c 421) error(_("invalid pattern: %s"), regex_);
6a83d902 422) FREE_AND_NULL(regexp);
9409c7a5 423) ret = CONFIG_INVALID_PATTERN;
5f1a63e0 424) goto free_strings;

builtin/pack-redundant.c
cb7e0336 461) llist_sorted_difference_inplace(all_objects, pl->remaining_objects);
1c3039e8 462) pl = pl->next;
bd22c904 478) static void scan_alt_odb_packs(void)
eeefa7c9 572) if (!strcmp(arg, "--verbose")) {
6390fe20 606) if (get_oid_hex(buf, oid))

builtin/rebase--interactive.c
e5b1c9d9 24) return error_errno(_("could not read '%s'."), todo_file);
e5b1c9d9 31) return error_errno(_("could not write '%s'"), todo_file);
4d55dfd7 46) return error_errno(_("could not read '%s'."), todo_file);
4d55dfd7 50) todo_list_release(&todo_list);
4d55dfd7 51) return error(_("unusable todo list: '%s'"), todo_file);
4d55dfd7 59) return error_errno(_("could not write '%s'."), todo_file);

builtin/rebase.c
c54dacb5 1351) const char *last_slash = strrchr(options.state_dir, '/');
c54dacb5 1352) const char *state_dir_base =
c54dacb5 1353) last_slash ? last_slash + 1 : options.state_dir;
c54dacb5 1354) const char *cmd_live_rebase =

builtin/stash.c
f6bbd781 128) die(_("'%s' is not a stash-like commit"), revision);
f6bbd781 161) free_stash_info(info);
f6bbd781 162) fprintf_ln(stderr, _("No stash entries found."));
f6bbd781 163) return -1;
f6bbd781 198) free_stash_info(info);
cdca49bc 225) return error(_("git stash clear with parameters is "
f6bbd781 241) return -1;
f6bbd781 249) return -1;
f6bbd781 265) return error(_("unable to write new index file"));
f6bbd781 377) remove_path(stash_index_path.buf);
f6bbd781 378) return -1;
f6bbd781 405) return -1;
f6bbd781 408) return error(_("cannot apply a stash in the middle of a merge"));
f6bbd781 418) strbuf_release(&out);
f6bbd781 419) return error(_("could not generate diff %s^!."),
f6bbd781 426) return error(_("conflicts in index."
f6bbd781 432) return error(_("could not save index tree"));
f6bbd781 439) return error(_("could not restore untracked files from stash"));
f6bbd781 470) return -1;
f6bbd781 475) strbuf_release(&out);
f6bbd781 480) strbuf_release(&out);
f6bbd781 481) return -1;
cdca49bc 557) return error(_("%s: Could not drop stash entry"),
e1d01876 632) printf_ln(_("The stash entry is kept in case "
b4493f26 766) free_stash_info(&info);
51809c70 767) usage_with_options(git_stash_show_usage, options);
847eb0b0 783) stash_msg = "Created via \"git stash store\".";
847eb0b0 789) if (!quiet) {
847eb0b0 790) fprintf_ln(stderr, _("Cannot update %s with %s"),
847eb0b0 793) return -1;
847eb0b0 817) if (!quiet)
847eb0b0 818) fprintf_ln(stderr, _("\"git stash store\" requires one "
847eb0b0 820) return -1;
1f5a011d 903) return -1;
1f5a011d 963) ret = -1;
1f5a011d 964) goto done;
1f5a011d 969) ret = -1;
1f5a011d 970) goto done;
1f5a011d 975) ret = -1;
1f5a011d 976) goto done;
1f5a011d 1002) ret = -1;
1f5a011d 1003) goto done;
1f5a011d 1014) ret = -1;
1f5a011d 1015) goto done;
1f5a011d 1021) ret = -1;
1f5a011d 1022) goto done;
1f5a011d 1029) ret = -1;
1f5a011d 1030) goto done;
1f5a011d 1068) ret = -1;
1f5a011d 1069) goto done;
1f5a011d 1075) ret = -1;
1f5a011d 1076) goto done;
1f5a011d 1087) ret = -1;
1f5a011d 1088) goto done;
1f5a011d 1093) ret = -1;
1f5a011d 1094) goto done;
9a95010a 1130) fprintf_ln(stderr, _("You do not have "
1f5a011d 1139) ret = 1;
1f5a011d 1140) goto done;
9a95010a 1156) if (!quiet)
9a95010a 1157) fprintf_ln(stderr, _("Cannot save the current "
1f5a011d 1159) ret = -1;
1f5a011d 1160) goto done;
9a95010a 1165) if (!quiet)
9a95010a 1166) fprintf_ln(stderr, _("Cannot save "
1f5a011d 1168) ret = -1;
1f5a011d 1169) goto done;
9a95010a 1176) if (!quiet)
9a95010a 1177) fprintf_ln(stderr, _("Cannot save the current "
1f5a011d 1179) goto done;
9a95010a 1213) if (!quiet)
9a95010a 1214) fprintf_ln(stderr, _("Cannot record "
1f5a011d 1216) ret = -1;
1f5a011d 1217) goto done;
fa38428f 1286) ret = -1;
fa38428f 1287) goto done;
fa38428f 1297) ret = -1;
9a95010a 1298) if (!quiet)
9a95010a 1299) fprintf_ln(stderr, _("Cannot initialize stash"));
fa38428f 1300) goto done;
fa38428f 1312) ret = -1;
9a95010a 1313) if (!quiet)
9a95010a 1314) fprintf_ln(stderr, _("Cannot save the current status"));
fa38428f 1315) goto done;
fa38428f 1332) ret = -1;
fa38428f 1351) ret = -1;
fa38428f 1352) goto done;
fa38428f 1361) ret = -1;
fa38428f 1362) goto done;
fa38428f 1370) ret = -1;
fa38428f 1379) ret = -1;
fa38428f 1390) ret = -1;
fa38428f 1391) goto done;
fa38428f 1400) ret = -1;
fa38428f 1401) goto done;
fa38428f 1409) ret = -1;
fa38428f 1435) ret = -1;
bec65d5b 1527) return env;
26799a20 1555) const char *path = mkpath("%s/git-legacy-stash",
26799a20 1558) if (sane_execvp(path, (char **)argv) < 0)
26799a20 1559) die_errno(_("could not exec %s"), path);
26799a20 1561) BUG("sane_execvp() returned???");
51809c70 1602) usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
51809c70 1630) continue;

builtin/update-index.c
309be813 905) return error("option '%s' must be the last argument", opt->long_name);
309be813 924) active_cache_changed = 0;

change-table.c
287a8679 7) void change_table_init(struct change_table *to_initialize)
287a8679 9) memset(to_initialize, 0, sizeof(*to_initialize));
287a8679 10) mem_pool_init(&(to_initialize->memory_pool), 0);
287a8679 11) to_initialize->memory_pool->block_alloc = 4*1024 - sizeof(struct mp_block);
287a8679 12) oidmap_init(&(to_initialize->oid_to_metadata_index), 0);
287a8679 13) string_list_init(&(to_initialize->refname_to_change_head), 1);
287a8679 14) }
287a8679 16) static void change_list_clear(struct change_list *to_clear) {
287a8679 17) string_list_clear(&to_clear->additional_refnames, 0);
287a8679 18) }
287a8679 20) static void commit_change_list_entry_clear(
287a8679 22) change_list_clear(&(to_clear->changes));
287a8679 23) }
287a8679 25) static void change_head_array_clear(struct change_head_array *to_clear)
287a8679 27) FREE_AND_NULL(to_clear->array);
287a8679 28) }
287a8679 30) void change_table_clear(struct change_table *to_clear)
287a8679 34) for (next = oidmap_iter_first(&to_clear->oid_to_metadata_index, &iter);
287a8679 36) next = oidmap_iter_next(&iter)) {
287a8679 38) commit_change_list_entry_clear(next);
287a8679 41) oidmap_free(&to_clear->oid_to_metadata_index, 0);
287a8679 42) string_list_clear(&(to_clear->refname_to_change_head), 0);
287a8679 43) change_head_array_clear(&to_clear->heads);
287a8679 44) mem_pool_discard(to_clear->memory_pool, 0);
287a8679 45) }
287a8679 51) static int change_head_array_append(struct change_head_array *to_add)
287a8679 53) int index = to_add->nr++;
287a8679 55) ALLOC_GROW(to_add->array, to_add->nr, to_add->alloc);
287a8679 56) new_head = &(to_add->array[index]);
287a8679 57) memset(new_head, 0, sizeof(*new_head));
287a8679 58) return index;
287a8679 61) static void add_head_to_commit(struct change_table *to_modify,
287a8679 68) entry = oidmap_get(&(to_modify->oid_to_metadata_index), to_add);
287a8679 69) if (!entry) {
287a8679 70) entry = mem_pool_calloc(to_modify->memory_pool, 1,
287a8679 72) oidcpy(&entry->entry.oid, to_add);
287a8679 73) oidmap_put(&(to_modify->oid_to_metadata_index), entry);
287a8679 74) string_list_init(&(entry->changes.additional_refnames), 0);
287a8679 77) if (entry->changes.first_refname == NULL) {
287a8679 78) entry->changes.first_refname = refname;
287a8679 80) string_list_insert(&entry->changes.additional_refnames, refname);
287a8679 82) }
287a8679 84) void change_table_add(struct change_table *to_modify, const char *refname,
287a8679 92) index = change_head_array_append(&to_modify->heads);
287a8679 93) new_head = &(to_modify->heads.array[index]);
287a8679 95) oidcpy(&new_head->head, &(to_add->object.oid));
287a8679 97) metacommit_type = get_metacommit_content(to_add, &new_head->content);
287a8679 98) if (metacommit_type == METACOMMIT_TYPE_NONE) {
287a8679 99) oidcpy(&new_head->content, &(to_add->object.oid));
287a8679 101) new_head->abandoned = (metacommit_type == METACOMMIT_TYPE_ABANDONED);
287a8679 102) new_head->remote = starts_with(refname, "refs/remote/");
287a8679 103) new_head->hidden = starts_with(refname, "refs/hiddenmetas/");
287a8679 105) new_item = string_list_insert(&to_modify->refname_to_change_head, refname);
287a8679 106) new_item->util = (void*)index;
287a8679 108) refname = new_item->string;
287a8679 110) if (!oideq(&new_head->content, &new_head->head)) {
287a8679 111) add_head_to_commit(to_modify, &(new_head->content), refname);
287a8679 113) add_head_to_commit(to_modify, &(new_head->head), refname);
287a8679 114) }
287a8679 116) void change_table_add_all_visible(struct change_table *to_modify,
287a8679 120) const char *name_patterns[] = {NULL};
287a8679 121) memset(&filter, 0, sizeof(filter));
287a8679 122) filter.kind = FILTER_REFS_CHANGES;
287a8679 123) filter.name_patterns = name_patterns;
287a8679 125) change_table_add_matching_filter(to_modify, repo, &filter);
287a8679 126) }
287a8679 128) void change_table_add_matching_filter(struct change_table *to_modify,
287a8679 134) memset(&matching_refs, 0, sizeof(matching_refs));
287a8679 135) filter_refs(&matching_refs, filter, filter->kind);
287a8679 142) for (i = 0; i < matching_refs.nr; i++) {
287a8679 143) struct ref_array_item *item = matching_refs.items[i];
287a8679 144) struct commit *commit = item->commit;
287a8679 146) commit = lookup_commit_reference_gently(repo, &(item->objectname), 1);
287a8679 148) if (commit != NULL) {
287a8679 149) change_table_add(to_modify, item->refname, commit);
287a8679 153) ref_array_clear(&matching_refs);
287a8679 154) }
287a8679 156) static int return_true_callback(const char *refname, void *cb_data)
287a8679 158) return 1;
287a8679 161) int change_table_has_change_referencing(struct change_table *changes,
287a8679 164) return for_each_change_referencing(changes, referenced_commit_id,
287a8679 168) int for_each_change_referencing(struct change_table *table,
287a8679 176) entry = oidmap_get(&table->oid_to_metadata_index,
287a8679 179) if (!entry) {
287a8679 180) return 0;
287a8679 182) changes = &(entry->changes);
287a8679 183) if (changes->first_refname == NULL) {
287a8679 184) return 0;
287a8679 186) retvalue = fn(changes->first_refname, cb_data);
287a8679 187) for (i = 0; retvalue == 0 && i < changes->additional_refnames.nr; i++) {
287a8679 188) retvalue = fn(changes->additional_refnames.items[i].string, cb_data);
287a8679 190) return retvalue;
287a8679 193) struct change_head* get_change_head(struct change_table *heads,
287a8679 196) struct string_list_item *item = string_list_lookup(
287a8679 200) if (!item) {
287a8679 201) return NULL;
287a8679 204) index = (long)item->util;
287a8679 205) return &(heads->heads.array[index]);

config.c
8f7c7f55 2147) int repo_config_set_gently(struct repository *r,
8f7c7f55 2150) char *path = repo_git_path(r, "config");
8f7c7f55 2151) int ret = git_config_set_multivar_in_file_gently(path, key, value, NULL, 0);
8f7c7f55 2152) free(path);
8f7c7f55 2153) return ret;
8f7c7f55 2156) void repo_config_set(struct repository *r, const char *key, const char *value)
8f7c7f55 2158) if (!repo_config_set_gently(r, key, value))
8f7c7f55 2159) return;
8f7c7f55 2160) if (value)
8f7c7f55 2161) die(_("could not set '%s' to '%s'"), key, value);
8f7c7f55 2163) die(_("could not unset '%s'"), key);
8f7c7f55 2166) int repo_config_set_worktree_gently(struct repository *r,
8f7c7f55 2172) path = get_worktree_config(r);
8f7c7f55 2173) if (!path)
8f7c7f55 2174) return CONFIG_INVALID_FILE;
8f7c7f55 2175) ret = git_config_set_multivar_in_file_gently(path, key, value, NULL, 0);
8f7c7f55 2176) free(path);
93c1e079 2920) goto write_err_out;
93c1e079 2923) goto write_err_out;

connect.c
aad6fddb 1299) die(_("unable to fork"));

date.c
acdd3776 113) die("Timestamp too large for this system: %"PRItime, time);
7d29afd4 138) return;
033abf97 209) BUG("cannot create anonymous strftime date_mode struct");
acdd3776 236) hide.date = 1;

diff.c
dd63f169 4639) die(_("--follow requires exactly one pathspec"));
d473e2e0 4946) return error(_("%s expects a numerical value"), "--unified");

git.c
63ab7419 155) trace2_cmd_verb("_query_");
63ab7419 159) trace2_cmd_verb("_query_");
63ab7419 163) trace2_cmd_verb("_query_");
8aa8c140 372) die(_("recursive alias: %s"), alias_command);
8aa8c140 456) die_errno(_("close failed on standard output"));
8aa8c140 680) die(_("%s doesn't support --super-prefix"), argv[0]);
246f0ede 717) exit(128);

list-objects.c
4f6d26b1 241) continue;
4f6d26b1 250) parent->object.flags |= SHOWN;
4f6d26b1 251) show_edge(parent);
4f6d26b1 272) tree->object.flags |= UNINTERESTING;
4f6d26b1 287) commit->object.flags |= SHOWN;
4f6d26b1 288) show_edge(commit);

metacommit-parser.c
6930f34d 9) static const char *find_key(const char *msg, const char *key, size_t *out_len)
6930f34d 11) int key_len = strlen(key);
6930f34d 12) const char *line = msg;
6930f34d 14) while (line) {
6930f34d 15) const char *eol = strchrnul(line, '\n');
6930f34d 17) if (eol - line > key_len &&
6930f34d 18) !strncmp(line, key, key_len) &&
6930f34d 19) line[key_len] == ' ') {
6930f34d 20) *out_len = eol - line - key_len - 1;
6930f34d 21) return line + key_len + 1;
6930f34d 23) line = *eol ? eol + 1 : NULL;
6930f34d 25) return NULL;
6930f34d 28) static struct commit *get_commit_by_index(struct commit_list *to_search, int index)
6930f34d 30) while (to_search && index) {
6930f34d 31) to_search = to_search->next;
6930f34d 32) --index;
6930f34d 35) return to_search->item;
6930f34d 42) int get_metacommit_content(
6930f34d 45) const char *buffer = get_commit_buffer(commit, NULL);
6930f34d 47) const char *parent_types = find_key(buffer, "parent-type",
6930f34d 50) int index = 0;
6930f34d 54) if (!parent_types) {
6930f34d 55) return METACOMMIT_TYPE_NONE;
6930f34d 58) end = &(parent_types[parent_types_size]);
6930f34d 61) char next = *parent_types;
6930f34d 62) if (next == ' ') {
6930f34d 63) index++;
6930f34d 65) if (next == 'c') {
6930f34d 66) ret = METACOMMIT_TYPE_NORMAL;
6930f34d 67) break;
6930f34d 69) if (next == 'a') {
6930f34d 70) ret = METACOMMIT_TYPE_ABANDONED;
6930f34d 71) break;
6930f34d 73) parent_types++;
6930f34d 74) if (parent_types >= end) {
6930f34d 75) return METACOMMIT_TYPE_NONE;
6930f34d 77) }
6930f34d 79) content_parent = get_commit_by_index(commit->parents, index);
6930f34d 81) if (!content_parent) {
6930f34d 82) return METACOMMIT_TYPE_NONE;
6930f34d 85) oidcpy(content, &(content_parent->object.oid));
6930f34d 86) return ret;

metacommit.c
6b8678e5 7) void init_metacommit_data(struct metacommit_data *state)
6b8678e5 9) memset(state, 0, sizeof(*state));
6b8678e5 10) }
6b8678e5 12) void clear_metacommit_data(struct metacommit_data *state)
6b8678e5 14) oid_array_clear(&state->replace);
6b8678e5 15) oid_array_clear(&state->origin);
6b8678e5 16) }
6b8678e5 18) static void compute_default_change_name(struct commit *initial_commit,
6b8678e5 21) const char *buffer = get_commit_buffer(initial_commit, NULL);
6b8678e5 25) find_commit_subject(buffer, &subject);
6b8678e5 26) eol = strchrnul(subject, '\n');
6b8678e5 27) for (len = 0;subject < eol && len < 10; ++subject, ++len) {
6b8678e5 28) char next = *subject;
6b8678e5 29) if (isspace(next)) {
6b8678e5 30) continue;
6b8678e5 33) strbuf_addch(result, next);
6b8678e5 35) }
6b8678e5 42) static void compute_change_name(struct commit *initial_commit, struct strbuf* result)
6b8678e5 47) strbuf_init(&default_name, 0);
6b8678e5 48) if (initial_commit) {
6b8678e5 49) compute_default_change_name(initial_commit, &default_name);
6b8678e5 51) strbuf_addstr(&default_name, "change");
6b8678e5 53) strbuf_addstr(result, "refs/metas/");
6b8678e5 54) strbuf_addstr(result, default_name.buf);
6b8678e5 57) if (!read_ref(result->buf, &unused)) {
6b8678e5 58) int suffix = 2;
6b8678e5 59) int original_length = result->len;
6b8678e5 62) strbuf_addf(result, "%d", suffix);
6b8678e5 63) if (read_ref(result->buf, &unused)) {
6b8678e5 64) break;
6b8678e5 66) strbuf_remove(result, original_length, result->len - original_length);
6b8678e5 67) ++suffix;
6b8678e5 68) }
6b8678e5 71) strbuf_release(&default_name);
6b8678e5 72) }
6b8678e5 81) static int resolve_metacommit_callback(const char *refname, void *cb_data)
6b8678e5 83) struct resolve_metacommit_callback_data *data = (struct resolve_metacommit_callback_data *)cb_data;
6b8678e5 86) chhead = get_change_head(data->active_changes, refname);
6b8678e5 88) if (data->changes) {
6b8678e5 89) string_list_append(data->changes, refname)->util = &(chhead->head);
6b8678e5 91) if (data->heads) {
6b8678e5 92) oid_array_append(data->heads, &(chhead->head));
6b8678e5 95) return 0;
6b8678e5 101) static void resolve_metacommit(
6b8678e5 110) int len = to_resolve->replace.nr;
6b8678e5 112) int old_change_list_length = to_advance->nr;
6b8678e5 115) oidcpy(&resolved_output->content, &to_resolve->content);
6b8678e5 119) resolved_output->abandoned = to_resolve->abandoned;
6b8678e5 120) cbdata.active_changes = active_changes;
6b8678e5 121) cbdata.changes = to_advance;
6b8678e5 122) cbdata.heads = &(resolved_output->replace);
6b8678e5 124) if (allow_append) {
6b8678e5 125) for (i = 0; i < len; i++) {
6b8678e5 126) int old_number = resolved_output->replace.nr;
6b8678e5 127) for_each_change_referencing(active_changes, &(to_resolve->replace.oid[i]),
6b8678e5 130) if (old_number == resolved_output->replace.nr) {
6b8678e5 131) oid_array_append(&(resolved_output->replace), &(to_resolve->replace.oid[i]));
6b8678e5 136) cbdata.changes = NULL;
6b8678e5 137) cbdata.heads = &(resolved_output->origin);
6b8678e5 139) len = to_resolve->origin.nr;
6b8678e5 140) for (i = 0; i < len; i++) {
6b8678e5 141) int old_number = resolved_output->origin.nr;
6b8678e5 142) for_each_change_referencing(active_changes, &(to_resolve->origin.oid[i]),
6b8678e5 144) if (old_number == resolved_output->origin.nr) {
6b8678e5 145) oid_array_append(&(resolved_output->origin), &(to_resolve->origin.oid[i]));
6b8678e5 151) if (to_advance->nr == old_change_list_length) {
6b8678e5 154) strbuf_init(&change_name, 80);
6b8678e5 155) content = lookup_commit_reference_gently(repo, &(to_resolve->content), 1);
6b8678e5 157) compute_change_name(content, &change_name);
6b8678e5 158) string_list_append(to_advance, change_name.buf);
6b8678e5 159) strbuf_release(&change_name);
6b8678e5 161) }
6b8678e5 163) static void lookup_commits(
6b8678e5 168) int i = to_lookup->nr;
6b8678e5 170) while (--i >= 0) {
6b8678e5 171) struct object_id *next = &(to_lookup->oid[i]);
6b8678e5 172) struct commit *commit = lookup_commit_reference_gently(repo, next, 1);
6b8678e5 173) commit_list_insert(commit, result);
6b8678e5 175) }
6b8678e5 183) int write_metacommit(struct repository *repo, struct metacommit_data *state,
6b8678e5 186) struct commit_list *parents = NULL;
6b8678e5 191) strbuf_init(&comment, strlen(PARENT_TYPE_PREFIX)
6b8678e5 192) + 1 + 2 * (state->origin.nr + state->replace.nr));
6b8678e5 193) lookup_commits(repo, &state->origin, &parents);
6b8678e5 194) lookup_commits(repo, &state->replace, &parents);
6b8678e5 195) content = lookup_commit_reference_gently(repo, &state->content, 1);
6b8678e5 196) if (!content) {
6b8678e5 197) strbuf_release(&comment);
6b8678e5 198) free_commit_list(parents);
6b8678e5 199) return -1;
6b8678e5 201) commit_list_insert(content, &parents);
6b8678e5 203) strbuf_addstr(&comment, PARENT_TYPE_PREFIX);
6b8678e5 204) strbuf_addstr(&comment, state->abandoned ? "a" : "c");
6b8678e5 205) for (i = 0; i < state->replace.nr; i++) {
6b8678e5 206) strbuf_addstr(&comment, " r");
6b8678e5 209) for (i = 0; i < state->origin.nr; i++) {
6b8678e5 210) strbuf_addstr(&comment, " o");
6b8678e5 214) commit_tree(comment.buf, comment.len, repo->hash_algo->empty_tree, parents,
6b8678e5 217) strbuf_release(&comment);
6b8678e5 218) return 0;
6b8678e5 225) static int is_nontrivial_metacommit(struct metacommit_data *state)
6b8678e5 227) return state->replace.nr || state->origin.nr || state->abandoned;
6b8678e5 240) int record_metacommit(struct repository *repo,
6b8678e5 248) struct ref_transaction *transaction = NULL;
6b8678e5 253) int ret = 0;
6b8678e5 254) int force = (options & UPDATE_OPTION_FORCE);
6b8678e5 256) init_metacommit_data(&resolved_metacommit);
6b8678e5 257) string_list_init(&changes, 1);
6b8678e5 259) change_table_init(&chtable);
6b8678e5 261) change_table_add_all_visible(&chtable, repo);
6b8678e5 263) resolve_metacommit(repo, &chtable, metacommit, &resolved_metacommit, &changes,
6b8678e5 264) (options & UPDATE_OPTION_NOAPPEND) == 0);
6b8678e5 266) if (override_change) {
6b8678e5 267) old_head = &old_head_working;
6b8678e5 268) string_list_clear(&changes, 0);
6b8678e5 269) if (get_oid_committish(override_change, &old_head_working)) {
6b8678e5 271) old_head = &null_oid;
6b8678e5 272) } else if (!force) {
6b8678e5 273) if (!oid_array_readonly_contains(&(resolved_metacommit.replace),
6b8678e5 276) strbuf_addf(err, _("non-fast-forward update to '%s'"),
6b8678e5 278) ret = -1;
6b8678e5 279) goto cleanup;
6b8678e5 283) string_list_append(&changes, override_change)->util = (void*)old_head;
6b8678e5 286) if (is_nontrivial_metacommit(&resolved_metacommit)) {
6b8678e5 289) if (write_metacommit(repo, &resolved_metacommit, &commit_target) < 0) {
6b8678e5 290) ret = -1;
6b8678e5 291) goto cleanup;
6b8678e5 296) oidcpy(&commit_target, &(resolved_metacommit.content));
6b8678e5 301) if (!override_change &&
6b8678e5 302) change_table_has_change_referencing(&chtable, &commit_target)) {
6b8678e5 304) goto cleanup;
6b8678e5 307) transaction = ref_transaction_begin(err);
6b8678e5 310) if (!transaction) {
6b8678e5 311) ret = -1;
6b8678e5 313) for (i = 0; i < changes.nr; i++) {
6b8678e5 314) struct string_list_item *it = &(changes.items[i]);
6b8678e5 318) if (it->util) {
6b8678e5 319) if (ref_transaction_update(transaction, it->string, &commit_target,
6b8678e5 322) ret = -1;
6b8678e5 325) if (ref_transaction_create(transaction, it->string,
6b8678e5 328) ret = -1;
6b8678e5 333) if (!ret) {
6b8678e5 334) if (ref_transaction_commit(transaction, err)) {
6b8678e5 335) ret = -1;
6b8678e5 341) ref_transaction_free(transaction);
6b8678e5 342) string_list_clear(&changes, 0);
6b8678e5 343) clear_metacommit_data(&resolved_metacommit);
6b8678e5 344) change_table_clear(&chtable);
6b8678e5 345) return ret;
6b8678e5 355) void modify_change(
6b8678e5 363) init_metacommit_data(&metacommit);
6b8678e5 364) oidcpy(&(metacommit.content), new_commit);
6b8678e5 365) oid_array_append(&(metacommit.replace), old_commit);
6b8678e5 367) record_metacommit(repo, &metacommit, NULL, 0, err);
6b8678e5 369) clear_metacommit_data(&metacommit);

object.c
01f8d594 278) error(_("hash mismatch %s"), oid_to_hex(repl));

oidset.c
ef644c41 69) die_errno("Could not read '%s'", path);

pager.c
603036d9 103) pager_process->trace2_child_class = "pager";

parse-options.c
f62470c6 116) BUG("BITOP can't have unset form");
df217ed6 155) *(const char **)opt->value = (const char *)opt->defval;
2a514ed8 204) *(unsigned long *)opt->value = 0;
2a514ed8 205) return 0;
1e5ce570 405) err |= optbug(opts, "uses incompatible flags "
af465af8 409) err |= optbug(opts, "invalid short name");
af465af8 411) err |= optbug(opts, "short name already used");
3ebbe289 432) BUG("OPTION_CALLBACK needs one callback");
3ebbe289 434) BUG("OPTION_CALLBACK can't have two callbacks");
b9d7f4b4 540) switch (opts->type) {
b9d7f4b4 542) continue;
ebc4a04e 559) if (opts->flags & PARSE_OPT_COMP_ARG)
b221b5ab 561) if (starts_with(opts->long_name, "no-"))
b9d7f4b4 567) fputc('\n', stdout);
a92ec7ef 568) return PARSE_OPT_COMPLETE;
b9d7f4b4 606) return show_gitcomp(ctx, options);

pretty.c
4681fe38 1069) return 0;
b755bf6f 1107)     match_placeholder_arg(p, "=on", end) ||
b755bf6f 1108)     match_placeholder_arg(p, "=true", end)) {

protocol.c
6da1f1a9 37) die(_("Unrecognized protocol version"));
6da1f1a9 39) die(_("Unrecognized protocol_version"));
373d70ef 49) die("unknown value for config 'protocol.version': %s",
6da1f1a9 61) BUG("late attempt to register an allowed protocol version");

read-cache.c
78bde923 3099) return error_errno(_("could not stat '%s'"), shared_index_path);

rebase-interactive.c
c27b32f0 26) warning(_("unrecognized setting %s for option "

remote-curl.c
6da1f1a9 344) return 0;
34a9469d 373) die("invalid server response; expected service, got flush packet");
34a9469d 397) d->proto_git = 1;
0f1dc53f 1375) break;

revision.c
d5d2e935 169) return;
d5d2e935 172) return;
d5d2e935 195) break;
f1f5de44 218) continue;

run-command.c
63ab7419 239) int ec = errno;
63ab7419 240) trace2_exec_result(exec_id, ec);
63ab7419 241) errno = ec;
0ac77ec3 715) failed_errno = errno;
507d7804 995) int finish_command_in_signal(struct child_process *cmd)
63ab7419 997) int ret = wait_or_whine(cmd->pid, cmd->argv[0], 1);
63ab7419 998) trace2_child_exit(cmd, ret);
63ab7419 999) return ret;
c553c72e 1829) pp.shutdown = 1;
c553c72e 1830) kill_children(&pp, -code);

sequencer.c
8414c890 4610) return error_errno(_("could not read '%s'."), todo_file);
8414c890 4612) if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list)) {
3546c8d9 4613) todo_list_release(&todo_list);
3546c8d9 4614) return error(_("unusable todo list: '%s'"), todo_file);
0cce4a27 4619) todo_list_release(&todo_list);
8414c890 4621) if (res)
8414c890 4622) return error_errno(_("could not write '%s'."), todo_file);
c27b32f0 4705) goto out;
c27b32f0 4710) goto out;
c27b32f0 4719) fprintf(stderr, _(edit_todo_list_advice));
cdac2b01 4743) return error(_("could not parse commit '%s'"),
cdac2b01 4759) error_errno(_("could not write to '%s'"), done_path);
cdac2b01 4760) return -1;
febebd99 5027) if (strbuf_read_file_or_whine(&todo_list.buf, todo_file) < 0)
febebd99 5030) todo_list_release(&todo_list);

sha1-array.c
9e98e9b6 34) return sha1_pos(oid->hash, array->oid, array->nr, sha1_access) >= 0;

sha1-file.c
2c319886 1595) return error_errno(_("unable to write file %s"), filename);
76011357 1626) fsync_or_die(fd, "loose object file");
76011357 1628) die_errno(_("error when closing loose object file"));
76011357 1719) die(_("unable to write loose object file"));
2c319886 1818) return error(_("cannot read object for %s"), oid_to_hex(oid));

sha1-name.c
d1dd94b3 926) return MISSING_OBJECT;

strbuf.c
bfc3fe33 259) die("`pos' is too far after the end of the buffer");
bfc3fe33 264) BUG("your vsnprintf is broken (returned %d)", len);
bfc3fe33 266) return; /* nothing to do */
bfc3fe33 268) die("you want to use way too much memory");
bfc3fe33 276) BUG("your vsnprintf is broken (returns inconsistent lengths)");
033abf97 397) BUG("your vsnprintf is broken (returned %d)", len);
033abf97 402) BUG("your vsnprintf is broken (insatiable)");

t/helper/test-path-utils.c
d04fa788 180) static int cmp_by_st_size(const void *a, const void *b)
d04fa788 182) intptr_t x = (intptr_t)((struct string_list_item *)a)->util;
d04fa788 183) intptr_t y = (intptr_t)((struct string_list_item *)b)->util;
d04fa788 185) return x > y ? -1 : (x < y ? +1 : 0);
dc2d9ba3 294) res = error("'%s' is %s.gitmodules", argv[i],
a5c09131 308) res = error_errno("Cannot stat '%s'", argv[i]);
2987e8cd 314) if (argc == 4 && !strcmp(argv[1], "skip-n-bytes")) {
2987e8cd 315) int fd = open(argv[2], O_RDONLY), offset = atoi(argv[3]);
2987e8cd 318) if (fd < 0)
2987e8cd 319) die_errno("could not open '%s'", argv[2]);
2987e8cd 320) if (lseek(fd, offset, SEEK_SET) < 0)
2987e8cd 321) die_errno("could not skip %d bytes", offset);
2987e8cd 323) ssize_t count = read(fd, buffer, sizeof(buffer));
2987e8cd 324) if (count < 0)
2987e8cd 325) die_errno("could not read '%s'", argv[2]);
2987e8cd 326) if (!count)
2987e8cd 327) break;
2987e8cd 328) if (write(1, buffer, count) < 0)
2987e8cd 329) die_errno("could not write to stdout");
2987e8cd 330) }
2987e8cd 331) close(fd);
2987e8cd 332) return 0;
d04fa788 335) if (argc > 5 && !strcmp(argv[1], "slice-tests")) {
d04fa788 336) int res = 0;
d04fa788 338) struct string_list list = STRING_LIST_INIT_NODUP;
d04fa788 341) offset = strtol(argv[2], NULL, 10);
d04fa788 342) stride = strtol(argv[3], NULL, 10);
d04fa788 343) if (stride < 1)
d04fa788 344) stride = 1;
d04fa788 345) for (i = 4; i < argc; i++)
d04fa788 346) if (stat(argv[i], &st))
d04fa788 347) res = error_errno("Cannot stat '%s'", argv[i]);
d04fa788 349) string_list_append(&list, argv[i])->util =

t/helper/test-sha1-array.c
9e98e9b6 30) die("not a hexadecimal SHA1: %s", arg);

t/helper/test-trace2.c
3e56cbd8 25) return MyError;
3e56cbd8 29) return MyError;
3e56cbd8 52) die("expect <exit_code>");
3e56cbd8 71) die("expect <exit_code>");
3e56cbd8 91) die("expect <error_message>");
3e56cbd8 141) return 0;
3e56cbd8 168) static int ut_005exec(int argc, const char **argv)
3e56cbd8 172) if (!argc)
3e56cbd8 173) return 0;
3e56cbd8 175) result = execv_git_cmd(argv);
3e56cbd8 176) return result;
3e56cbd8 185) die("%s", usage_error);
3e56cbd8 191) die("%s", usage_error);
3e56cbd8 223) static int print_usage(void)
3e56cbd8 228) fprintf(stderr, "usage:\n");
3e56cbd8 229) for_each_ut(k, ut_k) {
3e56cbd8 230) fprintf(stderr, "\t%s %s %s\n",
3e56cbd8 234) return 129;
3e56cbd8 271) return print_usage();

t/helper/test-xml-encode.c
b6fc0026 9) int cmd__xml_encode(int argc, const char **argv)
b6fc0026 11) unsigned char buf[1024], tmp[4], *tmp2 = NULL;
b6fc0026 12) ssize_t cur = 0, len = 1, remaining = 0;
b6fc0026 16) if (++cur == len) {
b6fc0026 17) len = xread(0, buf, sizeof(buf));
b6fc0026 18) if (!len)
b6fc0026 19) return 0;
b6fc0026 20) if (len < 0)
b6fc0026 21) die_errno("Could not read <stdin>");
b6fc0026 22) cur = 0;
b6fc0026 24) ch = buf[cur];
b6fc0026 26) if (tmp2) {
b6fc0026 27) if ((ch & 0xc0) != 0x80) {
b6fc0026 28) fputs(utf8_replace_character, stdout);
b6fc0026 29) tmp2 = 0;
b6fc0026 30) cur--;
b6fc0026 31) continue;
b6fc0026 33) *tmp2 = ch;
b6fc0026 34) tmp2++;
b6fc0026 35) if (--remaining == 0) {
b6fc0026 36) fwrite(tmp, tmp2 - tmp, 1, stdout);
b6fc0026 37) tmp2 = 0;
b6fc0026 39) continue;
b6fc0026 42) if (!(ch & 0x80)) {
b6fc0026 44) if (ch == '&')
b6fc0026 45) fputs("&amp;", stdout);
b6fc0026 46) else if (ch == '\'')
b6fc0026 47) fputs("&apos;", stdout);
b6fc0026 48) else if (ch == '"')
b6fc0026 49) fputs("&quot;", stdout);
b6fc0026 50) else if (ch == '<')
b6fc0026 51) fputs("&lt;", stdout);
b6fc0026 52) else if (ch == '>')
b6fc0026 53) fputs("&gt;", stdout);
b6fc0026 54) else if (ch >= 0x20)
b6fc0026 55) fputc(ch, stdout);
b6fc0026 56) else if (ch == 0x09 || ch == 0x0a || ch == 0x0d)
b6fc0026 57) fprintf(stdout, "&#x%02x;", ch);
b6fc0026 59) fputs(utf8_replace_character, stdout);
b6fc0026 60) } else if ((ch & 0xe0) == 0xc0) {
b6fc0026 62) tmp[0] = ch;
b6fc0026 63) remaining = 1;
b6fc0026 64) tmp2 = tmp + 1;
b6fc0026 65) } else if ((ch & 0xf0) == 0xe0) {
b6fc0026 67) tmp[0] = ch;
b6fc0026 68) remaining = 2;
b6fc0026 69) tmp2 = tmp + 1;
b6fc0026 70) } else if ((ch & 0xf8) == 0xf0) {
b6fc0026 72) tmp[0] = ch;
b6fc0026 73) remaining = 3;
b6fc0026 74) tmp2 = tmp + 1;
b6fc0026 76) fputs(utf8_replace_character, stdout);
b6fc0026 77) }

trace2.c
63ab7419 124) static void tr2main_signal_handler(int signo)
63ab7419 131) us_now = getnanotime() / 1000;
63ab7419 132) us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
63ab7419 134) for_each_wanted_builtin(j, tgt_j) {
63ab7419 135) if (tgt_j->pfn_signal)
63ab7419 136) tgt_j->pfn_signal(us_elapsed_absolute, signo);
63ab7419 139) sigchain_pop(signo);
63ab7419 140) raise(signo);
63ab7419 141) }
63ab7419 149) return;
63ab7419 233) void trace2_cmd_path_fl(const char *file, int line, const char *pathname)
63ab7419 238) if (!trace2_enabled)
63ab7419 239) return;
63ab7419 241) for_each_wanted_builtin(j, tgt_j) {
63ab7419 242) if (tgt_j->pfn_command_path_fl)
63ab7419 243) tgt_j->pfn_command_path_fl(file, line, pathname);
63ab7419 275) for_each_wanted_builtin(j, tgt_j) {
63ab7419 276) if (tgt_j->pfn_command_subverb_fl)
63ab7419 277) tgt_j->pfn_command_subverb_fl(file, line,
63ab7419 291) for_each_wanted_builtin(j, tgt_j) {
63ab7419 292) if (tgt_j->pfn_alias_fl)
63ab7419 293) tgt_j->pfn_alias_fl(file, line, alias, argv);
63ab7419 311) tr2_cfg_set_fl(file, line, key, value);
63ab7419 357) us_elapsed_child = 0;
63ab7419 381) us_now = getnanotime() / 1000;
63ab7419 382) us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
63ab7419 384) exec_id = tr2tls_locked_increment(&tr2_next_exec_id);
63ab7419 386) for_each_wanted_builtin(j, tgt_j) {
63ab7419 387) if (tgt_j->pfn_exec_fl)
63ab7419 388) tgt_j->pfn_exec_fl(file, line, us_elapsed_absolute,
63ab7419 392) return exec_id;
63ab7419 395) void trace2_exec_result_fl(const char *file, int line, int exec_id, int code)
63ab7419 402) if (!trace2_enabled)
63ab7419 403) return;
63ab7419 405) us_now = getnanotime() / 1000;
63ab7419 406) us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
63ab7419 408) for_each_wanted_builtin(j, tgt_j) {
63ab7419 409) if (tgt_j->pfn_exec_result_fl)
63ab7419 410) tgt_j->pfn_exec_result_fl(file, line,
63ab7419 416) void trace2_thread_start_fl(const char *file, int line,
63ab7419 424) if (!trace2_enabled)
63ab7419 425) return;
63ab7419 427) if (tr2tls_is_main_thread())
63ab7419 438) trace2_region_enter_printf_fl(file, line, NULL, NULL, NULL,
63ab7419 441) return;
63ab7419 444) us_now = getnanotime() / 1000;
63ab7419 445) us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
63ab7419 447) tr2tls_create_self(thread_name);
63ab7419 449) for_each_wanted_builtin(j, tgt_j) {
63ab7419 450) if (tgt_j->pfn_thread_start_fl)
63ab7419 451) tgt_j->pfn_thread_start_fl(file, line,
63ab7419 456) void trace2_thread_exit_fl(const char *file, int line)
63ab7419 464) if (!trace2_enabled)
63ab7419 465) return;
63ab7419 467) if (tr2tls_is_main_thread())
63ab7419 478) trace2_region_leave_printf_fl(file, line, NULL, NULL, NULL,
63ab7419 480) return;
63ab7419 483) us_now = getnanotime() / 1000;
63ab7419 484) us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
63ab7419 491) tr2tls_pop_unwind_self();
63ab7419 492) us_elapsed_thread = tr2tls_region_elasped_self(us_now);
63ab7419 494) for_each_wanted_builtin(j, tgt_j) {
63ab7419 495) if (tgt_j->pfn_thread_exit_fl)
63ab7419 496) tgt_j->pfn_thread_exit_fl(file, line,
63ab7419 501) tr2tls_unset_self();
63ab7419 511) return;
63ab7419 529) return;
63ab7419 553) us_now = getnanotime() / 1000;
63ab7419 554) us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
63ab7419 563) for_each_wanted_builtin(j, tgt_j) {
63ab7419 564) if (tgt_j->pfn_region_enter_printf_va_fl)
63ab7419 565) tgt_j->pfn_region_enter_printf_va_fl(
63ab7419 570) tr2tls_push_self(us_now);
63ab7419 628) us_now = getnanotime() / 1000;
63ab7419 629) us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
63ab7419 637) us_elapsed_region = tr2tls_region_elasped_self(us_now);
63ab7419 639) tr2tls_pop_self();
63ab7419 645) for_each_wanted_builtin(j, tgt_j) {
63ab7419 646) if (tgt_j->pfn_region_leave_printf_va_fl)
63ab7419 647) tgt_j->pfn_region_leave_printf_va_fl(
63ab7419 708) return;
63ab7419 733) strbuf_addf(&buf_string, "%"PRIdMAX, value);
63ab7419 734) trace2_data_string_fl(file, line, category, repo, key, buf_string.buf);
63ab7419 735) strbuf_release(&buf_string);
63ab7419 738) void trace2_data_json_fl(const char *file, int line,
63ab7419 750) if (!trace2_enabled)
63ab7419 751) return;
63ab7419 753) us_now = getnanotime() / 1000;
63ab7419 754) us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
63ab7419 755) us_elapsed_region = tr2tls_region_elasped_self(us_now);
63ab7419 757) for_each_wanted_builtin(j, tgt_j) {
63ab7419 758) if (tgt_j->pfn_data_fl)
63ab7419 759) tgt_j->pfn_data_json_fl(file, line, us_elapsed_absolute,
63ab7419 765) void trace2_printf_va_fl(const char *file, int line,
63ab7419 773) if (!trace2_enabled)
63ab7419 774) return;
63ab7419 776) us_now = getnanotime() / 1000;
63ab7419 777) us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
63ab7419 783) for_each_wanted_builtin(j, tgt_j) {
63ab7419 784) if (tgt_j->pfn_printf_va_fl)
63ab7419 785) tgt_j->pfn_printf_va_fl(file, line, us_elapsed_absolute,
63ab7419 790) void trace2_printf_fl(const char *file, int line,
63ab7419 795) va_start(ap, fmt);
63ab7419 796) trace2_printf_va_fl(file, line, fmt, ap);
63ab7419 797) va_end(ap);
63ab7419 798) }

trace2/tr2_cfg.c
63ab7419 21) return tr2_cfg_count_patterns;
63ab7419 33) strbuf_setlen(buf, buf->len - 1);
63ab7419 84) void tr2_cfg_set_fl(const char *file, int line,
63ab7419 87) struct tr2_cfg_data data = { file, line };
63ab7419 89) if (tr2_cfg_load_patterns() > 0)
63ab7419 90) tr2_cfg_cb(key, value, &data);

trace2/tr2_dst.c
63ab7419 27) dst->fd = STDERR_FILENO;
63ab7419 29) dst->fd = atoi(trace);
63ab7419 42) tr2_dst_trace_disable(dst);
63ab7419 48) warning("unknown trace value for '%s': %s\n"
63ab7419 52) tr2_dst_trace_disable(dst);
63ab7419 86) warning("unable to write trace for '%s': %s",
63ab7419 87) dst->env_var_name, strerror(errno));
63ab7419 88) tr2_dst_trace_disable(dst);

trace2/tr2_sid.c
63ab7419 27) return;
63ab7419 59) tr2_sid_compute();

trace2/tr2_tbuf.c
63ab7419 4) void tr2_tbuf_local_time(struct tr2_tbuf *tb)
63ab7419 10) gettimeofday(&tv, NULL);
63ab7419 11) secs = tv.tv_sec;
63ab7419 12) localtime_r(&secs, &tm);
63ab7419 14) xsnprintf(tb->buf, sizeof(tb->buf), "%02d:%02d:%02d.%06ld",
63ab7419 15)   tm.tm_hour, tm.tm_min, tm.tm_sec, (long)tv.tv_usec);
63ab7419 16) }

trace2/tr2_tgt_event.c
63ab7419 57) tr2env_event_nesting_wanted = want_nesting;
63ab7419 61) tr2env_event_brief = want_brief;
63ab7419 97)     !strcmp(event_name, "version") ||
63ab7419 98)     !strcmp(event_name, "atexit")) {
63ab7419 160) static void fn_signal(uint64_t us_elapsed_absolute, int signo)
63ab7419 162) const char *event_name = "signal";
63ab7419 163) struct json_writer jw = JSON_WRITER_INIT;
63ab7419 164) double t_abs = (double)us_elapsed_absolute / 1000000.0;
63ab7419 166) jw_object_begin(&jw, 0);
63ab7419 167) event_fmt_prepare(event_name, __FILE__, __LINE__, NULL, &jw);
63ab7419 168) jw_object_double(&jw, "t_abs", 6, t_abs);
63ab7419 169) jw_object_intmax(&jw, "signo", signo);
63ab7419 170) jw_end(&jw);
63ab7419 172) tr2_dst_write_line(&tr2dst_event, &jw.json);
63ab7419 173) jw_release(&jw);
63ab7419 174) }
63ab7419 209) if (fmt && *fmt) {
63ab7419 210) jw_object_string(jw, field_name, fmt);
63ab7419 211) return;
63ab7419 238) static void fn_command_path_fl(const char *file, int line,
63ab7419 241) const char *event_name = "cmd_path";
63ab7419 242) struct json_writer jw = JSON_WRITER_INIT;
63ab7419 244) jw_object_begin(&jw, 0);
63ab7419 245) event_fmt_prepare(event_name, file, line, NULL, &jw);
63ab7419 246) jw_object_string(&jw, "path", pathname);
63ab7419 247) jw_end(&jw);
63ab7419 249) tr2_dst_write_line(&tr2dst_event, &jw.json);
63ab7419 250) jw_release(&jw);
63ab7419 251) }
63ab7419 271) static void fn_command_subverb_fl(const char *file, int line,
63ab7419 274) const char *event_name = "cmd_subverb";
63ab7419 275) struct json_writer jw = JSON_WRITER_INIT;
63ab7419 277) jw_object_begin(&jw, 0);
63ab7419 278) event_fmt_prepare(event_name, file, line, NULL, &jw);
63ab7419 279) jw_object_string(&jw, "name", command_subverb);
63ab7419 280) jw_end(&jw);
63ab7419 282) tr2_dst_write_line(&tr2dst_event, &jw.json);
63ab7419 283) jw_release(&jw);
63ab7419 284) }
63ab7419 286) static void fn_alias_fl(const char *file, int line,
63ab7419 289) const char *event_name = "alias";
63ab7419 290) struct json_writer jw = JSON_WRITER_INIT;
63ab7419 292) jw_object_begin(&jw, 0);
63ab7419 293) event_fmt_prepare(event_name, file, line, NULL, &jw);
63ab7419 294) jw_object_string(&jw, "alias", alias);
63ab7419 295) jw_object_inline_begin_array(&jw, "argv");
63ab7419 296) jw_array_argv(&jw, argv);
63ab7419 297) jw_end(&jw);
63ab7419 298) jw_end(&jw);
63ab7419 300) tr2_dst_write_line(&tr2dst_event, &jw.json);
63ab7419 301) jw_release(&jw);
63ab7419 302) }
63ab7419 315) jw_object_string(&jw, "child_class", "hook");
63ab7419 316) jw_object_string(&jw, "hook_name", cmd->trace2_hook_name);
63ab7419 323) jw_object_string(&jw, "cd", cmd->dir);
63ab7419 327) jw_array_string(&jw, "git");
63ab7419 358) static void fn_thread_start_fl(const char *file, int line,
63ab7419 361) const char *event_name = "thread_start";
63ab7419 362) struct json_writer jw = JSON_WRITER_INIT;
63ab7419 364) jw_object_begin(&jw, 0);
63ab7419 365) event_fmt_prepare(event_name, file, line, NULL, &jw);
63ab7419 366) jw_end(&jw);
63ab7419 368) tr2_dst_write_line(&tr2dst_event, &jw.json);
63ab7419 369) jw_release(&jw);
63ab7419 370) }
63ab7419 372) static void fn_thread_exit_fl(const char *file, int line,
63ab7419 376) const char *event_name = "thread_exit";
63ab7419 377) struct json_writer jw = JSON_WRITER_INIT;
63ab7419 378) double t_rel = (double)us_elapsed_thread / 1000000.0;
63ab7419 380) jw_object_begin(&jw, 0);
63ab7419 381) event_fmt_prepare(event_name, file, line, NULL, &jw);
63ab7419 382) jw_object_double(&jw, "t_rel", 6, t_rel);
63ab7419 383) jw_end(&jw);
63ab7419 385) tr2_dst_write_line(&tr2dst_event, &jw.json);
63ab7419 386) jw_release(&jw);
63ab7419 387) }
63ab7419 389) static void fn_exec_fl(const char *file, int line,
63ab7419 393) const char *event_name = "exec";
63ab7419 394) struct json_writer jw = JSON_WRITER_INIT;
63ab7419 396) jw_object_begin(&jw, 0);
63ab7419 397) event_fmt_prepare(event_name, file, line, NULL, &jw);
63ab7419 398) jw_object_intmax(&jw, "exec_id", exec_id);
63ab7419 399) if (exe)
63ab7419 400) jw_object_string(&jw, "exe", exe);
63ab7419 401) jw_object_inline_begin_array(&jw, "argv");
63ab7419 402) jw_array_argv(&jw, argv);
63ab7419 403) jw_end(&jw);
63ab7419 404) jw_end(&jw);
63ab7419 406) tr2_dst_write_line(&tr2dst_event, &jw.json);
63ab7419 407) jw_release(&jw);
63ab7419 408) }
63ab7419 410) static void fn_exec_result_fl(const char *file, int line,
63ab7419 414) const char *event_name = "exec_result";
63ab7419 415) struct json_writer jw = JSON_WRITER_INIT;
63ab7419 417) jw_object_begin(&jw, 0);
63ab7419 418) event_fmt_prepare(event_name, file, line, NULL, &jw);
63ab7419 419) jw_object_intmax(&jw, "exec_id", exec_id);
63ab7419 420) jw_object_intmax(&jw, "code", code);
63ab7419 421) jw_end(&jw);
63ab7419 423) tr2_dst_write_line(&tr2dst_event, &jw.json);
63ab7419 424) jw_release(&jw);
63ab7419 425) }
63ab7419 458) static void fn_region_enter_printf_va_fl(const char *file, int line,
63ab7419 465) const char *event_name = "region_enter";
63ab7419 466) struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
63ab7419 467) if (ctx->nr_open_regions <= tr2env_event_nesting_wanted) {
63ab7419 468) struct json_writer jw = JSON_WRITER_INIT;
63ab7419 470) jw_object_begin(&jw, 0);
63ab7419 471) event_fmt_prepare(
63ab7419 473) jw_object_intmax(&jw, "nesting", ctx->nr_open_regions);
63ab7419 474) if (category)
63ab7419 475) jw_object_string(&jw, "category", category);
63ab7419 476) if (label)
63ab7419 477) jw_object_string(&jw, "label", label);
63ab7419 478) maybe_add_string_va(&jw, "msg", fmt, ap);
63ab7419 479) jw_end(&jw);
63ab7419 481) tr2_dst_write_line(&tr2dst_event, &jw.json);
63ab7419 482) jw_release(&jw);
63ab7419 484) }
63ab7419 486) static void fn_region_leave_printf_va_fl(const char *file, int line,
63ab7419 494) const char *event_name = "region_leave";
63ab7419 495) struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
63ab7419 496) if (ctx->nr_open_regions <= tr2env_event_nesting_wanted) {
63ab7419 497) struct json_writer jw = JSON_WRITER_INIT;
63ab7419 498) double t_rel = (double)us_elapsed_region / 1000000.0;
63ab7419 500) jw_object_begin(&jw, 0);
63ab7419 501) event_fmt_prepare(event_name, file, line, repo, &jw);
63ab7419 502) jw_object_double(&jw, "t_rel", 6, t_rel);
63ab7419 503) jw_object_intmax(&jw, "nesting", ctx->nr_open_regions);
63ab7419 504) if (category)
63ab7419 505) jw_object_string(&jw, "category", category);
63ab7419 506) if (label)
63ab7419 507) jw_object_string(&jw, "label", label);
63ab7419 508) maybe_add_string_va(&jw, "msg", fmt, ap);
63ab7419 509) jw_end(&jw);
63ab7419 511) tr2_dst_write_line(&tr2dst_event, &jw.json);
63ab7419 512) jw_release(&jw);
63ab7419 514) }
63ab7419 546) static void fn_data_json_fl(const char *file, int line,
63ab7419 554) const char *event_name = "data_json";
63ab7419 555) struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
63ab7419 556) if (ctx->nr_open_regions <= tr2env_event_nesting_wanted) {
63ab7419 557) struct json_writer jw = JSON_WRITER_INIT;
63ab7419 558) double t_abs = (double)us_elapsed_absolute / 1000000.0;
63ab7419 559) double t_rel = (double)us_elapsed_region / 1000000.0;
63ab7419 561) jw_object_begin(&jw, 0);
63ab7419 562) event_fmt_prepare(event_name, file, line, repo, &jw);
63ab7419 563) jw_object_double(&jw, "t_abs", 6, t_abs);
63ab7419 564) jw_object_double(&jw, "t_rel", 6, t_rel);
63ab7419 565) jw_object_intmax(&jw, "nesting", ctx->nr_open_regions);
63ab7419 566) jw_object_string(&jw, "category", category);
63ab7419 567) jw_object_string(&jw, "key", key);
63ab7419 568) jw_object_sub_jw(&jw, "value", value);
63ab7419 569) jw_end(&jw);
63ab7419 571) tr2_dst_write_line(&tr2dst_event, &jw.json);
63ab7419 572) jw_release(&jw);
63ab7419 574) }

trace2/tr2_tgt_normal.c
63ab7419 53) tr2_tbuf_local_time(&tb_now);
63ab7419 54) strbuf_addstr(buf, tb_now.buf);
63ab7419 55) strbuf_addch(buf, ' ');
63ab7419 57) if (file && *file)
63ab7419 58) strbuf_addf(buf, "%s:%d ", file, line);
63ab7419 59) while (buf->len < TR2FMT_NORMAL_FL_WIDTH)
63ab7419 60) strbuf_addch(buf, ' ');
63ab7419 106) static void fn_signal(uint64_t us_elapsed_absolute, int signo)
63ab7419 108) struct strbuf buf_payload = STRBUF_INIT;
63ab7419 109) double elapsed = (double)us_elapsed_absolute / 1000000.0;
63ab7419 111) strbuf_addf(&buf_payload, "signal elapsed:%.6f code:%d",
63ab7419 113) normal_io_write_fl(__FILE__, __LINE__, &buf_payload);
63ab7419 114) strbuf_release(&buf_payload);
63ab7419 115) }
63ab7419 140) if (fmt && *fmt) {
63ab7419 141) strbuf_addstr(buf, fmt);
63ab7419 142) return;
63ab7419 157) static void fn_command_path_fl(const char *file, int line,
63ab7419 160) struct strbuf buf_payload = STRBUF_INIT;
63ab7419 162) strbuf_addf(&buf_payload, "cmd_path %s", pathname);
63ab7419 163) normal_io_write_fl(file, line, &buf_payload);
63ab7419 164) strbuf_release(&buf_payload);
63ab7419 165) }
63ab7419 180) static void fn_command_subverb_fl(const char *file, int line,
63ab7419 183) struct strbuf buf_payload = STRBUF_INIT;
63ab7419 185) strbuf_addf(&buf_payload, "cmd_subverb %s", command_subverb);
63ab7419 186) normal_io_write_fl(file, line, &buf_payload);
63ab7419 187) strbuf_release(&buf_payload);
63ab7419 188) }
63ab7419 190) static void fn_alias_fl(const char *file, int line, const char *alias,
63ab7419 193) struct strbuf buf_payload = STRBUF_INIT;
63ab7419 195) strbuf_addf(&buf_payload, "alias %s ->", alias);
63ab7419 196) sq_quote_argv_pretty(&buf_payload, argv);
63ab7419 197) normal_io_write_fl(file, line, &buf_payload);
63ab7419 198) strbuf_release(&buf_payload);
63ab7419 199) }
63ab7419 201) static void fn_child_start_fl(const char *file, int line,
63ab7419 205) struct strbuf buf_payload = STRBUF_INIT;
63ab7419 207) strbuf_addf(&buf_payload, "child_start[%d] ", cmd->trace2_child_id);
63ab7419 209) if (cmd->dir) {
63ab7419 210) strbuf_addstr(&buf_payload, " cd");
63ab7419 211) sq_quote_buf_pretty(&buf_payload, cmd->dir);
63ab7419 212) strbuf_addstr(&buf_payload, "; ");
63ab7419 220) if (cmd->git_cmd)
63ab7419 221) strbuf_addstr(&buf_payload, "git");
63ab7419 222) sq_quote_argv_pretty(&buf_payload, cmd->argv);
63ab7419 224) normal_io_write_fl(file, line, &buf_payload);
63ab7419 225) strbuf_release(&buf_payload);
63ab7419 226) }
63ab7419 228) static void fn_child_exit_fl(const char *file, int line,
63ab7419 233) struct strbuf buf_payload = STRBUF_INIT;
63ab7419 234) double elapsed = (double)us_elapsed_child / 1000000.0;
63ab7419 236) strbuf_addf(&buf_payload, "child_exit[%d] pid:%d code:%d elapsed:%.6f",
63ab7419 238) normal_io_write_fl(file, line, &buf_payload);
63ab7419 239) strbuf_release(&buf_payload);
63ab7419 240) }
63ab7419 242) static void fn_exec_fl(const char *file, int line,
63ab7419 246) struct strbuf buf_payload = STRBUF_INIT;
63ab7419 248) strbuf_addf(&buf_payload, "exec[%d] ", exec_id);
63ab7419 249) if (exe)
63ab7419 250) strbuf_addstr(&buf_payload, exe);
63ab7419 251) sq_quote_argv_pretty(&buf_payload, argv);
63ab7419 252) normal_io_write_fl(file, line, &buf_payload);
63ab7419 253) strbuf_release(&buf_payload);
63ab7419 254) }
63ab7419 256) static void fn_exec_result_fl(const char *file, int line,
63ab7419 260) struct strbuf buf_payload = STRBUF_INIT;
63ab7419 262) strbuf_addf(&buf_payload, "exec_result[%d] code:%d", exec_id, code);
63ab7419 263) if (code > 0)
63ab7419 264) strbuf_addf(&buf_payload, " err:%s", strerror(code));
63ab7419 265) normal_io_write_fl(file, line, &buf_payload);
63ab7419 266) strbuf_release(&buf_payload);
63ab7419 267) }
63ab7419 269) static void fn_param_fl(const char *file, int line, const char *param,
63ab7419 272) struct strbuf buf_payload = STRBUF_INIT;
63ab7419 274) strbuf_addf(&buf_payload, "def_param %s=%s", param, value);
63ab7419 275) normal_io_write_fl(file, line, &buf_payload);
63ab7419 276) strbuf_release(&buf_payload);
63ab7419 277) }
63ab7419 279) static void fn_repo_fl(const char *file, int line,
63ab7419 282) struct strbuf buf_payload = STRBUF_INIT;
63ab7419 284) strbuf_addstr(&buf_payload, "worktree ");
63ab7419 285) sq_quote_buf_pretty(&buf_payload, repo->worktree);
63ab7419 286) normal_io_write_fl(file, line, &buf_payload);
63ab7419 287) strbuf_release(&buf_payload);
63ab7419 288) }
63ab7419 290) static void fn_printf_va_fl(const char *file, int line,
63ab7419 294) struct strbuf buf_payload = STRBUF_INIT;
63ab7419 296) maybe_append_string_va(&buf_payload, fmt, ap);
63ab7419 297) normal_io_write_fl(file, line, &buf_payload);
63ab7419 298) strbuf_release(&buf_payload);
63ab7419 299) }

trace2/tr2_tgt_perf.c
63ab7419 83) tr2_tbuf_local_time(&tb_now);
63ab7419 84) strbuf_addstr(buf, tb_now.buf);
63ab7419 85) strbuf_addch(buf, ' ');
63ab7419 87) if (file && *file)
63ab7419 88) strbuf_addf(buf, "%s:%d ", file, line);
63ab7419 89) while (buf->len < TR2FMT_PERF_FL_WIDTH)
63ab7419 90) strbuf_addch(buf, ' ');
63ab7419 92) strbuf_addstr(buf, "| ");
63ab7419 102) strbuf_addf(buf, "r%d ", repo->trace2_repo_id);
63ab7419 125) strbuf_addf(buf, "%s", dots.buf);
63ab7419 126) len_indent -= dots.len;
63ab7419 192) static void fn_signal(uint64_t us_elapsed_absolute, int signo)
63ab7419 194) const char *event_name = "signal";
63ab7419 195) struct strbuf buf_payload = STRBUF_INIT;
63ab7419 197) strbuf_addf(&buf_payload, "signo:%d", signo);
63ab7419 199) perf_io_write_fl(__FILE__, __LINE__, event_name, NULL,
63ab7419 202) strbuf_release(&buf_payload);
63ab7419 203) }
63ab7419 230) if (fmt && *fmt) {
63ab7419 231) strbuf_addstr(buf, fmt);
63ab7419 232) return;
63ab7419 250) static void fn_command_path_fl(const char *file, int line,
63ab7419 253) const char *event_name = "cmd_path";
63ab7419 254) struct strbuf buf_payload = STRBUF_INIT;
63ab7419 256) strbuf_addstr(&buf_payload, pathname);
63ab7419 258) perf_io_write_fl(file, line, event_name, NULL,
63ab7419 261) strbuf_release(&buf_payload);
63ab7419 262) }
63ab7419 281) static void fn_command_subverb_fl(const char *file, int line,
63ab7419 284) const char *event_name = "cmd_subverb";
63ab7419 285) struct strbuf buf_payload = STRBUF_INIT;
63ab7419 287) strbuf_addstr(&buf_payload, command_subverb);
63ab7419 289) perf_io_write_fl(file, line, event_name, NULL,
63ab7419 292) strbuf_release(&buf_payload);
63ab7419 293) }
63ab7419 295) static void fn_alias_fl(const char *file, int line, const char *alias,
63ab7419 298) const char *event_name = "alias";
63ab7419 299) struct strbuf buf_payload = STRBUF_INIT;
63ab7419 301) strbuf_addf(&buf_payload, "alias:%s argv:", alias);
63ab7419 302) sq_quote_argv_pretty(&buf_payload, argv);
63ab7419 304) perf_io_write_fl(file, line, event_name, NULL,
63ab7419 307) strbuf_release(&buf_payload);
63ab7419 308) }
63ab7419 318) strbuf_addf(&buf_payload, "[ch%d] class:hook hook:%s",
63ab7419 328) strbuf_addstr(&buf_payload, " cd:");
63ab7419 329) sq_quote_buf_pretty(&buf_payload, cmd->dir);
63ab7419 334) strbuf_addstr(&buf_payload, " git");
63ab7419 359) static void fn_thread_start_fl(const char *file, int line,
63ab7419 362) const char *event_name = "thread_start";
63ab7419 363) struct strbuf buf_payload = STRBUF_INIT;
63ab7419 365) perf_io_write_fl(file, line, event_name, NULL,
63ab7419 368) strbuf_release(&buf_payload);
63ab7419 369) }
63ab7419 371) static void fn_thread_exit_fl(const char *file, int line,
63ab7419 375) const char *event_name = "thread_exit";
63ab7419 376) struct strbuf buf_payload = STRBUF_INIT;
63ab7419 378) perf_io_write_fl(file, line, event_name, NULL,
63ab7419 381) strbuf_release(&buf_payload);
63ab7419 382) }
63ab7419 384) static void fn_exec_fl(const char *file, int line,
63ab7419 388) const char *event_name = "exec";
63ab7419 389) struct strbuf buf_payload = STRBUF_INIT;
63ab7419 391) strbuf_addf(&buf_payload, "id:%d ", exec_id);
63ab7419 392) strbuf_addstr(&buf_payload, "argv:");
63ab7419 393) if (exe)
63ab7419 394) strbuf_addf(&buf_payload, " %s", exe);
63ab7419 395) sq_quote_argv_pretty(&buf_payload, argv);
63ab7419 397) perf_io_write_fl(file, line, event_name, NULL,
63ab7419 400) strbuf_release(&buf_payload);
63ab7419 401) }
63ab7419 403) static void fn_exec_result_fl(const char *file, int line,
63ab7419 407) const char *event_name = "exec_result";
63ab7419 408) struct strbuf buf_payload = STRBUF_INIT;
63ab7419 410) strbuf_addf(&buf_payload, "id:%d code:%d", exec_id, code);
63ab7419 411) if (code > 0)
63ab7419 412) strbuf_addf(&buf_payload, " err:%s", strerror(code));
63ab7419 414) perf_io_write_fl(file, line, event_name, NULL,
63ab7419 417) strbuf_release(&buf_payload);
63ab7419 418) }
63ab7419 420) static void fn_param_fl(const char *file, int line,
63ab7419 423) const char *event_name = "def_param";
63ab7419 424) struct strbuf buf_payload = STRBUF_INIT;
63ab7419 426) strbuf_addf(&buf_payload, "%s:%s", param, value);
63ab7419 428) perf_io_write_fl(file, line, event_name, NULL,
63ab7419 431) strbuf_release(&buf_payload);
63ab7419 432) }
63ab7419 434) static void fn_repo_fl(const char *file, int line,
63ab7419 437) const char *event_name = "def_repo";
63ab7419 438) struct strbuf buf_payload = STRBUF_INIT;
63ab7419 440) strbuf_addstr(&buf_payload, "worktree:");
63ab7419 441) sq_quote_buf_pretty(&buf_payload, repo->worktree);
63ab7419 443) perf_io_write_fl(file, line, event_name, repo,
63ab7419 446) strbuf_release(&buf_payload);
63ab7419 447) }
63ab7419 449) static void fn_region_enter_printf_va_fl(const char *file, int line,
63ab7419 456) const char *event_name = "region_enter";
63ab7419 457) struct strbuf buf_payload = STRBUF_INIT;
63ab7419 459) if (label)
63ab7419 460) strbuf_addf(&buf_payload, "label:%s ", label);
63ab7419 461) maybe_append_string_va(&buf_payload, fmt, ap);
63ab7419 463) perf_io_write_fl(file, line, event_name, repo,
63ab7419 466) strbuf_release(&buf_payload);
63ab7419 467) }
63ab7419 469) static void fn_region_leave_printf_va_fl(const char *file, int line,
63ab7419 477) const char *event_name = "region_leave";
63ab7419 478) struct strbuf buf_payload = STRBUF_INIT;
63ab7419 480) if (label)
63ab7419 481) strbuf_addf(&buf_payload, "label:%s ", label);
63ab7419 482) maybe_append_string_va(&buf_payload, fmt, ap);
63ab7419 484) perf_io_write_fl(file, line, event_name, repo,
63ab7419 487) strbuf_release(&buf_payload);
63ab7419 488) }
63ab7419 490) static void fn_data_fl(const char *file, int line,
63ab7419 498) const char *event_name = "data";
63ab7419 499) struct strbuf buf_payload = STRBUF_INIT;
63ab7419 501) strbuf_addf(&buf_payload, "%s:%s", key, value);
63ab7419 503) perf_io_write_fl(file, line, event_name, repo,
63ab7419 506) strbuf_release(&buf_payload);
63ab7419 507) }
63ab7419 509) static void fn_data_json_fl(const char *file, int line,
63ab7419 517) const char *event_name = "data_json";
63ab7419 518) struct strbuf buf_payload = STRBUF_INIT;
63ab7419 520) strbuf_addf(&buf_payload, "%s:%s", key, value->json.buf);
63ab7419 522) perf_io_write_fl(file, line, event_name, repo,
63ab7419 525) strbuf_release(&buf_payload);
63ab7419 526) }
63ab7419 528) static void fn_printf_va_fl(const char *file, int line,
63ab7419 532) const char *event_name = "printf";
63ab7419 533) struct strbuf buf_payload = STRBUF_INIT;
63ab7419 535) maybe_append_string_va(&buf_payload, fmt, ap);
63ab7419 537) perf_io_write_fl(file, line, event_name, NULL,
63ab7419 540) strbuf_release(&buf_payload);
63ab7419 541) }

trace2/tr2_tls.c
63ab7419 38) strbuf_addf(&ctx->thread_name, "th%02d:", ctx->thread_id);
63ab7419 41) strbuf_setlen(&ctx->thread_name, TR2_MAX_THREAD_NAME);
63ab7419 58) ctx = tr2tls_create_self("unknown");
63ab7419 63) int tr2tls_is_main_thread(void)
63ab7419 65) struct tr2tls_thread_ctx * ctx = pthread_getspecific(tr2tls_key);
63ab7419 67) return ctx == tr2tls_thread_main;
63ab7419 82) void tr2tls_push_self(uint64_t us_now)
63ab7419 84) struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
63ab7419 86) ALLOC_GROW(ctx->array_us_start, ctx->nr_open_regions + 1, ctx->alloc);
63ab7419 87) ctx->array_us_start[ctx->nr_open_regions++] = us_now;
63ab7419 88) }
63ab7419 90) void tr2tls_pop_self(void)
63ab7419 92) struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
63ab7419 94) if (!ctx->nr_open_regions)
63ab7419 95) BUG("no open regions in thread '%s'", ctx->thread_name.buf);
63ab7419 97) ctx->nr_open_regions--;
63ab7419 98) }
63ab7419 105) tr2tls_pop_self();
63ab7419 115) return 0;
63ab7419 125) return 0;

utf8.c
76759c7d 553) return NULL;

wrapper.c
5efde212 70) die("Out of memory, malloc failed (tried to allocate %" PRIuMAX " bytes)",
5efde212 73) error("Out of memory, malloc failed (tried to allocate %" PRIuMAX " bytes)",

Commits introducting uncovered code:
Ævar Arnfjörð Bjarmason	6a83d902 coccinelle: make use of the "type" FREE_AND_NULL() rule
Alban Gruin	febebd99 sequencer: refactor rearrange_squash() to work on a todo_list
Alban Gruin	c27b32f0 sequencer: refactor check_todo_list() to work on a todo_list
Alban Gruin	4d55dfd7 rebase-interactive: move transform_todo_file() to rebase--interactive.c
Alban Gruin	8414c890 sequencer: refactor sequencer_add_exec_commands() to work on a todo_list
Alban Gruin	e5b1c9d9 rebase-interactive: rewrite edit_todo_list() to handle the initial edit
Anders Waldenborg	4681fe38 pretty: allow showing specific trailers
Anders Waldenborg	b755bf6f pretty: allow %(trailers) options with explicit value
Barret Rhoden	07d04b91 blame: add a config option to mark ignored lines
Barret Rhoden	e7973c85 blame: add the ability to ignore commits and their changes
Barret Rhoden	ef644c41 Move init_skiplist() outside of fsck
Brandon Williams	373d70ef protocol: introduce protocol extension mechanisms
Brandon Williams	0f1dc53f remote-curl: implement stateless-connect command
Brian Gianforcaro	eeefa7c9 Style fixes, add a space after if/for/while.
brian m. carlson	6390fe20 pack-redundant: convert linked lists to use struct object_id
Charles Bailey	2a514ed8 parse-options: move unsigned long option parsing out of pack-objects.c
David Turner	d1dd94b3 Do not print 'dangling' for cat-file in case of ambiguity
Derrick Stolee	4f6d26b1 list-objects: consume sparse tree walk
Derrick Stolee	d5d2e935 revision: implement sparse algorithm
Derrick Stolee	f1f5de44 revision: add mark_tree_uninteresting_sparse
Eugene Letuchy	31653c1a Make git blame's date output format configurable, like git log
Jeff Hostetler	3e56cbd8 trace2: t/helper/test-trace2, t0210.sh, t0211.sh, t0212.sh
Jeff Hostetler	63ab7419 trace2: create new combined trace facility
Jeff Hostetler	603036d9 trace2:data: add editor/pager child classification
Jeff King	01f8d594 prefer "hash mismatch" to "sha1 mismatch"
Jeff King	34a9469d remote-curl: refactor smart-http discovery
Jeff King	76011357 sha1-file: prefer "loose object file" to "sha1 file" in messages
Jeff King	2c319886 sha1-file: avoid "sha1 file" for generic use in messages
Jeff King	dd63f169 move "--follow needs one pathspec" rule to diff_setup_done
Jeff King	246f0ede execv_dashed_external: stop exiting with negative code
Jeff King	a5481a6c convert "enum date_mode" into a struct
Jeff Smith	b543bb1c blame: move scoreboard-related methods to libgit
Jiang Xin	cb7e0336 pack-redundant: rename pack_list.all_objects
Joel Teichroeb	f6bbd781 stash: convert apply to builtin
Joel Teichroeb	cdca49bc stash: convert drop and clear to builtin
Joel Teichroeb	e1d01876 stash: convert pop to builtin
Johannes Schindelin	5f1a63e0 Read configuration also from $HOME/.gitconfig
Johannes Schindelin	3546c8d9 rebase -i: also expand/collapse the SHA-1s via the rebase--helper
Johannes Schindelin	d04fa788 ci: parallelize testing on Windows
Johannes Schindelin	dc2d9ba3 is_{hfs,ntfs}_dotgitmodules: add tests
Johannes Schindelin	a5c09131 tests: avoid calling Perl just to determine file sizes
Johannes Schindelin	cdac2b01 rebase -i: skip unnecessary picks using the rebase--helper
Johannes Schindelin	2987e8cd tests: include detailed trace logs with --write-junit-xml upon failure
Johannes Schindelin	b6fc0026 tests: optionally write results as JUnit-style .xml
Johannes Schindelin	033abf97 Replace all die("BUG: ...") calls by BUG() ones
Johannes Schindelin	26799a20 stash: optionally use the scripted version again
Johannes Schindelin	bec65d5b tests: add a special setup where stash.useBuiltin is off
Johannes Sixt	0ac77ec3 run_command: report system call errors instead of returning error codes
Jonathan Nieder	7d29afd4 i18n: mark relative dates for translation
Jonathan Nieder	309be813 update-index: migrate to parse-options API
Jonathan Nieder	1e5ce570 parse-options: clearer reporting of API misuse
Josh Steadmon	6da1f1a9 protocol: advertise multiple supported versions
Junio C Hamano	93c1e079 config-set: check write-in-full returns in set_multivar
Junio C Hamano	9409c7a5 config: "git config baa" should exit with status 1
Junio C Hamano	af465af8 parse-options: detect attempt to add a duplicate short option name
Liam Beguin	0cce4a27 rebase -i -x: add exec commands via the rebase--helper
Linus Torvalds	acdd3776 Add 'human' date format
Lukas_Sandström	1c3039e8 Make git-pack-redundant consider alt-odbs
Martin Koegler	5efde212 zlib.c: use size_t for size
Nguyễn Thái Ngọc Duy	a12c1ff3 config: factor out set_config_source_file()
Nguyễn Thái Ngọc Duy	1d28ff4c builtin/config.c: mark more strings for translation
Nguyễn Thái Ngọc Duy	a92ec7ef parse-options: fix SunCC compiler warning
Nguyễn Thái Ngọc Duy	f62470c6 parse-options: add OPT_BITOP()
Nguyễn Thái Ngọc Duy	b221b5ab completion: collapse extra --no-.. options
Nguyễn Thái Ngọc Duy	8f7c7f55 config.c: add repo_config_set_worktree_gently()
Nguyễn Thái Ngọc Duy	ebc4a04e remote: force completing --mirror= instead of --mirror
Nguyễn Thái Ngọc Duy	b9d7f4b4 parse-options: support --git-completion-helper
Nguyễn Thái Ngọc Duy	3ebbe289 parse-options: allow ll_callback with OPTION_CALLBACK
Nguyễn Thái Ngọc Duy	aad6fddb connect.c: mark more strings for translation
Nguyễn Thái Ngọc Duy	8aa8c140 git.c: mark more strings for translation
Nguyễn Thái Ngọc Duy	d473e2e0 diff.c: convert -U|--unified
Paul-Sebastian Ungureanu	bfc3fe33 strbuf.c: add `strbuf_insertf()` and `strbuf_vinsertf()`
Paul-Sebastian Ungureanu	9a95010a stash: make push -q quiet
Paul-Sebastian Ungureanu	847eb0b0 stash: convert store to builtin
Paul-Sebastian Ungureanu	fa38428f stash: convert push to builtin
Paul-Sebastian Ungureanu	1f5a011d stash: convert create to builtin
Paul-Sebastian Ungureanu	b4493f26 stash: convert show to builtin
Paul-Sebastian Ungureanu	51809c70 stash: convert `stash--helper.c` into `stash.c`
Peter Krefting	78bde923 i18n: read-cache: typofix
Pierre Habouzit	5817da01 git-blame: migrate to incremental parse-option [1/2]
Pratik Karki	c54dacb5 builtin rebase: start a new rebase only if none is in progress
Stefan Beller	c553c72e run-command: add an asynchronous parallel child processor
Stefan Xenos	9e98e9b6 sha1-array: implement oid_array_readonly_contains()
Stefan Xenos	73f8829d evolve: implement the 'git change' command
Stefan Xenos	6b8678e5 evolve: add support for writing metacommits
Stefan Xenos	287a8679 evolve: add the change-table structure
Stefan Xenos	49854277 evolve: add the 'git change list' command
Stefan Xenos	6930f34d evolve: add support for parsing metacommits
Stephen Boyd	df217ed6 parse-opts: add OPT_FILENAME and transition builtins
Takashi Iwai	507d7804 pager: don't use unsafe functions in signal handlers
Timo Hirvonen	bd22c904 Fix sparse warnings
Torsten Bögershausen	76759c7d git on Mac OS and precomposed unicode


Uncovered code in 'jch' not in 'next'
--------------------------------------------------------

builtin/add.c
9472935d 140) continue;

builtin/am.c
7ff26832 1834) write_index_patch(state);

builtin/archive.c
01f9ec64 63) if (starts_with(reader.line, "NACK "))
01f9ec64 64) die(_("git archive: NACK %s"), reader.line + 5);

builtin/bisect--helper.c
ecb3f373 111) return error(_("please use two different terms"));
ecb3f373 118) return error_errno(_("could not open the file BISECT_TERMS"));
5e82c3dd 162) if (get_oid_commit(commit, &oid))
5e82c3dd 163) return error(_("'%s' is not a valid commit"), commit);
5e82c3dd 164) strbuf_addstr(&branch, commit);
5e82c3dd 172) strbuf_release(&branch);
5e82c3dd 173) argv_array_clear(&argv);
5e82c3dd 174) return error(_("could not check out original"
0f30233a 215) retval = error(_("Bad bisect_write argument: %s"), state);
0f30233a 216) goto finish;
0f30233a 220) retval = error(_("couldn't get the oid of the rev '%s'"), rev);
0f30233a 221) goto finish;
0f30233a 226) retval = -1;
0f30233a 227) goto finish;
0f30233a 232) retval = error_errno(_("couldn't open the file '%s'"), git_path_bisect_log());
0f30233a 233) goto finish;
129a6cf3 329) yesno = git_prompt(_("Are you sure [Y/n]? "), PROMPT_ECHO);
129a6cf3 330) if (starts_with(yesno, "N") || starts_with(yesno, "n"))
129a6cf3 331) retval = -1;
129a6cf3 332) goto finish;
129a6cf3 338) retval = error(_(need_bisect_start_warning),
450ebb73 389) return error(_("invalid argument %s for 'git bisect terms'.\n"
06f5608c 404) return -1;
06f5608c 407) retval = -1;
06f5608c 408) goto finish;
06f5608c 413) retval = -1;
06f5608c 452) no_checkout = 1;
06f5608c 474)  !one_of(arg, "--term-good", "--term-bad", NULL)) {
06f5608c 475) return error(_("unrecognized option: '%s'"), arg);
06f5608c 510) if (get_oid("HEAD", &head_oid))
06f5608c 511) return error(_("bad HEAD - I need a HEAD"));
06f5608c 526) retval = error(_("checking out '%s' failed."
06f5608c 547) return error(_("won't bisect on cg-seek'ed tree"));
06f5608c 550) return error(_("bad HEAD - strange symbolic ref"));
06f5608c 558) return -1;
06f5608c 576) retval = -1;
06f5608c 577) goto finish;

builtin/branch.c
0ecb1fc7 460) die(_("could not resolve HEAD"));

builtin/commit.c
b64c1e07 739) die_errno(_("could not read SQUASH_MSG"));
8a6179bc 746) die_errno(_("could not read MERGE_MSG"));

builtin/diff-tree.c
ff7fe37b 168) if (!the_index.cache)

builtin/merge.c
66f4b98a 797) error("%s", err_msg);
62dc42b9 819) BUG("the control must not reach here under --squash");

builtin/notes.c
033abf97 556) BUG("combine_notes_overwrite failed");

builtin/pack-objects.c
ac77d0c3 2008) die(_("unable to parse object header of %s"),
ca473cef 2081) die(_("object %s inconsistent object length (%"PRIuMAX" vs %"PRIuMAX")"),
f616db6a 2094) warning(_("object %s cannot be read"),

builtin/pull.c
11b6d178 642) argv_array_push(&args, opt_squash);

builtin/rebase.c
21853626 259) write_file(state_dir_path("verbose", opts), "%s", "");
21853626 261) write_file(state_dir_path("strategy", opts), "%s",
21853626 264) write_file(state_dir_path("strategy_opts", opts), "%s",
21853626 271) write_file(state_dir_path("gpg_sign_opt", opts), "%s",
21853626 274) write_file(state_dir_path("strategy", opts), "--signoff");
c5233708 394) BUG("Not a fully qualified branch: '%s'", switch_to_branch);
c5233708 397) ret = -1;
c5233708 398) goto leave_reset_head;
c5233708 402) ret = error(_("could not determine HEAD revision"));
c5233708 403) goto leave_reset_head;
c5233708 424) ret = error(_("could not read index"));
c5233708 425) goto leave_reset_head;
c5233708 429) ret = error(_("failed to find tree of %s"),
c5233708 431) goto leave_reset_head;
c5233708 435) ret = error(_("failed to find tree of %s"), oid_to_hex(oid));
c5233708 436) goto leave_reset_head;
c5233708 448) ret = error(_("could not write index"));
c5233708 449) goto leave_reset_head;
c5233708 467) } else if (old_orig)
c5233708 468) delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
122420c2 1268) exit(1);

builtin/receive-pack.c
01f9ec64 1587)     reader->line + 8);
a85b377d 1617) true_flush = 1;
01f9ec64 1621) die("protocol error: got an unexpected packet");

builtin/remote.c
f39a9c65 1575) die(_("--save-to-push can only be used when only one url is defined"));

commit-graph.c
aa658574 127) return NULL;
aa658574 130) return NULL;
cce99cd8 562) BUG("missing parent %s for commit %s",
4f5b532d 882) die(_("error adding pack %s"), packname.buf);
4f5b532d 884) die(_("error opening index for %s"), packname.buf);

config.c
7e43b32b 1488) return git_ident_config(var, value, cb);
7e43b32b 1491) return git_ident_config(var, value, cb);

fetch-pack.c
01f9ec64 154) die(_("git fetch-pack: expected a flush packet after shallow list"));
1dd73e20 256) die(_("--stateless-rpc requires multi_ack_detailed"));
01f9ec64 364) die(_("invalid unshallow line: %s"), reader.line);

http-walker.c
514c5fdd 550) loose_object_path(the_repository, &buf, &req->oid);

ident.c
862e80a4 385) fputs(_(env_hint), stderr);
d6991cee 491) int author_ident_sufficiently_given(void)
d6991cee 493) return ident_is_sufficient(author_ident_explicitly_given);
7e43b32b 504) if (!value)
7e43b32b 505) return config_error_nonbool(var);
7e43b32b 506) strbuf_reset(&git_author_name);
7e43b32b 507) strbuf_addstr(&git_author_name, value);
7e43b32b 508) author_ident_explicitly_given |= IDENT_NAME_GIVEN;
7e43b32b 509) ident_config_given |= IDENT_NAME_GIVEN;
7e43b32b 510) return 0;
7e43b32b 514) if (!value)
7e43b32b 515) return config_error_nonbool(var);
7e43b32b 516) strbuf_reset(&git_author_email);
7e43b32b 517) strbuf_addstr(&git_author_email, value);
7e43b32b 518) author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
7e43b32b 519) ident_config_given |= IDENT_MAIL_GIVEN;
7e43b32b 520) return 0;

merge-recursive.c
c43ba42e 436) fprintf(stderr, "BUG: %d %.*s\n", ce_stage(ce),
19c6a4f8 437) (int)ce_namelen(ce), ce->name);
033abf97 439) BUG("unmerged index entries in merge-recursive.c");
9047ebbc 728) return -1;
6003303a 925) if (status == SCLD_EXISTS)
18cfc088 1206) return 0;
73118f89 3632) return NULL;
d90e759f 3655)    oid_to_hex(base_list[i]));

midx.c
3c9e7185 817) drop_index++;
3c9e7185 818) missing_drops++;
3c9e7185 819) i--;
3c9e7185 826) result = 1;
3c9e7185 827) goto cleanup;
cc6af73c 1053) midx_report(_("failed to load pack-index for packfile %s"),
cc6af73c 1054)     e.p->pack_name);
cc6af73c 1055) break;
3c9e7185 1079) return 0;
3c9e7185 1094) continue;
467ae6f9 1133) return 0;
19c239d4 1148) return 0;
19c239d4 1157) continue;
19c239d4 1170) continue;

packfile.c
91336887 369) strbuf_release(&buf);
91336887 370) return;

pkt-line.c
bb643d8b 436) strbuf_setlen(sb_out, orig_len);
0bbc0bc5 505) if (demultiplex_sideband(reader->me, reader->buffer,
0bbc0bc5 508) break;
0bbc0bc5 509) }

read-cache.c
ee70c128 1736) advise(_("This is likely due to the file having been written by a newer\n"
bad68ec9 1745) break;

ref-filter.c
74efea94 448) return strbuf_addf_ret(err, -1, _("unrecognized %%(if) argument: %s"), arg);
6ccd3780 467) return 0;

remote-curl.c
01f9ec64 439) }

repository.c
359efeff 168) goto error;

send-pack.c
01f9ec64 143) return error(_("unable to parse remote unpack status: %s"), reader->line);
01f9ec64 162) error("invalid ref status from remote: %s", reader->line);

sequencer.c
d0aaa46f 1020) eol = sb->len;
66618a50 1409) goto out;
9055e401 2992) error("%s", err.buf);
2b6ad0f4 3291) goto leave_merge;

sha1-file.c
d21f8426 1084) return -1;
514c5fdd 1291) status = error(_("unable to parse %s header"), oid_to_hex(oid));
00a7760e 2305) the_hash_algo->final_fn(real_oid.hash, &c);
f6371f92 2309) return -1;
f6371f92 2344) goto out;

sideband.c
fbd76cd4 128) suffix = ANSI_SUFFIX;
fbd76cd4 138) strbuf_addf(scratch,
fbd76cd4 140)     scratch->len ? "\n" : "", me);
fbd76cd4 141) *sideband_type = SIDEBAND_PROTOCOL_ERROR;
fbd76cd4 142) goto cleanup;
0bbc0bc5 150) die("remote error: %s", buf + 1);
fbd76cd4 195) strbuf_addf(scratch, "%s%s: protocol error: bad band #%d",
fbd76cd4 196)     scratch->len ? "\n" : "", me, band);
fbd76cd4 197) *sideband_type = SIDEBAND_PROTOCOL_ERROR;
fbd76cd4 198) break;
0bbc0bc5 203) die("%s", scratch->buf);

upload-pack.c
10ac85c7 881) die("git upload-pack: filtering capability not negotiated");
05e95155 1059) if (!keepalive)
05e95155 1060) keepalive = -1;
685fbd32 1291) continue;

worktree.c
e0c4a731 465) clear_repository_format(&format);

wrapper.c
e3b1e3bd 701) die_errno(_("could not stat %s"), filename);

Commits introducting uncovered code:
Ævar Arnfjörð Bjarmason	8a6179bc i18n: git-commit basic messages
Brandon Williams	685fbd32 fetch-pack: perform a fetch using v2
Brandon Williams	359efeff repository: introduce the repository object
Daniels Umanovskis	0ecb1fc7 branch: introduce --show-current display option
Denton Liu	f39a9c65 remote: add --save-to-push option to git remote set-url
Derrick Stolee	467ae6f9 multi-pack-index: prepare 'repack' subcommand
Derrick Stolee	cce99cd8 commit-graph: writing missing parents is a BUG
Derrick Stolee	3c9e7185 multi-pack-index: implement 'expire' subcommand
Derrick Stolee	91336887 repack: refactor pack deletion for future use
Derrick Stolee	19c239d4 midx: implement midx_repack()
Derrick Stolee	cc6af73c multi-pack-index: verify object offsets
Elijah Newren	c43ba42e merge-recursive: Make BUG message more legible by adding a newline
Elijah Newren	d90e759f merge-recursive: fix numerous argument alignment issues
Jay Soffian	66f4b98a Teach merge the '[-e|--edit]' option
Jeff Hostetler	10ac85c7 upload-pack: add object filtering for partial clone
Jeff King	d6991cee ident: keep separate "explicit" flags for author and committer
Jeff King	862e80a4 ident: handle NULL email when complaining of empty name
Jeff King	00a7760e sha1-file: modernize loose header/stream functions
Jeff King	f6371f92 sha1_file: add read_loose_object() function
Jeff King	05e95155 upload-pack: send keepalive packets during pack computation
Jeff King	514c5fdd sha1-file: modernize loose object file functions
Johannes Schindelin	2b6ad0f4 rebase --rebase-merges: add support for octopus merges
Johannes Schindelin	21853626 built-in rebase: call `git am` directly
Johannes Schindelin	c5233708 rebase: move `reset_head()` into a better spot
Johannes Schindelin	9055e401 sequencer: introduce new commands to reset the revision
Johannes Schindelin	6003303a merge-recursive: switch to returning errors instead of dying
Johannes Schindelin	033abf97 Replace all die("BUG: ...") calls by BUG() ones
Jonathan Nieder	ee70c128 index: offer advice for unknown index extensions
Jonathan Tan	fbd76cd4 sideband: reverse its dependency on pkt-line
Jonathan Tan	0bbc0bc5 {fetch,upload}-pack: sideband v2 fetch response
Josh Steadmon	aa658574 commit-graph, fuzz: add fuzzer for commit-graph
Junio C Hamano	19c6a4f8 merge-recursive: do not return NULL only to cause segfault
Junio C Hamano	bad68ec9 index: make the index file format extensible.
Junio C Hamano	a85b377d push: the beginning of "git push --signed"
Junio C Hamano	d21f8426 unpack_sha1_header(): detect malformed object header
Lars Schneider	bb643d8b pkt-line: add functions to read/write flush terminated packet streams
Martin Ågren	e0c4a731 setup: fix memory leaks with `struct repository_format`
Masaya Suzuki	01f9ec64 Use packet_reader instead of packet_read_line
Michael J Gruber	62dc42b9 merge: clarify call chain
Miklos Vajna	9047ebbc Split out merge_recursive() to merge-recursive.c
Nguyễn Thái Ngọc Duy	f616db6a builtin/pack-objects.c: mark more strings for translation
Nguyễn Thái Ngọc Duy	4f5b532d commit-graph.c: mark more strings for translation
Nguyễn Thái Ngọc Duy	1dd73e20 fetch-pack.c: mark strings for translating
Nguyễn Thái Ngọc Duy	ac77d0c3 pack-objects: shrink size field in struct object_entry
Nguyễn Thái Ngọc Duy	ff7fe37b diff.c: move read_index() code back to the caller
Nickolai Belakovski	6ccd3780 ref-filter: add worktreepath atom
Olga Telezhnaya	74efea94 ref-filter: add return value to parsers
Paul Tan	7ff26832 builtin-am: implement -i/--interactive
Paul Tan	11b6d178 pull: pass git-merge's options to git-merge
Phillip Wood	d0aaa46f commit: move empty message checks to libgit
Phillip Wood	66618a50 sequencer: run 'prepare-commit-msg' hook
Pranit Bauva	e3b1e3bd wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
Pranit Bauva	06f5608c bisect--helper: `bisect_start` shell function partially in C
Pranit Bauva	450ebb73 bisect--helper: `get_terms` & `bisect_terms` shell function in C
Pranit Bauva	129a6cf3 bisect--helper: `bisect_next_check` shell function in C
Pranit Bauva	0f30233a bisect--helper: `bisect_write` shell function in C
Pranit Bauva	5e82c3dd bisect--helper: `bisect_reset` shell function in C
Pranit Bauva	ecb3f373 bisect--helper: `write_terms` shell function in C
Pratik Karki	122420c2 builtin rebase: support --skip
Stefan Beller	18cfc088 submodule.c: move submodule merging to merge-recursive.c
Stephan Beyer	73118f89 merge-recursive.c: Add more generic merge_recursive_generic()
Sven Strickroth	b64c1e07 commit: do not lose SQUASH_MSG contents
Torsten Bögershausen	ca473cef Upcast size_t variables to uintmax_t when printing
Torsten Bögershausen	9472935d add: introduce "--renormalize"
William Hubbs	7e43b32b Add author and committer configuration settings


Uncovered code in 'next' not in 'master'
--------------------------------------------------------

builtin/checkout.c

builtin/fetch-pack.c
4316ff30 226) get_remote_refs(fd[1], &reader, &ref, 0, NULL, NULL);

builtin/fetch.c
3390e42a 1200) warning("Ignoring --negotiation-tip because the protocol does not support it.");
aa57b871 1481) return;

builtin/grep.c
f9ee2fcd 428) return 0;

builtin/rebase.c
ba1905a5 1221) die(_("--strategy requires --merge or --interactive"));
d421afa0 1258) die(_("--reschedule-failed-exec requires an interactive rebase"));

commit-reach.c
5227c385 326) return ret;

commit.c

diff.c
b73bcbac 308) ret = 0;
21536d07 812)        (s[off] == '\r' && off < len - 1))
21536d07 813) off++;

entry.c
536ec183 450) BUG("Can't remove entry to a path");
12dccc16 517) return 0;

fetch-pack.c
f7e20501 1125) die(_("Server does not support shallow requests"));
f7e20501 1267) die(_("error in object: %s"), reader->line);
f7e20501 1269) die(_("no shallow found: %s"), reader->line);

hex.c
47edb649 93) char *sha1_to_hex_r(char *buffer, const unsigned char *sha1)
47edb649 95) return hash_to_hex_algop_r(buffer, sha1, &hash_algos[GIT_HASH_SHA1]);
47edb649 116) char *hash_to_hex(const unsigned char *hash)

http-push.c
ea82b2a0 1314) p = process_tree(lookup_tree(the_repository, &entry.oid),

http.c
e6cf87b1 1999) if (fflush(result)) {
e6cf87b1 2000) error_errno("unable to flush a file");
e6cf87b1 2001) return HTTP_START_FAILED;
e6cf87b1 2004) if (ftruncate(fileno(result), 0) < 0) {
e6cf87b1 2005) error_errno("unable to truncate a file");
e6cf87b1 2006) return HTTP_START_FAILED;
e6cf87b1 2008) break;
e6cf87b1 2010) BUG("Unknown http_request target");

list-objects-filter.c
bc5975d2 147) BUG("unknown filter_situation: %d", filter_situation);

pretty.c
ad6f028f 1204) return 0;

remote-curl.c
b79bdd8c 566) return size;

sha1-file.c
ac73cedf 114) static void git_hash_unknown_final(unsigned char *hash, git_hash_ctx *ctx)
1a07e59c 116) BUG("trying to finalize unknown hash");
024aa469 1358) return -1;
ee1c6c34 1766) return 0;

t/helper/test-hash-speed.c
37649b7f 6) static inline void compute_hash(const struct git_hash_algo *algo, git_hash_ctx *ctx, uint8_t *final, const void *p, size_t len)
37649b7f 8) algo->init_fn(ctx);
37649b7f 9) algo->update_fn(ctx, p, len);
37649b7f 10) algo->final_fn(final, ctx);
37649b7f 11) }
37649b7f 13) int cmd__hash_speed(int ac, const char **av)
37649b7f 18) unsigned bufsizes[] = { 64, 256, 1024, 8192, 16384 };
37649b7f 21) const struct git_hash_algo *algo = NULL;
37649b7f 23) if (ac == 2) {
37649b7f 24) for (i = 1; i < GIT_HASH_NALGOS; i++) {
37649b7f 25) if (!strcmp(av[1], hash_algos[i].name)) {
37649b7f 26) algo = &hash_algos[i];
37649b7f 27) break;
37649b7f 31) if (!algo)
37649b7f 32) die("usage: test-tool hash-speed algo_name");
37649b7f 35) initial = clock();
37649b7f 37) printf("algo: %s\n", algo->name);
37649b7f 39) for (i = 0; i < ARRAY_SIZE(bufsizes); i++) {
37649b7f 42) p = xcalloc(1, bufsizes[i]);
37649b7f 43) start = end = clock() - initial;
37649b7f 44) for (j = 0; ((end - start) / CLOCKS_PER_SEC) < NUM_SECONDS; j++) {
37649b7f 45) compute_hash(algo, &ctx, hash, p, bufsizes[i]);
37649b7f 51) if (!(j & 127))
37649b7f 52) end = clock() - initial;
37649b7f 54) kb = j * bufsizes[i];
37649b7f 55) kb_per_sec = kb / (1024 * ((double)end - start) / CLOCKS_PER_SEC);
37649b7f 56) printf("size %u: %lu iters; %lu KiB; %0.2f KiB/s\n", bufsizes[i], j, kb, kb_per_sec);
37649b7f 57) free(p);
37649b7f 60) exit(0);

t/helper/test-hash.c
50c817e0 17) bufsz = strtoul(av[1], NULL, 10) * 1024 * 1024;
50c817e0 21) bufsz = 8192;
50c817e0 24) fprintf(stderr, "bufsz %u is too big, halving...\n", bufsz);
50c817e0 25) bufsz /= 2;
50c817e0 26) if (bufsz < 1024)
50c817e0 27) die("OOPS");
50c817e0 42) die_errno("test-hash");

tree-walk.c
0a3faa45 530) oidcpy(result, &oid);

tree.c
60c38b9e 104) commit = lookup_commit(r, &entry.oid);

upload-pack.c
0b6069fe 148) argv_array_pushf(&pack_objects.args, "--filter=%s", buf.buf);

Commits introducting uncovered code:
Brandon Williams	f9ee2fcd grep: recurse in-process using 'struct repository'
Brandon Williams	f7e20501 fetch-pack: support shallow requests
brian m. carlson	ac73cedf hash: create union for hash context allocation
brian m. carlson	50c817e0 t: make the sha1 test-tool helper generic
brian m. carlson	0a3faa45 tree-walk: copy object ID before use
brian m. carlson	37649b7f t/helper: add a test helper to compute hash speed
brian m. carlson	47edb649 hex: introduce functions to print arbitrary hashes
brian m. carlson	ea82b2a0 tree-walk: store object_id in a separate member
Derrick Stolee	5227c385 commit-reach: move walk methods from commit.c
Issac Trotts	ad6f028f log: add %S option (like --source) to log --format
Jeff Hostetler	aa57b871 fetch: inherit filter-spec from partial clone
Jeff King	ee1c6c34 sha1_file: only freshen packs once per run
Johannes Schindelin	d421afa0 rebase: introduce --reschedule-failed-exec
Jonathan Tan	4316ff30 fetch-pack: support protocol version 2
Jonathan Tan	0b6069fe fetch-pack: test support excluding large blobs
Jonathan Tan	3390e42a fetch-pack: support negotiation tip whitelist
Junio C Hamano	60c38b9e Merge branch 'bc/tree-walk-oid' into next
Linus Torvalds	12dccc16 Make fiel checkout function available to the git library
Masaya Suzuki	b79bdd8c remote-curl: unset CURLOPT_FAILONERROR
Masaya Suzuki	e6cf87b1 http: enable keep_error for HTTP requests
Matthew DeVore	bc5975d2 list-objects-filter: implement filter tree:0
Nguyễn Thái Ngọc Duy	1a07e59c Update messages in preparation for i18n
Phillip Wood	21536d07 diff --color-moved-ws: modify allow-indentation-change
Phillip Wood	b73bcbac diff: allow --no-color-moved-ws
Pratik Karki	ba1905a5 builtin rebase: add support for custom merge strategies
Takuto Ikuta	024aa469 fetch-pack.c: use oidset to check existence of loose object
Thomas Gummerer	536ec183 entry: support CE_WT_REMOVE flag in checkout_entry


Uncovered code in 'master' not in 'maint'
--------------------------------------------------------

apply.c
0f086e6d 3355) if (checkout_entry(ce, &costate, NULL, NULL) ||
0f086e6d 3356)     lstat(ce->name, st))

attr.c
ad8f8f4a 369) fprintf_ln(stderr, _("%s not allowed: %s:%d"),

blame.c
09002f1b 1712) if (revs->pending.nr != 1)
09002f1b 1719) return NULL;

builtin/bundle.c
74ae4b63 64) return !!unbundle(the_repository, &header, bundle_fd, 0) ||

builtin/checkout.c
9f97ab08 182) return error(_("path '%s' does not have their version"), ce->name);

builtin/fast-export.c
f129c427 202) if (!p->parents)
f129c427 203) return NULL;
f129c427 204) p = p->parents->item;
f129c427 205) }
a8722750 257) buf = anonymize_blob(&size);
da14a7ff 258) object = (struct object *)lookup_blob(the_repository, oid);
a8722750 259) eaten = 0;
a8722750 334) struct strbuf out = STRBUF_INIT;
a8722750 335) strbuf_addf(&out, "path%d", counter++);
a8722750 336) return strbuf_detach(&out, len);
b3e8ca89 402) if (!string_list_has_string(changed, ospec->path)) {
b3e8ca89 403) printf("%c ", q->queue[i]->status);
b3e8ca89 404) print_path(ospec->path);
a8722750 630) refname = anonymize_refname(refname);
a8722750 631) anonymize_ident_line(&committer, &committer_end);
a8722750 632) anonymize_ident_line(&author, &author_end);
a8722750 637) reencoded = anonymize_commit_message(message);
02c48cd6 730) return;
1a07e59c 772) die("encountered signed tag %s; use "
1a07e59c 774)     oid_to_hex(&tag->object.oid));
1a07e59c 807)     oid_to_hex(&tag->object.oid),
f2dc849e 871) continue;
debca9d2 886) type_name(e->item->type));
2d07f6d4 887) continue;
273f8ee8 894) export_blob(&commit->object.oid);
3e9b9cb1 895) continue;
3e9b9cb1 897) warning("Tag points to object of unexpected type %s, skipping.",
debca9d2 898) type_name(commit->object.type));
3e9b9cb1 899) continue;
df6a7ff7 1031) die("corrupt mark line: %s", line);

builtin/fsck.c
674ba340 167) objerror(parent, _("wrong object type in link"));
18af29f2 280) return;
674ba340 334) fprintf_ln(stderr, _("Checking %s"), describe_object(obj));
85003492 367) return 0;
674ba340 618) fprintf_ln(stderr, _("Checking object directory"));
3813a89f 636) fprintf_ln(stderr, _("Checking %s link"), head_ref_name);
ae7c0c92 864) continue;

builtin/merge.c
9440b831 131) return error(_("option `%s' requires a value"), opt->long_name);

builtin/reflog.c
4264dc15 588) i++;
3c386aa3 685) i++;
552cecc2 705) continue;
afcb2e7a 740) i++;

builtin/repack.c
c83d950e 200) die(_("could not start pack-objects to repack promisor objects"));
3813a89f 239) die(_("repack: Expecting full hex object ID lines only from pack-objects."));
c83d950e 250) die_errno(_("unable to create '%s'"), promisor_name);
3813a89f 411) die(_("repack: Expecting full hex object ID lines only from pack-objects."));
a1bbc6c0 480) fprintf(stderr,

builtin/worktree.c
00a6d4d1 752) found_submodules = 1;

bundle.c
be042aff 491) argv_index_pack[3] = "-v";

commit-graph.c
cce99cd8 570) BUG("missing parent %s for commit %s",

delta-islands.c
c8d521fa 214) obj = ((struct tag *)obj)->tagged;

fast-import.c
8dc6a373 2869) static struct object_entry *dereference(struct object_entry *oe,

git.c
8aa8c140 342) die_errno(_("while expanding alias '%s': '%s'"),
8aa8c140 351) die(_("alias '%s' changes environment variables.\n"

http-walker.c
b69fb867 550) loose_object_path(the_repository, &buf, req->sha1);

http.c
d73019fe 289) return git_config_string(&curl_http_version, var, value);
d73019fe 797) static int get_curl_http_version_opt(const char *version_string, long *opt)
d73019fe 808) for (i = 0; i < ARRAY_SIZE(choice); i++) {
d73019fe 809) if (!strcmp(version_string, choice[i].name)) {
d73019fe 810) *opt = choice[i].opt_token;
d73019fe 811) return 0;
d73019fe 815) warning("unknown value given to http.version: '%s'", version_string);
d73019fe 816) return -1; /* not found */

merge-recursive.c
37b65ce3 1588) return -1;
37b65ce3 1594) return -1;
37b65ce3 1597) return -1;
37b65ce3 1664) return -1;
37b65ce3 1667) return -1;
7f867165 1703) return -1;
033abf97 2742) BUG("ren1_dst != ren2_dst");
75456f96 3206) free(new_path);
75456f96 3207) return -1;
75456f96 3278) clean_merge = -1;
75456f96 3283) clean_merge = -1;

parse-options-cb.c
9440b831 21) return error(_("option `%s' expects a numerical value"),
9440b831 51) return error(_("option `%s' expects \"always\", \"auto\", or \"never\""),

parse-options.c
9440b831 194) return error(_("%s expects a non-negative integer value"
9440b831 787) strbuf_addf(&sb, "option `no-%s'", opt->long_name);

pathspec.c
22af33be 671) name = to_free = xmemdupz(name, namelen);

read-cache.c
391408e5 319) BUG("unsupported ce_mode: %o", ce->ce_mode);
9d0a9e90 675) die(_("will not add file alias '%s' ('%s' already exists in index)"),
9d0a9e90 676)     ce->name, alias->name);
a849735b 785) discard_cache_entry(ce);
bad68ec9 1727) if (*ext < 'A' || 'Z' < *ext)
8616a2d0 2351) if (!istate) {
8616a2d0 2358) !mem_pool_contains(istate->split_index->base->ce_mem_pool, istate->cache[i])) {
ec36c42a 3498) const char *index = NULL;
ec36c42a 3504) if (!offset)
ec36c42a 3505) return NULL;
ec36c42a 3506) while (offset <= mmap_size - the_hash_algo->rawsz - 8) {
ec36c42a 3507) extsize = get_be32(mmap + offset + 4);
ec36c42a 3508) if (CACHE_EXT((mmap + offset)) == CACHE_EXT_INDEXENTRYOFFSETTABLE) {
ec36c42a 3509) index = mmap + offset + 4 + 4;
ec36c42a 3510) break;
ec36c42a 3512) offset += 8;
ec36c42a 3513) offset += extsize;
ec36c42a 3515) if (!index)
ec36c42a 3516) return NULL;
ec36c42a 3519) ext_version = get_be32(index);
ec36c42a 3520) if (ext_version != IEOT_VERSION) {
ec36c42a 3521) error("invalid IEOT version %d", ext_version);
ec36c42a 3522) return NULL;
ec36c42a 3524) index += sizeof(uint32_t);
ec36c42a 3527) nr = (extsize - sizeof(uint32_t)) / (sizeof(uint32_t) + sizeof(uint32_t));
ec36c42a 3528) if (!nr) {
ec36c42a 3529) error("invalid number of IEOT entries %d", nr);
ec36c42a 3530) return NULL;
ec36c42a 3532) ieot = xmalloc(sizeof(struct index_entry_offset_table)
ec36c42a 3533)        + (nr * sizeof(struct index_entry_offset)));
ec36c42a 3534) ieot->nr = nr;
ec36c42a 3535) for (i = 0; i < nr; i++) {
ec36c42a 3536) ieot->entries[i].offset = get_be32(index);
ec36c42a 3537) index += sizeof(uint32_t);
ec36c42a 3538) ieot->entries[i].nr = get_be32(index);
ec36c42a 3539) index += sizeof(uint32_t);

ref-filter.c
1867ce6c 236) oi_deref.info.sizep = &oi_deref.size;
1867ce6c 245) return strbuf_addf_ret(err, -1, _("unrecognized %%(objectsize) argument: %s"), arg);
33311fa1 253) return strbuf_addf_ret(err, -1, _("%%(deltabase) does not take arguments"));
033abf97 883) BUG("unknown %%(objectname) option");

remote.c
dd8dd300 1035) BUG("'%s' is not a valid object, "

sequencer.c
ba97aea1 598) return NULL;
e47c6caf 1190) free(user_config);
e47c6caf 1191) free(xdg_config);
66618a50 1343) hook_commit = "HEAD";
aee42e1f 1463) return error(_("could not parse parent commit %s"),
6e98de72 1673) return error(_("unknown command: %d"), command);
1e41229d 2559) strbuf_release(&sb);
88d5a271 2698) res |= git_config_set_in_file_gently(opts_file, "options.edit", "true");
56dc3ab0 2756) res |= error_errno(_("could not open '%s'"), buf.buf);
bc9238bb 2795) return -1;
bc9238bb 2798) return error(_("unable to copy '%s' to '%s'"),
56dc3ab0 2803) return -1;
2b6ad0f4 3133) ret = error(_("unable to parse '%.*s'"), k, p);
15ef6931 3925) return error(_("could not remove CHERRY_PICK_HEAD"));
2863584f 3957) return -1;
cdac2b01 4838) return -1;

setup.c
033abf97 1107) BUG("unhandled setup_git_directory_1() result");

sha1-file.c
f0eaf638 2138) return r;
3a2e0824 2162) BUG("subdir_nr out of range");

submodule.c
6e3c1595 1729) ret = -1;
6e3c1595 1730) goto out;

t/helper/test-sigchain.c
3b335762 17) int cmd__sigchain(int argc, const char **argv)

transport-helper.c
3b335762 1029) static int has_attribute(const char *attrs, const char *attr)

tree-walk.c
2842c0f9 377) return still_interesting;

Commits introducting uncovered code:
Ævar Arnfjörð Bjarmason	9f97ab08 i18n: git-checkout: our/their version message
Ævar Arnfjörð Bjarmason	dd8dd300 push: add an advice on unqualified <dst> push
Brandon Casey	3c386aa3 reflog-delete: parse standard reflog options
Brandon Williams	debca9d2 object: rename function 'typename' to 'type_name'
brian m. carlson	273f8ee8 builtin/fast-export: convert to struct object_id
David Barr	8dc6a373 fast-import: add 'ls' command
David Turner	afcb2e7a git-reflog: add exists command
Derrick Stolee	cce99cd8 commit-graph: writing missing parents is a BUG
Elijah Newren	37b65ce3 merge-recursive: new function for better colliding conflict resolutions
Elijah Newren	f129c427 fast-export: move commit rewriting logic into a function for reuse
Elijah Newren	7f867165 merge-recursive: fix rename/add conflict handling
Elijah Newren	02c48cd6 fast-export: Omit tags that tag trees
Erik Faye-Lund	2d07f6d4 builtin-fast-export.c: turn error into warning
Felipe Contreras	3e9b9cb1 fast-export: refactor get_tags_and_duplicates()
Force Charlie	d73019fe http: add support selecting http version
Jameson Miller	a849735b block alloc: add lifecycle APIs for cache_entry structs
Jameson Miller	8616a2d0 block alloc: add validations around cache_entry lifecyle
Jeff King	a8722750 teach fast-export an --anonymize option
Jeff King	b69fb867 sha1_file_name(): overwrite buffer instead of appending
Jeff King	3a2e0824 object-store: provide helpers for loose_objects_cache
Jeff King	c8d521fa Add delta-islands.{c,h}
Jeff King	f0eaf638 sha1-file: use an object_directory for the main object dir
Jeff Smith	09002f1b blame: move scoreboard setup to libgit
Johannes Schindelin	ba97aea1 sequencer: extract helper to update active_cache_tree
Johannes Schindelin	aee42e1f sequencer: strip bogus LF at end of error messages
Johannes Schindelin	6e98de72 sequencer (rebase -i): add support for the 'fixup' and 'squash' commands
Johannes Schindelin	88d5a271 sequencer: lib'ify save_opts()
Johannes Schindelin	2b6ad0f4 rebase --rebase-merges: add support for octopus merges
Johannes Schindelin	552cecc2 Teach "git reflog" a subcommand to delete single entries
Johannes Schindelin	cdac2b01 rebase -i: skip unnecessary picks using the rebase--helper
Johannes Schindelin	2863584f sequencer: get rid of the subcommand field
Johannes Schindelin	033abf97 Replace all die("BUG: ...") calls by BUG() ones
Johannes Schindelin	75456f96 merge-recursive: handle return values indicating errors
Johannes Schindelin	f2dc849e Add 'git fast-export', the sister of 'git fast-import'
Johannes Schindelin	15ef6931 rebase --skip: clean up commit message after a failed fixup/squash
Johannes Schindelin	56dc3ab0 sequencer (rebase -i): implement the 'edit' command
Jonathan Tan	b3e8ca89 fast-export: do not copy from modified file
Junio C Hamano	2842c0f9 traverse_trees(): allow pruning with pathspec
Junio C Hamano	4264dc15 git reflog expire
Junio C Hamano	ae7c0c92 Git-prune-script loses blobs referenced from an uncommitted cache.
Junio C Hamano	3813a89f Merge branch 'nd/i18n'
Junio C Hamano	be042aff Teach progress eye-candy to fetch_refs_from_bundle()
Junio C Hamano	bad68ec9 index: make the index file format extensible.
Linus Torvalds	85003492 Make fsck-cache do better tree checking.
Linus Torvalds	18af29f2 fsck-objects: refactor checking for connectivity
Nguyễn Thái Ngọc Duy	ec36c42a Indent code with TABs
Nguyễn Thái Ngọc Duy	8aa8c140 git.c: mark more strings for translation
Nguyễn Thái Ngọc Duy	391408e5 read-cache.c: turn die("internal error") to BUG()
Nguyễn Thái Ngọc Duy	ad8f8f4a attr.c: mark more string for translation
Nguyễn Thái Ngọc Duy	74ae4b63 bundle.c: remove the_repository references
Nguyễn Thái Ngọc Duy	1a07e59c Update messages in preparation for i18n
Nguyễn Thái Ngọc Duy	674ba340 fsck: mark strings for translation
Nguyễn Thái Ngọc Duy	9440b831 parse-options: replace opterror() with optname()
Nguyễn Thái Ngọc Duy	9d0a9e90 read-cache.c: mark more strings for translation
Nguyễn Thái Ngọc Duy	c83d950e repack: mark more strings for translation
Nguyễn Thái Ngọc Duy	3b335762 style: the opening '{' of a function is in a separate line
Nguyễn Thái Ngọc Duy	22af33be dir.c: move, rename and export match_attrs()
Nguyễn Thái Ngọc Duy	00a6d4d1 worktree: allow to (re)move worktrees with uninitialized submodules
Nguyễn Thái Ngọc Duy	0f086e6d checkout: print something when checking out paths
Olga Telezhnaya	33311fa1 ref-filter: add deltabase option
Olga Telezhnaya	1867ce6c ref-filter: add objectsize:disk option
Phillip Wood	66618a50 sequencer: run 'prepare-commit-msg' hook
Phillip Wood	e47c6caf commit: move print_commit_summary() to libgit
Phillip Wood	bc9238bb rebase -i: fix SIGSEGV when 'merge <branch>' fails
Pieter de Bie	df6a7ff7 builtin-fast-export: Add importing and exporting of revision marks
Stefan Beller	a1bbc6c0 repack: rewrite the shell script in C
Stefan Beller	da14a7ff blob: add repository argument to lookup_blob
Stefan Beller	6e3c1595 update submodules: add submodule_move_head
Stephan Beyer	1e41229d sequencer: make sequencer abort safer


