Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7ED51F453
	for <e@80x24.org>; Thu, 24 Jan 2019 20:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfAXU41 (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 15:56:27 -0500
Received: from mail-qt1-f180.google.com ([209.85.160.180]:38024 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfAXU40 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 15:56:26 -0500
Received: by mail-qt1-f180.google.com with SMTP id p17so8369278qtl.5
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 12:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+Kax0zunD2BWZZ/gSlBcG58UkS+LqFBeedoOYP+W29E=;
        b=aO/Bxx+KWpD+pn3wJJ9Y0Qz7gUqhql8b0gF+6WaXYOSEgf6qQo5VnxhEFg+QM62v23
         F0RW/XpnL/g3cRIGcFOHy3UWwCYgGG7uwT7+vum6KfKR8IDf/bMXLMV0QwPvDv1DXvvX
         AXIruoEI9ZCNM4g8Tu111K86uOd35CTfNt8DtC56bc+HqPtUHuYdQlkHnK0LFED4pcGT
         1t0T5fEsMCfW/0w0RKNT/oVRdZ3paQxU9HV51YGT4piig8HFJFJQhipYLZGDoOylfUAu
         vV1dAQ+MjlxK7C/PsuFHAQLfCjiQtRQZM7g2BhRO+s8Cfxn7Z6L7XOMg4i/EOsB+RC+K
         xf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+Kax0zunD2BWZZ/gSlBcG58UkS+LqFBeedoOYP+W29E=;
        b=tkyzcv+Te15aTunOsio3uQtElfdBFcMhKdE4KVZqAdZSNF+zNKFUDuKmiIvtM3PvXi
         K++bT0A2cIvXmW9Q1oYF9cOziTQ96NRrdiuyxaulAW8Y6MfC3nbUt+S6cT68a6+IPIrp
         f1ES8rkUtQmzfQyEEI03afNhOELes7cOWJnU6Izfyrqgusfi8GWl+eUQG4zvmGYtF0ZD
         vyjtDmKK6Dru1COSBGZlMYLX8sAL0nTXN8o8dGCKgCStX9AADXdZmZtZzqBAKrEDdclh
         pg4UNjDbkDxm/LHnazVHVija9UHOfdiehEqat3OzX3fLtufJ6ywhoIMhXm5ffXTtbSFm
         VJ1A==
X-Gm-Message-State: AJcUukcxzxzIK4kO/T4gn95XoqjHgzxrJlJPZAMRAYCFVtdV0CMmsJhf
        1W9hD3HqutCYsPYkxLOcLkcKSBTu
X-Google-Smtp-Source: ALg8bN4Cr8ITxn4nEDNDrhwRwNDmwkn/OUFCujNtirkI6A2t71hzAZji1Ey+qxIOwzAd6HRwD1ddpQ==
X-Received: by 2002:ac8:528b:: with SMTP id s11mr8003420qtn.199.1548363378030;
        Thu, 24 Jan 2019 12:56:18 -0800 (PST)
Received: from [10.0.1.15] ([98.122.160.2])
        by smtp.gmail.com with ESMTPSA id a17sm62921913qth.93.2019.01.24.12.56.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 12:56:17 -0800 (PST)
Subject: Re: Git Test Coverage Report (Sat Jan 19)
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <6addc879-a792-202f-2aeb-7097ea344894@gmail.com>
 <xmqqa7jp53d2.fsf@gitster-ct.c.googlers.com>
 <7aaec7c8-6cf9-fbd5-fbaf-60b110e2bac7@gmail.com>
 <5fe36d0a-e7f1-6349-27ed-a6d48a3ba1e3@ramsayjones.plus.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <00d82fc1-e908-51b5-5d72-ec48298acedf@gmail.com>
Date:   Thu, 24 Jan 2019 15:56:16 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <5fe36d0a-e7f1-6349-27ed-a6d48a3ba1e3@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/24/2019 2:39 PM, Ramsay Jones wrote:
> 
> 
> On 24/01/2019 19:18, Derrick Stolee wrote:
>> On 1/24/2019 1:15 PM, Junio C Hamano wrote:
>>> Derrick Stolee <stolee@gmail.com> writes:
>>>
>>>> Here is today's test coverage report.
>>>>
>>>> Also, there has been some feedback that it can be hard to manually
>>>> match up uncovered lines with names at the bottom of the summary. The
>>>> suggestion was to auto-generate an HTML report that could be posted to
>>>> a public page and referenced in this mail for those who prefer
>>>> that.
>>> I wanted to "grep" for lines attributed to certain commits that
>>> appear in the list, by filtering lines that begin with enough number
>>> of hexdigits, except for those object names, but the attempt failed
>>> miserably because of the line wrapping (which probably comes from
>>> the assumption that it is OK because the "text/plain; format=flowed"
>>> would not care).  If you can keep the long lines (due to the object
>>> names and line numbers prefixed to each line) unsplit, it would be
>>> more useful to locate and isolate lines.
>> This is likely more a problem with my workflow (pasting the report into Thunderbird and sending) than with the content itself.
> 
> Have you read Doucmentation/git-format-patch.txt (Thunderbird>
> Approach #2 (configuration) - approx. line 487)?
> 
> ATB,
> Ramsay Jones
> 

Thanks, Ramsay! I adjusted the settings and am re-pasting the latest
report below. Let me know if everything improved.

Thanks,
-Stolee


pu: 32ea0d952e6add9269432e6e2b31fd552e5478c0
jch: bc1fa105c1c1d5870a7e2800526f0a7ebf17d064
next: aa96b0ce6b0fa4fa4cc6870f1a3aff3878967bfa
master: 16a465bc018d09e9d7bbbdc5f40a7fb99c21f8ef
master@{1}: 77556354bb7ac50450e3b28999e3576969869068

Uncovered code in 'pu' not in 'jch'
--------------------------------------

bisect.c
4f6d26b167  661) mark_edges_uninteresting(revs, NULL, 0);

blame.c
e1ff0a32e4  191) repo_read_index(r);
e1ff0a32e4  273) repo_read_index(r);
07d04b919e  482)     ent->s_lno + ent->num_lines == next->s_lno &&
07d04b919e  483)     ent->ignored == next->ignored) {
07d04b919e  735) split[0].ignored = split[1].ignored = split[2].ignored = e->ignored;
e7973c8519  859) struct blame_entry *samep = NULL, *diffp = NULL, *ignoredp = NULL;
07d04b919e  873) n->ignored = e->ignored;
07d04b919e  928) n->ignored = e->ignored;
e7973c8519  938) if (ignore_diffs) {
e7973c8519  940) blame_origin_decref(e->suspect);
e7973c8519  941) e->suspect = blame_origin_incref(parent);
e7973c8519  942) e->s_lno += offset;
07d04b919e  943) e->ignored = 1;
e7973c8519  944) e->next = ignoredp;
e7973c8519  945) ignoredp = e;
e7973c8519  947) e->next = diffp;
e7973c8519  948) diffp = e;
e7973c8519  952) if (ignoredp) {
e7973c8519  953) **dstq = reverse_blame(ignoredp, **dstq);
e7973c8519  954) *dstq = &ignoredp->next;
e7973c8519 1001) d.ignore_diffs = ignore_diffs;
e7973c8519 1013) blame_chunk(&d.dstq, &d.srcq, INT_MAX, d.offset, INT_MAX, parent, 0);
e7973c8519 1518) pass_blame_to_parent(sb, origin, porigin, 0);
e7973c8519 1526) if (oidset_contains(&sb->ignore_list, &commit->object.oid)) {
e7973c8519 1527) for (i = 0, sg = first_scapegoat(revs, commit, sb->reverse);
e7973c8519 1528)      i < num_sg && sg;
e7973c8519 1529)      sg = sg->next, i++) {
e7973c8519 1530) struct blame_origin *porigin = sg_origin[i];
e7973c8519 1532) if (!porigin)
e7973c8519 1533) continue;
e7973c8519 1534) pass_blame_to_parent(sb, origin, porigin, 1);
e7973c8519 1535) if (!origin->suspects)
e7973c8519 1536) goto finish;

builtin/am.c
1d18d7581c  515) finish_copy_notes_for_rewrite(the_repository, c, msg);
150fe065f7 1765)     !repo_index_has_changes(the_repository, NULL, NULL)) {
150fe065f7 1819) if (!repo_index_has_changes(the_repository, NULL, NULL)) {

builtin/blame.c
07d04b919e builtin/blame.c    484) if (mark_ignored_lines && ent->ignored) {
07d04b919e builtin/blame.c    485) length--;
07d04b919e builtin/blame.c    486) putchar('*');
e7973c8519 builtin/blame.c    704) if (!strcmp(var, "blame.ignorerevsfile"))
e7973c8519 builtin/blame.c    705) return git_config_pathname(&ignore_revs_file, var, value);
07d04b919e builtin/blame.c    706) if (!strcmp(var, "blame.markignoredlines")) {
07d04b919e builtin/blame.c    707) mark_ignored_lines = git_config_bool(var, value);
07d04b919e builtin/blame.c    708) return 0;
e7973c8519 builtin/blame.c    789) static void build_ignorelist(struct blame_scoreboard *sb,
e7973c8519 builtin/blame.c    795) oidset_init(&sb->ignore_list, 0);
e7973c8519 builtin/blame.c    796) if (ignore_revs_file)
e7973c8519 builtin/blame.c    797) oidset_parse_file(&sb->ignore_list, ignore_revs_file);
e7973c8519 builtin/blame.c    798) for_each_string_list_item(i, ignore_rev_list) {
e7973c8519 builtin/blame.c    799) if (get_oid_committish(i->string, &oid))
e7973c8519 builtin/blame.c    800) die(_("Can't find revision '%s' to ignore"), i->string);
e7973c8519 builtin/blame.c    801) oidset_insert(&sb->ignore_list, &oid);
e7973c8519 builtin/blame.c    803) }
acdd37769d builtin/blame.c    961) blame_date_width = sizeof("Thu Oct 19 16:00");
acdd37769d builtin/blame.c    962) break;
e7973c8519 builtin/blame.c   1033) build_ignorelist(&sb, &ignore_rev_list);
e7973c8519 builtin/blame.c   1034) string_list_clear(&ignore_rev_list, 0);
4478671442 builtin/blame.c   1048)     the_repository->index))

builtin/checkout.c
0d6caa2d08 builtin/checkout.c  751) init_merge_options(&o, the_repository);

builtin/commit.c
1d18d7581c builtin/commit.c 1689) commit_post_rewrite(the_repository, current_head, &oid);

builtin/config.c
a12c1ff3a5 builtin/config.c       85) die(_("only one config file at a time"));
a12c1ff3a5 builtin/config.c       88) die(_("--local can only be used inside a git repository"));
a12c1ff3a5 builtin/config.c       91) die(_("--blob can only be used inside a git repository"));
a12c1ff3a5 builtin/config.c       95) given_config_source.file = NULL;
a12c1ff3a5 builtin/config.c       96) given_config_source.use_stdin = 1;
a12c1ff3a5 builtin/config.c      110) die(_("$HOME not set"));
a12c1ff3a5 builtin/config.c      114) given_config_source.file = xdg_config;
a12c1ff3a5 builtin/config.c      115) free(user_config);
a12c1ff3a5 builtin/config.c      122) given_config_source.file = git_etc_gitconfig();
a12c1ff3a5 builtin/config.c      126) given_config_source.file = get_worktree_config(the_repository);
a12c1ff3a5 builtin/config.c      127) if (!given_config_source.file)
a12c1ff3a5 builtin/config.c      128) die(_("--worktree cannot be used with multiple "
6f11fd5edb builtin/config.c      185) static int option_move_cb(const struct option *opt,
6f11fd5edb builtin/config.c      188) BUG_ON_OPT_NEG(unset);
6f11fd5edb builtin/config.c      189) BUG_ON_OPT_ARG(arg);
6f11fd5edb builtin/config.c      191) set_config_source_file();
6f11fd5edb builtin/config.c      192) memcpy(&move_source, &given_config_source, sizeof(move_source));
6f11fd5edb builtin/config.c      194) memset(&given_config_source, 0, sizeof(given_config_source));
6f11fd5edb builtin/config.c      195) use_global_config = 0;
6f11fd5edb builtin/config.c      196) use_system_config = 0;
6f11fd5edb builtin/config.c      197) use_local_config = 0;
6f11fd5edb builtin/config.c      198) use_worktree_config = 0;
6f11fd5edb builtin/config.c      200) actions = opt->defval;
6f11fd5edb builtin/config.c      201) return 0;
6f11fd5edb builtin/config.c      471) static int collect_move_config(const char *key, const char *value, void *cb)
6f11fd5edb builtin/config.c      473) struct move_config_cb *data = cb;
6f11fd5edb builtin/config.c      475) switch (actions) {
6f11fd5edb builtin/config.c      477) if (strcasecmp(data->key, key))
6f11fd5edb builtin/config.c      478) return 0;
6f11fd5edb builtin/config.c      479) break;
6f11fd5edb builtin/config.c      481) if (regexec(&data->key_re, key, 0, NULL, 0))
6f11fd5edb builtin/config.c      482) return 0;
6f11fd5edb builtin/config.c      483) break;
6f11fd5edb builtin/config.c      485) if (wildmatch(data->key, key, WM_CASEFOLD))
6f11fd5edb builtin/config.c      486) return 0;
6f11fd5edb builtin/config.c      487) break;
6f11fd5edb builtin/config.c      492) string_list_append(&data->keys, key)->util = xstrdup(value);
6f11fd5edb builtin/config.c      493) return 0;
6f11fd5edb builtin/config.c      496) static int move_config(const char *key)
6f11fd5edb builtin/config.c      499) int i, ret = 0;
6f11fd5edb builtin/config.c      501) config_options.respect_includes = 0;
6f11fd5edb builtin/config.c      502) if (!move_source.file && !move_source.use_stdin && !move_source.blob)
6f11fd5edb builtin/config.c      503) die(_("unknown config source"));
6f11fd5edb builtin/config.c      505) string_list_init(&cb.keys, 1);
6f11fd5edb builtin/config.c      506) cb.key = key;
6f11fd5edb builtin/config.c      507) if (actions == ACTION_MOVE_REGEXP &&
6f11fd5edb builtin/config.c      508)     regcomp(&cb.key_re, key, REG_EXTENDED | REG_ICASE))
6f11fd5edb builtin/config.c      509) die(_("invalid key pattern: %s"), key);
6f11fd5edb builtin/config.c      511) config_with_options(collect_move_config, &cb,
6f11fd5edb builtin/config.c      514) for (i = 0; i < cb.keys.nr && !ret; i++) {
6f11fd5edb builtin/config.c      515) const char *key = cb.keys.items[i].string;
6f11fd5edb builtin/config.c      516) const char *value = cb.keys.items[i].util;
6f11fd5edb builtin/config.c      517) const char *dest = given_config_source.file;
6f11fd5edb builtin/config.c      519) ret = git_config_set_multivar_in_file_gently(
6f11fd5edb builtin/config.c      527) if (!ret && move_source.file) {
6f11fd5edb builtin/config.c      528) for (i = 0; i < cb.keys.nr; i++) {
6f11fd5edb builtin/config.c      529) const char *key = cb.keys.items[i].string;
6f11fd5edb builtin/config.c      530) const char *src = move_source.file;
6f11fd5edb builtin/config.c      532) git_config_set_multivar_in_file_gently(
6f11fd5edb builtin/config.c      537) string_list_clear(&cb.keys, 1);
6f11fd5edb builtin/config.c      538) if (actions == ACTION_MOVE_REGEXP)
6f11fd5edb builtin/config.c      539) regfree(&cb.key_re);
6f11fd5edb builtin/config.c      540) return ret;
6f11fd5edb builtin/config.c      979) else if (actions == ACTION_MOVE ||
6f11fd5edb builtin/config.c      980)  actions == ACTION_MOVE_REGEXP ||
6f11fd5edb builtin/config.c      981)  actions == ACTION_MOVE_GLOB) {
6f11fd5edb builtin/config.c      982) check_write();
6f11fd5edb builtin/config.c      983) check_argc(argc, 1, 1);
6f11fd5edb builtin/config.c      984) return move_config(argv[0]);

builtin/describe.c
1b0d968b34 builtin/describe.c 638) repo_update_index_if_able(the_repository, &index_lock);

builtin/diff-tree.c
e1ff0a32e4 builtin/diff-tree.c 169) repo_read_index(the_repository);

builtin/grep.c
dba093ddc0 builtin/grep.c  403) static int grep_submodule(struct grep_opt *opt,
dba093ddc0 builtin/grep.c  409) struct repository *superproject = opt->repo;
dba093ddc0 builtin/grep.c  448) memcpy(&subopt, opt, sizeof(subopt));
b6b4172bfb builtin/grep.c  449) subopt.repo = &subrepo;
dba093ddc0 builtin/grep.c  472) hit = grep_tree(&subopt, pathspec, &tree, &base, base.len,
dba093ddc0 builtin/grep.c  473) object->type == OBJ_COMMIT);
dba093ddc0 builtin/grep.c  477) hit = grep_cache(&subopt, pathspec, 1);
dba093ddc0 builtin/grep.c  484) static int grep_cache(struct grep_opt *opt,
dba093ddc0 builtin/grep.c  487) struct repository *repo = opt->repo;
dba093ddc0 builtin/grep.c  525) hit |= grep_submodule(opt, pathspec, NULL, ce->name, ce->name);
dba093ddc0 builtin/grep.c  549) struct repository *repo = opt->repo;
b6b4172bfb builtin/grep.c  599) hit |= grep_submodule(opt, pathspec, &entry.oid,
dba093ddc0 builtin/grep.c  641) obj->type == OBJ_COMMIT);
dba093ddc0 builtin/grep.c  658) real_obj = deref_tag(opt->repo, list->objects[i].item,
dba093ddc0 builtin/grep.c  663) submodule_free(opt->repo);
dba093ddc0 builtin/grep.c  688) fill_directory(&dir, opt->repo->index, pathspec);
dba093ddc0 builtin/grep.c  690) if (!dir_path_match(opt->repo->index, dir.entries[i], pathspec, 0, NULL))
3a7a698e93 builtin/grep.c 1028) if (get_oid_with_context(the_repository, arg,
dba093ddc0 builtin/grep.c 1132) hit = grep_cache(&opt, &pathspec, cached);

builtin/log.c
3a7a698e93 builtin/log.c  513) if (get_oid_with_context(the_repository, obj_name,

builtin/merge-tree.c
4478671442 builtin/merge-tree.c  80) return merge_blobs(the_repository->index, path,

builtin/merge.c
08339886b9 builtin/merge.c  120) static enum parse_opt_result option_read_message(struct parse_opt_ctx_t *ctx,
9b4ae5190a builtin/merge.c  128) BUG_ON_OPT_ARG(arg_not_used);

builtin/notes.c
1d18d7581c builtin/notes.c  333) commit_notes(the_repository, t, msg);
1d18d7581c builtin/notes.c  336) finish_copy_notes_for_rewrite(the_repository, c, msg);
1d18d7581c builtin/notes.c  472) commit_notes(the_repository, t,
1d18d7581c builtin/notes.c  478) commit_notes(the_repository, t,
1d18d7581c builtin/notes.c  557) commit_notes(the_repository, t,
1d18d7581c builtin/notes.c  642) commit_notes(the_repository, t, logmsg);
1d18d7581c builtin/notes.c  943) commit_notes(the_repository, t,
1d18d7581c builtin/notes.c  972) commit_notes(the_repository, t,

builtin/pack-objects.c
3d036eb0d2 builtin/pack-objects.c 2716) sparse = git_config_bool(k, v);
3d036eb0d2 builtin/pack-objects.c 2717) return 0;

builtin/pack-redundant.c
a338d10395 builtin/pack-redundant.c 339) static int cmp_remaining_objects(const void *a, const void *b)
e4e2c2884e builtin/pack-redundant.c 341) struct pack_list *pl_a = *((struct pack_list **)a);
e4e2c2884e builtin/pack-redundant.c 342) struct pack_list *pl_b = *((struct pack_list **)b);
a338d10395 builtin/pack-redundant.c 344) if (pl_a->remaining_objects->size == pl_b->remaining_objects->size) {
a338d10395 builtin/pack-redundant.c 346) if (pl_a->all_objects_size == pl_b->all_objects_size)
a338d10395 builtin/pack-redundant.c 347) return 0;
a338d10395 builtin/pack-redundant.c 348) else if (pl_a->all_objects_size < pl_b->all_objects_size)
a338d10395 builtin/pack-redundant.c 349) return 1;
a338d10395 builtin/pack-redundant.c 351) return -1;
a338d10395 builtin/pack-redundant.c 352) } else if (pl_a->remaining_objects->size < pl_b->remaining_objects->size) {
e4e2c2884e builtin/pack-redundant.c 354) return 1;
e4e2c2884e builtin/pack-redundant.c 356) return -1;
e4e2c2884e builtin/pack-redundant.c 361) static void sort_pack_list(struct pack_list **pl)
e4e2c2884e builtin/pack-redundant.c 365) size_t n = pack_list_size(*pl);
e4e2c2884e builtin/pack-redundant.c 367) if (n < 2)
e4e2c2884e builtin/pack-redundant.c 368) return;
e4e2c2884e builtin/pack-redundant.c 371) ary = xcalloc(n, sizeof(struct pack_list *));
e4e2c2884e builtin/pack-redundant.c 372) for (n = 0, p = *pl; p; p = p->next)
e4e2c2884e builtin/pack-redundant.c 373) ary[n++] = p;
a338d10395 builtin/pack-redundant.c 375) QSORT(ary, n, cmp_remaining_objects);
e4e2c2884e builtin/pack-redundant.c 378) for (i = 0; i < n - 1; i++)
e4e2c2884e builtin/pack-redundant.c 379) ary[i]->next = ary[i + 1];
e4e2c2884e builtin/pack-redundant.c 380) ary[n - 1]->next = NULL;
e4e2c2884e builtin/pack-redundant.c 381) *pl = ary[0];
e4e2c2884e builtin/pack-redundant.c 383) free(ary);
e4e2c2884e builtin/pack-redundant.c 389) struct pack_list *pl, *unique = NULL, *non_unique = NULL;
cb7e0336fc builtin/pack-redundant.c 404) llist_sorted_difference_inplace(missing, pl->remaining_objects);
e4e2c2884e builtin/pack-redundant.c 408) *min = unique;
e4e2c2884e builtin/pack-redundant.c 416) unique_pack_objects = llist_copy(all_objects);
e4e2c2884e builtin/pack-redundant.c 417) llist_sorted_difference_inplace(unique_pack_objects, missing);
e4e2c2884e builtin/pack-redundant.c 420) pl = non_unique;
cb7e0336fc builtin/pack-redundant.c 422) llist_sorted_difference_inplace(pl->remaining_objects, unique_pack_objects);
e4e2c2884e builtin/pack-redundant.c 426) while (non_unique) {
e4e2c2884e builtin/pack-redundant.c 428) sort_pack_list(&non_unique);
cb7e0336fc builtin/pack-redundant.c 429) if (non_unique->remaining_objects->size == 0)
e4e2c2884e builtin/pack-redundant.c 430) break;
e4e2c2884e builtin/pack-redundant.c 432) pack_list_insert(min, non_unique);
cb7e0336fc builtin/pack-redundant.c 434) for (pl = non_unique->next; pl && pl->remaining_objects->size > 0;  pl = pl->next)
cb7e0336fc builtin/pack-redundant.c 435) llist_sorted_difference_inplace(pl->remaining_objects, non_unique->remaining_objects);
e4e2c2884e builtin/pack-redundant.c 437) non_unique = non_unique->next;
cb7e0336fc builtin/pack-redundant.c 450) l = pl->remaining_objects->front;
cb7e0336fc builtin/pack-redundant.c 461) llist_sorted_difference_inplace(all_objects, pl->remaining_objects);
cb7e0336fc builtin/pack-redundant.c 490) llist_sorted_difference_inplace(all_objects, alt->remaining_objects);
cb7e0336fc builtin/pack-redundant.c 505) llist_init(&l.remaining_objects);
cb7e0336fc builtin/pack-redundant.c 514) llist_insert_back(l.remaining_objects, (const struct object_id *)(base + off));
a338d10395 builtin/pack-redundant.c 517) l.all_objects_size = l.remaining_objects->size;
cb7e0336fc builtin/pack-redundant.c 519) l.unique_objects = llist_copy(l.remaining_objects);
cb7e0336fc builtin/pack-redundant.c 615) llist_sorted_difference_inplace(pl->remaining_objects, ignore);

builtin/range-diff.c
26c50430dc 78) FREE_AND_NULL(options);

