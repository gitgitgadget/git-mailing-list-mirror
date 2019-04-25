Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84A551F453
	for <e@80x24.org>; Thu, 25 Apr 2019 17:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbfDYRJ0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 13:09:26 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43495 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfDYRJZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 13:09:25 -0400
Received: by mail-qt1-f195.google.com with SMTP id g4so892700qtq.10
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 10:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=BFMv8doESUj7VkzDHob9MBn2eYkHWEOcQ2spMISwtUQ=;
        b=Mx2Qidkw8ILinidy2BrxI5fVlCKYdFqD/wNsBPed6TVzi99Ph8ubrMLbvb9gLXdGlP
         yodmDTzPclJiYQWMYBXU3FJLAArHCUIiuatytAeC+Ekqvgsbw8WYaXsP8NkFmP79ee73
         uP0jckvmGXV8WJBwPwLyyypH96oGXRxXy5L+HZcoC2QUgCZhY1PQrez7WxOWjo9ROKnN
         1dSFpYFcO43cB+Z9CmtnbDXi2Wrr++R9O07fnSh2GpMncqx1Q5aUm2qLzEn/FJq81N+2
         KnJzKspn4rtyNabCqB9XblukyFti09xTBTh/16n8bYubOSVwQBGYXUzgsrKOQbjeD4EQ
         VfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=BFMv8doESUj7VkzDHob9MBn2eYkHWEOcQ2spMISwtUQ=;
        b=LxzCbWa+6cPXfe++WgGY6Th+T0QOycycdmANwKw8v2HB12bznl2Fk3uwtLh1AM26dI
         4ml5cC1Xj6fC7gg6jifu/dxe7HCI8uZeZPm0UF1n8K8TIJ66Rk8DQwfGpGadnnmsMQ6C
         vpx2a8L2xfPMdPmgQiSREqdmpBpACkiV96RMgU1MOJnfjSerMnpEkQpTOBMhuK0ZFlK3
         fN462iCY2CAfhGS2EEQY6uuDlfEMr7+AvqlyiUyzDy7U2esnco+plV34Yei35D0Uubc2
         qe0zZ/Hm9sZFXWe5UnAdsTi5BEugVD/zWs6qDLPF4WBTUaiPEPiQFvkAwNg2WHKPIRvw
         8onQ==
X-Gm-Message-State: APjAAAUTiPVR9aLfXP90dspCTJdYteSh6AcyeWwI9BDm/AqZy9dZjxyH
        GTbbOORrOUXLUmRBvzgk1b2eV3x2
X-Google-Smtp-Source: APXvYqyu74GcXcJUCpotK6jQip/3fLc2QlNZxDmeo8wCHfQ1wf12XkWiIENIk3zZfF7ZMQwUGhHGig==
X-Received: by 2002:a0c:9dcb:: with SMTP id p11mr31829249qvf.28.1556212162336;
        Thu, 25 Apr 2019 10:09:22 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:189a:8d9a:2c4d:7028? ([2001:4898:8010:0:1d0:8d9a:2c4d:7028])
        by smtp.gmail.com with ESMTPSA id y189sm2561150qke.34.2019.04.25.10.09.21
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 10:09:21 -0700 (PDT)
To:     Git List <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (April 25)
Message-ID: <c315efa1-61d5-ba17-83a7-10bd7eb1fcd8@gmail.com>
Date:   Thu, 25 Apr 2019 13:09:20 -0400
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

Here is today's test coverage report. You can view it in HTML [1] or in
plain-text [2].

Thanks,
-Stolee

[1] https://derrickstolee.github.io/git-test-coverage/reports/2019-04-25.htm
[2] https://derrickstolee.github.io/git-test-coverage/reports/2019-04-25.txt

---

pu	762cccf710b8bb10da04b42e3f40a2c653c92fea
jch	0e8cc1100ca06ca127777cff331ef5a17b5f8f02
next	f2820cf01acf778d953a46357a6160ba42711eb1
master	83232e38648b51abbcbdb56c94632b6906cc85a6
master@{1}	14c0f8d3ab6c36672189cd2dd217f4617d12ccba


Uncovered code in 'pu' not in 'jch'
--------------------------------------------------------

blame.c
dfb4ee12 366) continue;
d0738d94 618)     ent->ignored == next->ignored &&
a5c91678 619)     ent->unblamable == next->unblamable) {
a5c91678 1853) continue;

builtin/blame.c
a5c91678 493) memset(hex, '0', length);
a5c91678 716) return ret;

