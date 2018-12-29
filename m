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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D4A01FAC8
	for <e@80x24.org>; Sat, 29 Dec 2018 22:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbeL2Wbs (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Dec 2018 17:31:48 -0500
Received: from mail-qt1-f175.google.com ([209.85.160.175]:46268 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbeL2Wbr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Dec 2018 17:31:47 -0500
Received: by mail-qt1-f175.google.com with SMTP id y20so26537627qtm.13
        for <git@vger.kernel.org>; Sat, 29 Dec 2018 14:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=hWLl5IfT1jPojRxiOK3bm8TqjKrtOia9UZ6MYgupRXw=;
        b=SBgmq/TzNRRdTl2hZubFDqJF6ygnJJyvthN44xxSgk+JHDGP6DPhtsFf7CwuMTr+K5
         GKSDAvp8bnYeyI9Pzj1PnSEiKKUADYmpxCrCyLHshTEjX1uLp/dM1EFqxnmopi6+ydeB
         0CUMxwIZxB8HvjB7gc0nxGppTQ3KNC42Dd7QFEV59HiMx4SM9kQpoz/0LNRsdUl7j4xW
         B+h5zl6nEqfP3jZ266bxAfomVeOXmVSun83JQ6OUDTvkDjyRd+YK4zC8ZDB8WKPknBHp
         y5510hvdkjGxdVbMSj2KHXBJeqP85N3gRuUaTbgFjKuwowp9Qp+AEW6P5z/laa5aDcMP
         jD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=hWLl5IfT1jPojRxiOK3bm8TqjKrtOia9UZ6MYgupRXw=;
        b=al5i3wOHBFlR7FxyaIPaJc2YMgu8DH26vjOkDTiwPaiPyedYTy1cmK5rLtNKOhyw8+
         qcYT99hVqwBNJEJT8UCOKTo8Aa7gQbYdH0nsdj2wn8TzpLtRL4OE5Bp0JnQ+x6ZQkHQW
         2TeKs2DypvsYZnx7ez5jYLad/pLcmj+aqR6Zglx5gwp+I9seWQrdeujGw5i+JNk+nvSw
         h9q4PxqZ+IeCImR3w3KWIos/SPNdEAR6Shgyb1/lbLjmTssoMkvUWSA2m2h3z1JDKo5P
         dMdN4Xv8wSwLA/IIdmcMNh9hFClQpbCHtLEOkje1O6yhT4ba4J4ujC3gwFBtarp9Hy43
         ONqw==
X-Gm-Message-State: AJcUukfhJHeyVTbeRp9iLJOATtgbeYD58S1L4odac0vbXcsIfJn4RKwO
        RHTrgjLmBMnXYi/YOaS9OweEugsE
X-Google-Smtp-Source: ALg8bN4aweG/9uvz1BxM5H2sIlrjSwMMqQ/ppkVRbdD32BhBjiM6PVXdaD/zYDhBOiVNJ4e9mZBXxQ==
X-Received: by 2002:ac8:5392:: with SMTP id x18mr10141557qtp.299.1546122704795;
        Sat, 29 Dec 2018 14:31:44 -0800 (PST)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id k6sm31894121qkk.60.2018.12.29.14.31.43
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Dec 2018 14:31:44 -0800 (PST)
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (Saturday, Dec 29)
Message-ID: <64b1be85-9206-912a-c14c-b1f78ff8b4e9@gmail.com>
Date:   Sat, 29 Dec 2018 17:31:41 -0500
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

Here is today's test coverage report.

Thanks,

-Stolee

[1] https://dev.azure.com/git/git/_build/results?buildId=289

---


pu: e31bc98f4bb8c7cf2a943a3b3b3de69a34a4349c
jch: 5442582aa4fe91238d2c294660d08fc1e0efc8b7
next: 81188d93c3fce477216ba905bd37ab453a74b11d
master: b21ebb671bb7dea8d342225f0d66c41f4e54d5ca
master@{1}: 7a95a1cd084cb665c5c2586a415e42df0213af74

Uncovered code in 'pu' not in 'jch'
--------------------------------------

apply.c
1fcfdf84ce 4275) oidclr(&patch->old_oid);

backup-log.c
fdbbdf809f  25) return error_errno(_("unable to open %s"), path);
fdbbdf809f  27) close(fd);
fdbbdf809f  28) return error_errno(_("unable to update %s"), path);
fdbbdf809f  41) return -1;
102b7856e3  63) return -1;/* corrupt? */
102b7856e3  71) return -1; /* corrupt? */
102b7856e3  75) message += 6;
102b7856e3 105) if (errno == ENOENT || errno == ENOTDIR)
102b7856e3 106) return 0;
102b7856e3 107) return -1;
102b7856e3 112) ret = error_errno(_("cannot seek back in %s"), path);
102b7856e3 123) ret = error_errno(_("cannot seek back in %s"), path);
102b7856e3 124) break;
102b7856e3 128) ret = error_errno(_("cannot read %d bytes from %s"),
102b7856e3 130) break;
102b7856e3 189) strbuf_splice(&sb, 0, 0, buf, endp - buf);
102b7856e3 190) break;
102b7856e3 215) return -1;
102b7856e3 219) ret = parse(&sb, data);
bde028c667 232) static int good_oid(struct repository *r, const struct 
object_id *oid)
bde028c667 234) if (is_null_oid(oid))
bde028c667 235) return 1;
bde028c667 237) return oid_object_info(r, oid, NULL) == OBJ_BLOB;
bde028c667 240) static int prune_parse(struct strbuf *line, void *data)
bde028c667 242) struct prune_options *opts = data;
bde028c667 245) strbuf_reset(&opts->copy);
bde028c667 246) strbuf_addbuf(&opts->copy, line);
bde028c667 248) if (bkl_parse_entry(line, &entry))
bde028c667 249) return -1;
bde028c667 251) if (entry.timestamp < opts->expire)
bde028c667 252) return 0;
bde028c667 254) if (oideq(&entry.old_oid, &entry.new_oid))
bde028c667 255) return 0;
bde028c667 257) if (!good_oid(opts->repo, &entry.old_oid) ||
bde028c667 258)     !good_oid(opts->repo, &entry.new_oid))
bde028c667 259) return 0;
bde028c667 261) if (!opts->fp)
bde028c667 262) return -1;
bde028c667 264) fputs(opts->copy.buf, opts->fp);
bde028c667 265) return 0;
bde028c667 278) return error(_("failed to lock '%s'"), path);
bde028c667 287) rollback_lock_file(&lk);
b86e9ac723 301) die(_("failed to prune %s"), "gitdir.bkl");
b86e9ac723 309) if (wt->id)
b86e9ac723 310) die(_("failed to prune %s on working tree '%s'"),
b86e9ac723 313) die(_("failed to prune %s"), "index.bkl");
b86e9ac723 316) if (wt->id)
b86e9ac723 317) die(_("failed to prune %s on working tree '%s'"),
b86e9ac723 320) die(_("failed to prune %s"), "worktree.bkl");
b2069b6eb0 331) static void add_blob_to_pending(const struct object_id *oid,
b2069b6eb0 337) if (!good_oid(cb->revs->repo, oid))
b2069b6eb0 338) return;
b2069b6eb0 340) blob = lookup_blob(cb->revs->repo, oid);
b2069b6eb0 341) blob->object.flags |= cb->flags;
b2069b6eb0 342) add_pending_object(cb->revs, &blob->object, path);
b2069b6eb0 345) static int add_pending(struct strbuf *line, void *cb)
b2069b6eb0 349) if (bkl_parse_entry(line, &entry))
b2069b6eb0 350) return -1;
b2069b6eb0 352) add_blob_to_pending(&entry.old_oid, entry.path, cb);
b2069b6eb0 353) add_blob_to_pending(&entry.new_oid, entry.path, cb);
b2069b6eb0 354) return 0;

