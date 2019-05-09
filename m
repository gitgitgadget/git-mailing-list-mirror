Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 604331F488
	for <e@80x24.org>; Thu,  9 May 2019 12:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfEIMIo (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 08:08:44 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34861 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfEIMIo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 08:08:44 -0400
Received: by mail-qk1-f196.google.com with SMTP id c15so1272187qkl.2
        for <git@vger.kernel.org>; Thu, 09 May 2019 05:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=/P+8A5ma+TomEnItsia7cvTSn1+b3uWWqNHqHoe4CZk=;
        b=MFL6vESL6JJBUqTJolEFgaVV0H+p8r2ZtkggzI50SFIiKz97OXGe+uAbU4xfA1dJyZ
         v0k7zgRB4kBQtQ7irvjvZwlXxt0nMxABCwo0aGfpqNzIr+S2x4lVocDLiAt7T3HejO48
         4wa6UcGteCrVS7Vm7XZ4ud+DpaeZvRoJnOQ801nGpsKYRVDsguJwZ4pKj4Gga09gFPwv
         fTzAP7Y3m5Qf8CINEV0S3xaS7EDw5MC30Dmx0qwW0iu2YRG3QBFd9D6fkDYG3MDTSGSC
         4IcSxhB/xBUrB33vnbsIiLJgJg8oXm90KXvS6GUkxlFmK76kKJWOjmfmbLHHKDtiIT6b
         of4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=/P+8A5ma+TomEnItsia7cvTSn1+b3uWWqNHqHoe4CZk=;
        b=ChpV+nkaguPSMMzupa0Gczq5m7wVGpXFuSpbIG5QSA5+czwFLDIEWQFBerOHYQsxCz
         Qwspkm58mL5M8HUohPDzaKvnAFWDGYn/qYOLQZscqVFxZQ0ltMdOM0fUj3hFFG0rzlRZ
         PCG4NO1wgcfEkWQbmJQCET7tUdV845ckhenCqmpRG8IHgUVIQzqKCZKXGmYjImlaSIJL
         GOQAcEoD33d1hW3XpRdOeDjfDYHn28uKOyVm2ExCx50VTjQP31RhKp/TScs+6Nz3SgS9
         Az8iJ19csIELhgTpDhedUu7X5p23SzkeoaZodxXdL4HoEIN7nrauJCC+9DLOChAJODVs
         8+wA==
X-Gm-Message-State: APjAAAX+BNgKw1zdXjzCMSYXTkjIVz7C4d/IGqroTEPPI/LJXUEF9v+x
        +CikogS83UI9zGGQ4qwL/SOdsMyFRgQ=
X-Google-Smtp-Source: APXvYqx1WR4uNju0cLGv9ngLUNd6cMCak6YuEDd545SQIy8IizJ+0UKnDvrgDos2jcXuCRG70sCXqQ==
X-Received: by 2002:ae9:ec07:: with SMTP id h7mr3008813qkg.7.1557403722187;
        Thu, 09 May 2019 05:08:42 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:d14c:17a3:d28e:9336? ([2001:4898:8010:0:ba82:17a3:d28e:9336])
        by smtp.gmail.com with ESMTPSA id m62sm857038qkd.68.2019.05.09.05.08.41
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 05:08:41 -0700 (PDT)
To:     Git List <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (May 9)
Message-ID: <4d2476a6-1f3b-d05c-46fd-9d9056d8d1f6@gmail.com>
Date:   Thu, 9 May 2019 08:08:41 -0400
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

Here is today's test coverage report. You can view it in HTML [1] or in
plain-text [2].

Thanks,
-Stolee

[1] https://derrickstolee.github.io/git-test-coverage/reports/2019-05-09.htm
[2] https://derrickstolee.github.io/git-test-coverage/reports/2019-05-09.txt

---

pu	ec7b02a06325d60f87d37617fec3070e707db307
jch	87aec2b5eae506b830875f703f7348513e20d346
next	81c186ecd2768836c2dc37eefd32d2e2a5e6dfb5
master	6a6c0f10a70a6eb101c213b09ae82a9cad252743
master@{1}	83232e38648b51abbcbdb56c94632b6906cc85a6


Uncovered code in 'pu' not in 'jch'
--------------------------------------------------------

blame.c
d0738d94 618)     ent->ignored == next->ignored &&
a5c91678 619)     ent->unblamable == next->unblamable) {

builtin/blame.c
a5c91678 493) memset(hex, '0', length);