builtin/cat-file.c
e265069a 528) warning("This repository uses promisor remotes. Some objects may not be loaded.");

builtin/commit.c
5ff7cad9 1674) return 1;

builtin/config.c
a12c1ff3 110) die(_("$HOME not set"));
a12c1ff3 122) given_config_source.file = git_etc_gitconfig();
6f11fd5e 489) BUG("action %d cannot get here", actions);
6f11fd5e 503) die(_("unknown config source"));
6f11fd5e 509) die(_("invalid key pattern: %s"), key);

builtin/fetch-pack.c
bf01639c 249) warning(_("Lockfile created but not reported: %s"),
bf01639c 250) pack_lockfiles.items[i].string);

builtin/gc.c
5ff7cad9 692) return 1;

builtin/pack-objects.c
820a5361 858) BUG("configured exclusion wasn't configured");
820a5361 2795) die(_("value of uploadpack.blobpackfileuri must be "
820a5361 2798) die(_("object already configured in another "

commit-graph.c
d5747681 936) error(_("unsupported commit-graph version %d"),
d5747681 938) return 1;
5ff7cad9 988) error(_("error adding pack %s"), packname.buf);
5ff7cad9 989) res = 1;
5ff7cad9 990) goto cleanup;
5ff7cad9 993) error(_("error opening index for %s"), packname.buf);
5ff7cad9 994) res = 1;
5ff7cad9 995) goto cleanup;
5ff7cad9 1068) error(_("the commit graph format cannot write %d commits"), count_distinct);
5ff7cad9 1069) res = 1;
5ff7cad9 1070) goto cleanup;
5ff7cad9 1104) error(_("too many commits to write graph"));
5ff7cad9 1105) res = 1;
5ff7cad9 1106) goto cleanup;
5ff7cad9 1114) error(_("unable to create leading directories of %s"),
5ff7cad9 1116) res = errno;
5ff7cad9 1117) goto cleanup;

config.c
8f7c7f55 2155) int repo_config_set_gently(struct repository *r,
8f7c7f55 2158) char *path = repo_git_path(r, "config");
8f7c7f55 2159) int ret = git_config_set_multivar_in_file_gently(path, key, value, NULL, 0);
8f7c7f55 2160) free(path);
8f7c7f55 2161) return ret;
8f7c7f55 2164) void repo_config_set(struct repository *r, const char *key, const char *value)
8f7c7f55 2166) if (!repo_config_set_gently(r, key, value))
8f7c7f55 2167) return;
8f7c7f55 2168) if (value)
8f7c7f55 2169) die(_("could not set '%s' to '%s'"), key, value);
8f7c7f55 2171) die(_("could not unset '%s'"), key);
8f7c7f55 2174) int repo_config_set_worktree_gently(struct repository *r,
8f7c7f55 2180) path = get_worktree_config(r);
8f7c7f55 2181) if (!path)
8f7c7f55 2182) return CONFIG_INVALID_FILE;
8f7c7f55 2183) ret = git_config_set_multivar_in_file_gently(path, key, value, NULL, 0);
8f7c7f55 2184) free(path);
8f7c7f55 2185) return ret;

fetch-pack.c
820a5361 1390) die("expected '<hash> <uri>', got: %s\n", reader->line);
820a5361 1395) die("expected DELIM");
820a5361 1522) die("fetch-pack: unable to spawn http-fetch");
820a5361 1526) die("fetch-pack: expected keep then TAB at start of http-fetch output");
820a5361 1531) die("fetch-pack: expected hash then LF at end of http-fetch output");
820a5361 1538) die("fetch-pack: unable to finish http-fetch");
820a5361 1542) die("fetch-pack: pack downloaded from %s does not match expected hash %.*s",
820a5361 1543)     uri, (int) the_hash_algo->hexsz,
820a5361 1544)     packfile_uris.items[i].string);

http-fetch.c
472fbef8 75) die("couldn't create http pack request");
472fbef8 82) die("Unable to get pack file %s\n%s", preq->url,
472fbef8 86) die("Unable to start request");
472fbef8 101) walker_targets_free(commits, commit_id, write_ref);
472fbef8 104) fprintf(stderr,

http.c
ba81921a 2005) if (fflush((FILE *)result)) {
ba81921a 2009) rewind((FILE *)result);
ba81921a 2010) if (ftruncate(fileno((FILE *)result), 0) < 0) {
07ca07bb 2302) target ? hash_to_hex(target->hash) : base_url,