builtin/rebase--interactive.c
e5b1c9d929 builtin/rebase--interactive.c   17) static int edit_todo_file(unsigned flags)
e5b1c9d929 builtin/rebase--interactive.c   19) const char *todo_file = rebase_path_todo();
e5b1c9d929 builtin/rebase--interactive.c   20) struct todo_list todo_list = TODO_LIST_INIT,
e5b1c9d929 builtin/rebase--interactive.c   21) new_todo = TODO_LIST_INIT;
e5b1c9d929 builtin/rebase--interactive.c   23) if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
e5b1c9d929 builtin/rebase--interactive.c   24) return error_errno(_("could not read '%s'."), todo_file);
e5b1c9d929 builtin/rebase--interactive.c   26) strbuf_stripspace(&todo_list.buf, 1);
e5b1c9d929 builtin/rebase--interactive.c   27) if (!edit_todo_list(the_repository, &todo_list,
e5b1c9d929 builtin/rebase--interactive.c   28)     &new_todo, NULL, NULL, flags) &&
e5b1c9d929 builtin/rebase--interactive.c   29)     todo_list_write_to_file(the_repository, &new_todo, todo_file, NULL, NULL,
e5b1c9d929 builtin/rebase--interactive.c   31) return error_errno(_("could not write '%s'"), todo_file);
e5b1c9d929 builtin/rebase--interactive.c   33) todo_list_release(&todo_list);
e5b1c9d929 builtin/rebase--interactive.c   34) todo_list_release(&new_todo);
e5b1c9d929 builtin/rebase--interactive.c   36) return 0;
4d55dfd767 builtin/rebase--interactive.c   39) static int transform_todo_file(unsigned flags)
4d55dfd767 builtin/rebase--interactive.c   41) const char *todo_file = rebase_path_todo();
4d55dfd767 builtin/rebase--interactive.c   42) struct todo_list todo_list = TODO_LIST_INIT;
4d55dfd767 builtin/rebase--interactive.c   45) if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
4d55dfd767 builtin/rebase--interactive.c   46) return error_errno(_("could not read '%s'."), todo_file);
4d55dfd767 builtin/rebase--interactive.c   48) if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
4d55dfd767 builtin/rebase--interactive.c   50) todo_list_release(&todo_list);
4d55dfd767 builtin/rebase--interactive.c   51) return error(_("unusable todo list: '%s'"), todo_file);
4d55dfd767 builtin/rebase--interactive.c   54) res = todo_list_write_to_file(the_repository, &todo_list, todo_file,
4d55dfd767 builtin/rebase--interactive.c   56) todo_list_release(&todo_list);
4d55dfd767 builtin/rebase--interactive.c   58) if (res)
4d55dfd767 builtin/rebase--interactive.c   59) return error_errno(_("could not write '%s'."), todo_file);
4d55dfd767 builtin/rebase--interactive.c   60) return 0;
0566a4f68e builtin/rebase--interactive.c  121) struct todo_list todo_list = TODO_LIST_INIT;
0566a4f68e builtin/rebase--interactive.c  147) ret = sequencer_make_script(the_repository, &todo_list.buf,
c1c074e0cc builtin/rebase--interactive.c  155) if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
c1c074e0cc builtin/rebase--interactive.c  159) ret = complete_action(the_repository, opts, flags, shortrevisions, onto_name,
0566a4f68e builtin/rebase--interactive.c  165) todo_list_release(&todo_list);
8414c890aa builtin/rebase--interactive.c  269) if (cmd && *cmd) {
8414c890aa builtin/rebase--interactive.c  270) string_list_split(&commands, cmd, '\n', -1);
8414c890aa builtin/rebase--interactive.c  271) if (strlen(commands.items[commands.nr - 1].string) == 0)
8414c890aa builtin/rebase--interactive.c  272) --commands.nr;
e5b1c9d929 builtin/rebase--interactive.c  294) ret = edit_todo_file(flags);
4d55dfd767 builtin/rebase--interactive.c  307) ret = transform_todo_file(flags);
c27b32f0ec builtin/rebase--interactive.c  310) ret = check_todo_list_from_file(the_repository);
febebd99b6 builtin/rebase--interactive.c  313) ret = rearrange_squash_in_todo_file(the_repository);
8414c890aa builtin/rebase--interactive.c  316) ret = sequencer_add_exec_commands(the_repository, &commands);

builtin/rebase.c
b6b4172bfb  423) if (repo_read_index_unmerged(the_repository) < 0) {
e1ff0a32e4 1236) if (repo_read_index(the_repository) < 0)
1b0d968b34 1241) repo_update_index_if_able(the_repository, &lock_file);
e1ff0a32e4 1593) if (repo_read_index(the_repository) < 0)
1b0d968b34 1603) repo_update_index_if_able(the_repository, &lock_file);
e1ff0a32e4 1648) repo_read_index(the_repository) < 0)

builtin/replace.c
4478671442 builtin/replace.c 298) if (index_fd(the_repository->index, oid, fd, &st, type, NULL, flags) < 0)

