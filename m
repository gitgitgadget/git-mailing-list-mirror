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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D3611F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 14:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbeKVBVl (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 20:21:41 -0500
Received: from mail-qk1-f173.google.com ([209.85.222.173]:35937 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbeKVBVl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 20:21:41 -0500
Received: by mail-qk1-f173.google.com with SMTP id o125so5027734qkf.3
        for <git@vger.kernel.org>; Wed, 21 Nov 2018 06:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=xZs8tOdoOcxlM1AYt5RY3oqJvg7hTkv6qnWMuQd517A=;
        b=iIT9WNrRwdDJqgZClFAwrmK8SO3ZorFaaFlS2IQ3JECEMEedE61TkszIZdq66U3bAm
         vmJV3JI9WcoHzhLTpcFf18sgBSWRyXa5PpDWCLrAXNgcFBdHQ3+3Ieor7yA9GxccNi4T
         KcGOZVqogFLFjjq0dbKsbyt7MuMwdArhtLowOriDPeBKfV9J7YZRDagNJUguWpasInfb
         ePzMYxyk4V2oqwfACeTBNVfjRxieL6nGN/2gCAckC/w6gb90Q8R3WryWf1nXphqd6OFU
         VV+gmavu4wS2e66BqUXXW3pC7+ZwK98oIJBSdo+bb+VQd0KhfjVIVS8fhm0cga0s2Qo9
         BdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=xZs8tOdoOcxlM1AYt5RY3oqJvg7hTkv6qnWMuQd517A=;
        b=f4Yg+CYBhmYcvzPJ5ZTNFGH3lNuUFhT6b7V//rTDtFQZkyIBxGqkAMF3GNBnG5o68R
         MTbZcHzBfx3miXWqph2ti296bQOoQDs+JafS6a0PujiPB4TWOcz05u1nvJFyzhhw99gY
         X23WsOHOpEvtyDwDT2xb++5q+kuHgF+yh1V7giIdcLATjTUZp1/iWoLKd0IvAJzNXiVv
         Dtof/WBPcS6OEa98monquN+W+J4eEKLPuwv+/MZyjpeR+QsrEStJYr8OhBJRJOL4mwWB
         XYLNpoZ2M0JBELlvvam4D77wD46pP3iwylgOuuaalZYSazLEvGqvr6KK5QlAs10QKsc/
         tHqg==
X-Gm-Message-State: AA+aEWaMBHmzwH5oq+iQF1j1RsElw8CspnLtZzPmI28HZHpyWqAi4vsK
        IvR4vNsArbWpBsdHhUYeXJ3HTxkW
X-Google-Smtp-Source: AFSGD/WHxh7USDgby9uKpjql6TBkR0HLaWPN759Gaq1IYuQpByCCKVRlQ56834lEOevLS5wgDpQvYA==
X-Received: by 2002:a37:4eca:: with SMTP id c193mr5808417qkb.37.1542811615683;
        Wed, 21 Nov 2018 06:46:55 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:cc42:c99e:79d7:4dba? ([2001:4898:8010:0:b578:c99e:79d7:4dba])
        by smtp.gmail.com with ESMTPSA id v50sm30778874qtc.7.2018.11.21.06.46.54
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 06:46:55 -0800 (PST)
To:     Git List <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (Wednesday Nov 21)
Message-ID: <c24b418a-4998-511b-fe3a-1fb9e814ef89@gmail.com>
Date:   Wed, 21 Nov 2018 09:46:53 -0500
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

Here is today's test report.

Thanks,
-Stolee

[1] https://dev.azure.com/git/git/_build/results?buildId=271&view=logs

---

pu: c4a21f043160e02a25755bbf43e4d2fa0b9766aa
jch: 29ea8ddbcef3ec1c79fffa23cc5751a45344754c
next: 68bc7959f8dc2d629c09be1a52f1b95b977b3a13
master: bb75be6cb916297f271c846f2f9caa3daaaec718
master@{1}: d166e6afe5f257217836ef24a73764eba390c58d

Uncovered code in 'pu' not in 'jch'
--------------------------------------

builtin/blame.c
c4a21f0431 builtin/blame.c    200) 
repo_unuse_commit_buffer(the_repository, commit, message);
74e8221b52 builtin/blame.c    928) blame_date_width = sizeof("Thu Oct 19 
16:00");
74e8221b52 builtin/blame.c    929) break;