oidset.c
3486d8d4 69) die_errno("Could not read '%s'", path);

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
6da1f1a9 37) die(_("Unrecognized protocol version"));
6da1f1a9 39) die(_("Unrecognized protocol_version"));
6da1f1a9 74) BUG("late attempt to register an allowed protocol version");

ref-filter.c
3da20422 93) keydata_aka_refname ? keydata_aka_refname : k->wt->head_ref);

remote-curl.c
6da1f1a9 345) return 0;

upload-pack.c
a8d662e3 130) return readsz;
820a5361 149) BUG("packfile_uris requires sideband-all");
a8d662e3 355) send_client_data(1, output_state.buffer, output_state.used);
820a5361 1386) string_list_clear(&data->uri_protocols, 0);

wrapper.c
5efde212 70) die("Out of memory, malloc failed (tried to allocate %" PRIuMAX " bytes)",
5efde212 73) error("Out of memory, malloc failed (tried to allocate %" PRIuMAX " bytes)",

Commits introducting uncovered code:
Barret Rhoden	dfb4ee12 blame: use a fingerprint heuristic to match ignored lines
Barret Rhoden	d0738d94 blame: add config options to handle output for ignored lines
Barret Rhoden	a5c91678 blame: add the ability to ignore commits and their changes
Barret Rhoden	3486d8d4 Move init_skiplist() outside of fsck
Christian Couder	e265069a Use promisor_remote_get_direct() and has_promisor_remote()
Christian Couder	dcc8b4e9 promisor-remote: implement promisor_remote_get_direct()
Christian Couder	b21a55f3 promisor-remote: parse remote.*.partialclonefilter
Christian Couder	7b6e1b04 Move core_partial_clone_filter_default to promisor-remote.c
Christian Couder	7bdf0926 promisor-remote: use repository_format_partial_clone
Christian Couder	54248706 Add initial support for many promisor remotes
Christian Couder	0ba08c05 Remove fetch-object.{c,h} in favor of promisor-remote.{c,h}
Dan McGregor	ba81921a http: cast result to FILE *
Derrick Stolee	d5747681 commit-graph: create new version flags
Derrick Stolee	5ff7cad9 commit-graph: return with errors during write
Jonathan Tan	a8d662e3 upload-pack: refactor reading of pack-objects out
Jonathan Tan	820a5361 upload-pack: send part of packfile response as uri
Jonathan Tan	bf01639c fetch-pack: support more than one pack lockfile
Jonathan Tan	472fbef8 http-fetch: support fetching packfiles by URL
Josh Steadmon	6da1f1a9 protocol: advertise multiple supported versions
Junio C Hamano	07ca07bb Merge branch 'jt/fetch-cdn-offload' into pu
Martin Koegler	5efde212 zlib.c: use size_t for size
Nguyễn Thái Ngọc Duy	8f7c7f55 config.c: add repo_config_set_worktree_gently()
Nguyễn Thái Ngọc Duy	6f11fd5e config: add --move-to
Nguyễn Thái Ngọc Duy	a12c1ff3 config: factor out set_config_source_file()
Nickolai Belakovski	3da20422 ref-filter: add worktreepath atom


Uncovered code in 'jch' not in 'next'
--------------------------------------------------------

attr.c
b0c2d613 1167) return 0;

