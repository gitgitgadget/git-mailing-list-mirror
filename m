Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 356E31F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 12:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387859AbfJ2M4V (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 08:56:21 -0400
Received: from mout.gmx.net ([212.227.15.19]:58687 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729253AbfJ2M4V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 08:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572353776;
        bh=H2UB+S8QjOYH5Qvwwi4WOX2ilsQNojOUQxGSMJyL5bg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=UGTRwjRfDVf7S9qfLzS6bnow+9vJEnmDCC5lp+vP2W08HwEQIWytdhNFSOUGAegNX
         Ap5s1yCzcjgPJLTw4BrgZ1dX8g3htBaTzg8h1uo8Y5Vz7sJJY3/Tv9CvgY4t8yBPvG
         UfLG9UuecKm+PWICRrNmvybR/QLzueQOQYBY0CWw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MysRk-1i4AlO01z8-00vume; Tue, 29
 Oct 2019 13:56:16 +0100
Date:   Tue, 29 Oct 2019 13:56:01 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     george espinoza via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, George Espinoza <gespinoz2019@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        george espinoza <gespinoz2019@gmail.com>
Subject: Re: [PATCH 1/1] [Outreachy] merge-ours: include parse-options
In-Reply-To: <8c088194f604eac3a6b00c48a7fddfdf807571fc.1572306149.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910291355070.46@tvgsbejvaqbjf.bet>
References: <pull.425.git.1572306149.gitgitgadget@gmail.com> <8c088194f604eac3a6b00c48a7fddfdf807571fc.1572306149.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:I+tPpDobt8RwRof9k+qo2qLeaLyfWUl2TOEvTYziqa5tbiRs7w/
 yX+0YfUe+we7ud/5Z60zVCgzsBNU5m0Xh5yj7axaswEDfjO47GDX1gtRiDVq2hMvI7+/nET
 rgeKLBVMr7QzYXggnT2yq1Wcp+71MtA1M5fPtBVY5GH3HIMqBDz41g9+uQbso8lJpQIykCd
 m8WwgFyIL8GfqCZ1YiaBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sbhXJw3Kd7A=:XtIVZaOCROSFUbdl3+sogD
 OdbywCGDstEkPddcl03oe1WYmXhUW0pAf2CQsQx2Tu09h8Wzzrs8ZE7ozKBW86AwJ2lxgU31Z
 CpXAwvxCw5EK1CBTfLA7bExjX+JHxI2lw48rlkP/fkeIgmU9AYUNc7liZzuRRffNrKV73rCjK
 9tqbg39+m8vYpUQe/UAz5wRjazeI1w6JlQGNthBzqBIMD/dlIefnGt7gp0RZ3AvXiddIQqroJ
 04PNHqF/UgcneAaEQSYqtyoyvT/dsz/ZtrvbiDsdngmUiGdpaacZ67ggzKSRSWbpgnhnjrBTN
 w8BsO+KqMHYd9XxSMsL/UezWmKNnV08+mIKDFZNz1ZhPHJvrTxKPoH3y19QtkCwubMOOURlT0
 i9aRqgE1wrMqExipD67p37x36j9SQ32aXikfVSU4HYmm9OV9W1FqFD3TjXgAt1njAQVJsguKY
 taw7JuctRhdA2WBqfDP06Vxxt9n+7PGfZ31L9007zCWGnxNF3y8NaNYflZraSkHtVXk77c928
 aG4DSf0QNPAS2+UzNolluIrHArir/mBNt30tqz6ayT6WcfqOgemJHWIudViB3x78GqoCi35eP
 d2NJvqLpxvVsJeRbWCzriBw1HnDMykKqHvhZOEbZ9/ZWsuh7aSOuiATE08/1Sg83q6Ge9t1St
 JF9MNjRg2TXOtEgF4s+PtXQQo6aWvR/h7jSpYYcvc/wFGsUSQYaQftMAdLOqLegt8KzBxRMnA
 +yyD68SePjzPtDrTrIk7z2uI0XL3UA04GRTdReERlHfJQ1mAfcFxDbqtPR2BZX8ijz8NnHGRV
 rICGQug9G8fyMvExedBp8YxP8AWBBXM6RCQCHdrO1YIbIurdtJd+jlVA3Bp2tGrjD0nUcN/sp
 R9OkbDgH2iiM1Qvl0+0Kwk/tPBm+ZT7cbCgVpcvgGOvZB3jmfSccCA/yIe7XMqS6VTDB7vw9B
 24WJdwOj7cQt4+MSkHteBlqnBSc4rEEKraZTnhbLZvS073HSIrMqDyr4yd07pi00N5JAAxDsU
 7cxo27X5UmAY3s+frp2W40bwadE04YvYTh2W1phsEK6jPyd5FmJXcw6vU4gOcN0aFg86911TU
 zH+LHaDxZyuTNzWz6BJS0cPDI9nm/ipVsWpgRpay8UlHx7z8Gawqeajs4vXjiXEWCXlpSsgOz
 WePzuzp1H9geBSnLY47o4hFF+BSG5IrWU5MtsEQHGzFl7lq+mhdmdhNFIl2PCo5oC8mBdpVIO
 ZA+Pj0stbQ/C/WAe7Zdv8/aMlyaIRkNaOqKHW+sj3TFZ1iJWMPygNkUErT2Q=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi george,

On Mon, 28 Oct 2019, george espinoza via GitGitGadget wrote:

> From: george espinoza <gespinoz2019@gmail.com>
>
> Teach this command which currently handles its own argv to use
> parse-options instead because parse-options helps make sure we handle
> user input like -h in a standardized way across the project.
> Also deleted the NO_PARSEOPT flag from git.c to coincide with
> the conversion of the structure in this command since merge-ours
> now uses parse-options and needed to update git.c accordingly.

The commit message and the patch look good to me!

Thanks,
Johannes

>
> Signed-off-by: george espinoza <gespinoz2019@gmail.com>
> ---
>  builtin/merge-ours.c | 14 ++++++++++----
>  git.c                |  2 +-
>  2 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/merge-ours.c b/builtin/merge-ours.c
> index 4594507420..fb3674a384 100644
> --- a/builtin/merge-ours.c
> +++ b/builtin/merge-ours.c
> @@ -11,14 +11,20 @@
>  #include "git-compat-util.h"
>  #include "builtin.h"
>  #include "diff.h"
> +#include "parse-options.h"
>
> -static const char builtin_merge_ours_usage[] =3D
> -	"git merge-ours <base>... -- HEAD <remote>...";
> +static const char * const merge_ours_usage[] =3D {
> +	N_("git merge-ours [<base>...] -- <head> <merge-head>..."),
> +	NULL,
> +};
>
>  int cmd_merge_ours(int argc, const char **argv, const char *prefix)
>  {
> -	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
> -		usage(builtin_merge_ours_usage);
> +	struct option options[] =3D {
> +		OPT_END()
> +	};
> +
> +	argc =3D parse_options(argc, argv, prefix, options, merge_ours_usage, =
0);
>
>  	/*
>  	 * The contents of the current index becomes the tree we
> diff --git a/git.c b/git.c
> index ce6ab0ece2..6aee0e9477 100644
> --- a/git.c
> +++ b/git.c
> @@ -527,7 +527,7 @@ static struct cmd_struct commands[] =3D {
>  	{ "merge-base", cmd_merge_base, RUN_SETUP },
>  	{ "merge-file", cmd_merge_file, RUN_SETUP_GENTLY },
>  	{ "merge-index", cmd_merge_index, RUN_SETUP | NO_PARSEOPT },
> -	{ "merge-ours", cmd_merge_ours, RUN_SETUP | NO_PARSEOPT },
> +	{ "merge-ours", cmd_merge_ours, RUN_SETUP },
>  	{ "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE |=
 NO_PARSEOPT },
>  	{ "merge-recursive-ours", cmd_merge_recursive, RUN_SETUP | NEED_WORK_T=
REE | NO_PARSEOPT },
>  	{ "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK=
_TREE | NO_PARSEOPT },
> --
> gitgitgadget
>
