Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED0B21F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 09:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfJBJmN (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 05:42:13 -0400
Received: from mout.gmx.net ([212.227.15.19]:36151 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbfJBJmM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 05:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570009328;
        bh=A2OFKSIXpUq09vp/tqQn+5sJrAbIgFV4kpZJFN51Srw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bBuBD15EGQ2UksuivTZTIkBw2OnGIRqV3imb78NqPa98kfpbjKzOVh2w9+6kJwjjr
         u9zeGnzKshqr7LS25VwYHuSS1y/C+8NTcbXnS2ZH4J5U4bHsxFi1AeAkwGNQmwusVl
         hVyREA4EIlbDc21YVes3IS2f9WIqWqX0KCefA0jE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOzT4-1iTp8u0ypI-00PP7h; Wed, 02
 Oct 2019 11:42:08 +0200
Date:   Wed, 2 Oct 2019 11:41:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
cc:     git@vger.kernel.org
Subject: Re: git crash in range-diff
In-Reply-To: <20190923101929.GA18205@kitsune.suse.cz>
Message-ID: <nycvar.QRO.7.76.6.1910021129010.46@tvgsbejvaqbjf.bet>
References: <20190923101929.GA18205@kitsune.suse.cz>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1855128131-1570009330=:46"
X-Provags-ID: V03:K1:0si293QC5aJKpLvL2Kk7H/7cTxzzIFz8RFmb3t9RWLedKKCj0ab
 ioT3B30k0ZwG+Pbv1GNOBodMWZwAcKbQdi3jjLO4QzdL+NVfTK6fidRYDnizqsOQyAfonS3
 x9VoOjcKTu0n6qYjWIaPiOx3QEdjgK36VXwZ6mICQYIMsIpW4I3pVtwGo0fpFS586BBPHbY
 lgm3GHzIm2oUe1AUHtUgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZNF25bZRoIU=:ag4E7yX8ujYddIIt+tvIoL
 smol+3CkZBn6ZMKyiLO2PvYZHxLyglHLVZ8Kav6zx4iyZsuRqT39pJ8IghUkCNVUlYNkZptIf
 MBV1u8E+n0G0mimKcrcK1R/htP04RGYyDr4x6xvVdRTJtDfdirxaPvZwwQZ400G0slMHSomnT
 E9IKmejqYQZjOGtTkRZkRwQ2EVJgumAqN12tEh432BVF62jtdRiiZMm3SzhhlMOl1xdXTh/er
 78RqW1bCCDsUCNLP/4UKXnn4M0cmpuD69LA2Xhx/3c0+Rl7Oqz3648W56Sv433LICX8p+SMGO
 1qxLuWO+cSG63rLB6VgmMyssi+DkCv7mVOoKc2mjeP+cA+07ftbz+l6tlSMFMXUzOqqUQ3sbu
 BD0SMmW1vJcanMsELlR6IGOqtkMaj0+3oWNHfH9XrBn8kCEu0nNHPctHL1mJwMxoT4f+N/drT
 7dCmW5p4/Fr+EWwhB4d0r36AtCcJ2d5t9SPcuKUuf9VYSW0lNIYvXILK6kLwLcQidFPWaYLsA
 Kwf579N6kvHGKqZErjVuokqP4SphrODgCXxTWgp7l6JKYnnNwb1aWxA6zYBpMs8jpZyPN6ERX
 mQNUww+/y5XaO9Nk1GvrKxivADpKrlPxb+vnqhg/3q/TjNOFbp677xlhUB7blbQiPemjaB/kL
 PnCgpfDjapVeJsiSdyNZSVrbZE23CFV1bquLtpmWF8P+AI9TAcouWNc6ZXVhps3j4jlXA0uAj
 +/IkCfunlpTlkMIv6DBwrLfh8BDIexIXM7NRLXf0C35Ptgg2wpeOpXmWGIR4OjAYY5Y4FHofm
 AN9lO60elwWmNoSYe1eBWd8ozd49r0uyNUI9VeDI2Js076gTL9m3DzSypZqGVGRWJhTIrxQuu
 JENeFYt0R2aatlRNMiWhYuG9kIja/6Z8C/ydarliFmSelMn9AYVR7KTuPgO5k+ZQDf2OuELbT
 NrYjhu5FjFs9sNJi0+2bDp0snPrtmu0wXb8yqV8bOtlqXSoa9oJtDpejVZQj0ycnBXizrrv7k
 D/9GpgEcbucgpB1NAtGZRGuFmoeyPQlkNxxgsz0HphAsTWYAeKqeUL5IvlRbIcm4xsybOUVNC
 oXPDBwUQnIawFL/S7Q76c81H6IRoDRf2HPyJa7tKq5azSqlOPe+gZp28GHLfKlWxnRcHCPAB7
 4tkFVpX+spg+JtfKYojALkbKYZGnulsM3ZQd/PvFlBb4kDwADNQ4CkWG0JP5F8SJ1knt9qZRS
 EoaPpX45ZWv+dZt4ferpSIXE/g35i71ESWFopuUp6ull0GgKPdr3435v49CE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1855128131-1570009330=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Michal,

On Wed, 2 Oct 2019, Michal Such=C3=A1nek wrote:

> I get a crash in range-diff. It used to work in the past but I don't use
> it often so can't really say if this is a regression or a particular
> data triggering the crash.

It would always be helpful to add a Minimal, Complete & Verifiable
Example with your bug reports. If that is too much of a burden ;-) at
least try to give a Complete & Verifiable Example.

Of course, the absence of this example leaves me totally free to say
that I cannot do much of anything about it and I kick it right back into
your court.

Not without giving you a couple of hopefully useful hints, though:

> [...]
> Program received signal SIGSEGV, Segmentation fault.
> __strlen_avx2 () at ../sysdeps/x86_64/multiarch/strlen-avx2.S:62
> 62		VPCMPEQ (%rdi), %ymm0, %ymm1
> (gdb) bt full
> #0  __strlen_avx2 () at ../sysdeps/x86_64/multiarch/strlen-avx2.S:62
> No locals.
> #1  0x00005555556cf00f in strbuf_addstr (s=3D<optimized out>, sb=3D0x7ff=
fffffd2d0) at strbuf.h:292
> No locals.
> #2  read_patches (range=3Drange@entry=3D0x555555a69340 "76ac02e3549..cd5=
f86d59a73", list=3Dlist@entry=3D0x7fffffffd640) at range-diff.c:126