builtin/stash.c
f6bbd78127 builtin/stash--helper.c  117) static void free_stash_info(struct stash_info *info)
f6bbd78127 builtin/stash--helper.c  119) strbuf_release(&info->revision);
f6bbd78127 builtin/stash--helper.c  120) }
f6bbd78127 builtin/stash--helper.c  122) static void assert_stash_like(struct stash_info *info, const char *revision)
f6bbd78127 builtin/stash--helper.c  124) if (get_oidf(&info->b_commit, "%s^1", revision) ||
f6bbd78127 builtin/stash--helper.c  125)     get_oidf(&info->w_tree, "%s:", revision) ||
f6bbd78127 builtin/stash--helper.c  126)     get_oidf(&info->b_tree, "%s^1:", revision) ||
f6bbd78127 builtin/stash--helper.c  127)     get_oidf(&info->i_tree, "%s^2:", revision))
f6bbd78127 builtin/stash--helper.c  128) die(_("'%s' is not a stash-like commit"), revision);
f6bbd78127 builtin/stash--helper.c  129) }
f6bbd78127 builtin/stash--helper.c  131) static int get_stash_info(struct stash_info *info, int argc, const char **argv)
f6bbd78127 builtin/stash--helper.c  137) const char *commit = NULL;
f6bbd78127 builtin/stash--helper.c  139) struct strbuf symbolic = STRBUF_INIT;
f6bbd78127 builtin/stash--helper.c  141) if (argc > 1) {
f6bbd78127 builtin/stash--helper.c  143) struct strbuf refs_msg = STRBUF_INIT;
f6bbd78127 builtin/stash--helper.c  145) for (i = 0; i < argc; i++)
f6bbd78127 builtin/stash--helper.c  146) strbuf_addf(&refs_msg, " '%s'", argv[i]);
f6bbd78127 builtin/stash--helper.c  148) fprintf_ln(stderr, _("Too many revisions specified:%s"),
f6bbd78127 builtin/stash--helper.c  150) strbuf_release(&refs_msg);
f6bbd78127 builtin/stash--helper.c  152) return -1;
f6bbd78127 builtin/stash--helper.c  155) if (argc == 1)
f6bbd78127 builtin/stash--helper.c  156) commit = argv[0];
f6bbd78127 builtin/stash--helper.c  158) strbuf_init(&info->revision, 0);
f6bbd78127 builtin/stash--helper.c  159) if (!commit) {
f6bbd78127 builtin/stash--helper.c  160) if (!ref_exists(ref_stash)) {
f6bbd78127 builtin/stash--helper.c  161) free_stash_info(info);
f6bbd78127 builtin/stash--helper.c  162) fprintf_ln(stderr, _("No stash entries found."));
f6bbd78127 builtin/stash--helper.c  163) return -1;
f6bbd78127 builtin/stash--helper.c  166) strbuf_addf(&info->revision, "%s@{0}", ref_stash);
f6bbd78127 builtin/stash--helper.c  167) } else if (strspn(commit, "0123456789") == strlen(commit)) {
f6bbd78127 builtin/stash--helper.c  168) strbuf_addf(&info->revision, "%s@{%s}", ref_stash, commit);
f6bbd78127 builtin/stash--helper.c  170) strbuf_addstr(&info->revision, commit);
f6bbd78127 builtin/stash--helper.c  173) revision = info->revision.buf;
f6bbd78127 builtin/stash--helper.c  175) if (get_oid(revision, &info->w_commit)) {
f6bbd78127 builtin/stash--helper.c  176) error(_("%s is not a valid reference"), revision);
f6bbd78127 builtin/stash--helper.c  177) free_stash_info(info);
f6bbd78127 builtin/stash--helper.c  178) return -1;
f6bbd78127 builtin/stash--helper.c  181) assert_stash_like(info, revision);
f6bbd78127 builtin/stash--helper.c  183) info->has_u = !get_oidf(&info->u_tree, "%s^3:", revision);
f6bbd78127 builtin/stash--helper.c  185) end_of_rev = strchrnul(revision, '@');
f6bbd78127 builtin/stash--helper.c  186) strbuf_add(&symbolic, revision, end_of_rev - revision);
f6bbd78127 builtin/stash--helper.c  188) ret = dwim_ref(symbolic.buf, symbolic.len, &dummy, &expanded_ref);
f6bbd78127 builtin/stash--helper.c  189) strbuf_release(&symbolic);
f6bbd78127 builtin/stash--helper.c  190) switch (ret) {
f6bbd78127 builtin/stash--helper.c  192) info->is_stash_ref = 0;
f6bbd78127 builtin/stash--helper.c  193) break;
f6bbd78127 builtin/stash--helper.c  195) info->is_stash_ref = !strcmp(expanded_ref, ref_stash);
f6bbd78127 builtin/stash--helper.c  196) break;
f6bbd78127 builtin/stash--helper.c  198) free_stash_info(info);
f6bbd78127 builtin/stash--helper.c  201) free(expanded_ref);
f6bbd78127 builtin/stash--helper.c  202) return !(ret == 0 || ret == 1);
cdca49bc4c builtin/stash--helper.c  205) static int do_clear_stash(void)
cdca49bc4c builtin/stash--helper.c  208) if (get_oid(ref_stash, &obj))
cdca49bc4c builtin/stash--helper.c  209) return 0;
cdca49bc4c builtin/stash--helper.c  211) return delete_ref(NULL, ref_stash, &obj, 0);
cdca49bc4c builtin/stash--helper.c  214) static int clear_stash(int argc, const char **argv, const char *prefix)
cdca49bc4c builtin/stash--helper.c  216) struct option options[] = {
cdca49bc4c builtin/stash--helper.c  220) argc = parse_options(argc, argv, prefix, options,
cdca49bc4c builtin/stash--helper.c  224) if (argc)
cdca49bc4c builtin/stash--helper.c  225) return error(_("git stash clear with parameters is "
cdca49bc4c builtin/stash--helper.c  228) return do_clear_stash();
f6bbd78127 builtin/stash--helper.c  231) static int reset_tree(struct object_id *i_tree, int update, int reset)
f6bbd78127 builtin/stash--helper.c  233) int nr_trees = 1;
f6bbd78127 builtin/stash--helper.c  237) struct lock_file lock_file = LOCK_INIT;
f6bbd78127 builtin/stash--helper.c  239) read_cache_preload(NULL);
f6bbd78127 builtin/stash--helper.c  240) if (refresh_cache(REFRESH_QUIET))
f6bbd78127 builtin/stash--helper.c  241) return -1;
f6bbd78127 builtin/stash--helper.c  243) hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
f6bbd78127 builtin/stash--helper.c  245) memset(&opts, 0, sizeof(opts));
f6bbd78127 builtin/stash--helper.c  247) tree = parse_tree_indirect(i_tree);
f6bbd78127 builtin/stash--helper.c  248) if (parse_tree(tree))
f6bbd78127 builtin/stash--helper.c  249) return -1;
f6bbd78127 builtin/stash--helper.c  251) init_tree_desc(t, tree->buffer, tree->size);
f6bbd78127 builtin/stash--helper.c  253) opts.head_idx = 1;
f6bbd78127 builtin/stash--helper.c  254) opts.src_index = &the_index;
f6bbd78127 builtin/stash--helper.c  255) opts.dst_index = &the_index;
f6bbd78127 builtin/stash--helper.c  256) opts.merge = 1;
f6bbd78127 builtin/stash--helper.c  257) opts.reset = reset;
f6bbd78127 builtin/stash--helper.c  258) opts.update = update;
f6bbd78127 builtin/stash--helper.c  259) opts.fn = oneway_merge;
f6bbd78127 builtin/stash--helper.c  261) if (unpack_trees(nr_trees, t, &opts))
f6bbd78127 builtin/stash--helper.c  262) return -1;
f6bbd78127 builtin/stash--helper.c  264) if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
f6bbd78127 builtin/stash--helper.c  265) return error(_("unable to write new index file"));
f6bbd78127 builtin/stash--helper.c  267) return 0;
f6bbd78127 builtin/stash--helper.c  270) static int diff_tree_binary(struct strbuf *out, struct object_id *w_commit)
f6bbd78127 builtin/stash--helper.c  272) struct child_process cp = CHILD_PROCESS_INIT;
f6bbd78127 builtin/stash--helper.c  273) const char *w_commit_hex = oid_to_hex(w_commit);
f6bbd78127 builtin/stash--helper.c  279) cp.git_cmd = 1;
f6bbd78127 builtin/stash--helper.c  280) argv_array_pushl(&cp.args, "diff-tree", "--binary", NULL);
f6bbd78127 builtin/stash--helper.c  281) argv_array_pushf(&cp.args, "%s^2^..%s^2", w_commit_hex, w_commit_hex);
f6bbd78127 builtin/stash--helper.c  283) return pipe_command(&cp, NULL, 0, out, 0, NULL, 0);
f6bbd78127 builtin/stash--helper.c  286) static int apply_cached(struct strbuf *out)
f6bbd78127 builtin/stash--helper.c  288) struct child_process cp = CHILD_PROCESS_INIT;
f6bbd78127 builtin/stash--helper.c  295) cp.git_cmd = 1;
f6bbd78127 builtin/stash--helper.c  296) argv_array_pushl(&cp.args, "apply", "--cached", NULL);
f6bbd78127 builtin/stash--helper.c  297) return pipe_command(&cp, out->buf, out->len, NULL, 0, NULL, 0);
f6bbd78127 builtin/stash--helper.c  300) static int reset_head(void)
f6bbd78127 builtin/stash--helper.c  302) struct child_process cp = CHILD_PROCESS_INIT;
f6bbd78127 builtin/stash--helper.c  308) cp.git_cmd = 1;
f6bbd78127 builtin/stash--helper.c  309) argv_array_push(&cp.args, "reset");
f6bbd78127 builtin/stash--helper.c  311) return run_command(&cp);
1f5a011d90 builtin/stash--helper.c  314) static void add_diff_to_buf(struct diff_queue_struct *q,
1f5a011d90 builtin/stash--helper.c  320) for (i = 0; i < q->nr; i++) {
1f5a011d90 builtin/stash--helper.c  321) strbuf_addstr(data, q->queue[i]->one->path);
1f5a011d90 builtin/stash--helper.c  328) strbuf_addch(data, '\0');
1f5a011d90 builtin/stash--helper.c  330) }
f6bbd78127 builtin/stash--helper.c  332) static int get_newly_staged(struct strbuf *out, struct object_id *c_tree)
f6bbd78127 builtin/stash--helper.c  334) struct child_process cp = CHILD_PROCESS_INIT;
f6bbd78127 builtin/stash--helper.c  335) const char *c_tree_hex = oid_to_hex(c_tree);
f6bbd78127 builtin/stash--helper.c  341) cp.git_cmd = 1;
f6bbd78127 builtin/stash--helper.c  342) argv_array_pushl(&cp.args, "diff-index", "--cached", "--name-only",
f6bbd78127 builtin/stash--helper.c  344) argv_array_push(&cp.args, c_tree_hex);
f6bbd78127 builtin/stash--helper.c  345) return pipe_command(&cp, NULL, 0, out, 0, NULL, 0);
f6bbd78127 builtin/stash--helper.c  348) static int update_index(struct strbuf *out)
f6bbd78127 builtin/stash--helper.c  350) struct child_process cp = CHILD_PROCESS_INIT;
f6bbd78127 builtin/stash--helper.c  356) cp.git_cmd = 1;
f6bbd78127 builtin/stash--helper.c  357) argv_array_pushl(&cp.args, "update-index", "--add", "--stdin", NULL);
f6bbd78127 builtin/stash--helper.c  358) return pipe_command(&cp, out->buf, out->len, NULL, 0, NULL, 0);
f6bbd78127 builtin/stash--helper.c  361) static int restore_untracked(struct object_id *u_tree)
f6bbd78127 builtin/stash--helper.c  364) struct child_process cp = CHILD_PROCESS_INIT;
f6bbd78127 builtin/stash--helper.c  371) cp.git_cmd = 1;
f6bbd78127 builtin/stash--helper.c  372) argv_array_push(&cp.args, "read-tree");
f6bbd78127 builtin/stash--helper.c  373) argv_array_push(&cp.args, oid_to_hex(u_tree));
f6bbd78127 builtin/stash--helper.c  374) argv_array_pushf(&cp.env_array, "GIT_INDEX_FILE=%s",
f6bbd78127 builtin/stash--helper.c  376) if (run_command(&cp)) {
f6bbd78127 builtin/stash--helper.c  377) remove_path(stash_index_path.buf);
f6bbd78127 builtin/stash--helper.c  378) return -1;
f6bbd78127 builtin/stash--helper.c  381) child_process_init(&cp);
f6bbd78127 builtin/stash--helper.c  382) cp.git_cmd = 1;
f6bbd78127 builtin/stash--helper.c  383) argv_array_pushl(&cp.args, "checkout-index", "--all", NULL);
f6bbd78127 builtin/stash--helper.c  384) argv_array_pushf(&cp.env_array, "GIT_INDEX_FILE=%s",
f6bbd78127 builtin/stash--helper.c  387) res = run_command(&cp);
f6bbd78127 builtin/stash--helper.c  388) remove_path(stash_index_path.buf);
f6bbd78127 builtin/stash--helper.c  389) return res;
f6bbd78127 builtin/stash--helper.c  392) static int do_apply_stash(const char *prefix, struct stash_info *info,
f6bbd78127 builtin/stash--helper.c  396) int has_index = index;
f6bbd78127 builtin/stash--helper.c  403) read_cache_preload(NULL);
f6bbd78127 builtin/stash--helper.c  404) if (refresh_cache(REFRESH_QUIET))
f6bbd78127 builtin/stash--helper.c  405) return -1;
f6bbd78127 builtin/stash--helper.c  407) if (write_cache_as_tree(&c_tree, 0, NULL) || reset_tree(&c_tree, 0, 0))
f6bbd78127 builtin/stash--helper.c  408) return error(_("cannot apply a stash in the middle of a merge"));
f6bbd78127 builtin/stash--helper.c  410) if (index) {
f6bbd78127 builtin/stash--helper.c  411) if (oideq(&info->b_tree, &info->i_tree) ||
f6bbd78127 builtin/stash--helper.c  412)     oideq(&c_tree, &info->i_tree)) {
f6bbd78127 builtin/stash--helper.c  413) has_index = 0;
f6bbd78127 builtin/stash--helper.c  415) struct strbuf out = STRBUF_INIT;
f6bbd78127 builtin/stash--helper.c  417) if (diff_tree_binary(&out, &info->w_commit)) {
f6bbd78127 builtin/stash--helper.c  418) strbuf_release(&out);
f6bbd78127 builtin/stash--helper.c  419) return error(_("could not generate diff %s^!."),
f6bbd78127 builtin/stash--helper.c  423) ret = apply_cached(&out);
f6bbd78127 builtin/stash--helper.c  424) strbuf_release(&out);
f6bbd78127 builtin/stash--helper.c  425) if (ret)
f6bbd78127 builtin/stash--helper.c  426) return error(_("conflicts in index."
f6bbd78127 builtin/stash--helper.c  429) discard_cache();
f6bbd78127 builtin/stash--helper.c  430) read_cache();
f6bbd78127 builtin/stash--helper.c  431) if (write_cache_as_tree(&index_tree, 0, NULL))
f6bbd78127 builtin/stash--helper.c  432) return error(_("could not save index tree"));
f6bbd78127 builtin/stash--helper.c  434) reset_head();
f6bbd78127 builtin/stash--helper.c  438) if (info->has_u && restore_untracked(&info->u_tree))
f6bbd78127 builtin/stash--helper.c  439) return error(_("could not restore untracked files from stash"));
b6b4172bfb builtin/stash.c          441) init_merge_options(&o, the_repository);
f6bbd78127 builtin/stash--helper.c  443) o.branch1 = "Updated upstream";
f6bbd78127 builtin/stash--helper.c  444) o.branch2 = "Stashed changes";
f6bbd78127 builtin/stash--helper.c  446) if (oideq(&info->b_tree, &c_tree))
f6bbd78127 builtin/stash--helper.c  447) o.branch1 = "Version stash was based on";
f6bbd78127 builtin/stash--helper.c  449) if (quiet)
f6bbd78127 builtin/stash--helper.c  450) o.verbosity = 0;
f6bbd78127 builtin/stash--helper.c  452) if (o.verbosity >= 3)
f6bbd78127 builtin/stash--helper.c  453) printf_ln(_("Merging %s with %s"), o.branch1, o.branch2);
f6bbd78127 builtin/stash--helper.c  455) bases[0] = &info->b_tree;
f6bbd78127 builtin/stash--helper.c  457) ret = merge_recursive_generic(&o, &c_tree, &info->w_tree, 1, bases,
f6bbd78127 builtin/stash--helper.c  459) if (ret) {
f6bbd78127 builtin/stash--helper.c  460) rerere(0);
f6bbd78127 builtin/stash--helper.c  462) if (index)
f6bbd78127 builtin/stash--helper.c  463) fprintf_ln(stderr, _("Index was not unstashed."));
f6bbd78127 builtin/stash--helper.c  465) return ret;
f6bbd78127 builtin/stash--helper.c  468) if (has_index) {
f6bbd78127 builtin/stash--helper.c  469) if (reset_tree(&index_tree, 0, 0))
f6bbd78127 builtin/stash--helper.c  470) return -1;
f6bbd78127 builtin/stash--helper.c  472) struct strbuf out = STRBUF_INIT;
f6bbd78127 builtin/stash--helper.c  474) if (get_newly_staged(&out, &c_tree)) {
f6bbd78127 builtin/stash--helper.c  475) strbuf_release(&out);
f6bbd78127 builtin/stash--helper.c  476) return -1;
f6bbd78127 builtin/stash--helper.c  479) if (reset_tree(&c_tree, 0, 1)) {
f6bbd78127 builtin/stash--helper.c  480) strbuf_release(&out);
f6bbd78127 builtin/stash--helper.c  481) return -1;
f6bbd78127 builtin/stash--helper.c  484) ret = update_index(&out);
f6bbd78127 builtin/stash--helper.c  485) strbuf_release(&out);
f6bbd78127 builtin/stash--helper.c  486) if (ret)
f6bbd78127 builtin/stash--helper.c  487) return -1;
f6bbd78127 builtin/stash--helper.c  489) discard_cache();
f6bbd78127 builtin/stash--helper.c  492) if (quiet) {
f6bbd78127 builtin/stash--helper.c  493) if (refresh_cache(REFRESH_QUIET))
f6bbd78127 builtin/stash--helper.c  494) warning("could not refresh index");
f6bbd78127 builtin/stash--helper.c  496) struct child_process cp = CHILD_PROCESS_INIT;
f6bbd78127 builtin/stash--helper.c  503) cp.git_cmd = 1;
f6bbd78127 builtin/stash--helper.c  504) cp.dir = prefix;
f6bbd78127 builtin/stash--helper.c  505) argv_array_push(&cp.args, "status");
f6bbd78127 builtin/stash--helper.c  506) run_command(&cp);
f6bbd78127 builtin/stash--helper.c  509) return 0;
f6bbd78127 builtin/stash--helper.c  512) static int apply_stash(int argc, const char **argv, const char *prefix)
f6bbd78127 builtin/stash--helper.c  515) int quiet = 0;
f6bbd78127 builtin/stash--helper.c  516) int index = 0;
f6bbd78127 builtin/stash--helper.c  518) struct option options[] = {
f6bbd78127 builtin/stash--helper.c  525) argc = parse_options(argc, argv, prefix, options,
f6bbd78127 builtin/stash--helper.c  528) if (get_stash_info(&info, argc, argv))
f6bbd78127 builtin/stash--helper.c  529) return -1;
f6bbd78127 builtin/stash--helper.c  531) ret = do_apply_stash(prefix, &info, index, quiet);
f6bbd78127 builtin/stash--helper.c  532) free_stash_info(&info);
f6bbd78127 builtin/stash--helper.c  533) return ret;
cdca49bc4c builtin/stash--helper.c  536) static int do_drop_stash(const char *prefix, struct stash_info *info, int quiet)
cdca49bc4c builtin/stash--helper.c  539) struct child_process cp_reflog = CHILD_PROCESS_INIT;
cdca49bc4c builtin/stash--helper.c  540) struct child_process cp = CHILD_PROCESS_INIT;
cdca49bc4c builtin/stash--helper.c  547) cp_reflog.git_cmd = 1;
cdca49bc4c builtin/stash--helper.c  548) argv_array_pushl(&cp_reflog.args, "reflog", "delete", "--updateref",
cdca49bc4c builtin/stash--helper.c  550) argv_array_push(&cp_reflog.args, info->revision.buf);
cdca49bc4c builtin/stash--helper.c  551) ret = run_command(&cp_reflog);
cdca49bc4c builtin/stash--helper.c  552) if (!ret) {
cdca49bc4c builtin/stash--helper.c  553) if (!quiet)
cdca49bc4c builtin/stash--helper.c  554) printf_ln(_("Dropped %s (%s)"), info->revision.buf,
cdca49bc4c builtin/stash--helper.c  555)   oid_to_hex(&info->w_commit));
cdca49bc4c builtin/stash--helper.c  557) return error(_("%s: Could not drop stash entry"),
cdca49bc4c builtin/stash--helper.c  565) cp.git_cmd = 1;
cdca49bc4c builtin/stash--helper.c  567) cp.no_stdout = 1;
cdca49bc4c builtin/stash--helper.c  568) argv_array_pushl(&cp.args, "rev-parse", "--verify", "--quiet", NULL);
cdca49bc4c builtin/stash--helper.c  569) argv_array_pushf(&cp.args, "%s@{0}", ref_stash);
cdca49bc4c builtin/stash--helper.c  570) ret = run_command(&cp);
cdca49bc4c builtin/stash--helper.c  573) if (ret)
cdca49bc4c builtin/stash--helper.c  574) do_clear_stash();
cdca49bc4c builtin/stash--helper.c  576) return 0;
cdca49bc4c builtin/stash--helper.c  579) static void assert_stash_ref(struct stash_info *info)
cdca49bc4c builtin/stash--helper.c  581) if (!info->is_stash_ref) {
cdca49bc4c builtin/stash--helper.c  582) free_stash_info(info);
cdca49bc4c builtin/stash--helper.c  583) error(_("'%s' is not a stash reference"), info->revision.buf);
cdca49bc4c builtin/stash--helper.c  584) exit(128);
cdca49bc4c builtin/stash--helper.c  586) }
cdca49bc4c builtin/stash--helper.c  588) static int drop_stash(int argc, const char **argv, const char *prefix)
cdca49bc4c builtin/stash--helper.c  591) int quiet = 0;
cdca49bc4c builtin/stash--helper.c  593) struct option options[] = {
cdca49bc4c builtin/stash--helper.c  598) argc = parse_options(argc, argv, prefix, options,
cdca49bc4c builtin/stash--helper.c  601) if (get_stash_info(&info, argc, argv))
cdca49bc4c builtin/stash--helper.c  602) return -1;
cdca49bc4c builtin/stash--helper.c  604) assert_stash_ref(&info);
cdca49bc4c builtin/stash--helper.c  606) ret = do_drop_stash(prefix, &info, quiet);
cdca49bc4c builtin/stash--helper.c  607) free_stash_info(&info);
cdca49bc4c builtin/stash--helper.c  608) return ret;
e1d01876a4 builtin/stash--helper.c  611) static int pop_stash(int argc, const char **argv, const char *prefix)
e1d01876a4 builtin/stash--helper.c  614) int index = 0;
e1d01876a4 builtin/stash--helper.c  615) int quiet = 0;
e1d01876a4 builtin/stash--helper.c  617) struct option options[] = {
e1d01876a4 builtin/stash--helper.c  624) argc = parse_options(argc, argv, prefix, options,
e1d01876a4 builtin/stash--helper.c  627) if (get_stash_info(&info, argc, argv))
e1d01876a4 builtin/stash--helper.c  628) return -1;
e1d01876a4 builtin/stash--helper.c  630) assert_stash_ref(&info);
e1d01876a4 builtin/stash--helper.c  631) if ((ret = do_apply_stash(prefix, &info, index, quiet)))
e1d01876a4 builtin/stash--helper.c  632) printf_ln(_("The stash entry is kept in case "
e1d01876a4 builtin/stash--helper.c  635) ret = do_drop_stash(prefix, &info, quiet);
e1d01876a4 builtin/stash--helper.c  637) free_stash_info(&info);
e1d01876a4 builtin/stash--helper.c  638) return ret;
f596f3366c builtin/stash--helper.c  641) static int branch_stash(int argc, const char **argv, const char *prefix)
f596f3366c builtin/stash--helper.c  644) const char *branch = NULL;
f596f3366c builtin/stash--helper.c  646) struct child_process cp = CHILD_PROCESS_INIT;
f596f3366c builtin/stash--helper.c  647) struct option options[] = {
f596f3366c builtin/stash--helper.c  651) argc = parse_options(argc, argv, prefix, options,
f596f3366c builtin/stash--helper.c  654) if (!argc) {
f596f3366c builtin/stash--helper.c  655) fprintf_ln(stderr, _("No branch name specified"));
f596f3366c builtin/stash--helper.c  656) return -1;
f596f3366c builtin/stash--helper.c  659) branch = argv[0];
f596f3366c builtin/stash--helper.c  661) if (get_stash_info(&info, argc - 1, argv + 1))
f596f3366c builtin/stash--helper.c  662) return -1;
f596f3366c builtin/stash--helper.c  664) cp.git_cmd = 1;
f596f3366c builtin/stash--helper.c  665) argv_array_pushl(&cp.args, "checkout", "-b", NULL);
f596f3366c builtin/stash--helper.c  666) argv_array_push(&cp.args, branch);
f596f3366c builtin/stash--helper.c  667) argv_array_push(&cp.args, oid_to_hex(&info.b_commit));
f596f3366c builtin/stash--helper.c  668) ret = run_command(&cp);
f596f3366c builtin/stash--helper.c  669) if (!ret)
f596f3366c builtin/stash--helper.c  670) ret = do_apply_stash(prefix, &info, 1, 0);
f596f3366c builtin/stash--helper.c  671) if (!ret && info.is_stash_ref)
f596f3366c builtin/stash--helper.c  672) ret = do_drop_stash(prefix, &info, 0);
f596f3366c builtin/stash--helper.c  674) free_stash_info(&info);
f596f3366c builtin/stash--helper.c  676) return ret;
9b77b07ba4 builtin/stash--helper.c  679) static int list_stash(int argc, const char **argv, const char *prefix)
9b77b07ba4 builtin/stash--helper.c  681) struct child_process cp = CHILD_PROCESS_INIT;
9b77b07ba4 builtin/stash--helper.c  682) struct option options[] = {
9b77b07ba4 builtin/stash--helper.c  686) argc = parse_options(argc, argv, prefix, options,
9b77b07ba4 builtin/stash--helper.c  690) if (!ref_exists(ref_stash))
9b77b07ba4 builtin/stash--helper.c  691) return 0;
9b77b07ba4 builtin/stash--helper.c  693) cp.git_cmd = 1;
9b77b07ba4 builtin/stash--helper.c  694) argv_array_pushl(&cp.args, "log", "--format=%gd: %gs", "-g",
9b77b07ba4 builtin/stash--helper.c  696) argv_array_pushv(&cp.args, argv);
9b77b07ba4 builtin/stash--helper.c  697) argv_array_push(&cp.args, ref_stash);
9b77b07ba4 builtin/stash--helper.c  698) argv_array_push(&cp.args, "--");
9b77b07ba4 builtin/stash--helper.c  699) return run_command(&cp);
b4493f269e builtin/stash--helper.c  705) static int git_stash_config(const char *var, const char *value, void *cb)
b4493f269e builtin/stash--helper.c  707) if (!strcmp(var, "stash.showstat")) {
b4493f269e builtin/stash--helper.c  708) show_stat = git_config_bool(var, value);
b4493f269e builtin/stash--helper.c  709) return 0;
b4493f269e builtin/stash--helper.c  711) if (!strcmp(var, "stash.showpatch")) {
b4493f269e builtin/stash--helper.c  712) show_patch = git_config_bool(var, value);
b4493f269e builtin/stash--helper.c  713) return 0;
b4493f269e builtin/stash--helper.c  715) return git_default_config(var, value, cb);
b4493f269e builtin/stash--helper.c  718) static int show_stash(int argc, const char **argv, const char *prefix)
b4493f269e builtin/stash--helper.c  721) int opts = 0;
b4493f269e builtin/stash--helper.c  722) int ret = 0;
b4493f269e builtin/stash--helper.c  725) struct argv_array stash_args = ARGV_ARRAY_INIT;
b4493f269e builtin/stash--helper.c  726) struct option options[] = {
b4493f269e builtin/stash--helper.c  730) init_diff_ui_defaults();
b4493f269e builtin/stash--helper.c  731) git_config(git_diff_ui_config, NULL);
b4493f269e builtin/stash--helper.c  732) init_revisions(&rev, prefix);
b4493f269e builtin/stash--helper.c  734) for (i = 1; i < argc; i++) {
b4493f269e builtin/stash--helper.c  735) if (argv[i][0] != '-')
b4493f269e builtin/stash--helper.c  736) argv_array_push(&stash_args, argv[i]);
b4493f269e builtin/stash--helper.c  738) opts++;
b4493f269e builtin/stash--helper.c  741) ret = get_stash_info(&info, stash_args.argc, stash_args.argv);
b4493f269e builtin/stash--helper.c  742) argv_array_clear(&stash_args);
b4493f269e builtin/stash--helper.c  743) if (ret)
b4493f269e builtin/stash--helper.c  744) return -1;
b4493f269e builtin/stash--helper.c  750) if (!opts) {
b4493f269e builtin/stash--helper.c  751) git_config(git_stash_config, NULL);
b4493f269e builtin/stash--helper.c  752) if (show_stat)
b4493f269e builtin/stash--helper.c  753) rev.diffopt.output_format = DIFF_FORMAT_DIFFSTAT;
b4493f269e builtin/stash--helper.c  755) if (show_patch)
b4493f269e builtin/stash--helper.c  756) rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
b4493f269e builtin/stash--helper.c  758) if (!show_stat && !show_patch) {
b4493f269e builtin/stash--helper.c  759) free_stash_info(&info);
b4493f269e builtin/stash--helper.c  760) return 0;
b4493f269e builtin/stash--helper.c  764) argc = setup_revisions(argc, argv, &rev, NULL);
b4493f269e builtin/stash--helper.c  765) if (argc > 1) {
b4493f269e builtin/stash--helper.c  766) free_stash_info(&info);
51809c70ca builtin/stash.c          767) usage_with_options(git_stash_show_usage, options);
b4493f269e builtin/stash--helper.c  770) rev.diffopt.flags.recursive = 1;
b4493f269e builtin/stash--helper.c  771) setup_diff_pager(&rev.diffopt);
b4493f269e builtin/stash--helper.c  772) diff_tree_oid(&info.b_commit, &info.w_commit, "", &rev.diffopt);
b4493f269e builtin/stash--helper.c  773) log_tree_diff_flush(&rev);
b4493f269e builtin/stash--helper.c  775) free_stash_info(&info);
b4493f269e builtin/stash--helper.c  776) return diff_result_code(&rev.diffopt, 0);
847eb0b0a8 builtin/stash--helper.c  779) static int do_store_stash(const struct object_id *w_commit, const char *stash_msg,
847eb0b0a8 builtin/stash--helper.c  782) if (!stash_msg)
847eb0b0a8 builtin/stash--helper.c  783) stash_msg = "Created via \"git stash store\".";
847eb0b0a8 builtin/stash--helper.c  785) if (update_ref(stash_msg, ref_stash, w_commit, NULL,
847eb0b0a8 builtin/stash--helper.c  789) if (!quiet) {
847eb0b0a8 builtin/stash--helper.c  790) fprintf_ln(stderr, _("Cannot update %s with %s"),
847eb0b0a8 builtin/stash--helper.c  793) return -1;
847eb0b0a8 builtin/stash--helper.c  796) return 0;
847eb0b0a8 builtin/stash--helper.c  799) static int store_stash(int argc, const char **argv, const char *prefix)
847eb0b0a8 builtin/stash--helper.c  801) int quiet = 0;
847eb0b0a8 builtin/stash--helper.c  802) const char *stash_msg = NULL;
847eb0b0a8 builtin/stash--helper.c  805) struct option options[] = {
847eb0b0a8 builtin/stash--helper.c  812) argc = parse_options(argc, argv, prefix, options,
847eb0b0a8 builtin/stash--helper.c  816) if (argc != 1) {
847eb0b0a8 builtin/stash--helper.c  817) if (!quiet)
847eb0b0a8 builtin/stash--helper.c  818) fprintf_ln(stderr, _("\"git stash store\" requires one "
847eb0b0a8 builtin/stash--helper.c  820) return -1;
b6b4172bfb builtin/stash.c          823) if (get_oid_with_context(the_repository,
847eb0b0a8 builtin/stash--helper.c  826) if (!quiet)
847eb0b0a8 builtin/stash--helper.c  827) fprintf_ln(stderr, _("Cannot update %s with %s"),
847eb0b0a8 builtin/stash--helper.c  829) return -1;
847eb0b0a8 builtin/stash--helper.c  832) return do_store_stash(&obj, stash_msg, quiet);
1f5a011d90 builtin/stash--helper.c  835) static void add_pathspecs(struct argv_array *args,
1f5a011d90 builtin/stash--helper.c  839) for (i = 0; i < ps.nr; i++)
1f5a011d90 builtin/stash--helper.c  840) argv_array_push(args, ps.items[i].match);
1f5a011d90 builtin/stash--helper.c  841) }
1f5a011d90 builtin/stash--helper.c  850) static int get_untracked_files(struct pathspec ps, int include_untracked,
1f5a011d90 builtin/stash--helper.c  855) int found = 0;
1f5a011d90 builtin/stash--helper.c  859) memset(&dir, 0, sizeof(dir));
1f5a011d90 builtin/stash--helper.c  860) if (include_untracked != INCLUDE_ALL_FILES)
1f5a011d90 builtin/stash--helper.c  861) setup_standard_excludes(&dir);
1f5a011d90 builtin/stash--helper.c  863) seen = xcalloc(ps.nr, 1);
1f5a011d90 builtin/stash--helper.c  865) max_len = fill_directory(&dir, the_repository->index, &ps);
1f5a011d90 builtin/stash--helper.c  866) for (i = 0; i < dir.nr; i++) {
1f5a011d90 builtin/stash--helper.c  867) struct dir_entry *ent = dir.entries[i];
1f5a011d90 builtin/stash--helper.c  868) if (dir_path_match(&the_index, ent, &ps, max_len, seen)) {
1f5a011d90 builtin/stash--helper.c  869) found++;
1f5a011d90 builtin/stash--helper.c  870) strbuf_addstr(untracked_files, ent->name);
1f5a011d90 builtin/stash--helper.c  872) strbuf_addch(untracked_files, 0);
1f5a011d90 builtin/stash--helper.c  874) free(ent);
1f5a011d90 builtin/stash--helper.c  877) free(seen);
1f5a011d90 builtin/stash--helper.c  878) free(dir.entries);
1f5a011d90 builtin/stash--helper.c  879) free(dir.ignored);
1f5a011d90 builtin/stash--helper.c  880) clear_directory(&dir);
1f5a011d90 builtin/stash--helper.c  881) return found;
168e6cff5e builtin/stash--helper.c  892) static int check_changes_tracked_files(struct pathspec ps)
1f5a011d90 builtin/stash--helper.c  899) if (get_oid("HEAD", &dummy))
1f5a011d90 builtin/stash--helper.c  900) return -1;
1f5a011d90 builtin/stash--helper.c  902) if (read_cache() < 0)
1f5a011d90 builtin/stash--helper.c  903) return -1;
1f5a011d90 builtin/stash--helper.c  905) init_revisions(&rev, NULL);
1f5a011d90 builtin/stash--helper.c  906) rev.prune_data = ps;
1f5a011d90 builtin/stash--helper.c  908) rev.diffopt.flags.quick = 1;
1f5a011d90 builtin/stash--helper.c  909) rev.diffopt.flags.ignore_submodules = 1;
1f5a011d90 builtin/stash--helper.c  910) rev.abbrev = 0;
1f5a011d90 builtin/stash--helper.c  912) add_head_to_pending(&rev);
1f5a011d90 builtin/stash--helper.c  913) diff_setup_done(&rev.diffopt);
1f5a011d90 builtin/stash--helper.c  915) result = run_diff_index(&rev, 1);
1f5a011d90 builtin/stash--helper.c  916) if (diff_result_code(&rev.diffopt, result))
1f5a011d90 builtin/stash--helper.c  917) return 1;
1f5a011d90 builtin/stash--helper.c  919) object_array_clear(&rev.pending);
1f5a011d90 builtin/stash--helper.c  920) result = run_diff_files(&rev, 0);
1f5a011d90 builtin/stash--helper.c  921) if (diff_result_code(&rev.diffopt, result))
1f5a011d90 builtin/stash--helper.c  922) return 1;
168e6cff5e builtin/stash--helper.c  924) return 0;
168e6cff5e builtin/stash--helper.c  932) static int check_changes(struct pathspec ps, int include_untracked,
168e6cff5e builtin/stash--helper.c  935) int ret = 0;
168e6cff5e builtin/stash--helper.c  936) if (check_changes_tracked_files(ps))
168e6cff5e builtin/stash--helper.c  937) ret = 1;
1f5a011d90 builtin/stash--helper.c  939) if (include_untracked && get_untracked_files(ps, include_untracked,
168e6cff5e builtin/stash--helper.c  941) ret = 1;
168e6cff5e builtin/stash--helper.c  943) return ret;
1f5a011d90 builtin/stash--helper.c  946) static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
1f5a011d90 builtin/stash--helper.c  949) int ret = 0;
1f5a011d90 builtin/stash--helper.c  950) struct strbuf untracked_msg = STRBUF_INIT;
1f5a011d90 builtin/stash--helper.c  951) struct child_process cp_upd_index = CHILD_PROCESS_INIT;
559edead8f builtin/stash--helper.c  952) struct index_state istate = { NULL };
1f5a011d90 builtin/stash--helper.c  954) cp_upd_index.git_cmd = 1;
1f5a011d90 builtin/stash--helper.c  955) argv_array_pushl(&cp_upd_index.args, "update-index", "-z", "--add",
1f5a011d90 builtin/stash--helper.c  957) argv_array_pushf(&cp_upd_index.env_array, "GIT_INDEX_FILE=%s",
1f5a011d90 builtin/stash--helper.c  960) strbuf_addf(&untracked_msg, "untracked files on %s\n", msg->buf);
1f5a011d90 builtin/stash--helper.c  961) if (pipe_command(&cp_upd_index, files.buf, files.len, NULL, 0,
1f5a011d90 builtin/stash--helper.c  963) ret = -1;
1f5a011d90 builtin/stash--helper.c  964) goto done;
559edead8f builtin/stash--helper.c  967) if (write_index_as_tree(&info->u_tree, &istate, stash_index_path.buf, 0,
1f5a011d90 builtin/stash--helper.c  969) ret = -1;
1f5a011d90 builtin/stash--helper.c  970) goto done;
1f5a011d90 builtin/stash--helper.c  973) if (commit_tree(untracked_msg.buf, untracked_msg.len,
1f5a011d90 builtin/stash--helper.c  974) &info->u_tree, NULL, &info->u_commit, NULL, NULL)) {
1f5a011d90 builtin/stash--helper.c  975) ret = -1;
1f5a011d90 builtin/stash--helper.c  976) goto done;
559edead8f builtin/stash--helper.c  980) discard_index(&istate);
1f5a011d90 builtin/stash--helper.c  981) strbuf_release(&untracked_msg);
1f5a011d90 builtin/stash--helper.c  982) remove_path(stash_index_path.buf);
1f5a011d90 builtin/stash--helper.c  983) return ret;
1f5a011d90 builtin/stash--helper.c  986) static int stash_patch(struct stash_info *info, struct pathspec ps,
1f5a011d90 builtin/stash--helper.c  989) int ret = 0;
1f5a011d90 builtin/stash--helper.c  990) struct child_process cp_read_tree = CHILD_PROCESS_INIT;
1f5a011d90 builtin/stash--helper.c  991) struct child_process cp_add_i = CHILD_PROCESS_INIT;
1f5a011d90 builtin/stash--helper.c  992) struct child_process cp_diff_tree = CHILD_PROCESS_INIT;
559edead8f builtin/stash--helper.c  993) struct index_state istate = { NULL };
1f5a011d90 builtin/stash--helper.c  995) remove_path(stash_index_path.buf);
1f5a011d90 builtin/stash--helper.c  997) cp_read_tree.git_cmd = 1;
1f5a011d90 builtin/stash--helper.c  998) argv_array_pushl(&cp_read_tree.args, "read-tree", "HEAD", NULL);
1f5a011d90 builtin/stash--helper.c  999) argv_array_pushf(&cp_read_tree.env_array, "GIT_INDEX_FILE=%s",
1f5a011d90 builtin/stash--helper.c 1001) if (run_command(&cp_read_tree)) {
1f5a011d90 builtin/stash--helper.c 1002) ret = -1;
1f5a011d90 builtin/stash--helper.c 1003) goto done;
1f5a011d90 builtin/stash--helper.c 1007) cp_add_i.git_cmd = 1;
1f5a011d90 builtin/stash--helper.c 1008) argv_array_pushl(&cp_add_i.args, "add--interactive", "--patch=stash",
1f5a011d90 builtin/stash--helper.c 1010) add_pathspecs(&cp_add_i.args, ps);
1f5a011d90 builtin/stash--helper.c 1011) argv_array_pushf(&cp_add_i.env_array, "GIT_INDEX_FILE=%s",
1f5a011d90 builtin/stash--helper.c 1013) if (run_command(&cp_add_i)) {
1f5a011d90 builtin/stash--helper.c 1014) ret = -1;
1f5a011d90 builtin/stash--helper.c 1015) goto done;
559edead8f builtin/stash--helper.c 1019) if (write_index_as_tree(&info->w_tree, &istate, stash_index_path.buf, 0,
1f5a011d90 builtin/stash--helper.c 1021) ret = -1;
1f5a011d90 builtin/stash--helper.c 1022) goto done;
1f5a011d90 builtin/stash--helper.c 1025) cp_diff_tree.git_cmd = 1;
1f5a011d90 builtin/stash--helper.c 1026) argv_array_pushl(&cp_diff_tree.args, "diff-tree", "-p", "HEAD",
1f5a011d90 builtin/stash--helper.c 1027)  oid_to_hex(&info->w_tree), "--", NULL);
1f5a011d90 builtin/stash--helper.c 1028) if (pipe_command(&cp_diff_tree, NULL, 0, out_patch, 0, NULL, 0)) {
1f5a011d90 builtin/stash--helper.c 1029) ret = -1;
1f5a011d90 builtin/stash--helper.c 1030) goto done;
1f5a011d90 builtin/stash--helper.c 1033) if (!out_patch->len) {
9a95010a11 builtin/stash--helper.c 1034) if (!quiet)
9a95010a11 builtin/stash--helper.c 1035) fprintf_ln(stderr, _("No changes selected"));
1f5a011d90 builtin/stash--helper.c 1036) ret = 1;
559edead8f builtin/stash--helper.c 1040) discard_index(&istate);
1f5a011d90 builtin/stash--helper.c 1041) remove_path(stash_index_path.buf);
1f5a011d90 builtin/stash--helper.c 1042) return ret;
1f5a011d90 builtin/stash--helper.c 1045) static int stash_working_tree(struct stash_info *info, struct pathspec ps)
1f5a011d90 builtin/stash--helper.c 1047) int ret = 0;
1f5a011d90 builtin/stash--helper.c 1049) struct child_process cp_upd_index = CHILD_PROCESS_INIT;
1f5a011d90 builtin/stash--helper.c 1050) struct strbuf diff_output = STRBUF_INIT;
559edead8f builtin/stash--helper.c 1051) struct index_state istate = { NULL };
ed5d77f7d3 builtin/stash.c         1053) init_revisions(&rev, NULL);
1f5a011d90 builtin/stash--helper.c 1055) set_alternate_index_output(stash_index_path.buf);
1f5a011d90 builtin/stash--helper.c 1056) if (reset_tree(&info->i_tree, 0, 0)) {
1f5a011d90 builtin/stash--helper.c 1057) ret = -1;
1f5a011d90 builtin/stash--helper.c 1058) goto done;
1f5a011d90 builtin/stash--helper.c 1060) set_alternate_index_output(NULL);
1f5a011d90 builtin/stash--helper.c 1062) rev.prune_data = ps;
1f5a011d90 builtin/stash--helper.c 1063) rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
1f5a011d90 builtin/stash--helper.c 1064) rev.diffopt.format_callback = add_diff_to_buf;
1f5a011d90 builtin/stash--helper.c 1065) rev.diffopt.format_callback_data = &diff_output;
1f5a011d90 builtin/stash--helper.c 1067) if (read_cache_preload(&rev.diffopt.pathspec) < 0) {
1f5a011d90 builtin/stash--helper.c 1068) ret = -1;
1f5a011d90 builtin/stash--helper.c 1069) goto done;
1f5a011d90 builtin/stash--helper.c 1072) add_pending_object(&rev, parse_object(the_repository, &info->b_commit),
1f5a011d90 builtin/stash--helper.c 1074) if (run_diff_index(&rev, 0)) {
1f5a011d90 builtin/stash--helper.c 1075) ret = -1;
1f5a011d90 builtin/stash--helper.c 1076) goto done;
1f5a011d90 builtin/stash--helper.c 1079) cp_upd_index.git_cmd = 1;
1f5a011d90 builtin/stash--helper.c 1080) argv_array_pushl(&cp_upd_index.args, "update-index", "-z", "--add",
1f5a011d90 builtin/stash--helper.c 1082) argv_array_pushf(&cp_upd_index.env_array, "GIT_INDEX_FILE=%s",
1f5a011d90 builtin/stash--helper.c 1085) if (pipe_command(&cp_upd_index, diff_output.buf, diff_output.len,
1f5a011d90 builtin/stash--helper.c 1087) ret = -1;
1f5a011d90 builtin/stash--helper.c 1088) goto done;
559edead8f builtin/stash--helper.c 1091) if (write_index_as_tree(&info->w_tree, &istate, stash_index_path.buf, 0,
1f5a011d90 builtin/stash--helper.c 1093) ret = -1;
1f5a011d90 builtin/stash--helper.c 1094) goto done;
559edead8f builtin/stash--helper.c 1098) discard_index(&istate);
1f5a011d90 builtin/stash--helper.c 1100) object_array_clear(&rev.pending);
1f5a011d90 builtin/stash--helper.c 1101) strbuf_release(&diff_output);
1f5a011d90 builtin/stash--helper.c 1102) remove_path(stash_index_path.buf);
1f5a011d90 builtin/stash--helper.c 1103) return ret;
1f5a011d90 builtin/stash--helper.c 1106) static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
1f5a011d90 builtin/stash--helper.c 1111) int ret = 0;
1f5a011d90 builtin/stash--helper.c 1112) int flags = 0;
1f5a011d90 builtin/stash--helper.c 1113) int untracked_commit_option = 0;
1f5a011d90 builtin/stash--helper.c 1114) const char *head_short_sha1 = NULL;
1f5a011d90 builtin/stash--helper.c 1115) const char *branch_ref = NULL;
1f5a011d90 builtin/stash--helper.c 1116) const char *branch_name = "(no branch)";
1f5a011d90 builtin/stash--helper.c 1117) struct commit *head_commit = NULL;
1f5a011d90 builtin/stash--helper.c 1118) struct commit_list *parents = NULL;
1f5a011d90 builtin/stash--helper.c 1119) struct strbuf msg = STRBUF_INIT;
1f5a011d90 builtin/stash--helper.c 1120) struct strbuf commit_tree_label = STRBUF_INIT;
1f5a011d90 builtin/stash--helper.c 1121) struct strbuf untracked_files = STRBUF_INIT;
1f5a011d90 builtin/stash--helper.c 1123) prepare_fallback_ident("git stash", "git@stash");
1f5a011d90 builtin/stash--helper.c 1125) read_cache_preload(NULL);
1f5a011d90 builtin/stash--helper.c 1126) refresh_cache(REFRESH_QUIET);
1f5a011d90 builtin/stash--helper.c 1128) if (get_oid("HEAD", &info->b_commit)) {
9a95010a11 builtin/stash--helper.c 1129) if (!quiet)
9a95010a11 builtin/stash--helper.c 1130) fprintf_ln(stderr, _("You do not have "
1f5a011d90 builtin/stash--helper.c 1132) ret = -1;
1f5a011d90 builtin/stash--helper.c 1133) goto done;
1f5a011d90 builtin/stash--helper.c 1135) head_commit = lookup_commit(the_repository, &info->b_commit);
168e6cff5e builtin/stash--helper.c 1138) if (!check_changes(ps, include_untracked, &untracked_files)) {
1f5a011d90 builtin/stash--helper.c 1139) ret = 1;
1f5a011d90 builtin/stash--helper.c 1140) goto done;
1f5a011d90 builtin/stash--helper.c 1143) branch_ref = resolve_ref_unsafe("HEAD", 0, NULL, &flags);
1f5a011d90 builtin/stash--helper.c 1144) if (flags & REF_ISSYMREF)
1f5a011d90 builtin/stash--helper.c 1145) branch_name = strrchr(branch_ref, '/') + 1;
1f5a011d90 builtin/stash--helper.c 1146) head_short_sha1 = find_unique_abbrev(&head_commit->object.oid,
1f5a011d90 builtin/stash--helper.c 1148) strbuf_addf(&msg, "%s: %s ", branch_name, head_short_sha1);
1f5a011d90 builtin/stash--helper.c 1149) pp_commit_easy(CMIT_FMT_ONELINE, head_commit, &msg);
1f5a011d90 builtin/stash--helper.c 1151) strbuf_addf(&commit_tree_label, "index on %s\n", msg.buf);
1f5a011d90 builtin/stash--helper.c 1152) commit_list_insert(head_commit, &parents);
1f5a011d90 builtin/stash--helper.c 1153) if (write_cache_as_tree(&info->i_tree, 0, NULL) ||
1f5a011d90 builtin/stash--helper.c 1154)     commit_tree(commit_tree_label.buf, commit_tree_label.len,
1f5a011d90 builtin/stash--helper.c 1155) &info->i_tree, parents, &info->i_commit, NULL, NULL)) {
9a95010a11 builtin/stash--helper.c 1156) if (!quiet)
9a95010a11 builtin/stash--helper.c 1157) fprintf_ln(stderr, _("Cannot save the current "
1f5a011d90 builtin/stash--helper.c 1159) ret = -1;
1f5a011d90 builtin/stash--helper.c 1160) goto done;
168e6cff5e builtin/stash--helper.c 1163) if (include_untracked) {
1f5a011d90 builtin/stash--helper.c 1164) if (save_untracked_files(info, &msg, untracked_files)) {
9a95010a11 builtin/stash--helper.c 1165) if (!quiet)
9a95010a11 builtin/stash--helper.c 1166) fprintf_ln(stderr, _("Cannot save "
1f5a011d90 builtin/stash--helper.c 1168) ret = -1;
1f5a011d90 builtin/stash--helper.c 1169) goto done;
1f5a011d90 builtin/stash--helper.c 1171) untracked_commit_option = 1;
1f5a011d90 builtin/stash--helper.c 1173) if (patch_mode) {
9a95010a11 builtin/stash--helper.c 1174) ret = stash_patch(info, ps, patch, quiet);
1f5a011d90 builtin/stash--helper.c 1175) if (ret < 0) {
9a95010a11 builtin/stash--helper.c 1176) if (!quiet)
9a95010a11 builtin/stash--helper.c 1177) fprintf_ln(stderr, _("Cannot save the current "
1f5a011d90 builtin/stash--helper.c 1179) goto done;
1f5a011d90 builtin/stash--helper.c 1180) } else if (ret > 0) {
1f5a011d90 builtin/stash--helper.c 1181) goto done;
1f5a011d90 builtin/stash--helper.c 1184) if (stash_working_tree(info, ps)) {
9a95010a11 builtin/stash--helper.c 1185) if (!quiet)
9a95010a11 builtin/stash--helper.c 1186) fprintf_ln(stderr, _("Cannot save the current "
1f5a011d90 builtin/stash--helper.c 1188) ret = -1;
1f5a011d90 builtin/stash--helper.c 1189) goto done;
1f5a011d90 builtin/stash--helper.c 1193) if (!stash_msg_buf->len)
1f5a011d90 builtin/stash--helper.c 1194) strbuf_addf(stash_msg_buf, "WIP on %s", msg.buf);
1f5a011d90 builtin/stash--helper.c 1196) strbuf_insertf(stash_msg_buf, 0, "On %s: ", branch_name);
1f5a011d90 builtin/stash--helper.c 1202) parents = NULL;
1f5a011d90 builtin/stash--helper.c 1203) if (untracked_commit_option)
1f5a011d90 builtin/stash--helper.c 1204) commit_list_insert(lookup_commit(the_repository,
1f5a011d90 builtin/stash--helper.c 1205)  &info->u_commit),
1f5a011d90 builtin/stash--helper.c 1207) commit_list_insert(lookup_commit(the_repository, &info->i_commit),
1f5a011d90 builtin/stash--helper.c 1209) commit_list_insert(head_commit, &parents);
1f5a011d90 builtin/stash--helper.c 1211) if (commit_tree(stash_msg_buf->buf, stash_msg_buf->len, &info->w_tree,
9a95010a11 builtin/stash--helper.c 1213) if (!quiet)
9a95010a11 builtin/stash--helper.c 1214) fprintf_ln(stderr, _("Cannot record "
1f5a011d90 builtin/stash--helper.c 1216) ret = -1;
1f5a011d90 builtin/stash--helper.c 1217) goto done;
1f5a011d90 builtin/stash--helper.c 1221) strbuf_release(&commit_tree_label);
1f5a011d90 builtin/stash--helper.c 1222) strbuf_release(&msg);
1f5a011d90 builtin/stash--helper.c 1223) strbuf_release(&untracked_files);
1f5a011d90 builtin/stash--helper.c 1224) return ret;
1f5a011d90 builtin/stash--helper.c 1227) static int create_stash(int argc, const char **argv, const char *prefix)
1f5a011d90 builtin/stash--helper.c 1229) int ret = 0;
1f5a011d90 builtin/stash--helper.c 1230) struct strbuf stash_msg_buf = STRBUF_INIT;
51809c70ca builtin/stash.c         1235) strbuf_join_argv(&stash_msg_buf, argc - 1, ++argv, ' ');
1f5a011d90 builtin/stash--helper.c 1237) memset(&ps, 0, sizeof(ps));
168e6cff5e builtin/stash--helper.c 1238) if (!check_changes_tracked_files(ps))
168e6cff5e builtin/stash--helper.c 1239) return 0;
168e6cff5e builtin/stash--helper.c 1241) if (!(ret = do_create_stash(ps, &stash_msg_buf, 0, 0, &info, NULL, 0)))
1f5a011d90 builtin/stash--helper.c 1242) printf_ln("%s", oid_to_hex(&info.w_commit));
1f5a011d90 builtin/stash--helper.c 1244) strbuf_release(&stash_msg_buf);
168e6cff5e builtin/stash--helper.c 1245) return ret;
fa38428f76 builtin/stash--helper.c 1248) static int do_push_stash(struct pathspec ps, const char *stash_msg, int quiet,
fa38428f76 builtin/stash--helper.c 1251) int ret = 0;
fa38428f76 builtin/stash--helper.c 1253) struct strbuf patch = STRBUF_INIT;
fa38428f76 builtin/stash--helper.c 1254) struct strbuf stash_msg_buf = STRBUF_INIT;
168e6cff5e builtin/stash--helper.c 1255) struct strbuf untracked_files = STRBUF_INIT;
fa38428f76 builtin/stash--helper.c 1257) if (patch_mode && keep_index == -1)
fa38428f76 builtin/stash--helper.c 1258) keep_index = 1;
fa38428f76 builtin/stash--helper.c 1260) if (patch_mode && include_untracked) {
fa38428f76 builtin/stash--helper.c 1261) fprintf_ln(stderr, _("Can't use --patch and --include-untracked"
fa38428f76 builtin/stash--helper.c 1263) ret = -1;
fa38428f76 builtin/stash--helper.c 1264) goto done;
fa38428f76 builtin/stash--helper.c 1267) read_cache_preload(NULL);
fa38428f76 builtin/stash--helper.c 1268) if (!include_untracked && ps.nr) {
fa38428f76 builtin/stash--helper.c 1270) char *ps_matched = xcalloc(ps.nr, 1);
fa38428f76 builtin/stash--helper.c 1272) for (i = 0; i < active_nr; i++)
fa38428f76 builtin/stash--helper.c 1273) ce_path_match(&the_index, active_cache[i], &ps,
fa38428f76 builtin/stash--helper.c 1276) if (report_path_error(ps_matched, &ps, NULL)) {
fa38428f76 builtin/stash--helper.c 1277) fprintf_ln(stderr, _("Did you forget to 'git add'?"));
fa38428f76 builtin/stash--helper.c 1278) ret = -1;
fa38428f76 builtin/stash--helper.c 1279) free(ps_matched);
fa38428f76 builtin/stash--helper.c 1280) goto done;
fa38428f76 builtin/stash--helper.c 1282) free(ps_matched);
fa38428f76 builtin/stash--helper.c 1285) if (refresh_cache(REFRESH_QUIET)) {
fa38428f76 builtin/stash--helper.c 1286) ret = -1;
fa38428f76 builtin/stash--helper.c 1287) goto done;
168e6cff5e builtin/stash--helper.c 1290) if (!check_changes(ps, include_untracked, &untracked_files)) {
fa38428f76 builtin/stash--helper.c 1291) if (!quiet)
fa38428f76 builtin/stash--helper.c 1292) printf_ln(_("No local changes to save"));
fa38428f76 builtin/stash--helper.c 1293) goto done;
fa38428f76 builtin/stash--helper.c 1296) if (!reflog_exists(ref_stash) && do_clear_stash()) {
fa38428f76 builtin/stash--helper.c 1297) ret = -1;
9a95010a11 builtin/stash--helper.c 1298) if (!quiet)
9a95010a11 builtin/stash--helper.c 1299) fprintf_ln(stderr, _("Cannot initialize stash"));
fa38428f76 builtin/stash--helper.c 1300) goto done;
fa38428f76 builtin/stash--helper.c 1303) if (stash_msg)
fa38428f76 builtin/stash--helper.c 1304) strbuf_addstr(&stash_msg_buf, stash_msg);
fa38428f76 builtin/stash--helper.c 1305) if (do_create_stash(ps, &stash_msg_buf, include_untracked, patch_mode,
fa38428f76 builtin/stash--helper.c 1307) ret = -1;
fa38428f76 builtin/stash--helper.c 1308) goto done;
fa38428f76 builtin/stash--helper.c 1311) if (do_store_stash(&info.w_commit, stash_msg_buf.buf, 1)) {
fa38428f76 builtin/stash--helper.c 1312) ret = -1;
9a95010a11 builtin/stash--helper.c 1313) if (!quiet)
9a95010a11 builtin/stash--helper.c 1314) fprintf_ln(stderr, _("Cannot save the current status"));
fa38428f76 builtin/stash--helper.c 1315) goto done;
9a95010a11 builtin/stash--helper.c 1318) if (!quiet)
9a95010a11 builtin/stash--helper.c 1319) printf_ln(_("Saved working directory and index state %s"),
fa38428f76 builtin/stash--helper.c 1322) if (!patch_mode) {
fa38428f76 builtin/stash--helper.c 1323) if (include_untracked && !ps.nr) {
fa38428f76 builtin/stash--helper.c 1324) struct child_process cp = CHILD_PROCESS_INIT;
fa38428f76 builtin/stash--helper.c 1326) cp.git_cmd = 1;
fa38428f76 builtin/stash--helper.c 1327) argv_array_pushl(&cp.args, "clean", "--force",
fa38428f76 builtin/stash--helper.c 1329) if (include_untracked == INCLUDE_ALL_FILES)
fa38428f76 builtin/stash--helper.c 1330) argv_array_push(&cp.args, "-x");
fa38428f76 builtin/stash--helper.c 1331) if (run_command(&cp)) {
fa38428f76 builtin/stash--helper.c 1332) ret = -1;
fa38428f76 builtin/stash--helper.c 1333) goto done;
fa38428f76 builtin/stash--helper.c 1336) if (ps.nr) {
fa38428f76 builtin/stash--helper.c 1337) struct child_process cp_add = CHILD_PROCESS_INIT;
fa38428f76 builtin/stash--helper.c 1338) struct child_process cp_diff = CHILD_PROCESS_INIT;
fa38428f76 builtin/stash--helper.c 1339) struct child_process cp_apply = CHILD_PROCESS_INIT;
fa38428f76 builtin/stash--helper.c 1340) struct strbuf out = STRBUF_INIT;
fa38428f76 builtin/stash--helper.c 1342) cp_add.git_cmd = 1;
fa38428f76 builtin/stash--helper.c 1343) argv_array_push(&cp_add.args, "add");
fa38428f76 builtin/stash--helper.c 1344) if (!include_untracked)
fa38428f76 builtin/stash--helper.c 1345) argv_array_push(&cp_add.args, "-u");
fa38428f76 builtin/stash--helper.c 1346) if (include_untracked == INCLUDE_ALL_FILES)
fa38428f76 builtin/stash--helper.c 1347) argv_array_push(&cp_add.args, "--force");
fa38428f76 builtin/stash--helper.c 1348) argv_array_push(&cp_add.args, "--");
fa38428f76 builtin/stash--helper.c 1349) add_pathspecs(&cp_add.args, ps);
fa38428f76 builtin/stash--helper.c 1350) if (run_command(&cp_add)) {
fa38428f76 builtin/stash--helper.c 1351) ret = -1;
fa38428f76 builtin/stash--helper.c 1352) goto done;
fa38428f76 builtin/stash--helper.c 1355) cp_diff.git_cmd = 1;
fa38428f76 builtin/stash--helper.c 1356) argv_array_pushl(&cp_diff.args, "diff-index", "-p",
fa38428f76 builtin/stash--helper.c 1359) add_pathspecs(&cp_diff.args, ps);
fa38428f76 builtin/stash--helper.c 1360) if (pipe_command(&cp_diff, NULL, 0, &out, 0, NULL, 0)) {
fa38428f76 builtin/stash--helper.c 1361) ret = -1;
fa38428f76 builtin/stash--helper.c 1362) goto done;
fa38428f76 builtin/stash--helper.c 1365) cp_apply.git_cmd = 1;
fa38428f76 builtin/stash--helper.c 1366) argv_array_pushl(&cp_apply.args, "apply", "--index",
fa38428f76 builtin/stash--helper.c 1368) if (pipe_command(&cp_apply, out.buf, out.len, NULL, 0,
fa38428f76 builtin/stash--helper.c 1370) ret = -1;
fa38428f76 builtin/stash--helper.c 1371) goto done;
fa38428f76 builtin/stash--helper.c 1374) struct child_process cp = CHILD_PROCESS_INIT;
fa38428f76 builtin/stash--helper.c 1375) cp.git_cmd = 1;
fa38428f76 builtin/stash--helper.c 1376) argv_array_pushl(&cp.args, "reset", "--hard", "-q",
fa38428f76 builtin/stash--helper.c 1378) if (run_command(&cp)) {
fa38428f76 builtin/stash--helper.c 1379) ret = -1;
fa38428f76 builtin/stash--helper.c 1380) goto done;
fa38428f76 builtin/stash--helper.c 1384) if (keep_index == 1 && !is_null_oid(&info.i_tree)) {
fa38428f76 builtin/stash--helper.c 1385) struct child_process cp_ls = CHILD_PROCESS_INIT;
fa38428f76 builtin/stash--helper.c 1386) struct child_process cp_checkout = CHILD_PROCESS_INIT;
fa38428f76 builtin/stash--helper.c 1387) struct strbuf out = STRBUF_INIT;
fa38428f76 builtin/stash--helper.c 1389) if (reset_tree(&info.i_tree, 0, 1)) {
fa38428f76 builtin/stash--helper.c 1390) ret = -1;
fa38428f76 builtin/stash--helper.c 1391) goto done;
fa38428f76 builtin/stash--helper.c 1394) cp_ls.git_cmd = 1;
fa38428f76 builtin/stash--helper.c 1395) argv_array_pushl(&cp_ls.args, "ls-files", "-z",
fa38428f76 builtin/stash--helper.c 1398) add_pathspecs(&cp_ls.args, ps);
fa38428f76 builtin/stash--helper.c 1399) if (pipe_command(&cp_ls, NULL, 0, &out, 0, NULL, 0)) {
fa38428f76 builtin/stash--helper.c 1400) ret = -1;
fa38428f76 builtin/stash--helper.c 1401) goto done;
fa38428f76 builtin/stash--helper.c 1404) cp_checkout.git_cmd = 1;
fa38428f76 builtin/stash--helper.c 1405) argv_array_pushl(&cp_checkout.args, "checkout-index",
fa38428f76 builtin/stash--helper.c 1407) if (pipe_command(&cp_checkout, out.buf, out.len, NULL,
fa38428f76 builtin/stash--helper.c 1409) ret = -1;
fa38428f76 builtin/stash--helper.c 1410) goto done;
fa38428f76 builtin/stash--helper.c 1413) goto done;
fa38428f76 builtin/stash--helper.c 1415) struct child_process cp = CHILD_PROCESS_INIT;
fa38428f76 builtin/stash--helper.c 1417) cp.git_cmd = 1;
fa38428f76 builtin/stash--helper.c 1418) argv_array_pushl(&cp.args, "apply", "-R", NULL);
fa38428f76 builtin/stash--helper.c 1420) if (pipe_command(&cp, patch.buf, patch.len, NULL, 0, NULL, 0)) {
9a95010a11 builtin/stash--helper.c 1421) if (!quiet)
9a95010a11 builtin/stash--helper.c 1422) fprintf_ln(stderr, _("Cannot remove "
fa38428f76 builtin/stash--helper.c 1424) ret = -1;
fa38428f76 builtin/stash--helper.c 1425) goto done;
fa38428f76 builtin/stash--helper.c 1428) if (keep_index < 1) {
fa38428f76 builtin/stash--helper.c 1429) struct child_process cp = CHILD_PROCESS_INIT;
fa38428f76 builtin/stash--helper.c 1431) cp.git_cmd = 1;
fa38428f76 builtin/stash--helper.c 1432) argv_array_pushl(&cp.args, "reset", "-q", "--", NULL);
fa38428f76 builtin/stash--helper.c 1433) add_pathspecs(&cp.args, ps);
fa38428f76 builtin/stash--helper.c 1434) if (run_command(&cp)) {
fa38428f76 builtin/stash--helper.c 1435) ret = -1;
fa38428f76 builtin/stash--helper.c 1436) goto done;
fa38428f76 builtin/stash--helper.c 1439) goto done;
fa38428f76 builtin/stash--helper.c 1443) strbuf_release(&stash_msg_buf);
fa38428f76 builtin/stash--helper.c 1444) return ret;
fa38428f76 builtin/stash--helper.c 1447) static int push_stash(int argc, const char **argv, const char *prefix)
fa38428f76 builtin/stash--helper.c 1449) int keep_index = -1;
fa38428f76 builtin/stash--helper.c 1450) int patch_mode = 0;
fa38428f76 builtin/stash--helper.c 1451) int include_untracked = 0;
fa38428f76 builtin/stash--helper.c 1452) int quiet = 0;
fa38428f76 builtin/stash--helper.c 1453) const char *stash_msg = NULL;
fa38428f76 builtin/stash--helper.c 1455) struct option options[] = {
51809c70ca builtin/stash.c         1470) if (argc)
51809c70ca builtin/stash.c         1471) argc = parse_options(argc, argv, prefix, options,
fa38428f76 builtin/stash--helper.c 1475) parse_pathspec(&ps, 0, PATHSPEC_PREFER_FULL, prefix, argv);
fa38428f76 builtin/stash--helper.c 1476) return do_push_stash(ps, stash_msg, quiet, keep_index, patch_mode,
cf5b27d699 builtin/stash--helper.c 1480) static int save_stash(int argc, const char **argv, const char *prefix)
cf5b27d699 builtin/stash--helper.c 1482) int keep_index = -1;
cf5b27d699 builtin/stash--helper.c 1483) int patch_mode = 0;
cf5b27d699 builtin/stash--helper.c 1484) int include_untracked = 0;
cf5b27d699 builtin/stash--helper.c 1485) int quiet = 0;
cf5b27d699 builtin/stash--helper.c 1486) int ret = 0;
cf5b27d699 builtin/stash--helper.c 1487) const char *stash_msg = NULL;
cf5b27d699 builtin/stash--helper.c 1489) struct strbuf stash_msg_buf = STRBUF_INIT;
cf5b27d699 builtin/stash--helper.c 1490) struct option options[] = {
cf5b27d699 builtin/stash--helper.c 1505) argc = parse_options(argc, argv, prefix, options,
cf5b27d699 builtin/stash--helper.c 1509) if (argc)
cf5b27d699 builtin/stash--helper.c 1510) stash_msg = strbuf_join_argv(&stash_msg_buf, argc, argv, ' ');
cf5b27d699 builtin/stash--helper.c 1512) memset(&ps, 0, sizeof(ps));
cf5b27d699 builtin/stash--helper.c 1513) ret = do_push_stash(ps, stash_msg, quiet, keep_index,
cf5b27d699 builtin/stash--helper.c 1516) strbuf_release(&stash_msg_buf);
cf5b27d699 builtin/stash--helper.c 1517) return ret;
bec65d5b78 builtin/stash.c         1527) return env;
26799a208f builtin/stash.c         1537) strbuf_trim(&out);
26799a208f builtin/stash.c         1538) ret = !strcmp("true", out.buf);
26799a208f builtin/stash.c         1539) strbuf_release(&out);
26799a208f builtin/stash.c         1555) const char *path = mkpath("%s/git-legacy-stash",
26799a208f builtin/stash.c         1558) if (sane_execvp(path, (char **)argv) < 0)
26799a208f builtin/stash.c         1559) die_errno(_("could not exec %s"), path);
f6bbd78127 builtin/stash--helper.c 1573) index_file = get_index_file();
f6bbd78127 builtin/stash--helper.c 1574) strbuf_addf(&stash_index_path, "%s.stash.%" PRIuMAX, index_file,
51809c70ca builtin/stash.c         1577) if (!argc)
51809c70ca builtin/stash.c         1578) return !!push_stash(0, NULL, prefix);
51809c70ca builtin/stash.c         1579) else if (!strcmp(argv[0], "apply"))
f6bbd78127 builtin/stash--helper.c 1580) return !!apply_stash(argc, argv, prefix);
cdca49bc4c builtin/stash--helper.c 1581) else if (!strcmp(argv[0], "clear"))
cdca49bc4c builtin/stash--helper.c 1582) return !!clear_stash(argc, argv, prefix);
cdca49bc4c builtin/stash--helper.c 1583) else if (!strcmp(argv[0], "drop"))
cdca49bc4c builtin/stash--helper.c 1584) return !!drop_stash(argc, argv, prefix);
e1d01876a4 builtin/stash--helper.c 1585) else if (!strcmp(argv[0], "pop"))
e1d01876a4 builtin/stash--helper.c 1586) return !!pop_stash(argc, argv, prefix);
f596f3366c builtin/stash--helper.c 1587) else if (!strcmp(argv[0], "branch"))
f596f3366c builtin/stash--helper.c 1588) return !!branch_stash(argc, argv, prefix);
9b77b07ba4 builtin/stash--helper.c 1589) else if (!strcmp(argv[0], "list"))
9b77b07ba4 builtin/stash--helper.c 1590) return !!list_stash(argc, argv, prefix);
b4493f269e builtin/stash--helper.c 1591) else if (!strcmp(argv[0], "show"))
b4493f269e builtin/stash--helper.c 1592) return !!show_stash(argc, argv, prefix);
847eb0b0a8 builtin/stash--helper.c 1593) else if (!strcmp(argv[0], "store"))
847eb0b0a8 builtin/stash--helper.c 1594) return !!store_stash(argc, argv, prefix);
1f5a011d90 builtin/stash--helper.c 1595) else if (!strcmp(argv[0], "create"))
1f5a011d90 builtin/stash--helper.c 1596) return !!create_stash(argc, argv, prefix);
fa38428f76 builtin/stash--helper.c 1597) else if (!strcmp(argv[0], "push"))
fa38428f76 builtin/stash--helper.c 1598) return !!push_stash(argc, argv, prefix);
cf5b27d699 builtin/stash--helper.c 1599) else if (!strcmp(argv[0], "save"))
cf5b27d699 builtin/stash--helper.c 1600) return !!save_stash(argc, argv, prefix);
51809c70ca builtin/stash.c         1601) else if (*argv[0] != '-')
51809c70ca builtin/stash.c         1602) usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
51809c70ca builtin/stash.c         1605) if (strcmp(argv[0], "-p")) {
51809c70ca builtin/stash.c         1606) while (++i < argc && strcmp(argv[i], "--")) {
51809c70ca builtin/stash.c         1611) if ((strlen(argv[i]) == 2) && *argv[i] == '-' &&
51809c70ca builtin/stash.c         1612)     strchr("akpqu", argv[i][1]))
51809c70ca builtin/stash.c         1613) continue;
51809c70ca builtin/stash.c         1615) if (!strcmp(argv[i], "--all") ||
51809c70ca builtin/stash.c         1616)     !strcmp(argv[i], "--keep-index") ||
51809c70ca builtin/stash.c         1617)     !strcmp(argv[i], "--no-keep-index") ||
51809c70ca builtin/stash.c         1618)     !strcmp(argv[i], "--patch") ||
51809c70ca builtin/stash.c         1619)     !strcmp(argv[i], "--quiet") ||
51809c70ca builtin/stash.c         1620)     !strcmp(argv[i], "--include-untracked"))
51809c70ca builtin/stash.c         1621) continue;
51809c70ca builtin/stash.c         1628) if (starts_with(argv[i], "-m") ||
51809c70ca builtin/stash.c         1629)     starts_with(argv[i], "--message="))
51809c70ca builtin/stash.c         1630) continue;
51809c70ca builtin/stash.c         1632) usage_with_options(git_stash_usage, options);
51809c70ca builtin/stash.c         1636) argv_array_push(&args, "push");
51809c70ca builtin/stash.c         1637) argv_array_pushv(&args, argv);
51809c70ca builtin/stash.c         1638) return !!push_stash(args.argc, args.argv, prefix);

