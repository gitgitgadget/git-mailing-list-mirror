Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D1A11F453
	for <e@80x24.org>; Wed, 24 Apr 2019 01:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbfDXBkc (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 21:40:32 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43172 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729050AbfDXBkb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 21:40:31 -0400
Received: by mail-qt1-f195.google.com with SMTP id i14so18459107qtr.10
        for <git@vger.kernel.org>; Tue, 23 Apr 2019 18:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=HTd83PUn0a5/ERCRMLb26zjcDC5vrvoT7mPxIzHykIE=;
        b=hoK+NQpIge8Yz9g9RcIjxVlF1stGo3Z+HzDyDqmzIBOEBF8urbtwsjnDvjv38wBNed
         AaFlXm127KivTgxf+du5qfvQojqrgn2DXBS3nuqb5BQgwYi0b7hThGQplZG0zX690Ntk
         asMWf4lcmokZtGDGTBZX6tjiIr+vDIF1Fscxw8ztNuXzuTFVVajR/93ELe1nX461UrSP
         QglhZVl6TZ8RoKSOth7cH0iyecMJIvRYlquyffKdJCCv91fGojSKFyfjoX8Nqortd3Q5
         I4unhH6Civ8Tj3BHT5TpdUcfG8x6D/SnWMDIS4DLwsyNWSlQyFQ2kBG87KnQZiaCBFFz
         6eVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=HTd83PUn0a5/ERCRMLb26zjcDC5vrvoT7mPxIzHykIE=;
        b=eXWuc3mLtniZfmlLKsmSVs8DmwIExUzFd3JBvvCRBB9A6/lJK3DLQMlnG/ILEb0z4k
         NUQ2R3Y8njQYV10OuoamLByAWlTTAON0PG4tMXDLbOLCR60ezGxcoutTZU5LOghiRvT7
         TBtRMU0ilbf0ViwXglyjubH5Z6SSqzCWqtQNO5NksFLCP5y1YCaF26LrjknLWz7VBl70
         /chQEjXkqKYNk4VzBu1j2+xKN69wyPCv5xU4B/7wqAn0/C6mF43vq9WJ5vsOXB84CzqB
         NaHqCzYEZ2QKCbUDDjWo3mWhJAoWum9aoiXH0V1ggJ4X509ldJqWrMNnDau1NTOXwKMh
         BBVg==
X-Gm-Message-State: APjAAAXt0/sFLZLoEmzfbh220HdqTeP5rf+gisyLefRBeq9Xd4XB3Vg/
        9+PzEFU/u3lvAwZrDOD1pyV5AjM2oqA=
X-Google-Smtp-Source: APXvYqyL1mqFrFqh5aZKMB5KR3XzbMQXJUDnfqyziw3t09fogz1wZO55eCto960AxZlyh0Auv/rvuQ==
X-Received: by 2002:ac8:304f:: with SMTP id g15mr3745085qte.306.1556070026195;
        Tue, 23 Apr 2019 18:40:26 -0700 (PDT)
Received: from [10.0.1.4] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id h62sm8491758qkd.92.2019.04.23.18.40.25
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 18:40:25 -0700 (PDT)
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (April 23)
Message-ID: <b67443ff-7269-60ae-f553-8c63b55b020e@gmail.com>
Date:   Tue, 23 Apr 2019 21:40:24 -0400
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

Hello! The Git Test Coverage Report returns. You can view it online [1] with
links to the associated commits on GitHub, or the text report [2] also copied
below.

Thanks,
-Stolee

[1] https://derrickstolee.github.io/git-test-coverage/reports/2019-04-23.htm
[2] https://derrickstolee.github.io/git-test-coverage/reports/2019-04-23.txt

---

pu	10106b3182f67f26aca845f309ac34197630ae3d
jch	7817e26e80e7a31d173cc239a27d2b619fe18685
next	bc5ef9b4584fe30aba4dab265bba44254d0b5df0
master	14c0f8d3ab6c36672189cd2dd217f4617d12ccba
master@{1}	aeb582a98374c094361cba1bd756dc6307432c42


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
8e7e6c05 1674) return 1;

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
8e7e6c05 692) return 1;

builtin/pack-objects.c
820a5361 858) BUG("configured exclusion wasn't configured");
820a5361 2795) die(_("value of uploadpack.blobpackfileuri must be "
820a5361 2798) die(_("object already configured in another "

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

commit-graph.c
b1beb050 936) error(_("unsupported commit-graph version %d"),
b1beb050 938) return 1;
8e7e6c05 988) error(_("error adding pack %s"), packname.buf);
8e7e6c05 989) res = 1;
8e7e6c05 990) goto cleanup;
8e7e6c05 993) error(_("error opening index for %s"), packname.buf);
8e7e6c05 994) res = 1;
8e7e6c05 995) goto cleanup;
8e7e6c05 1068) error(_("the commit graph format cannot write %d commits"), count_distinct);
8e7e6c05 1069) res = 1;
8e7e6c05 1070) goto cleanup;
8e7e6c05 1104) error(_("too many commits to write graph"));
8e7e6c05 1105) res = 1;
8e7e6c05 1106) goto cleanup;
8e7e6c05 1114) error(_("unable to create leading directories of %s"),
8e7e6c05 1116) res = errno;
8e7e6c05 1117) goto cleanup;

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
8b13ff27 2302) target ? hash_to_hex(target->hash) : base_url,

oidset.c
3486d8d4 69) die_errno("Could not read '%s'", path);

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

sequencer.c
4a72486d 2184) return error_errno("unable to open '%s'", todo_file);
4a72486d 2188) eol--; /* strip Carriage Return */
4a72486d 2190) goto fail;
4a72486d 2196) goto fail;
b07d9bfd 2300) error_errno("unable to open '%s'", todo_path);
b07d9bfd 2301) return 0;

upload-pack.c
a8d662e3 130) return readsz;
820a5361 149) BUG("packfile_uris requires sideband-all");
a8d662e3 355) send_client_data(1, output_state.buffer, output_state.used);
820a5361 1384) string_list_clear(&data->uri_protocols, 0);

wrapper.c
5efde212 70) die("Out of memory, malloc failed (tried to allocate %" PRIuMAX " bytes)",
5efde212 73) error("Out of memory, malloc failed (tried to allocate %" PRIuMAX " bytes)",

Commits introducting uncovered code:
Barret Rhoden	dfb4ee12 blame: use a fingerprint heuristic to match ignored lines
Barret Rhoden	d0738d94 blame: add config options to handle output for ignored lines
Barret Rhoden	a5c91678 blame: add the ability to ignore commits and their changes
Barret Rhoden	3486d8d4 Move init_skiplist() outside of fsck
Christian Couder	0ba08c05 Remove fetch-object.{c,h} in favor of promisor-remote.{c,h}
Christian Couder	54248706 Add initial support for many promisor remotes
Christian Couder	7bdf0926 promisor-remote: use repository_format_partial_clone
Christian Couder	7b6e1b04 Move core_partial_clone_filter_default to promisor-remote.c
Christian Couder	b21a55f3 promisor-remote: parse remote.*.partialclonefilter
Christian Couder	dcc8b4e9 promisor-remote: implement promisor_remote_get_direct()
Christian Couder	e265069a Use promisor_remote_get_direct() and has_promisor_remote()
Dan McGregor	ba81921a http: cast result to FILE *
Derrick Stolee	8e7e6c05 commit-graph: return with errors during write
Derrick Stolee	b1beb050 commit-graph: create new version flags
Jonathan Tan	bf01639c fetch-pack: support more than one pack lockfile
Jonathan Tan	a8d662e3 upload-pack: refactor reading of pack-objects out
Jonathan Tan	472fbef8 http-fetch: support fetching packfiles by URL
Jonathan Tan	820a5361 upload-pack: send part of packfile response as uri
Josh Steadmon	6da1f1a9 protocol: advertise multiple supported versions
Junio C Hamano	8b13ff27 Merge branch 'jt/fetch-cdn-offload' into pu
Martin Koegler	5efde212 zlib.c: use size_t for size
Nguyễn Thái Ngọc Duy	6f11fd5e config: add --move-to
Nguyễn Thái Ngọc Duy	a12c1ff3 config: factor out set_config_source_file()
Nguyễn Thái Ngọc Duy	8f7c7f55 config.c: add repo_config_set_worktree_gently()
Nickolai Belakovski	3da20422 ref-filter: add worktreepath atom
Phillip Wood	33898531 rebase -i: use struct object_id for squash_onto
Phillip Wood	460bc3ce rebase -i: run without forking rebase--interactive
Phillip Wood	0ea0847e rebase -i: use struct rebase_options in do_interactive_rebase()
Phillip Wood	7d3488eb rebase -i: use struct commit when parsing options
Phillip Wood	c44c2462 rebase -i: remove duplication
Phillip Wood	0609b741 rebase -i: combine rebase--interactive.c with rebase.c
Phillip Wood	4a72486d fix cherry-pick/revert status after commit
Phillip Wood	b07d9bfd commit/reset: try to clean up sequencer state
Phillip Wood	73fdc535 rebase -i: use struct rebase_options to parse args


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
467ae6f9 52) die(_("--batch-size option is only for 'repack' subcommand"));
467ae6f9 61) die(_("unrecognized subcommand: %s"), argv[0]);

builtin/pull.c
d540b70c 652) argv_array_pushf(&args, "--cleanup=%s", cleanup_arg);

builtin/rebase.c
9999ed57 890) goto done;
6ddf3d44 906) goto done;

builtin/remote.c
f39a9c65 1551) die(_("--save-to-push cannot be used with other options"));
f39a9c65 1575) die(_("--save-to-push can only be used when only one url is defined"));

