Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86B591F453
	for <e@80x24.org>; Wed,  6 Feb 2019 14:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbfBFOlW (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 09:41:22 -0500
Received: from mail-qt1-f175.google.com ([209.85.160.175]:38524 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfBFOlW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 09:41:22 -0500
Received: by mail-qt1-f175.google.com with SMTP id 2so8050996qtb.5
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 06:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=bTLuJ4YvrydilsjWb+cwcgO/DJTCj7LMmvjbyEj4Dyw=;
        b=MBd1SgTz5RJg9wwh3hVAtWPVSGAIu66dxWuUw47zWigEwo7+CPErD65A17FlUTQdOA
         cxQzuXD0ApYH0mAqvLTwEt4fILeLfzPa1iwhcBkTIzUD5skrPJy8tEZYQXx+YyEGTMu7
         5O5HynbuyymVnDpyOm0dkQ3jIKvbWFCM492TPTY0Is46RMcQ46SF7Cg2gtsU0j2a+Ni/
         K1/5CpY3aSnzI1YA8fV1Ceu3AyN9VEJiysnTyi5vsOXMeGmcNW0AaJ3mFYwO4N/nqeJt
         GDivdHFWZoii1W4LTs82FB1KTr6SkjXovyBSTzIQ9fdgVgJsDKrxVt+JQe0XdWxL3hdB
         xrTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=bTLuJ4YvrydilsjWb+cwcgO/DJTCj7LMmvjbyEj4Dyw=;
        b=atAiSExRbSLv9Yy9yKZGOS8PzEO6o57gU86dksxFRMZOiNSrFTkAJnbNGVQmfTTtDs
         uiNi2rxohLyH0yW/De/optj28JQy4dXhDoQNM+UQr1sAztgVmc8hG2/vg6d2SAIj/TBG
         Az2r3LMReNBi4DFTQyzEfL5M/NDHx5sVLEiDCi3251UOn/B39+Frovo4OBBNYs0eWGuW
         cmEOqVCyV/C5Nf/JxlO8YdE9bmzm3kNiqQYF4US5MiVNkNRPqu98mXyTk4BLrJSCKTmM
         CNZLbx/H5u3Yl8CZJcb4nR4I0gYjfLpc3+gpmPd3YN9l1t9oIMYcypUKgJq2Hh0xNxMX
         BgLA==
X-Gm-Message-State: AHQUAubg43uysaez1VDlqPup8dJHnUasXvQ6VHJWlAUkwJvVhWtUGG0H
        Q7lLE5HKThBMax39II9GoowWZZq/
X-Google-Smtp-Source: AHgI3IZKMjOjxkgRYdqXBq81aXIIcQcgCXh4ju3qQa8J2FU0vXNPN+K55jqKwtK/J3hd3K/FCCbSxw==
X-Received: by 2002:a0c:b11a:: with SMTP id q26mr8162234qvc.2.1549464077076;
        Wed, 06 Feb 2019 06:41:17 -0800 (PST)
Received: from [10.0.1.23] ([98.122.160.2])
        by smtp.gmail.com with ESMTPSA id f33sm11101208qta.91.2019.02.06.06.41.15
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 06:41:16 -0800 (PST)
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (Wednesday, Feb. 6)
Message-ID: <b5ea3297-4893-a8dc-2008-a8e0fbd5e5d6@gmail.com>
Date:   Wed, 6 Feb 2019 09:41:13 -0500
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

Thanks,
-Stolee

[1] https://derrickstolee.github.io/git-test-coverage/reports/2019-02-06.htm
[2] https://derrickstolee.github.io/git-test-coverage/reports/2019-02-06.txt
[3] https://dev.azure.com/git/git/_build/results?buildId=335

---

pu	6e9ee141a1008e2fa8374f008861cd8100bbf922
jch	0dcb92d596127ce52eb144229b8a848ea28433b6
next	b4d0f1c61aafd6cb5c3d9e6ee6bd99a036e3f21d
master	8feddda32cc50e928404788d7b9377c0b5f73f50
master@{1}	16a465bc018d09e9d7bbbdc5f40a7fb99c21f8ef


Uncovered code in 'pu' not in 'jch'
--------------------------------------------------------

builtin/commit.c
8e7e6c05 1668) return 1;

builtin/config.c
a12c1ff3 110) die(_("$HOME not set"));
a12c1ff3 122) given_config_source.file = git_etc_gitconfig();
6f11fd5e 489) BUG("action %d cannot get here", actions);
6f11fd5e 503) die(_("unknown config source"));
6f11fd5e 509) die(_("invalid key pattern: %s"), key);

builtin/gc.c
8e7e6c05 670) return 1;

builtin/rebase.c
34fed676 1224) if (is_interactive(&options))
34fed676 1225) trace2_cmd_mode("interactive");
34fed676 1226) else if (exec.nr)
34fed676 1227) trace2_cmd_mode("interactive-exec");
34fed676 1229) trace2_cmd_mode(action_names[action]);

commit-graph.c
b1beb050 877) error(_("unsupported commit-graph version %d"),
b1beb050 879) return 1;
8e7e6c05 929) error(_("error adding pack %s"), packname.buf);
8e7e6c05 930) res = 1;
8e7e6c05 931) goto cleanup;
8e7e6c05 934) error(_("error opening index for %s"), packname.buf);
8e7e6c05 935) res = 1;
8e7e6c05 936) goto cleanup;
8e7e6c05 1009) error(_("the commit graph format cannot write %d commits"), count_distinct);
8e7e6c05 1010) res = 1;
8e7e6c05 1011) goto cleanup;
8e7e6c05 1045) error(_("too many commits to write graph"));
8e7e6c05 1046) res = 1;
8e7e6c05 1047) goto cleanup;
8e7e6c05 1055) error(_("unable to create leading directories of %s"),
8e7e6c05 1057) res = errno;
8e7e6c05 1058) goto cleanup;

config.c
8f7c7f55 2143) int repo_config_set_gently(struct repository *r,
8f7c7f55 2146) char *path = repo_git_path(r, "config");
8f7c7f55 2147) int ret = git_config_set_multivar_in_file_gently(path, key, value, NULL, 0);
8f7c7f55 2148) free(path);
8f7c7f55 2149) return ret;
8f7c7f55 2152) void repo_config_set(struct repository *r, const char *key, const char *value)
8f7c7f55 2154) if (!repo_config_set_gently(r, key, value))
8f7c7f55 2155) return;
8f7c7f55 2156) if (value)
8f7c7f55 2157) die(_("could not set '%s' to '%s'"), key, value);
8f7c7f55 2159) die(_("could not unset '%s'"), key);
8f7c7f55 2162) int repo_config_set_worktree_gently(struct repository *r,
8f7c7f55 2168) path = get_worktree_config(r);
8f7c7f55 2169) if (!path)
8f7c7f55 2170) return CONFIG_INVALID_FILE;
8f7c7f55 2171) ret = git_config_set_multivar_in_file_gently(path, key, value, NULL, 0);
8f7c7f55 2172) free(path);
8f7c7f55 2173) return ret;

git.c
3c543ab3 155) trace2_cmd_name("_query_");
3c543ab3 159) trace2_cmd_name("_query_");
3c543ab3 163) trace2_cmd_name("_query_");

http.c
ba81921a 1999) if (fflush((FILE *)result)) {
ba81921a 2003) rewind((FILE *)result);
ba81921a 2004) if (ftruncate(fileno((FILE *)result), 0) < 0) {

pager.c
3507f837 103) pager_process->trace2_child_class = "pager";

protocol.c
6da1f1a9 37) die(_("Unrecognized protocol version"));
6da1f1a9 39) die(_("Unrecognized protocol_version"));
6da1f1a9 61) BUG("late attempt to register an allowed protocol version");

ref-filter.c
358c9418 93) keydata_aka_refname ? keydata_aka_refname : k->wt->head_ref);

remote-curl.c
6da1f1a9 404) return 0;

run-command.c
3c543ab3 239) int ec = errno;
3c543ab3 240) trace2_exec_result(exec_id, ec);
3c543ab3 241) errno = ec;
3c543ab3 997) int ret = wait_or_whine(cmd->pid, cmd->argv[0], 1);
3c543ab3 998) trace2_child_exit(cmd, ret);
3c543ab3 999) return ret;
3c543ab3 1021) int run_command_v_opt_tr2(const char **argv, int opt, const char *tr2_class)
3c543ab3 1023) return run_command_v_opt_cd_env_tr2(argv, opt, NULL, NULL, tr2_class);

t/helper/test-trace2.c
7bc0969b 24) return MyError;
7bc0969b 28) return MyError;
7bc0969b 52) die("expect <exit_code>");
7bc0969b 72) die("expect <exit_code>");
7bc0969b 92) die("expect <error_message>");
7bc0969b 142) return 0;
7bc0969b 169) static int ut_005exec(int argc, const char **argv)
7bc0969b 173) if (!argc)
7bc0969b 174) return 0;
7bc0969b 176) result = execv_git_cmd(argv);
7bc0969b 177) return result;
7bc0969b 186) die("%s", usage_error);
7bc0969b 191) die("%s", usage_error);
7bc0969b 227) static int print_usage(void)
7bc0969b 232) fprintf(stderr, "usage:\n");
7bc0969b 233) for_each_ut (k, ut_k)
7bc0969b 234) fprintf(stderr, "\t%s %s %s\n", USAGE_PREFIX, ut_k->ut_name,
7bc0969b 237) return 129;
7bc0969b 272) return print_usage();

