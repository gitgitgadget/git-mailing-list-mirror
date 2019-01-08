Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D2401F803
	for <e@80x24.org>; Tue,  8 Jan 2019 17:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbfAHRu5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 12:50:57 -0500
Received: from mail-qt1-f180.google.com ([209.85.160.180]:42019 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbfAHRu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 12:50:56 -0500
Received: by mail-qt1-f180.google.com with SMTP id d19so5300956qtq.9
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 09:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=vvz+ISF3r0uUr+E7wCN/XxFl73yyz7zOAfYu0RKR/PQ=;
        b=l5lCmZ/kKSArN+DKff97VnLyGT+WSrsRp/s899FuJsku9sfmOGW0cQkJOwLRAX8HIh
         aKzsGEGwRkH/0XzgcKUslPRVqnjfpjQCjakn5Ikcp/Lox/krvBvij1yxf5EBafk56Lub
         Myq/YMiM4g6MqRP+Vv0ZjSUx61G3SEEHDxXBeazTuYacENPsU4zX/962jqx+A0FiEsjq
         dQstJ+nIMTshrJWJA4SbrbIwFVgQKdmIzplLqXPbo2IGfgS14BC18mDD7v9sd2ST1Rqk
         FWJoJxmMKVpOYc4u9S2ysYludl1tgkNUkPOZBees+KySomGWMCQ62iDedFngCCSm2rzJ
         a+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=vvz+ISF3r0uUr+E7wCN/XxFl73yyz7zOAfYu0RKR/PQ=;
        b=cAPRbctgYRZ9PJd/O/ZVDCtyRe5NUZLr2mlN4tbMTszsRlS5Pht8wf1s5pMV+aGWBw
         mhutqylOIpJd7s+KpC3z3T/KJ2ETqUf/qPgMDE3eUyh4RIBJ5uDqRQbscX3VMpoMX/6S
         QBuF38jyq8xdEqadVxo7lvORbchXpQ+QHoj14s5xKzdJeyyFbUsyr1AMRq0dFhygxiof
         ppaQJkGT7SqmhxE7UlLH5fdtUgnP+2xIRMNxrTVhdjU3R6DlmGkoraAVfBnez+xy7KV6
         yzZ4RVdJ87Aw93udil7ZSeHQT6J0Ylh2blQF8KsGZsx3CV0LDxVc7Cxk42JsQFP5rxQo
         wchw==
X-Gm-Message-State: AJcUukevZtqra1HTpCuZ2YyiivAOvPqSHGqtzLWNwzwfT8A88Hi5yb1a
        xfp7IFJfXSLYpEPit1WXeM4bF7Gz
X-Google-Smtp-Source: ALg8bN6in3LUKgLtJt+D2EL34v03ILACnHeT502jxYGkHcc/AvhAWuokQNaPkfmmuiaziy0q6Iu8ug==
X-Received: by 2002:aed:2314:: with SMTP id h20mr2611351qtc.286.1546969852372;
        Tue, 08 Jan 2019 09:50:52 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:6dcd:1b4c:550f:6a75? ([2001:4898:8010:0:5703:1b4c:550f:6a75])
        by smtp.gmail.com with ESMTPSA id x49sm45539014qta.89.2019.01.08.09.50.51
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 09:50:51 -0800 (PST)
To:     Git List <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (Tues, Jan 8)
Message-ID: <ee220b08-0600-b7c1-53ab-f468267a1de7@gmail.com>
Date:   Tue, 8 Jan 2019 12:50:51 -0500
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

[1] https://git.visualstudio.com/git/_build/results?buildId=290

---

pu: a5fd499f842ac17440e29bd610058ccdd3cf24a1
jch: 2ccddf26bf6308d5ea65fa26ffd7372d083bfc16
next: d81d796ee0c49eae40e3f85467a8e6b18022bcea
master: ecbdaf0899161c067986e9d9d564586d4b045d62
master@{1}: b21ebb671bb7dea8d342225f0d66c41f4e54d5ca

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

builtin/archive.c
01f9ec64c8 builtin/archive.c  64) if (starts_with(reader.line, "NACK "))
01f9ec64c8 builtin/archive.c  65) die(_("git archive: NACK %s"), 
reader.line + 5);

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
080448fbe8 builtin/blame.c    930) blame_date_width = sizeof("Thu Oct 19 
16:00");
080448fbe8 builtin/blame.c    931) break;

