Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDF0E1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 10:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbeJPSMO (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 14:12:14 -0400
Received: from mout.gmx.net ([212.227.17.20]:47995 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbeJPSMO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 14:12:14 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MNqcR-1gJCvI3bhr-007U7Y; Tue, 16
 Oct 2018 12:22:27 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MNqcR-1gJCvI3bhr-007U7Y; Tue, 16
 Oct 2018 12:22:27 +0200
Date:   Tue, 16 Oct 2018 12:22:30 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v10 00/21] Convert "git stash" to C builtin
In-Reply-To: <20181015221040.GD4883@hank.intra.tgummerer.com>
Message-ID: <nycvar.QRO.7.76.6.1810161205530.4546@tvgsbejvaqbjf.bet>
References: <https://public-inbox.org/git/cover.1537913094.git.ungureanupaulsebastian@gmail.com/> <cover.1539553398.git.ungureanupaulsebastian@gmail.com> <20181015221040.GD4883@hank.intra.tgummerer.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:nstQ9GHoM9OwoEgJmEM1cJHjrNTBl1QigWrxLUOZWpmu0tvTSvP
 JC0aqm9ESnMurGAt133csDSnH3iIgcfut7tMnaSSImhxMXxE3V5cJQFktyvlZhFSvw/er4a
 zfVApxNkPiM7mcsNnh6AcNCpBLaErNTD44Lw/NVo/XvPdNltgbHd4B1+b3JdHr7fQFYY8rA
 SL7d9+l3/NF0at0fFThMQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:w2/v6D9GMGU=:PdkipUDwQY5/UQdMmhKOaS
 mPtP4SUDsSY9ewQ4D6ljsf7y0COi57ovZEf8vTq2qOjCIQsuSYI481rECJtmJc2csSgmyytND
 r4PgexsQdttrHLf5o03lsqDX5GVpdnW6V90GNz5QhddjfjhPDLk/ywQ3yMFhX2cjAbBRKXocM
 JVKd+9ZsLLoT0WhlAHVRyBzg4Z2Fdr7I6seKy0QNXYm6ztcWGRtccarLMfrXcv8uhGk7cOWTe
 7AP1WrmPyQ6o/3xhOilmlJTuV3sDptXsBWWQzqZ0GHzqeUNS0M3bG/U6hkiDgBgaFNz99mhIq
 Gr6QnkqWB9iqgqLoX74KSY93FHFxXBqyHdmUps76IeIVcqZK0Qakc7wlO3m5VjZdN/Zp61vBO
 sPCvdmfQ65J6QlWnZ0Br4041N3uFNBTHePYH6Mp3Y5f0pldLRCwNLQb1XLyz3n8YnncxTINWC
 quXH5K5APeWFuj025OHO7sJmrVJHdCh1z5aYyEDwVqcck6bQLF9ayA/g2bry7xeTj1D8At9OY
 tDYgZ/i+f9VUz4WDBA0y4jwBvQPCgONs/vMTECTJcpo6YU2DWCdNZFuOFD12fwFALLf/eEe10
 1cveNZwwgjHQEoCijNLUdxjfn1RIr03wWKDsHNGAdHEv7/u3/ckyWZBs5JN9XdxrkQs+7oh0C
 76nDWWRJEC0RE9MITPcrfYhUZy0Q1pyr6EmMGG7U7sfweZJGDMQggPhQb4S2n5bitWMpgWVEQ
 lNafUmEG07GnCu7+V3aRDXipE9rCeRaT6SSq+i7TFvKqfFr4C+8weguz+Z+ewNTaQEzd1o1nd
 EACKX/qf7UPTGSsqN+c74Z7Wmw5VPwQG2J7YEjnajsSc2KbrNU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Mon, 15 Oct 2018, Thomas Gummerer wrote:

>  2:  63f2e0e6f9 !  2:  2d45985676 strbuf.c: add `strbuf_join_argv()`
>     @@ -14,19 +14,17 @@
>       	strbuf_setlen(sb, sb->len + sb2->len);
>       }
>       
>     -+const char *strbuf_join_argv(struct strbuf *buf,
>     -+			     int argc, const char **argv, char delim)
>     ++void strbuf_join_argv(struct strbuf *buf,
>     ++		      int argc, const char **argv, char delim)

While the patch series does not use the return value, I have to ask
whether it would really be useful to change it to return `void`. I could
imagine that there may already be quite a few code paths that would love
to use strbuf_join_argv(), *and* would benefit from the `const char *`
return value.

In other words: just because the *current* patches do not make use of that
quite convenient return value does not mean that we should remove that
convenience.