builtin/cat-file.c

builtin/commit.c

builtin/fast-export.c
67bfce6c 81) static int parse_opt_reencode_mode(const struct option *opt,
67bfce6c 84) if (unset || !strcmp(arg, "abort"))
67bfce6c 85) reencode_mode = REENCODE_ABORT;
67bfce6c 86) else if (!strcmp(arg, "yes"))
67bfce6c 87) reencode_mode = REENCODE_PLEASE;
67bfce6c 88) else if (!strcmp(arg, "no"))
67bfce6c 89) reencode_mode = REENCODE_NEVER;
67bfce6c 91) return error("Unknown reencoding mode: %s", arg);
67bfce6c 92) return 0;
67bfce6c 654) switch(reencode_mode) {
67bfce6c 656) reencoded = reencode_string(message, "UTF-8", encoding);
67bfce6c 657) break;
67bfce6c 659) break;
67bfce6c 661) die("Encountered commit-specific encoding %s in commit "
67bfce6c 663)     encoding, oid_to_hex(&commit->object.oid));
1c493913 675) printf("encoding %s\n", encoding);

builtin/fetch-pack.c

builtin/gc.c
5ff7cad9 693) return 1;

builtin/merge.c
a87e56a4 1290) usage_msg_opt(_("--quit expects no arguments"),

builtin/pack-objects.c

commit-graph.c
0be0712d 935) error(_("unsupported commit-graph version %d"),
0be0712d 937) return 1;
5ff7cad9 987) error(_("error adding pack %s"), packname.buf);
5ff7cad9 988) res = 1;
5ff7cad9 989) goto cleanup;
5ff7cad9 992) error(_("error opening index for %s"), packname.buf);
5ff7cad9 993) res = 1;
5ff7cad9 994) goto cleanup;
5ff7cad9 1067) error(_("the commit graph format cannot write %d commits"), count_distinct);
5ff7cad9 1068) res = 1;
5ff7cad9 1069) goto cleanup;
5ff7cad9 1103) error(_("too many commits to write graph"));
5ff7cad9 1104) res = 1;
5ff7cad9 1105) goto cleanup;
5ff7cad9 1113) error(_("unable to create leading directories of %s"),
5ff7cad9 1115) res = errno;
5ff7cad9 1116) goto cleanup;

fast-import.c
23495a3d 2612) read_next_command();
23495a3d 2679) strbuf_addf(&new_data,

fetch-pack.c

http-fetch.c

http.c
9f7a3592 2302) target ? hash_to_hex(target->hash) : base_url,

oidset.c