builtin/update-index.c
08339886b9 builtin/update-index.c  895) static enum parse_opt_result stdin_callback(
9b4ae5190a builtin/update-index.c  902) BUG_ON_OPT_ARG(arg);
08339886b9 builtin/update-index.c  910) static enum parse_opt_result unresolve_callback(
9b4ae5190a builtin/update-index.c  918) BUG_ON_OPT_ARG(arg);
08339886b9 builtin/update-index.c  931) static enum parse_opt_result reupdate_callback(
9b4ae5190a builtin/update-index.c  939) BUG_ON_OPT_ARG(arg);

builtin/upload-archive.c
6da1f1a920 builtin/upload-archive.c  86) register_allowed_protocol_version(protocol_v0);

commit-graph.c
97b202471c  885) for_each_object_in_pack(p, add_packed_commits, &oids,
97b202471c  932) for_each_packed_object(add_packed_commits, &oids,

config.c
06800238c6 1684) worktree_config = mkpathdup("%s/config.worktree", opts->git_dir);
06800238c6 1709) ret += git_config_from_file(fn, worktree_config, data);
8f7c7f5555 2147) int repo_config_set_gently(struct repository *r,
8f7c7f5555 2150) char *path = repo_git_path(r, "config");
8f7c7f5555 2151) int ret = git_config_set_multivar_in_file_gently(path, key, value, NULL, 0);
8f7c7f5555 2152) free(path);
8f7c7f5555 2153) return ret;
8f7c7f5555 2156) void repo_config_set(struct repository *r, const char *key, const char *value)
8f7c7f5555 2158) if (!repo_config_set_gently(r, key, value))
8f7c7f5555 2159) return;
8f7c7f5555 2160) if (value)
8f7c7f5555 2161) die(_("could not set '%s' to '%s'"), key, value);
8f7c7f5555 2163) die(_("could not unset '%s'"), key);
8f7c7f5555 2166) int repo_config_set_worktree_gently(struct repository *r,
8f7c7f5555 2172) path = get_worktree_config(r);
8f7c7f5555 2173) if (!path)
8f7c7f5555 2174) return CONFIG_INVALID_FILE;
8f7c7f5555 2175) ret = git_config_set_multivar_in_file_gently(path, key, value, NULL, 0);
8f7c7f5555 2176) free(path);
8f7c7f5555 2177) return ret;