trace2.c
3c543ab3 127) static void tr2main_signal_handler(int signo)
3c543ab3 134) us_now = getnanotime() / 1000;
3c543ab3 135) us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
3c543ab3 137) for_each_wanted_builtin (j, tgt_j)
3c543ab3 138) if (tgt_j->pfn_signal)
3c543ab3 139) tgt_j->pfn_signal(us_elapsed_absolute, signo);
3c543ab3 141) sigchain_pop(signo);
3c543ab3 142) raise(signo);
3c543ab3 143) }
3c543ab3 151) return;
3c543ab3 232) void trace2_cmd_path_fl(const char *file, int line, const char *pathname)
3c543ab3 237) if (!trace2_enabled)
3c543ab3 238) return;
3c543ab3 240) for_each_wanted_builtin (j, tgt_j)
3c543ab3 241) if (tgt_j->pfn_command_path_fl)
3c543ab3 242) tgt_j->pfn_command_path_fl(file, line, pathname);
3c543ab3 271) for_each_wanted_builtin (j, tgt_j)
3c543ab3 272) if (tgt_j->pfn_command_mode_fl)
3c543ab3 273) tgt_j->pfn_command_mode_fl(file, line, mode);
3c543ab3 285) for_each_wanted_builtin (j, tgt_j)
3c543ab3 286) if (tgt_j->pfn_alias_fl)
3c543ab3 287) tgt_j->pfn_alias_fl(file, line, alias, argv);
3c543ab3 304) tr2_cfg_set_fl(file, line, key, value);
3c543ab3 348) us_elapsed_child = 0;
3c543ab3 371) us_now = getnanotime() / 1000;
3c543ab3 372) us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
3c543ab3 374) exec_id = tr2tls_locked_increment(&tr2_next_exec_id);
3c543ab3 376) for_each_wanted_builtin (j, tgt_j)
3c543ab3 377) if (tgt_j->pfn_exec_fl)
3c543ab3 378) tgt_j->pfn_exec_fl(file, line, us_elapsed_absolute,
3c543ab3 381) return exec_id;
3c543ab3 384) void trace2_exec_result_fl(const char *file, int line, int exec_id, int code)
3c543ab3 391) if (!trace2_enabled)
3c543ab3 392) return;
3c543ab3 394) us_now = getnanotime() / 1000;
3c543ab3 395) us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
3c543ab3 397) for_each_wanted_builtin (j, tgt_j)
3c543ab3 398) if (tgt_j->pfn_exec_result_fl)
3c543ab3 399) tgt_j->pfn_exec_result_fl(
3c543ab3 403) void trace2_thread_start_fl(const char *file, int line, const char *thread_name)
3c543ab3 410) if (!trace2_enabled)
3c543ab3 411) return;
3c543ab3 413) if (tr2tls_is_main_thread()) {
3c543ab3 423) trace2_region_enter_printf_fl(file, line, NULL, NULL, NULL,
3c543ab3 426) return;
3c543ab3 429) us_now = getnanotime() / 1000;
3c543ab3 430) us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
3c543ab3 432) tr2tls_create_self(thread_name);
3c543ab3 434) for_each_wanted_builtin (j, tgt_j)
3c543ab3 435) if (tgt_j->pfn_thread_start_fl)
3c543ab3 436) tgt_j->pfn_thread_start_fl(file, line,
3c543ab3 440) void trace2_thread_exit_fl(const char *file, int line)
3c543ab3 448) if (!trace2_enabled)
3c543ab3 449) return;
3c543ab3 451) if (tr2tls_is_main_thread()) {
3c543ab3 462) trace2_region_leave_printf_fl(file, line, NULL, NULL, NULL,
3c543ab3 464) return;
3c543ab3 467) us_now = getnanotime() / 1000;
3c543ab3 468) us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
3c543ab3 475) tr2tls_pop_unwind_self();
3c543ab3 476) us_elapsed_thread = tr2tls_region_elasped_self(us_now);
3c543ab3 478) for_each_wanted_builtin (j, tgt_j)
3c543ab3 479) if (tgt_j->pfn_thread_exit_fl)
3c543ab3 480) tgt_j->pfn_thread_exit_fl(file, line,
3c543ab3 484) tr2tls_unset_self();
3c543ab3 494) return;
3c543ab3 509) if (repo->trace2_repo_id)
3c543ab3 510) return;
3c543ab3 512) repo->trace2_repo_id = tr2tls_locked_increment(&tr2_next_repo_id);
3c543ab3 514) for_each_wanted_builtin (j, tgt_j)
3c543ab3 515) if (tgt_j->pfn_repo_fl)
3c543ab3 516) tgt_j->pfn_repo_fl(file, line, repo);
3c543ab3 532) us_now = getnanotime() / 1000;
3c543ab3 533) us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
3c543ab3 542) for_each_wanted_builtin (j, tgt_j)
3c543ab3 543) if (tgt_j->pfn_region_enter_printf_va_fl)
3c543ab3 544) tgt_j->pfn_region_enter_printf_va_fl(
3c543ab3 548) tr2tls_push_self(us_now);
3c543ab3 599) us_now = getnanotime() / 1000;
3c543ab3 600) us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
3c543ab3 608) us_elapsed_region = tr2tls_region_elasped_self(us_now);
3c543ab3 610) tr2tls_pop_self();
3c543ab3 616) for_each_wanted_builtin (j, tgt_j)
3c543ab3 617) if (tgt_j->pfn_region_leave_printf_va_fl)
3c543ab3 618) tgt_j->pfn_region_leave_printf_va_fl(
3c543ab3 669) return;
3c543ab3 691) strbuf_addf(&buf_string, "%" PRIdMAX, value);
3c543ab3 692) trace2_data_string_fl(file, line, category, repo, key, buf_string.buf);
3c543ab3 693) strbuf_release(&buf_string);
3c543ab3 696) void trace2_data_json_fl(const char *file, int line, const char *category,
3c543ab3 706) if (!trace2_enabled)
3c543ab3 707) return;
3c543ab3 709) us_now = getnanotime() / 1000;
3c543ab3 710) us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
3c543ab3 711) us_elapsed_region = tr2tls_region_elasped_self(us_now);
3c543ab3 713) for_each_wanted_builtin (j, tgt_j)
3c543ab3 714) if (tgt_j->pfn_data_fl)
3c543ab3 715) tgt_j->pfn_data_json_fl(file, line, us_elapsed_absolute,
3c543ab3 720) void trace2_printf_va_fl(const char *file, int line, const char *fmt,
3c543ab3 728) if (!trace2_enabled)
3c543ab3 729) return;
3c543ab3 731) us_now = getnanotime() / 1000;
3c543ab3 732) us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
3c543ab3 738) for_each_wanted_builtin (j, tgt_j)
3c543ab3 739) if (tgt_j->pfn_printf_va_fl)
3c543ab3 740) tgt_j->pfn_printf_va_fl(file, line, us_elapsed_absolute,
3c543ab3 744) void trace2_printf_fl(const char *file, int line, const char *fmt, ...)
3c543ab3 748) va_start(ap, fmt);
3c543ab3 749) trace2_printf_va_fl(file, line, fmt, ap);
3c543ab3 750) va_end(ap);
3c543ab3 751) }

trace2/tr2_cfg.c
3c543ab3 21) return tr2_cfg_count_patterns;
3c543ab3 33) strbuf_setlen(buf, buf->len - 1);
3c543ab3 83) void tr2_cfg_set_fl(const char *file, int line, const char *key,
3c543ab3 86) struct tr2_cfg_data data = { file, line };
3c543ab3 88) if (tr2_cfg_load_patterns() > 0)
3c543ab3 89) tr2_cfg_cb(key, value, &data);
3c543ab3 90) }

trace2/tr2_dst.c
3c543ab3 15) static int tr2_dst_want_warning(void)
3c543ab3 19) if (tr2env_dst_debug == -1) {
3c543ab3 20) const char *env_value = getenv(TR2_ENVVAR_DST_DEBUG);
3c543ab3 21) if (!env_value || !*env_value)
3c543ab3 22) tr2env_dst_debug = 0;
3c543ab3 24) tr2env_dst_debug = atoi(env_value) > 0;
3c543ab3 27) return tr2env_dst_debug;
3c543ab3 43) if (tr2_dst_want_warning())
3c543ab3 44) warning("trace2: could not open '%s' for '%s' tracing: %s",
3c543ab3 45) tgt_value, dst->env_var_name, strerror(errno));
3c543ab3 47) tr2_dst_trace_disable(dst);
3c543ab3 48) return 0;
3c543ab3 62) static int tr2_dst_try_unix_domain_socket(struct tr2_dst *dst,
3c543ab3 67) const char *path = tgt_value + PREFIX_AF_UNIX_LEN;
3c543ab3 68) int path_len = strlen(path);
3c543ab3 70) if (!is_absolute_path(path) || path_len >= sizeof(sa.sun_path)) {
3c543ab3 71) if (tr2_dst_want_warning())
3c543ab3 72) warning("trace2: invalid AF_UNIX path '%s' for '%s' tracing",
3c543ab3 75) tr2_dst_trace_disable(dst);
3c543ab3 76) return 0;
3c543ab3 79) sa.sun_family = AF_UNIX;
3c543ab3 80) strlcpy(sa.sun_path, path, sizeof(sa.sun_path));
3c543ab3 81) if ((fd = socket(AF_UNIX, SOCK_STREAM, 0)) == -1 ||
3c543ab3 82)     connect(fd, (struct sockaddr *)&sa, sizeof(sa)) == -1) {
3c543ab3 83) if (tr2_dst_want_warning())
3c543ab3 84) warning("trace2: could not connect to socket '%s' for '%s' tracing: %s",
3c543ab3 85) path, dst->env_var_name, strerror(errno));
3c543ab3 87) tr2_dst_trace_disable(dst);
3c543ab3 88) return 0;
3c543ab3 91) dst->fd = fd;
3c543ab3 92) dst->need_close = 1;
3c543ab3 93) dst->initialized = 1;
3c543ab3 95) return dst->fd;
3c543ab3 99) static void tr2_dst_malformed_warning(struct tr2_dst *dst,
3c543ab3 102) struct strbuf buf = STRBUF_INIT;
3c543ab3 104) strbuf_addf(&buf, "trace2: unknown trace value for '%s': '%s'",
3c543ab3 106) strbuf_addstr(
3c543ab3 111) strbuf_addstr(
3c543ab3 117) warning("%s", buf.buf);
3c543ab3 119) strbuf_release(&buf);
3c543ab3 120) }
3c543ab3 141) dst->fd = STDERR_FILENO;
3c543ab3 142) return dst->fd;
3c543ab3 146) dst->fd = atoi(tgt_value);
3c543ab3 147) return dst->fd;
3c543ab3 154) if (!strncmp(tgt_value, PREFIX_AF_UNIX, PREFIX_AF_UNIX_LEN))
3c543ab3 155) return tr2_dst_try_unix_domain_socket(dst, tgt_value);
3c543ab3 159) tr2_dst_malformed_warning(dst, tgt_value);
3c543ab3 160) tr2_dst_trace_disable(dst);
3c543ab3 161) return 0;
3c543ab3 193) if (tr2_dst_want_warning())
3c543ab3 194) warning("unable to write trace to '%s': %s", dst->env_var_name,
3c543ab3 195) strerror(errno));
3c543ab3 196) tr2_dst_trace_disable(dst);

trace2/tr2_sid.c
3c543ab3 27) return;
3c543ab3 59) tr2_sid_compute();