builtin/checkout.c
4de2081d 415) die(_("'%s' cannot be used with updating paths"),
4de2081d 425) die(_("'%s' cannot be used with %s"),
a0f3bbfa 433) die(_("neither '%s' or '%s' is specified"),
a0f3bbfa 437) die(_("'%s' must be used when '%s' is not specified"),
7800c9e6 442) die(_("'%s' or '%s' cannot be used with %s"),
7800c9e6 447) die(_("'%s' or '%s' cannot be used with %s"),
a0f3bbfa 456) patch_mode = "--patch=reset";
af482cb3 460) BUG("either flag must have been set, worktree=%d, index=%d",
a0f3bbfa 536) die(_("unable to write new index file"));
1806c29f 656) BUG("'switch --orphan' should never accept a commit as starting point");
1806c29f 1039) BUG("'switch --orphan' should never accept a commit as starting point");
5c06e269 1176) die(_("only one reference expected"));
7968bef0 1300) const char *ref = to_free;
7968bef0 1302) if (skip_prefix(ref, "refs/tags/", &ref))
7968bef0 1303) die(_("a branch is expected, got tag '%s'"), ref);
7968bef0 1304) if (skip_prefix(ref, "refs/remotes/", &ref))
7968bef0 1305) die(_("a branch is expected, got remote branch '%s'"), ref);
7968bef0 1306) die(_("a branch is expected, got '%s'"), ref);
7968bef0 1314) die(_("a branch is expected, got '%s'"), branch_info->name);
c45f0f52 1329) die(_("cannot switch branch in the middle of an am session\n"
c45f0f52 1333) die(_("cannot switch branch while rebasing\n"
c45f0f52 1337) die(_("cannot switch branch while cherry-picking\n"
c45f0f52 1341) die(_("cannot switch branch while reverting\n"
c45f0f52 1345) die(_("cannot switch branch while bisecting\n"
3ec37ad1 1372) die(_("'%s' cannot be used with '%s'"), "--discard-changes", "--merge");
8c1bf59d 1510) BUG("make up your mind, you need to take _something_");
a0f3bbfa 1542) opts->checkout_index = 0;
a0f3bbfa 1552) BUG("these flags should be non-negative by now");
8c1bf59d 1613) die(_("could not resolve %s"), opts->from_treeish);

builtin/multi-pack-index.c
ab08c40a 52) die(_("--batch-size option is only for 'repack' subcommand"));
ab08c40a 61) die(_("unrecognized subcommand: %s"), argv[0]);

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
526c03b5 1267) goto done;
10572de1 1283) goto done;

builtin/remote.c
f39a9c65 1551) die(_("--save-to-push cannot be used with other options"));
f39a9c65 1575) die(_("--save-to-push can only be used when only one url is defined"));

builtin/worktree.c
722abec7 297) BUG("How come '%s' becomes empty after sanitization?", sb.buf);

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

sequencer.c
4a72486d 2184) return error_errno("unable to open '%s'", todo_file);
4a72486d 2188) eol--; /* strip Carriage Return */
4a72486d 2190) goto fail;
4a72486d 2196) goto fail;
b07d9bfd 2300) error_errno("unable to open '%s'", todo_path);
b07d9bfd 2301) return 0;

upload-pack.c
6ef255b6 1073) precomposed_unicode = git_config_bool(var, value);

wt-status.c
b6d7dfc5 191) status_printf_ln(s, c, _("  (use \"git rm --staged <file>...\" to unstage)"));

Commits introducting uncovered code:
Denton Liu	f39a9c65 remote: add --save-to-push option to git remote set-url
Denton Liu	10572de1 rebase: fast-forward --onto in more cases
Denton Liu	526c03b5 rebase: refactor can_fast_forward into goto tower
Derrick Stolee	91336887 repack: refactor pack deletion for future use
Derrick Stolee	3dfbc2f0 midx: implement midx_repack()
Derrick Stolee	3c9e7185 multi-pack-index: implement 'expire' subcommand
Derrick Stolee	5bf52fbc midx: refactor permutation logic and pack sorting
Derrick Stolee	ab08c40a multi-pack-index: prepare 'repack' subcommand
Elijah Newren	6ef255b6 Honor core.precomposeUnicode in more places
Jonathan Nieder	ee70c128 index: offer advice for unknown index extensions
Nguyễn Thái Ngọc Duy	b0c2d613 Introduce "precious" file concept
Nguyễn Thái Ngọc Duy	722abec7 worktree add: sanitize worktree names
Nguyễn Thái Ngọc Duy	b6d7dfc5 rm: add --staged as alias for --cached
Nguyễn Thái Ngọc Duy	1806c29f switch: make --orphan switch to an empty tree
Nguyễn Thái Ngọc Duy	8c1bf59d restore: take tree-ish from --source option instead
Nguyễn Thái Ngọc Duy	4de2081d restore: replace --force with --ignore-unmerged
Nguyễn Thái Ngọc Duy	3ec37ad1 switch: add --discard-changes
Nguyễn Thái Ngọc Duy	c45f0f52 switch: reject if some operation is in progress
Nguyễn Thái Ngọc Duy	7968bef0 switch: only allow explicit detached HEAD
Nguyễn Thái Ngọc Duy	5c06e269 switch: stop accepting pathspec
Nguyễn Thái Ngọc Duy	af482cb3 restore: support --patch
Nguyễn Thái Ngọc Duy	7800c9e6 restore: reject invalid combinations with --staged
Nguyễn Thái Ngọc Duy	a0f3bbfa restore: add --worktree and --staged
Phillip Wood	b07d9bfd commit/reset: try to clean up sequencer state
Phillip Wood	4a72486d fix cherry-pick/revert status after commit
Phillip Wood	33898531 rebase -i: use struct object_id for squash_onto
Phillip Wood	c44c2462 rebase -i: remove duplication
Phillip Wood	73fdc535 rebase -i: use struct rebase_options to parse args
Phillip Wood	460bc3ce rebase -i: run without forking rebase--interactive
Phillip Wood	7d3488eb rebase -i: use struct commit when parsing options
Phillip Wood	0609b741 rebase -i: combine rebase--interactive.c with rebase.c
Phillip Wood	0ea0847e rebase -i: use struct rebase_options in do_interactive_rebase()