promisor-remote.c
0ba08c05 25) die(_("Remote with no URL"));
54248706 61) warning(_("promisor remote name cannot begin with '/': %s"),
54248706 63) return NULL;
7bdf0926 93) previous->next = r->next;
7b6e1b04 108) return git_config_string(&core_partial_clone_filter_default,
b21a55f3 139) return 0;
dcc8b4e9 202) static int remove_fetched_oids(struct object_id **oids, int oid_nr, int to_free)
dcc8b4e9 204) int i, missing_nr = 0;
dcc8b4e9 205) int *missing = xcalloc(oid_nr, sizeof(*missing));
dcc8b4e9 206) struct object_id *old_oids = *oids;
dcc8b4e9 208) int old_fetch_if_missing = fetch_if_missing;
dcc8b4e9 210) fetch_if_missing = 0;
dcc8b4e9 212) for (i = 0; i < oid_nr; i++)
dcc8b4e9 213) if (oid_object_info_extended(the_repository, &old_oids[i], NULL, 0)) {
dcc8b4e9 214) missing[i] = 1;
dcc8b4e9 215) missing_nr++;
dcc8b4e9 218) fetch_if_missing = old_fetch_if_missing;
dcc8b4e9 220) if (missing_nr) {
dcc8b4e9 221) int j = 0;
dcc8b4e9 222) new_oids = xcalloc(missing_nr, sizeof(*new_oids));
dcc8b4e9 223) for (i = 0; i < oid_nr; i++)
dcc8b4e9 224) if (missing[i])
dcc8b4e9 225) oidcpy(&new_oids[j++], &old_oids[i]);
dcc8b4e9 226) *oids = new_oids;
dcc8b4e9 227) if (to_free)
dcc8b4e9 228) free(old_oids);
dcc8b4e9 231) free(missing);
dcc8b4e9 233) return missing_nr;
dcc8b4e9 248) if (missing_nr == 1)
dcc8b4e9 249) continue;
dcc8b4e9 250) missing_nr = remove_fetched_oids(&missing_oids, missing_nr, to_free);
dcc8b4e9 251) if (missing_nr) {
dcc8b4e9 252) to_free = 1;
dcc8b4e9 253) continue;
dcc8b4e9 261) free(missing_oids);

protocol.c

ref-filter.c
2582083f 93) keydata_aka_refname ? keydata_aka_refname : k->wt->head_ref);

remote-curl.c

t/helper/test-read-cache.c
dc76852d 29) die("%s not in index", name);

upload-pack.c
a8d662e3 130) return readsz;
820a5361 149) BUG("packfile_uris requires sideband-all");
a8d662e3 355) send_client_data(1, output_state.buffer, output_state.used);
820a5361 1386) string_list_clear(&data->uri_protocols, 0);

wrapper.c

Commits introducting uncovered code:
Barret Rhoden	d0738d94 blame: add config options to handle output for ignored lines
Barret Rhoden	a5c91678 blame: add the ability to ignore commits and their changes
Christian Couder	dcc8b4e9 promisor-remote: implement promisor_remote_get_direct()
Christian Couder	b21a55f3 promisor-remote: parse remote.*.partialclonefilter
Christian Couder	7bdf0926 promisor-remote: use repository_format_partial_clone
Christian Couder	54248706 Add initial support for many promisor remotes
Christian Couder	7b6e1b04 Move core_partial_clone_filter_default to promisor-remote.c
Christian Couder	0ba08c05 Remove fetch-object.{c,h} in favor of promisor-remote.{c,h}
Derrick Stolee	0be0712d commit-graph: create new version parameter
Derrick Stolee	5ff7cad9 commit-graph: return with errors during write
Elijah Newren	23495a3d fast-import: support 'encoding' commit header
Elijah Newren	1c493913 fast-export: avoid stripping encoding header if we cannot reencode
Elijah Newren	67bfce6c fast-export: do automatic reencoding of commit messages only if requested
Johannes Schindelin	dc76852d fsmonitor: demonstrate that it is not refreshed after discard_index()
Jonathan Tan	a8d662e3 upload-pack: refactor reading of pack-objects out
Jonathan Tan	820a5361 upload-pack: send part of packfile response as uri
Junio C Hamano	9f7a3592 Merge branch 'jt/fetch-cdn-offload' into pu
Nguyễn Thái Ngọc Duy	a87e56a4 merge: add --quit
Nickolai Belakovski	2582083f ref-filter: add worktreepath atom


Uncovered code in 'jch' not in 'next'
--------------------------------------------------------

attr.c

builtin/checkout.c

builtin/multi-pack-index.c

builtin/rebase.c
526c03b5 1274) goto done;
10572de1 1290) goto done;

builtin/remote.c
f39a9c65 1551) die(_("--save-to-push cannot be used with other options"));
f39a9c65 1575) die(_("--save-to-push can only be used when only one url is defined"));