trace2/tr2_tgt_event.c
3c543ab3 57) tr2env_event_nesting_wanted = want_nesting;
3c543ab3 61) tr2env_event_brief = want_brief;
3c543ab3 96)     !strcmp(event_name, "atexit")) {
3c543ab3 158) static void fn_signal(uint64_t us_elapsed_absolute, int signo)
3c543ab3 160) const char *event_name = "signal";
3c543ab3 161) struct json_writer jw = JSON_WRITER_INIT;
3c543ab3 162) double t_abs = (double)us_elapsed_absolute / 1000000.0;
3c543ab3 164) jw_object_begin(&jw, 0);
3c543ab3 165) event_fmt_prepare(event_name, __FILE__, __LINE__, NULL, &jw);
3c543ab3 166) jw_object_double(&jw, "t_abs", 6, t_abs);
3c543ab3 167) jw_object_intmax(&jw, "signo", signo);
3c543ab3 168) jw_end(&jw);
3c543ab3 170) tr2_dst_write_line(&tr2dst_event, &jw.json);
3c543ab3 171) jw_release(&jw);
3c543ab3 172) }
3c543ab3 206) if (fmt && *fmt) {
3c543ab3 207) jw_object_string(jw, field_name, fmt);
3c543ab3 208) return;
3c543ab3 235) static void fn_command_path_fl(const char *file, int line, const char *pathname)
3c543ab3 237) const char *event_name = "cmd_path";
3c543ab3 238) struct json_writer jw = JSON_WRITER_INIT;
3c543ab3 240) jw_object_begin(&jw, 0);
3c543ab3 241) event_fmt_prepare(event_name, file, line, NULL, &jw);
3c543ab3 242) jw_object_string(&jw, "path", pathname);
3c543ab3 243) jw_end(&jw);
3c543ab3 245) tr2_dst_write_line(&tr2dst_event, &jw.json);
3c543ab3 246) jw_release(&jw);
3c543ab3 247) }
3c543ab3 267) static void fn_command_mode_fl(const char *file, int line, const char *mode)
3c543ab3 269) const char *event_name = "cmd_mode";
3c543ab3 270) struct json_writer jw = JSON_WRITER_INIT;
3c543ab3 272) jw_object_begin(&jw, 0);
3c543ab3 273) event_fmt_prepare(event_name, file, line, NULL, &jw);
3c543ab3 274) jw_object_string(&jw, "name", mode);
3c543ab3 275) jw_end(&jw);
3c543ab3 277) tr2_dst_write_line(&tr2dst_event, &jw.json);
3c543ab3 278) jw_release(&jw);
3c543ab3 279) }
3c543ab3 281) static void fn_alias_fl(const char *file, int line, const char *alias,
3c543ab3 284) const char *event_name = "alias";
3c543ab3 285) struct json_writer jw = JSON_WRITER_INIT;
3c543ab3 287) jw_object_begin(&jw, 0);
3c543ab3 288) event_fmt_prepare(event_name, file, line, NULL, &jw);
3c543ab3 289) jw_object_string(&jw, "alias", alias);
3c543ab3 290) jw_object_inline_begin_array(&jw, "argv");
3c543ab3 291) jw_array_argv(&jw, argv);
3c543ab3 292) jw_end(&jw);
3c543ab3 293) jw_end(&jw);
3c543ab3 295) tr2_dst_write_line(&tr2dst_event, &jw.json);
3c543ab3 296) jw_release(&jw);
3c543ab3 297) }
3c543ab3 310) jw_object_string(&jw, "child_class", "hook");
3c543ab3 311) jw_object_string(&jw, "hook_name", cmd->trace2_hook_name);
3c543ab3 318) jw_object_string(&jw, "cd", cmd->dir);
3c543ab3 322) jw_array_string(&jw, "git");
3c543ab3 352) static void fn_thread_start_fl(const char *file, int line,
3c543ab3 355) const char *event_name = "thread_start";
3c543ab3 356) struct json_writer jw = JSON_WRITER_INIT;
3c543ab3 358) jw_object_begin(&jw, 0);
3c543ab3 359) event_fmt_prepare(event_name, file, line, NULL, &jw);
3c543ab3 360) jw_end(&jw);
3c543ab3 362) tr2_dst_write_line(&tr2dst_event, &jw.json);
3c543ab3 363) jw_release(&jw);
3c543ab3 364) }
3c543ab3 366) static void fn_thread_exit_fl(const char *file, int line,
3c543ab3 370) const char *event_name = "thread_exit";
3c543ab3 371) struct json_writer jw = JSON_WRITER_INIT;
3c543ab3 372) double t_rel = (double)us_elapsed_thread / 1000000.0;
3c543ab3 374) jw_object_begin(&jw, 0);
3c543ab3 375) event_fmt_prepare(event_name, file, line, NULL, &jw);
3c543ab3 376) jw_object_double(&jw, "t_rel", 6, t_rel);
3c543ab3 377) jw_end(&jw);
3c543ab3 379) tr2_dst_write_line(&tr2dst_event, &jw.json);
3c543ab3 380) jw_release(&jw);
3c543ab3 381) }
3c543ab3 383) static void fn_exec_fl(const char *file, int line, uint64_t us_elapsed_absolute,
3c543ab3 386) const char *event_name = "exec";
3c543ab3 387) struct json_writer jw = JSON_WRITER_INIT;
3c543ab3 389) jw_object_begin(&jw, 0);
3c543ab3 390) event_fmt_prepare(event_name, file, line, NULL, &jw);
3c543ab3 391) jw_object_intmax(&jw, "exec_id", exec_id);
3c543ab3 392) if (exe)
3c543ab3 393) jw_object_string(&jw, "exe", exe);
3c543ab3 394) jw_object_inline_begin_array(&jw, "argv");
3c543ab3 395) jw_array_argv(&jw, argv);
3c543ab3 396) jw_end(&jw);
3c543ab3 397) jw_end(&jw);
3c543ab3 399) tr2_dst_write_line(&tr2dst_event, &jw.json);
3c543ab3 400) jw_release(&jw);
3c543ab3 401) }
3c543ab3 403) static void fn_exec_result_fl(const char *file, int line,
3c543ab3 407) const char *event_name = "exec_result";
3c543ab3 408) struct json_writer jw = JSON_WRITER_INIT;
3c543ab3 410) jw_object_begin(&jw, 0);
3c543ab3 411) event_fmt_prepare(event_name, file, line, NULL, &jw);
3c543ab3 412) jw_object_intmax(&jw, "exec_id", exec_id);
3c543ab3 413) jw_object_intmax(&jw, "code", code);
3c543ab3 414) jw_end(&jw);
3c543ab3 416) tr2_dst_write_line(&tr2dst_event, &jw.json);
3c543ab3 417) jw_release(&jw);
3c543ab3 418) }
3c543ab3 436) static void fn_repo_fl(const char *file, int line,
3c543ab3 439) const char *event_name = "def_repo";
3c543ab3 440) struct json_writer jw = JSON_WRITER_INIT;
3c543ab3 442) jw_object_begin(&jw, 0);
3c543ab3 443) event_fmt_prepare(event_name, file, line, repo, &jw);
3c543ab3 444) jw_object_string(&jw, "worktree", repo->worktree);
3c543ab3 445) jw_end(&jw);
3c543ab3 447) tr2_dst_write_line(&tr2dst_event, &jw.json);
3c543ab3 448) jw_release(&jw);
3c543ab3 449) }
3c543ab3 451) static void fn_region_enter_printf_va_fl(const char *file, int line,
3c543ab3 458) const char *event_name = "region_enter";
3c543ab3 459) struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
3c543ab3 460) if (ctx->nr_open_regions <= tr2env_event_nesting_wanted) {
3c543ab3 461) struct json_writer jw = JSON_WRITER_INIT;
3c543ab3 463) jw_object_begin(&jw, 0);
3c543ab3 464) event_fmt_prepare(event_name, file, line, repo, &jw);
3c543ab3 465) jw_object_intmax(&jw, "nesting", ctx->nr_open_regions);
3c543ab3 466) if (category)
3c543ab3 467) jw_object_string(&jw, "category", category);
3c543ab3 468) if (label)
3c543ab3 469) jw_object_string(&jw, "label", label);
3c543ab3 470) maybe_add_string_va(&jw, "msg", fmt, ap);
3c543ab3 471) jw_end(&jw);
3c543ab3 473) tr2_dst_write_line(&tr2dst_event, &jw.json);
3c543ab3 474) jw_release(&jw);
3c543ab3 476) }
3c543ab3 478) static void fn_region_leave_printf_va_fl(
3c543ab3 483) const char *event_name = "region_leave";
3c543ab3 484) struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
3c543ab3 485) if (ctx->nr_open_regions <= tr2env_event_nesting_wanted) {
3c543ab3 486) struct json_writer jw = JSON_WRITER_INIT;
3c543ab3 487) double t_rel = (double)us_elapsed_region / 1000000.0;
3c543ab3 489) jw_object_begin(&jw, 0);
3c543ab3 490) event_fmt_prepare(event_name, file, line, repo, &jw);
3c543ab3 491) jw_object_double(&jw, "t_rel", 6, t_rel);
3c543ab3 492) jw_object_intmax(&jw, "nesting", ctx->nr_open_regions);
3c543ab3 493) if (category)
3c543ab3 494) jw_object_string(&jw, "category", category);
3c543ab3 495) if (label)
3c543ab3 496) jw_object_string(&jw, "label", label);
3c543ab3 497) maybe_add_string_va(&jw, "msg", fmt, ap);
3c543ab3 498) jw_end(&jw);
3c543ab3 500) tr2_dst_write_line(&tr2dst_event, &jw.json);
3c543ab3 501) jw_release(&jw);
3c543ab3 503) }
3c543ab3 532) static void fn_data_json_fl(const char *file, int line,
3c543ab3 538) const char *event_name = "data_json";
3c543ab3 539) struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
3c543ab3 540) if (ctx->nr_open_regions <= tr2env_event_nesting_wanted) {
3c543ab3 541) struct json_writer jw = JSON_WRITER_INIT;
3c543ab3 542) double t_abs = (double)us_elapsed_absolute / 1000000.0;
3c543ab3 543) double t_rel = (double)us_elapsed_region / 1000000.0;
3c543ab3 545) jw_object_begin(&jw, 0);
3c543ab3 546) event_fmt_prepare(event_name, file, line, repo, &jw);
3c543ab3 547) jw_object_double(&jw, "t_abs", 6, t_abs);
3c543ab3 548) jw_object_double(&jw, "t_rel", 6, t_rel);
3c543ab3 549) jw_object_intmax(&jw, "nesting", ctx->nr_open_regions);
3c543ab3 550) jw_object_string(&jw, "category", category);
3c543ab3 551) jw_object_string(&jw, "key", key);
3c543ab3 552) jw_object_sub_jw(&jw, "value", value);
3c543ab3 553) jw_end(&jw);
3c543ab3 555) tr2_dst_write_line(&tr2dst_event, &jw.json);
3c543ab3 556) jw_release(&jw);
3c543ab3 558) }