Uncovered code in 'next' not in 'master'
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

trace2.c
a0897249 448) tr2tls_create_self(thread_name, us_now);

trace2/tr2_dst.c
bce9db6d 16) const char *env_value = tr2_sysenv_get(TR2_SYSENV_DST_DEBUG);
a4d3a283 45) sid = last_slash + 1;
a4d3a283 55) strbuf_setlen(&path, base_path_len);
a4d3a283 56) strbuf_addf(&path, ".%d", attempt_count);
a4d3a283 65) if (tr2_dst_want_warning())
a4d3a283 66) warning("trace2: could not open '%.*s' for '%s' tracing: %s",
a5c08f12 69) strerror(errno));
a4d3a283 71) tr2_dst_trace_disable(dst);
a4d3a283 72) strbuf_release(&path);
a4d3a283 73) return 0;
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
Christian Couder	f8e44a81 replace: peel tag when passing a tag as parent to --graft
Christian Couder	ee521ec4 replace: peel tag when passing a tag first to --graft
Damien Robert	c646d093 ref-filter: use correct branch for %(push:track)
Denton Liu	d540b70c merge: cleanup messages like commit
Denton Liu	01dc801a tag: fix formatting
Elijah Newren	259ccb6c merge-recursive: rename merge_options argument from 'o' to 'opt'
Elijah Newren	8daec1df merge-recursive: switch from (oid,mode) pairs to a diff_filespec
Elijah Newren	e3de888c merge-recursive: rename diff_filespec 'one' to 'o'
Elijah Newren	79c47598 merge-recursive: avoid clobbering untracked files with directory renames
Elijah Newren	8c8e5bd6 merge-recursive: switch directory rename detection default
Jeff Hostetler	bce9db6d trace2: use system/global config for default trace2 settings
Jeff Hostetler	a0897249 trace2: refactor setting process starting time
Jeff Hostetler	08881b9a trace2: make SIDs more unique
Johannes Schindelin	6ea18fff test-tool: handle the `-C <directory>` option just like `git`
Josh Steadmon	a4d3a283 trace2: write to directory targets
Junio C Hamano	a5c08f12 Merge branch 'jh/trace2-sid-fix' into next
Nguyễn Thái Ngọc Duy	c931ba4e sha1-name.c: remove the_repo from handle_one_ref()
Nguyễn Thái Ngọc Duy	0daf7ff6 sha1-name.c: remove the_repo from get_oid_mb()
Nguyễn Thái Ngọc Duy	0488481e sha1-name.c: remove the_repo from diagnose_invalid_index_path()
Nguyễn Thái Ngọc Duy	7fdff474 refs.c: remove the_repo from read_ref_at()
Nguyễn Thái Ngọc Duy	56700903 refs.c: add repo_dwim_log()
Phillip Wood	d74f3e58 sequencer: fix cleanup with --signoff and -x
Phillip Wood	dc42e9a8 sequencer.c: save and restore cleanup mode


Uncovered code in 'master' not in 'master@{1}'
--------------------------------------------------------

builtin/blame.c
a544fb08 1005) die("no such ref: HEAD");

builtin/commit-graph.c
61df89c8 105) die_errno(_("Could not open commit-graph '%s'"), graph_name);
61df89c8 109) return 1;

builtin/difftool.c
ebe4df59 69) return error("expected object ID, got '%s'", p);
ebe4df59 73) return error("expected object ID, got '%s'", p);
20de316e 730) die(_("difftool requires worktree or --no-index"));

builtin/gc.c
bf3d70fe 126) die(_("failed to parse '%s' value '%s'"), var, value);

builtin/get-tar-commit-id.c
3548726c 40) return 1;
3548726c 42) return 1;