builtin/replace.c
f8e44a81 383) return error(_("could not parse %s as a commit"), argv[i]);
ee521ec4 490) return error(_("new commit is the same as the old one: '%s'"),

builtin/show-branch.c
7fdff474 756) read_ref_at(get_main_ref_store(the_repository),
7fdff474 769) if (read_ref_at(get_main_ref_store(the_repository),

builtin/tag.c
01dc801a 226) die(_("bad object type."));

builtin/worktree.c
722abec7 297) BUG("How come '%s' becomes empty after sanitization?", sb.buf);

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
467ae6f9 1234) return 0;
19c239d4 1249) return 0;
19c239d4 1258) continue;
19c239d4 1271) continue;
19c239d4 1294) error(_("could not start pack-objects"));
19c239d4 1295) result = 1;
19c239d4 1296) goto cleanup;
19c239d4 1313) error(_("could not finish pack-objects"));
19c239d4 1314) result = 1;
19c239d4 1315) goto cleanup;

packfile.c
91336887 369) strbuf_release(&buf);
91336887 370) return;

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
56700903 700)  refs_reflog_exists(refs, ref))

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
d86ca9e2 69) strerror(errno));
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

wt-status.c
b6d7dfc5 190) status_printf_ln(s, c, _("  (use \"git rm --staged <file>...\" to unstage)"));

Commits introducting uncovered code:
Christian Couder	ee521ec4 replace: peel tag when passing a tag first to --graft
Christian Couder	f8e44a81 replace: peel tag when passing a tag as parent to --graft
Damien Robert	c646d093 ref-filter: use correct branch for %(push:track)
Denton Liu	9999ed57 rebase: refactor can_fast_forward into goto tower
Denton Liu	01dc801a tag: fix formatting
Denton Liu	f39a9c65 remote: add --save-to-push option to git remote set-url
Denton Liu	6ddf3d44 rebase: fast-forward --onto in more cases
Denton Liu	d540b70c merge: cleanup messages like commit
Derrick Stolee	3c9e7185 multi-pack-index: implement 'expire' subcommand
Derrick Stolee	19c239d4 midx: implement midx_repack()
Derrick Stolee	91336887 repack: refactor pack deletion for future use
Derrick Stolee	5bf52fbc midx: refactor permutation logic and pack sorting
Derrick Stolee	467ae6f9 multi-pack-index: prepare 'repack' subcommand
Elijah Newren	8c8e5bd6 merge-recursive: switch directory rename detection default
Elijah Newren	8daec1df merge-recursive: switch from (oid,mode) pairs to a diff_filespec
Elijah Newren	e3de888c merge-recursive: rename diff_filespec 'one' to 'o'
Elijah Newren	79c47598 merge-recursive: avoid clobbering untracked files with directory renames
Elijah Newren	259ccb6c merge-recursive: rename merge_options argument from 'o' to 'opt'
Jeff Hostetler	a0897249 trace2: refactor setting process starting time
Jeff Hostetler	bce9db6d trace2: use system/global config for default trace2 settings
Jeff Hostetler	08881b9a trace2: make SIDs more unique
Johannes Schindelin	6ea18fff test-tool: handle the `-C <directory>` option just like `git`
Jonathan Nieder	ee70c128 index: offer advice for unknown index extensions
Josh Steadmon	a4d3a283 trace2: write to directory targets
Junio C Hamano	d86ca9e2 Merge branch 'jh/trace2-sid-fix' into jch
Nguyễn Thái Ngọc Duy	56700903 refs.c: add repo_dwim_log()
Nguyễn Thái Ngọc Duy	c931ba4e sha1-name.c: remove the_repo from handle_one_ref()
Nguyễn Thái Ngọc Duy	0daf7ff6 sha1-name.c: remove the_repo from get_oid_mb()
Nguyễn Thái Ngọc Duy	b0c2d613 Introduce "precious" file concept
Nguyễn Thái Ngọc Duy	722abec7 worktree add: sanitize worktree names
Nguyễn Thái Ngọc Duy	7fdff474 refs.c: remove the_repo from read_ref_at()
Nguyễn Thái Ngọc Duy	8c1bf59d restore: take tree-ish from --source option instead
Nguyễn Thái Ngọc Duy	3ec37ad1 switch: add --discard-changes
Nguyễn Thái Ngọc Duy	c45f0f52 switch: reject if some operation is in progress
Nguyễn Thái Ngọc Duy	7968bef0 switch: only allow explicit detached HEAD
Nguyễn Thái Ngọc Duy	5c06e269 switch: stop accepting pathspec
Nguyễn Thái Ngọc Duy	1806c29f switch: make --orphan switch to an empty tree
Nguyễn Thái Ngọc Duy	af482cb3 restore: support --patch
Nguyễn Thái Ngọc Duy	7800c9e6 restore: reject invalid combinations with --staged
Nguyễn Thái Ngọc Duy	a0f3bbfa restore: add --worktree and --staged
Nguyễn Thái Ngọc Duy	4de2081d restore: replace --force with --ignore-unmerged
Nguyễn Thái Ngọc Duy	0488481e sha1-name.c: remove the_repo from diagnose_invalid_index_path()
Nguyễn Thái Ngọc Duy	b6d7dfc5 rm: add --staged as alias for --cached
Phillip Wood	d74f3e58 sequencer: fix cleanup with --signoff and -x
Phillip Wood	dc42e9a8 sequencer.c: save and restore cleanup mode


Uncovered code in 'next' not in 'master'
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


Uncovered code in 'master' not in 'master@{1}'
--------------------------------------------------------

builtin/branch.c
0ecb1fc7 452) die(_("could not resolve HEAD"));
0ecb1fc7 458) die(_("HEAD (%s) points outside of refs/heads/"), refname);

builtin/checkout.c
091e04bc 303) return;
091e04bc 1292) die(_("'%s' cannot be used with switching branches"),

builtin/commit-tree.c
cbdeab98 56) die(_("not a valid object name %s"), arg);
cbdeab98 71) strbuf_addch(buf, '\n');
cbdeab98 78) static int parse_file_arg_callback(const struct option *opt,
cbdeab98 82) struct strbuf *buf = opt->value;
cbdeab98 84) BUG_ON_OPT_NEG_NOARG(unset, arg);
cbdeab98 86) if (buf->len)
cbdeab98 87) strbuf_addch(buf, '\n');
cbdeab98 88) if (!strcmp(arg, "-"))
cbdeab98 89) fd = 0;
cbdeab98 91) fd = open(arg, O_RDONLY);
cbdeab98 92) if (fd < 0)
cbdeab98 93) die_errno(_("git commit-tree: failed to open '%s'"), arg);
cbdeab98 95) if (strbuf_read(buf, fd, 0) < 0)
cbdeab98 96) die_errno(_("git commit-tree: failed to read '%s'"), arg);
cbdeab98 97) if (fd && close(fd))
cbdeab98 98) die_errno(_("git commit-tree: failed to close '%s'"), arg);
cbdeab98 100) return 0;
cbdeab98 133) die(_("must give exactly one tree"));
cbdeab98 140) die_errno(_("git commit-tree: failed to read"));

builtin/fsck.c
8d8c2a5a 271) static int mark_packed_unreachable_referents(const struct object_id *oid,
8d8c2a5a 276) mark_unreachable_referents(oid);
8d8c2a5a 277) return 0;

builtin/log.c
bc208ae3 520) die(_("not a valid object name %s"), obj_name);
bc208ae3 544) return error(_("could not read object %s"), oid_to_hex(oid));
bc208ae3 663) ret = error(_("unknown type: %d"), o->type);
bc208ae3 918) die(_("need exactly one range"));
bc208ae3 928) die(_("not a range"));
bc208ae3 1051) die(_("cover letter needs email format"));
bc208ae3 1221) die(_("two output directories?"));
bc208ae3 1332) die(_("unknown commit %s"), base_commit);
bc208ae3 1342) die(_("failed to resolve '%s' as a valid ref"), upstream);
bc208ae3 1351) die(_("failed to get upstream, if you want to record base commit automatically,\n"
bc208ae3 1371) die(_("failed to find exact merge base"));
bc208ae3 1750) die_errno(_("could not create directory '%s'"),
bc208ae3 1952) die(_("failed to create output files"));
bc208ae3 2076) die(_("unknown commit %s"), head);
bc208ae3 2078) die(_("unknown commit %s"), upstream);
bc208ae3 2090) die(_("unknown commit %s"), limit);

builtin/prune-packed.c
9b0bd87e 67) usage_msg_opt(_("too many arguments"),

builtin/prune.c
d55a30bb 43) progress = start_delayed_progress(_("Checking connectivity"), 0);

builtin/rebase.c
cbd29ead 448) } else if (old_orig)
cbd29ead 449) delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
b3a5d5a8 1205) if (is_interactive(&options))
b3a5d5a8 1206) trace2_cmd_mode("interactive");
b3a5d5a8 1207) else if (exec.nr)
b3a5d5a8 1208) trace2_cmd_mode("interactive-exec");
b3a5d5a8 1210) trace2_cmd_mode(action_names[action]);

