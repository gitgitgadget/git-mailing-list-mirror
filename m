Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51A3C1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 10:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbeGQKr0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 06:47:26 -0400
Received: from mout.gmx.net ([212.227.17.21]:53675 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729665AbeGQKr0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 06:47:26 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LbxQO-1gMAUh0pFs-00jKZZ; Tue, 17
 Jul 2018 12:15:31 +0200
Date:   Tue, 17 Jul 2018 12:15:14 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 1/5] format-patch: allow additional generated content
 in make_cover_letter()
In-Reply-To: <20180530080325.37520-2-sunshine@sunshineco.com>
Message-ID: <nycvar.QRO.7.76.6.1807171214590.71@tvgsbejvaqbjf.bet>
References: <20180530080325.37520-1-sunshine@sunshineco.com> <20180530080325.37520-2-sunshine@sunshineco.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DuLCZQn3Yyw64A2B2kZ/cslELkU8TJMYZyFXbhsi2+QCVGxxegU
 zxXeQeg6mVaZfIPaIM2f6bU99qyRatVA5Rp14NWJO7ia0sHAvG+xnvzxzPuLYDbAITPJ4wW
 WHs+9fUiHQe26rO37FPNo0lEuU2zO3u33IWaLcSpxTt5rCyY6sh+lj2m+xU6IixvVZ8DQIF
 rhrppluA885aAm6sv4pmg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JkMLrNPbrC0=:ks4GizO+3L60X40LoI2WR9
 Gcsq+dd+PhU/MysF7N529LFMFMGvQ25ou4+x3laB95PM9CjaHAoJy21jeqFGgZ1wA+9iTniOK
 Zyv1Zq9k8OknRRAEK67eDkVVavbGdrloHZTQfafJEukbOPFHrxalWfRm2Ajb0RYs2d5h6NHLs
 vOwiu+ZCJOnhW+7aYpi3Dl+wtpGpI6U4+tAQ773obo/LuLi+y56ND+xOMwutwvINAr4Xq9TYn
 j0zZrQqT04rjRGDBMy5Kz1vwRK1iq8KERJIv8pTCCiZvSq4+7UQzEHsI1XqDexZpMY+NIq0er
 4WpdLF3SkjJGRtIRH+X8faID+FA2Uk2xI60gMwrBulMuELSEGH7/epwPCFnHHw0GkGnhnpLVA
 ZbywbTEAT6yRP+3T6ae8AhZ1TnHxE98iUKQ9Vra3fxEiDkm4HMH0+K00UOtEYaDrYTP7MHJ/e
 JjdGjHkC4y0DBMKy+NFuCINgQF7jsTtX6zrOz31319rEjbI74Mrx6o6z7tduN2jti8koQwEJj
 DUWKz9L8kYpV6Kq8NB6h8trVKMg1pmgH6Bww4k0A+KqpxIlj7QNSJJ6xizPZqQGiSVHEYhKo2
 QVCRzM6i+eTAjfp8liyQM1GAyRWLnYLNy/OUQlscmF202kae21MtLD7lBBZ26I2vML35Le3Bz
 n/V+EsMoJ2ooA7WvO3UX76I7IAq26V+0s25axvrhZ25bgkU+bIHdLRXNDc0MzZGjxWX14Y23n
 4dFoQE39gK6tyglN+/NW4Et8z7hWiowfW4PWcDAq9RY5mcjYukWwLjmGe9mExAoCzJoHELor+
 vh4qupq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Wed, 30 May 2018, Eric Sunshine wrote:

> make_cover_letter() returns early when it lacks sufficient state to emit
> a diffstat, which makes it difficult to extend the function to reliably
> emit additional generated content. Work around this shortcoming by
> factoring diffstat-printing logic out to its own function and calling it
> as needed without otherwise inhibiting normal control flow.
> 
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>

Makes sense.

Ciao,
Dscho

> ---
>  builtin/log.c | 43 +++++++++++++++++++++++--------------------
>  1 file changed, 23 insertions(+), 20 deletions(-)
> 
> diff --git a/builtin/log.c b/builtin/log.c
> index 71f68a3e4f..e01a256c11 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -992,6 +992,26 @@ static char *find_branch_name(struct rev_info *rev)
>  	return branch;
>  }
>  
> +static void emit_diffstat(struct rev_info *rev,
> +			  struct commit *origin, struct commit *head)
> +{
> +	struct diff_options opts;
> +
> +	memcpy(&opts, &rev->diffopt, sizeof(opts));
> +	opts.output_format = DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
> +	opts.stat_width = MAIL_DEFAULT_WRAP;
> +
> +	diff_setup_done(&opts);
> +
> +	diff_tree_oid(&origin->tree->object.oid,
> +		      &head->tree->object.oid,
> +		      "", &opts);
> +	diffcore_std(&opts);
> +	diff_flush(&opts);
> +
> +	fprintf(rev->diffopt.file, "\n");
> +}
> +
>  static void make_cover_letter(struct rev_info *rev, int use_stdout,
>  			      struct commit *origin,
>  			      int nr, struct commit **list,
> @@ -1005,7 +1025,6 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
>  	struct strbuf sb = STRBUF_INIT;
>  	int i;
>  	const char *encoding = "UTF-8";
> -	struct diff_options opts;
>  	int need_8bit_cte = 0;
>  	struct pretty_print_context pp = {0};
>  	struct commit *head = list[0];
> @@ -1055,25 +1074,9 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
>  
>  	shortlog_output(&log);
>  
> -	/*
> -	 * We can only do diffstat with a unique reference point
> -	 */
> -	if (!origin)
> -		return;
> -
> -	memcpy(&opts, &rev->diffopt, sizeof(opts));
> -	opts.output_format = DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
> -	opts.stat_width = MAIL_DEFAULT_WRAP;
> -
> -	diff_setup_done(&opts);
> -
> -	diff_tree_oid(&origin->tree->object.oid,
> -		      &head->tree->object.oid,
> -		      "", &opts);
> -	diffcore_std(&opts);
> -	diff_flush(&opts);
> -
> -	fprintf(rev->diffopt.file, "\n");
> +	/* We can only do diffstat with a unique reference point */
> +	if (origin)
> +		emit_diffstat(rev, origin, head);
>  }
>  
>  static const char *clean_message_id(const char *msg_id)
> -- 
> 2.17.1.1235.ge295dfb56e
> 
> 