connect.c
6da1f1a920 1085) strbuf_addch(&request, '\0');
6da1f1a920 1086) strbuf_addf(&request, "%s%c", version_advert->buf, '\0');
6da1f1a920 1103) if (variant == VARIANT_SSH) {
6da1f1a920 1106) argv_array_pushf(env, GIT_PROTOCOL_ENVIRONMENT "=%s",
6da1f1a920 1194) push_ssh_options(&detect.args, &detect.env_array, VARIANT_SSH,
6da1f1a920 1202) push_ssh_options(&conn->args, &conn->env_array, variant, port,
6da1f1a920 1241) conn = git_connect_git(fd, hostandport, path, prog,
6da1f1a920 1285) fill_ssh_args(conn, ssh_host, port, &version_advert,

date.c
acdd37769d  113) die("Timestamp too large for this system: %"PRItime, time);
6943bd42fb  137) gettimeofday(now, NULL);
acdd37769d  245) hide.date = 1;
acdd37769d  926) return DATE_HUMAN;
86177eb5c4  943) if (isatty(1) || pager_in_use())
86177eb5c4  944) format = p;
86177eb5c4  946) format = "default";

diff-no-index.c
963389f6e7 268) if (implicit_no_index)
963389f6e7 269) warning(_("Not a git repository. Use --no-index to "
963389f6e7 271) usage_with_options(diff_no_index_usage, options);
963389f6e7 305) return 1;

diff.c
0eb03c4cd0 4745) width = strtoul(value, &end, 10);
0eb03c4cd0 4746) if (*end == ',')
0eb03c4cd0 4747) name_width = strtoul(end+1, &end, 10);
0eb03c4cd0 4748) if (*end == ',')
0eb03c4cd0 4749) count = strtoul(end+1, &end, 10);
0eb03c4cd0 4750) if (*end)
0eb03c4cd0 4751) return error(_("invalid --stat value: %s"), value);
0eb03c4cd0 4753) } else if (!strcmp(opt->long_name, "stat-width")) {
0eb03c4cd0 4754) width = strtoul(value, &end, 10);
0eb03c4cd0 4755) if (*end)
0eb03c4cd0 4756) return error(_("%s expects a numerical value"),
0eb03c4cd0 4758) } else if (!strcmp(opt->long_name, "stat-name-width")) {
0eb03c4cd0 4759) name_width = strtoul(value, &end, 10);
0eb03c4cd0 4760) if (*end)
0eb03c4cd0 4761) return error(_("%s expects a numerical value"),
0eb03c4cd0 4763) } else if (!strcmp(opt->long_name, "stat-graph-width")) {
0eb03c4cd0 4764) graph_width = strtoul(value, &end, 10);
0eb03c4cd0 4765) if (*end)
0eb03c4cd0 4766) return error(_("%s expects a numerical value"),
0eb03c4cd0 4768) } else if (!strcmp(opt->long_name, "stat-count")) {
0eb03c4cd0 4769) count = strtoul(value, &end, 10);
0eb03c4cd0 4770) if (*end)
0eb03c4cd0 4771) return error(_("%s expects a numerical value"),
b74a81799d 4836) static int diff_opt_diff_filter(const struct option *option,
b74a81799d 4839) struct diff_options *opt = option->value;
b74a81799d 4842) BUG_ON_OPT_NEG(unset);
b74a81799d 4873) return error(_("unknown change class '%c' in --diff-filter=%s"),
8b70e41773 4889) static int diff_opt_ws_error_highlight(const struct option *option,
8b70e41773 4892) struct diff_options *opt = option->value;
8b70e41773 4895) BUG_ON_OPT_NEG(unset);
8b70e41773 4896) if (val < 0)
8b70e41773 4897) return error("unknown value after ws-error-highlight=%.*s",
8b70e41773 4900) return 0;
5866e9ce9a 4903) static int diff_opt_find_object(const struct option *option,
5866e9ce9a 4906) struct diff_options *opt = option->value;
5866e9ce9a 4909) BUG_ON_OPT_NEG(unset);
5866e9ce9a 4911) return error(_("unable to resolve '%s'"), arg);
5866e9ce9a 4920) return 0;
b065b66077 4923) static int diff_opt_anchored(const struct option *opt,
b065b66077 4926) struct diff_options *options = opt->value;
b065b66077 4928) BUG_ON_OPT_NEG(unset);
b065b66077 4929) options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
b065b66077 4930) ALLOC_GROW(options->anchors, options->anchors_nr + 1,
b065b66077 4932) options->anchors[options->anchors_nr++] = xstrdup(arg);
b065b66077 4933) return 0;
6d0300b2e3 4936) static int diff_opt_binary(const struct option *opt,
6d0300b2e3 4939) struct diff_options *options = opt->value;
6d0300b2e3 4941) BUG_ON_OPT_NEG(unset);
6d0300b2e3 4942) BUG_ON_OPT_ARG(arg);
6d0300b2e3 4943) enable_patch_output(&options->output_format);
6d0300b2e3 4944) options->flags.binary = 1;
6d0300b2e3 4945) return 0;
b9b760ed1c 4948) static int diff_opt_break_rewrites(const struct option *opt,
b9b760ed1c 4951) int *break_opt = opt->value;
b9b760ed1c 4954) BUG_ON_OPT_NEG(unset);
b9b760ed1c 4955) if (!arg)
b9b760ed1c 4956) arg = "";
b9b760ed1c 4957) opt1 = parse_rename_score(&arg);
b9b760ed1c 4958) switch (*arg) {
b9b760ed1c 4960) opt2 = 0;
b9b760ed1c 4961) break;
b9b760ed1c 4963) arg++;
b9b760ed1c 4964) opt2 = parse_rename_score(&arg);
b9b760ed1c 4965) break;
b9b760ed1c 4967) if (*arg != 0)
b9b760ed1c 4968) return error(_("%s expects <n>/<m> form"), opt->long_name);
b9b760ed1c 4969) *break_opt = opt1 | (opt2 << 16);
b9b760ed1c 4970) return 0;
3d810d1860 4973) static int diff_opt_char(const struct option *opt,
3d810d1860 4976) char *value = opt->value;
3d810d1860 4978) BUG_ON_OPT_NEG(unset);
3d810d1860 4979) if (arg[1])
3d810d1860 4980) return error(_("%s expects a character, got '%s'"),
3d810d1860 4982) *value = arg[0];
3d810d1860 4983) return 0;
221d676696 4986) static int diff_opt_color_moved(const struct option *opt,
221d676696 4989) struct diff_options *options = opt->value;
221d676696 4991) if (unset) {
221d676696 4992) options->color_moved = COLOR_MOVED_NO;
221d676696 4993) } else if (!arg) {
221d676696 5004) return 0;
7c33a67a2e 5007) static int diff_opt_color_moved_ws(const struct option *opt,
7c33a67a2e 5010) struct diff_options *options = opt->value;
da9db54b3e 5013) if (unset) {
da9db54b3e 5015) return 0;
7c33a67a2e 5018) cm = parse_color_moved_ws(arg);
7c33a67a2e 5019) if (cm & COLOR_MOVED_WS_ERROR)
7c33a67a2e 5020) return error(_("invalid mode '%s' in --color-moved-ws"), arg);
7c33a67a2e 5021) options->color_moved_ws_handling = cm;
7c33a67a2e 5022) return 0;
f3b49b7f9e 5025) static int diff_opt_color_words(const struct option *opt,
f3b49b7f9e 5028) struct diff_options *options = opt->value;
f3b49b7f9e 5030) BUG_ON_OPT_NEG(unset);
f3b49b7f9e 5031) options->use_color = 1;
f3b49b7f9e 5032) options->word_diff = DIFF_WORDS_COLOR;
f3b49b7f9e 5033) options->word_regex = arg;
f3b49b7f9e 5034) return 0;
58c7ef398e 5037) static int diff_opt_compact_summary(const struct option *opt,
58c7ef398e 5040) struct diff_options *options = opt->value;
58c7ef398e 5042) BUG_ON_OPT_ARG(arg);
58c7ef398e 5043) if (unset) {
58c7ef398e 5044) options->flags.stat_with_summary = 0;
58c7ef398e 5046) options->flags.stat_with_summary = 1;
58c7ef398e 5047) options->output_format |= DIFF_FORMAT_DIFFSTAT;
58c7ef398e 5049) return 0;
1efc2689d6 5052) static int diff_opt_diff_algorithm(const struct option *opt,
1efc2689d6 5055) struct diff_options *options = opt->value;
1efc2689d6 5056) long value = parse_algorithm_value(arg);
1efc2689d6 5058) BUG_ON_OPT_NEG(unset);
1efc2689d6 5059) if (value < 0)
1efc2689d6 5060) return error(_("option diff-algorithm accepts \"myers\", "
1efc2689d6 5064) DIFF_XDL_CLR(options, NEED_MINIMAL);
1efc2689d6 5065) options->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
1efc2689d6 5066) options->xdl_opts |= value;
1efc2689d6 5067) return 0;
f8d10810d3 5070) static int diff_opt_dirstat(const struct option *opt,
f8d10810d3 5073) struct diff_options *options = opt->value;
f8d10810d3 5075) BUG_ON_OPT_NEG(unset);
f8d10810d3 5076) if (!strcmp(opt->long_name, "cumulative")) {
f8d10810d3 5077) if (arg)
f8d10810d3 5079) arg = "cumulative";
f8d10810d3 5080) } else if (!strcmp(opt->long_name, "dirstat-by-file"))
f8d10810d3 5081) parse_dirstat_opt(options, "files");
f8d10810d3 5082) parse_dirstat_opt(options, arg ? arg : "");
f8d10810d3 5083) return 0;
97e53999cd 5086) static int diff_opt_find_copies(const struct option *opt,
97e53999cd 5089) struct diff_options *options = opt->value;
97e53999cd 5091) BUG_ON_OPT_NEG(unset);
97e53999cd 5092) if (!arg)
97e53999cd 5093) arg = "";
97e53999cd 5094) options->rename_score = parse_rename_score(&arg);
97e53999cd 5095) if (*arg != 0)
97e53999cd 5096) return error(_("invalid argument to %s"), opt->long_name);
97e53999cd 5098) if (options->detect_rename == DIFF_DETECT_COPY)
97e53999cd 5099) options->flags.find_copies_harder = 1;
97e53999cd 5101) options->detect_rename = DIFF_DETECT_COPY;
97e53999cd 5103) return 0;
10e07ecc0c 5116) return error(_("invalid argument to %s"), opt->long_name);
c2dcec4fd2 5122) static int diff_opt_follow(const struct option *opt,
c2dcec4fd2 5125) struct diff_options *options = opt->value;
c2dcec4fd2 5127) BUG_ON_OPT_ARG(arg);
c2dcec4fd2 5128) if (unset) {
c2dcec4fd2 5129) options->flags.follow_renames = 0;
c2dcec4fd2 5130) options->flags.default_follow_renames = 0;
c2dcec4fd2 5132) options->flags.follow_renames = 1;
c2dcec4fd2 5134) return 0;
6c0ec4f728 5150) static int diff_opt_line_prefix(const struct option *opt,
6c0ec4f728 5153) struct diff_options *options = opt->value;
6c0ec4f728 5155) BUG_ON_OPT_NEG(unset);
6c0ec4f728 5156) options->line_prefix = optarg;
6c0ec4f728 5157) options->line_prefix_length = strlen(options->line_prefix);
6c0ec4f728 5158) graph_setup_line_prefix(options);
6c0ec4f728 5159) return 0;
059343267e 5162) static int diff_opt_no_prefix(const struct option *opt,
059343267e 5165) struct diff_options *options = opt->value;
059343267e 5167) BUG_ON_OPT_NEG(unset);
059343267e 5168) BUG_ON_OPT_ARG(optarg);
059343267e 5169) options->a_prefix = "";
059343267e 5170) options->b_prefix = "";
059343267e 5171) return 0;
3d810d1860 5174) static enum parse_opt_result diff_opt_output(struct parse_opt_ctx_t *ctx,
3d810d1860 5178) struct diff_options *options = opt->value;
3d810d1860 5181) BUG_ON_OPT_NEG(unset);
3d810d1860 5182) path = prefix_filename(ctx->prefix, arg);
3d810d1860 5183) options->file = xfopen(path, "w");
3d810d1860 5184) options->close_file = 1;
3d810d1860 5185) if (options->use_color != GIT_COLOR_ALWAYS)
3d810d1860 5186) options->use_color = GIT_COLOR_NEVER;
3d810d1860 5187) free(path);
3d810d1860 5188) return 0;
2156b1fd0c 5191) static int diff_opt_patience(const struct option *opt,
2156b1fd0c 5194) struct diff_options *options = opt->value;
2156b1fd0c 5197) BUG_ON_OPT_NEG(unset);
2156b1fd0c 5198) BUG_ON_OPT_ARG(arg);
2156b1fd0c 5199) options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
2156b1fd0c 5205) for (i = 0; i < options->anchors_nr; i++)
2156b1fd0c 5206) free(options->anchors[i]);
2156b1fd0c 5207) options->anchors_nr = 0;
2156b1fd0c 5208) return 0;
d071ebcc8a 5211) static int diff_opt_pickaxe_regex(const struct option *opt,
d071ebcc8a 5214) struct diff_options *options = opt->value;
d071ebcc8a 5216) BUG_ON_OPT_NEG(unset);
d071ebcc8a 5217) options->pickaxe = arg;
d071ebcc8a 5218) options->pickaxe_opts |= DIFF_PICKAXE_KIND_G;
d071ebcc8a 5219) return 0;
d071ebcc8a 5222) static int diff_opt_pickaxe_string(const struct option *opt,
d071ebcc8a 5225) struct diff_options *options = opt->value;
d071ebcc8a 5227) BUG_ON_OPT_NEG(unset);
d071ebcc8a 5228) options->pickaxe = arg;
d071ebcc8a 5229) options->pickaxe_opts |= DIFF_PICKAXE_KIND_S;
d071ebcc8a 5230) return 0;
350a71f2fc 5233) static int diff_opt_relative(const struct option *opt,
350a71f2fc 5236) struct diff_options *options = opt->value;
350a71f2fc 5238) BUG_ON_OPT_NEG(unset);
350a71f2fc 5239) options->flags.relative_name = 1;
350a71f2fc 5240) if (arg)
350a71f2fc 5241) options->prefix = arg;
350a71f2fc 5242) return 0;
1d2890f4f5 5245) static int diff_opt_submodule(const struct option *opt,
1d2890f4f5 5248) struct diff_options *options = opt->value;
1d2890f4f5 5250) BUG_ON_OPT_NEG(unset);
1d2890f4f5 5251) if (!arg)
1d2890f4f5 5252) arg = "log";
1d2890f4f5 5253) if (parse_submodule_params(options, arg))
1d2890f4f5 5254) return error(_("failed to parse --submodule option parameter: '%s'"),
1d2890f4f5 5256) return 0;
1d85988346 5259) static int diff_opt_textconv(const struct option *opt,
1d85988346 5262) struct diff_options *options = opt->value;
1d85988346 5264) BUG_ON_OPT_ARG(arg);
1d85988346 5265) if (unset) {
1d85988346 5266) options->flags.allow_textconv = 0;
1d85988346 5268) options->flags.allow_textconv = 1;
1d85988346 5269) options->flags.textconv_set_via_cmdline = 1;
1d85988346 5271) return 0;
6643eb7bbf 5284) return error(_("%s expects a numerical value"), "--unified");
08d080bf7f 5290) static int diff_opt_word_diff(const struct option *opt,
08d080bf7f 5293) struct diff_options *options = opt->value;
08d080bf7f 5295) BUG_ON_OPT_NEG(unset);
08d080bf7f 5296) if (arg) {
08d080bf7f 5308) return error(_("bad --word-diff argument: %s"), arg);
08d080bf7f 5313) return 0;
afe77a4dd9 5316) static int diff_opt_word_diff_regex(const struct option *opt,
afe77a4dd9 5319) struct diff_options *options = opt->value;
afe77a4dd9 5321) BUG_ON_OPT_NEG(unset);
afe77a4dd9 5322) if (options->word_diff == DIFF_WORDS_NONE)
afe77a4dd9 5323) options->word_diff = DIFF_WORDS_PLAIN;
afe77a4dd9 5324) options->word_regex = arg;
afe77a4dd9 5325) return 0;

fsck.c
ef644c4150  252) oidset_parse_file(&options->skiplist, buf + equal + 1);

ident.c
97f56073ce 568) static void set_env_if(const char *key, const char *value, int *given, int bit)
97f56073ce 570) if ((*given & bit) || getenv(key))
97f56073ce 571) return; /* nothing to do */
97f56073ce 572) setenv(key, value, 0);
97f56073ce 573) *given |= bit;
97f56073ce 576) void prepare_fallback_ident(const char *name, const char *email)
97f56073ce 578) set_env_if("GIT_AUTHOR_NAME", name,
97f56073ce 580) set_env_if("GIT_AUTHOR_EMAIL", email,
97f56073ce 582) set_env_if("GIT_COMMITTER_NAME", name,
97f56073ce 584) set_env_if("GIT_COMMITTER_EMAIL", email,
97f56073ce 586) }

list-objects-filter-options.c
3a7a698e93  74) if (!get_oid_with_context(the_repository, v0, GET_OID_BLOB,

list-objects.c
4f6d26b167 229) static void add_edge_parents(struct commit *commit,
4f6d26b167 236) for (parents = commit->parents; parents; parents = parents->next) {
4f6d26b167 237) struct commit *parent = parents->item;
4f6d26b167 238) struct tree *tree = get_commit_tree(parent);
4f6d26b167 240) if (!tree)
4f6d26b167 241) continue;
4f6d26b167 243) oidset_insert(set, &tree->object.oid);
4f6d26b167 245) if (!(parent->object.flags & UNINTERESTING))
4f6d26b167 246) continue;
4f6d26b167 247) tree->object.flags |= UNINTERESTING;
4f6d26b167 249) if (revs->edge_hint && !(parent->object.flags & SHOWN)) {
4f6d26b167 250) parent->object.flags |= SHOWN;
4f6d26b167 251) show_edge(parent);
4f6d26b167 254) }
4f6d26b167 265) oidset_init(&set, 16);
4f6d26b167 267) for (list = revs->commits; list; list = list->next) {
4f6d26b167 268) struct commit *commit = list->item;
4f6d26b167 269) struct tree *tree = get_commit_tree(commit);
4f6d26b167 271) if (commit->object.flags & UNINTERESTING)
4f6d26b167 272) tree->object.flags |= UNINTERESTING;
4f6d26b167 274) oidset_insert(&set, &tree->object.oid);
4f6d26b167 275) add_edge_parents(commit, revs, show_edge, &set);
4f6d26b167 278) mark_trees_uninteresting_sparse(revs->repo, &set);
4f6d26b167 279) oidset_clear(&set);
4f6d26b167 287) commit->object.flags |= SHOWN;
4f6d26b167 288) show_edge(commit);

