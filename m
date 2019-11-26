Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FC3C432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 20:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFAFD20684
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 20:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="O+Dadwuj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbfKZUrD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 15:47:03 -0500
Received: from mout.gmx.net ([212.227.17.20]:34129 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbfKZUrD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 15:47:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574801219;
        bh=Nn7Y7herZn5glYiMcDzOYpfP1+4zle+ubbHXI0f7MrM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=O+DadwujLn5IlEvhqdvFOL7ipprQ6XHSAow5aWVuHa41/QIPxnsfpddQmTks3BmJ6
         3PSG7VArTjpuF9v65h/4P983CtqdYw8QsdFmvxuj1gs6uKopJa9p2+AyxrMigMZYq8
         /aJ8ZCKcLARumXcPJ9G67+OLBRgcVTNwxw3lmSZM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MulqN-1hj6wr3QQd-00rsUw; Tue, 26
 Nov 2019 21:46:58 +0100
Date:   Tue, 26 Nov 2019 21:46:43 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee <stolee@gmail.com>
cc:     Git List <git@vger.kernel.org>
Subject: Re: Git Test Coverage Report (Nov 25)
In-Reply-To: <1cb7ddbf-020e-d63a-85b6-5a9267c0a5a3@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1911262116100.31080@tvgsbejvaqbjf.bet>
References: <1cb7ddbf-020e-d63a-85b6-5a9267c0a5a3@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:d7XhirddDvTrkiN7bvbi8UZg/XfCSaWhggZRnEdUNRKCyQmJ2PL
 Jp27XMPzBUcxrZ+NIIx/enNJFQtW5JRAluQZ8NPn/M+WOAZ3UbzQdW1U69AKq2vswAZuZhZ
 /TxKbGIiiFEvSlo+pda/Wz5qe+e1lCiGOsEenOJoTkg+3ZaX7MhtkiBE+yauAserZRBt6lP
 8dxVRy12OK6WOP/+tCb0A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3CpC/xIMphM=:vg+ddwg5iOoDMwj93u8MAS
 MdjkXcxONJau2GTVH2tRCpqTpOmHGkRu8IDe2jKDwTsET6Tw263XayhOEUPaLGVtFT+uauYIR
 NJhw8IVUCaw8QNjg1r8SuLz/vJ8rw58gj+j21tJlBTz6xqCYzXighxr8lN+fyMFW++hdDY2jV
 OuzC6n47BvsOamgsSf+kqjhnv+Wy5hkuAUFDhjr1yVESYJLiR0u7GIx+nT+Rc0wD6IL5EGf2w
 HcaliwXqrhdnaz3TKcpG6ObVzBJgmP2jjbskWh1aPKXmMCuNFJ86bwM4dnc7GdYRWsXCO+YFn
 HEc1rDlzeh3FSIfr7aZa48FwEYe52e5dmd7nbFJdYJQ4XYKgz1fUBKdtUlHwqQ18M6Mq+G+Kf
 ruC9geEYc89uEgaflCiOZz9OuF3RpuwxecE1cgeGn9fh8kaQnfUmQ9yVayLowcuUoo6HPu2ph
 Qq3TGVKVeTHkoYO9LfMFFFCVRb8OIhR1CgFbXgNBpfdJSyZtHuAT9ucG8oRFF8enfTfsz50K2
 aRbWpLqHHefmzJ5qpYM8SloLUQxbMNnmtl2/KiuMhiEpn4oF7Xry0ucWcsoghwjb5vF1Un5NC
 YmbLoXRfXRoPK3fDt7U4yOP1NLu7LJ718YONSS4Retu3Er4Em6cKCTljdVm1uD36eXoInVIhi
 8bEg/SIx7k0JtG4uzgFPrFaGMOEVBjqJ6FElP/cLgfBjm9Vx3O+iN24UqckjdFAg20UXy7xkQ
 lYl4O0Op9XZfIw5ML081r9r9UH/22z2loS3E/gyWSv+y+x56wEogrWPcBvwKYcNMSmnTClcbG
 9WjQtOwbTcQ1jdi3Szu065njmn/q3RTwyTmoX1kkmEvdr38pS99S4fZo1IYRxVTgda74zGtN1
 1MoJgAJnONkQoRJz4eq4dPOq/0jqXkxCQTZrSlXF1i1HxPDGPhXiJ8okHbL4fgcMwOTFlmLqs
 NtBVj+y7nnorqvcO/qy4SJkrqFNWNWskaUpiczNdLxxMJBysUWMWVtOL0TyZI+x7/I8ieJ99p
 nOJHA20Ol4CF31CAn2Xq93702UALOxtB8P6c2FszBZRBmpvtc9eTv4siak09vOuMwi9A3prRn
 bpH6fJwm7GGDkHfdtn37V9oHYoHp/aFfTiLbqIkgX4vbXG0Yj4l/IGblfrf/jqy13VVzeFP5O
 CEckLNyI//5+DbXGx/764Ye+vl6q8fv0CFBbfqAKclvY7/S7rEXWgAi9GKHeMjB4645Ba6UrQ
 t/5iz6u3vk6Lf2eMCM6MOgG4T9ci4sa9yZiCoNu0IZpEUHZ7swIfxSo+uoqI=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

thank you for keeping doing these reports.

On Mon, 25 Nov 2019, Derrick Stolee wrote:

> Here is today's test coverage report.
>
> Sorry for the delay, but I had some issues working out the new
> "ignored lines" logic. Now there are a few phrases that are
> ignored automatically, including "BUG(" or "die(".
>
> [...]
> Johannes Schindelin	eea4a7f4 mingw: demonstrate that all file handles ar=
e inherited by child processes
> t/helper/test-run-command.c
> eea4a7f4 203) static int inherit_handle(const char *argv0)
> eea4a7f4 205) struct child_process cp =3D CHILD_PROCESS_INIT;
> eea4a7f4 210) xsnprintf(path, sizeof(path), "out-XXXXXX");
> eea4a7f4 211) tmp =3D xmkstemp(path);
> eea4a7f4 213) argv_array_pushl(&cp.args,
> eea4a7f4 215) cp.in =3D -1;
> eea4a7f4 216) cp.no_stdout =3D cp.no_stderr =3D 1;
> eea4a7f4 217) if (start_command(&cp) < 0)
> eea4a7f4 221) close(tmp);
> eea4a7f4 222) if (unlink(path))
> eea4a7f4 225) if (close(cp.in) < 0 || finish_command(&cp) < 0)
> eea4a7f4 228) return 0;
> eea4a7f4 231) static int inherit_handle_child(void)
> eea4a7f4 233) struct strbuf buf =3D STRBUF_INIT;
> eea4a7f4 235) if (strbuf_read(&buf, 0, 0) < 0)
> eea4a7f4 237) printf("Received %s\n", buf.buf);
> eea4a7f4 238) strbuf_release(&buf);
> eea4a7f4 240) return 0;
> eea4a7f4 251) exit(inherit_handle(argv[0]));
> eea4a7f4 253) exit(inherit_handle_child());