builtin/config.c
937d6bee9e builtin/config.c      604) oidclr(oid);

builtin/fetch-pack.c
4d0feb7630 builtin/fetch-pack.c 231) get_remote_refs(fd[1], &reader, 
&ref, 0, NULL, NULL);
4d0feb7630 builtin/fetch-pack.c 232) break;

builtin/grep.c
d5498e0871 builtin/grep.c  408) const struct submodule *sub = 
submodule_from_path(superproject,
d5498e0871 builtin/grep.c  426) if (repo_submodule_init(&subrepo, 
superproject, sub)) {
d5498e0871 builtin/grep.c  431) repo_read_gitmodules(&subrepo);
d6af6af1f0 builtin/grep.c  443) 
add_to_alternates_memory(subrepo.objects->odb->path);
d5498e0871 builtin/grep.c  468) object->type == OBJ_COMMIT, &subrepo);
d5498e0871 builtin/grep.c  472) hit = grep_cache(opt, &subrepo, 
pathspec, 1);
d5498e0871 builtin/grep.c  475) repo_clear(&subrepo);

builtin/multi-pack-index.c
5532d59aaa 49) die(_("--batch-size option is only for 'repack' verb"));

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
2ead83aefb  426) ret = error(_("could not read index"));
2ead83aefb  427) goto leave_reset_head;
2ead83aefb  431) ret = error(_("failed to find tree of %s"),
2ead83aefb  433) goto leave_reset_head;
2ead83aefb  437) ret = error(_("failed to find tree of %s"), 
oid_to_hex(oid));
2ead83aefb  438) goto leave_reset_head;
2ead83aefb  450) ret = error(_("could not write index"));
2ead83aefb  451) goto leave_reset_head;
2ead83aefb  469) } else if (old_orig)
2ead83aefb  470) delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
3bd5f07101  546) argv_array_push(&am.args, opts->gpg_sign_opt);
3bd5f07101  580) status = error_errno(_("could not write '%s'"),
3bd5f07101  582) free(rebased_patches);
3bd5f07101  583) argv_array_clear(&am.args);
3bd5f07101  584) return status;
3bd5f07101  594) argv_array_split(&format_patch.args,
3bd5f07101  595)  opts->git_format_patch_opt.buf);
3bd5f07101  603) unlink(rebased_patches);
3bd5f07101  604) free(rebased_patches);
3bd5f07101  605) argv_array_clear(&am.args);
3bd5f07101  607) reset_head(&opts->orig_head, "checkout", 
opts->head_name, 0,
3bd5f07101  609) error(_("\ngit encountered an error while preparing the "
3bd5f07101  616) strbuf_release(&revisions);
3bd5f07101  617) return status;
3bd5f07101  623) status = error_errno(_("could not read '%s'"),
3bd5f07101  625) free(rebased_patches);
3bd5f07101  626) argv_array_clear(&am.args);
3bd5f07101  627) return status;
3bd5f07101  639) argv_array_push(&am.args, opts->gpg_sign_opt);
81ef8ee75d  960) return -1;
d421afa0c6 1448) die(_("--reschedule-failed-exec requires an interactive 
rebase"));
d421afa0c6 1480) die(_("error: cannot combine '--preserve-merges' with "

builtin/receive-pack.c
01f9ec64c8 builtin/receive-pack.c 1587)     reader->line + 8);
01f9ec64c8 builtin/receive-pack.c 1621) die("protocol error: got an 
unexpected packet");

builtin/stash.c
f6bbd78127 builtin/stash--helper.c  127) die(_("'%s' is not a stash-like 
commit"), revision);
f6bbd78127 builtin/stash--helper.c  160) free_stash_info(info);
f6bbd78127 builtin/stash--helper.c  161) fprintf_ln(stderr, _("No stash 
entries found."));
f6bbd78127 builtin/stash--helper.c  162) return -1;
f6bbd78127 builtin/stash--helper.c  197) free_stash_info(info);
cdca49bc4c builtin/stash--helper.c  224) return error(_("git stash clear 
with parameters is "
f6bbd78127 builtin/stash--helper.c  240) return -1;
f6bbd78127 builtin/stash--helper.c  248) return -1;
f6bbd78127 builtin/stash--helper.c  261) return -1;
f6bbd78127 builtin/stash--helper.c  264) return error(_("unable to write 
new index file"));
f6bbd78127 builtin/stash--helper.c  376) remove_path(stash_index_path.buf);
f6bbd78127 builtin/stash--helper.c  377) return -1;
f6bbd78127 builtin/stash--helper.c  404) return -1;
f6bbd78127 builtin/stash--helper.c  407) return error(_("cannot apply a 
stash in the middle of a merge"));
f6bbd78127 builtin/stash--helper.c  417) strbuf_release(&out);
f6bbd78127 builtin/stash--helper.c  418) return error(_("could not 
generate diff %s^!."),
f6bbd78127 builtin/stash--helper.c  425) return error(_("conflicts in 
index."
f6bbd78127 builtin/stash--helper.c  431) return error(_("could not save 
index tree"));
f6bbd78127 builtin/stash--helper.c  438) return error(_("could not 
restore untracked files from stash"));
f6bbd78127 builtin/stash--helper.c  469) return -1;
f6bbd78127 builtin/stash--helper.c  474) strbuf_release(&out);
f6bbd78127 builtin/stash--helper.c  479) strbuf_release(&out);
f6bbd78127 builtin/stash--helper.c  480) return -1;
cdca49bc4c builtin/stash--helper.c  556) return error(_("%s: Could not 
drop stash entry"),
e1d01876a4 builtin/stash--helper.c  631) printf_ln(_("The stash entry is 
kept in case "
b4493f269e builtin/stash--helper.c  765) free_stash_info(&info);
51809c70ca builtin/stash.c          766) 
usage_with_options(git_stash_show_usage, options);
847eb0b0a8 builtin/stash--helper.c  782) stash_msg = "Created via \"git 
stash store\".";
847eb0b0a8 builtin/stash--helper.c  788) if (!quiet) {
847eb0b0a8 builtin/stash--helper.c  789) fprintf_ln(stderr, _("Cannot 
update %s with %s"),
847eb0b0a8 builtin/stash--helper.c  792) return -1;
847eb0b0a8 builtin/stash--helper.c  816) if (!quiet)
847eb0b0a8 builtin/stash--helper.c  817) fprintf_ln(stderr, _("\"git 
stash store\" requires one "
847eb0b0a8 builtin/stash--helper.c  819) return -1;
1f5a011d90 builtin/stash--helper.c  901) return -1;
1f5a011d90 builtin/stash--helper.c  961) ret = -1;
1f5a011d90 builtin/stash--helper.c  962) goto done;
1f5a011d90 builtin/stash--helper.c  967) ret = -1;
1f5a011d90 builtin/stash--helper.c  968) goto done;
1f5a011d90 builtin/stash--helper.c  973) ret = -1;
1f5a011d90 builtin/stash--helper.c  974) goto done;
1f5a011d90 builtin/stash--helper.c 1000) ret = -1;
1f5a011d90 builtin/stash--helper.c 1001) goto done;
1f5a011d90 builtin/stash--helper.c 1012) ret = -1;
1f5a011d90 builtin/stash--helper.c 1013) goto done;
1f5a011d90 builtin/stash--helper.c 1019) ret = -1;
1f5a011d90 builtin/stash--helper.c 1020) goto done;
1f5a011d90 builtin/stash--helper.c 1027) ret = -1;
1f5a011d90 builtin/stash--helper.c 1028) goto done;
1f5a011d90 builtin/stash--helper.c 1053) ret = -1;
1f5a011d90 builtin/stash--helper.c 1054) goto done;
1f5a011d90 builtin/stash--helper.c 1065) ret = -1;
1f5a011d90 builtin/stash--helper.c 1066) goto done;
1f5a011d90 builtin/stash--helper.c 1072) ret = -1;
1f5a011d90 builtin/stash--helper.c 1073) goto done;
1f5a011d90 builtin/stash--helper.c 1084) ret = -1;
1f5a011d90 builtin/stash--helper.c 1085) goto done;
1f5a011d90 builtin/stash--helper.c 1090) ret = -1;
1f5a011d90 builtin/stash--helper.c 1091) goto done;
9a95010a11 builtin/stash--helper.c 1127) fprintf_ln(stderr, _("You do 
not have "
1f5a011d90 builtin/stash--helper.c 1136) ret = 1;
1f5a011d90 builtin/stash--helper.c 1137) goto done;
9a95010a11 builtin/stash--helper.c 1153) if (!quiet)
9a95010a11 builtin/stash--helper.c 1154) fprintf_ln(stderr, _("Cannot 
save the current "
1f5a011d90 builtin/stash--helper.c 1156) ret = -1;
1f5a011d90 builtin/stash--helper.c 1157) goto done;
9a95010a11 builtin/stash--helper.c 1162) if (!quiet)
9a95010a11 builtin/stash--helper.c 1163) fprintf_ln(stderr, _("Cannot save "
1f5a011d90 builtin/stash--helper.c 1165) ret = -1;
1f5a011d90 builtin/stash--helper.c 1166) goto done;
9a95010a11 builtin/stash--helper.c 1173) if (!quiet)
9a95010a11 builtin/stash--helper.c 1174) fprintf_ln(stderr, _("Cannot 
save the current "
1f5a011d90 builtin/stash--helper.c 1176) goto done;
9a95010a11 builtin/stash--helper.c 1182) if (!quiet)
9a95010a11 builtin/stash--helper.c 1183) fprintf_ln(stderr, _("Cannot 
save the current "
1f5a011d90 builtin/stash--helper.c 1185) ret = -1;
1f5a011d90 builtin/stash--helper.c 1186) goto done;
9a95010a11 builtin/stash--helper.c 1210) if (!quiet)
9a95010a11 builtin/stash--helper.c 1211) fprintf_ln(stderr, _("Cannot 
record "
1f5a011d90 builtin/stash--helper.c 1213) ret = -1;
1f5a011d90 builtin/stash--helper.c 1214) goto done;
fa38428f76 builtin/stash--helper.c 1283) ret = -1;
fa38428f76 builtin/stash--helper.c 1284) goto done;
fa38428f76 builtin/stash--helper.c 1294) ret = -1;
9a95010a11 builtin/stash--helper.c 1295) if (!quiet)
9a95010a11 builtin/stash--helper.c 1296) fprintf_ln(stderr, _("Cannot 
initialize stash"));
fa38428f76 builtin/stash--helper.c 1297) goto done;
fa38428f76 builtin/stash--helper.c 1309) ret = -1;
9a95010a11 builtin/stash--helper.c 1310) if (!quiet)
9a95010a11 builtin/stash--helper.c 1311) fprintf_ln(stderr, _("Cannot 
save the current status"));
fa38428f76 builtin/stash--helper.c 1312) goto done;
fa38428f76 builtin/stash--helper.c 1329) ret = -1;
fa38428f76 builtin/stash--helper.c 1348) ret = -1;
fa38428f76 builtin/stash--helper.c 1349) goto done;
fa38428f76 builtin/stash--helper.c 1358) ret = -1;
fa38428f76 builtin/stash--helper.c 1359) goto done;
fa38428f76 builtin/stash--helper.c 1367) ret = -1;
fa38428f76 builtin/stash--helper.c 1376) ret = -1;
fa38428f76 builtin/stash--helper.c 1387) ret = -1;
fa38428f76 builtin/stash--helper.c 1388) goto done;
fa38428f76 builtin/stash--helper.c 1397) ret = -1;
fa38428f76 builtin/stash--helper.c 1398) goto done;
fa38428f76 builtin/stash--helper.c 1406) ret = -1;
fa38428f76 builtin/stash--helper.c 1432) ret = -1;
bec65d5b78 builtin/stash.c         1524) return env;
26799a208f builtin/stash.c         1552) const char *path = 
mkpath("%s/git-legacy-stash",
26799a208f builtin/stash.c         1555) if (sane_execvp(path, (char 
**)argv) < 0)
26799a208f builtin/stash.c         1556) die_errno(_("could not exec 
%s"), path);
51809c70ca builtin/stash.c         1599) 
usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
51809c70ca builtin/stash.c         1627) continue;

