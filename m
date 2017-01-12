Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C817820756
	for <e@80x24.org>; Thu, 12 Jan 2017 09:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751312AbdALJ4Y (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 04:56:24 -0500
Received: from mout.gmx.net ([212.227.17.20]:49825 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751213AbdALJ4X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 04:56:23 -0500
Received: from virtualbox ([213.133.108.164]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0McUnM-1c9wju09Gy-00Hgr2; Thu, 12
 Jan 2017 10:56:14 +0100
Date:   Thu, 12 Jan 2017 10:56:12 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jacob Keller <jacob.e.keller@intel.com>
cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 2/5] name-rev: extend --refs to accept multiple
 patterns
In-Reply-To: <20170112001721.2534-3-jacob.e.keller@intel.com>
Message-ID: <alpine.DEB.2.20.1701121049530.3469@virtualbox>
References: <20170112001721.2534-1-jacob.e.keller@intel.com> <20170112001721.2534-3-jacob.e.keller@intel.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:1rPriN8tt9Ijwo6Jrj6jo9JsHxJSWti+k9HkEC4QMi84vwfWmfw
 PIGYDE+jymdBZYBiD6Zzp/cXYP8eWaBshs/gvLHe3CeEDj0ck70kf+VYP3GtpS0ijll448N
 U+ZF6EdMWBkvOi6gDi+8PSGYqyq1+ZCn6kv3m/8KYh+0wxUjMYo97GiG5k/RcnLu+C91SIj
 yKGppnKnKCf9tDQJaRWPw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XAS0tIx6x6s=:BLqdWXxNchWxTV/WAE9iif
 TEFCeglusarDWjEKXEA/z062hrRIrlNDI4LZZBRuJGXy4/GCuWH6CsJtZepGBSuyLy+95/bJY
 NHbrsmcimE+scLw76J17/2GMVuJfGxkw/FgaNOKY7RyLM7H6WkeqHAvH/P39nJOaHc4MbGo/f
 gQQp7tU76GgEe76x0+ALa8+H0p41yP9UDjmffiJ8PxBjsnAmRLMoRxnsPipAqJUWamabCoPzb
 zHUb23xamZNSDYcawpstFIvx4O/+kBmX2dnHzbQTP04Lg3MRndlRuHB/NGB8aeykRwBOgorVh
 AEqhRg8D4ftb9wviTMdbrmAy0yI6s6l1pV/4phkyMaWq+8Tig247r4zjUF2o+C8PQGRt2Ry/d
 rAIr9CJEwgHtDf0F9HOUijqgsu3scri9MY4eORDTueQxi0O4TazzluTa6gFZTdX9KYSgWdUaC
 Zv/a1/ACTjsTAVddR5jvc7VHek/XdVOXRSPMbuiCUYCOC2X5E8R1bVB6ugTumawcOtyzDo3EI
 W35QROp/mTEpwJGKuZCPaP23tIiTUOS8dA6fCw8i/nWD/kVy8sP1y2BlLBU/vwEHCE84F/kfI
 RX+BzwA1buXqy1NZfDLLGZVVvSM0TZI/WzknyySQ0F17j+8P1MT9OPAS8O3STZIpXuQi+WaP1
 G+tTYWt+IwJJAIK7D+Gw8MVRWG8k9V1OKG6+r2mXAzFZd4h5OovJz/s9SHt96QpkWDHtGHCeh
 dYAzKzooFu2ojqLa25xugjQkYW7+30XXmRsshjmdmadpqFQnqY/5bIKmK1tX5IB6sbMwb5sPc
 qCWwCxLoT34td1O+SDSCwiPGZNiVQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jake,

On Wed, 11 Jan 2017, Jacob Keller wrote:

> diff --git a/t/t6007-rev-list-cherry-pick-file.sh b/t/t6007-rev-list-cherry-pick-file.sh
> index 1408b608eb03..d072ec43b016 100755
> --- a/t/t6007-rev-list-cherry-pick-file.sh
> +++ b/t/t6007-rev-list-cherry-pick-file.sh
> @@ -99,6 +99,36 @@ test_expect_success '--cherry-pick bar does not come up empty (II)' '
>  	test_cmp actual.named expect
>  '
>  
> +test_expect_success 'name-rev multiple --refs combine inclusive' '
> +	git rev-list --left-right --cherry-pick F...E -- bar > actual &&

Our current coding style seems to skip the space between `>` and `actual`
(this applies to all redirections added in this patch).

> +	git name-rev --stdin --name-only --refs="*tags/F" --refs="*tags/E" \
> +		< actual > actual.named &&
> +	test_cmp actual.named expect
> +'
> +
> +cat >expect <<EOF
> +<tags/F
> +$(git rev-list --left-right --right-only --cherry-pick F...E -- bar)
> +EOF

In the current revision of t6007, we seem to list the expected output
explicitly, i.e. *not* generating it dynamically.

If you *do* insist to generate the `expect` file dynamically, a better way
would be to include that generation in the `test_expect_success` code so
that errors in the call can be caught, too:

test_expect_success 'name-rev --refs excludes non-matched patterns' '
	echo "<tags/F" >expect &&
	git rev-list --left-right --right-only --cherry-pick F...E -- \
		bar >>expect &&
	[...]

However, if I was asked for my preference, I would suggest to specify the
`expect` contents explicitly, to document the expectation as of time of
writing. The reason: I debugged my share of test breakages and these
dynamically-generated `expect` files are the worst. When things break, you
have to dig *real* deep to figure out what is going wrong, as sometimes
the *generation of the `expect` file* regresses.

Ciao,
Dscho