builtin/stash.c
8a0fc8d1 127) die(_("'%s' is not a stash-like commit"), revision);
8a0fc8d1 160) free_stash_info(info);
8a0fc8d1 161) fprintf_ln(stderr, _("No stash entries found."));
8a0fc8d1 162) return -1;
8a0fc8d1 197) free_stash_info(info);
4e2dd393 224) return error(_("git stash clear with parameters is "
8a0fc8d1 240) return -1;
8a0fc8d1 248) return -1;
8a0fc8d1 264) return error(_("unable to write new index file"));
8a0fc8d1 372) remove_path(stash_index_path.buf);
8a0fc8d1 373) return -1;
8a0fc8d1 400) return -1;
8a0fc8d1 403) return error(_("cannot apply a stash in the middle of a merge"));
8a0fc8d1 413) strbuf_release(&out);
8a0fc8d1 414) return error(_("could not generate diff %s^!."),
8a0fc8d1 421) return error(_("conflicts in index."
8a0fc8d1 427) return error(_("could not save index tree"));
8a0fc8d1 434) return error(_("could not restore untracked files from stash"));
8a0fc8d1 465) return -1;
8a0fc8d1 470) strbuf_release(&out);
8a0fc8d1 475) strbuf_release(&out);
8a0fc8d1 476) return -1;
4e2dd393 552) return error(_("%s: Could not drop stash entry"),
c4de61d7 627) printf_ln(_("The stash entry is kept in case "
dc7bd382 761) free_stash_info(&info);
40af1468 762) usage_with_options(git_stash_show_usage, options);
41e0dd55 782) stash_msg = "Created via \"git stash store\".";
41e0dd55 788) if (!quiet) {
41e0dd55 789) fprintf_ln(stderr, _("Cannot update %s with %s"),
41e0dd55 792) return -1;
41e0dd55 816) if (!quiet)
41e0dd55 817) fprintf_ln(stderr, _("\"git stash store\" requires one "
41e0dd55 819) return -1;
d4788af8 902) return -1;
d4788af8 967) ret = -1;
d4788af8 968) goto done;
d4788af8 973) ret = -1;
d4788af8 974) goto done;
d4788af8 979) ret = -1;
d4788af8 980) goto done;
d4788af8 1006) ret = -1;
d4788af8 1007) goto done;
d4788af8 1018) ret = -1;
d4788af8 1019) goto done;
d4788af8 1025) ret = -1;
d4788af8 1026) goto done;
d4788af8 1033) ret = -1;
d4788af8 1034) goto done;
d4788af8 1072) ret = -1;
d4788af8 1073) goto done;
d4788af8 1079) ret = -1;
d4788af8 1080) goto done;
d4788af8 1091) ret = -1;
d4788af8 1092) goto done;
d4788af8 1097) ret = -1;
d4788af8 1098) goto done;
1ac528c0 1135) fprintf_ln(stderr, _("You do not have "
d4788af8 1144) ret = 1;
d4788af8 1145) goto done;
1ac528c0 1161) if (!quiet)
1ac528c0 1162) fprintf_ln(stderr, _("Cannot save the current "
d4788af8 1164) ret = -1;
d4788af8 1165) goto done;
1ac528c0 1170) if (!quiet)
1ac528c0 1171) fprintf_ln(stderr, _("Cannot save "
d4788af8 1173) ret = -1;
d4788af8 1174) goto done;
1ac528c0 1181) if (!quiet)
1ac528c0 1182) fprintf_ln(stderr, _("Cannot save the current "
d4788af8 1184) goto done;
1ac528c0 1218) if (!quiet)
1ac528c0 1219) fprintf_ln(stderr, _("Cannot record "
d4788af8 1221) ret = -1;
d4788af8 1222) goto done;
d553f538 1293) ret = -1;
d553f538 1294) goto done;
d553f538 1304) ret = -1;
1ac528c0 1305) if (!quiet)
1ac528c0 1306) fprintf_ln(stderr, _("Cannot initialize stash"));
d553f538 1307) goto done;
d553f538 1319) ret = -1;
1ac528c0 1320) if (!quiet)
1ac528c0 1321) fprintf_ln(stderr, _("Cannot save the current status"));
d553f538 1322) goto done;
d553f538 1339) ret = -1;
d553f538 1359) ret = -1;
d553f538 1360) goto done;
d553f538 1369) ret = -1;
d553f538 1370) goto done;
d553f538 1378) ret = -1;
d553f538 1387) ret = -1;
d553f538 1398) ret = -1;
d553f538 1399) goto done;
d553f538 1408) ret = -1;
d553f538 1409) goto done;
d553f538 1417) ret = -1;
d553f538 1443) ret = -1;
7906af0c 1536) return env;
90a46272 1564) const char *path = mkpath("%s/git-legacy-stash",
90a46272 1567) if (sane_execvp(path, (char **)argv) < 0)
90a46272 1568) die_errno(_("could not exec %s"), path);
90a46272 1570) BUG("sane_execvp() returned???");
40af1468 1611) usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
40af1468 1639) continue;

builtin/worktree.c
7af01f23 302) die_errno(_("could not create directory of '%s'"),

combine-diff.c
d76ce4f7 89)     filename_changed(p->parent[j].status))
d76ce4f7 90) strbuf_release(&p->parent[j].path);
d76ce4f7 992) dump_quoted_path("--- ", "", "/dev/null",
d76ce4f7 1000) dump_quoted_path("--- ", "", "/dev/null",
d76ce4f7 1273) write_name_quoted(p->path, stdout,

diff.c
84b5089e 4741) count = strtoul(end+1, &end, 10);
84b5089e 4743) return error(_("invalid --stat value: %s"), value);
84b5089e 4748) return error(_("%s expects a numerical value"),
84b5089e 4753) return error(_("%s expects a numerical value"),
84b5089e 4758) return error(_("%s expects a numerical value"),
84b5089e 4763) return error(_("%s expects a numerical value"),
84b5089e 4766) BUG("%s should not get here", opt->long_name);
ced4e179 4938) else if (*arg != '/')
ced4e179 4939) return error(_("%s expects <n>/<m> form"), opt->long_name);
ced4e179 4941) arg++;
ced4e179 4942) opt2 = parse_rename_score(&arg);
ced4e179 4945) return error(_("%s expects <n>/<m> form"), opt->long_name);
af2f3680 4957) return error(_("%s expects a character, got '%s'"),
7d7942b7 4982) options->flags.stat_with_summary = 0;
10f35b1c 4990) static int diff_opt_diff_algorithm(const struct option *opt,
10f35b1c 4993) struct diff_options *options = opt->value;
10f35b1c 4994) long value = parse_algorithm_value(arg);
10f35b1c 4996) BUG_ON_OPT_NEG(unset);
10f35b1c 4997) if (value < 0)
10f35b1c 4998) return error(_("option diff-algorithm accepts \"myers\", "
10f35b1c 5002) DIFF_XDL_CLR(options, NEED_MINIMAL);
10f35b1c 5003) options->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
10f35b1c 5004) options->xdl_opts |= value;
10f35b1c 5005) return 0;
4ce7aab5 5016) BUG("how come --cumulative take a value?");
7f64850d 5034) return error(_("invalid argument to %s"), opt->long_name);
f476308b 5054) return error(_("invalid argument to %s"), opt->long_name);
125dcea9 5146) return error(_("failed to parse --submodule option parameter: '%s'"),
d473e2e0 5176) return error(_("%s expects a numerical value"), "--unified");
e9fb39b6 5200) return error(_("bad --word-diff argument: %s"), arg);

entry.c
536ec183 450) BUG("Can't remove entry to a path");

fetch-pack.c
37c80012 196) die_errno(_("unable to write to remote"));
37c80012 1169) die_errno(_("unable to write request to remote"));

git.c
ee4512ed 162) trace2_cmd_name("_query_");
ee4512ed 166) trace2_cmd_name("_query_");
ee4512ed 170) trace2_cmd_name("_query_");

help.c
057ab54b 389) if (sb.buf[0] == '-')
057ab54b 390) string_list_remove(list, sb.buf + 1, 0);

ident.c
39ab4d09 452) break;
39ab4d09 454) name = getenv("GIT_AUTHOR_NAME");
39ab4d09 455) email = getenv("GIT_AUTHOR_EMAIL");
39ab4d09 456) break;
39ab4d09 515) return config_error_nonbool(var);
39ab4d09 525) return config_error_nonbool(var);
39ab4d09 535) return config_error_nonbool(var);
39ab4d09 545) return config_error_nonbool(var);

pack-objects.c
c409d108 122) void oe_map_new_pack(struct packing_data *pack)

pager.c
eee73d1d 103) pager_process->trace2_child_class = "pager";

parse-options.c
f62470c6 118) BUG("BITOP can't have unset form");
3ebbe289 257) rc = (*numopt->ll_callback)(p, numopt, arg, 0);
3ebbe289 438) BUG("OPTION_CALLBACK needs one callback");
3ebbe289 440) BUG("OPTION_CALLBACK can't have two callbacks");
bf3ff338 444) BUG("OPTION_LOWLEVEL_CALLBACK needs a callback");
bf3ff338 446) BUG("OPTION_LOWLEVEL_CALLBACK needs no high level callback");
202fbb33 481) BUG("Can't keep argv0 if you don't have it");
f41179f1 628) BUG("parse_short_opt() cannot return these");
f41179f1 653) BUG("parse_short_opt() cannot return these");
f41179f1 682) BUG("parse_long_opt() cannot return these");

pkt-line.c
37c80012 92) die_errno(_("unable to write flush packet"));
37c80012 99) die_errno(_("unable to write delim packet"));

pretty.c
4f732e0f 1079) return 0;
4f732e0f 1116) return 0;

progress.c
9d81ecb5 243) struct progress *start_delayed_sparse_progress(const char *title,
9d81ecb5 246) return start_progress_delay(title, total, 2, 1);

protocol.c
8cbeba06 38) die("unknown value for %s: %s", git_test_k, git_test_v);