builtin/submodule--helper.c
date.c
080448fbe8  113) die("Timestamp too large for this system: %"PRItime, time);
080448fbe8  223) hide.date = 1;
080448fbe8  886) static int auto_date_style(void)
080448fbe8  888) return (isatty(1) || pager_in_use()) ? DATE_HUMAN : 
DATE_NORMAL;
080448fbe8  911) return auto_date_style();

fetch-pack.c
01f9ec64c8  154) die(_("git fetch-pack: expected a flush packet after 
shallow list"));
01f9ec64c8  353) die(_("invalid shallow line: %s"), reader.line);
01f9ec64c8  359) die(_("invalid unshallow line: %s"), reader.line);
01f9ec64c8  361) die(_("object not found: %s"), reader.line);
01f9ec64c8  364) die(_("error in object: %s"), reader.line);
01f9ec64c8  366) die(_("no shallow found: %s"), reader.line);
01f9ec64c8  369) die(_("expected shallow/unshallow, got %s"), reader.line);

list-objects-filter.c
adbdcc0768 118) if (include_it)
e34ec45cce 119) return oidset_remove(filter_data->omits, &obj->oid);
e34ec45cce 121) return oidset_insert(filter_data->omits, &obj->oid);
adbdcc0768 167) already_seen =
adbdcc0768 168) filter_data->current_depth >= seen_info->depth;
adbdcc0768 171) filter_res = LOFR_SKIP_TREE;
adbdcc0768 178) filter_res = LOFR_DO_SHOW;
adbdcc0768 184) filter_res = LOFR_ZERO;

