Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1061E202F3
	for <e@80x24.org>; Wed, 20 Jul 2016 15:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754573AbcGTPJH (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 11:09:07 -0400
Received: from mout.gmx.net ([212.227.17.22]:61302 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753938AbcGTPIz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 11:08:55 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MYKGj-1buUlx1oB7-00V4Xx; Wed, 20 Jul 2016 17:08:36
 +0200
Date:	Wed, 20 Jul 2016 17:08:10 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeff Hostetler <jeffhost@microsoft.com>
cc:	git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH v1 1/6] Allow --porcelain[=<n>] in status and commit
 commands
In-Reply-To: <1468966258-11191-2-git-send-email-jeffhost@microsoft.com>
Message-ID: <alpine.DEB.2.20.1607201600050.14111@virtualbox>
References: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com> <1468966258-11191-2-git-send-email-jeffhost@microsoft.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:zApYnYoQSUGOJ/4iL/sCfDaZxI9l17Qxnu7xIHQ3CXxXmrFkNB+
 93FFwD4Kw4KvJ9ryjhOmon5KCjNEItGMSc7w8exft4Qyth7hWGs8Tya4vxQoIXPvlqj/Bae
 yJWr70wQV2ItKrJkYG1QjsXbab4JRNCw79FkXtgCChc5jOhqjxJ2yV+1+yImOZOubr/7nIi
 GHYrEfLDLswW12SzZE+Og==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:JNtlweW8d70=:OnmvfOMcksN9fAsBvgaMoH
 5WeIa6OXO1YA/daH2KG5f7U3CcI42MHymFUKMNeyo5qPgttuNbVTYQYMR9Xm2J7cwjim/ktjw
 Xv91/9oVaZUwsdDJ6iX14TBSvLDpvPo2a38vCxzo0XrMBQoo3kHKS+jaQJgyeQN5AG/1B+A4M
 dxE71J4I/uVXWKNzk7MDbSQO5JULEnisSGCBJCzRWiB0y0qv/2mKEKXjZILa8igFbtST9XwzG
 KG7BvxRiOgHC03McnzopQrkA8zUanKhPNu1H4jNPMoU16vFrEdqAqU6h2oopaH8dKoi4HXOHO
 5wVoDQjU626XfOhxnVh9GZBRnqe+8sXFc8f8AhiMwC2ltklPQZXJvhA3wP11GMaRfeAm1axDx
 GmFvcI+owVaC32FbqRD4hQXyiEw7gNh7a/cuK0AZzOsE+i3vszDK5JVtnRnk6uwOB992zXU7m
 jnutRO90n9Rlaq5djdcskof7SIfBD3Zrxxya34TZoEJ2aJTLER0CacKSdfmINKd8Iar4G7t7C
 BdZXdKLAGPgWdP/IC5Btx2m3cYrdQJXS3oW74rP9KlXgPggOlwN7digUhtt7Xq08dXf+TyOof
 6SbiR7pboRPjPtL670/TG0aTInx8dn4K52AT/Cg0OkPiPo42XpAvn8kDnJWz+zz0MhKilBgEW
 BY5f0gKYNavcUELGGEIHW6FT4Afr0o893T0irnnGr6ddcLOfLCeVX80SopuBTvbRYSUd/CTz7
 R0MLj3wsnpc/BtfrDga0ckOqiTbz9cppXF0gqYwY+zE7PTBln4w7zcPE2NDacHTpRtoQVzTAl
 laCGqdJ
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Jeff,

On Tue, 19 Jul 2016, Jeff Hostetler wrote:

> Update the --porcelain argument to take an optional
> version number.  This will allow us to define new
> porcelain formats in the future.
> 
> This default to 1 and represents the existing porcelain
> format.
> 
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>

Very nice introductory patch.

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 1f6dbcd..892d7f7 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -142,14 +142,24 @@ static int show_ignored_in_status, have_option_m;
>  static const char *only_include_assumed;
>  static struct strbuf message = STRBUF_INIT;
>  
> -static enum status_format {
> -	STATUS_FORMAT_NONE = 0,
> -	STATUS_FORMAT_LONG,
> -	STATUS_FORMAT_SHORT,
> -	STATUS_FORMAT_PORCELAIN,
> +static enum wt_status_format status_format = STATUS_FORMAT_UNSPECIFIED;
>  
> -	STATUS_FORMAT_UNSPECIFIED
> -} status_format = STATUS_FORMAT_UNSPECIFIED;
> +static int opt_parse_porcelain(const struct option *opt, const char *arg, int unset)
> +{
> +	enum wt_status_format *value = (enum wt_status_format *)opt->value;
> +	if (unset) {
> +		*value = STATUS_FORMAT_UNSPECIFIED;

In Git's source code, we skip the curly braces for one-liners.

> +	} else if (arg) {
> +		int n = strtol(arg, NULL, 10);
> +		if (n == 1)
> +			*value = STATUS_FORMAT_PORCELAIN;
> +		else
> +			die("unsupported porcelain version");
> +	} else {
> +		*value = STATUS_FORMAT_PORCELAIN;

This could be folded into the previous conditional:

	}
	else {
		int n = arg ? strtol(arg, NULL, 10) : 1;
		...

Having said this, ...

> @@ -1336,9 +1347,9 @@ int cmd_status(int argc, const char **argv, const char *prefix)
>  			    N_("show status concisely"), STATUS_FORMAT_SHORT),
>  		OPT_BOOL('b', "branch", &s.show_branch,
>  			 N_("show branch information")),
> -		OPT_SET_INT(0, "porcelain", &status_format,
> -			    N_("machine-readable output"),
> -			    STATUS_FORMAT_PORCELAIN),
> +		{ OPTION_CALLBACK, 0, "porcelain", &status_format,
> +		  N_("version"), N_("machine-readable output"),
> +		  PARSE_OPT_OPTARG, opt_parse_porcelain },

How about using a COUNTUP here instead? We could then set the status
format afterwards, like this:

	if (porcelain == 0)
		status_format = STATUS_FORMAT_UNSPECIFIED;
	else {
		status_format = STATUS_FORMAT_PORCELAIN;
		if (porcelain > 1)
			warning("No porcelain v%d; falling back to v1",
				porcelain);
	}

The rest of the patch looks good to me!

Ciao,
Johannes