builtin/log.c
7954d365 254) static int estimate_commit_count(struct commit_list *list)
7954d365 292) int n = estimate_commit_count(list);
7954d365 336) static void setup_early_output(void)
7954d365 367) int n = estimate_commit_count(rev->commits);
7954d365 379) setup_early_output();

builtin/ls-files.c
7cb7283a 115) printf("  ctime: %u:%u\n", sd->sd_ctime.sec, sd->sd_ctime.nsec);
7cb7283a 116) printf("  mtime: %u:%u\n", sd->sd_mtime.sec, sd->sd_mtime.nsec);
7cb7283a 117) printf("  dev: %u\tino: %u\n", sd->sd_dev, sd->sd_ino);
7cb7283a 118) printf("  uid: %u\tgid: %u\n", sd->sd_uid, sd->sd_gid);
7cb7283a 119) printf("  size: %u\tflags: %x\n", sd->sd_size, ce->ce_flags);

builtin/rebase--interactive.c
1ba204de 17) static int add_exec_commands(struct string_list *commands)
1ba204de 19) const char *todo_file = rebase_path_todo();
1ba204de 20) struct todo_list todo_list = TODO_LIST_INIT;
1ba204de 23) if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
1ba204de 24) return error_errno(_("could not read '%s'."), todo_file);
1ba204de 26) if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
1ba204de 28) todo_list_release(&todo_list);
1ba204de 29) return error(_("unusable todo list: '%s'"), todo_file);
1ba204de 32) todo_list_add_exec_commands(&todo_list, commands);
1ba204de 33) res = todo_list_write_to_file(the_repository, &todo_list,
1ba204de 35) todo_list_release(&todo_list);
1ba204de 37) if (res)
1ba204de 38) return error_errno(_("could not write '%s'."), todo_file);
1ba204de 39) return 0;
79d7e883 42) static int rearrange_squash_in_todo_file(void)
79d7e883 44) const char *todo_file = rebase_path_todo();
79d7e883 45) struct todo_list todo_list = TODO_LIST_INIT;
79d7e883 46) int res = 0;
79d7e883 48) if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
79d7e883 49) return error_errno(_("could not read '%s'."), todo_file);
79d7e883 50) if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
79d7e883 52) todo_list_release(&todo_list);
79d7e883 53) return error(_("unusable todo list: '%s'"), todo_file);
79d7e883 56) res = todo_list_rearrange_squash(&todo_list);
79d7e883 57) if (!res)
79d7e883 58) res = todo_list_write_to_file(the_repository, &todo_list,
79d7e883 61) todo_list_release(&todo_list);
79d7e883 63) if (res)
79d7e883 64) return error_errno(_("could not write '%s'."), todo_file);
79d7e883 65) return 0;
ed35d188 75) return error_errno(_("could not read '%s'."), todo_file);
ed35d188 79) todo_list_release(&todo_list);
ed35d188 80) return error(_("unusable todo list: '%s'"), todo_file);
ed35d188 88) return error_errno(_("could not write '%s'."), todo_file);
a930eb03 100) return error_errno(_("could not read '%s'."), todo_file);
a930eb03 106) res = error_errno(_("could not write '%s'"), todo_file);
94bcad79 208) BUG("unusable todo list");
79d7e883 366) ret = rearrange_squash_in_todo_file();
1ba204de 369) ret = add_exec_commands(&commands);

commit-graph.c
61df89c8 89) close(*fd);
61df89c8 90) return 0;
93b4405f 218) error(_("commit-graph improper chunk offset %08x%08x"), (uint32_t)(chunk_offset >> 32),
93b4405f 255) error(_("commit-graph chunk id %08x appears multiple times"), chunk_id);
43d35618 315) die("dying as requested by the '%s' variable on commit-graph load!",
93b4405f 1182) graph_report(_("failed to parse commit %s from commit-graph"),
93b4405f 1248) graph_report(_("commit-graph parent list for commit %s terminates early"),
93b4405f 1253) graph_report(_("commit-graph has generation number zero for commit %s, but non-zero elsewhere"),

diff-no-index.c
16bb3d71 263) warning(_("Not a git repository. Use --no-index to "
16bb3d71 299) return 1;

diff.c
d2d3f273 4806) return error(_("unknown change class '%c' in --diff-filter=%s"),
5a749d9f 4830) return error(_("unknown value after ws-error-highlight=%.*s"),
a75f28cb 4844) return error(_("unable to resolve '%s'"), arg);
59311a98 4924) options->color_moved = COLOR_MOVED_NO;
bb987290 4946) options->color_moved_ws_handling = 0;
bb987290 4947) return 0;