trace2/tr2_tgt_normal.c
3c543ab3 105) static void fn_signal(uint64_t us_elapsed_absolute, int signo)
3c543ab3 107) struct strbuf buf_payload = STRBUF_INIT;
3c543ab3 108) double elapsed = (double)us_elapsed_absolute / 1000000.0;
3c543ab3 110) strbuf_addf(&buf_payload, "signal elapsed:%.6f code:%d", elapsed,
3c543ab3 112) normal_io_write_fl(__FILE__, __LINE__, &buf_payload);
3c543ab3 113) strbuf_release(&buf_payload);
3c543ab3 114) }
3c543ab3 138) if (fmt && *fmt) {
3c543ab3 139) strbuf_addstr(buf, fmt);
3c543ab3 140) return;
3c543ab3 155) static void fn_command_path_fl(const char *file, int line, const char *pathname)
3c543ab3 157) struct strbuf buf_payload = STRBUF_INIT;
3c543ab3 159) strbuf_addf(&buf_payload, "cmd_path %s", pathname);
3c543ab3 160) normal_io_write_fl(file, line, &buf_payload);
3c543ab3 161) strbuf_release(&buf_payload);
3c543ab3 162) }
3c543ab3 177) static void fn_command_mode_fl(const char *file, int line, const char *mode)
3c543ab3 179) struct strbuf buf_payload = STRBUF_INIT;
3c543ab3 181) strbuf_addf(&buf_payload, "cmd_mode %s", mode);
3c543ab3 182) normal_io_write_fl(file, line, &buf_payload);
3c543ab3 183) strbuf_release(&buf_payload);
3c543ab3 184) }
3c543ab3 186) static void fn_alias_fl(const char *file, int line, const char *alias,
3c543ab3 189) struct strbuf buf_payload = STRBUF_INIT;
3c543ab3 191) strbuf_addf(&buf_payload, "alias %s ->", alias);
3c543ab3 192) sq_quote_argv_pretty(&buf_payload, argv);
3c543ab3 193) normal_io_write_fl(file, line, &buf_payload);
3c543ab3 194) strbuf_release(&buf_payload);
3c543ab3 195) }
3c543ab3 197) static void fn_child_start_fl(const char *file, int line,
3c543ab3 201) struct strbuf buf_payload = STRBUF_INIT;
3c543ab3 203) strbuf_addf(&buf_payload, "child_start[%d] ", cmd->trace2_child_id);
3c543ab3 205) if (cmd->dir) {
3c543ab3 206) strbuf_addstr(&buf_payload, " cd");
3c543ab3 207) sq_quote_buf_pretty(&buf_payload, cmd->dir);
3c543ab3 208) strbuf_addstr(&buf_payload, "; ");
3c543ab3 216) if (cmd->git_cmd)
3c543ab3 217) strbuf_addstr(&buf_payload, "git");
3c543ab3 218) sq_quote_argv_pretty(&buf_payload, cmd->argv);
3c543ab3 220) normal_io_write_fl(file, line, &buf_payload);
3c543ab3 221) strbuf_release(&buf_payload);
3c543ab3 222) }
3c543ab3 224) static void fn_child_exit_fl(const char *file, int line,
3c543ab3 228) struct strbuf buf_payload = STRBUF_INIT;
3c543ab3 229) double elapsed = (double)us_elapsed_child / 1000000.0;
3c543ab3 231) strbuf_addf(&buf_payload, "child_exit[%d] pid:%d code:%d elapsed:%.6f",
3c543ab3 233) normal_io_write_fl(file, line, &buf_payload);
3c543ab3 234) strbuf_release(&buf_payload);
3c543ab3 235) }
3c543ab3 237) static void fn_exec_fl(const char *file, int line, uint64_t us_elapsed_absolute,
3c543ab3 240) struct strbuf buf_payload = STRBUF_INIT;
3c543ab3 242) strbuf_addf(&buf_payload, "exec[%d] ", exec_id);
3c543ab3 243) if (exe)
3c543ab3 244) strbuf_addstr(&buf_payload, exe);
3c543ab3 245) sq_quote_argv_pretty(&buf_payload, argv);
3c543ab3 246) normal_io_write_fl(file, line, &buf_payload);
3c543ab3 247) strbuf_release(&buf_payload);
3c543ab3 248) }
3c543ab3 250) static void fn_exec_result_fl(const char *file, int line,
3c543ab3 254) struct strbuf buf_payload = STRBUF_INIT;
3c543ab3 256) strbuf_addf(&buf_payload, "exec_result[%d] code:%d", exec_id, code);
3c543ab3 257) if (code > 0)
3c543ab3 258) strbuf_addf(&buf_payload, " err:%s", strerror(code));
3c543ab3 259) normal_io_write_fl(file, line, &buf_payload);
3c543ab3 260) strbuf_release(&buf_payload);
3c543ab3 261) }
3c543ab3 263) static void fn_param_fl(const char *file, int line, const char *param,
3c543ab3 266) struct strbuf buf_payload = STRBUF_INIT;
3c543ab3 268) strbuf_addf(&buf_payload, "def_param %s=%s", param, value);
3c543ab3 269) normal_io_write_fl(file, line, &buf_payload);
3c543ab3 270) strbuf_release(&buf_payload);
3c543ab3 271) }
3c543ab3 273) static void fn_repo_fl(const char *file, int line,
3c543ab3 276) struct strbuf buf_payload = STRBUF_INIT;
3c543ab3 278) strbuf_addstr(&buf_payload, "worktree ");
3c543ab3 279) sq_quote_buf_pretty(&buf_payload, repo->worktree);
3c543ab3 280) normal_io_write_fl(file, line, &buf_payload);
3c543ab3 281) strbuf_release(&buf_payload);
3c543ab3 282) }
3c543ab3 284) static void fn_printf_va_fl(const char *file, int line,
3c543ab3 288) struct strbuf buf_payload = STRBUF_INIT;
3c543ab3 290) maybe_append_string_va(&buf_payload, fmt, ap);
3c543ab3 291) normal_io_write_fl(file, line, &buf_payload);
3c543ab3 292) strbuf_release(&buf_payload);
3c543ab3 293) }