builtin/worktree.c
722abec7 297) BUG("How come '%s' becomes empty after sanitization?", sb.buf);

http.c
5c3d5a38 2329) return posn / eltsize;

midx.c
5bf52fbc 464) close_pack(packs->info[packs->nr].p);
5bf52fbc 465) FREE_AND_NULL(packs->info[packs->nr].p);
3c9e7185 724) BUG("object %s is in an expired pack with int-id %d",
3c9e7185 851) error(_("did not see pack-file %s to drop"),
3c9e7185 853) drop_index++;
3c9e7185 854) missing_drops++;
3c9e7185 855) i--;
3c9e7185 862) result = 1;
3c9e7185 863) goto cleanup;
3c9e7185 1180) return 0;
3c9e7185 1195) continue;
ab08c40a 1235) return 0;
3dfbc2f0 1261) continue;
3dfbc2f0 1281) continue;
3dfbc2f0 1283) continue;
3dfbc2f0 1315) return 0;
3dfbc2f0 1336) error(_("could not start pack-objects"));
3dfbc2f0 1337) result = 1;
3dfbc2f0 1338) goto cleanup;
3dfbc2f0 1355) error(_("could not finish pack-objects"));
3dfbc2f0 1356) result = 1;
3dfbc2f0 1357) goto cleanup;

packfile.c
91336887 369) strbuf_release(&buf);
91336887 370) return;

parse-options.c
5c387428 282) return 0;
5c387428 481) BUG("OPT_ALIAS() should not remain at this point. "
5c387428 661) BUG("An alias must have long option name");
5c387428 670) BUG("No please. Nested aliases are not supported.");
5c387428 685) BUG("could not find source option '%s' of alias '%s'",

read-cache.c
ee70c128 1723) if (advice_unknown_index_extension) {
ee70c128 1724) warning(_("ignoring optional %.4s index extension"), ext);
ee70c128 1725) advise(_("This is likely due to the file having been written by a newer\n"

refs.c
722abec7 111) sanitized->buf[sanitized->len-1] = '-';
722abec7 170) if (sanitized)
722abec7 171) strbuf_addch(sanitized, '-');
722abec7 173) return -1;
722abec7 178) strbuf_complete(sanitized, '/');
722abec7 215) BUG("sanitizing refname '%s' check returned error", refname);

upload-pack.c
8e712ef6 1073) precomposed_unicode = git_config_bool(var, value);

Commits introducting uncovered code:
Denton Liu	526c03b5 rebase: refactor can_fast_forward into goto tower
Denton Liu	10572de1 rebase: fast-forward --onto in more cases
Denton Liu	f39a9c65 remote: add --save-to-push option to git remote set-url
Derrick Stolee	91336887 repack: refactor pack deletion for future use
Derrick Stolee	5bf52fbc midx: refactor permutation logic and pack sorting
Derrick Stolee	3c9e7185 multi-pack-index: implement 'expire' subcommand
Derrick Stolee	ab08c40a multi-pack-index: prepare 'repack' subcommand
Derrick Stolee	3dfbc2f0 midx: implement midx_repack()
Elijah Newren	8e712ef6 Honor core.precomposeUnicode in more places
Jonathan Nieder	ee70c128 index: offer advice for unknown index extensions
Mike Hommey	5c3d5a38 Make fread/fwrite-like functions in http.c more like fread/fwrite.
Nguyễn Thái Ngọc Duy	5c387428 parse-options: don't emit "ambiguous option" for aliases
Nguyễn Thái Ngọc Duy	722abec7 worktree add: sanitize worktree names


Uncovered code in 'next' not in 'master'
--------------------------------------------------------