builtin/describe.c
c4a21f0431 builtin/describe.c 257) repo_parse_commit(the_repository, p);

builtin/pack-objects.c
c4a21f0431 builtin/pack-objects.c 2834) if 
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

fast-import.c
c4a21f0431 2793) buf = repo_read_object_file(the_repository, oid, &type, 
&size);
c4a21f0431 2899) buf = repo_read_object_file(the_repository, oid, &unused,

fsck.c
c4a21f0431  858) repo_unuse_commit_buffer(the_repository, commit, buffer);
c4a21f0431  878) repo_read_object_file(the_repository,
c4a21f0431  879)       &tag->object.oid, &type, &size);

http-push.c
c4a21f0431 1635) if (!repo_has_object_file(the_repository, &head_oid))
c4a21f0431 1642) if (!repo_has_object_file(the_repository, 
&remote_ref->old_oid))

negotiator/default.c
c4a21f0431  71) if (repo_parse_commit(the_repository, commit))

protocol.c
24c10f7473  37) die(_("Unrecognized protocol version"));
24c10f7473  39) die(_("Unrecognized protocol_version"));

remote-curl.c
24c10f7473  403) return 0;

revision.c
c4a21f0431  726) if (repo_parse_commit(the_repository, p) < 0)

sequencer.c
c4a21f0431 1643) repo_unuse_commit_buffer(the_repository, head_commit,
c4a21f0431 3914) repo_unuse_commit_buffer(the_repository,

sha1-array.c
bba406749a 91) oidcpy(&oids[dst], &oids[src]);

strbuf.c
10a40f5700  397) return 0;

submodule.c
e2419f7e30 1376) strbuf_release(&gitdir);
7454fe5cb6 1499) struct get_next_submodule_task *task = task_cb;
7454fe5cb6 1503) get_next_submodule_task_release(task);
7454fe5cb6 1530) return 0;
7454fe5cb6 1534) goto out;
7454fe5cb6 1549) return 0;

tree.c
c4a21f0431 110) if (repo_parse_commit(the_repository, commit))

wrapper.c
5efde212fc  70) die("Out of memory, malloc failed (tried to allocate %" 
PRIuMAX " bytes)",
5efde212fc  73) error("Out of memory, malloc failed (tried to allocate 
%" PRIuMAX " bytes)",

Commits introducing uncovered code:
Anders Waldenborg      10a40f570: strbuf: separate callback for 
strbuf_expand:ing literals
Denton Liu      b7f4e371e: remote: add --save-to-push option to git 
remote set-url
Josh Steadmon      24c10f747: protocol: advertise multiple supported 
versions
Junio C Hamano      c4a21f043: treewide: apply cocci patch
Linus Torvalds      74e8221b5: Add 'human' date format
Martin Koegler      5efde212f: zlib.c: use size_t for size
Stefan Beller      7454fe5cb: fetch: try fetching submodules if needed 
objects were not fetched
Stefan Beller      bba406749: sha1-array: provide oid_array_filter
Stefan Beller      e2419f7e3: submodule: migrate get_next_submodule to 
use repository structs



Uncovered code in 'jch' not in 'next'
----------------------------------------

apply.c
0f086e6dca 3355) if (checkout_entry(ce, &costate, NULL, NULL) ||
0f086e6dca 3356)     lstat(ce->name, st))

builtin/branch.c
0ecb1fc726 builtin/branch.c 456) die(_("could not resolve HEAD"));
0ecb1fc726 builtin/branch.c 462) die(_("HEAD (%s) points outside of 
refs/heads/"), refname);

builtin/pull.c
b19eee9066 647) argv_array_push(&args, opt_cleanup);

hex.c
47edb64997  93) char *sha1_to_hex_r(char *buffer, const unsigned char *sha1)
47edb64997  95) return hash_to_hex_algop_r(buffer, sha1, 
&hash_algos[GIT_HASH_SHA1]);
47edb64997 116) char *hash_to_hex(const unsigned char *hash)
47edb64997 118) return hash_to_hex_algop(hash, the_hash_algo);

pathspec.c
22af33bece 671) name = to_free = xmemdupz(name, namelen);

read-cache.c
ee70c12820 1730) if (advice_unknown_index_extension) {
ee70c12820 1731) warning(_("ignoring optional %.4s index extension"), ext);
ee70c12820 1732) advise(_("This is likely due to the file having been 
written by a newer\n"

sequencer.c
18e711a162 2387) opts->quiet = 1;

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

tree.c
e092073d64 104) commit = lookup_commit(r, entry.oid);