trace2/tr2_tgt_perf.c
3c543ab3 102) strbuf_addf(buf, "r%d ", repo->trace2_repo_id);
3c543ab3 125) strbuf_addbuf(buf, &dots);
3c543ab3 126) len_indent -= dots.len;
3c543ab3 187) static void fn_signal(uint64_t us_elapsed_absolute, int signo)
3c543ab3 189) const char *event_name = "signal";
3c543ab3 190) struct strbuf buf_payload = STRBUF_INIT;
3c543ab3 192) strbuf_addf(&buf_payload, "signo:%d", signo);
3c543ab3 194) perf_io_write_fl(__FILE__, __LINE__, event_name, NULL,
3c543ab3 196) strbuf_release(&buf_payload);
3c543ab3 197) }
3c543ab3 223) if (fmt && *fmt) {
3c543ab3 224) strbuf_addstr(buf, fmt);
3c543ab3 225) return;
3c543ab3 242) static void fn_command_path_fl(const char *file, int line, const char *pathname)
3c543ab3 244) const char *event_name = "cmd_path";
3c543ab3 245) struct strbuf buf_payload = STRBUF_INIT;
3c543ab3 247) strbuf_addstr(&buf_payload, pathname);
3c543ab3 249) perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
3c543ab3 251) strbuf_release(&buf_payload);
3c543ab3 252) }
3c543ab3 270) static void fn_command_mode_fl(const char *file, int line, const char *mode)
3c543ab3 272) const char *event_name = "cmd_mode";
3c543ab3 273) struct strbuf buf_payload = STRBUF_INIT;
3c543ab3 275) strbuf_addstr(&buf_payload, mode);
3c543ab3 277) perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
3c543ab3 279) strbuf_release(&buf_payload);
3c543ab3 280) }
3c543ab3 282) static void fn_alias_fl(const char *file, int line, const char *alias,
3c543ab3 285) const char *event_name = "alias";
3c543ab3 286) struct strbuf buf_payload = STRBUF_INIT;
3c543ab3 288) strbuf_addf(&buf_payload, "alias:%s argv:", alias);
3c543ab3 289) sq_quote_argv_pretty(&buf_payload, argv);
3c543ab3 291) perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
3c543ab3 293) strbuf_release(&buf_payload);
3c543ab3 294) }
3c543ab3 304) strbuf_addf(&buf_payload, "[ch%d] class:hook hook:%s",
3c543ab3 314) strbuf_addstr(&buf_payload, " cd:");
3c543ab3 315) sq_quote_buf_pretty(&buf_payload, cmd->dir);
3c543ab3 320) strbuf_addstr(&buf_payload, " git");
3c543ab3 342) static void fn_thread_start_fl(const char *file, int line,
3c543ab3 345) const char *event_name = "thread_start";
3c543ab3 346) struct strbuf buf_payload = STRBUF_INIT;
3c543ab3 348) perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
3c543ab3 350) strbuf_release(&buf_payload);
3c543ab3 351) }
3c543ab3 353) static void fn_thread_exit_fl(const char *file, int line,
3c543ab3 357) const char *event_name = "thread_exit";
3c543ab3 358) struct strbuf buf_payload = STRBUF_INIT;
3c543ab3 360) perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
3c543ab3 362) strbuf_release(&buf_payload);
3c543ab3 363) }
3c543ab3 365) static void fn_exec_fl(const char *file, int line, uint64_t us_elapsed_absolute,
3c543ab3 368) const char *event_name = "exec";
3c543ab3 369) struct strbuf buf_payload = STRBUF_INIT;
3c543ab3 371) strbuf_addf(&buf_payload, "id:%d ", exec_id);
3c543ab3 372) strbuf_addstr(&buf_payload, "argv:");
3c543ab3 373) if (exe)
3c543ab3 374) strbuf_addf(&buf_payload, " %s", exe);
3c543ab3 375) sq_quote_argv_pretty(&buf_payload, argv);
3c543ab3 377) perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
3c543ab3 379) strbuf_release(&buf_payload);
3c543ab3 380) }
3c543ab3 382) static void fn_exec_result_fl(const char *file, int line,
3c543ab3 386) const char *event_name = "exec_result";
3c543ab3 387) struct strbuf buf_payload = STRBUF_INIT;
3c543ab3 389) strbuf_addf(&buf_payload, "id:%d code:%d", exec_id, code);
3c543ab3 390) if (code > 0)
3c543ab3 391) strbuf_addf(&buf_payload, " err:%s", strerror(code));
3c543ab3 393) perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
3c543ab3 395) strbuf_release(&buf_payload);
3c543ab3 396) }
3c543ab3 398) static void fn_param_fl(const char *file, int line, const char *param,
3c543ab3 401) const char *event_name = "def_param";
3c543ab3 402) struct strbuf buf_payload = STRBUF_INIT;
3c543ab3 404) strbuf_addf(&buf_payload, "%s:%s", param, value);
3c543ab3 406) perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
3c543ab3 408) strbuf_release(&buf_payload);
3c543ab3 409) }
3c543ab3 411) static void fn_repo_fl(const char *file, int line,
3c543ab3 414) const char *event_name = "def_repo";
3c543ab3 415) struct strbuf buf_payload = STRBUF_INIT;
3c543ab3 417) strbuf_addstr(&buf_payload, "worktree:");
3c543ab3 418) sq_quote_buf_pretty(&buf_payload, repo->worktree);
3c543ab3 420) perf_io_write_fl(file, line, event_name, repo, NULL, NULL, NULL,
3c543ab3 422) strbuf_release(&buf_payload);
3c543ab3 423) }
3c543ab3 425) static void fn_region_enter_printf_va_fl(const char *file, int line,
3c543ab3 432) const char *event_name = "region_enter";
3c543ab3 433) struct strbuf buf_payload = STRBUF_INIT;
3c543ab3 435) if (label)
3c543ab3 436) strbuf_addf(&buf_payload, "label:%s ", label);
3c543ab3 437) maybe_append_string_va(&buf_payload, fmt, ap);
3c543ab3 439) perf_io_write_fl(file, line, event_name, repo, &us_elapsed_absolute,
3c543ab3 441) strbuf_release(&buf_payload);
3c543ab3 442) }
3c543ab3 444) static void fn_region_leave_printf_va_fl(
3c543ab3 449) const char *event_name = "region_leave";
3c543ab3 450) struct strbuf buf_payload = STRBUF_INIT;
3c543ab3 452) if (label)
3c543ab3 453) strbuf_addf(&buf_payload, "label:%s ", label);
3c543ab3 454) maybe_append_string_va(&buf_payload, fmt, ap);
3c543ab3 456) perf_io_write_fl(file, line, event_name, repo, &us_elapsed_absolute,
3c543ab3 458) strbuf_release(&buf_payload);
3c543ab3 459) }
3c543ab3 461) static void fn_data_fl(const char *file, int line, uint64_t us_elapsed_absolute,
3c543ab3 466) const char *event_name = "data";
3c543ab3 467) struct strbuf buf_payload = STRBUF_INIT;
3c543ab3 469) strbuf_addf(&buf_payload, "%s:%s", key, value);
3c543ab3 471) perf_io_write_fl(file, line, event_name, repo, &us_elapsed_absolute,
3c543ab3 473) strbuf_release(&buf_payload);
3c543ab3 474) }
3c543ab3 476) static void fn_data_json_fl(const char *file, int line,
3c543ab3 482) const char *event_name = "data_json";
3c543ab3 483) struct strbuf buf_payload = STRBUF_INIT;
3c543ab3 485) strbuf_addf(&buf_payload, "%s:%s", key, value->json.buf);
3c543ab3 487) perf_io_write_fl(file, line, event_name, repo, &us_elapsed_absolute,
3c543ab3 489) strbuf_release(&buf_payload);
3c543ab3 490) }
3c543ab3 492) static void fn_printf_va_fl(const char *file, int line,
3c543ab3 496) const char *event_name = "printf";
3c543ab3 497) struct strbuf buf_payload = STRBUF_INIT;
3c543ab3 499) maybe_append_string_va(&buf_payload, fmt, ap);
3c543ab3 501) perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
3c543ab3 503) strbuf_release(&buf_payload);
3c543ab3 504) }

trace2/tr2_tls.c
3c543ab3 38) strbuf_addf(&ctx->thread_name, "th%02d:", ctx->thread_id);
3c543ab3 41) strbuf_setlen(&ctx->thread_name, TR2_MAX_THREAD_NAME);
3c543ab3 58) ctx = tr2tls_create_self("unknown");
3c543ab3 63) int tr2tls_is_main_thread(void)
3c543ab3 65) struct tr2tls_thread_ctx *ctx = pthread_getspecific(tr2tls_key);
3c543ab3 67) return ctx == tr2tls_thread_main;
3c543ab3 82) void tr2tls_push_self(uint64_t us_now)
3c543ab3 84) struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
3c543ab3 86) ALLOC_GROW(ctx->array_us_start, ctx->nr_open_regions + 1, ctx->alloc);
3c543ab3 87) ctx->array_us_start[ctx->nr_open_regions++] = us_now;
3c543ab3 88) }
3c543ab3 90) void tr2tls_pop_self(void)
3c543ab3 92) struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
3c543ab3 94) if (!ctx->nr_open_regions)
3c543ab3 95) BUG("no open regions in thread '%s'", ctx->thread_name.buf);
3c543ab3 97) ctx->nr_open_regions--;
3c543ab3 98) }
3c543ab3 105) tr2tls_pop_self();
3c543ab3 115) return 0;
3c543ab3 125) return 0;

wrapper.c
5efde212 70) die("Out of memory, malloc failed (tried to allocate %" PRIuMAX " bytes)",
5efde212 73) error("Out of memory, malloc failed (tried to allocate %" PRIuMAX " bytes)",

Commits introducting uncovered code:
Dan McGregor	ba81921a http: cast result to FILE *
Derrick Stolee	8e7e6c05 commit-graph: return with errors during write
Derrick Stolee	b1beb050 commit-graph: create new version flags
Jeff Hostetler	34fed676 trace2:data: add subverb for rebase
Jeff Hostetler	3c543ab3 trace2: create new combined trace facility
Jeff Hostetler	3507f837 trace2:data: add editor/pager child classification
Jeff Hostetler	7bc0969b trace2: t/helper/test-trace2, t0210.sh, t0211.sh, t0212.sh
Josh Steadmon	6da1f1a9 protocol: advertise multiple supported versions
Martin Koegler	5efde212 zlib.c: use size_t for size
Nguyễn Thái Ngọc Duy	a12c1ff3 config: factor out set_config_source_file()
Nguyễn Thái Ngọc Duy	6f11fd5e config: add --move-to
Nguyễn Thái Ngọc Duy	8f7c7f55 config.c: add repo_config_set_worktree_gently()
Nickolai Belakovski	358c9418 ref-filter: add worktreepath atom


Uncovered code in 'jch' not in 'next'
--------------------------------------------------------

blame.c
07d04b91 483)     ent->s_lno + ent->num_lines == next->s_lno &&
07d04b91 484)     ent->ignored == next->ignored) {
e7973c85 941) blame_origin_decref(e->suspect);
e7973c85 942) e->suspect = blame_origin_incref(parent);
e7973c85 943) e->s_lno += offset;
07d04b91 944) e->ignored = 1;
e7973c85 945) e->next = ignoredp;
e7973c85 946) ignoredp = e;
e7973c85 954) **dstq = reverse_blame(ignoredp, **dstq);
e7973c85 955) *dstq = &ignoredp->next;
e7973c85 1528) for (i = 0, sg = first_scapegoat(revs, commit, sb->reverse);
e7973c85 1529)      i < num_sg && sg;
e7973c85 1530)      sg = sg->next, i++) {
e7973c85 1531) struct blame_origin *porigin = sg_origin[i];
e7973c85 1533) if (!porigin)
e7973c85 1534) continue;
e7973c85 1535) pass_blame_to_parent(sb, origin, porigin, 1);
e7973c85 1536) if (!origin->suspects)
e7973c85 1537) goto finish;

builtin/blame.c
07d04b91 485) length--;
07d04b91 486) putchar('*');
e7973c85 705) return git_config_pathname(&ignore_revs_file, var, value);
07d04b91 707) mark_ignored_lines = git_config_bool(var, value);
07d04b91 708) return 0;
e7973c85 797) oidset_parse_file(&sb->ignore_list, ignore_revs_file);
e7973c85 799) if (get_oid_committish(i->string, &oid))
e7973c85 800) die(_("Can't find revision '%s' to ignore"), i->string);
e7973c85 801) oidset_insert(&sb->ignore_list, &oid);

builtin/branch.c
0ecb1fc7 452) die(_("could not resolve HEAD"));
0ecb1fc7 458) die(_("HEAD (%s) points outside of refs/heads/"), refname);

builtin/multi-pack-index.c
467ae6f9 49) die(_("--batch-size option is only for 'repack' subcommand"));
467ae6f9 58) die(_("unrecognized subcommand: %s"), argv[0]);

builtin/pull.c
a3b994b7 648) argv_array_push(&args, opt_cleanup);

builtin/rebase--interactive.c
c0108d5c 24) return error_errno(_("could not read '%s'."), todo_file);
c0108d5c 31) return error_errno(_("could not write '%s'"), todo_file);
30faf278 46) return error_errno(_("could not read '%s'."), todo_file);
30faf278 50) todo_list_release(&todo_list);
30faf278 51) return error(_("unusable todo list: '%s'"), todo_file);
30faf278 59) return error_errno(_("could not write '%s'."), todo_file);
1f4d9b1b 157) BUG("unusable todo list");
acabb2aa 313) ret = rearrange_squash_in_todo_file(the_repository);
6d3f180e 316) ret = sequencer_add_exec_commands(the_repository, &commands);

builtin/remote.c
f39a9c65 1551) die(_("--save-to-push cannot be used with other options"));
f39a9c65 1575) die(_("--save-to-push can only be used when only one url is defined"));

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

combine-diff.c
26c64cee 89)     filename_changed(p->parent[j].status))
26c64cee 90) strbuf_release(&p->parent[j].path);
26c64cee 992) dump_quoted_path("--- ", "", "/dev/null",
26c64cee 1000) dump_quoted_path("--- ", "", "/dev/null",
26c64cee 1273) write_name_quoted(p->path, stdout,

ident.c
39ab4d09 452) break;
39ab4d09 454) name = getenv("GIT_AUTHOR_NAME");
39ab4d09 455) email = getenv("GIT_AUTHOR_EMAIL");
39ab4d09 456) break;
39ab4d09 515) return config_error_nonbool(var);
39ab4d09 525) return config_error_nonbool(var);
39ab4d09 535) return config_error_nonbool(var);
39ab4d09 545) return config_error_nonbool(var);