builtin/rebase.c
0609b741 146) static int add_exec_commands(struct string_list *commands)
0609b741 148) const char *todo_file = rebase_path_todo();
0609b741 149) struct todo_list todo_list = TODO_LIST_INIT;
0609b741 152) if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
0609b741 153) return error_errno(_("could not read '%s'."), todo_file);
0609b741 155) if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
0609b741 157) todo_list_release(&todo_list);
0609b741 158) return error(_("unusable todo list: '%s'"), todo_file);
0609b741 161) todo_list_add_exec_commands(&todo_list, commands);
0609b741 162) res = todo_list_write_to_file(the_repository, &todo_list,
0609b741 164) todo_list_release(&todo_list);
0609b741 166) if (res)
0609b741 167) return error_errno(_("could not write '%s'."), todo_file);
0609b741 168) return 0;
0609b741 171) static int rearrange_squash_in_todo_file(void)
0609b741 173) const char *todo_file = rebase_path_todo();
0609b741 174) struct todo_list todo_list = TODO_LIST_INIT;
0609b741 175) int res = 0;
0609b741 177) if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
0609b741 178) return error_errno(_("could not read '%s'."), todo_file);
0609b741 179) if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
0609b741 181) todo_list_release(&todo_list);
0609b741 182) return error(_("unusable todo list: '%s'"), todo_file);
0609b741 185) res = todo_list_rearrange_squash(&todo_list);
0609b741 186) if (!res)
0609b741 187) res = todo_list_write_to_file(the_repository, &todo_list,
0609b741 190) todo_list_release(&todo_list);
0609b741 192) if (res)
0609b741 193) return error_errno(_("could not write '%s'."), todo_file);
0609b741 194) return 0;
0609b741 204) return error_errno(_("could not read '%s'."), todo_file);
0609b741 208) todo_list_release(&todo_list);
0609b741 209) return error(_("unusable todo list: '%s'"), todo_file);
0609b741 217) return error_errno(_("could not write '%s'."), todo_file);
0609b741 229) return error_errno(_("could not read '%s'."), todo_file);
0609b741 235) res = error_errno(_("could not write '%s'"), todo_file);
0609b741 252) return error(_("no HEAD?"));
c44c2462 279) return error_errno(_("could not create temporary %s"), merge_dir());
0609b741 285) return error_errno(_("could not mark as interactive"));
0609b741 314) return -1;
0609b741 318) return -1;
0609b741 323) free(revisions);
0609b741 324) free(shortrevisions);
0609b741 326) return -1;
7d3488eb 335) argv_array_push(&make_script_args,
0ea0847e 336) oid_to_hex(&opts->restrict_revision->object.oid));
0609b741 343) error(_("could not generate todo list"));
0609b741 348) BUG("unusable todo list");
460bc3ce 382) die(_("a base commit must be provided with --upstream or --onto"));
460bc3ce 419) ret = rearrange_squash_in_todo_file();
460bc3ce 420) break;
460bc3ce 422) struct string_list commands = STRING_LIST_INIT_DUP;
460bc3ce 424) split_exec_commands(opts->cmd, &commands);
460bc3ce 425) ret = add_exec_commands(&commands);
460bc3ce 426) string_list_clear(&commands, 0);
460bc3ce 427) break;
460bc3ce 430) BUG("invalid command '%d'", command);
0609b741 509) usage_with_options(builtin_rebase_interactive_usage, options);
73fdc535 515) opts.squash_onto = &squash_onto;
0609b741 518) warning(_("--[no-]rebase-cousins has no effect without "

parse-options-cb.c
7d3488eb 99) int parse_opt_commit(const struct option *opt, const char *arg, int unset)
7d3488eb 103) struct commit **target = opt->value;
7d3488eb 105) if (!arg)
7d3488eb 106) return -1;
7d3488eb 107) if (get_oid(arg, &oid))
7d3488eb 108) return error("malformed object name %s", arg);
7d3488eb 109) commit = lookup_commit_reference(the_repository, &oid);
7d3488eb 110) if (!commit)
7d3488eb 111) return error("no such commit %s", arg);
7d3488eb 112) *target = commit;
7d3488eb 113) return 0;
33898531 132) int parse_opt_object_id(const struct option *opt, const char *arg, int unset)
33898531 135) struct object_id *target = opt->value;
33898531 137) if (unset) {
33898531 138) *target = null_oid;
33898531 139) return 0;
33898531 141) if (!arg)
33898531 142) return -1;
33898531 143) if (get_oid(arg, &oid))
33898531 144) return error(_("malformed object name '%s'"), arg);
33898531 145) *target = oid;
33898531 146) return 0;