merge-recursive.c
d7cf3a96e9  149) static struct tree *shift_tree_object(struct repository *repo,
d7cf3a96e9  163) return lookup_tree(repo, &shifted);
0d6caa2d08  428) struct index_state *istate = o->repo->index;
0d6caa2d08  430) if (unmerged_index(istate)) {
0d6caa2d08  433) for (i = 0; i < istate->cache_nr; i++) {
0d6caa2d08  434) const struct cache_entry *ce = istate->cache[i];
0d6caa2d08  442) if (!istate->cache_tree)
0d6caa2d08  443) istate->cache_tree = cache_tree();
0d6caa2d08  445) if (!cache_tree_fully_valid(istate->cache_tree) &&
0d6caa2d08  446)     cache_tree_update(istate, 0) < 0) {
d7cf3a96e9  451) result = lookup_tree(o->repo, &istate->cache_tree->oid);
0d6caa2d08  733) ce = index_file_exists(o->repo->index, path, strlen(path),
0d6caa2d08 1116) static int find_first_merges(struct repository *repo,
0d6caa2d08 1137) repo_init_revisions(repo, &revs, NULL);
d7cf3a96e9 1215) if (!(commit_base = lookup_commit_reference(o->repo, base)) ||
d7cf3a96e9 1216)     !(commit_a = lookup_commit_reference(o->repo, a)) ||
d7cf3a96e9 1217)     !(commit_b = lookup_commit_reference(o->repo, b))) {
0d6caa2d08 1267) parent_count = find_first_merges(o->repo, &merges, path,
0d6caa2d08 1416) if (!o->call_depth && would_lose_untracked(o, dest->path)) {
0d6caa2d08 1455)     (!o->call_depth && would_lose_untracked(o, path))) {
0d6caa2d08 1465) ret = remove_file_from_index(o->repo->index, path);
0d6caa2d08 1541) return remove_file_from_index(o->repo->index, dest->path);
0d6caa2d08 1622)     o->call_depth || would_lose_untracked(o, prev_path1));
0d6caa2d08 1625)     o->call_depth || would_lose_untracked(o, prev_path2));
0d6caa2d08 1732) if (dir_in_way(o->repo->index, path, !o->call_depth, 0)) {
0d6caa2d08 1737) } else if (would_lose_untracked(o, path)) {
0d6caa2d08 1798) remove_file_from_index(o->repo->index, a->path);
0d6caa2d08 1805) remove_file_from_index(o->repo->index, b->path);
0d6caa2d08 3057) if (renormalize_buffer(opt->repo->index, path, o.buf, o.len, &o) |
0d6caa2d08 3058)     renormalize_buffer(opt->repo->index, path, a.buf, a.len, &a))
0d6caa2d08 3139) if (dir_in_way(o->repo->index, path, !o->call_depth,
0d6caa2d08 3173) pos = index_name_pos(o->repo->index, path, strlen(path));
0d6caa2d08 3174) ce = o->repo->index->cache[pos];
0d6caa2d08 3193) remove_file_from_index(o->repo->index, path);
0d6caa2d08 3364) remove_file_from_index(o->repo->index, path);
d7cf3a96e9 3423) merge = shift_tree_object(o->repo, head, merge, o->subtree_shift);
d7cf3a96e9 3424) common = shift_tree_object(o->repo, head, common, o->subtree_shift);
d7cf3a96e9 3560) tree = lookup_tree(o->repo, o->repo->hash_algo->empty_tree);
d7cf3a96e9 3561) merged_common_ancestors = make_virtual_commit(o->repo, tree, "ancestor");
0d6caa2d08 3575) discard_index(o->repo->index);
d7cf3a96e9 3605) *result = make_virtual_commit(o->repo, mrtree, "merged tree");

merge.c
e1ff0a32e4  40) if (repo_read_index(r) < 0)

notes-merge.c
1d18d7581c 652) create_notes_commit(o->repo, local_tree, parents, o->commit_msg.buf,
1d18d7581c 727) create_notes_commit(o->repo, partial_tree, partial_commit->parents, msg,

notes-utils.c
1d18d7581c   8) void create_notes_commit(struct repository *r,
1d18d7581c  25) struct commit *parent = lookup_commit(r, &parent_oid);
1d18d7581c  38) void commit_notes(struct repository *r, struct notes_tree *t, const char *msg)
1d18d7581c  54) create_notes_commit(r, t, NULL, buf.buf, buf.len, &commit_oid);
1d18d7581c 175) void finish_copy_notes_for_rewrite(struct repository *r,
1d18d7581c 181) commit_notes(r, c->trees[i], msg);

oidset.c
ef644c4150 39) void oidset_parse_file(struct oidset *set, const char *path)
ef644c4150 42) struct strbuf sb = STRBUF_INIT;
ef644c4150 45) fp = fopen(path, "r");
ef644c4150 46) if (!fp)
ef644c4150 47) die("Could not open skip list: %s", path);
ef644c4150 48) while (!strbuf_getline(&sb, fp)) {
ef644c4150 57) hash = strchr(sb.buf, '#');
ef644c4150 58) if (hash)
ef644c4150 59) strbuf_setlen(&sb, hash - sb.buf);
ef644c4150 60) strbuf_trim(&sb);
ef644c4150 61) if (!sb.len)
ef644c4150 62) continue;
ef644c4150 64) if (parse_oid_hex(sb.buf, &oid, &p) || *p != '\0')
ef644c4150 65) die("Invalid SHA-1: %s", sb.buf);
ef644c4150 66) oidset_insert(set, &oid);
ef644c4150 68) if (ferror(fp))
ef644c4150 69) die_errno("Could not read '%s'", path);
ef644c4150 70) fclose(fp);
ef644c4150 71) strbuf_release(&sb);
ef644c4150 72) }

parse-options-cb.c
8fc6b47cd5  26) v = the_hash_algo->hexsz;
08339886b9 173) enum parse_opt_result parse_opt_unknown_cb(struct parse_opt_ctx_t *ctx,
9b4ae5190a 177) BUG_ON_OPT_ARG(arg);
08339886b9 178) return PARSE_OPT_UNKNOWN;

parse-options.c
08339886b9  48) static enum parse_opt_result opt_command_mode_error(
08339886b9  74) return PARSE_OPT_ERROR;
9b4ae5190a 183) return (*opt->ll_callback)(p, opt, p_arg, p_unset);
9b4ae5190a 255) rc = (*numopt->ll_callback)(p, numopt, arg, 0);

pretty.c
4681fe38e1 1060) static int match_placeholder_arg_value(const char *to_parse, const char *candidate,
4681fe38e1 1067) if (valuestart) {
4681fe38e1 1068) if (*p != '=')
4681fe38e1 1069) return 0;
4681fe38e1 1070) *valuestart = p + 1;
4681fe38e1 1071) *valuelen = strcspn(*valuestart, ",)");
4681fe38e1 1072) p = *valuestart + *valuelen;
4681fe38e1 1085) static int match_placeholder_arg(const char *to_parse, const char *candidate,
4681fe38e1 1088) return match_placeholder_arg_value(to_parse, candidate, end, NULL, NULL);
b755bf6f83 1091) static int match_placeholder_bool_arg(const char *to_parse, const char *candidate,
b755bf6f83 1095) if (!skip_prefix(to_parse, candidate, &p))
b755bf6f83 1096) return 0;
b755bf6f83 1098) if (match_placeholder_arg(p, "=no", end) ||
b755bf6f83 1099)     match_placeholder_arg(p, "=off", end) ||
b755bf6f83 1100)     match_placeholder_arg(p, "=false", end)) {
b755bf6f83 1101) *val = 0;
b755bf6f83 1102) return 1;
b755bf6f83 1105) if (match_placeholder_arg(p, "", end) ||
b755bf6f83 1106)     match_placeholder_arg(p, "=yes", end) ||
b755bf6f83 1107)     match_placeholder_arg(p, "=on", end) ||
b755bf6f83 1108)     match_placeholder_arg(p, "=true", end)) {
b755bf6f83 1109) *val = 1;
b755bf6f83 1110) return 1;
4681fe38e1 1112) return 0;
4681fe38e1 1115) static int format_trailer_match_cb(const struct strbuf *key, void *ud)
4681fe38e1 1117) const struct string_list *list = ud;
4681fe38e1 1120) for_each_string_list_item (item, list) {
4681fe38e1 1121) if (key->len == (uintptr_t)item->util &&
4681fe38e1 1122)     !strncasecmp (item->string, key->buf, key->len))
4681fe38e1 1123) return 1;
b755bf6f83 1125) return 0;
18f8e81091 1143) return res;
4681fe38e1 1369) struct string_list filter_list = STRING_LIST_INIT_NODUP;
ced45aab72 1370) struct strbuf sepbuf = STRBUF_INIT;
ffd7cae405 1371) size_t ret = 0;
4681fe38e1 1381) if (match_placeholder_arg_value(arg, "key", &arg, &argval, &arglen)) {
4681fe38e1 1382) uintptr_t len = arglen;
4681fe38e1 1383) if (len && argval[len - 1] == ':')
4681fe38e1 1384) len--;
4681fe38e1 1385) string_list_append(&filter_list, argval)->util = (char *)len;
4681fe38e1 1387) opts.filter = format_trailer_match_cb;
4681fe38e1 1388) opts.filter_data = &filter_list;
ced45aab72 1390) } else if (match_placeholder_arg_value(arg, "separator", &arg, &argval, &arglen)) {
ced45aab72 1393) strbuf_reset(&sepbuf);
ced45aab72 1394) fmt = xstrndup(argval, arglen);
ced45aab72 1395) strbuf_expand(&sepbuf, fmt, strbuf_expand_literal_cb, NULL);
ced45aab72 1396) free(fmt);
ced45aab72 1397) opts.separator = &sepbuf;
4681fe38e1 1398) } else if (!match_placeholder_bool_arg(arg, "only", &arg, &opts.only_trailers) &&
e9da5de761 1399)    !match_placeholder_bool_arg(arg, "unfold", &arg, &opts.unfold) &&
e9da5de761 1400)    !match_placeholder_bool_arg(arg, "valueonly", &arg, &opts.value_only))
ffd7cae405 1406) ret = arg - placeholder + 1;
4681fe38e1 1408) string_list_clear (&filter_list, 0);
ced45aab72 1409) strbuf_release(&sepbuf);
ffd7cae405 1410) return ret;

protocol.c
6da1f1a920  31) return protocol_v0_string;
6da1f1a920  33) return protocol_v1_string;
6da1f1a920  37) die(_("Unrecognized protocol version"));
6da1f1a920  39) die(_("Unrecognized protocol_version"));
6da1f1a920  76) return;
6da1f1a920 112) ALLOC_ARRAY(tmp_allowed_versions, tmp_nr);
6da1f1a920 113) copy_array(tmp_allowed_versions, allowed_versions, tmp_nr,
6da1f1a920 122) for (i = 1; i < nr_allowed_versions; i++)
6da1f1a920 123) if (tmp_allowed_versions[i] == config_version) {
6da1f1a920 124) SWAP(tmp_allowed_versions[0],
6da1f1a920 131) strbuf_addf(advert, ":version=%s",
6da1f1a920 132)     format_protocol_version(tmp_allowed_versions[i]));

rebase-interactive.c
c27b32f0ec  15) static enum missing_commit_check_level get_missing_commit_check_level(void)
c27b32f0ec  19) if (git_config_get_value("rebase.missingcommitscheck", &value) ||
c27b32f0ec  20) !strcasecmp("ignore", value))
c27b32f0ec  21) return MISSING_COMMIT_CHECK_IGNORE;
c27b32f0ec  22) if (!strcasecmp("warn", value))
c27b32f0ec  23) return MISSING_COMMIT_CHECK_WARN;
c27b32f0ec  24) if (!strcasecmp("error", value))
c27b32f0ec  25) return MISSING_COMMIT_CHECK_ERROR;
c27b32f0ec  26) warning(_("unrecognized setting %s for option "
c27b32f0ec  28) return MISSING_COMMIT_CHECK_IGNORE;
2dd989a694  31) void append_todo_help(unsigned keep_empty, int command_count,
2dd989a694  52) unsigned edit_todo = !(shortrevisions && shortonto);
2dd989a694  54) if (!edit_todo) {
2dd989a694  55) strbuf_addch(buf, '\n');
2dd989a694  56) strbuf_commented_addf(buf, Q_("Rebase %s onto %s (%d command)",
e5b1c9d929  90) int edit_todo_list(struct repository *r, struct todo_list *todo_list,
e5b1c9d929  95) unsigned initial = shortrevisions && shortonto;
e5b1c9d929  97) if (initial) {
e5b1c9d929  98) todo_list_write_to_file(r, todo_list, todo_file, shortrevisions, shortonto,
e5b1c9d929 101) if (copy_file(rebase_path_todo_backup(), todo_file, 0666))
e5b1c9d929 102) return error(_("could not copy '%s' to '%s'."), todo_file,
e5b1c9d929 105) todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_list);
e5b1c9d929 106) todo_list_write_to_file(r, todo_list, todo_file, NULL, NULL, -1,
e5b1c9d929 110) if (launch_sequence_editor(todo_file, &new_todo->buf, NULL))
e5b1c9d929 111) return -2;
e5b1c9d929 113) strbuf_stripspace(&new_todo->buf, 1);
e5b1c9d929 114) if (initial && new_todo->buf.len == 0)
e5b1c9d929 115) return -3;
e5b1c9d929 117) if (!initial)
e5b1c9d929 118) todo_list_parse_insn_buffer(r, new_todo->buf.buf, new_todo);
e5b1c9d929 120) return 0;
c27b32f0ec 123) define_commit_slab(commit_seen, unsigned char);
c27b32f0ec 130) int todo_list_check(struct todo_list *old_todo, struct todo_list *new_todo)
c27b32f0ec 132) enum missing_commit_check_level check_level = get_missing_commit_check_level();
c27b32f0ec 133) struct strbuf missing = STRBUF_INIT;
c27b32f0ec 134) int res = 0, i;
c27b32f0ec 137) init_commit_seen(&commit_seen);
c27b32f0ec 139) if (check_level == MISSING_COMMIT_CHECK_IGNORE)
c27b32f0ec 140) goto leave_check;
c27b32f0ec 143) for (i = 0; i < new_todo->nr; i++) {
c27b32f0ec 144) struct commit *commit = new_todo->items[i].commit;
c27b32f0ec 145) if (commit)
c27b32f0ec 146) *commit_seen_at(&commit_seen, commit) = 1;
c27b32f0ec 150) for (i = old_todo->nr - 1; i >= 0; i--) {
c27b32f0ec 151) struct todo_item *item = old_todo->items + i;
c27b32f0ec 152) struct commit *commit = item->commit;
c27b32f0ec 153) if (commit && !*commit_seen_at(&commit_seen, commit)) {
c27b32f0ec 154) strbuf_addf(&missing, " - %s %.*s\n",
c27b32f0ec 155)     find_unique_abbrev(&commit->object.oid, DEFAULT_ABBREV),
c27b32f0ec 157)     old_todo->buf.buf + item->arg_offset);
c27b32f0ec 158) *commit_seen_at(&commit_seen, commit) = 1;
c27b32f0ec 163) if (!missing.len)
c27b32f0ec 164) goto leave_check;
c27b32f0ec 166) if (check_level == MISSING_COMMIT_CHECK_ERROR)
c27b32f0ec 167) res = 1;
c27b32f0ec 169) fprintf(stderr,
c27b32f0ec 174) fputs(missing.buf, stderr);
c27b32f0ec 175) strbuf_release(&missing);
c27b32f0ec 177) fprintf(stderr, _("To avoid this message, use \"drop\" to "
c27b32f0ec 184) clear_commit_seen(&commit_seen);
c27b32f0ec 185) return res;

remote-curl.c
6da1f1a920  344) return 0;
34a9469d6a  363) return;
34a9469d6a  373) die("invalid server response; expected service, got flush packet");
240fb9b7a0  392) } else if (!strcmp(line, "version 2")) {
34a9469d6a  397) d->proto_git = 1;
e586e7df7c  399) } else if (skip_prefix(line, "ERR ", &p)) {
e586e7df7c  400) die(_("remote error: %s"), p);

repository.c
rerere.c
e1ff0a32e4  598) if (repo_read_index(r) < 0)
3a95f31d1c  708) repo_hold_locked_index(r, &index_lock, LOCK_DIE_ON_ERROR);
e1ff0a32e4 1110) if (repo_read_index(r) < 0)

revision.c
d5d2e93577  109) static int path_and_oids_cmp(const void *hashmap_cmp_fn_data,
d5d2e93577  114) return strcmp(e1->path, e2->path);
d5d2e93577  117) static void paths_and_oids_init(struct hashmap *map)
d5d2e93577  119) hashmap_init(map, (hashmap_cmp_fn) path_and_oids_cmp, NULL, 0);
d5d2e93577  120) }
d5d2e93577  122) static void paths_and_oids_clear(struct hashmap *map)
d5d2e93577  126) hashmap_iter_init(map, &iter);
d5d2e93577  128) while ((entry = (struct path_and_oids_entry *)hashmap_iter_next(&iter))) {
d5d2e93577  129) oidset_clear(&entry->trees);
d5d2e93577  130) free(entry->path);
d5d2e93577  133) hashmap_free(map, 1);
d5d2e93577  134) }
d5d2e93577  136) static void paths_and_oids_insert(struct hashmap *map,
d5d2e93577  140) int hash = strhash(path);
d5d2e93577  144) hashmap_entry_init(&key, hash);
d5d2e93577  147) key.path = (char *)path;
d5d2e93577  148) oidset_init(&key.trees, 0);
d5d2e93577  150) if (!(entry = (struct path_and_oids_entry *)hashmap_get(map, &key, NULL))) {
d5d2e93577  151) entry = xcalloc(1, sizeof(struct path_and_oids_entry));
d5d2e93577  152) hashmap_entry_init(entry, hash);
d5d2e93577  153) entry->path = xstrdup(key.path);
d5d2e93577  154) oidset_init(&entry->trees, 16);
d5d2e93577  155) hashmap_put(map, entry);
d5d2e93577  158) oidset_insert(&entry->trees, oid);
d5d2e93577  159) }
d5d2e93577  161) static void add_children_by_path(struct repository *r,
d5d2e93577  168) if (!tree)
d5d2e93577  169) return;
d5d2e93577  171) if (parse_tree_gently(tree, 1) < 0)
d5d2e93577  172) return;
d5d2e93577  174) init_tree_desc(&desc, tree->buffer, tree->size);
d5d2e93577  175) while (tree_entry(&desc, &entry)) {
d5d2e93577  176) switch (object_type(entry.mode)) {
5dde8fc6df  178) paths_and_oids_insert(map, entry.path, &entry.oid);
d5d2e93577  180) if (tree->object.flags & UNINTERESTING) {
5dde8fc6df  181) struct tree *child = lookup_tree(r, &entry.oid);
d5d2e93577  182) if (child)
d5d2e93577  183) child->object.flags |= UNINTERESTING;
d5d2e93577  185) break;
d5d2e93577  187) if (tree->object.flags & UNINTERESTING) {
5dde8fc6df  188) struct blob *child = lookup_blob(r, &entry.oid);
d5d2e93577  189) if (child)
d5d2e93577  190) child->object.flags |= UNINTERESTING;
d5d2e93577  192) break;
d5d2e93577  195) break;
d5d2e93577  199) free_tree_buffer(tree);
f1f5de442f  202) void mark_trees_uninteresting_sparse(struct repository *r,
d5d2e93577  205) unsigned has_interesting = 0, has_uninteresting = 0;
f1f5de442f  212) oidset_iter_init(trees, &iter);
d5d2e93577  213) while ((!has_interesting || !has_uninteresting) &&
f1f5de442f  215) struct tree *tree = lookup_tree(r, oid);
f1f5de442f  217) if (!tree)
f1f5de442f  218) continue;
d5d2e93577  220) if (tree->object.flags & UNINTERESTING)
d5d2e93577  221) has_uninteresting = 1;
d5d2e93577  223) has_interesting = 1;
d5d2e93577  227) if (!has_uninteresting || !has_interesting)
d5d2e93577  228) return;
d5d2e93577  230) paths_and_oids_init(&map);
d5d2e93577  232) oidset_iter_init(trees, &iter);
d5d2e93577  233) while ((oid = oidset_iter_next(&iter))) {
d5d2e93577  234) struct tree *tree = lookup_tree(r, oid);
d5d2e93577  235) add_children_by_path(r, tree, &map);
d5d2e93577  238) hashmap_iter_init(&map, &map_iter);
d5d2e93577  239) while ((entry = hashmap_iter_next(&map_iter)))
d5d2e93577  240) mark_trees_uninteresting_sparse(r, &entry->trees);
d5d2e93577  242) paths_and_oids_clear(&map);
e1ff0a32e4 1690) repo_read_index(revs->repo);
3a7a698e93 1749) if (get_oid_with_context(revs->repo, a_name, oc_flags, &a_oid, a_oc) ||
3a7a698e93 1750)     get_oid_with_context(revs->repo, b_name, oc_flags, &b_oid, b_oc))