midx.c
5bf52fbc 428) close_pack(packs->info[packs->nr].p);
5bf52fbc 429) FREE_AND_NULL(packs->info[packs->nr].p);
3c9e7185 688) BUG("object %s is in an expired pack with int-id %d",
3c9e7185 815) error(_("did not see pack-file %s to drop"),
3c9e7185 817) drop_index++;
3c9e7185 818) missing_drops++;
3c9e7185 819) i--;
3c9e7185 826) result = 1;
3c9e7185 827) goto cleanup;
3c9e7185 1079) return 0;
3c9e7185 1094) continue;
467ae6f9 1133) return 0;
19c239d4 1148) return 0;
19c239d4 1157) continue;
19c239d4 1170) continue;
19c239d4 1193) error(_("could not start pack-objects"));
19c239d4 1194) result = 1;
19c239d4 1195) goto cleanup;
19c239d4 1212) error(_("could not finish pack-objects"));
19c239d4 1213) result = 1;
19c239d4 1214) goto cleanup;

oidset.c
ef644c41 69) die_errno("Could not read '%s'", path);

packfile.c
91336887 369) strbuf_release(&buf);
91336887 370) return;

pretty.c
4f732e0f 1075) return 0;
4f732e0f 1112) return 0;

read-cache.c
ee70c128 1734) if (advice_unknown_index_extension) {
ee70c128 1735) warning(_("ignoring optional %.4s index extension"), ext);
ee70c128 1736) advise(_("This is likely due to the file having been written by a newer\n"

rebase-interactive.c
6ca89c6f 26) warning(_("unrecognized setting %s for option "
c0108d5c 102) return error(_("could not copy '%s' to '%s'."), todo_file,
6ca89c6f 164) goto leave_check;

remote-curl.c
34a9469d 360) die("invalid server response; expected service, got flush packet");

revision.c
26c64cee 2654) die("--combined-all-names makes no sense without -c or --cc");

sequencer.c
6d3f180e 4606) int sequencer_add_exec_commands(struct repository *r,
6d3f180e 4614) return error_errno(_("could not read '%s'."), todo_file);
6d3f180e 4616) if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list)) {
6d3f180e 4621) todo_list_add_exec_commands(&todo_list, commands);
6d3f180e 4622) res = todo_list_write_to_file(r, &todo_list, todo_file, NULL, NULL, -1, 0);
0cce4a27 4623) todo_list_release(&todo_list);
6d3f180e 4625) if (res)
6d3f180e 4626) return error_errno(_("could not write '%s'."), todo_file);
6d3f180e 4627) return 0;
616d7740 4661) strbuf_addstr(buf, " -c");
87805600 4708) res = -1;
6ca89c6f 4709) goto out;
6ca89c6f 4714) goto out;
6ca89c6f 4723) fprintf(stderr, _(edit_todo_list_advice));
ce193960 4841) todo_list_release(&new_todo);
1f4d9b1b 4847) todo_list_release(&new_todo);
1f4d9b1b 4848) return error_errno(_("could not write '%s'"), todo_file);
acabb2aa 5025) int rearrange_squash_in_todo_file(struct repository *r)
acabb2aa 5027) const char *todo_file = rebase_path_todo();
acabb2aa 5028) struct todo_list todo_list = TODO_LIST_INIT;
acabb2aa 5029) int res = 0;
acabb2aa 5031) if (strbuf_read_file_or_whine(&todo_list.buf, todo_file) < 0)
acabb2aa 5032) return -1;
acabb2aa 5033) if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list) < 0) {
acabb2aa 5034) todo_list_release(&todo_list);
acabb2aa 5035) return -1;
acabb2aa 5038) res = todo_list_rearrange_squash(&todo_list);
acabb2aa 5039) if (!res)
acabb2aa 5040) res = todo_list_write_to_file(r, &todo_list, todo_file, NULL, NULL, -1, 0);
acabb2aa 5042) todo_list_release(&todo_list);
acabb2aa 5044) if (res)
acabb2aa 5045) return error_errno(_("could not write '%s'."), todo_file);
acabb2aa 5046) return 0;

strbuf.c
bfc3fe33 259) die("`pos' is too far after the end of the buffer");
bfc3fe33 264) BUG("your vsnprintf is broken (returned %d)", len);
bfc3fe33 266) return; /* nothing to do */
bfc3fe33 268) die("you want to use way too much memory");
bfc3fe33 276) BUG("your vsnprintf is broken (returns inconsistent lengths)");
fd2015b3 448) return 0;

worktree.c
e0c4a731 465) clear_repository_format(&format);

Commits introducting uncovered code:
Alban Gruin	ce193960 sequencer: refactor skip_unnecessary_picks() to work on a todo_list
Alban Gruin	6ca89c6f sequencer: refactor check_todo_list() to work on a todo_list
Alban Gruin	616d7740 sequencer: introduce todo_list_write_to_file()
Alban Gruin	6d3f180e sequencer: refactor sequencer_add_exec_commands() to work on a todo_list
Alban Gruin	c0108d5c rebase-interactive: rewrite edit_todo_list() to handle the initial edit
Alban Gruin	30faf278 rebase--interactive: move transform_todo_file() to rebase--interactive.c
Alban Gruin	1f4d9b1b sequencer: change complete_action() to use the refactored functions
Alban Gruin	acabb2aa sequencer: refactor rearrange_squash() to work on a todo_list
Anders Waldenborg	fd2015b3 strbuf: separate callback for strbuf_expand:ing literals
Anders Waldenborg	4f732e0f pretty: allow %(trailers) options with explicit value
Barret Rhoden	e7973c85 blame: add the ability to ignore commits and their changes
Barret Rhoden	ef644c41 Move init_skiplist() outside of fsck
Barret Rhoden	07d04b91 blame: add a config option to mark ignored lines
Daniels Umanovskis	0ecb1fc7 branch: introduce --show-current display option
Denton Liu	f39a9c65 remote: add --save-to-push option to git remote set-url
Denton Liu	a3b994b7 merge: cleanup messages like commit
Derrick Stolee	91336887 repack: refactor pack deletion for future use
Derrick Stolee	467ae6f9 multi-pack-index: prepare 'repack' subcommand
Derrick Stolee	19c239d4 midx: implement midx_repack()
Derrick Stolee	3c9e7185 multi-pack-index: implement 'expire' subcommand
Derrick Stolee	5bf52fbc midx: refactor permutation logic and pack sorting
Elijah Newren	26c64cee log,diff-tree: add --combined-all-names option
Jeff King	34a9469d remote-curl: refactor smart-http discovery
Joel Teichroeb	f6bbd781 stash: convert apply to builtin
Joel Teichroeb	e1d01876 stash: convert pop to builtin
Joel Teichroeb	cdca49bc stash: convert drop and clear to builtin
Johannes Schindelin	bec65d5b tests: add a special setup where stash.useBuiltin is off
Johannes Schindelin	26799a20 stash: optionally use the scripted version again
Jonathan Nieder	ee70c128 index: offer advice for unknown index extensions
Liam Beguin	0cce4a27 rebase -i -x: add exec commands via the rebase--helper
Martin Ågren	e0c4a731 setup: fix memory leaks with `struct repository_format`
Paul-Sebastian Ungureanu	9a95010a stash: make push -q quiet
Paul-Sebastian Ungureanu	1f5a011d stash: convert create to builtin
Paul-Sebastian Ungureanu	847eb0b0 stash: convert store to builtin
Paul-Sebastian Ungureanu	51809c70 stash: convert `stash--helper.c` into `stash.c`
Paul-Sebastian Ungureanu	b4493f26 stash: convert show to builtin
Paul-Sebastian Ungureanu	bfc3fe33 strbuf.c: add `strbuf_insertf()` and `strbuf_vinsertf()`
Paul-Sebastian Ungureanu	fa38428f stash: convert push to builtin
René Scharfe	87805600 sequencer: factor out strbuf_read_file_or_whine()
William Hubbs	39ab4d09 config: allow giving separate author and committer idents


Uncovered code in 'next' not in 'master'
--------------------------------------------------------

bisect.c
4f6d26b1 661) mark_edges_uninteresting(revs, NULL, 0);

builtin/bisect--helper.c
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
06f5608c 588) retval = -1;
06f5608c 589) goto finish;
06f5608c 600) retval = -1;
5e82c3dd 677) return error(_("--bisect-reset requires either no argument or a commit"));
0f30233a 681) return error(_("--bisect-write requires either 4 or 5 arguments"));
4fbdbd5b 687) return error(_("--check-and-set-terms requires 3 arguments"));
129a6cf3 693) return error(_("--bisect-next-check requires 2 or 3 arguments"));

builtin/blame.c
acdd3776 930) blame_date_width = sizeof("Thu Oct 19 16:00");
acdd3776 931) break;

builtin/checkout.c
091e04bc 303) return;
091e04bc 1271) die(_("'%s' cannot be used with switching branches"),

builtin/diff-tree.c
e1ff0a32 169) repo_read_index(the_repository);

builtin/pack-objects.c
33de80b1 2225) const uint32_t tail = (idx + window - count) % window;

builtin/pack-redundant.c
33de80b1 169) const int cmp = oidcmp(l->oid, oid);
33de80b1 267) const int cmp = hashcmp(p1_base + p1_off, p2_base + p2_off);

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
21853626 507) BUG("move_to_original_branch without onto");
21853626 543) argv_array_push(&am.args, opts->gpg_sign_opt);
21853626 575) status = error_errno(_("could not open '%s' for writing"),
21853626 577) free(rebased_patches);
21853626 578) argv_array_clear(&am.args);
21853626 579) return status;
21853626 588) argv_array_split(&format_patch.args,
21853626 589)  opts->git_format_patch_opt.buf);
21853626 597) unlink(rebased_patches);
21853626 598) free(rebased_patches);
21853626 599) argv_array_clear(&am.args);
21853626 601) reset_head(&opts->orig_head, "checkout", opts->head_name, 0,
21853626 603) error(_("\ngit encountered an error while preparing the "
21853626 610) strbuf_release(&revisions);
21853626 611) return status;
21853626 617) status = error_errno(_("could not open '%s' for reading"),
21853626 619) free(rebased_patches);
21853626 620) argv_array_clear(&am.args);
21853626 621) return status;