reachable.c
fde67d68 162) static void *lookup_object_by_type(struct repository *r,
fde67d68 166) switch (type) {
fde67d68 168) return lookup_commit(r, oid);
fde67d68 170) return lookup_tree(r, oid);
fde67d68 172) return lookup_tag(r, oid);
fde67d68 174) return lookup_blob(r, oid);
fde67d68 176) die("BUG: unknown object type %d", type);
fde67d68 180) static int mark_object_seen(const struct object_id *oid,
fde67d68 187) struct object *obj = lookup_object_by_type(the_repository, oid, type);
fde67d68 188) if (!obj)
fde67d68 189) die("unable to create object '%s'", oid_to_hex(oid));
fde67d68 191) obj->flags |= SEEN;
fde67d68 192) return 0;
fde67d68 228) traverse_bitmap_commit_list(bitmap_git, mark_object_seen);
fde67d68 229) free_bitmap_index(bitmap_git);
fde67d68 230) return;

remote-curl.c
ed8b4132 157) die(_("invalid quoting in push-option value: '%s'"), value);
aa1edf14 355) die(_("invalid server response; expected service, got flush packet"));
ed8b4132 446) die(_("repository '%s' not found"),
c1284b21 447)     transport_anonymize_url(url.buf));
aa1edf14 584) die(_("shouldn't have EOF when not gentle on EOF"));
a97d0079 615) BUG("The entire rpc->buf should be larger than LARGE_PACKET_MAX");
ed8b4132 664) error(_("unable to rewind rpc post data - try increasing http.postBuffer"));
ed8b4132 764) die(_("cannot handle pushes this big"));
ed8b4132 879) die(_("cannot deflate request; zlib deflate error %d"), ret);
ed8b4132 883) die(_("cannot deflate request; zlib end error %d"), ret);
ed8b4132 1014) die(_("dumb http transport does not support shallow capabilities"));
ed8b4132 1076) die(_("cannot fetch by sha1 over smart http"));
ed8b4132 1119) die(_("protocol error: expected sha/ref, got %s'"), p);
ed8b4132 1125) die(_("protocol error: expected sha/ref, got %s'"), p);
ed8b4132 1137) die(_("http transport does not support %s"), buf->buf);
ed8b4132 1251) die(_("http transport does not support %s"), buf->buf);
a97d0079 1304) rpc.protocol_header = NULL;
a97d0079 1305) strbuf_release(&buf);
a97d0079 1332) BUG("The entire rpc->buf should be larger than LARGE_PACKET_MAX");
ed8b4132 1359) error(_("remote-curl: usage: git remote-curl <remote> [<url>]"));
ed8b4132 1391) error(_("remote-curl: error reading command stream from git"));
ed8b4132 1398) die(_("remote-curl: fetch attempted without a local repo"));
ed8b4132 1438) error(_("remote-curl: unknown command '%s' from git"), buf.buf);

revision.c
d76ce4f7 2654) die("--combined-all-paths makes no sense without -c or --cc");

run-command.c
ee4512ed 239) int ec = errno;
ee4512ed 240) trace2_exec_result(exec_id, ec);
ee4512ed 241) errno = ec;
ee4512ed 997) int ret = wait_or_whine(cmd->pid, cmd->argv[0], 1);
ee4512ed 998) trace2_child_exit(cmd, ret);
ee4512ed 999) return ret;
ee4512ed 1021) int run_command_v_opt_tr2(const char **argv, int opt, const char *tr2_class)
ee4512ed 1023) return run_command_v_opt_cd_env_tr2(argv, opt, NULL, NULL, tr2_class);

strbuf.c
5ef264db 259) die("`pos' is too far after the end of the buffer");
5ef264db 264) BUG("your vsnprintf is broken (returned %d)", len);
5ef264db 266) return; /* nothing to do */
5ef264db 268) die("you want to use way too much memory");
5ef264db 276) BUG("your vsnprintf is broken (returns inconsistent lengths)");
fd2015b3 448) return 0;

t/helper/test-trace2.c
a15860dc 24) return MyError;
a15860dc 28) return MyError;
a15860dc 52) die("expect <exit_code>");
a15860dc 72) die("expect <exit_code>");
a15860dc 92) die("expect <error_message>");
a15860dc 142) return 0;
a15860dc 169) static int ut_005exec(int argc, const char **argv)
a15860dc 173) if (!argc)
a15860dc 174) return 0;
a15860dc 176) result = execv_git_cmd(argv);
a15860dc 177) return result;
a15860dc 186) die("%s", usage_error);
a15860dc 191) die("%s", usage_error);
a15860dc 227) static int print_usage(void)
a15860dc 232) fprintf(stderr, "usage:\n");
a15860dc 233) for_each_ut (k, ut_k)
a15860dc 234) fprintf(stderr, "\t%s %s %s\n", USAGE_PREFIX, ut_k->ut_name,
a15860dc 237) return 129;
a15860dc 272) return print_usage();

trace2.c
ee4512ed 127) static void tr2main_signal_handler(int signo)
ee4512ed 134) us_now = getnanotime() / 1000;
ee4512ed 135) us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
ee4512ed 137) for_each_wanted_builtin (j, tgt_j)
ee4512ed 138) if (tgt_j->pfn_signal)
ee4512ed 139) tgt_j->pfn_signal(us_elapsed_absolute, signo);
ee4512ed 141) sigchain_pop(signo);
ee4512ed 142) raise(signo);
ee4512ed 143) }
ee4512ed 151) return;
ee4512ed 232) void trace2_cmd_path_fl(const char *file, int line, const char *pathname)
ee4512ed 237) if (!trace2_enabled)
ee4512ed 238) return;
ee4512ed 240) for_each_wanted_builtin (j, tgt_j)
ee4512ed 241) if (tgt_j->pfn_command_path_fl)
ee4512ed 242) tgt_j->pfn_command_path_fl(file, line, pathname);
ee4512ed 270) for_each_wanted_builtin (j, tgt_j)
ee4512ed 271) if (tgt_j->pfn_command_mode_fl)
ee4512ed 272) tgt_j->pfn_command_mode_fl(file, line, mode);
ee4512ed 284) for_each_wanted_builtin (j, tgt_j)
ee4512ed 285) if (tgt_j->pfn_alias_fl)
ee4512ed 286) tgt_j->pfn_alias_fl(file, line, alias, argv);
ee4512ed 303) tr2_cfg_set_fl(file, line, key, value);
ee4512ed 347) us_elapsed_child = 0;
ee4512ed 370) us_now = getnanotime() / 1000;
ee4512ed 371) us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
ee4512ed 373) exec_id = tr2tls_locked_increment(&tr2_next_exec_id);
ee4512ed 375) for_each_wanted_builtin (j, tgt_j)
ee4512ed 376) if (tgt_j->pfn_exec_fl)
ee4512ed 377) tgt_j->pfn_exec_fl(file, line, us_elapsed_absolute,
ee4512ed 380) return exec_id;
ee4512ed 383) void trace2_exec_result_fl(const char *file, int line, int exec_id, int code)
ee4512ed 390) if (!trace2_enabled)
ee4512ed 391) return;
ee4512ed 393) us_now = getnanotime() / 1000;
ee4512ed 394) us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
ee4512ed 396) for_each_wanted_builtin (j, tgt_j)
ee4512ed 397) if (tgt_j->pfn_exec_result_fl)
ee4512ed 398) tgt_j->pfn_exec_result_fl(
ee4512ed 402) void trace2_thread_start_fl(const char *file, int line, const char *thread_name)
ee4512ed 409) if (!trace2_enabled)
ee4512ed 410) return;
ee4512ed 412) if (tr2tls_is_main_thread()) {
ee4512ed 422) trace2_region_enter_printf_fl(file, line, NULL, NULL, NULL,
ee4512ed 425) return;
ee4512ed 428) us_now = getnanotime() / 1000;
ee4512ed 429) us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
ee4512ed 431) tr2tls_create_self(thread_name);
ee4512ed 433) for_each_wanted_builtin (j, tgt_j)
ee4512ed 434) if (tgt_j->pfn_thread_start_fl)
ee4512ed 435) tgt_j->pfn_thread_start_fl(file, line,
ee4512ed 439) void trace2_thread_exit_fl(const char *file, int line)
ee4512ed 447) if (!trace2_enabled)
ee4512ed 448) return;
ee4512ed 450) if (tr2tls_is_main_thread()) {
ee4512ed 461) trace2_region_leave_printf_fl(file, line, NULL, NULL, NULL,
ee4512ed 463) return;
ee4512ed 466) us_now = getnanotime() / 1000;
ee4512ed 467) us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
ee4512ed 474) tr2tls_pop_unwind_self();
ee4512ed 475) us_elapsed_thread = tr2tls_region_elasped_self(us_now);
ee4512ed 477) for_each_wanted_builtin (j, tgt_j)
ee4512ed 478) if (tgt_j->pfn_thread_exit_fl)
ee4512ed 479) tgt_j->pfn_thread_exit_fl(file, line,
ee4512ed 483) tr2tls_unset_self();
ee4512ed 493) return;
ee4512ed 508) if (repo->trace2_repo_id)
ee4512ed 509) return;
ee4512ed 511) repo->trace2_repo_id = tr2tls_locked_increment(&tr2_next_repo_id);
ee4512ed 513) for_each_wanted_builtin (j, tgt_j)
ee4512ed 514) if (tgt_j->pfn_repo_fl)
ee4512ed 515) tgt_j->pfn_repo_fl(file, line, repo);
ee4512ed 531) us_now = getnanotime() / 1000;
ee4512ed 532) us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
ee4512ed 541) for_each_wanted_builtin (j, tgt_j)
ee4512ed 542) if (tgt_j->pfn_region_enter_printf_va_fl)
ee4512ed 543) tgt_j->pfn_region_enter_printf_va_fl(
ee4512ed 547) tr2tls_push_self(us_now);
ee4512ed 602) us_now = getnanotime() / 1000;
ee4512ed 603) us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
ee4512ed 611) us_elapsed_region = tr2tls_region_elasped_self(us_now);
ee4512ed 613) tr2tls_pop_self();
ee4512ed 619) for_each_wanted_builtin (j, tgt_j)
ee4512ed 620) if (tgt_j->pfn_region_leave_printf_va_fl)
ee4512ed 621) tgt_j->pfn_region_leave_printf_va_fl(
ee4512ed 675) return;
ee4512ed 697) strbuf_addf(&buf_string, "%" PRIdMAX, value);
ee4512ed 698) trace2_data_string_fl(file, line, category, repo, key, buf_string.buf);
ee4512ed 699) strbuf_release(&buf_string);
ee4512ed 702) void trace2_data_json_fl(const char *file, int line, const char *category,
ee4512ed 712) if (!trace2_enabled)
ee4512ed 713) return;
ee4512ed 715) us_now = getnanotime() / 1000;
ee4512ed 716) us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
ee4512ed 717) us_elapsed_region = tr2tls_region_elasped_self(us_now);
ee4512ed 719) for_each_wanted_builtin (j, tgt_j)
ee4512ed 720) if (tgt_j->pfn_data_fl)
ee4512ed 721) tgt_j->pfn_data_json_fl(file, line, us_elapsed_absolute,
ee4512ed 726) void trace2_printf_va_fl(const char *file, int line, const char *fmt,
ee4512ed 734) if (!trace2_enabled)
ee4512ed 735) return;
ee4512ed 737) us_now = getnanotime() / 1000;
ee4512ed 738) us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
ee4512ed 744) for_each_wanted_builtin (j, tgt_j)
ee4512ed 745) if (tgt_j->pfn_printf_va_fl)
ee4512ed 746) tgt_j->pfn_printf_va_fl(file, line, us_elapsed_absolute,
ee4512ed 750) void trace2_printf_fl(const char *file, int line, const char *fmt, ...)
ee4512ed 754) va_start(ap, fmt);
ee4512ed 755) trace2_printf_va_fl(file, line, fmt, ap);
ee4512ed 756) va_end(ap);
ee4512ed 757) }