sequencer.c
e5b1c9d929   58) GIT_PATH_FUNC(rebase_path_todo_backup, "rebase-merge/git-rebase-todo.backup")
e1ff0a32e4  449) static int error_dirty_index(struct repository *repo, struct replay_opts *opts)
e1ff0a32e4  451) if (repo_read_index_unmerged(repo))
e1ff0a32e4  486) repo_read_index(r);
1d18d7581c 1118) void commit_post_rewrite(struct repository *r,
1d18d7581c 1128) finish_copy_notes_for_rewrite(r, cfg, "Notes added by 'git commit --amend'");
1d18d7581c 1409) commit_post_rewrite(r, current_head, oid);
e1ff0a32e4 1745) return error_dirty_index(r, opts);
5d94d54564 1996) void todo_list_release(struct todo_list *todo_list)
d836079ec2 2024) item->arg_offset = bol - buf;
d836079ec2 2051) item->arg_offset = bol - buf;
d836079ec2 2063) item->arg_offset = bol - buf;
d836079ec2 2077) item->arg_offset = bol - buf;
d836079ec2 2089) bol = end_of_object_name + strspn(end_of_object_name, " \t");
d836079ec2 2090) item->arg_offset = bol - buf;
d836079ec2 2091) item->arg_len = (int)(eol - bol);
5d94d54564 2100) int todo_list_parse_insn_buffer(struct repository *r, char *buf,
2b71595d47 2107) todo_list->current = todo_list->nr = 0;
d836079ec2 2119) if (parse_insn_line(r, item, buf, p, eol)) {
2b71595d47 2122) item->command = TODO_COMMENT + 1;
d836079ec2 2123) item->arg_offset = p - buf;
2b71595d47 2124) item->arg_len = (int)(eol - p);
2b71595d47 2125) item->commit = NULL;
5d94d54564 2200) res = todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_list);
5d94d54564 2231)     !todo_list_parse_insn_buffer(r, done.buf.buf, &done))
d836079ec2 2468) item->arg_offset = 0;
e1ff0a32e4 2829) if (discard_index(r->index) < 0 || repo_read_index(r) < 0)
3a95f31d1c 2953) if (repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ERROR) < 0)
e1ff0a32e4 2998) if (repo_read_index_unmerged(r)) {
3a95f31d1c 3071) if (repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ERROR) < 0) {
e1ff0a32e4 3252)      repo_read_index(r) < 0))
e1ff0a32e4 3274) repo_read_index(r);
0d6caa2d08 3275) init_merge_options(&o, r);
d836079ec2 3507) const char *arg = todo_list->buf.buf + item->arg_offset;
d836079ec2 3595) char *end_of_arg = (char *)(arg + item->arg_len);
d836079ec2 3600) res = do_exec(r, arg);
d836079ec2 3618) if ((res = do_label(r, arg, item->arg_len)))
d836079ec2 3621) if ((res = do_reset(r, arg, item->arg_len, opts)))
e1ff0a32e4 3950) res = error_dirty_index(r, opts);
0566a4f68e 4372) strbuf_addf(out, "%s onto\n", cmd_label);
0566a4f68e 4382) strbuf_addf(out, "\n%c Branch %s\n", comment_line_char, entry->string);
0566a4f68e 4384) strbuf_addch(out, '\n');
0566a4f68e 4397) strbuf_addf(out, "%s %s\n", cmd_reset,
0566a4f68e 4411) strbuf_addf(out, "%s onto\n", cmd_reset);
0566a4f68e 4415) strbuf_addf(out, "%s %s # %s\n",
0566a4f68e 4425) strbuf_addf(out, "%s\n", entry->string);
0566a4f68e 4428) strbuf_addf(out, "%s %s\n",
0566a4f68e 4429)     cmd_label, entry->string);
0566a4f68e 4451) int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
0566a4f68e 4499) strbuf_addf(out, "%c ", comment_line_char);
0566a4f68e 4500) strbuf_addf(out, "%s %s ", insn,
0566a4f68e 4502) pretty_print_commit(&pp, commit, out);
0566a4f68e 4503) strbuf_addch(out, '\n');
8414c890aa 4508) static void todo_list_add_exec_commands(struct todo_list *todo_list,
8414c890aa 4511) struct strbuf *buf = &todo_list->buf;
8414c890aa 4512) size_t base_offset = buf->len;
8414c890aa 4513) int i, insert, nr = 0, alloc = 0;
8414c890aa 4514) struct todo_item *items = NULL, *base_items = NULL;
8414c890aa 4516) base_items = xcalloc(commands->nr, sizeof(struct todo_item));
8414c890aa 4517) for (i = 0; i < commands->nr; ++i) {
8414c890aa 4518) size_t command_len = strlen(commands->items[i].string);
8414c890aa 4520) strbuf_addstr(buf, commands->items[i].string);
8414c890aa 4521) strbuf_addch(buf, '\n');
8414c890aa 4523) base_items[i].command = TODO_EXEC;
8414c890aa 4524) base_items[i].offset_in_buf = base_offset;
8414c890aa 4525) base_items[i].arg_offset = base_offset + strlen("exec ");
8414c890aa 4526) base_items[i].arg_len = command_len - strlen("exec ");
8414c890aa 4528) base_offset += command_len + 1;
8414c890aa 4537) for (i = 0; i < todo_list->nr; i++) {
8414c890aa 4538) enum todo_command command = todo_list->items[i].command;
8414c890aa 4539) if (insert >= 0 && command != TODO_COMMENT && !is_fixup(command)) {
8414c890aa 4540) ALLOC_GROW(items, nr + commands->nr, alloc);
8414c890aa 4541) COPY_ARRAY(items + nr, base_items, commands->nr);
8414c890aa 4542) nr += commands->nr;
8414c890aa 4546) ALLOC_GROW(items, nr + 1, alloc);
8414c890aa 4547) items[nr++] = todo_list->items[i];
8414c890aa 4549) if (command == TODO_PICK || command == TODO_MERGE || is_fixup(command))
8414c890aa 4554) if (insert >= 0 || nr == todo_list->nr) {
8414c890aa 4555) ALLOC_GROW(items, nr + commands->nr, alloc);
8414c890aa 4556) COPY_ARRAY(items + nr, base_items, commands->nr);
8414c890aa 4557) nr += commands->nr;
8414c890aa 4560) free(base_items);
8414c890aa 4561) FREE_AND_NULL(todo_list->items);
8414c890aa 4562) todo_list->items = items;
8414c890aa 4563) todo_list->nr = nr;
8414c890aa 4564) todo_list->alloc = alloc;
8414c890aa 4571) int sequencer_add_exec_commands(struct repository *r,
8414c890aa 4579) return error_errno(_("could not read '%s'."), todo_file);
8414c890aa 4581) if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list)) {
8414c890aa 4586) todo_list_add_exec_commands(&todo_list, commands);
8414c890aa 4587) res = todo_list_write_to_file(r, &todo_list, todo_file, NULL, NULL, -1, 0);
0cce4a2756 4588) todo_list_release(&todo_list);
8414c890aa 4590) if (res)
8414c890aa 4591) return error_errno(_("could not write '%s'."), todo_file);
8414c890aa 4592) return 0;
cf18b3f6c9 4595) static void todo_list_to_strbuf(struct repository *r, struct todo_list *todo_list,
cf18b3f6c9 4599) int i, max = todo_list->nr;
cf18b3f6c9 4601) if (num > 0 && num < max)
cf18b3f6c9 4602) max = num;
cf18b3f6c9 4604) for (item = todo_list->items, i = 0; i < max; i++, item++) {
cf18b3f6c9 4607) strbuf_addf(buf, "%.*s\n", item->arg_len,
3ebafef416 4608)     todo_list->buf.buf + item->arg_offset);
cf18b3f6c9 4614) strbuf_addch(buf, command_to_char(item->command));
cf18b3f6c9 4616) strbuf_addstr(buf, command_to_string(item->command));
cf18b3f6c9 4626) strbuf_addstr(buf, " -c");
cf18b3f6c9 4628) strbuf_addstr(buf, " -C");
cf18b3f6c9 4631) strbuf_addf(buf, " %s", oid);
cf18b3f6c9 4636) strbuf_addch(buf, '\n');
cf18b3f6c9 4638) strbuf_addf(buf, " %.*s\n", item->arg_len,
3ebafef416 4639)     todo_list->buf.buf + item->arg_offset);
cf18b3f6c9 4643) int todo_list_write_to_file(struct repository *r, struct todo_list *todo_list,
cf18b3f6c9 4648) struct strbuf buf = STRBUF_INIT;
cf18b3f6c9 4650) todo_list_to_strbuf(r, todo_list, &buf, num, flags);
2dd989a694 4651) if (flags & TODO_LIST_APPEND_TODO_HELP)
2dd989a694 4652) append_todo_help(flags & TODO_LIST_KEEP_EMPTY, count_commands(todo_list),
cf18b3f6c9 4655) res = write_message(buf.buf, buf.len, file, 0);
3ebafef416 4656) strbuf_release(&buf);
cf18b3f6c9 4658) return res;
c27b32f0ec 4667) int check_todo_list_from_file(struct repository *r)
c27b32f0ec 4669) struct todo_list old_todo = TODO_LIST_INIT, new_todo = TODO_LIST_INIT;
c27b32f0ec 4670) int res = 0;
c27b32f0ec 4672) if (strbuf_read_file_or_whine(&new_todo.buf, rebase_path_todo()) < 0) {
878056005e 4673) res = -1;
c27b32f0ec 4674) goto out;
c27b32f0ec 4677) if (strbuf_read_file_or_whine(&old_todo.buf, rebase_path_todo_backup()) < 0) {
c27b32f0ec 4679) goto out;
c27b32f0ec 4682) res = todo_list_parse_insn_buffer(r, old_todo.buf.buf, &old_todo);
c27b32f0ec 4683) if (!res)
c27b32f0ec 4684) res = todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo);
c27b32f0ec 4685) if (!res)
c27b32f0ec 4686) res = todo_list_check(&old_todo, &new_todo);
c27b32f0ec 4687) if (res)
c27b32f0ec 4688) fprintf(stderr, _(edit_todo_list_advice));
c27b32f0ec 4690) todo_list_release(&old_todo);
c27b32f0ec 4691) todo_list_release(&new_todo);
98b29e0607 4697) static int skip_unnecessary_picks(struct repository *r,
98b29e0607 4704) for (i = 0; i < todo_list->nr; i++) {
98b29e0607 4705) struct todo_item *item = todo_list->items + i;
98b29e0607 4727) if (todo_list_write_to_file(r, todo_list, done_path, NULL, NULL, i, 0)) {
98b29e0607 4732) MOVE_ARRAY(todo_list->items, todo_list->items + i, todo_list->nr - i);
98b29e0607 4733) todo_list->nr -= i;
98b29e0607 4734) todo_list->current = 0;
98b29e0607 4736) if (is_fixup(peek_command(todo_list, 0)))
98b29e0607 4737) record_in_rewritten(output_oid, peek_command(todo_list, 0));
c1c074e0cc 4751) struct todo_list new_todo = TODO_LIST_INIT;
c1c074e0cc 4752) struct strbuf *buf = &todo_list->buf;
c1c074e0cc 4759) if (buf->len == 0) {
c1c074e0cc 4760) struct todo_item *item = append_new_todo(todo_list);
c1c074e0cc 4761) item->command = TODO_NOOP;
c1c074e0cc 4762) item->commit = NULL;
c1c074e0cc 4763) item->arg_len = item->arg_offset = item->flags = item->offset_in_buf = 0;
c1c074e0cc 4766) if (autosquash && todo_list_rearrange_squash(todo_list))
8414c890aa 4769) if (commands->nr)
c1c074e0cc 4770) todo_list_add_exec_commands(todo_list, commands);
c1c074e0cc 4772) if (count_commands(todo_list) == 0) {
33bc1844f7 4779) res = edit_todo_list(r, todo_list, &new_todo, shortrevisions,
33bc1844f7 4781) if (res == -1)
33bc1844f7 4783) else if (res == -2) {
33bc1844f7 4788) } else if (res == -3) {
c1c074e0cc 4791) todo_list_release(&new_todo);
c1c074e0cc 4796) if (todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo) ||
c1c074e0cc 4797)     todo_list_check(todo_list, &new_todo)) {
c1c074e0cc 4798) fprintf(stderr, _(edit_todo_list_advice));
c1c074e0cc 4800) todo_list_release(&new_todo);
98b29e0607 4805) if (opts->allow_ff && skip_unnecessary_picks(r, &new_todo, &oid)) {
98b29e0607 4806) todo_list_release(&new_todo);
c1c074e0cc 4810) if (todo_list_write_to_file(r, &new_todo, todo_file, NULL, NULL, -1,
c1c074e0cc 4812) todo_list_release(&new_todo);
c1c074e0cc 4813) return error_errno(_("could not write '%s'"), todo_file);
c1c074e0cc 4816) todo_list_release(&new_todo);
febebd99b6 4851) static int todo_list_rearrange_squash(struct todo_list *todo_list)
febebd99b6 4854) int rearranged = 0, *next, *tail, i, nr = 0, alloc = 0;
febebd99b6 4857) struct todo_item *items = NULL;
febebd99b6 4870)      NULL, todo_list->nr);
febebd99b6 4871) ALLOC_ARRAY(next, todo_list->nr);
febebd99b6 4872) ALLOC_ARRAY(tail, todo_list->nr);
febebd99b6 4873) ALLOC_ARRAY(subjects, todo_list->nr);
febebd99b6 4874) for (i = 0; i < todo_list->nr; i++) {
febebd99b6 4876) struct todo_item *item = todo_list->items + i;
febebd99b6 4923) - todo_list->items;
febebd99b6 4936) todo_list->items[i].command =
febebd99b6 4954) for (i = 0; i < todo_list->nr; i++) {
febebd99b6 4955) enum todo_command command = todo_list->items[i].command;
febebd99b6 4966) ALLOC_GROW(items, nr + 1, alloc);
febebd99b6 4967) items[nr++] = todo_list->items[cur];
febebd99b6 4972) FREE_AND_NULL(todo_list->items);
febebd99b6 4973) todo_list->items = items;
febebd99b6 4974) todo_list->nr = nr;
febebd99b6 4975) todo_list->alloc = alloc;
febebd99b6 4980) for (i = 0; i < todo_list->nr; i++)
febebd99b6 4987) return 0;
febebd99b6 4990) int rearrange_squash_in_todo_file(struct repository *r)
febebd99b6 4992) const char *todo_file = rebase_path_todo();
febebd99b6 4993) struct todo_list todo_list = TODO_LIST_INIT;
febebd99b6 4994) int res = 0;
febebd99b6 4996) if (strbuf_read_file_or_whine(&todo_list.buf, todo_file) < 0)
febebd99b6 4997) return -1;
febebd99b6 4998) if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list) < 0) {
febebd99b6 4999) todo_list_release(&todo_list);
febebd99b6 5000) return -1;
febebd99b6 5003) res = todo_list_rearrange_squash(&todo_list);
febebd99b6 5004) if (!res)
febebd99b6 5005) res = todo_list_write_to_file(r, &todo_list, todo_file, NULL, NULL, -1, 0);
febebd99b6 5007) todo_list_release(&todo_list);
febebd99b6 5009) if (res)
febebd99b6 5010) return error_errno(_("could not write '%s'."), todo_file);
febebd99b6 5011) return 0;

sha1-name.c
4e763fae87 sha1-name.c 1523) int get_oidf(struct object_id *oid, const char *fmt, ...)
4e763fae87 sha1-name.c 1527) struct strbuf sb = STRBUF_INIT;
4e763fae87 sha1-name.c 1529) va_start(ap, fmt);
4e763fae87 sha1-name.c 1530) strbuf_vaddf(&sb, fmt, ap);
4e763fae87 sha1-name.c 1531) va_end(ap);
4e763fae87 sha1-name.c 1533) ret = get_oid(sb.buf, oid);
4e763fae87 sha1-name.c 1534) strbuf_release(&sb);
4e763fae87 sha1-name.c 1536) return ret;
3a7a698e93 sha1-name.c 1624) static void diagnose_invalid_index_path(struct index_state *istate,
3a7a698e93 sha1-name.c 1638) pos = index_name_pos(istate, filename, namelen);
3a7a698e93 sha1-name.c 1641) if (pos < istate->cache_nr) {
3a7a698e93 sha1-name.c 1642) ce = istate->cache[pos];
3a7a698e93 sha1-name.c 1654) pos = index_name_pos(istate, fullname.buf, fullname.len);
3a7a698e93 sha1-name.c 1657) if (pos < istate->cache_nr) {
3a7a698e93 sha1-name.c 1658) ce = istate->cache[pos];
3a7a698e93 sha1-name.c 1771) diagnose_invalid_index_path(repo->index, stage, prefix, cp);

strbuf.c
bfc3fe33f6  252) void strbuf_vinsertf(struct strbuf *sb, size_t pos, const char *fmt, va_list ap)
bfc3fe33f6  258) if (pos > sb->len)
bfc3fe33f6  259) die("`pos' is too far after the end of the buffer");
bfc3fe33f6  260) va_copy(cp, ap);
bfc3fe33f6  261) len = vsnprintf(sb->buf + sb->len, 0, fmt, cp);
bfc3fe33f6  262) va_end(cp);
bfc3fe33f6  263) if (len < 0)
bfc3fe33f6  265) if (!len)
bfc3fe33f6  266) return; /* nothing to do */
bfc3fe33f6  267) if (unsigned_add_overflows(sb->len, len))
bfc3fe33f6  268) die("you want to use way too much memory");
bfc3fe33f6  269) strbuf_grow(sb, len);
bfc3fe33f6  270) memmove(sb->buf + pos + len, sb->buf + pos, sb->len - pos);
bfc3fe33f6  272) save = sb->buf[pos + len];
bfc3fe33f6  273) len2 = vsnprintf(sb->buf + pos, sb->alloc - sb->len, fmt, ap);
bfc3fe33f6  274) sb->buf[pos + len] = save;
bfc3fe33f6  275) if (len2 != len)
bfc3fe33f6  277) strbuf_setlen(sb, sb->len + len);
bfc3fe33f6  280) void strbuf_insertf(struct strbuf *sb, size_t pos, const char *fmt, ...)
bfc3fe33f6  283) va_start(ap, fmt);
bfc3fe33f6  284) strbuf_vinsertf(sb, pos, fmt, ap);
bfc3fe33f6  285) va_end(ap);
bfc3fe33f6  286) }
0c1599c33c  307) const char *strbuf_join_argv(struct strbuf *buf,
0c1599c33c  310) if (!argc)
0c1599c33c  311) return buf->buf;
0c1599c33c  313) strbuf_addstr(buf, *argv);
0c1599c33c  314) while (--argc) {
0c1599c33c  315) strbuf_addch(buf, delim);
0c1599c33c  316) strbuf_addstr(buf, *(++argv));
0c1599c33c  319) return buf->buf;
18f8e81091  442) strbuf_addch(sb, '\n');
18f8e81091  443) return 1;
18f8e81091  446) ch = hex2chr(placeholder + 1);
18f8e81091  447) if (ch < 0)
18f8e81091  448) return 0;
18f8e81091  449) strbuf_addch(sb, ch);
18f8e81091  450) return 3;

trailer.c
ced45aab72 1132) size_t origlen = out->len;
ced45aab72 1136) if (!opts->only_trailers && !opts->unfold && !opts->filter && !opts->separator) {
4681fe38e1 1151) if (!opts->filter || opts->filter(&tok, opts->filter_data)) {
4681fe38e1 1152) if (opts->unfold)
4681fe38e1 1153) unfold_value(&val);
ced45aab72 1155) if (opts->separator && out->len != origlen)
ced45aab72 1156) strbuf_addbuf(out, opts->separator);
e9da5de761 1157) if (!opts->value_only)
e9da5de761 1158) strbuf_addf(out, "%s: ", tok.buf);
e9da5de761 1159) strbuf_addbuf(out, &val);
ced45aab72 1160) if (!opts->separator)
ced45aab72 1161) strbuf_addch(out, '\n');
ced45aab72 1167) if (opts->separator && out->len != origlen) {
ced45aab72 1168) strbuf_addbuf(out, opts->separator);
ced45aab72 1171) if (opts->separator) {
ced45aab72 1172) strbuf_rtrim(out);

worktree.c
2ec5633ff4 587) char *get_worktree_config(struct repository *r)
2ec5633ff4 589) struct worktree **worktrees = get_worktrees(0);
2ec5633ff4 592) if (repository_format_worktree_config)
2ec5633ff4 593) path = repo_git_path(r, "config.worktree");
2ec5633ff4 594) else if (worktrees[0] && worktrees[1])
2ec5633ff4 595) path = NULL;
2ec5633ff4 597) path = repo_git_path(r, "config");
2ec5633ff4 599) free_worktrees(worktrees);
2ec5633ff4 600) return path;

wrapper.c
5efde212fc  70) die("Out of memory, malloc failed (tried to allocate %" PRIuMAX " bytes)",
5efde212fc  73) error("Out of memory, malloc failed (tried to allocate %" PRIuMAX " bytes)",

wt-status.c
3a95f31d1c 2378) fd = repo_hold_locked_index(r, &lock_file, 0);
1b0d968b34 2381) repo_update_index_if_able(r, &lock_file);

Commits introducing uncovered code:
Ævar Arnfjörð Bjarmason      97b202471: commit-graph write: use pack order when finding commits
Alban Gruin      0566a4f68: sequencer: make sequencer_make_script() write its script to a strbuf
Alban Gruin      2b71595d4: sequencer: changes in parse_insn_buffer()
Alban Gruin      2dd989a69: rebase-interactive: append_todo_help() changes
Alban Gruin      33bc1844f: sequencer: use edit_todo_list() in complete_action()
Alban Gruin      3ebafef41: sequencer: refactor transform_todos() to work on a todo_list
Alban Gruin      4d55dfd76: rebase-interactive: move transform_todo_file() to rebase--interactive.c
Alban Gruin      5d94d5456: sequencer: make the todo_list structure public
Alban Gruin      8414c890a: sequencer: refactor sequencer_add_exec_commands() to work on a todo_list
Alban Gruin      98b29e060: sequencer: refactor skip_unnecessary_picks() to work on a todo_list
Alban Gruin      c1c074e0c: sequencer: change complete_action() to use the refactored functions
Alban Gruin      c27b32f0e: sequencer: refactor check_todo_list() to work on a todo_list
Alban Gruin      cf18b3f6c: sequencer: introduce todo_list_write_to_file()
Alban Gruin      d836079ec: sequencer: remove the 'arg' field from todo_item
Alban Gruin      e5b1c9d92: rebase-interactive: rewrite edit_todo_list() to handle the initial edit
Alban Gruin      febebd99b: sequencer: refactor rearrange_squash() to work on a todo_list
Anders Waldenborg      18f8e8109: strbuf: separate callback for strbuf_expand:ing literals
Anders Waldenborg      4681fe38e: pretty: allow showing specific trailers
Anders Waldenborg      b755bf6f8: pretty: allow %(trailers) options with explicit value
Anders Waldenborg      ced45aab7: pretty: add support for separator option in %(trailers)
Anders Waldenborg      e9da5de76: pretty: add support for "valueonly" option in %(trailers)
Anders Waldenborg      ffd7cae40: pretty: single return path in %(trailers) handling
Barret Rhoden      07d04b919: blame: add a config option to mark ignored lines
Barret Rhoden      e7973c851: blame: add the ability to ignore commits and their changes
Barret Rhoden      ef644c415: Move init_skiplist() outside of fsck
Derrick Stolee      3d036eb0d: pack-objects: create pack.useSparse setting
Derrick Stolee      4f6d26b16: list-objects: consume sparse tree walk
Derrick Stolee      d5d2e9357: revision: implement sparse algorithm
Derrick Stolee      f1f5de442: revision: add mark_tree_uninteresting_sparse
Jeff King      240fb9b7a: remote-curl: tighten "version 2" check for smart-http
Jeff King      34a9469d6: remote-curl: refactor smart-http discovery
Jiang Xin      a338d1039: pack-redundant: consistent sort method
Jiang Xin      cb7e0336f: pack-redundant: rename pack_list.all_objects
Joel Teichroeb      cdca49bc4: stash: convert drop and clear to builtin
Joel Teichroeb      e1d01876a: stash: convert pop to builtin
Joel Teichroeb      f596f3366: stash: convert branch to builtin
Joel Teichroeb      f6bbd7812: stash: convert apply to builtin
Johannes Schindelin      26799a208: stash: optionally use the scripted version again
Johannes Schindelin      97f56073c: ident: add the ability to provide a "fallback identity"
Johannes Schindelin      bec65d5b7: tests: add a special setup where stash.useBuiltin is off
Josh Steadmon      6da1f1a92: protocol: advertise multiple supported versions
Josh Steadmon      e586e7df7: remote-curl: die on server-side errors
Junio C Hamano      5dde8fc6d: Merge branch 'ds/push-sparse-tree-walk' into pu
Junio C Hamano      b6b4172bf: Merge branch 'nd/the-index-final' into pu
Liam Beguin      0cce4a275: rebase -i -x: add exec commands via the rebase--helper
Linus Torvalds      acdd37769: Add 'human' date format
Martin Koegler      5efde212f: zlib.c: use size_t for size
Matthew Kraai      ed5d77f7d: stash: fix segmentation fault when files were added with intent
Nguyễn Thái Ngọc Duy      059343267: diff.c: convert --no-prefix
Nguyễn Thái Ngọc Duy      06800238c: config.c: avoid git_path() in do_git_config_sequence()
Nguyễn Thái Ngọc Duy      08339886b: parse-options: avoid magic return codes
Nguyễn Thái Ngọc Duy      08d080bf7: diff.c: convert --word-diff
Nguyễn Thái Ngọc Duy      0d6caa2d0: merge-recursive.c: remove implicit dependency on the_index
Nguyễn Thái Ngọc Duy      0eb03c4cd: diff.c: convert --stat*
Nguyễn Thái Ngọc Duy      10e07ecc0: diff.c: convert -M|--find-renames
Nguyễn Thái Ngọc Duy      150fe065f: read-cache.c: remove the_* from index_has_changes()
Nguyễn Thái Ngọc Duy      1b0d968b3: read-cache.c: replace update_index_if_able with repo_&
Nguyễn Thái Ngọc Duy      1d18d7581: notes-utils.c: remove the_repository references
Nguyễn Thái Ngọc Duy      1d2890f4f: diff.c: convert --submodule
Nguyễn Thái Ngọc Duy      1d8598834: diff.c: convert --textconv
Nguyễn Thái Ngọc Duy      1efc2689d: diff.c: convert --diff-algorithm
Nguyễn Thái Ngọc Duy      2156b1fd0: diff.c: convert --patience
Nguyễn Thái Ngọc Duy      221d67669: diff.c: convert --color-moved
Nguyễn Thái Ngọc Duy      26c50430d: range-diff: use parse_options() instead of diff_opt_parse()
Nguyễn Thái Ngọc Duy      2ec5633ff: worktree.c: add get_worktree_config()
Nguyễn Thái Ngọc Duy      350a71f2f: diff.c: convert --relative
Nguyễn Thái Ngọc Duy      3a7a698e9: sha1-name.c: remove implicit dependency on the_index
Nguyễn Thái Ngọc Duy      3a95f31d1: repository.c: replace hold_locked_index() with repo_hold_locked_index()
Nguyễn Thái Ngọc Duy      3d810d186: diff.c: convert --output-*
Nguyễn Thái Ngọc Duy      447867144: cache.h: flip NO_THE_INDEX_COMPATIBILITY_MACROS switch
Nguyễn Thái Ngọc Duy      5866e9ce9: diff.c: convert --find-object
Nguyễn Thái Ngọc Duy      58c7ef398: diff.c: convert --[no-]compact-summary
Nguyễn Thái Ngọc Duy      6643eb7bb: diff.c: convert -U|--unified
Nguyễn Thái Ngọc Duy      6c0ec4f72: diff.c: convert --line-prefix
Nguyễn Thái Ngọc Duy      6d0300b2e: diff.c: convert --binary
Nguyễn Thái Ngọc Duy      6f11fd5ed: config: add --move-to
Nguyễn Thái Ngọc Duy      7c33a67a2: diff.c: convert --color-moved-ws
Nguyễn Thái Ngọc Duy      8b70e4177: diff.c: convert --ws-error-highlight
Nguyễn Thái Ngọc Duy      8f7c7f555: config.c: add repo_config_set_worktree_gently()
Nguyễn Thái Ngọc Duy      8fc6b47cd: diff.c: convert --[no-]abbrev
Nguyễn Thái Ngọc Duy      963389f6e: diff --no-index: use parse_options() instead of diff_opt_parse()
Nguyễn Thái Ngọc Duy      97e53999c: diff.c: convert -C|--find-copies
Nguyễn Thái Ngọc Duy      9b4ae5190: parse-options: allow ll_callback with OPTION_CALLBACK
Nguyễn Thái Ngọc Duy      a12c1ff3a: config: factor out set_config_source_file()
Nguyễn Thái Ngọc Duy      afe77a4dd: diff.c: convert --word-diff-regex
Nguyễn Thái Ngọc Duy      b065b6607: diff.c: convert --anchored
Nguyễn Thái Ngọc Duy      b74a81799: diff.c: convert --diff-filter
Nguyễn Thái Ngọc Duy      b9b760ed1: diff.c: convert -B|--break-rewrites
Nguyễn Thái Ngọc Duy      c2dcec4fd: diff.c: convert --[no-]follow
Nguyễn Thái Ngọc Duy      d071ebcc8: diff.c: convert -S|-G
Nguyễn Thái Ngọc Duy      d7cf3a96e: merge-recursive.c: remove implicit dependency on the_repository
Nguyễn Thái Ngọc Duy      da9db54b3: diff.c: allow --no-color-moved-ws
Nguyễn Thái Ngọc Duy      dba093ddc: grep: use grep_opt->repo instead of explict repo argument
Nguyễn Thái Ngọc Duy      e1ff0a32e: read-cache.c: kill read_index()
Nguyễn Thái Ngọc Duy      f3b49b7f9: diff.c: convert --color-words
Nguyễn Thái Ngọc Duy      f8d10810d: diff.c: convert --dirstat and friends
Paul-Sebastian Ungureanu      0c1599c33: strbuf.c: add `strbuf_join_argv()`
Paul-Sebastian Ungureanu      168e6cff5: stash: optimize `get_untracked_files()` and `check_changes()`
Paul-Sebastian Ungureanu      1f5a011d9: stash: convert create to builtin
Paul-Sebastian Ungureanu      4e763fae8: sha1-name.c: add `get_oidf()` which acts like `get_oid()`
Paul-Sebastian Ungureanu      51809c70c: stash: convert `stash--helper.c` into `stash.c`
Paul-Sebastian Ungureanu      559edead8: stash: replace all `write-tree` child processes with API calls
Paul-Sebastian Ungureanu      847eb0b0a: stash: convert store to builtin
Paul-Sebastian Ungureanu      9a95010a1: stash: make push -q quiet
Paul-Sebastian Ungureanu      9b77b07ba: stash: convert list to builtin
Paul-Sebastian Ungureanu      b4493f269: stash: convert show to builtin
Paul-Sebastian Ungureanu      bfc3fe33f: strbuf.c: add `strbuf_insertf()` and `strbuf_vinsertf()`
Paul-Sebastian Ungureanu      cf5b27d69: stash: convert save to builtin
Paul-Sebastian Ungureanu      fa38428f7: stash: convert push to builtin
René Scharfe      878056005: sequencer: factor out strbuf_read_file_or_whine()
Stephen P. Smith      6943bd42f: Add `human` format to test-tool
Stephen P. Smith      86177eb5c: Remove the proposed use of auto as secondary way to specify human
Sun Chao      e4e2c2884: pack-redundant: new algorithm to find min packs