bisect.c
04dac00473  661) mark_edges_uninteresting(revs, NULL, 0);

builtin/backup-log.c
fdbbdf809f  28) usage_with_options(backup_log_usage, NULL);
fdbbdf809f  33) die(_("not a valid object name: %s"), argv[2]);
fdbbdf809f  36) die(_("not a valid object name: %s"), argv[3]);
6a05b9ab74  62) return -1;
6a05b9ab74  65) return 2;
6a05b9ab74  69) return 0;
6a05b9ab74  82) return 1;/* treat null oid like empty blob */
6a05b9ab74  86) die(_("object not found: %s"), oid_to_hex(oid));
6a05b9ab74  88) die(_("not a blob: %s"), oid_to_hex(oid));
6a05b9ab74 111) usage_with_options(backup_log_usage, options);
6a05b9ab74 114) die(_("not a valid change id: %s"), argv[0]);
6a05b9ab74 119) die(_("failed to parse '%s'"), log_path);
45f3e0cd9d 130) old = the_hash_algo->empty_blob;
45f3e0cd9d 135) new = the_hash_algo->empty_blob;
45f3e0cd9d 140) return;
45f3e0cd9d 156) return -1;
45f3e0cd9d 162) return 0;
45f3e0cd9d 183) found_dash_dash = 1;
45f3e0cd9d 184) i++;
45f3e0cd9d 185) continue;
45f3e0cd9d 189) exit(128);
45f3e0cd9d 196) die(_("not a valid change id: %s"), arg);
45f3e0cd9d 204) usage_with_options(backup_log_usage, NULL);
45f3e0cd9d 208) die(_("failed to parse '%s'"), log_path);
7f1d166ee1 252) return -1;
7f1d166ee1 255) return 1;
7f1d166ee1 260) return 0;
7f1d166ee1 283) opts.revs.diffopt.output_format = DIFF_FORMAT_PATCH;
7f1d166ee1 284) diff_setup_done(&opts.revs.diffopt);
7f1d166ee1 293) ret = bkl_parse_file(log_path, log_parse, &opts);
7f1d166ee1 298) die(_("failed to parse '%s'"), log_path);
bde028c667 304) static int prune(int argc, const char **argv,
bde028c667 307) timestamp_t expire = time(NULL) - 90 * 24 * 3600;
bde028c667 308) struct option options[] = {
bde028c667 314) argc = parse_options(argc, argv, prefix, options, 
backup_log_usage, 0);
bde028c667 316) return bkl_prune(the_repository, log_path, expire);
fdbbdf809f 323) else if (!strcmp(id, "worktree"))
fdbbdf809f 324) return git_pathdup("worktree.bkl");
fdbbdf809f 325) else if (!strcmp(id, "gitdir"))
fdbbdf809f 326) return git_pathdup("common/gitdir.bkl");
fdbbdf809f 328) die(_("backup log id '%s' is not recognized"), id);
fdbbdf809f 346) die(_("expected a subcommand"));
fdbbdf809f 350) die(_("--id and --path are incompatible"));
fdbbdf809f 354) die(_("either --id or --path is required"));
bde028c667 364) else if (!strcmp(argv[0], "prune"))
bde028c667 365) return prune(argc, argv, prefix, log_path);