trace2/tr2_cfg.c
ee4512ed 21) return tr2_cfg_count_patterns;
ee4512ed 33) strbuf_setlen(buf, buf->len - 1);
ee4512ed 83) void tr2_cfg_set_fl(const char *file, int line, const char *key,
ee4512ed 86) struct tr2_cfg_data data = { file, line };
ee4512ed 88) if (tr2_cfg_load_patterns() > 0)
ee4512ed 89) tr2_cfg_cb(key, value, &data);
ee4512ed 90) }

trace2/tr2_dst.c
ee4512ed 15) static int tr2_dst_want_warning(void)
ee4512ed 19) if (tr2env_dst_debug == -1) {
ee4512ed 20) const char *env_value = getenv(TR2_ENVVAR_DST_DEBUG);
ee4512ed 21) if (!env_value || !*env_value)
ee4512ed 22) tr2env_dst_debug = 0;
ee4512ed 24) tr2env_dst_debug = atoi(env_value) > 0;
ee4512ed 27) return tr2env_dst_debug;
ee4512ed 43) if (tr2_dst_want_warning())
ee4512ed 44) warning("trace2: could not open '%s' for '%s' tracing: %s",
ee4512ed 45) tgt_value, dst->env_var_name, strerror(errno));
ee4512ed 47) tr2_dst_trace_disable(dst);
ee4512ed 48) return 0;
ee4512ed 63) static int tr2_dst_try_uds_connect(const char *path, int sock_type, int *out_fd)
ee4512ed 68) fd = socket(AF_UNIX, sock_type, 0);
ee4512ed 69) if (fd == -1)
ee4512ed 70) return errno;
ee4512ed 72) sa.sun_family = AF_UNIX;
ee4512ed 73) strlcpy(sa.sun_path, path, sizeof(sa.sun_path));
ee4512ed 75) if (connect(fd, (struct sockaddr *)&sa, sizeof(sa)) == -1) {
ee4512ed 76) int e = errno;
ee4512ed 77) close(fd);
ee4512ed 78) return e;
ee4512ed 81) *out_fd = fd;
ee4512ed 82) return 0;
ee4512ed 88) static int tr2_dst_try_unix_domain_socket(struct tr2_dst *dst,
ee4512ed 91) unsigned int uds_try = 0;
ee4512ed 94) const char *path = NULL;
ee4512ed 107) if (skip_prefix(tgt_value, PREFIX_AF_UNIX_STREAM, &path))
ee4512ed 108) uds_try |= TR2_DST_UDS_TRY_STREAM;
ee4512ed 110) else if (skip_prefix(tgt_value, PREFIX_AF_UNIX_DGRAM, &path))
ee4512ed 111) uds_try |= TR2_DST_UDS_TRY_DGRAM;
ee4512ed 113) else if (skip_prefix(tgt_value, PREFIX_AF_UNIX, &path))
ee4512ed 114) uds_try |= TR2_DST_UDS_TRY_STREAM | TR2_DST_UDS_TRY_DGRAM;
ee4512ed 116) if (!path || !*path) {
ee4512ed 117) if (tr2_dst_want_warning())
ee4512ed 118) warning("trace2: invalid AF_UNIX value '%s' for '%s' tracing",
ee4512ed 121) tr2_dst_trace_disable(dst);
ee4512ed 122) return 0;
ee4512ed 125) if (!is_absolute_path(path) ||
ee4512ed 126)     strlen(path) >= sizeof(((struct sockaddr_un *)0)->sun_path)) {
ee4512ed 127) if (tr2_dst_want_warning())
ee4512ed 128) warning("trace2: invalid AF_UNIX path '%s' for '%s' tracing",
ee4512ed 131) tr2_dst_trace_disable(dst);
ee4512ed 132) return 0;
ee4512ed 135) if (uds_try & TR2_DST_UDS_TRY_STREAM) {
ee4512ed 136) e = tr2_dst_try_uds_connect(path, SOCK_STREAM, &fd);
ee4512ed 137) if (!e)
ee4512ed 138) goto connected;
ee4512ed 139) if (e != EPROTOTYPE)
ee4512ed 140) goto error;
ee4512ed 142) if (uds_try & TR2_DST_UDS_TRY_DGRAM) {
ee4512ed 143) e = tr2_dst_try_uds_connect(path, SOCK_DGRAM, &fd);
ee4512ed 144) if (!e)
ee4512ed 145) goto connected;
ee4512ed 149) if (tr2_dst_want_warning())
ee4512ed 150) warning("trace2: could not connect to socket '%s' for '%s' tracing: %s",
ee4512ed 153) tr2_dst_trace_disable(dst);
ee4512ed 154) return 0;
ee4512ed 157) dst->fd = fd;
ee4512ed 158) dst->need_close = 1;
ee4512ed 159) dst->initialized = 1;
ee4512ed 161) return dst->fd;
ee4512ed 165) static void tr2_dst_malformed_warning(struct tr2_dst *dst,
ee4512ed 168) struct strbuf buf = STRBUF_INIT;
ee4512ed 170) strbuf_addf(&buf, "trace2: unknown value for '%s': '%s'",
ee4512ed 172) warning("%s", buf.buf);
ee4512ed 174) strbuf_release(&buf);
ee4512ed 175) }
ee4512ed 196) dst->fd = STDERR_FILENO;
ee4512ed 197) return dst->fd;
ee4512ed 201) dst->fd = atoi(tgt_value);
ee4512ed 202) return dst->fd;
ee4512ed 209) if (starts_with(tgt_value, PREFIX_AF_UNIX))
ee4512ed 210) return tr2_dst_try_unix_domain_socket(dst, tgt_value);
ee4512ed 214) tr2_dst_malformed_warning(dst, tgt_value);
ee4512ed 215) tr2_dst_trace_disable(dst);
ee4512ed 216) return 0;
ee4512ed 248) if (tr2_dst_want_warning())
ee4512ed 249) warning("unable to write trace to '%s': %s", dst->env_var_name,
ee4512ed 250) strerror(errno));
ee4512ed 251) tr2_dst_trace_disable(dst);

trace2/tr2_sid.c
ee4512ed 27) return;
ee4512ed 59) tr2_sid_compute();