The line 126 in `range-diff.c` wants to append `patch.new_name` to a
`strbuf`, but that `patch.new_name` is `NULL`:

>         patch =3D {new_name =3D 0x0, old_name =3D 0x0, def_name =3D 0x0,=
 old_mode =3D 33188, new_mode =3D 0, is_new =3D 0, is_delete =3D 0, reject=
ed =3D 0,
                   ^^^^^^^^^^^^^^

So where should that have been populated? These are the lines 114--126
of `range-diff.c:

	len =3D parse_git_diff_header(&root, &linenr, 1, line,
				    len, size, &patch);

	if (len < 0)
		die(_("could not parse git header '%.*s'"), (int)len, line);
	strbuf_addstr(&buf, " ## ");
	if (patch.is_new > 0)
		strbuf_addf(&buf, "%s (new)", patch.new_name);
	else if (patch.is_delete > 0)
		strbuf_addf(&buf, "%s (deleted)", patch.old_name);
	else if (patch.is_rename)
		strbuf_addf(&buf, "%s =3D> %s", %patch.old_name, %patch.new_name);
	else
		strbuf_addstr(&buf, patch.new_name);

So I think the problem is that `parse_git_diff_header()` (which is
located in `apply.c`) fails to parse the new name correctly, but somehow
still reports success.

And indeed, when I look at the variable `line`:

>           ws_rule =3D 0, lines_added =3D 0, lines_deleted =3D 0, score =
=3D 0, extension_linenr =3D 0, is_toplevel_relative =3D 0, inaccurate_eof =
=3D 0,
>           is_binary =3D 0, is_copy =3D 0, is_rename =3D 0, recount =3D 0=
, conflicted_threeway =3D 0, direct_to_threeway =3D 0, crlf_in_old =3D 0,
>           fragments =3D 0x0, result =3D 0x0, resultsize =3D 0, old_oid_p=
refix =3D "c452d7c1308d", '\000' <repeats 52 times>,
>           new_oid_prefix =3D "dd7b242a4c00", '\000' <repeats 52 times>, =
next =3D 0x0, threeway_stage =3D {{hash =3D '\000' <repeats 31 times>}, {
>               hash =3D '\000' <repeats 31 times>}, {hash =3D '\000' <rep=
eats 31 times>}}}
>         root =3D {alloc =3D 0, len =3D 0, buf =3D 0x555555a64920 <strbuf=
_slopbuf> ""}
>         linenr =3D 4
>         p =3D <optimized out>
>         cp =3D {argv =3D 0x555555a6a390, args =3D {argv =3D 0x555555a6a3=
90, argc =3D 12, alloc =3D 24}, env_array =3D {
>             argv =3D 0x555555a2f760 <empty_argv>, argc =3D 0, alloc =3D =
0}, pid =3D 3068, trace2_child_id =3D 0, trace2_child_us_start =3D 0,
>           trace2_child_class =3D 0x0, trace2_hook_name =3D 0x0, in =3D 0=
, out =3D 3, err =3D 0, dir =3D 0x0, env =3D 0x555555a2f760 <empty_argv>,
>           no_stdin =3D 1, no_stdout =3D 0, no_stderr =3D 0, git_cmd =3D =
1, silent_exec_failure =3D 0, stdout_to_stderr =3D 0, use_shell =3D 0,
>           clean_on_exit =3D 0, wait_after_clean =3D 0, clean_on_exit_han=
dler =3D 0x0, clean_on_exit_handler_cbdata =3D 0x0}
>         buf =3D {alloc =3D 6816, len =3D 5924,
>           buf =3D 0x555555a864c0 " ## Metadata ##\nAuthor: Michal Suchan=
ek <msuchanek@suse.de>\n\n ## Commit message ##\n    Refresh sorted sectio=
n.\n\n    - Refresh patches.suse/powerpc-dump-kernel-log-before-carrying-o=
ut-fadump-o.patch wi"...}
>         contents =3D {alloc =3D 947512, len =3D 679767, buf =3D 0x7ffff7=
e69010 "commit 999192044274522b2d5820f40cd1a7436cce31b9"}
>         util =3D 0x555555a6a600
>         in_header =3D 0
>         line =3D 0x7ffff7e6aea0 "diff --git series.conf series.conf\nind=
ex c452d7c1308d..dd7b242a4c00 100644\n--- series.conf\n+++ series.conf\n@@=
 -47,17 +47,14 @@\n#\t", '#' <repeats 56 times>, "\n#\t# sorted pat"...
                                            ^^^^^^^^^^^ ^^^^^^^^^^^

I see that neither old nor new name start with the expected `a/` and
`b/`, respectively. But that `1` that was passed to
`parse_git_diff_header()` is the `p_value`, i.e. the number of leading
directories to strip from the file names.

And when there is nothing to strip, but it was told to strip something,
I guess `parse_git_diff_header()` just ignores it and leaves `new_name`
unassigned.

So here is how you can chase this down further:

- Why are those `a/` and `b/` prefixes missing? They should not be
  missing, they should be generated by default, and `range-diff` expects
  them.

  Probably some funny config setting in your setup, something that
  should probably be explicitly overridden by the `range-diff` machinery
  when generating those patches that are then fed into `read_patches()`.

- Why is `parse_git_diff_headers()` failing to report failure? You would
  be in the best position to debug this, probably by wittling down the
  example you have to something smaller so that you hit that snag right
  away, then setting a breakpoint on `parse_git_diff_headers()` and/or
  `git_header_name()` and single-step through it to find out where it
  failed to parse the name, and then try to patch it so that it returns
  failure in that case.

Good luck,
Johannes

>         current_filename =3D 0x555555a6b010 "scsi-cxlflash-Mark-expected=
-switch-fall-throughs.patch"
>         offset =3D <optimized out>
>         len =3D 107
>         size =3D 671943
> #3  0x00005555556cf304 in show_range_diff (range1=3D0x555555a69340 "76ac=
02e3549..cd5f86d59a73",
>     range2=3D0x555555a6a360 "76ac02e3549..3b77e5866178", creation_factor=
=3D60, dual_color=3D1, diffopt=3Ddiffopt@entry=3D0x7fffffffda60)
>     at range-diff.c:505
>         res =3D 0
>         branch1 =3D {items =3D 0x0, nr =3D 0, alloc =3D 0, strdup_string=
s =3D 1, cmp =3D 0x0}
> --Type <RET> for more, q to quit, c to continue without paging--c
>         branch2 =3D {items =3D 0x0, nr =3D 0, alloc =3D 0, strdup_string=
s =3D 1, cmp =3D 0x0}
> #4  0x00005555555de7c8 in cmd_range_diff (argc=3D<optimized out>, argv=
=3D<optimized out>, prefix=3D<optimized out>) at builtin/range-diff.c:80
>         creation_factor =3D 60
>         diffopt =3D {orderfile =3D 0x0, pickaxe =3D 0x0, single_follow =
=3D 0x0, a_prefix =3D 0x5555557b3780 "", b_prefix =3D 0x5555557b3780 "", l=
ine_prefix =3D 0x0, line_prefix_length =3D 0, flags =3D {recursive =3D 0, =
tree_in_recursive =3D 0, binary =3D 0, text =3D 0, full_index =3D 0, silen=
t_on_remove =3D 0, find_copies_harder =3D 0, follow_renames =3D 0, rename_=
empty =3D 1, has_changes =3D 0, quick =3D 0, no_index =3D 0, allow_externa=
l =3D 0, exit_with_status =3D 0, reverse_diff =3D 0, check_failed =3D 0, r=
elative_name =3D 0, ignore_submodules =3D 0, dirstat_cumulative =3D 0, dir=
stat_by_file =3D 0, allow_textconv =3D 0, textconv_set_via_cmdline =3D 0, =
diff_from_contents =3D 0, dirty_submodules =3D 0, ignore_untracked_in_subm=
odules =3D 0, ignore_dirty_submodules =3D 0, override_submodule_config =3D=
 0, dirstat_by_line =3D 0, funccontext =3D 0, default_follow_renames =3D 0=
, stat_with_summary =3D 0, suppress_diff_headers =3D 0, dual_color_diffed_=
diffs =3D 0, suppress_hunk_header_line_count =3D 0}, filter =3D 0, use_col=
or =3D -1, context =3D 3, interhunkcontext =3D 0, break_opt =3D -1, detect=
_rename =3D 0, irreversible_delete =3D 0, skip_stat_unmatch =3D 0, line_te=
rmination =3D 10, output_format =3D 0, pickaxe_opts =3D 0, rename_score =
=3D 0, rename_limit =3D -1, needed_rename_limit =3D 0, degraded_cc_to_c =
=3D 0, show_rename_progress =3D 0, dirstat_permille =3D 30, setup =3D 0, a=
bbrev =3D 12, ita_invisible_in_index =3D 0, ws_error_highlight =3D 4096, p=
refix =3D 0x0, prefix_length =3D 0, stat_sep =3D 0x0, xdl_opts =3D 8388608=
, anchors =3D 0x0, anchors_nr =3D 0, anchors_alloc =3D 0, stat_width =3D 0=
, stat_name_width =3D 0, stat_graph_width =3D 0, stat_count =3D 0, word_re=
gex =3D 0x0, word_diff =3D DIFF_WORDS_NONE, submodule_format =3D DIFF_SUBM=
ODULE_SHORT, objfind =3D 0x0, found_changes =3D 0, found_follow =3D 0, set=
_default =3D 0x0, file =3D 0x7ffff7309720 <_IO_2_1_stdout_>, close_file =
=3D 0, output_indicators =3D "+- ", pathspec =3D {nr =3D 0, has_wildcard =
=3D 0, recursive =3D 0, recurse_submodules =3D 0, magic =3D 0, max_depth =
=3D 0, items =3D 0x0}, pathchange =3D 0x0, change =3D 0x55555566a3a0 <diff=
_change>, add_remove =3D 0x55555566a8b0 <diff_addremove>, change_fn_data =
=3D 0x0, format_callback =3D 0x0, format_callback_data =3D 0x0, output_pre=
fix =3D 0x0, output_prefix_data =3D 0x0, diff_path_counter =3D 0, emitted_=
symbols =3D 0x0, color_moved =3D COLOR_MOVED_NO, color_moved_ws_handling =
=3D 0, repo =3D 0x555555a53b20 <the_repo>, parseopts =3D 0x0}
>         simple_color =3D -1
>         range_diff_options =3D {{type =3D OPTION_INTEGER, short_name =3D=
 0, long_name =3D 0x555555785379 "creation-factor", value =3D 0x7fffffffd9=
28, argh =3D 0x555555786937 "n", help =3D 0x55555578d0c0 "Percentage by wh=
ich creation is weighted", flags =3D 0, callback =3D 0x0, defval =3D 0, ll=
_callback =3D 0x0, extra =3D 0}, {type =3D OPTION_SET_INT, short_name =3D =
0, long_name =3D 0x55555578d05c "no-dual-color", value =3D 0x7fffffffd92c,=
 argh =3D 0x0, help =3D 0x55555578d06a "use simple diff colors", flags =3D=
 2, callback =3D 0x0, defval =3D 1, ll_callback =3D 0x0, extra =3D 0}, {ty=
pe =3D OPTION_END, short_name =3D 0, long_name =3D 0x0, value =3D 0x0, arg=
h =3D 0x0, help =3D 0x0, flags =3D 0, callback =3D 0x0, defval =3D 0, ll_c=
allback =3D 0x0, extra =3D 0}}
>         options =3D 0x0
>         res =3D 0
>         range1 =3D {alloc =3D 26, len =3D 25, buf =3D 0x555555a69340 "76=
ac02e3549..cd5f86d59a73"}
>         range2 =3D {alloc =3D 26, len =3D 25, buf =3D 0x555555a6a360 "76=
ac02e3549..3b77e5866178"}
> #5  0x000055555557146d in run_builtin (argv=3D<optimized out>, argc=3D<o=
ptimized out>, p=3D<optimized out>) at git.c:445
>         status =3D <optimized out>
>         help =3D <optimized out>
>         st =3D {st_dev =3D 93824997553696, st_ino =3D 140737336887026, s=
t_nlink =3D 140737488347232, st_mode =3D 114, st_uid =3D 0, st_gid =3D 143=
6972576, __pad0 =3D 21845, st_rdev =3D 5522724075126890240, st_size =3D 93=
824997553824, st_blksize =3D 93824997553696, st_blocks =3D 140737488346480=
, st_atim =3D {tv_sec =3D 140737488350949, tv_nsec =3D 140737488347232}, s=
t_mtim =3D {tv_sec =3D 93824997324640, tv_nsec =3D 140737488346640}, st_ct=
im =3D {tv_sec =3D 140737337196512, tv_nsec =3D 140737488346480}, __glibc_=
reserved =3D {93824994140141, 93824997552896, 93824993439848}}
>         prefix =3D <optimized out>
>         status =3D <optimized out>
>         help =3D <optimized out>
>         st =3D <optimized out>
>         prefix =3D <optimized out>
>         nongit_ok =3D <optimized out>
> #6  handle_builtin (argc=3D<optimized out>, argv=3D<optimized out>) at g=
it.c:674
>         args =3D {argv =3D 0x555555a2f760 <empty_argv>, argc =3D 0, allo=
c =3D 0}
>         cmd =3D <optimized out>
>         builtin =3D 0x555555a13f70 <commands+1968>
> #7  0x0000555555572575 in run_argv (argv=3D0x7fffffffddd0, argcp=3D0x7ff=
fffffdddc) at git.c:741
>         done_alias =3D 0
>         cmd_list =3D {items =3D 0x0, nr =3D 0, alloc =3D 0, strdup_strin=
gs =3D 0, cmp =3D 0x0}
>         seen =3D <optimized out>
>         done_alias =3D <optimized out>
>         cmd_list =3D <optimized out>
>         seen =3D <optimized out>
>         args =3D <optimized out>
>         i =3D <optimized out>
>         i =3D <optimized out>
>         sb =3D <optimized out>
>         item =3D <optimized out>
> #8  cmd_main (argc=3D<optimized out>, argv=3D<optimized out>) at git.c:8=
72
>         was_alias =3D <optimized out>
>         cmd =3D 0x7fffffffe488 "range-diff"
>         done_help =3D <optimized out>
> #9  0x00005555555710a8 in main (argc=3D4, argv=3D0x7fffffffe068) at comm=
on-main.c:52
>         result =3D <optimized out>
> (gdb) l
> 57		andl	$(2 * VEC_SIZE - 1), %ecx
> 58		cmpl	$VEC_SIZE, %ecx
> 59		ja	L(cros_page_boundary)
> 60
> 61		/* Check the first VEC_SIZE bytes.  */
> 62		VPCMPEQ (%rdi), %ymm0, %ymm1
> 63		vpmovmskb %ymm1, %eax
> 64		testl	%eax, %eax
> 65
> 66	# ifdef USE_AS_STRNLEN
> (gdb) quit
> A debugging session is active.
>
> 	Inferior 1 [process 3063] will be killed.
>
> Quit anyway? (y or n) y
>
> =1B[K=1B[7mlines ?-?/? (END)=1B[27m=1B[K
> =1B[K=1B[?1l=1B>=1B[?1049l=1B[23;0;0t=1B[0;32m=E2=9C=94=1B[0;0m =1B[0;33=
m~/kernel-source=1B[0;0m [=1B[0;35mSLE15-SP2=1B[0;0m =E2=86=91=C2=B782=1B[=
0;0m|=1B[0;36m=E2=80=A617791=1B[0;0m=1B[1;34m=E2=9A=91 9=1B[0;0m=1B[0;0m]
>
> =1B[0;37m12:16=1B[0;0m $ gdb --args git range-diff 76ac02e3549..cd5f86d5=
9a73 76ac02e3549..3b77e5866178
> =1B[C=1B[C=1B[C=1B[C=1B[C=1B[C=1B[C=1B[Cldd `which git`=1B[K
> 	linux-vdso.so.1 (0x00007ffe55bfd000)
> 	libpcre2-8.so.0 =3D> /usr/lib64/libpcre2-8.so.0 (0x00007f125f849000)
> 	libz.so.1 =3D> /lib64/libz.so.1 (0x00007f125f632000)
> 	libsha1detectcoll.so.1 =3D> /usr/lib64/libsha1detectcoll.so.1 (0x00007f=
125f428000)
> 	libpthread.so.0 =3D> /lib64/libpthread.so.0 (0x00007f125f20a000)
> 	librt.so.1 =3D> /lib64/librt.so.1 (0x00007f125f002000)
> 	libc.so.6 =3D> /lib64/libc.so.6 (0x00007f125ec48000)
> 	/lib64/ld-linux-x86-64.so.2 (0x00007f125ffdc000)
> =1B[0;32m=E2=9C=94=1B[0;0m =1B[0;33m~/kernel-source=1B[0;0m [=1B[0;35mSL=
E15-SP2=1B[0;0m =E2=86=91=C2=B782=1B[0;0m|=1B[0;36m=E2=80=A617791=1B[0;0m=
=1B[1;34m=E2=9A=91 9=1B[0;0m=1B[0;0m]
>
> =1B[0;37m12:16=1B[0;0m $ exit
>
> Script done on 2019-09-23 12:16:17+0200
>

--8323328-1855128131-1570009330=:46--