builtin/blame.c
74e8221b52 builtin/blame.c    930) blame_date_width = sizeof("Thu Oct 19 
16:00");
74e8221b52 builtin/blame.c    931) break;

builtin/checkout.c
20e835df5c builtin/checkout.c 1271) die(_("'%s' cannot be used with 
switching branches"),
4ed0c8eb49 builtin/checkout.c 1275) die(_("'%s' cannot be used with 
switching branches"),

builtin/config.c
937d6bee9e builtin/config.c      604) oidclr(oid);

builtin/multi-pack-index.c
e86a2be882 49) die(_("--batch-size option is only for 'repack' verb"));

builtin/rebase.c
81ef8ee75d  764) return -1;
d421afa0c6 1253) die(_("--reschedule-failed-exec requires an interactive 
rebase"));
d421afa0c6 1291) die(_("error: cannot combine '--preserve-merges' with "

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

entry.c
list-objects.c
04dac00473 241) continue;
04dac00473 250) parent->object.flags |= SHOWN;
04dac00473 251) show_edge(parent);
04dac00473 274) tree->object.flags |= UNINTERESTING;

midx.c
5518ac8ee4  806) error(_("did not see pack-file %s to drop"),
5518ac8ee4  808) drop_index++;
5518ac8ee4  809) i--;
5518ac8ee4  810) missing_drops++;
5518ac8ee4  826) error(_("did not see all pack-files to drop"));
5518ac8ee4  827) result = 1;
5518ac8ee4  828) goto cleanup;
5518ac8ee4 1078) return 0;
5518ac8ee4 1095) close_pack(m->packs[i]);
5518ac8ee4 1096) m->packs[i] = NULL;
b59c492264 1133) return -1;
b59c492264 1135) return 1;
b59c492264 1151) return 0;
b59c492264 1160) continue;
b59c492264 1173) continue;
b59c492264 1196) error(_("could not start pack-objects"));
b59c492264 1197) result = 1;
b59c492264 1198) goto cleanup;
b59c492264 1215) error(_("could not finish pack-objects"));
b59c492264 1216) result = 1;
b59c492264 1217) goto cleanup;