I think this is actually covered, but only in the Windows build.

> Johannes Schindelin	116a408b commit: give correct advice for empty commi=
t during a rebase
> builtin/commit.c
> 116a408b 478) else if (whence =3D=3D FROM_CHERRY_PICK) {
> 116a408b 479) if (rebase_in_progress && !sequencer_in_use)
> 116a408b 1186) else if (whence =3D=3D FROM_CHERRY_PICK) {
> 116a408b 1187) if (rebase_in_progress && !sequencer_in_use)

My understanding is that Phillip is working on a replacement for this
patch, so I'll leave this as-is for now.

> Johannes Schindelin	0de7b036 built-in add -i: offer the `quit` command
> add-interactive.c
> [...]
>
> Johannes Schindelin	d17e3a76 built-in add -i: prepare for multi-selectio=
n commands
> add-interactive.c
> [...]
>
> Johannes Schindelin	dea080c8 built-in add -i: re-implement `revert` in C
> add-interactive.c
> [...]
>
> Johannes Schindelin	daabf56b built-in add -i: re-implement `add-untracke=
d` in C
> add-interactive.c
> [...]
>
> Johannes Schindelin	4ba7c22a built-in add -i: implement the `update` com=
mand
> add-interactive.c
> [...]
>
> Johannes Schindelin	9d86921e built-in add -i: implement the `patch` comm=
and
> add-interactive.c
> [...]
>
> Johannes Schindelin	a5ced6db built-in add -i: allow filtering the modifi=
ed files list
> add-interactive.c
> [...]
>
> Johannes Schindelin	465a9699 built-in add -i: re-implement the `diff` co=
mmand
> add-interactive.c
> [...]
>
> Johannes Schindelin	68db1cbf built-in add -i: support `?` (prompt help)
> add-interactive.c
> [...]
>
> Johannes Schindelin	76b74323 built-in add -i: show unique prefixes of th=
e commands
> add-interactive.c
> [...]
>
> Johannes Schindelin	6348bfba built-in add -i: implement the main loop
> add-interactive.c
> [...]
>
> Johannes Schindelin	f83dff60 Start to implement a built-in version of `g=
it add --interactive`
> add-interactive.c
> f83dff60 571) int run_add_i(struct repository *r, const struct pathspec =
*ps)
>
> builtin/add.c
> f83dff60 197) return !!run_add_i(the_repository, pathspec);