fast-import.c
28d055bd 960) && (pack_size + PACK_SIZE_THRESHOLD + s.total_out) > max_packsize)
28d055bd 1056) if ((max_packsize
28d055bd 1057) && (pack_size + PACK_SIZE_THRESHOLD + len) > max_packsize)
28d055bd 1058) || (pack_size + PACK_SIZE_THRESHOLD + len) < pack_size)
28d055bd 2071)     tmp_hex_oid_len > hexsz ||
28d055bd 2085) if (tmp_hex_oid_len == hexsz && !get_oid_hex(hex_oid, &oid)) {
7ffde293 2262) parse_cat_blob(v);
28d055bd 2566) if (!buf || size < the_hash_algo->hexsz + 6)
7ffde293 2640) parse_cat_blob(v);
28d055bd 2855) cat_blob_write(output, the_hash_algo->hexsz + 1);
28d055bd 2885) const unsigned hexsz = the_hash_algo->hexsz;
28d055bd 2920) if (size < hexsz + strlen("object ") ||
28d055bd 2925) if (size < hexsz + strlen("tree ") ||
ef479a12 2957) static void print_ls(int mode, const unsigned char *hash, const char *path)
5056bb76 3326) parse_ls(v, NULL);
7ffde293 3328) parse_cat_blob(v);
cf7b857a 3330) parse_get_mark(v);

fetch-pack.c
1e7d440b 1680) BUG("Protocol V2 does not provide shallows at this point in the fetch");

http-walker.c
2bf1db78 445) hash_to_hex(target->hash));

http.c
05dfc7ca 2094) fprintf(stderr, "Getting index for pack %s\n", hash_to_hex(hash));
ddc56d47 2176)     (*data == '\n' || *data == '\0')) {
05dfc7ca 2291) hash_to_hex(target->hash),
eed0e60f 2433) the_hash_algo->init_fn(&freq->c);

pack-bitmap.c
0dd49248 192) error("Duplicate entry in bitmap index: %s", hash_to_hex(hash));
4828ce98 312) goto failed;

pack-revindex.c
4828ce98 166) return -1;
4828ce98 197) return NULL;

packfile.c
fc789156 475) ret = p->pack_name; /* we only have a base */
4828ce98 2038) return -1;

parse-options-cb.c
d8774183 26) v = the_hash_algo->hexsz;

parse-options.c
5205749d 534) static int show_gitcomp(const struct option *opts)
5205749d 613) return show_gitcomp(options);

progress.c
545dc345 127) fprintf(stderr, "  %s%*s", counters_sb->buf,
545dc345 130) clear_len = progress->title_len + 1 < cols ?
545dc345 131)     cols - progress->title_len : 0;
545dc345 132) fprintf(stderr, "%s:%*s\n  %s%s",
545dc345 135) progress->split = 1;

rebase-interactive.c
6ca89c6f 26) warning(_("unrecognized setting %s for option "
a930eb03 105) return error_errno(_("could not write '%s'"), todo_file);
a930eb03 108) return error(_("could not copy '%s' to '%s'."), todo_file,
6ca89c6f 167) goto leave_check;

remote-curl.c
9c9492e8 1123) else if (!*q)

revision.c
8320b1db 956) prio_queue_put(queue, p);

sequencer.c
f59199d5 2683) res |= git_config_set_in_file_gently(opts_file,
f59199d5 2714) res |= git_config_set_in_file_gently(opts_file,
f59199d5 2715) "options.gpg-sign", opts->gpg_sign);
616d7740 4646) strbuf_addstr(buf, " -c");
87805600 4693) res = -1;
6ca89c6f 4694) goto out;
6ca89c6f 4699) goto out;
6ca89c6f 4708) fprintf(stderr, _(edit_todo_list_advice));
6bfeb7f1 4824) todo_list_release(&new_todo);
94bcad79 4830) todo_list_release(&new_todo);
94bcad79 4831) return error_errno(_("could not write '%s'"), todo_file);

server-info.c
4ecbd649 148) } else if (line.buf[0] == 'D') {
4ecbd649 151) } else if (line.buf[0] == 'T') {
b83a3089 153) goto out_stale;

sha1-file.c
95399788 198) return GIT_HASH_UNKNOWN;

unpack-trees.c
191e9d2c 1699) return add_rejected_path(o, error_type, ce->name);
b165fac8 2346) return o->quiet ? -1 :