list-objects.c
04dac00473 241) continue;
04dac00473 250) parent->object.flags |= SHOWN;
04dac00473 251) show_edge(parent);
04dac00473 274) tree->object.flags |= UNINTERESTING;

midx.c
0d8e91f58b  806) error(_("did not see pack-file %s to drop"),
0d8e91f58b  808) drop_index++;
0d8e91f58b  809) i--;
0d8e91f58b  810) missing_drops++;
0d8e91f58b  811) continue;
0d8e91f58b  827) error(_("did not see all pack-files to drop"));
0d8e91f58b  828) result = 1;
0d8e91f58b  829) goto cleanup;
0d8e91f58b 1077) return 0;
0d8e91f58b 1092) continue;
0d8e91f58b 1095) continue;
c9b3585980 1130) return 1;
c9b3585980 1146) return 0;
c9b3585980 1155) continue;
c9b3585980 1168) continue;
c9b3585980 1191) error(_("could not start pack-objects"));
c9b3585980 1192) result = 1;
c9b3585980 1193) goto cleanup;
c9b3585980 1210) error(_("could not finish pack-objects"));
c9b3585980 1211) result = 1;
c9b3585980 1212) goto cleanup;

packfile.c
9133688752  369) strbuf_release(&buf);
9133688752  370) return;