trace2/tr2_tgt_event.c
ee4512ed 57) tr2env_event_nesting_wanted = want_nesting;
ee4512ed 61) tr2env_event_brief = want_brief;
ee4512ed 96)     !strcmp(event_name, "atexit")) {
ee4512ed 158) static void fn_signal(uint64_t us_elapsed_absolute, int signo)
ee4512ed 160) const char *event_name = "signal";
ee4512ed 161) struct json_writer jw = JSON_WRITER_INIT;
ee4512ed 162) double t_abs = (double)us_elapsed_absolute / 1000000.0;
ee4512ed 164) jw_object_begin(&jw, 0);
ee4512ed 165) event_fmt_prepare(event_name, __FILE__, __LINE__, NULL, &jw);
ee4512ed 166) jw_object_double(&jw, "t_abs", 6, t_abs);
ee4512ed 167) jw_object_intmax(&jw, "signo", signo);
ee4512ed 168) jw_end(&jw);
ee4512ed 170) tr2_dst_write_line(&tr2dst_event, &jw.json);
ee4512ed 171) jw_release(&jw);
ee4512ed 172) }
ee4512ed 206) if (fmt && *fmt) {
ee4512ed 207) jw_object_string(jw, field_name, fmt);
ee4512ed 208) return;
ee4512ed 235) static void fn_command_path_fl(const char *file, int line, const char *pathname)
ee4512ed 237) const char *event_name = "cmd_path";
ee4512ed 238) struct json_writer jw = JSON_WRITER_INIT;
ee4512ed 240) jw_object_begin(&jw, 0);
ee4512ed 241) event_fmt_prepare(event_name, file, line, NULL, &jw);
ee4512ed 242) jw_object_string(&jw, "path", pathname);
ee4512ed 243) jw_end(&jw);
ee4512ed 245) tr2_dst_write_line(&tr2dst_event, &jw.json);
ee4512ed 246) jw_release(&jw);
ee4512ed 247) }
ee4512ed 266) static void fn_command_mode_fl(const char *file, int line, const char *mode)
ee4512ed 268) const char *event_name = "cmd_mode";
ee4512ed 269) struct json_writer jw = JSON_WRITER_INIT;
ee4512ed 271) jw_object_begin(&jw, 0);
ee4512ed 272) event_fmt_prepare(event_name, file, line, NULL, &jw);
ee4512ed 273) jw_object_string(&jw, "name", mode);
ee4512ed 274) jw_end(&jw);
ee4512ed 276) tr2_dst_write_line(&tr2dst_event, &jw.json);
ee4512ed 277) jw_release(&jw);
ee4512ed 278) }
ee4512ed 280) static void fn_alias_fl(const char *file, int line, const char *alias,
ee4512ed 283) const char *event_name = "alias";
ee4512ed 284) struct json_writer jw = JSON_WRITER_INIT;
ee4512ed 286) jw_object_begin(&jw, 0);
ee4512ed 287) event_fmt_prepare(event_name, file, line, NULL, &jw);
ee4512ed 288) jw_object_string(&jw, "alias", alias);
ee4512ed 289) jw_object_inline_begin_array(&jw, "argv");
ee4512ed 290) jw_array_argv(&jw, argv);
ee4512ed 291) jw_end(&jw);
ee4512ed 292) jw_end(&jw);
ee4512ed 294) tr2_dst_write_line(&tr2dst_event, &jw.json);
ee4512ed 295) jw_release(&jw);
ee4512ed 296) }
ee4512ed 309) jw_object_string(&jw, "child_class", "hook");
ee4512ed 310) jw_object_string(&jw, "hook_name", cmd->trace2_hook_name);
ee4512ed 317) jw_object_string(&jw, "cd", cmd->dir);
ee4512ed 321) jw_array_string(&jw, "git");
ee4512ed 351) static void fn_thread_start_fl(const char *file, int line,
ee4512ed 354) const char *event_name = "thread_start";
ee4512ed 355) struct json_writer jw = JSON_WRITER_INIT;
ee4512ed 357) jw_object_begin(&jw, 0);
ee4512ed 358) event_fmt_prepare(event_name, file, line, NULL, &jw);
ee4512ed 359) jw_end(&jw);
ee4512ed 361) tr2_dst_write_line(&tr2dst_event, &jw.json);
ee4512ed 362) jw_release(&jw);
ee4512ed 363) }
ee4512ed 365) static void fn_thread_exit_fl(const char *file, int line,
ee4512ed 369) const char *event_name = "thread_exit";
ee4512ed 370) struct json_writer jw = JSON_WRITER_INIT;
ee4512ed 371) double t_rel = (double)us_elapsed_thread / 1000000.0;
ee4512ed 373) jw_object_begin(&jw, 0);
ee4512ed 374) event_fmt_prepare(event_name, file, line, NULL, &jw);
ee4512ed 375) jw_object_double(&jw, "t_rel", 6, t_rel);
ee4512ed 376) jw_end(&jw);
ee4512ed 378) tr2_dst_write_line(&tr2dst_event, &jw.json);
ee4512ed 379) jw_release(&jw);
ee4512ed 380) }
ee4512ed 382) static void fn_exec_fl(const char *file, int line, uint64_t us_elapsed_absolute,
ee4512ed 385) const char *event_name = "exec";
ee4512ed 386) struct json_writer jw = JSON_WRITER_INIT;
ee4512ed 388) jw_object_begin(&jw, 0);
ee4512ed 389) event_fmt_prepare(event_name, file, line, NULL, &jw);
ee4512ed 390) jw_object_intmax(&jw, "exec_id", exec_id);
ee4512ed 391) if (exe)
ee4512ed 392) jw_object_string(&jw, "exe", exe);
ee4512ed 393) jw_object_inline_begin_array(&jw, "argv");
ee4512ed 394) jw_array_argv(&jw, argv);
ee4512ed 395) jw_end(&jw);
ee4512ed 396) jw_end(&jw);
ee4512ed 398) tr2_dst_write_line(&tr2dst_event, &jw.json);
ee4512ed 399) jw_release(&jw);
ee4512ed 400) }
ee4512ed 402) static void fn_exec_result_fl(const char *file, int line,
ee4512ed 406) const char *event_name = "exec_result";
ee4512ed 407) struct json_writer jw = JSON_WRITER_INIT;
ee4512ed 409) jw_object_begin(&jw, 0);
ee4512ed 410) event_fmt_prepare(event_name, file, line, NULL, &jw);
ee4512ed 411) jw_object_intmax(&jw, "exec_id", exec_id);
ee4512ed 412) jw_object_intmax(&jw, "code", code);
ee4512ed 413) jw_end(&jw);
ee4512ed 415) tr2_dst_write_line(&tr2dst_event, &jw.json);
ee4512ed 416) jw_release(&jw);
ee4512ed 417) }
ee4512ed 435) static void fn_repo_fl(const char *file, int line,
ee4512ed 438) const char *event_name = "def_repo";
ee4512ed 439) struct json_writer jw = JSON_WRITER_INIT;
ee4512ed 441) jw_object_begin(&jw, 0);
ee4512ed 442) event_fmt_prepare(event_name, file, line, repo, &jw);
ee4512ed 443) jw_object_string(&jw, "worktree", repo->worktree);
ee4512ed 444) jw_end(&jw);
ee4512ed 446) tr2_dst_write_line(&tr2dst_event, &jw.json);
ee4512ed 447) jw_release(&jw);
ee4512ed 448) }
ee4512ed 450) static void fn_region_enter_printf_va_fl(const char *file, int line,
ee4512ed 457) const char *event_name = "region_enter";
ee4512ed 458) struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
ee4512ed 459) if (ctx->nr_open_regions <= tr2env_event_nesting_wanted) {
ee4512ed 460) struct json_writer jw = JSON_WRITER_INIT;
ee4512ed 462) jw_object_begin(&jw, 0);
ee4512ed 463) event_fmt_prepare(event_name, file, line, repo, &jw);
ee4512ed 464) jw_object_intmax(&jw, "nesting", ctx->nr_open_regions);
ee4512ed 465) if (category)
ee4512ed 466) jw_object_string(&jw, "category", category);
ee4512ed 467) if (label)
ee4512ed 468) jw_object_string(&jw, "label", label);
ee4512ed 469) maybe_add_string_va(&jw, "msg", fmt, ap);
ee4512ed 470) jw_end(&jw);
ee4512ed 472) tr2_dst_write_line(&tr2dst_event, &jw.json);
ee4512ed 473) jw_release(&jw);
ee4512ed 475) }
ee4512ed 477) static void fn_region_leave_printf_va_fl(
ee4512ed 482) const char *event_name = "region_leave";
ee4512ed 483) struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
ee4512ed 484) if (ctx->nr_open_regions <= tr2env_event_nesting_wanted) {
ee4512ed 485) struct json_writer jw = JSON_WRITER_INIT;
ee4512ed 486) double t_rel = (double)us_elapsed_region / 1000000.0;
ee4512ed 488) jw_object_begin(&jw, 0);
ee4512ed 489) event_fmt_prepare(event_name, file, line, repo, &jw);
ee4512ed 490) jw_object_double(&jw, "t_rel", 6, t_rel);
ee4512ed 491) jw_object_intmax(&jw, "nesting", ctx->nr_open_regions);
ee4512ed 492) if (category)
ee4512ed 493) jw_object_string(&jw, "category", category);
ee4512ed 494) if (label)
ee4512ed 495) jw_object_string(&jw, "label", label);
ee4512ed 496) maybe_add_string_va(&jw, "msg", fmt, ap);
ee4512ed 497) jw_end(&jw);
ee4512ed 499) tr2_dst_write_line(&tr2dst_event, &jw.json);
ee4512ed 500) jw_release(&jw);
ee4512ed 502) }
ee4512ed 531) static void fn_data_json_fl(const char *file, int line,
ee4512ed 537) const char *event_name = "data_json";
ee4512ed 538) struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
ee4512ed 539) if (ctx->nr_open_regions <= tr2env_event_nesting_wanted) {
ee4512ed 540) struct json_writer jw = JSON_WRITER_INIT;
ee4512ed 541) double t_abs = (double)us_elapsed_absolute / 1000000.0;
ee4512ed 542) double t_rel = (double)us_elapsed_region / 1000000.0;
ee4512ed 544) jw_object_begin(&jw, 0);
ee4512ed 545) event_fmt_prepare(event_name, file, line, repo, &jw);
ee4512ed 546) jw_object_double(&jw, "t_abs", 6, t_abs);
ee4512ed 547) jw_object_double(&jw, "t_rel", 6, t_rel);
ee4512ed 548) jw_object_intmax(&jw, "nesting", ctx->nr_open_regions);
ee4512ed 549) jw_object_string(&jw, "category", category);
ee4512ed 550) jw_object_string(&jw, "key", key);
ee4512ed 551) jw_object_sub_jw(&jw, "value", value);
ee4512ed 552) jw_end(&jw);
ee4512ed 554) tr2_dst_write_line(&tr2dst_event, &jw.json);
ee4512ed 555) jw_release(&jw);
ee4512ed 557) }