Commits introducting uncovered code:
Ævar Arnfjörð Bjarmason	61df89c8 commit-graph: don't early exit(1) on e.g. "git status"
Ævar Arnfjörð Bjarmason	43d35618 commit-graph write: don't die if the existing graph is corrupt
Ævar Arnfjörð Bjarmason	bf3d70fe gc: handle & check gc.reflogExpire config
Ævar Arnfjörð Bjarmason	93b4405f commit-graph: improve & i18n error messages
Alban Gruin	6bfeb7f1 sequencer: refactor skip_unnecessary_picks() to work on a todo_list
Alban Gruin	616d7740 sequencer: introduce todo_list_write_to_file()
Alban Gruin	94bcad79 sequencer: change complete_action() to use the refactored functions
Alban Gruin	a930eb03 rebase-interactive: rewrite edit_todo_list() to handle the initial edit
Alban Gruin	6ca89c6f sequencer: refactor check_todo_list() to work on a todo_list
Alban Gruin	ed35d188 rebase--interactive: move transform_todo_file()
Alban Gruin	1ba204de rebase--interactive: move sequencer_add_exec_commands()
Alban Gruin	79d7e883 rebase--interactive: move rearrange_squash_in_todo_file()
brian m. carlson	05dfc7ca http: replace sha1_to_hex
brian m. carlson	eed0e60f http: compute hash of downloaded objects using the_hash_algo
brian m. carlson	95399788 hash: add a function to lookup hash algorithm by length
brian m. carlson	0dd49248 pack-bitmap: replace sha1_to_hex
brian m. carlson	2bf1db78 http-walker: replace sha1_to_hex
brian m. carlson	ebe4df59 builtin/difftool: use parse_oid_hex
brian m. carlson	ef479a12 fast-import: replace sha1_to_hex
brian m. carlson	9c9492e8 remote-curl: make hash size independent
brian m. carlson	28d055bd fast-import: make hash-size independent
Elijah Newren	cf7b857a fast-import: fix erroneous handling of get-mark with empty orphan commits
Elijah Newren	5056bb76 fast-import: check most prominent commands first
Elijah Newren	7ffde293 fast-import: only allow cat-blob requests where it makes sense
Jeff King	8320b1db revision: use a prio_queue to hold rewritten parents
Jeff King	5205749d parse-options: drop unused ctx parameter from show_gitcomp()
Jeff King	4828ce98 pack-revindex: open index if necessary
Jeff King	4ecbd649 server-info: use strbuf to read old info/packs file
Jeff King	b83a3089 server-info: fix blind pointer arithmetic
Jeff King	ddc56d47 http: simplify parsing of remote objects/info/packs
Jeff King	7954d365 log: drop unused rev_info from early output
Jeff King	fc789156 packfile: fix pack basename computation
Johannes Schindelin	20de316e difftool: allow running outside Git worktrees with --no-index
Jonathan Tan	1e7d440b fetch-pack: call prepare_shallow_info only if v0
Nguyễn Thái Ngọc Duy	b165fac8 unpack-trees: rename "gently" flag to "quiet"
Nguyễn Thái Ngọc Duy	191e9d2c unpack-trees: keep gently check inside add_rejected_path
Nguyễn Thái Ngọc Duy	bb987290 diff.c: allow --no-color-moved-ws
Nguyễn Thái Ngọc Duy	59311a98 diff-parseopt: convert --[no-]color-moved
Nguyễn Thái Ngọc Duy	a75f28cb diff-parseopt: convert --find-object
Nguyễn Thái Ngọc Duy	5a749d9f diff-parseopt: convert --ws-error-highlight
Nguyễn Thái Ngọc Duy	d2d3f273 diff-parseopt: convert --diff-filter
Nguyễn Thái Ngọc Duy	16bb3d71 diff --no-index: use parse_options() instead of diff_opt_parse()
Nguyễn Thái Ngọc Duy	d8774183 diff-parseopt: convert --[no-]abbrev
Phillip Wood	f59199d5 sequencer: break some long lines
Rene Scharfe	3548726c get-tar-commit-id: parse comment record
René Scharfe	87805600 sequencer: factor out strbuf_read_file_or_whine()
SZEDER Gábor	545dc345 progress: break too long progress bar lines
SZEDER Gábor	a544fb08 blame: default to HEAD in a bare repo when no start commit is given
Thomas Gummerer	7cb7283a ls-files: use correct format string