date.c
acdd3776 113) die("Timestamp too large for this system: %"PRItime, time);
acdd3776 236) hide.date = 1;
acdd3776 917) return DATE_HUMAN;
2fd7c229 934) if (isatty(1) || pager_in_use())
2fd7c229 935) format = p;
2fd7c229 937) format = "default";

diff.c
d473e2e0 4946) return error(_("%s expects a numerical value"), "--unified");

entry.c
536ec183 450) BUG("Can't remove entry to a path");

http-walker.c
514c5fdd 550) loose_object_path(the_repository, &buf, &req->oid);

list-objects.c
4f6d26b1 241) continue;
4f6d26b1 250) parent->object.flags |= SHOWN;
4f6d26b1 251) show_edge(parent);
4f6d26b1 272) tree->object.flags |= UNINTERESTING;
4f6d26b1 287) commit->object.flags |= SHOWN;
4f6d26b1 288) show_edge(commit);

merge-recursive.c
0d6caa2d 433) for (i = 0; i < istate->cache_nr; i++) {
0d6caa2d 434) const struct cache_entry *ce = istate->cache[i];
0d6caa2d 443) istate->cache_tree = cache_tree();
0d6caa2d 733) ce = index_file_exists(o->repo->index, path, strlen(path),
0d6caa2d 3193) remove_file_from_index(o->repo->index, path);

object.c
01f8d594 278) error(_("hash mismatch %s"), oid_to_hex(repl));

parse-options.c
f62470c6 116) BUG("BITOP can't have unset form");
3ebbe289 183) return (*opt->ll_callback)(p, opt, p_arg, p_unset);
3ebbe289 255) rc = (*numopt->ll_callback)(p, numopt, arg, 0);
3ebbe289 432) BUG("OPTION_CALLBACK needs one callback");
3ebbe289 434) BUG("OPTION_CALLBACK can't have two callbacks");
bf3ff338 438) BUG("OPTION_LOWLEVEL_CALLBACK needs a callback");
bf3ff338 440) BUG("OPTION_LOWLEVEL_CALLBACK needs no high level callback");
202fbb33 475) BUG("Can't keep argv0 if you don't have it");
f41179f1 622) BUG("parse_short_opt() cannot return these");
f41179f1 647) BUG("parse_short_opt() cannot return these");
f41179f1 676) BUG("parse_long_opt() cannot return these");

repository.c
3a95f31d 272) BUG("the repo hasn't been setup");

revision.c
d5d2e935 169) return;
d5d2e935 172) return;
d5d2e935 195) break;
f1f5de44 218) continue;

sequencer.c
899b49c4 2395) opts->quiet = 1;
e1ff0a32 3991) res = error_dirty_index(r, opts);

sha1-file.c
514c5fdd 1291) status = error(_("unable to parse %s header"), oid_to_hex(oid));
2c319886 1595) return error_errno(_("unable to write file %s"), filename);
76011357 1626) fsync_or_die(fd, "loose object file");
76011357 1628) die_errno(_("error when closing loose object file"));
76011357 1719) die(_("unable to write loose object file"));
2c319886 1818) return error(_("cannot read object for %s"), oid_to_hex(oid));
00a7760e 2297) the_hash_algo->final_fn(real_oid.hash, &c);
00a7760e 2298) if (!oideq(expected_oid, &real_oid)) {
01f8d594 2299) error(_("hash mismatch for %s (expected %s)"), path,

sha1-name.c
d1dd94b3 926) return MISSING_OBJECT;

t/helper/test-date.c
4419de91 95) static void getnanos(const char **argv, struct timeval *now)
4419de91 97) double seconds = getnanotime() / 1.0e9;
4419de91 99) if (*argv)
4419de91 100) seconds -= strtod(*argv, NULL);
4419de91 101) printf("%lf\n", seconds);
4419de91 102) }
4419de91 133) getnanos(argv+1, &now);

t/helper/test-path-utils.c
b819f1d2 180) static int cmp_by_st_size(const void *a, const void *b)
b819f1d2 182) intptr_t x = (intptr_t)((struct string_list_item *)a)->util;
b819f1d2 183) intptr_t y = (intptr_t)((struct string_list_item *)b)->util;
b819f1d2 185) return x > y ? -1 : (x < y ? +1 : 0);
5868bd86 308) res = error_errno("Cannot stat '%s'", argv[i]);
af9912ef 314) if (argc == 4 && !strcmp(argv[1], "skip-n-bytes")) {
af9912ef 315) int fd = open(argv[2], O_RDONLY), offset = atoi(argv[3]);
af9912ef 318) if (fd < 0)
af9912ef 319) die_errno("could not open '%s'", argv[2]);
af9912ef 320) if (lseek(fd, offset, SEEK_SET) < 0)
af9912ef 321) die_errno("could not skip %d bytes", offset);
af9912ef 323) ssize_t count = read(fd, buffer, sizeof(buffer));
af9912ef 324) if (count < 0)
af9912ef 325) die_errno("could not read '%s'", argv[2]);
af9912ef 326) if (!count)
af9912ef 327) break;
af9912ef 328) if (write(1, buffer, count) < 0)
af9912ef 329) die_errno("could not write to stdout");
af9912ef 330) }
af9912ef 331) close(fd);
af9912ef 332) return 0;
b819f1d2 335) if (argc > 5 && !strcmp(argv[1], "slice-tests")) {
b819f1d2 336) int res = 0;
b819f1d2 338) struct string_list list = STRING_LIST_INIT_NODUP;
b819f1d2 341) offset = strtol(argv[2], NULL, 10);
b819f1d2 342) stride = strtol(argv[3], NULL, 10);
b819f1d2 343) if (stride < 1)
b819f1d2 344) stride = 1;
b819f1d2 345) for (i = 4; i < argc; i++)
b819f1d2 346) if (stat(argv[i], &st))
b819f1d2 347) res = error_errno("Cannot stat '%s'", argv[i]);
b819f1d2 349) string_list_append(&list, argv[i])->util =
b819f1d2 350) (void *)(intptr_t)st.st_size;
b819f1d2 351) QSORT(list.items, list.nr, cmp_by_st_size);
b819f1d2 352) for (i = offset; i < list.nr; i+= stride)
b819f1d2 353) printf("%s\n", list.items[i].string);
b819f1d2 355) return !!res;

t/helper/test-xml-encode.c
22231908 9) int cmd__xml_encode(int argc, const char **argv)
22231908 11) unsigned char buf[1024], tmp[4], *tmp2 = NULL;
22231908 12) ssize_t cur = 0, len = 1, remaining = 0;
22231908 16) if (++cur == len) {
22231908 17) len = xread(0, buf, sizeof(buf));
22231908 18) if (!len)
22231908 19) return 0;
22231908 20) if (len < 0)
22231908 21) die_errno("Could not read <stdin>");
22231908 22) cur = 0;
22231908 24) ch = buf[cur];
22231908 26) if (tmp2) {
22231908 27) if ((ch & 0xc0) != 0x80) {
22231908 28) fputs(utf8_replace_character, stdout);
22231908 29) tmp2 = NULL;
22231908 30) cur--;
22231908 31) continue;
22231908 33) *tmp2 = ch;
22231908 34) tmp2++;
22231908 35) if (--remaining == 0) {
22231908 36) fwrite(tmp, tmp2 - tmp, 1, stdout);
22231908 37) tmp2 = NULL;
22231908 39) continue;
22231908 42) if (!(ch & 0x80)) {
22231908 44) if (ch == '&')
22231908 45) fputs("&amp;", stdout);
22231908 46) else if (ch == '\'')
22231908 47) fputs("&apos;", stdout);
22231908 48) else if (ch == '"')
22231908 49) fputs("&quot;", stdout);
22231908 50) else if (ch == '<')
22231908 51) fputs("&lt;", stdout);
22231908 52) else if (ch == '>')
22231908 53) fputs("&gt;", stdout);
22231908 54) else if (ch >= 0x20)
22231908 55) fputc(ch, stdout);
22231908 56) else if (ch == 0x09 || ch == 0x0a || ch == 0x0d)
22231908 57) fprintf(stdout, "&#x%02x;", ch);
22231908 59) fputs(utf8_replace_character, stdout);
22231908 60) } else if ((ch & 0xe0) == 0xc0) {
22231908 62) tmp[0] = ch;
22231908 63) remaining = 1;
22231908 64) tmp2 = tmp + 1;
22231908 65) } else if ((ch & 0xf0) == 0xe0) {
22231908 67) tmp[0] = ch;
22231908 68) remaining = 2;
22231908 69) tmp2 = tmp + 1;
22231908 70) } else if ((ch & 0xf8) == 0xf0) {
22231908 72) tmp[0] = ch;
22231908 73) remaining = 3;
22231908 74) tmp2 = tmp + 1;
22231908 76) fputs(utf8_replace_character, stdout);
22231908 77) }

utf8.c
aab2a1ae 568) bom_str = utf16_be_bom;
aab2a1ae 569) bom_len = sizeof(utf16_be_bom);
aab2a1ae 570) out_encoding = "UTF-16BE";

wrapper.c
e3b1e3bd 701) die_errno(_("could not stat %s"), filename);