Commits introducing uncovered code:
brian m. carlson      2f90b9d9b: sha1-file: provide functions to look up 
hash algorithms
brian m. carlson      47edb6499: hex: introduce functions to print 
arbitrary hashes
Daniels Umanovskis      0ecb1fc72: branch: introduce --show-current 
display option
Denton Liu      b19eee906: merge: add scissors line on merge conflict
Elijah Newren      18e711a16: git-rebase, sequencer: extend --quiet 
option for the interactive machinery
Jonathan Nieder      ee70c1282: index: offer advice for unknown index 
extensions
Nguyễn Thái Ngọc Duy      0f086e6dc: checkout: print something when 
checking out paths
Nguyễn Thái Ngọc Duy      22af33bec: dir.c: move, rename and export 
match_attrs()
Nguyễn Thái Ngọc Duy      e092073d6: tree.c: make read_tree*() take 
'struct repository *'



Uncovered code in 'next' not in 'master'
--------------------------------------------

archive.c
c6e7965ddf 399) die(_("not a valid object name: %s"), name);
c6e7965ddf 412) die(_("not a tree object: %s"), oid_to_hex(&oid));
c6e7965ddf 422) die(_("current working directory is untracked"));

attr.c
ad8f8f4aed  369) fprintf_ln(stderr, _("%s not allowed: %s:%d"),

blame.c
fb998eae6c 1717) obj = deref_tag(revs->repo, obj, NULL, 0);
fb998eae6c 1724) head_commit = lookup_commit_reference_gently(revs->repo,

builtin/bundle.c
74ae4b638d builtin/bundle.c 64) return !!unbundle(the_repository, 
&header, bundle_fd, 0) ||

builtin/fast-export.c
b93b81e799 builtin/fast-export.c   52) signed_tag_mode = SIGNED_TAG_ABORT;
b93b81e799 builtin/fast-export.c   70) tag_of_filtered_mode = 
TAG_FILTERING_ABORT;
f129c4275c builtin/fast-export.c  202) if (!p->parents)
f129c4275c builtin/fast-export.c  203) return NULL;
f129c4275c builtin/fast-export.c  204) p = p->parents->item;
f129c4275c builtin/fast-export.c  205) }
843b9e6d48 builtin/fast-export.c  265) die("oid mismatch in blob %s", 
oid_to_hex(oid));
a965bb3116 builtin/fast-export.c  277) printf("original-oid %s\n", 
oid_to_hex(oid));
843b9e6d48 builtin/fast-export.c  356) const unsigned hashsz = 
the_hash_algo->rawsz;
843b9e6d48 builtin/fast-export.c  357) unsigned char *out = 
xcalloc(hashsz, 1);
843b9e6d48 builtin/fast-export.c  358) put_be32(out + hashsz - 4, 
counter++);
843b9e6d48 builtin/fast-export.c  362) static const struct object_id 
*anonymize_oid(const struct object_id *oid)
843b9e6d48 builtin/fast-export.c  365) size_t len = the_hash_algo->rawsz;
843b9e6d48 builtin/fast-export.c  366) return anonymize_mem(&objs, 
generate_fake_oid, oid, &len);
843b9e6d48 builtin/fast-export.c  426) anonymize_oid(&spec->oid) :
a965bb3116 builtin/fast-export.c  644) printf("original-oid %s\n", 
oid_to_hex(&commit->object.oid));
530ca19c02 builtin/fast-export.c  668) printf("%s\n", oid_to_hex(anonymize ?
530ca19c02 builtin/fast-export.c  669) anonymize_oid(&obj->oid) :
f129c4275c builtin/fast-export.c  810) p = rewrite_commit((struct commit 
*)tagged);
f129c4275c builtin/fast-export.c  811) if (!p) {
f129c4275c builtin/fast-export.c  812) printf("reset %s\nfrom %s\n\n",
f129c4275c builtin/fast-export.c  814) free(buf);
f129c4275c builtin/fast-export.c  815) return;
a965bb3116 builtin/fast-export.c  825) printf("original-oid %s\n", 
oid_to_hex(&tag->object.oid));
cd13762d8f builtin/fast-export.c  943) printf("reset %s\nfrom %s\n\n",
cd13762d8f builtin/fast-export.c  945) continue;
530ca19c02 builtin/fast-export.c  960) if (!reference_excluded_commits) {
530ca19c02 builtin/fast-export.c  962) printf("reset %s\nfrom %s\n\n",
530ca19c02 builtin/fast-export.c  964) continue;
530ca19c02 builtin/fast-export.c  967) printf("reset %s\nfrom %s\n\n", name,
530ca19c02 builtin/fast-export.c  968) oid_to_hex(&commit->object.oid));
fdf31b6369 builtin/fast-export.c  969) continue;

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
674ba34038 builtin/fsck.c 421) return error(_("%s: object corrupt or 
missing"),
674ba34038 builtin/fsck.c 460) fprintf_ln(stderr, _("Checking reflog 
%s->%s"),
674ba34038 builtin/fsck.c 584) error(_("%s: object could not be parsed: 
%s"),
674ba34038 builtin/fsck.c 619) fprintf_ln(stderr, _("Checking object 
directory"));
5215bd2f7d builtin/fsck.c 637) fprintf_ln(stderr, _("Checking %s link"), 
head_ref_name);
5215bd2f7d builtin/fsck.c 642) return error(_("invalid %s"), head_ref_name);
674ba34038 builtin/fsck.c 671) fprintf_ln(stderr, _("Checking cache tree"));
674ba34038 builtin/fsck.c 687) err |= objerror(obj, _("non-tree in 
cache-tree"));

builtin/merge.c
9440b831ad builtin/merge.c  131) return error(_("option `%s' requires a 
value"), opt->long_name);

builtin/rebase--interactive.c
005af339c9 builtin/rebase--interactive.c  262) ret = 
rearrange_squash(the_repository);
005af339c9 builtin/rebase--interactive.c  265) ret = 
sequencer_add_exec_commands(the_repository, cmd);

builtin/rebase.c
4d86503eed  585) ret = error(_("failed to find tree of %s"),

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
5215bd2f7d 239) die(_("repack: Expecting full hex object ID lines only 
from pack-objects."));
c83d950e59 250) die_errno(_("unable to create '%s'"), promisor_name);
5215bd2f7d 411) die(_("repack: Expecting full hex object ID lines only 
from pack-objects."));

bundle.c
74ae4b638d 394) struct commit *one = lookup_commit_reference(revs->repo, 
&oid);

config.c
2a9dedef2e 2309) *dest = val ? 0 : 1;
2a9dedef2e 2311) *dest = val;
2a9dedef2e 2312) return 0;