>  7:  a2abd1b4bd !  8:  974dbaa492 stash: convert apply to builtin
>     @@ -370,18 +370,20 @@
>      +
>      +			if (diff_tree_binary(&out, &info->w_commit)) {
>      +				strbuf_release(&out);
>     -+				return -1;
>     ++				return error(_("Could not generate diff %s^!."),
>     ++					     oid_to_hex(&info->w_commit));

Please start the argument of an `error()` call with a lower-case letter.

>      +			}
>      +
>      +			ret = apply_cached(&out);
>      +			strbuf_release(&out);
>      +			if (ret)
>     -+				return -1;
>     ++				return error(_("Conflicts in index."
>     ++					       "Try without --index."));

Same here.

>      +
>      +			discard_cache();
>      +			read_cache();
>      +			if (write_cache_as_tree(&index_tree, 0, NULL))
>     -+				return -1;
>     ++				return error(_("Could not save index tree"));

And here.

> 15:  bd827be103 ! 15:  989db67e9a stash: convert create to builtin
>     @@ -119,7 +119,6 @@
>      +static int check_changes(struct pathspec ps, int include_untracked)
>      +{
>      +	int result;
>     -+	int ret = 0;

I was curious about this change, and could not find it in the
git-stash-v10 tag of https://github.com/ungps/git...

> 18:  1c501ad666 ! 18:  c90e30173a stash: convert save to builtin
>     @@ -72,8 +72,10 @@
>      +			     git_stash_helper_save_usage,
>      +			     PARSE_OPT_KEEP_DASHDASH);
>      +
>     -+	if (argc)
>     -+		stash_msg = (char*) strbuf_join_argv(&buf, argc, argv, ' ');
>     ++	if (argc) {
>     ++		strbuf_join_argv(&buf, argc, argv, ' ');
>     ++		stash_msg = buf.buf;
>     ++	}

Aha! So there *was* a user of that return value. I really would prefer a
non-void return value here.

> 19:  c4401b21db ! 19:  4360ea875d stash: convert `stash--helper.c` into `stash.c`
>     @@ -264,9 +320,9 @@
>      -	argc = parse_options(argc, argv, prefix, options,
>      -			     git_stash_helper_create_usage,
>      -			     0);
>     -+	/* Startinf with argv[1], since argv[0] is "create" */
>     -+	stash_msg = (char*) strbuf_join_argv(&stash_msg_buf, argc - 1,
>     -+					     ++argv, ' ');
>     ++	/* Starting with argv[1], since argv[0] is "create" */
>     ++	strbuf_join_argv(&stash_msg_buf, argc - 1, ++argv, ' ');
>     ++	stash_msg = stash_msg_buf.buf;

Again, I would strongly prefer the convenience of assigning the return
value directly, rather than having two lines.

>     @@ -375,10 +425,8 @@
>      +			 * they need to be immediately followed by a string
>      +			 * (i.e.`-m"foobar"` or `--message="foobar"`).
>      +			 */
>     -+			if ((strlen(argv[i]) > 2 &&
>     -+			     !strncmp(argv[i], "-m", 2)) ||
>     -+			    (strlen(argv[i]) > 10 &&
>     -+			     !strncmp(argv[i], "--message=", 10)))
>     ++			if (starts_with(argv[i], "-m") ||
>     ++			    starts_with(argv[i], "--message="))

Very nice.

> 20:  92dc11fd16 ! 20:  a384b05008 stash: optimize `get_untracked_files()` and `check_changes()`
>     @@ -52,7 +52,6 @@
>      +static int check_changes_tracked_files(struct pathspec ps)
>       {
>       	int result;
>     --	int ret = 0;

I also wonder about this change, in light of...

>       	struct rev_info rev;
>       	struct object_id dummy;
>      -	struct strbuf out = STRBUF_INIT;
>     @@ -99,8 +98,8 @@
>      -	if (!check_changes(ps, include_untracked)) {
>      +	if (!check_changes(ps, include_untracked, &untracked_files)) {
>       		ret = 1;

this here line. How does that work, if `ret` is removed? And why didn't
the `make DEVELOPER=1` complain about that unused `ret` variable before?

>     - 		*stash_msg = NULL;
>       		goto done;
>     + 	}
>      @@
>       		goto done;

The rest of the changes looks pretty sensible to me (indentation/wrapping
changes, mostly, with a couple of commit message/typo fixes thrown in).

Maybe you have a commit hash, or even better, a tag in a public Git
repository somewhere, so that Paul can pick it up more easily (and compare
the changes with his latest local branch)?

Thank you!
Dscho
