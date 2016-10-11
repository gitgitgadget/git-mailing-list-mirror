Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45CF5207EC
	for <e@80x24.org>; Tue, 11 Oct 2016 10:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752729AbcJKKIF (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 06:08:05 -0400
Received: from mout.gmx.net ([212.227.17.21]:57952 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752301AbcJKKIE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 06:08:04 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0M0yaB-1b0Yd90xzT-00v46E; Tue, 11 Oct 2016 12:07:56
 +0200
Date:   Tue, 11 Oct 2016 12:07:55 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 05/25] sequencer: eventually release memory allocated
 for the option values
In-Reply-To: <xmqqzimbc0gw.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610111148340.35196@virtualbox>
References: <cover.1473590966.git.johannes.schindelin@gmx.de>        <cover.1476120229.git.johannes.schindelin@gmx.de>        <a67af02ef363311b526bddba864c7f1ca9087b43.1476120229.git.johannes.schindelin@gmx.de>
 <xmqqzimbc0gw.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Z1L+zhFSMDLZ6HLSl2VIBaVMu7Z5p2HRJMvZIhk1dN+n667Z3NM
 eAolmc3OVIV0JIfnJYyHRLC13HKB4JAnBfs6FASrD9PWheCQgD8EEzurVh7agn3Yop5oxC8
 RJZ3wMoAv1yWHpcMwEP3RmEU9B1Tj43Gnp0DhmGiMbhRQuCGwf6+NvQhBbCNWLLd0XV7tBy
 4PLE3FHt4mn20es+hfMwQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QONikq/8cQk=:U+5STq5yRrVrySUPZGl47p
 yAVMmZglg+hhQ4eQFznGpaYJi1nUpRmXr+34fr37QFoLdp31njyNzGUok2L4sb8GgbKeu8YJw
 KDgOAPMoYLVKxJoXcysyEVvGsSAWeYypKuVBiGJtkZ/BfP2NMglgwMwcq46l0JJj3LVF8bz4K
 xiR7VOBV1SHK4beQJWkOCVEtPzjQ1hKbWGx7WOcg/nSTWjlLZ6/jHgNMQkjc3l83LD9FYQXld
 2b7Fc7WBGKhMoYMUlBaHRKCHeYs3cNzWZV8SvMMNABa3IMS+ndXsjgx5Z3SsVWD4IEtqbfZbs
 jpU5J0jiwFHXb7aEWoshbH+dHhKS1yFFPt7w3xKSqQRYM4LFb0a8UAg0Lfp0oS46UtMZQ0vT5
 KuVWfbklBojdDhBQr0i4xYNIbdgqv6cbYCzyJDwLJRmkQFG1YMhFmsXuZ1ViMz/9G37iwsLC5
 SGK4MHEG0GT4FeVPxPS6qUeOi5LBD6mInBGKOFazpd2HfP8/Ksi9IKl483CNrUaRihqJLR96V
 oOZOPHFY5do6KaLsOjLVqA2IJBaBQ816dB1TnGcpRVc7rBxK8oz4vcT7lDufHvijMWs+NhzxG
 ku0DAVF/QpHdCR/oLBH1wpYORVBLKsFQXPQpokd068dB1S2pzwQaYkTSmqmy5VUSEVbcqSDdn
 o+s02V3Xba9/oMb+5a0GRDd52QsMloYfyV0tsKcXzcq7l+WZp/f2C6ifebUBbCazduZ34ThwJ
 pA/d/54hVOZCSP9ay4oQwnI3Hduq3OkBd9BXh0CkTcm9c2+caAxZkn3RKdDfRQvBOG6yE1ht+
 VqUXesl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 10 Oct 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > diff --git a/builtin/revert.c b/builtin/revert.c
> > index 7365559..fce9c75 100644
> > --- a/builtin/revert.c
> > +++ b/builtin/revert.c
> > @@ -174,6 +174,12 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
> >  
> >  	if (argc > 1)
> >  		usage_with_options(usage_str, options);
> > +
> > +	/* These option values will be free()d */
> > +	if (opts->gpg_sign)
> > +		opts->gpg_sign = xstrdup(opts->gpg_sign);
> > +	if (opts->strategy)
> > +		opts->strategy = xstrdup(opts->strategy);
> >  }
> 
> This certainly is good, but I wonder if a new variant of OPT_STRING
> and OPTION_STRING that does the strdup for you, something along the
> lines of ...
> 
> diff --git a/parse-options.c b/parse-options.c
> index 312a85dbde..6aab6b0b05 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -138,6 +138,21 @@ static int get_value(struct parse_opt_ctx_t *p,
>  			return get_arg(p, opt, flags, (const char **)opt->value);
>  		return 0;
>  
> +	case OPTION_STRDUP:
> +		err = 0;
> +		free(opt->value);

Probably

		free(*(char **)opt->value);

instead.

> +		if (unset)
> +			*(const char **)opt->value = NULL;
> +		else if (opt->flags & PARSE_OPT_OPTARG && !p->opt)
> +			*(const char **)opt->value = xstrdup(opt->defval);
> +		else {
> +			const char *v;
> +			err = get_arg(p, opt, flags, &v);
> +			if (!err)
> +				*(const char **)opt->value = xstrdup(v);
> +		}
> +		return err;
> +
>  	case OPTION_FILENAME:
>  		err = 0;
>  		if (unset)
> 
> ... may make it even more pleasant to use?

With s/even// I would agree.

I will keep this patch in mind and will try to come back to it, once the
rebase--helper patches are well on target for `master`.

Ciao,
Dscho