delta-islands.c
385cb64ff3 216) parse_object(r, &obj->oid);

entry.c
e66ceca94b 422) if ((trust_ino && !match_stat_data(&dup->ce_stat_data, 
st)) ||

fast-import.c
a965bb3116 1821) read_next_command();

git.c
8aa8c14097 341) die_errno(_("while expanding alias '%s': '%s'"),
8aa8c14097 350) die(_("alias '%s' changes environment variables.\n"
8aa8c14097 358) die(_("empty alias for %s"), alias_command);
8aa8c14097 361) die(_("recursive alias: %s"), alias_command);
8aa8c14097 412) die(_("%s doesn't support --super-prefix"), p->cmd);
8aa8c14097 436) die_errno(_("write failure on standard output"));
8aa8c14097 438) die(_("unknown write failure on standard output"));
8aa8c14097 440) die_errno(_("close failed on standard output"));
8aa8c14097 657) die(_("%s doesn't support --super-prefix"), argv[0]);
8aa8c14097 769) die(_("cannot handle %s as a builtin"), cmd);

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
9d0a9e9089 2251) warning(_("could not freshen shared index '%s'"), 
shared_index);
9d0a9e9089 2286) die(_("broken index, expect %s in %s, got %s"),
d8465500c3 2699) return val;
429160544d 2714) return val;
9d0a9e9089 3100) error(_("cannot fix permission bits on '%s'"), 
get_tempfile_path(*temp));
9d0a9e9089 3247) return error(_("%s: cannot drop to stage #0"),

ref-filter.c
bbfc042ef9  236) oi_deref.info.sizep = &oi_deref.size;
bbfc042ef9  245) return strbuf_addf_ret(err, -1, _("unrecognized 
%%(objectsize) argument: %s"), arg);
ab0e367154  253) return strbuf_addf_ret(err, -1, _("%%(deltabase) does 
not take arguments"));
9440b831ad 2353) return error(_("option `%s' is incompatible with 
--no-merged"),

remote-curl.c
afa5d74929  359) die("invalid server response; expected service, got 
flush packet");

remote.c
0b9c3afdbf  363) warning(_("config remote shorthand cannot begin with 
'/': %s"),
0b9c3afdbf  418) error(_("more than one uploadpack given, using the 
first"));
0b9c3afdbf  684) die(_("key '%s' of pattern had no '*'"), key);
0b9c3afdbf  694) die(_("value '%s' of pattern has no '*'"), value);
0b9c3afdbf 1102) error(_("unable to delete '%s': remote ref does not 
exist"),
0b9c3afdbf 1121) return error(_("dst ref %s receives from more than one 
src"),
0b9c3afdbf 1840) die(_("couldn't find remote ref %s"), name);
0b9c3afdbf 1853) error(_("* Ignoring funny ref '%s' locally"),
0b9c3afdbf 1948) die(_("revision walk setup failed"));
0b9c3afdbf 2221) return error(_("cannot parse expected object name '%s'"),

sequencer.c
f11c958054  593) istate->cache_tree = cache_tree();
f11c958054 3974) res = error_dirty_index(r->index, opts);

sha1-file.c
f0eaf63819 sha1-file.c 2145) return r;

Commits introducing uncovered code:
Elijah Newren      37b65ce36: merge-recursive: new function for better 
colliding conflict resolutions
Elijah Newren      48c9cb9d6: merge-recursive: improve 
rename/rename(1to2)/add[/add] handling
Elijah Newren      530ca19c0: fast-export: add 
--reference-excluded-parents option
Elijah Newren      7f8671656: merge-recursive: fix rename/add conflict 
handling
Elijah Newren      843b9e6d4: fast-export: convert sha1 to oid
Elijah Newren      a965bb311: fast-export: add a --show-original-ids 
option to show original names
Elijah Newren      b93b81e79: fast-export: use value from correct enum
Elijah Newren      cd13762d8: fast-export: when using paths, avoid 
corrupt stream with non-existent mark
Elijah Newren      f129c4275: fast-export: move commit rewriting logic 
into a function for reuse
Elijah Newren      fdf31b636: fast-export: ensure we export requested refs
Force Charlie      d73019feb: http: add support selecting http version
Jeff King      afa5d7492: remote-curl: refactor smart-http discovery
Jeff King      b69fb867b: sha1_file_name(): overwrite buffer instead of 
appending
Jeff King      f0eaf6381: sha1-file: use an object_directory for the 
main object dir
Johannes Schindelin      4d86503ee: rebase: warn about the correct 
tree's OID
Jonathan Nieder      2a9dedef2: index: make index.threads=true enable 
ieot and eoie
Jonathan Nieder      429160544: ieot: default to not writing IEOT section
Jonathan Nieder      d8465500c: eoie: default to not writing EOIE section
Junio C Hamano      5215bd2f7: Merge branch 'nd/i18n' into next
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
Nguyễn Thái Ngọc Duy      e66ceca94: clone: fix colliding file detection 
on APFS
Nguyễn Thái Ngọc Duy      f11c95805: sequencer.c: remove implicit 
dependency on the_index
Nguyễn Thái Ngọc Duy      fb998eae6: blame.c: remove implicit dependency 
the_repository
Olga Telezhnaya      ab0e36715: ref-filter: add deltabase option
Olga Telezhnaya      bbfc042ef: ref-filter: add objectsize:disk option



Uncovered code in 'master' not in 'master@{1}'
----------------------------------------------------

apply.c
517fe807d6 4776) BUG_ON_OPT_NEG(unset);
735ca208c5 4830) return -1;