Commits introducting uncovered code:
David Turner	d1dd94b3 Do not print 'dangling' for cat-file in case of ambiguity
Derrick Stolee	4f6d26b1 list-objects: consume sparse tree walk
Derrick Stolee	d5d2e935 revision: implement sparse algorithm
Derrick Stolee	f1f5de44 revision: add mark_tree_uninteresting_sparse
Elijah Newren	899b49c4 git-rebase, sequencer: extend --quiet option for the interactive machinery
Jeff King	01f8d594 prefer "hash mismatch" to "sha1 mismatch"
Jeff King	514c5fdd sha1-file: modernize loose object file functions
Jeff King	76011357 sha1-file: prefer "loose object file" to "sha1 file" in messages
Jeff King	2c319886 sha1-file: avoid "sha1 file" for generic use in messages
Jeff King	00a7760e sha1-file: modernize loose header/stream functions
Johannes Schindelin	21853626 built-in rebase: call `git am` directly
Johannes Schindelin	c5233708 rebase: move `reset_head()` into a better spot
Johannes Schindelin	4419de91 test-date: add a subcommand to measure times in shell scripts
Johannes Schindelin	b819f1d2 ci: parallelize testing on Windows
Johannes Schindelin	5868bd86 tests: avoid calling Perl just to determine file sizes
Johannes Schindelin	af9912ef tests: include detailed trace logs with --write-junit-xml upon failure
Johannes Schindelin	22231908 tests: optionally write results as JUnit-style .xml
Linus Torvalds	acdd3776 Add 'human' date format
Nguyễn Thái Ngọc Duy	f41179f1 parse-options: avoid magic return codes
Nguyễn Thái Ngọc Duy	3a95f31d repository.c: replace hold_locked_index() with repo_hold_locked_index()
Nguyễn Thái Ngọc Duy	202fbb33 parse-options: add one-shot mode
Nguyễn Thái Ngọc Duy	f62470c6 parse-options: add OPT_BITOP()
Nguyễn Thái Ngọc Duy	3ebbe289 parse-options: allow ll_callback with OPTION_CALLBACK
Nguyễn Thái Ngọc Duy	0d6caa2d merge-recursive.c: remove implicit dependency on the_index
Nguyễn Thái Ngọc Duy	d473e2e0 diff.c: convert -U|--unified
Nguyễn Thái Ngọc Duy	e1ff0a32 read-cache.c: kill read_index()
Nguyễn Thái Ngọc Duy	bf3ff338 parse-options: stop abusing 'callback' for lowlevel callbacks
Pranit Bauva	5e82c3dd bisect--helper: `bisect_reset` shell function in C
Pranit Bauva	0f30233a bisect--helper: `bisect_write` shell function in C
Pranit Bauva	129a6cf3 bisect--helper: `bisect_next_check` shell function in C
Pranit Bauva	450ebb73 bisect--helper: `get_terms` & `bisect_terms` shell function in C
Pranit Bauva	06f5608c bisect--helper: `bisect_start` shell function partially in C
Pranit Bauva	e3b1e3bd wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
Pranit Bauva	4fbdbd5b bisect--helper: `check_and_set_terms` shell function in C
Shahzad Lone	33de80b1 various: tighten constness of some local variables
Stephen P. Smith	2fd7c229 Replace the proposed 'auto' mode with 'auto:'
Thomas Gummerer	536ec183 entry: support CE_WT_REMOVE flag in checkout_entry
Thomas Gummerer	091e04bc checkout: introduce --{,no-}overlay option
Torsten Bögershausen	aab2a1ae Support working-tree-encoding "UTF-16LE-BOM"


Uncovered code in 'master' not in 'master@{1}'
--------------------------------------------------------

builtin/archive.c
01f9ec64 63) if (starts_with(reader.line, "NACK "))
01f9ec64 64) die(_("git archive: NACK %s"), reader.line + 5);

builtin/fetch-pack.c
4316ff30 227) get_remote_refs(fd[1], &reader, &ref, 0, NULL, NULL);
4316ff30 228) break;

builtin/fetch.c
e0137875 1483) die(_("--filter can only be used with the remote "
e0137875 1652) die(_("--filter can only be used with the remote "

builtin/pack-objects.c
edb673cf 2335) packing_data_lock(&to_pack);
edb673cf 2337) packing_data_unlock(&to_pack);

builtin/rebase.c
81ef8ee7 774) return -1;
d421afa0 1259) die(_("--reschedule-failed-exec requires an interactive rebase"));
d421afa0 1297) die(_("error: cannot combine '--preserve-merges' with "

builtin/receive-pack.c
01f9ec64 1587)     reader->line + 8);
01f9ec64 1621) die("protocol error: got an unexpected packet");

commit-graph.c
aa658574 127) return NULL;
aa658574 130) return NULL;
aa658574 186) free(graph);
aa658574 187) return NULL;
aa658574 222) free(graph);
aa658574 223) return NULL;
d9b1b309 935) display_progress(oids.progress, approx_nr_objects);

diff.c
b73bcbac 308) ret = 0;
21536d07 812)        (s[off] == '\r' && off < len - 1))
21536d07 813) off++;
b73bcbac 5112) options->color_moved_ws_handling = 0;

fetch-pack.c
01f9ec64 154) die(_("git fetch-pack: expected a flush packet after shallow list"));
01f9ec64 358) die(_("invalid shallow line: %s"), reader.line);
01f9ec64 364) die(_("invalid unshallow line: %s"), reader.line);
01f9ec64 366) die(_("object not found: %s"), reader.line);
01f9ec64 369) die(_("error in object: %s"), reader.line);
01f9ec64 371) die(_("no shallow found: %s"), reader.line);
01f9ec64 374) die(_("expected shallow/unshallow, got %s"), reader.line);
0bbc0bc5 1128) packet_buf_write(&req_buf, "sideband-all");
0bbc0bc5 1350) reader.use_sideband = 1;
0bbc0bc5 1351) reader.me = "fetch-pack";

hex.c
47edb649 93) char *sha1_to_hex_r(char *buffer, const unsigned char *sha1)
47edb649 95) return hash_to_hex_algop_r(buffer, sha1, &hash_algos[GIT_HASH_SHA1]);
47edb649 116) char *hash_to_hex(const unsigned char *hash)
47edb649 118) return hash_to_hex_algop(hash, the_hash_algo);

http-push.c
ea82b2a0 1314) p = process_tree(lookup_tree(the_repository, &entry.oid),

http.c
e6cf87b1 1999) if (fflush(result)) {
e6cf87b1 2000) error_errno("unable to flush a file");
e6cf87b1 2001) return HTTP_START_FAILED;
e6cf87b1 2003) rewind(result);
e6cf87b1 2004) if (ftruncate(fileno(result), 0) < 0) {
e6cf87b1 2005) error_errno("unable to truncate a file");
e6cf87b1 2006) return HTTP_START_FAILED;
e6cf87b1 2008) break;
e6cf87b1 2010) BUG("Unknown http_request target");

list-objects-filter.c
c813a7c3 199) return;

match-trees.c
f55ac431 231) hashcpy(tree_oid.hash, rewrite_here);
f55ac431 232) status = splice_tree(&tree_oid, subpath, oid2, &subtree);

pkt-line.c
0bbc0bc5 505) if (demultiplex_sideband(reader->me, reader->buffer,
0bbc0bc5 508) break;
0bbc0bc5 509) }

pretty.c
ad6f028f 1204) return 0;

remote-curl.c
01f9ec64 427) die("invalid server response; got '%s'", reader.line);
01f9ec64 439) }
b79bdd8c 576) return size;

send-pack.c
01f9ec64 143) return error(_("unable to parse remote unpack status: %s"), reader->line);
01f9ec64 162) error("invalid ref status from remote: %s", reader->line);
01f9ec64 579) receive_unpack_status(&reader);

sha1-file.c
2f90b9d9 172) int hash_algo_by_name(const char *name)
2f90b9d9 175) if (!name)
2f90b9d9 176) return GIT_HASH_UNKNOWN;
2f90b9d9 177) for (i = 1; i < GIT_HASH_NALGOS; i++)
2f90b9d9 178) if (!strcmp(name, hash_algos[i].name))
2f90b9d9 179) return i;
2f90b9d9 180) return GIT_HASH_UNKNOWN;
2f90b9d9 183) int hash_algo_by_id(uint32_t format_id)
2f90b9d9 186) for (i = 1; i < GIT_HASH_NALGOS; i++)
2f90b9d9 187) if (format_id == hash_algos[i].format_id)
2f90b9d9 188) return i;
2f90b9d9 189) return GIT_HASH_UNKNOWN;

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

submodule.c
26f80ccf 1398) strbuf_release(&gitdir);
be76c212 1521) struct fetch_task *task = task_cb;
be76c212 1525) fetch_task_release(task);
be76c212 1551) BUG("callback cookie bogus");

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
371820d5 104) commit = lookup_commit(r, &entry.oid);

upload-pack.c
87c2d9d3 149) sq_quote_buf(&buf, expanded_filter_spec.buf);
01f9ec64 432) die("git upload-pack: expected SHA1 list, got '%s'", reader->line);
0bbc0bc5 1066) allow_sideband_all = git_config_bool(var, value);
07c3c2aa 1306)      allow_sideband_all) &&
07c3c2aa 1307)     !strcmp(arg, "sideband-all")) {
0bbc0bc5 1308) data->writer.use_sideband = 1;
0bbc0bc5 1309) continue;
bc2e795c 1441) deepen(&data->writer, INFINITE_DEPTH, data->deepen_relative,
07c3c2aa 1544)    &allow_sideband_all_value) &&

Commits introducting uncovered code:
Ævar Arnfjörð Bjarmason	d9b1b309 commit-graph write: show progress for object search
brian m. carlson	0a3faa45 tree-walk: copy object ID before use
brian m. carlson	37649b7f t/helper: add a test helper to compute hash speed
brian m. carlson	f55ac431 match-trees: use hashcpy to splice trees
brian m. carlson	2f90b9d9 sha1-file: provide functions to look up hash algorithms
brian m. carlson	50c817e0 t: make the sha1 test-tool helper generic
brian m. carlson	47edb649 hex: introduce functions to print arbitrary hashes
brian m. carlson	ea82b2a0 tree-walk: store object_id in a separate member
Christian Couder	e0137875 fetch: fix extensions.partialclone name in error message
Issac Trotts	ad6f028f log: add %S option (like --source) to log --format
Johannes Schindelin	81ef8ee7 rebase: introduce a shortcut for --reschedule-failed-exec
Johannes Schindelin	d421afa0 rebase: introduce --reschedule-failed-exec
Jonathan Tan	07c3c2aa tests: define GIT_TEST_SIDEBAND_ALL
Jonathan Tan	bc2e795c pkt-line: introduce struct packet_writer
Jonathan Tan	4316ff30 fetch-pack: support protocol version 2
Jonathan Tan	0bbc0bc5 {fetch,upload}-pack: sideband v2 fetch response
Jonathan Tan	fbd76cd4 sideband: reverse its dependency on pkt-line
Josh Steadmon	aa658574 commit-graph, fuzz: add fuzzer for commit-graph
Josh Steadmon	87c2d9d3 filter-options: expand scaled numbers
Junio C Hamano	371820d5 Merge branch 'bc/tree-walk-oid'
Masaya Suzuki	01f9ec64 Use packet_reader instead of packet_read_line
Masaya Suzuki	b79bdd8c remote-curl: unset CURLOPT_FAILONERROR
Masaya Suzuki	e6cf87b1 http: enable keep_error for HTTP requests
Matthew DeVore	c813a7c3 list-objects-filter: teach tree:# how to handle >0
Patrick Hogg	edb673cf pack-objects: merge read_lock and lock in packing_data struct
Phillip Wood	21536d07 diff --color-moved-ws: modify allow-indentation-change
Phillip Wood	b73bcbac diff: allow --no-color-moved-ws
Stefan Beller	be76c212 fetch: ensure submodule objects fetched
Stefan Beller	26f80ccf submodule: migrate get_next_submodule to use repository structs