pretty.c
4681fe38e1 1069) return 0;
b755bf6f83 1107)     match_placeholder_arg(p, "=on", end) ||
b755bf6f83 1108)     match_placeholder_arg(p, "=true", end)) {

protocol.c
6da1f1a920  37) die(_("Unrecognized protocol version"));
6da1f1a920  39) die(_("Unrecognized protocol_version"));
63bb981502  49) enum protocol_version version = 
parse_protocol_version(git_test_v);
63bb981502  51) if (version == protocol_unknown_version)
63bb981502  52) die("unknown value for %s: %s", git_test_k,
63bb981502  55) return version;

read-cache.c
43bf1db73e 1302) return 0;
43bf1db73e 1323) oidcpy(&backup_prev, &istate->cache[pos]->oid);
43bf1db73e 1343) update_backup_log(istate, &backup_prev, ce);
43bf1db73e 3215) strbuf_release(&sb);
43bf1db73e 3216) return -1;

refs/files-backend.c
c67027c9a9 1892) return;
c67027c9a9 1895) return;

remote-curl.c
6da1f1a920  344) return 0;
34a9469d6a  373) die("invalid server response; expected service, got 
flush packet");
34a9469d6a  397) d->proto_git = 1;

revision.c
497f2693ab  149) return;
497f2693ab  152) return;
497f2693ab  175) break;
04dac00473  197) continue;