This ginormous amount of code without test coverage is exactly the type of
problem I pointed out with the approach I had to take in the built-in add
-i/-p series, and which I described in the commit message
https://public-inbox.org/git/5d9962d4344fa182b37cd8d969da01bc603414be.1573=
648866.git.gitgitgadget@gmail.com/
Most of it _will_ be covered by the tests, but _only_ at the very end,
when all six patch series will be merged.

> Johannes Schindelin	867bc1d2 rebase-merges: move labels' whitespace mang=
ling into `label_oid()`
> sequencer.c
> 867bc1d2 4539) }

Not sure why this closing parenthesis isn't covered :-D

> Johannes Schindelin	4d17fd25 remote-curl: unbreak http.extraHeader with =
custom allocators
> http.c
> 4d17fd25 417) string_list_clear(&extra_http_headers, 0);

I think it is okay to have that uncovered. This line is in the unlikely
code path where a user will try to unset the extra headers via `git -c
http.extraHeaders [...]`, i.e. without setting a value for that setting.

> Johannes Schindelin	2e0afafe Add git-bundle: move objects and references=
 by archive
> builtin/bundle.c
> 2e0afafe 115) return 1;

I have to admit that I am slightly curious how this commit from 2007 ended
up in this list: 2e0afafebd8 (Add git-bundle: move objects and references
by archive, 2007-02-22). That's quite the blast of the past.

> Johannes Schindelin	116d1fa6 vreportf(): avoid relying on stdio bufferin=
g
> usage.c
> 116d1fa6 16) fprintf(stderr, "BUG!!! too long a prefix '%s'\n", prefix);
> 116d1fa6 17) abort();
> 116d1fa6 22) *p =3D '\0'; /* vsnprintf() failed, clip at prefix */

Those are defensive programming, so this is expected not to be covered.

> Johannes Schindelin	d54dea77 fetch: let --jobs=3D<n> parallelize --multi=
ple, too
> builtin/fetch.c
> d54dea77 113) fetch_parallel_config =3D git_config_int(k, v);
> d54dea77 114) if (fetch_parallel_config < 0)
> d54dea77 116) return 0;
> d54dea77 1566) static int fetch_failed_to_start(struct strbuf *out, void=
 *cb, void *task_cb)
> d54dea77 1568) struct parallel_fetch_state *state =3D cb;
> d54dea77 1569) const char *remote =3D task_cb;
> d54dea77 1573) return 0;

I guess that yes, this points out that setting the number of parallel
fetches via `fetch.parallel` is untested... I am willing to leave it like
that until the time a regression is found in that code (if ever).

> Johannes Schindelin	e145d993 rebase -r: support merge strategies other t=
han `recursive`
> sequencer.c
> e145d993 3304) (!opts->strategy || !strcmp(opts->strategy, "recursive"))=
 ?

I am a bit puzzled by this because the added test case in t3430 should
cover precisely this line.

> Johannes Schindelin	e2683d51 Fix .git/ discovery at the root of UNC shar=
es
> setup.c
> e2683d51 952)     !is_dir_sep(dir->buf[min_offset - 1])) {
> e2683d51 953) strbuf_addch(dir, '/');
> e2683d51 954) min_offset++;

I think this is only tested on Windows.