pretty.c
4681fe38e1 1069) return 0;
b755bf6f83 1107)     match_placeholder_arg(p, "=on", end) ||
b755bf6f83 1108)     match_placeholder_arg(p, "=true", end)) {

protocol.c
24c10f7473  37) die(_("Unrecognized protocol version"));
24c10f7473  39) die(_("Unrecognized protocol_version"));

read-cache.c
43bf1db73e 1323) oidcpy(&backup_prev, &istate->cache[pos]->oid);
43bf1db73e 1343) update_backup_log(istate, &backup_prev, ce);
43bf1db73e 3215) strbuf_release(&sb);
43bf1db73e 3216) return -1;

refs/files-backend.c
c67027c9a9 1892) return;
c67027c9a9 1895) return;

remote-curl.c
24c10f7473  400) return 0;

revision.c
497f2693ab  149) return;
497f2693ab  152) return;
497f2693ab  175) break;
04dac00473  197) continue;

strbuf.c
18f8e81091  397) return 0;

submodule.c
26f80ccfc1 1396) strbuf_release(&gitdir);
be76c21282 1519) struct fetch_task *task = task_cb;
be76c21282 1523) fetch_task_release(task);

unpack-trees.c
cc14089d7c  206) oidclr(&null_hash);
cc14089d7c  207) new_hash = &null_hash;
6f41cc899b 1716) index_path(NULL, old_hash, ce->name, &st,
6f41cc899b 1972)     old_hash && !lstat(ce->name, &st))
6f41cc899b 1973) index_path(NULL, old_hash, ce->name, &st,
cc14089d7c 2291) if (verify_absent(ce, ERROR_WOULD_LOSE_UNTRACKED_REMOVED,
cc14089d7c 2294) make_backup(ce, &old_hash, NULL, o);

wrapper.c
5efde212fc  70) die("Out of memory, malloc failed (tried to allocate %" 
PRIuMAX " bytes)",
5efde212fc  73) error("Out of memory, malloc failed (tried to allocate 
%" PRIuMAX " bytes)",