send-pack.c
01f9ec64c8 143) return error(_("unable to parse remote unpack status: 
%s"), reader->line);
01f9ec64c8 162) error("invalid ref status from remote: %s", reader->line);
01f9ec64c8 579) receive_unpack_status(&reader);

strbuf.c
bfc3fe33f6  259) die("`pos' is too far after the end of the buffer");
bfc3fe33f6  266) return; /* nothing to do */
bfc3fe33f6  268) die("you want to use way too much memory");
18f8e81091  448) return 0;

submodule.c
26f80ccfc1 1398) strbuf_release(&gitdir);
be76c21282 1521) struct fetch_task *task = task_cb;
be76c21282 1525) fetch_task_release(task);
898c2e65b7 1806) warning(_("Could not unset core.worktree setting in 
submodule '%s'"),

unpack-trees.c
cc14089d7c  206) oidclr(&null_hash);
cc14089d7c  207) new_hash = &null_hash;
6f41cc899b 1716) index_path(NULL, old_hash, ce->name, &st,
6f41cc899b 1972)     old_hash && !lstat(ce->name, &st))
6f41cc899b 1973) index_path(NULL, old_hash, ce->name, &st,
cc14089d7c 2291) if (verify_absent(ce, ERROR_WOULD_LOSE_UNTRACKED_REMOVED,
cc14089d7c 2294) make_backup(ce, &old_hash, NULL, o);

upload-pack.c
01f9ec64c8  428) die("git upload-pack: expected SHA1 list, got '%s'", 
reader->line);

wrapper.c
5efde212fc  70) die("Out of memory, malloc failed (tried to allocate %" 
PRIuMAX " bytes)",
5efde212fc  73) error("Out of memory, malloc failed (tried to allocate 
%" PRIuMAX " bytes)",