builtin/am.c
fce5664805 2117) *opt_value = PATCH_FORMAT_UNKNOWN;

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
517fe807d6 builtin/log.c 1194) BUG_ON_OPT_NEG(unset);

builtin/pack-objects.c
ca473cef91 builtin/pack-objects.c 2086) die(_("object %s inconsistent 
object length (%"PRIuMAX" vs %"PRIuMAX")"),
ca473cef91 builtin/pack-objects.c 2087) oid_to_hex(&trg_entry->idx.oid), 
(uintmax_t)sz,
ca473cef91 builtin/pack-objects.c 2113) die(_("object %s inconsistent 
object length (%"PRIuMAX" vs %"PRIuMAX")"),
ca473cef91 builtin/pack-objects.c 2114) oid_to_hex(&src_entry->idx.oid), 
(uintmax_t)sz,

builtin/pull.c
01a31f3bca 565) die(_("unable to access commit %s"),

builtin/rebase.c
3249c1251e  556) ret = -1;
3249c1251e  557) goto leave_reset_head;
bac2a1e36f  561) ret = error(_("could not determine HEAD revision"));
bac2a1e36f  562) goto leave_reset_head;
3249c1251e  580) ret = error(_("could not read index"));
3249c1251e  581) goto leave_reset_head;
bac2a1e36f  585) ret = error(_("failed to find tree of %s"), 
oid_to_hex(oid));
bac2a1e36f  586) goto leave_reset_head;
3249c1251e  590) ret = error(_("failed to find tree of %s"), 
oid_to_hex(oid));
3249c1251e  591) goto leave_reset_head;
3249c1251e  604) goto leave_reset_head;