sequencer.c
4a72486d 2184) return error_errno("unable to open '%s'", todo_file);
4a72486d 2188) eol--; /* strip Carriage Return */
4a72486d 2190) goto fail;
4a72486d 2196) goto fail;
b07d9bfd 2300) error_errno("unable to open '%s'", todo_path);
b07d9bfd 2301) return 0;

trace2.c
a0897249 448) tr2tls_create_self(thread_name, us_now);
22a73383 737) if (tgt_j->pfn_data_json_fl)

trace2/tr2_dst.c
bce9db6d 16) const char *env_value = tr2_sysenv_get(TR2_SYSENV_DST_DEBUG);
a5c08f12 69) strerror(errno));
bce9db6d 93) strerror(errno));
bce9db6d 303) warning("unable to write trace to '%s': %s",

trace2/tr2_sid.c
08881b9a 44) strbuf_add(&tr2sid_buf, "Localhost", 9);

trace2/tr2_sysenv.c
bce9db6d 70) return 0;
bce9db6d 95) BUG("tr2_sysenv_get invalid var '%d'", var);
bce9db6d 113) const char *tr2_sysenv_display_name(enum tr2_sysenv_variable var)
bce9db6d 115) if (var >= TR2_SYSENV_MUST_BE_LAST)
bce9db6d 116) BUG("tr2_sysenv_get invalid var '%d'", var);
bce9db6d 118) return tr2_sysenv_settings[var].env_var_name;

trace2/tr2_tgt_event.c
bce9db6d 56) tr2env_event_max_nesting_levels = max_nesting;
bce9db6d 61) tr2env_event_be_brief = want_brief;
bce9db6d 542) if (ctx->nr_open_regions <= tr2env_event_max_nesting_levels) {

Commits introducting uncovered code:
Jeff Hostetler	a0897249 trace2: refactor setting process starting time
Jeff Hostetler	bce9db6d trace2: use system/global config for default trace2 settings
Jeff Hostetler	08881b9a trace2: make SIDs more unique
Josh Steadmon	22a73383 trace2: fix incorrect function pointer check
Junio C Hamano	a5c08f12 Merge branch 'jh/trace2-sid-fix' into next
Phillip Wood	0609b741 rebase -i: combine rebase--interactive.c with rebase.c
Phillip Wood	c44c2462 rebase -i: remove duplication
Phillip Wood	7d3488eb rebase -i: use struct commit when parsing options
Phillip Wood	0ea0847e rebase -i: use struct rebase_options in do_interactive_rebase()
Phillip Wood	460bc3ce rebase -i: run without forking rebase--interactive
Phillip Wood	73fdc535 rebase -i: use struct rebase_options to parse args
Phillip Wood	33898531 rebase -i: use struct object_id for squash_onto
Phillip Wood	4a72486d fix cherry-pick/revert status after commit
Phillip Wood	b07d9bfd commit/reset: try to clean up sequencer state


Uncovered code in 'master' not in 'master@{1}'
--------------------------------------------------------

builtin/pull.c
d540b70c 652) argv_array_pushf(&args, "--cleanup=%s", cleanup_arg);

builtin/replace.c
f8e44a81 383) return error(_("could not parse %s as a commit"), argv[i]);
ee521ec4 490) return error(_("new commit is the same as the old one: '%s'"),

builtin/show-branch.c
7fdff474 756) read_ref_at(get_main_ref_store(the_repository),
7fdff474 769) if (read_ref_at(get_main_ref_store(the_repository),

builtin/tag.c
01dc801a 226) die(_("bad object type."));

dir.c
0488481e 2322) BUG("do not know how to check file existence in arbitrary repo");