Commits introducing uncovered code:
Anders Waldenborg      18f8e8109: strbuf: separate callback for 
strbuf_expand:ing literals
Anders Waldenborg      4681fe38e: pretty: allow showing specific trailers
Anders Waldenborg      b755bf6f8: pretty: allow %(trailers) options with 
explicit value
Derrick Stolee      04dac0047: list-objects: consume sparse tree walk
Derrick Stolee      497f2693a: revision: implement sparse algorithm
Derrick Stolee      5518ac8ee: multi-pack-index: implement 'expire' verb
Derrick Stolee      b59c49226: multi-pack-index: implement midx_repack()
Derrick Stolee      e86a2be88: multi-pack-index: prepare 'repack' verb
Johannes Schindelin      81ef8ee75: rebase: introduce a shortcut for 
--reschedule-failed-exec
Johannes Schindelin      d421afa0c: rebase: introduce 
--reschedule-failed-exec
Josh Steadmon      24c10f747: protocol: advertise multiple supported 
versions
Linus Torvalds      74e8221b5: Add 'human' date format
Martin Koegler      5efde212f: zlib.c: use size_t for size
Nguyễn Thái Ngọc Duy      102b7856e: backup-log.c: add API for walking 
backup log
Nguyễn Thái Ngọc Duy      1fcfdf84c: apply: support backup log with 
--keep-backup
Nguyễn Thái Ngọc Duy      43bf1db73: read-cache.c: new flag for 
add_index_entry() to write to backup log
Nguyễn Thái Ngọc Duy      45f3e0cd9: backup-log: add diff command
Nguyễn Thái Ngọc Duy      6a05b9ab7: backup-log: add cat command
Nguyễn Thái Ngọc Duy      6f41cc899: reset --hard: keep backup of 
overwritten files
Nguyễn Thái Ngọc Duy      7f1d166ee: backup-log: add log command
Nguyễn Thái Ngọc Duy      937d6bee9: config --edit: support backup log
Nguyễn Thái Ngọc Duy      b2069b6eb: backup-log: keep all blob 
references around
Nguyễn Thái Ngọc Duy      b86e9ac72: gc: prune backup logs
Nguyễn Thái Ngọc Duy      bde028c66: backup-log: add prune command
Nguyễn Thái Ngọc Duy      c67027c9a: refs: keep backup of deleted reflog
Nguyễn Thái Ngọc Duy      cc14089d7: unpack-trees.c: keep backup of 
ignored files being overwritten
Nguyễn Thái Ngọc Duy      fdbbdf809: backup-log: add "update" subcommand
Stefan Beller      26f80ccfc: submodule: migrate get_next_submodule to 
use repository structs
Stefan Beller      be76c2128: fetch: ensure submodule objects fetched
Thomas Gummerer      20e835df5: checkout: add --cached option
Thomas Gummerer      4ed0c8eb4: checkout: introduce --{,no-}overlay option



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

builtin/remote.c
f39a9c6547 builtin/remote.c 1551) die(_("--save-to-push cannot be used 
with other options"));
f39a9c6547 builtin/remote.c 1575) die(_("--save-to-push can only be used 
when only one url is defined"));

commit-graph.c
721351787e  128) return NULL;
721351787e  131) return NULL;
721351787e  187) free(graph);
721351787e  188) return NULL;
721351787e  223) free(graph);
721351787e  224) return NULL;

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
ec36c42a63 3508) const char *index = NULL;
ec36c42a63 3514) if (!offset)
ec36c42a63 3515) return NULL;
ec36c42a63 3516) while (offset <= mmap_size - the_hash_algo->rawsz - 8) {
ec36c42a63 3517) extsize = get_be32(mmap + offset + 4);
ec36c42a63 3518) if (CACHE_EXT((mmap + offset)) == 
CACHE_EXT_INDEXENTRYOFFSETTABLE) {
ec36c42a63 3519) index = mmap + offset + 4 + 4;
ec36c42a63 3520) break;
ec36c42a63 3522) offset += 8;
ec36c42a63 3523) offset += extsize;
ec36c42a63 3525) if (!index)
ec36c42a63 3526) return NULL;
ec36c42a63 3529) ext_version = get_be32(index);
ec36c42a63 3530) if (ext_version != IEOT_VERSION) {
ec36c42a63 3531) error("invalid IEOT version %d", ext_version);
ec36c42a63 3532) return NULL;
ec36c42a63 3534) index += sizeof(uint32_t);
ec36c42a63 3537) nr = (extsize - sizeof(uint32_t)) / (sizeof(uint32_t) + 
sizeof(uint32_t));
ec36c42a63 3538) if (!nr) {
ec36c42a63 3539) error("invalid number of IEOT entries %d", nr);
ec36c42a63 3540) return NULL;
ec36c42a63 3542) ieot = xmalloc(sizeof(struct index_entry_offset_table)
ec36c42a63 3543)        + (nr * sizeof(struct index_entry_offset)));
ec36c42a63 3544) ieot->nr = nr;
ec36c42a63 3545) for (i = 0; i < nr; i++) {
ec36c42a63 3546) ieot->entries[i].offset = get_be32(index);
ec36c42a63 3547) index += sizeof(uint32_t);
ec36c42a63 3548) ieot->entries[i].nr = get_be32(index);
ec36c42a63 3549) index += sizeof(uint32_t);
ec36c42a63 3552) return ieot;