Commits introducing uncovered code:
Ævar Arnfjörð Bjarmason      63bb98150: tests: add a special setup where 
for protocol.version
Anders Waldenborg      18f8e8109: strbuf: separate callback for 
strbuf_expand:ing literals
Anders Waldenborg      4681fe38e: pretty: allow showing specific trailers
Anders Waldenborg      b755bf6f8: pretty: allow %(trailers) options with 
explicit value
Derrick Stolee      04dac0047: list-objects: consume sparse tree walk
Derrick Stolee      0d8e91f58: multi-pack-index: implement 'expire' verb
Derrick Stolee      497f2693a: revision: implement sparse algorithm
Derrick Stolee      5532d59aa: multi-pack-index: prepare 'repack' subcommand
Derrick Stolee      913368875: repack: refactor pack deletion for future use
Derrick Stolee      c9b358598: midx: implement midx_repack()
Jeff King      34a9469d6: remote-curl: refactor smart-http discovery
Joel Teichroeb      cdca49bc4: stash: convert drop and clear to builtin
Joel Teichroeb      e1d01876a: stash: convert pop to builtin
Joel Teichroeb      f6bbd7812: stash: convert apply to builtin
Johannes Schindelin      26799a208: stash: optionally use the scripted 
version again
Johannes Schindelin      2ead83aef: rebase: move `reset_head()` into a 
better spot
Johannes Schindelin      3bd5f0710: built-in rebase: call `git am` directly
Johannes Schindelin      81ef8ee75: rebase: introduce a shortcut for 
--reschedule-failed-exec
Johannes Schindelin      bec65d5b7: tests: add a special setup where 
stash.useBuiltin is off
Johannes Schindelin      d421afa0c: rebase: introduce 
--reschedule-failed-exec
Jonathan Tan      4d0feb763: builtin/fetch-pack: support protocol version 2
Josh Steadmon      6da1f1a92: protocol: advertise multiple supported 
versions
Junio C Hamano      d6af6af1f: Merge branch 
'sb/submodule-recursive-fetch-gets-the-tip' into pu
Linus Torvalds      080448fbe: Add 'human' date format
Martin Koegler      5efde212f: zlib.c: use size_t for size
Masaya Suzuki      01f9ec64c: Use packet_reader instead of packet_read_line
Matthew DeVore      adbdcc076: list-objects-filter: teach tree:# how to 
handle >0
Matthew DeVore      e34ec45cc: tree:<depth>: skip some trees even when 
collecting omits
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
Paul-Sebastian Ungureanu      1f5a011d9: stash: convert create to builtin
Paul-Sebastian Ungureanu      51809c70c: stash: convert 
`stash--helper.c` into `stash.c`
Paul-Sebastian Ungureanu      847eb0b0a: stash: convert store to builtin
Paul-Sebastian Ungureanu      9a95010a1: stash: make push -q quiet
Paul-Sebastian Ungureanu      b4493f269: stash: convert show to builtin
Paul-Sebastian Ungureanu      bfc3fe33f: strbuf.c: add 
`strbuf_insertf()` and `strbuf_vinsertf()`
Paul-Sebastian Ungureanu      fa38428f7: stash: convert push to builtin
Stefan Beller      26f80ccfc: submodule: migrate get_next_submodule to 
use repository structs
Stefan Beller      898c2e65b: submodule: unset core.worktree if no 
working tree is present
Stefan Beller      be76c2128: fetch: ensure submodule objects fetched
Stefan Beller      d5498e087: repository: repo_submodule_init to take a 
submodule struct



Uncovered code in 'jch' not in 'next'
----------------------------------------

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
7bdbccf4cb builtin/branch.c 370) strbuf_addf(&local, 
"%s%%(if:notequals=*)%%(HEAD)%%(then)%%(if)%%(worktreepath)%%(then)%%(worktreepath) 
%%(end)%%(end)%s",
0ecb1fc726 builtin/branch.c 460) die(_("could not resolve HEAD"));
0ecb1fc726 builtin/branch.c 466) die(_("HEAD (%s) points outside of 
refs/heads/"), refname);

builtin/checkout.c
da1c1cf6f5 builtin/checkout.c  302) return;
da1c1cf6f5 builtin/checkout.c 1268) die(_("'%s' cannot be used with 
switching branches"),

builtin/pull.c
b19eee9066 647) argv_array_push(&args, opt_cleanup);

builtin/remote.c
f39a9c6547 builtin/remote.c 1551) die(_("--save-to-push cannot be used 
with other options"));
f39a9c6547 builtin/remote.c 1575) die(_("--save-to-push can only be used 
when only one url is defined"));

builtin/worktree.c
00a6d4d1d2 752) found_submodules = 1;
00a6d4d1d2 753) break;

commit-graph.c
721351787e  127) return NULL;
721351787e  130) return NULL;
721351787e  186) free(graph);
721351787e  187) return NULL;
721351787e  222) free(graph);
721351787e  223) return NULL;

config.c
7e43b32b58 1488) return git_ident_config(var, value, cb);
7e43b32b58 1491) return git_ident_config(var, value, cb);

entry.c
hex.c
47edb64997  93) char *sha1_to_hex_r(char *buffer, const unsigned char *sha1)
47edb64997  95) return hash_to_hex_algop_r(buffer, sha1, 
&hash_algos[GIT_HASH_SHA1]);
47edb64997 116) char *hash_to_hex(const unsigned char *hash)
47edb64997 118) return hash_to_hex_algop(hash, the_hash_algo);

http-walker.c
e3180fd0b9 http-walker.c 550) loose_object_path(the_repository, &buf, 
&req->oid);