merge-recursive.c
259ccb6c 322) strbuf_addstr(&opt->obuf, _("(bad commit)\n"));
259ccb6c 345) return err(opt, _("add_cacheinfo failed for path '%s'; merge aborting."), path);
259ccb6c 354) return err(opt, _("add_cacheinfo failed to refresh for path '%s'; merge aborting."), path);
259ccb6c 437) err(opt, _("error building trees"));
259ccb6c 692) ce = index_file_exists(opt->repo->index, path, strlen(path),
259ccb6c 886) return err(opt, msg, path, _(": perhaps a D/F conflict?"));
259ccb6c 887) return err(opt, msg, path, "");
8daec1df 936) return err(opt, _("cannot read object %s '%s'"),
8daec1df 939) ret = err(opt, _("blob expected for %s '%s'"),
259ccb6c 963) ret = err(opt, _("failed to open '%s': %s"),
259ccb6c 974) ret = err(opt, _("failed to symlink '%s': %s"),
259ccb6c 978) ret = err(opt,
8daec1df 980)   contents->mode, oid_to_hex(&contents->oid), path);
259ccb6c 1182) output(opt, 1, _("Failed to merge submodule %s (commits not present)"), path);
259ccb6c 1199) } else if (show(opt, 2))
259ccb6c 1200) output(opt, 2, _("Fast-forwarding submodule %s"), path);
259ccb6c 1208) if (show(opt, 3)) {
259ccb6c 1209) output(opt, 3, _("Fast-forwarding submodule %s to the following commit:"), path);
259ccb6c 1210) output_commit_title(opt, commit_a);
259ccb6c 1211) } else if (show(opt, 2))
259ccb6c 1212) output(opt, 2, _("Fast-forwarding submodule %s"), path);
e3de888c 1277) return merge_mode_and_contents(opt, o, b, a,
259ccb6c 1325) ret = err(opt, _("Failed to execute internal merge"));
259ccb6c 1330) ret = err(opt, _("Unable to add %s to database"),
79c47598 1397) return -1;
8c8e5bd6 1408) return -1;
8daec1df 1746) if (update_file(opt, 0, add, a->path))
8daec1df 1753) if (update_file(opt, 0, add, b->path))
259ccb6c 2929) return err(opt, _("cannot read object %s"), oid_to_hex(oid));
259ccb6c 2932) return err(opt, _("object %s is not a blob"), oid_to_hex(oid));
259ccb6c 3068) remove_file_from_index(opt->repo->index, path);
8c8e5bd6 3122) return -1;
8c8e5bd6 3184) BUG("Impossible dir_rename_original_type/clean combination");
8daec1df 3362) } else if (!o_valid && !a_valid && !b_valid) {
8daec1df 3367) remove_file(opt, 1, path, !a->mode);
259ccb6c 3462) unpack_trees_finish(opt);
259ccb6c 3556) return err(opt, _("merge returned no commit"));
259ccb6c 3622) return err(opt, _("Could not parse object '%s'"),
259ccb6c 3638) return err(opt, _("Unable to write index."));
8c8e5bd6 3661) } else if (!strcasecmp(value, "conflict")) {
8c8e5bd6 3662) opt->detect_directory_renames = 1;
259ccb6c 3704) opt->subtree_shift = "";
259ccb6c 3708) opt->xdl_opts = DIFF_WITH_ALG(opt, PATIENCE_DIFF);
259ccb6c 3710) opt->xdl_opts = DIFF_WITH_ALG(opt, HISTOGRAM_DIFF);
259ccb6c 3716) DIFF_XDL_CLR(opt, NEED_MINIMAL);
259ccb6c 3717) opt->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
259ccb6c 3718) opt->xdl_opts |= value;
259ccb6c 3727) DIFF_XDL_SET(opt, IGNORE_CR_AT_EOL);
259ccb6c 3729) opt->renormalize = 1;
259ccb6c 3731) opt->renormalize = 0;

