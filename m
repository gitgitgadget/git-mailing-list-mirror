Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84CD21F404
	for <e@80x24.org>; Wed, 29 Aug 2018 12:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbeH2QvP (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 12:51:15 -0400
Received: from mout.gmx.net ([212.227.15.15]:38623 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727452AbeH2QvP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 12:51:15 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LnxQO-1fSFs538u0-00fwVS; Wed, 29
 Aug 2018 14:54:21 +0200
Date:   Wed, 29 Aug 2018 14:54:20 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, corrmage@gmail.com,
        avarab@gmail.com, sbeller@google.com
Subject: Re: [PATCH 2/3] merge-recursive: add ability to turn off directory
 rename detection
In-Reply-To: <20180829070613.11793-3-newren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1808291452070.71@tvgsbejvaqbjf.bet>
References: <xmqqh8jeh1id.fsf@gitster-ct.c.googlers.com> <20180829070613.11793-1-newren@gmail.com> <20180829070613.11793-3-newren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:s6QfPPAu9yuOM3SR6lE4RRLWyGAnNrSlsZlxJPjPdta44AXsUjC
 tSWoQkepXqajgu0328BL4jM7bffO5+4HhUQBlq2Hiyse40QzmcktV5fPMKpll7onGD28qsy
 NDI2IsuX/6P1CKUK5EKGme9OLDipL/U0G/yRghfoLZ1Q/9iyPI8CRBCu2Z2hjhGVsS7dBli
 lokU4LCVCARbdVgTdndPQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4pvKbfAtC0c=:SeKh23Cvr7/XudwJ2yxwo5
 5ay61aZBzBhHCJIMbANwM7UkUDnIQZMHSOdpVXBg21hPCxrEZ6Jul7O+1e2V+xs02qrPvVU2q
 ML6W6fC1vrsLZ3WrkoLt+XhBgkynzRwG6zcX5sr6QkpXU3mhr4/d1Ebj2x06wnISB5Uh52AIC
 pJWe3sEdYRDrViNtgQ1l/XxCwREmG3vRYmXuujXTRdLPCxnc1YP8HcZ/T4z1ypZgR7o6lNXru
 CyMFdTJXaXGsE/tbGxjmxNZU1IQmOYnAoETiuDWxJ4PIEL51M9we3i7pBOb9wT8b3DDjYdbxo
 7IbAYFrubO3Yc70njftZ1WReGfZuzp/enQ5iUleIs7I4fZYtoj+ynrfSp6s9YpywE5g3fq8qq
 waIaUP53XuCQy8CwBwE86WefgQ3Eu2rgTHRCxD003U6FTMDp6rW4egMNpT3POY1l0CW33AaSw
 OVQfaDkFYwQmNmp+eRATRzUkPvlSmu25ZduasNe8DBsWssefWVOb3FC3AUmO/x26LExip7Q7f
 md6426EHEwwE97x9riYSkXqggNo9m61qxNhdEhpeb3zG1Z8Jm3HNr6de3+XK/sBZ/Nunl8vbk
 Mnp4BScCmXK4+noRbDyC9mFzFY0koTEuye/vbJVe9SoBUQcSjPL2061WlfIUu3Ufcl5b2fSkt
 Jp9NIH5imtAb6CoknKiUnRZsmLZd6MzMgjJhSma4VPNpve8aPy/3U5LeTJTNsBdDgJd6FVxSA
 ES03xCgJA6EeqcsbrOo2lX0qdymWEalc72AX8+kgQKVqkLlk5mbiCu6fA/tp08UzSU+zW3nzE
 i6P7dXk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Wed, 29 Aug 2018, Elijah Newren wrote:

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-recursive.c | 18 +++++++++++++-----
>  merge-recursive.h |  1 +
>  2 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/merge-recursive.c b/merge-recursive.c
> index f110e1c5ec..bf3cb03d3a 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -2843,12 +2843,19 @@ static int handle_renames(struct merge_options *o,
>  	head_pairs = get_diffpairs(o, common, head);
>  	merge_pairs = get_diffpairs(o, common, merge);
>  
> -	dir_re_head = get_directory_renames(head_pairs, head);
> -	dir_re_merge = get_directory_renames(merge_pairs, merge);
> +	if (o->detect_directory_renames) {
> +		dir_re_head = get_directory_renames(head_pairs, head);
> +		dir_re_merge = get_directory_renames(merge_pairs, merge);
>  
> -	handle_directory_level_conflicts(o,
> -					 dir_re_head, head,
> -					 dir_re_merge, merge);
> +		handle_directory_level_conflicts(o,
> +						 dir_re_head, head,
> +						 dir_re_merge, merge);
> +	} else {
> +		dir_re_head  = xmalloc(sizeof(*dir_re_head));
> +		dir_re_merge = xmalloc(sizeof(*dir_re_merge));

This is not a suggestion to change anything, but a genuine question out of
curiosity: would it make sense to put the `dir_re_head` and `dir_re_merge`
structures into `struct merge_options` to avoid these extra `malloc()`s?
Or would that cause issues with the recursive nature of the recursive
merge?

Ciao,
Dscho

> +		dir_rename_init(dir_re_head);
> +		dir_rename_init(dir_re_merge);
> +	}
>  
>  	ri->head_renames  = get_renames(o, head_pairs,
>  					dir_re_merge, dir_re_head, head,
> @@ -3541,6 +3548,7 @@ void init_merge_options(struct merge_options *o)
>  	o->renormalize = 0;
>  	o->diff_detect_rename = -1;
>  	o->merge_detect_rename = -1;
> +	o->detect_directory_renames = 1;
>  	merge_recursive_config(o);
>  	merge_verbosity = getenv("GIT_MERGE_VERBOSITY");
>  	if (merge_verbosity)
> diff --git a/merge-recursive.h b/merge-recursive.h
> index fa7bc6b683..e39ee5d78b 100644
> --- a/merge-recursive.h
> +++ b/merge-recursive.h
> @@ -18,6 +18,7 @@ struct merge_options {
>  	unsigned renormalize : 1;
>  	long xdl_opts;
>  	int verbosity;
> +	int detect_directory_renames;
>  	int diff_detect_rename;
>  	int merge_detect_rename;
>  	int diff_rename_limit;
> -- 
> 2.18.0.12.g97a29da30a
> 
> 