Uncovered code in 'jch' not in 'next'
----------------------------------------

builtin/archive.c
01f9ec64c8 builtin/archive.c  63) if (starts_with(reader.line, "NACK "))
01f9ec64c8 builtin/archive.c  64) die(_("git archive: NACK %s"), reader.line + 5);

builtin/bisect--helper.c
5e82c3dd22 builtin/bisect--helper.c 162) if (get_oid_commit(commit, &oid))
5e82c3dd22 builtin/bisect--helper.c 163) return error(_("'%s' is not a valid commit"), commit);
5e82c3dd22 builtin/bisect--helper.c 164) strbuf_addstr(&branch, commit);
5e82c3dd22 builtin/bisect--helper.c 172) strbuf_release(&branch);
5e82c3dd22 builtin/bisect--helper.c 173) argv_array_clear(&argv);
5e82c3dd22 builtin/bisect--helper.c 174) return error(_("could not check out original"
0f30233a11 builtin/bisect--helper.c 215) retval = error(_("Bad bisect_write argument: %s"), state);
0f30233a11 builtin/bisect--helper.c 216) goto finish;
0f30233a11 builtin/bisect--helper.c 220) retval = error(_("couldn't get the oid of the rev '%s'"), rev);
0f30233a11 builtin/bisect--helper.c 221) goto finish;
0f30233a11 builtin/bisect--helper.c 226) retval = -1;
0f30233a11 builtin/bisect--helper.c 227) goto finish;
0f30233a11 builtin/bisect--helper.c 232) retval = error_errno(_("couldn't open the file '%s'"), git_path_bisect_log());
0f30233a11 builtin/bisect--helper.c 233) goto finish;
129a6cf344 builtin/bisect--helper.c 329) yesno = git_prompt(_("Are you sure [Y/n]? "), PROMPT_ECHO);
129a6cf344 builtin/bisect--helper.c 330) if (starts_with(yesno, "N") || starts_with(yesno, "n"))
129a6cf344 builtin/bisect--helper.c 331) retval = -1;
129a6cf344 builtin/bisect--helper.c 332) goto finish;
129a6cf344 builtin/bisect--helper.c 338) retval = error(_(need_bisect_start_warning),
450ebb7359 builtin/bisect--helper.c 389) return error(_("invalid argument %s for 'git bisect terms'.\n"
06f5608c14 builtin/bisect--helper.c 404) return -1;
06f5608c14 builtin/bisect--helper.c 407) retval = -1;
06f5608c14 builtin/bisect--helper.c 408) goto finish;
06f5608c14 builtin/bisect--helper.c 413) retval = -1;
06f5608c14 builtin/bisect--helper.c 452) no_checkout = 1;
06f5608c14 builtin/bisect--helper.c 474)  !one_of(arg, "--term-good", "--term-bad", NULL)) {
06f5608c14 builtin/bisect--helper.c 475) return error(_("unrecognized option: '%s'"), arg);
06f5608c14 builtin/bisect--helper.c 510) if (get_oid("HEAD", &head_oid))
06f5608c14 builtin/bisect--helper.c 511) return error(_("bad HEAD - I need a HEAD"));
06f5608c14 builtin/bisect--helper.c 526) retval = error(_("checking out '%s' failed."
06f5608c14 builtin/bisect--helper.c 547) return error(_("won't bisect on cg-seek'ed tree"));
06f5608c14 builtin/bisect--helper.c 550) return error(_("bad HEAD - strange symbolic ref"));
06f5608c14 builtin/bisect--helper.c 558) return -1;
06f5608c14 builtin/bisect--helper.c 576) retval = -1;
06f5608c14 builtin/bisect--helper.c 577) goto finish;
06f5608c14 builtin/bisect--helper.c 588) retval = -1;
06f5608c14 builtin/bisect--helper.c 589) goto finish;
06f5608c14 builtin/bisect--helper.c 600) retval = -1;
5e82c3dd22 builtin/bisect--helper.c 677) return error(_("--bisect-reset requires either no argument or a commit"));
0f30233a11 builtin/bisect--helper.c 681) return error(_("--bisect-write requires either 4 or 5 arguments"));
4fbdbd5bff builtin/bisect--helper.c 687) return error(_("--check-and-set-terms requires 3 arguments"));
129a6cf344 builtin/bisect--helper.c 693) return error(_("--bisect-next-check requires 2 or 3 arguments"));

builtin/branch.c
711d28e2e4 builtin/branch.c 370) strbuf_addf(&local, "%s%%(if:notequals=*)%%(HEAD)%%(then)%%(if)%%(worktreepath)%%(then)%%(worktreepath) %%(end)%%(end)%s",
0ecb1fc726 builtin/branch.c 460) die(_("could not resolve HEAD"));
0ecb1fc726 builtin/branch.c 466) die(_("HEAD (%s) points outside of refs/heads/"), refname);

builtin/multi-pack-index.c
334e9745a6 49) die(_("--batch-size option is only for 'repack' subcommand"));

builtin/pull.c
b19eee9066 647) argv_array_push(&args, opt_cleanup);

builtin/rebase.c
21853626ea  258) write_file(state_dir_path("verbose", opts), "%s", "");
21853626ea  260) write_file(state_dir_path("strategy", opts), "%s",
21853626ea  263) write_file(state_dir_path("strategy_opts", opts), "%s",
21853626ea  270) write_file(state_dir_path("gpg_sign_opt", opts), "%s",
21853626ea  273) write_file(state_dir_path("strategy", opts), "--signoff");
c5233708c5  396) ret = -1;
c5233708c5  397) goto leave_reset_head;
c5233708c5  401) ret = error(_("could not determine HEAD revision"));
c5233708c5  402) goto leave_reset_head;
c5233708c5  423) ret = error(_("could not read index"));
c5233708c5  424) goto leave_reset_head;
c5233708c5  428) ret = error(_("failed to find tree of %s"),
c5233708c5  430) goto leave_reset_head;
c5233708c5  434) ret = error(_("failed to find tree of %s"), oid_to_hex(oid));
c5233708c5  435) goto leave_reset_head;
c5233708c5  447) ret = error(_("could not write index"));
c5233708c5  448) goto leave_reset_head;
c5233708c5  466) } else if (old_orig)
c5233708c5  467) delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
21853626ea  542) argv_array_push(&am.args, opts->gpg_sign_opt);
21853626ea  574) status = error_errno(_("could not open '%s' for writing"),
21853626ea  576) free(rebased_patches);
21853626ea  577) argv_array_clear(&am.args);
21853626ea  578) return status;
21853626ea  587) argv_array_split(&format_patch.args,
21853626ea  588)  opts->git_format_patch_opt.buf);
21853626ea  596) unlink(rebased_patches);
21853626ea  597) free(rebased_patches);
21853626ea  598) argv_array_clear(&am.args);
21853626ea  600) reset_head(&opts->orig_head, "checkout", opts->head_name, 0,
21853626ea  602) error(_("\ngit encountered an error while preparing the "
21853626ea  609) strbuf_release(&revisions);
21853626ea  610) return status;
21853626ea  616) status = error_errno(_("could not open '%s' for reading"),
21853626ea  618) free(rebased_patches);
21853626ea  619) argv_array_clear(&am.args);
21853626ea  620) return status;

builtin/receive-pack.c
01f9ec64c8 builtin/receive-pack.c 1587)     reader->line + 8);
01f9ec64c8 builtin/receive-pack.c 1621) die("protocol error: got an unexpected packet");

builtin/remote.c
f39a9c6547 builtin/remote.c 1551) die(_("--save-to-push cannot be used with other options"));
f39a9c6547 builtin/remote.c 1575) die(_("--save-to-push can only be used when only one url is defined"));

commit-graph.c
aa658574bf  127) return NULL;
aa658574bf  130) return NULL;
aa658574bf  186) free(graph);
aa658574bf  187) return NULL;
aa658574bf  222) free(graph);
aa658574bf  223) return NULL;
64415806e8  933) display_progress(oids.progress, approx_nr_objects);

config.c
7e43b32b58 1488) return git_ident_config(var, value, cb);
7e43b32b58 1491) return git_ident_config(var, value, cb);

fetch-pack.c
01f9ec64c8  154) die(_("git fetch-pack: expected a flush packet after shallow list"));
01f9ec64c8  358) die(_("invalid shallow line: %s"), reader.line);
01f9ec64c8  364) die(_("invalid unshallow line: %s"), reader.line);
01f9ec64c8  366) die(_("object not found: %s"), reader.line);
01f9ec64c8  369) die(_("error in object: %s"), reader.line);
01f9ec64c8  371) die(_("no shallow found: %s"), reader.line);
01f9ec64c8  374) die(_("expected shallow/unshallow, got %s"), reader.line);
0bbc0bc574 1128) packet_buf_write(&req_buf, "sideband-all");
0bbc0bc574 1350) reader.use_sideband = 1;
0bbc0bc574 1351) reader.me = "fetch-pack";

http-walker.c
514c5fdd03 http-walker.c 550) loose_object_path(the_repository, &buf, &req->oid);

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

midx.c
e7a330ee26  428) close_pack(packs->info[packs->nr].p);
e7a330ee26  429) FREE_AND_NULL(packs->info[packs->nr].p);
14b7185175  815) error(_("did not see pack-file %s to drop"),
14b7185175  817) drop_index++;
14b7185175  818) missing_drops++;
14b7185175  819) i--;
14b7185175  826) result = 1;
14b7185175  827) goto cleanup;
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
9133688752  369) strbuf_release(&buf);
9133688752  370) return;

pkt-line.c
0bbc0bc574 505) if (demultiplex_sideband(reader->me, reader->buffer,
0bbc0bc574 508) break;
0bbc0bc574 509) }

read-cache.c
ee70c12820 1736) if (advice_unknown_index_extension) {
ee70c12820 1737) warning(_("ignoring optional %.4s index extension"), ext);
ee70c12820 1738) advise(_("This is likely due to the file having been written by a newer\n"

ref-filter.c
a9fb549b1d  467) return 0;

remote-curl.c
01f9ec64c8  427) die("invalid server response; got '%s'", reader.line);
01f9ec64c8  439) }

send-pack.c
01f9ec64c8 143) return error(_("unable to parse remote unpack status: %s"), reader->line);
01f9ec64c8 162) error("invalid ref status from remote: %s", reader->line);
01f9ec64c8 579) receive_unpack_status(&reader);

sequencer.c
899b49c446 2394) opts->quiet = 1;

sha1-file.c
514c5fdd03 sha1-file.c 1291) status = error(_("unable to parse %s header"), oid_to_hex(oid));
00a7760e81 sha1-file.c 2305) the_hash_algo->final_fn(real_oid.hash, &c);
00a7760e81 sha1-file.c 2306) if (!oideq(expected_oid, &real_oid)) {

sideband.c
fbd76cd450 128) suffix = ANSI_SUFFIX;
fbd76cd450 138) strbuf_addf(scratch,
fbd76cd450 140)     scratch->len ? "\n" : "", me);
fbd76cd450 141) *sideband_type = SIDEBAND_PROTOCOL_ERROR;
fbd76cd450 142) goto cleanup;
0bbc0bc574 150) die("remote error: %s", buf + 1);
fbd76cd450 195) strbuf_addf(scratch, "%s%s: protocol error: bad band #%d",
fbd76cd450 196)     scratch->len ? "\n" : "", me, band);
fbd76cd450 197) *sideband_type = SIDEBAND_PROTOCOL_ERROR;
fbd76cd450 198) break;
0bbc0bc574 203) die("%s", scratch->buf);

upload-pack.c
01f9ec64c8  432) die("git upload-pack: expected SHA1 list, got '%s'", reader->line);
0bbc0bc574 1066) allow_sideband_all = git_config_bool(var, value);
07c3c2aa16 1306)      allow_sideband_all) &&
07c3c2aa16 1307)     !strcmp(arg, "sideband-all")) {
0bbc0bc574 1308) data->writer.use_sideband = 1;
0bbc0bc574 1309) continue;
bc2e795cea 1441) deepen(&data->writer, INFINITE_DEPTH, data->deepen_relative,
07c3c2aa16 1544)    &allow_sideband_all_value) &&

worktree.c
ebefff3c73 465) clear_repository_format(&format);

wrapper.c
e3b1e3bdc0 701) die_errno(_("could not stat %s"), filename);

Commits introducing uncovered code:
Ævar Arnfjörð Bjarmason      64415806e: commit-graph write: show progress for object search
Daniels Umanovskis      0ecb1fc72: branch: introduce --show-current display option
Denton Liu      b19eee906: merge: add scissors line on merge conflict
Denton Liu      f39a9c654: remote: add --save-to-push option to git remote set-url
Derrick Stolee      14b718517: multi-pack-index: implement 'expire' subcommand
Derrick Stolee      17d0bf5a7: midx: implement midx_repack()
Derrick Stolee      334e9745a: multi-pack-index: prepare 'repack' subcommand
Derrick Stolee      913368875: repack: refactor pack deletion for future use
Derrick Stolee      e7a330ee2: midx: refactor permutation logic and pack sorting
Elijah Newren      899b49c44: git-rebase, sequencer: extend --quiet option for the interactive machinery
Jeff King      00a7760e8: sha1-file: modernize loose header/stream functions
Jeff King      514c5fdd0: sha1-file: modernize loose object file functions
Johannes Schindelin      21853626e: built-in rebase: call `git am` directly
Johannes Schindelin      c5233708c: rebase: move `reset_head()` into a better spot
Jonathan Nieder      ee70c1282: index: offer advice for unknown index extensions
Jonathan Tan      07c3c2aa1: tests: define GIT_TEST_SIDEBAND_ALL
Jonathan Tan      0bbc0bc57: {fetch,upload}-pack: sideband v2 fetch response
Jonathan Tan      bc2e795ce: pkt-line: introduce struct packet_writer
Jonathan Tan      fbd76cd45: sideband: reverse its dependency on pkt-line
Josh Steadmon      aa658574b: commit-graph, fuzz: add fuzzer for commit-graph
Martin Ågren      ebefff3c7: setup: add `clear_repository_format()`
Masaya Suzuki      01f9ec64c: Use packet_reader instead of packet_read_line
Nickolai Belakovski      711d28e2e: branch: add an extra verbose output displaying worktree path for checked out branch
Nickolai Belakovski      a9fb549b1: ref-filter: add worktreepath atom
Pranit Bauva      06f5608c1: bisect--helper: `bisect_start` shell function partially in C
Pranit Bauva      0f30233a1: bisect--helper: `bisect_write` shell function in C
Pranit Bauva      129a6cf34: bisect--helper: `bisect_next_check` shell function in C
Pranit Bauva      450ebb735: bisect--helper: `get_terms` & `bisect_terms` shell function in C
Pranit Bauva      4fbdbd5bf: bisect--helper: `check_and_set_terms` shell function in C
Pranit Bauva      5e82c3dd2: bisect--helper: `bisect_reset` shell function in C
Pranit Bauva      e3b1e3bdc: wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
William Hubbs      7e43b32b5: Add author and committer configuration settings



Uncovered code in 'next' not in 'master'
--------------------------------------------

builtin/checkout.c
091e04bc8c builtin/checkout.c  302) return;
091e04bc8c builtin/checkout.c 1268) die(_("'%s' cannot be used with switching branches"),

builtin/fetch-pack.c
4316ff3068 builtin/fetch-pack.c 226) get_remote_refs(fd[1], &reader, &ref, 0, NULL, NULL);
4316ff3068 builtin/fetch-pack.c 227) break;

builtin/fetch.c
e01378753d builtin/fetch.c 1479) die(_("--filter can only be used with the remote "
e01378753d builtin/fetch.c 1648) die(_("--filter can only be used with the remote "

builtin/rebase.c
81ef8ee75d  773) return -1;
d421afa0c6 1258) die(_("--reschedule-failed-exec requires an interactive rebase"));
d421afa0c6 1296) die(_("error: cannot combine '--preserve-merges' with "

diff.c
b73bcbac4a  308) ret = 0;
21536d077f  812)        (s[off] == '\r' && off < len - 1))
21536d077f  813) off++;
b73bcbac4a 5112) options->color_moved_ws_handling = 0;

entry.c
hex.c
47edb64997  93) char *sha1_to_hex_r(char *buffer, const unsigned char *sha1)
47edb64997  95) return hash_to_hex_algop_r(buffer, sha1, &hash_algos[GIT_HASH_SHA1]);
47edb64997 116) char *hash_to_hex(const unsigned char *hash)
47edb64997 118) return hash_to_hex_algop(hash, the_hash_algo);

http-push.c
ea82b2a085 1314) p = process_tree(lookup_tree(the_repository, &entry.oid),

http.c
e6cf87b12d 1999) if (fflush(result)) {
e6cf87b12d 2000) error_errno("unable to flush a file");
e6cf87b12d 2001) return HTTP_START_FAILED;
e6cf87b12d 2003) rewind(result);
e6cf87b12d 2004) if (ftruncate(fileno(result), 0) < 0) {
e6cf87b12d 2005) error_errno("unable to truncate a file");
e6cf87b12d 2006) return HTTP_START_FAILED;
e6cf87b12d 2008) break;

list-objects-filter.c
c813a7c35f 199) return;

match-trees.c
f55ac4311a 231) hashcpy(tree_oid.hash, rewrite_here);
f55ac4311a 232) status = splice_tree(&tree_oid, subpath, oid2, &subtree);

pretty.c
ad6f028f06 1204) return 0;

remote-curl.c
b79bdd8c12  566) return size;

sha1-file.c
2f90b9d9b4 sha1-file.c  172) int hash_algo_by_name(const char *name)
2f90b9d9b4 sha1-file.c  175) if (!name)
2f90b9d9b4 sha1-file.c  176) return GIT_HASH_UNKNOWN;
2f90b9d9b4 sha1-file.c  177) for (i = 1; i < GIT_HASH_NALGOS; i++)
2f90b9d9b4 sha1-file.c  178) if (!strcmp(name, hash_algos[i].name))
2f90b9d9b4 sha1-file.c  179) return i;
2f90b9d9b4 sha1-file.c  180) return GIT_HASH_UNKNOWN;
2f90b9d9b4 sha1-file.c  183) int hash_algo_by_id(uint32_t format_id)
2f90b9d9b4 sha1-file.c  186) for (i = 1; i < GIT_HASH_NALGOS; i++)
2f90b9d9b4 sha1-file.c  187) if (format_id == hash_algos[i].format_id)
2f90b9d9b4 sha1-file.c  188) return i;
2f90b9d9b4 sha1-file.c  189) return GIT_HASH_UNKNOWN;

submodule.c
26f80ccfc1 1398) strbuf_release(&gitdir);
be76c21282 1521) struct fetch_task *task = task_cb;
be76c21282 1525) fetch_task_release(task);

tree-walk.c
0a3faa45b1  530) oidcpy(result, &oid);

tree.c
60c38b9e4a 104) commit = lookup_commit(r, &entry.oid);

upload-pack.c
87c2d9d310  147) sq_quote_buf(&buf, expanded_filter_spec.buf);

Commits introducing uncovered code:
brian m. carlson      0a3faa45b: tree-walk: copy object ID before use
brian m. carlson      2f90b9d9b: sha1-file: provide functions to look up hash algorithms
brian m. carlson      47edb6499: hex: introduce functions to print arbitrary hashes
brian m. carlson      ea82b2a08: tree-walk: store object_id in a separate member
brian m. carlson      f55ac4311: match-trees: use hashcpy to splice trees
Christian Couder      e01378753: fetch: fix extensions.partialclone name in error message
Issac Trotts      ad6f028f0: log: add %S option (like --source) to log --format
Johannes Schindelin      81ef8ee75: rebase: introduce a shortcut for --reschedule-failed-exec
Johannes Schindelin      d421afa0c: rebase: introduce --reschedule-failed-exec
Jonathan Tan      4316ff306: fetch-pack: support protocol version 2
Josh Steadmon      87c2d9d31: filter-options: expand scaled numbers
Junio C Hamano      60c38b9e4: Merge branch 'bc/tree-walk-oid' into next
Masaya Suzuki      b79bdd8c1: remote-curl: unset CURLOPT_FAILONERROR
Masaya Suzuki      e6cf87b12: http: enable keep_error for HTTP requests
Matthew DeVore      c813a7c35: list-objects-filter: teach tree:# how to handle >0
Phillip Wood      21536d077: diff --color-moved-ws: modify allow-indentation-change
Phillip Wood      b73bcbac4: diff: allow --no-color-moved-ws
Stefan Beller      26f80ccfc: submodule: migrate get_next_submodule to use repository structs
Stefan Beller      be76c2128: fetch: ensure submodule objects fetched
Thomas Gummerer      091e04bc8: checkout: introduce --{,no-}overlay option



Uncovered code in 'master' not in 'master@{1}'
----------------------------------------------------

builtin/submodule--helper.c
builtin/worktree.c
00a6d4d1d2 752) found_submodules = 1;
00a6d4d1d2 753) break;

commit-graph.c
ref-filter.c
1867ce6cbe  236) oi_deref.info.sizep = &oi_deref.size;
1867ce6cbe  245) return strbuf_addf_ret(err, -1, _("unrecognized %%(objectsize) argument: %s"), arg);
33311fa1ad  253) return strbuf_addf_ret(err, -1, _("%%(deltabase) does not take arguments"));

setup.c
07098b81a4 1093) if (!nongit_ok)
07098b81a4 1094) die(_("not a git repository (or any parent up to mount point %s)\n"
07098b81a4 1097) *nongit_ok = 1;
07098b81a4 1098) break;

transport-helper.c
3b3357626e 1029) static int has_attribute(const char *attrs, const char *attr)

Commits introducing uncovered code:
Erin Dahlgren      07098b81a: Simplify handling of setup_git_directory_gently() failure cases.
Nguyễn Thái Ngọc Duy      00a6d4d1d: worktree: allow to (re)move worktrees with uninitialized submodules
Nguyễn Thái Ngọc Duy      3b3357626: style: the opening '{' of a function is in a separate line
Olga Telezhnaya      1867ce6cb: ref-filter: add objectsize:disk option
Olga Telezhnaya      33311fa1a: ref-filter: add deltabase option