refs.c
56700903 630)  refs_reflog_exists(refs, ref))

remote.c
c646d093 1925) BUG("stat_branch_pair: invalid abf '%d'", abf);

sequencer.c
d74f3e58 176) opts->explicit_cleanup = 1;
d74f3e58 179) opts->explicit_cleanup = 1;
dc42e9a8 542) static const char *describe_cleanup_mode(int cleanup_mode)
dc42e9a8 549) if (cleanup_mode < ARRAY_SIZE(modes))
dc42e9a8 550) return modes[cleanup_mode];
dc42e9a8 552) BUG("invalid cleanup_mode provided (%d)", cleanup_mode);
dc42e9a8 2369) else if (!strcmp(key, "options.default-msg-cleanup")) {
dc42e9a8 2370) opts->explicit_cleanup = 1;
dc42e9a8 2371) opts->default_msg_cleanup = get_cleanup_mode(value, 1);
dc42e9a8 2796) res |= git_config_set_in_file_gently(opts_file,
dc42e9a8 2798) describe_cleanup_mode(opts->default_msg_cleanup));

sha1-name.c
c931ba4e 1219) object = deref_tag(cb->repo, object, path,
0daf7ff6 1387) BUG("sorry get_merge_bases() can't take struct repository yet");

t/helper/test-tool.c
6ea18fff 101) die("Could not cd to '%s'", working_directory);

trace2/tr2_dst.c
a4d3a283 55) sid = last_slash + 1;
a4d3a283 65) strbuf_setlen(&path, base_path_len);
a4d3a283 66) strbuf_addf(&path, ".%d", attempt_count);
a4d3a283 75) if (tr2_dst_want_warning())
a4d3a283 76) warning("trace2: could not open '%.*s' for '%s' tracing: %s",
a4d3a283 78) dst->env_var_name, strerror(errno));
a4d3a283 80) tr2_dst_trace_disable(dst);
a4d3a283 81) strbuf_release(&path);
a4d3a283 82) return 0;

Commits introducting uncovered code:
Christian Couder	f8e44a81 replace: peel tag when passing a tag as parent to --graft
Christian Couder	ee521ec4 replace: peel tag when passing a tag first to --graft
Damien Robert	c646d093 ref-filter: use correct branch for %(push:track)
Denton Liu	d540b70c merge: cleanup messages like commit
Denton Liu	01dc801a tag: fix formatting
Elijah Newren	8c8e5bd6 merge-recursive: switch directory rename detection default
Elijah Newren	e3de888c merge-recursive: rename diff_filespec 'one' to 'o'
Elijah Newren	79c47598 merge-recursive: avoid clobbering untracked files with directory renames
Elijah Newren	259ccb6c merge-recursive: rename merge_options argument from 'o' to 'opt'
Elijah Newren	8daec1df merge-recursive: switch from (oid,mode) pairs to a diff_filespec
Johannes Schindelin	6ea18fff test-tool: handle the `-C <directory>` option just like `git`
Josh Steadmon	a4d3a283 trace2: write to directory targets
Nguyễn Thái Ngọc Duy	0488481e sha1-name.c: remove the_repo from diagnose_invalid_index_path()
Nguyễn Thái Ngọc Duy	56700903 refs.c: add repo_dwim_log()
Nguyễn Thái Ngọc Duy	7fdff474 refs.c: remove the_repo from read_ref_at()
Nguyễn Thái Ngọc Duy	c931ba4e sha1-name.c: remove the_repo from handle_one_ref()
Nguyễn Thái Ngọc Duy	0daf7ff6 sha1-name.c: remove the_repo from get_oid_mb()
Phillip Wood	d74f3e58 sequencer: fix cleanup with --signoff and -x
Phillip Wood	dc42e9a8 sequencer.c: save and restore cleanup mode