http.c
168badebdd 2004) FILE *new_file = freopen(dest->filename, "w", dest->file);
168badebdd 2005) if (new_file == NULL) {
168badebdd 2006) error("Unable to open local file %s", dest->filename);
168badebdd 2007) return HTTP_ERROR;
168badebdd 2009) dest->file = new_file;

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

read-cache.c
ee70c12820 1736) if (advice_unknown_index_extension) {
ee70c12820 1737) warning(_("ignoring optional %.4s index extension"), ext);
ee70c12820 1738) advise(_("This is likely due to the file having been 
written by a newer\n"

ref-filter.c
1867ce6cbe  254) oi_deref.info.sizep = &oi_deref.size;
1867ce6cbe  263) return strbuf_addf_ret(err, -1, _("unrecognized 
%%(objectsize) argument: %s"), arg);
33311fa1ad  271) return strbuf_addf_ret(err, -1, _("%%(deltabase) does 
not take arguments"));
70550aa6d2  467) return 0;

remote-curl.c
168badebdd  566) return size;

sequencer.c
899b49c446 2393) opts->quiet = 1;

setup.c
07098b81a4 1093) if (!nongit_ok)
07098b81a4 1094) die(_("not a git repository (or any parent up to mount 
point %s)\n"
07098b81a4 1097) *nongit_ok = 1;
07098b81a4 1098) break;

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
e3180fd0b9 sha1-file.c 1294) status = error(_("unable to parse %s 
header"), oid_to_hex(oid));
aff8ab85b9 sha1-file.c 2312) the_hash_algo->final_fn(real_oid.hash, &c);
aff8ab85b9 sha1-file.c 2313) if (!oideq(expected_oid, &real_oid)) {

transport-helper.c
3b3357626e 1029) static int has_attribute(const char *attrs, const char 
*attr)

wrapper.c
e3b1e3bdc0 701) die_errno(_("could not stat %s"), filename);

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
Elijah Newren      899b49c44: git-rebase, sequencer: extend --quiet 
option for the interactive machinery
Erin Dahlgren      07098b81a: Simplify handling of 
setup_git_directory_gently() failure cases.
Jeff King      aff8ab85b: sha1-file: modernize loose header/stream functions
Jeff King      e3180fd0b: sha1-file: modernize loose object file functions
Jonathan Nieder      ee70c1282: index: offer advice for unknown index 
extensions
Josh Steadmon      721351787: commit-graph, fuzz: add fuzzer for 
commit-graph
Masaya Suzuki      168badebd: Change how HTTP response body is returned
Nguyễn Thái Ngọc Duy      00a6d4d1d: worktree: allow to (re)move 
worktrees with uninitialized submodules
Nguyễn Thái Ngọc Duy      3b3357626: style: the opening '{' of a 
function is in a separate line
Nickolai Belakovski      70550aa6d: ref-filter: add worktreepath atom
Nickolai Belakovski      7bdbccf4c: branch: add an extra verbose output 
displaying worktree path for checked out branch
Olga Telezhnaya      1867ce6cb: ref-filter: add objectsize:disk option
Olga Telezhnaya      33311fa1a: ref-filter: add deltabase option
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
Thomas Gummerer      da1c1cf6f: checkout: introduce --{,no-}overlay option
William Hubbs      7e43b32b5: Add author and committer configuration 
settings



Uncovered code in 'next' not in 'master'
--------------------------------------------

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



Uncovered code in 'master' not in 'master@{1}'
----------------------------------------------------

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
3813a89fae builtin/fsck.c 636) fprintf_ln(stderr, _("Checking %s link"), 
head_ref_name);
3813a89fae builtin/fsck.c 641) return error(_("invalid %s"), head_ref_name);
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
3813a89fae 239) die(_("repack: Expecting full hex object ID lines only 
from pack-objects."));
c83d950e59 250) die_errno(_("unable to create '%s'"), promisor_name);
3813a89fae 411) die(_("repack: Expecting full hex object ID lines only 
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
Junio C Hamano      3813a89fa: Merge branch 'nd/i18n'
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