> Johannes Schindelin	be5d88e1 test-tool run-command: learn to run (parts =
of) the testsuite
> t/helper/test-run-command.c
> be5d88e1 66) static int next_test(struct child_process *cp, struct strbu=
f *err, void *cb,
> be5d88e1 69) struct testsuite *suite =3D cb;
> be5d88e1 71) if (suite->next >=3D suite->tests.nr)
> be5d88e1 72) return 0;
> be5d88e1 74) test =3D suite->tests.items[suite->next++].string;
> be5d88e1 75) argv_array_pushl(&cp->args, "sh", test, NULL);
> be5d88e1 76) if (suite->quiet)
> be5d88e1 77) argv_array_push(&cp->args, "--quiet");
> be5d88e1 78) if (suite->immediate)
> be5d88e1 79) argv_array_push(&cp->args, "-i");
> be5d88e1 80) if (suite->verbose)
> be5d88e1 81) argv_array_push(&cp->args, "-v");
> be5d88e1 82) if (suite->verbose_log)
> be5d88e1 83) argv_array_push(&cp->args, "-V");
> be5d88e1 84) if (suite->trace)
> be5d88e1 85) argv_array_push(&cp->args, "-x");
> be5d88e1 86) if (suite->write_junit_xml)
> be5d88e1 87) argv_array_push(&cp->args, "--write-junit-xml");
> be5d88e1 89) strbuf_addf(err, "Output of '%s':\n", test);
> be5d88e1 90) *task_cb =3D (void *)test;
> be5d88e1 92) return 1;
> be5d88e1 95) static int test_finished(int result, struct strbuf *err, vo=
id *cb,
> be5d88e1 98) struct testsuite *suite =3D cb;
> be5d88e1 99) const char *name =3D (const char *)task_cb;
> be5d88e1 101) if (result)
> be5d88e1 102) string_list_append(&suite->failed, name);
> be5d88e1 104) strbuf_addf(err, "%s: '%s'\n", result ? "FAIL" : "SUCCESS"=
, name);
> be5d88e1 106) return 0;
> be5d88e1 109) static int test_failed(struct strbuf *out, void *cb, void =
*task_cb)
> be5d88e1 111) struct testsuite *suite =3D cb;
> be5d88e1 112) const char *name =3D (const char *)task_cb;
> be5d88e1 114) string_list_append(&suite->failed, name);
> be5d88e1 115) strbuf_addf(out, "FAILED TO START: '%s'\n", name);
> be5d88e1 117) return 0;
> be5d88e1 125) static int testsuite(int argc, const char **argv)
> be5d88e1 127) struct testsuite suite =3D TESTSUITE_INIT;
> be5d88e1 128) int max_jobs =3D 1, i, ret;
> be5d88e1 131) struct option options[] =3D {
> be5d88e1 145) memset(&suite, 0, sizeof(suite));
> be5d88e1 146) suite.tests.strdup_strings =3D suite.failed.strdup_strings=
 =3D 1;
> be5d88e1 148) argc =3D parse_options(argc, argv, NULL, options,
> be5d88e1 151) if (max_jobs <=3D 0)
> be5d88e1 152) max_jobs =3D online_cpus();
> be5d88e1 154) dir =3D opendir(".");
> be5d88e1 155) if (!dir)
> be5d88e1 157) while ((d =3D readdir(dir))) {
> be5d88e1 158) const char *p =3D d->d_name;
> be5d88e1 160) if (*p !=3D 't' || !isdigit(p[1]) || !isdigit(p[2]) ||
> be5d88e1 161)     !isdigit(p[3]) || !isdigit(p[4]) || p[5] !=3D '-' ||
> be5d88e1 162)     !ends_with(p, ".sh"))
> be5d88e1 163) continue;
> be5d88e1 166) if (!argc) {
> be5d88e1 167) string_list_append(&suite.tests, p);
> be5d88e1 168) continue;
> be5d88e1 171) for (i =3D 0; i < argc; i++)
> be5d88e1 172) if (!wildmatch(argv[i], p, 0)) {
> be5d88e1 173) string_list_append(&suite.tests, p);
> be5d88e1 174) break;
> be5d88e1 177) closedir(dir);
> be5d88e1 179) if (!suite.tests.nr)
> be5d88e1 181) if (max_jobs > suite.tests.nr)
> be5d88e1 182) max_jobs =3D suite.tests.nr;
> be5d88e1 184) fprintf(stderr, "Running %d tests (%d at a time)\n",
> be5d88e1 187) ret =3D run_processes_parallel(max_jobs, next_test, test_f=
ailed,
> be5d88e1 190) if (suite.failed.nr > 0) {
> be5d88e1 191) ret =3D 1;
> be5d88e1 192) fprintf(stderr, "%d tests failed:\n\n", suite.failed.nr);
> be5d88e1 193) for (i =3D 0; i < suite.failed.nr; i++)
> be5d88e1 194) fprintf(stderr, "\t%s\n", suite.failed.items[i].string);
> be5d88e1 197) string_list_clear(&suite.tests, 0);
> be5d88e1 198) string_list_clear(&suite.failed, 0);
> be5d88e1 200) return !!ret;
> be5d88e1 209) exit(testsuite(argc - 1, argv + 1));

This is exercised extensively in the Visual Studio job of our Azure
Pipeline.

Thanks,
DschO