trace2/tr2_tgt_normal.c
ee4512ed 105) static void fn_signal(uint64_t us_elapsed_absolute, int signo)
ee4512ed 107) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed 108) double elapsed = (double)us_elapsed_absolute / 1000000.0;
ee4512ed 110) strbuf_addf(&buf_payload, "signal elapsed:%.6f code:%d", elapsed,
ee4512ed 112) normal_io_write_fl(__FILE__, __LINE__, &buf_payload);
ee4512ed 113) strbuf_release(&buf_payload);
ee4512ed 114) }
ee4512ed 138) if (fmt && *fmt) {
ee4512ed 139) strbuf_addstr(buf, fmt);
ee4512ed 140) return;
ee4512ed 155) static void fn_command_path_fl(const char *file, int line, const char *pathname)
ee4512ed 157) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed 159) strbuf_addf(&buf_payload, "cmd_path %s", pathname);
ee4512ed 160) normal_io_write_fl(file, line, &buf_payload);
ee4512ed 161) strbuf_release(&buf_payload);
ee4512ed 162) }
ee4512ed 176) static void fn_command_mode_fl(const char *file, int line, const char *mode)
ee4512ed 178) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed 180) strbuf_addf(&buf_payload, "cmd_mode %s", mode);
ee4512ed 181) normal_io_write_fl(file, line, &buf_payload);
ee4512ed 182) strbuf_release(&buf_payload);
ee4512ed 183) }
ee4512ed 185) static void fn_alias_fl(const char *file, int line, const char *alias,
ee4512ed 188) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed 190) strbuf_addf(&buf_payload, "alias %s ->", alias);
ee4512ed 191) sq_quote_argv_pretty(&buf_payload, argv);
ee4512ed 192) normal_io_write_fl(file, line, &buf_payload);
ee4512ed 193) strbuf_release(&buf_payload);
ee4512ed 194) }
ee4512ed 196) static void fn_child_start_fl(const char *file, int line,
ee4512ed 200) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed 202) strbuf_addf(&buf_payload, "child_start[%d] ", cmd->trace2_child_id);
ee4512ed 204) if (cmd->dir) {
ee4512ed 205) strbuf_addstr(&buf_payload, " cd");
ee4512ed 206) sq_quote_buf_pretty(&buf_payload, cmd->dir);
ee4512ed 207) strbuf_addstr(&buf_payload, "; ");
ee4512ed 215) if (cmd->git_cmd)
ee4512ed 216) strbuf_addstr(&buf_payload, "git");
ee4512ed 217) sq_quote_argv_pretty(&buf_payload, cmd->argv);
ee4512ed 219) normal_io_write_fl(file, line, &buf_payload);
ee4512ed 220) strbuf_release(&buf_payload);
ee4512ed 221) }
ee4512ed 223) static void fn_child_exit_fl(const char *file, int line,
ee4512ed 227) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed 228) double elapsed = (double)us_elapsed_child / 1000000.0;
ee4512ed 230) strbuf_addf(&buf_payload, "child_exit[%d] pid:%d code:%d elapsed:%.6f",
ee4512ed 232) normal_io_write_fl(file, line, &buf_payload);
ee4512ed 233) strbuf_release(&buf_payload);
ee4512ed 234) }
ee4512ed 236) static void fn_exec_fl(const char *file, int line, uint64_t us_elapsed_absolute,
ee4512ed 239) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed 241) strbuf_addf(&buf_payload, "exec[%d] ", exec_id);
ee4512ed 242) if (exe)
ee4512ed 243) strbuf_addstr(&buf_payload, exe);
ee4512ed 244) sq_quote_argv_pretty(&buf_payload, argv);
ee4512ed 245) normal_io_write_fl(file, line, &buf_payload);
ee4512ed 246) strbuf_release(&buf_payload);
ee4512ed 247) }
ee4512ed 249) static void fn_exec_result_fl(const char *file, int line,
ee4512ed 253) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed 255) strbuf_addf(&buf_payload, "exec_result[%d] code:%d", exec_id, code);
ee4512ed 256) if (code > 0)
ee4512ed 257) strbuf_addf(&buf_payload, " err:%s", strerror(code));
ee4512ed 258) normal_io_write_fl(file, line, &buf_payload);
ee4512ed 259) strbuf_release(&buf_payload);
ee4512ed 260) }
ee4512ed 262) static void fn_param_fl(const char *file, int line, const char *param,
ee4512ed 265) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed 267) strbuf_addf(&buf_payload, "def_param %s=%s", param, value);
ee4512ed 268) normal_io_write_fl(file, line, &buf_payload);
ee4512ed 269) strbuf_release(&buf_payload);
ee4512ed 270) }
ee4512ed 272) static void fn_repo_fl(const char *file, int line,
ee4512ed 275) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed 277) strbuf_addstr(&buf_payload, "worktree ");
ee4512ed 278) sq_quote_buf_pretty(&buf_payload, repo->worktree);
ee4512ed 279) normal_io_write_fl(file, line, &buf_payload);
ee4512ed 280) strbuf_release(&buf_payload);
ee4512ed 281) }
ee4512ed 283) static void fn_printf_va_fl(const char *file, int line,
ee4512ed 287) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed 289) maybe_append_string_va(&buf_payload, fmt, ap);
ee4512ed 290) normal_io_write_fl(file, line, &buf_payload);
ee4512ed 291) strbuf_release(&buf_payload);
ee4512ed 292) }

trace2/tr2_tgt_perf.c
ee4512ed 102) strbuf_addf(buf, "r%d ", repo->trace2_repo_id);
ee4512ed 125) strbuf_addbuf(buf, &dots);
ee4512ed 126) len_indent -= dots.len;
ee4512ed 187) static void fn_signal(uint64_t us_elapsed_absolute, int signo)
ee4512ed 189) const char *event_name = "signal";
ee4512ed 190) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed 192) strbuf_addf(&buf_payload, "signo:%d", signo);
ee4512ed 194) perf_io_write_fl(__FILE__, __LINE__, event_name, NULL,
ee4512ed 196) strbuf_release(&buf_payload);
ee4512ed 197) }
ee4512ed 223) if (fmt && *fmt) {
ee4512ed 224) strbuf_addstr(buf, fmt);
ee4512ed 225) return;
ee4512ed 242) static void fn_command_path_fl(const char *file, int line, const char *pathname)
ee4512ed 244) const char *event_name = "cmd_path";
ee4512ed 245) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed 247) strbuf_addstr(&buf_payload, pathname);
ee4512ed 249) perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
ee4512ed 251) strbuf_release(&buf_payload);
ee4512ed 252) }
ee4512ed 269) static void fn_command_mode_fl(const char *file, int line, const char *mode)
ee4512ed 271) const char *event_name = "cmd_mode";
ee4512ed 272) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed 274) strbuf_addstr(&buf_payload, mode);
ee4512ed 276) perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
ee4512ed 278) strbuf_release(&buf_payload);
ee4512ed 279) }
ee4512ed 281) static void fn_alias_fl(const char *file, int line, const char *alias,
ee4512ed 284) const char *event_name = "alias";
ee4512ed 285) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed 287) strbuf_addf(&buf_payload, "alias:%s argv:", alias);
ee4512ed 288) sq_quote_argv_pretty(&buf_payload, argv);
ee4512ed 290) perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
ee4512ed 292) strbuf_release(&buf_payload);
ee4512ed 293) }
ee4512ed 303) strbuf_addf(&buf_payload, "[ch%d] class:hook hook:%s",
ee4512ed 313) strbuf_addstr(&buf_payload, " cd:");
ee4512ed 314) sq_quote_buf_pretty(&buf_payload, cmd->dir);
ee4512ed 319) strbuf_addstr(&buf_payload, " git");
ee4512ed 341) static void fn_thread_start_fl(const char *file, int line,
ee4512ed 344) const char *event_name = "thread_start";
ee4512ed 345) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed 347) perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
ee4512ed 349) strbuf_release(&buf_payload);
ee4512ed 350) }
ee4512ed 352) static void fn_thread_exit_fl(const char *file, int line,
ee4512ed 356) const char *event_name = "thread_exit";
ee4512ed 357) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed 359) perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
ee4512ed 361) strbuf_release(&buf_payload);
ee4512ed 362) }
ee4512ed 364) static void fn_exec_fl(const char *file, int line, uint64_t us_elapsed_absolute,
ee4512ed 367) const char *event_name = "exec";
ee4512ed 368) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed 370) strbuf_addf(&buf_payload, "id:%d ", exec_id);
ee4512ed 371) strbuf_addstr(&buf_payload, "argv:");
ee4512ed 372) if (exe)
ee4512ed 373) strbuf_addf(&buf_payload, " %s", exe);
ee4512ed 374) sq_quote_argv_pretty(&buf_payload, argv);
ee4512ed 376) perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
ee4512ed 378) strbuf_release(&buf_payload);
ee4512ed 379) }
ee4512ed 381) static void fn_exec_result_fl(const char *file, int line,
ee4512ed 385) const char *event_name = "exec_result";
ee4512ed 386) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed 388) strbuf_addf(&buf_payload, "id:%d code:%d", exec_id, code);
ee4512ed 389) if (code > 0)
ee4512ed 390) strbuf_addf(&buf_payload, " err:%s", strerror(code));
ee4512ed 392) perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
ee4512ed 394) strbuf_release(&buf_payload);
ee4512ed 395) }
ee4512ed 397) static void fn_param_fl(const char *file, int line, const char *param,
ee4512ed 400) const char *event_name = "def_param";
ee4512ed 401) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed 403) strbuf_addf(&buf_payload, "%s:%s", param, value);
ee4512ed 405) perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
ee4512ed 407) strbuf_release(&buf_payload);
ee4512ed 408) }
ee4512ed 410) static void fn_repo_fl(const char *file, int line,
ee4512ed 413) const char *event_name = "def_repo";
ee4512ed 414) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed 416) strbuf_addstr(&buf_payload, "worktree:");
ee4512ed 417) sq_quote_buf_pretty(&buf_payload, repo->worktree);
ee4512ed 419) perf_io_write_fl(file, line, event_name, repo, NULL, NULL, NULL,
ee4512ed 421) strbuf_release(&buf_payload);
ee4512ed 422) }
ee4512ed 424) static void fn_region_enter_printf_va_fl(const char *file, int line,
ee4512ed 431) const char *event_name = "region_enter";
ee4512ed 432) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed 434) if (label)
ee4512ed 435) strbuf_addf(&buf_payload, "label:%s ", label);
ee4512ed 436) maybe_append_string_va(&buf_payload, fmt, ap);
ee4512ed 438) perf_io_write_fl(file, line, event_name, repo, &us_elapsed_absolute,
ee4512ed 440) strbuf_release(&buf_payload);
ee4512ed 441) }
ee4512ed 443) static void fn_region_leave_printf_va_fl(
ee4512ed 448) const char *event_name = "region_leave";
ee4512ed 449) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed 451) if (label)
ee4512ed 452) strbuf_addf(&buf_payload, "label:%s ", label);
ee4512ed 453) maybe_append_string_va(&buf_payload, fmt, ap);
ee4512ed 455) perf_io_write_fl(file, line, event_name, repo, &us_elapsed_absolute,
ee4512ed 457) strbuf_release(&buf_payload);
ee4512ed 458) }
ee4512ed 460) static void fn_data_fl(const char *file, int line, uint64_t us_elapsed_absolute,
ee4512ed 465) const char *event_name = "data";
ee4512ed 466) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed 468) strbuf_addf(&buf_payload, "%s:%s", key, value);
ee4512ed 470) perf_io_write_fl(file, line, event_name, repo, &us_elapsed_absolute,
ee4512ed 472) strbuf_release(&buf_payload);
ee4512ed 473) }
ee4512ed 475) static void fn_data_json_fl(const char *file, int line,
ee4512ed 481) const char *event_name = "data_json";
ee4512ed 482) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed 484) strbuf_addf(&buf_payload, "%s:%s", key, value->json.buf);
ee4512ed 486) perf_io_write_fl(file, line, event_name, repo, &us_elapsed_absolute,
ee4512ed 488) strbuf_release(&buf_payload);
ee4512ed 489) }
ee4512ed 491) static void fn_printf_va_fl(const char *file, int line,
ee4512ed 495) const char *event_name = "printf";
ee4512ed 496) struct strbuf buf_payload = STRBUF_INIT;
ee4512ed 498) maybe_append_string_va(&buf_payload, fmt, ap);
ee4512ed 500) perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
ee4512ed 502) strbuf_release(&buf_payload);
ee4512ed 503) }