ref-filter.c
bbfc042ef9  238) oi_deref.info.sizep = &oi_deref.size;
bbfc042ef9  247) return strbuf_addf_ret(err, -1, _("unrecognized 
%%(objectsize) argument: %s"), arg);
ab0e367154  255) return strbuf_addf_ret(err, -1, _("%%(deltabase) does 
not take arguments"));

remote-curl.c
80bb63786c  359) die("invalid server response; expected service, got 
flush packet");

sequencer.c
18e711a162 2389) opts->quiet = 1;

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

transport-helper.c
3b3357626e 1029) static int has_attribute(const char *attrs, const char 
*attr)

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
Denton Liu      f39a9c654: remote: add --save-to-push option to git 
remote set-url
Elijah Newren      18e711a16: git-rebase, sequencer: extend --quiet 
option for the interactive machinery
Jeff King      80bb63786: remote-curl: refactor smart-http discovery
Jonathan Nieder      ee70c1282: index: offer advice for unknown index 
extensions
Josh Steadmon      721351787: commit-graph, fuzz: add fuzzer for 
commit-graph
Nguyễn Thái Ngọc Duy      0f086e6dc: checkout: print something when 
checking out paths
Nguyễn Thái Ngọc Duy      22af33bec: dir.c: move, rename and export 
match_attrs()
Nguyễn Thái Ngọc Duy      3b3357626: style: the opening '{' of a 
function is in a separate line
Nguyễn Thái Ngọc Duy      e092073d6: tree.c: make read_tree*() take 
'struct repository *'
Nguyễn Thái Ngọc Duy      ec36c42a6: Indent code with TABs
Olga Telezhnaya      ab0e36715: ref-filter: add deltabase option
Olga Telezhnaya      bbfc042ef: ref-filter: add objectsize:disk option



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
674ba34038 builtin/fsck.c 420) return error(_("%s: object corrupt or 
missing"),
674ba34038 builtin/fsck.c 459) fprintf_ln(stderr, _("Checking reflog 
%s->%s"),
674ba34038 builtin/fsck.c 583) error(_("%s: object could not be parsed: 
%s"),
674ba34038 builtin/fsck.c 618) fprintf_ln(stderr, _("Checking object 
directory"));
8e2de8338e builtin/fsck.c 636) fprintf_ln(stderr, _("Checking %s link"), 
head_ref_name);
8e2de8338e builtin/fsck.c 641) return error(_("invalid %s"), head_ref_name);
674ba34038 builtin/fsck.c 670) fprintf_ln(stderr, _("Checking cache tree"));
674ba34038 builtin/fsck.c 686) err |= objerror(obj, _("non-tree in 
cache-tree"));

builtin/merge.c
9440b831ad builtin/merge.c  131) return error(_("option `%s' requires a 
value"), opt->long_name);

builtin/rebase--interactive.c
005af339c9 builtin/rebase--interactive.c  262) ret = 
rearrange_squash(the_repository);
005af339c9 builtin/rebase--interactive.c  265) ret = 
sequencer_add_exec_commands(the_repository, cmd);

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
8e2de8338e 239) die(_("repack: Expecting full hex object ID lines only 
from pack-objects."));
c83d950e59 250) die_errno(_("unable to create '%s'"), promisor_name);
8e2de8338e 411) die(_("repack: Expecting full hex object ID lines only 
from pack-objects."));

bundle.c
74ae4b638d 394) struct commit *one = lookup_commit_reference(revs->repo, 
&oid);

delta-islands.c
385cb64ff3 216) parse_object(r, &obj->oid);

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
8900342628 653) error(_("unknown non-ascii option in string: `%s'"),
9440b831ad 787) strbuf_addf(&sb, "option `no-%s'", opt->long_name);

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
9d0a9e9089 3100) error(_("cannot fix permission bits on '%s'"), 
get_tempfile_path(*temp));
9d0a9e9089 3247) return error(_("%s: cannot drop to stage #0"),

ref-filter.c
9440b831ad 2330) return error(_("option `%s' is incompatible with 
--no-merged"),

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
f0eaf63819 sha1-file.c 2139) return r;

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
Jeff King      b69fb867b: sha1_file_name(): overwrite buffer instead of 
appending
Jeff King      f0eaf6381: sha1-file: use an object_directory for the 
main object dir
Junio C Hamano      8e2de8338: Merge branch 'nd/i18n' into next
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