builtin/show-branch.c
517fe807d6 builtin/show-branch.c 607) BUG_ON_OPT_NEG(unset);

builtin/show-ref.c
517fe807d6 builtin/show-ref.c 154) BUG_ON_OPT_NEG(unset);

bundle.c
2c8ee1f53c 267) error_errno(_("unable to dup bundle descriptor"));
2c8ee1f53c 268) child_process_clear(&pack_objects);
2c8ee1f53c 269) return -1;
2c8ee1f53c 478) rollback_lock_file(&lock);

config.c
fast-import.c
ca473cef91 2958) strbuf_addf(&line, "%s %s %"PRIuMAX"\n", oid_to_hex(oid),

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
b45424181e 2915) define_commit_slab(author_date_slab, timestamp_t);
b45424181e 2942) return;
b45424181e 2945) return;
b45424181e 2948) record_author_date(&info->author_date, c);
b45424181e 2951) c->object.flags |= UNINTERESTING;
b45424181e 2954) return;
b45424181e 2957) mark_parents_uninteresting(c);
b45424181e 2980) return;
b45424181e 2983) return;
b45424181e 3031) info->topo_queue.compare = compare_commits_by_commit_date;
b45424181e 3032) break;
b45424181e 3034) init_author_date_slab(&info->author_date);
b45424181e 3035) info->topo_queue.compare = compare_commits_by_author_date;
b45424181e 3036) info->topo_queue.cb_data = &info->author_date;
b45424181e 3037) break;
b45424181e 3048) continue;
b45424181e 3059) record_author_date(&info->author_date, c);
f0d9cc4196 3097) if (!revs->ignore_missing_links)
f0d9cc4196 3098) die("Failed to traverse parents of commit %s",
f0d9cc4196 3099)     oid_to_hex(&commit->object.oid));
b45424181e 3107) continue;

run-command.c
2179045fd0 1229) error(_("cannot create async thread: %s"), strerror(err));

send-pack.c
c0e40a2d66 207) close(fd[1]);

Commits introducing uncovered code:
Derrick Stolee      b45424181: revision.c: generation-based topo-order 
algorithm
Derrick Stolee      f0d9cc419: revision.c: begin refactoring 
--topo-order logic
Jeff King      01a31f3bc: pull: handle --verify-signatures for unborn branch
Jeff King      0eb8d3767: cat-file: report an error on multiple --batch 
options
Jeff King      2c8ee1f53: bundle: dup() output descriptor closer to 
point-of-use
Jeff King      517fe807d: assert NOARG/NONEG behavior of parse-options 
callbacks
Jeff King      735ca208c: apply: return -1 from option callback instead 
of calling exit(1)
Jeff King      fce566480: am: handle --no-patch-format option
Johannes Schindelin      3249c1251: rebase: consolidate clean-up code 
before leaving reset_head()
Johannes Schindelin      bac2a1e36: built-in rebase: reinstate `checkout 
-q` behavior where appropriate
Nguyễn Thái Ngọc Duy      2179045fd: Clean up pthread_create() error 
handling
Nguyễn Thái Ngọc Duy      c0e40a2d6: send-pack.c: move async's #ifdef 
NO_PTHREADS back to run-command.c
Nguyễn Thái Ngọc Duy      fd6263fb7: grep: clean up num_threads handling
Torsten Bögershausen      ca473cef9: Upcast size_t variables to 
uintmax_t when printing