trace2/tr2_tls.c
ee4512ed 38) strbuf_addf(&ctx->thread_name, "th%02d:", ctx->thread_id);
ee4512ed 41) strbuf_setlen(&ctx->thread_name, TR2_MAX_THREAD_NAME);
ee4512ed 58) ctx = tr2tls_create_self("unknown");
ee4512ed 63) int tr2tls_is_main_thread(void)
ee4512ed 65) struct tr2tls_thread_ctx *ctx = pthread_getspecific(tr2tls_key);
ee4512ed 67) return ctx == tr2tls_thread_main;
ee4512ed 82) void tr2tls_push_self(uint64_t us_now)
ee4512ed 84) struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
ee4512ed 86) ALLOC_GROW(ctx->array_us_start, ctx->nr_open_regions + 1, ctx->alloc);
ee4512ed 87) ctx->array_us_start[ctx->nr_open_regions++] = us_now;
ee4512ed 88) }
ee4512ed 90) void tr2tls_pop_self(void)
ee4512ed 92) struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
ee4512ed 94) if (!ctx->nr_open_regions)
ee4512ed 95) BUG("no open regions in thread '%s'", ctx->thread_name.buf);
ee4512ed 97) ctx->nr_open_regions--;
ee4512ed 98) }
ee4512ed 105) tr2tls_pop_self();
ee4512ed 115) return 0;
ee4512ed 125) return 0;

worktree.c
e8805af1 465) clear_repository_format(&format);

Commits introducting uncovered code:
Anders Waldenborg	fd2015b3 strbuf: separate callback for strbuf_expand:ing literals
Anders Waldenborg	4f732e0f pretty: allow %(trailers) options with explicit value
Brandon Richardson	cbdeab98 commit-tree: utilize parse-options api
Daniels Umanovskis	0ecb1fc7 branch: introduce --show-current display option
Elijah Newren	d76ce4f7 log,diff-tree: add --combined-all-paths option
Jeff Hostetler	ee4512ed trace2: create new combined trace facility
Jeff Hostetler	eee73d1d trace2:data: add editor/pager child classification
Jeff Hostetler	9d81ecb5 progress: add sparse mode to force 100% complete message
Jeff Hostetler	a15860dc trace2: t/helper/test-trace2, t0210.sh, t0211.sh, t0212.sh
Jeff Hostetler	b3a5d5a8 trace2:data: add subverb for rebase
Jeff King	8d8c2a5a fsck: always compute USED flags for unreachable objects
Jeff King	37c80012 fetch: avoid calling write_or_die()
Jeff King	057ab54b completion: fix multiple command removals
Jeff King	fde67d68 prune: use bitmaps for reachability traversal
Jeff King	c409d108 pack-objects: drop unused parameter from oe_map_new_pack()
Jeff King	d55a30bb prune: lazily perform reachability traversal
Joel Teichroeb	8a0fc8d1 stash: convert apply to builtin
Joel Teichroeb	4e2dd393 stash: convert drop and clear to builtin
Joel Teichroeb	c4de61d7 stash: convert pop to builtin
Johannes Schindelin	7906af0c tests: add a special setup where stash.useBuiltin is off
Johannes Schindelin	cbd29ead built-in rebase: set ORIG_HEAD just once, before the rebase
Johannes Schindelin	ed8b4132 remote-curl: mark all error messages for translation
Johannes Schindelin	c1284b21 curl: anonymize URLs in error messages and warnings
Johannes Schindelin	90a46272 stash: optionally use the scripted version again
Jonathan Tan	a97d0079 remote-curl: use post_rpc() for protocol v2 also
Jonathan Tan	8cbeba06 tests: define GIT_TEST_PROTOCOL_VERSION
Junio C Hamano	bc208ae3 builtin/log: downcase the beginning of error messages
Junio C Hamano	aa1edf14 Merge branch 'js/remote-curl-i18n'
Martin Ågren	e8805af1 setup: fix memory leaks with `struct repository_format`
Michal Suchanek	7af01f23 worktree: fix worktree add race
Nguyễn Thái Ngọc Duy	f476308b diff-parseopt: convert -M|--find-renames
Nguyễn Thái Ngọc Duy	f41179f1 parse-options: avoid magic return codes
Nguyễn Thái Ngọc Duy	202fbb33 parse-options: add one-shot mode
Nguyễn Thái Ngọc Duy	4ce7aab5 diff-parseopt: convert --dirstat and friends
Nguyễn Thái Ngọc Duy	3ebbe289 parse-options: allow ll_callback with OPTION_CALLBACK
Nguyễn Thái Ngọc Duy	f62470c6 parse-options: add OPT_BITOP()
Nguyễn Thái Ngọc Duy	84b5089e diff-parseopt: convert --stat*
Nguyễn Thái Ngọc Duy	ced4e179 diff-parseopt: convert -B|--break-rewrites
Nguyễn Thái Ngọc Duy	bf3ff338 parse-options: stop abusing 'callback' for lowlevel callbacks
Nguyễn Thái Ngọc Duy	af2f3680 diff-parseopt: convert --output-*
Nguyễn Thái Ngọc Duy	125dcea9 diff-parseopt: convert --submodule
Nguyễn Thái Ngọc Duy	d473e2e0 diff.c: convert -U|--unified
Nguyễn Thái Ngọc Duy	e9fb39b6 diff-parseopt: convert --word-diff
Nguyễn Thái Ngọc Duy	7f64850d diff-parseopt: convert -C|--find-copies
Nguyễn Thái Ngọc Duy	10f35b1c diff-parseopt: convert --diff-algorithm
Nguyễn Thái Ngọc Duy	7d7942b7 diff-parseopt: convert --[no-]compact-summary
Paul-Sebastian Ungureanu	d553f538 stash: convert push to builtin
Paul-Sebastian Ungureanu	d4788af8 stash: convert create to builtin
Paul-Sebastian Ungureanu	41e0dd55 stash: convert store to builtin
Paul-Sebastian Ungureanu	40af1468 stash: convert `stash--helper.c` into `stash.c`
Paul-Sebastian Ungureanu	dc7bd382 stash: convert show to builtin
Paul-Sebastian Ungureanu	5ef264db strbuf.c: add `strbuf_insertf()` and `strbuf_vinsertf()`
Paul-Sebastian Ungureanu	1ac528c0 stash: make push -q quiet
Ramsay Jones	9b0bd87e prune-packed: check for too many arguments
Thomas Gummerer	091e04bc checkout: introduce --{,no-}overlay option
Thomas Gummerer	536ec183 entry: support CE_WT_REMOVE flag in checkout_entry
William Hubbs	39ab4d09 config: allow giving separate author and committer idents

