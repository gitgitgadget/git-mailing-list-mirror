Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32DCA1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 14:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbeGPPLe (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 11:11:34 -0400
Received: from mout.gmx.net ([212.227.17.22]:53125 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727150AbeGPPLd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 11:11:33 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M2ojS-1fw38t0AJ4-00scJ0; Mon, 16
 Jul 2018 16:43:33 +0200
Date:   Mon, 16 Jul 2018 16:43:30 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 11/25] t7400: fix broken "submodule add/reconfigure
 --force" test
In-Reply-To: <20180702002405.3042-12-sunshine@sunshineco.com>
Message-ID: <nycvar.QRO.7.76.6.1807161641140.71@tvgsbejvaqbjf.bet>
References: <20180702002405.3042-1-sunshine@sunshineco.com> <20180702002405.3042-12-sunshine@sunshineco.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:P3ozZCZazXC7hZET+pWc/uOfH/woc3YIuy5IIGYBRhHRdUOnVtS
 +nOU0Mwp77AifWLI91MRdawR0Tpg/UiEEaqSJ2SQ4t669DE8fQ559DoesZw2Ej2s4BZvDhS
 n6H1qP+dw0MNcI6/vAWW0Zfw2OqDcFqctBsMJh9B0cxj1LmeN5Tr2u3z1UuXGYnSZoKX8ys
 rxOZBEd96V2rgfIuFe1vA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:P7M6z+NlVL8=:fiWos8M4+VM8Tk3HAEd3Ns
 Jahf7rnsGRxU13SL2MYwC8dTX0caPknUOMbiouHGaWKMFzAt+M7Tq4pPz1yWWhfhhXaI1VAAk
 R/pEhmrfsyBmTBtv5NFMVNsZk03/0QyoZ/C33QmV9ObFl054pkb7PIdQyh9Ysocie4+fp+PVL
 CLLIOUTh56gWeAo1iO+QdHOa5uh8L6Fz4JO4eKe1cCjPSsSYuRvu/P5VkzoaZbOMb2+Rq8099
 z6DxW33vznt/OUS3l5gAeWh4m+OCTN1rQ1T2DRJ4N0aRLchD2sgQ37dUZotBEMlJCWDfkCpRx
 RFsZJt+XlNGfkLHUjcUdZQuU89ojEqkvtLpZXipiIlvlTYDO+7YHWJB+yrpleczBQfAMuntUh
 35971Ho2z7EiSU7oAIkttg8MpzLdClTedGZv8eG/ludCXUPdEComPMSjEmpqd/SBqERc0usPf
 3kOWVZVKiCr8rCaOzgBxGekbFuX68GILRcvND+tnid3Kgb2+o9+XviQl/2pKlS0xGdd3xd4jr
 TYONoEivkYIf2ewoNVVPl9UkxD7A3agruAvTr4d7Y0fS9IKZNkrK9Vx22KmhIpbw4e6xm132k
 hLK7Rsyv6iJzYI6SW4G8fyLanz6qbpPd+akmKC9iXUUFT4JCUFiVHuG/hJcM28gne13KQ6sty
 1IW9mQd07l+B1bh58CgXG51F/kXLony5n3UGFykInL2ydr55/2QeNB5bk1bIHO2cCEbn5CNEx
 G/XgKY6V7Ns3nrlOhksI9XiNJzyzteMhORRnd6dxcZzMoZ3bTXM6ggrdKJWd9OVQtsQKLKxmc
 Fm05X7E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Sun, 1 Jul 2018, Eric Sunshine wrote:

> This test has been dysfunctional since it was added by 619acfc78c
> (submodule add: extend force flag to add existing repos, 2016-10-06),
> however, two problems early in the test went unnoticed due to a broken
> &&-chain later in the test.
> 
> First, it tries configuring the submodule with repository "bogus-url",
> however, "git submodule add" insists that the repository be either an
> absolute URL or a relative pathname requiring prefix "./" or "../" (this
> is true even with --force), but "bogus-url" does not meet those
> criteria, thus the command fails.
> 
> Second, it then tries configuring a submodule with a path which is
> .gitignore'd, which is disallowed. This restriction can be overridden
> with --force, but the test neglects to use that option.
> 
> Fix both problems, as well as the broken &&-chain behind which they hid.
> 
> Reviewed-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  t/t7400-submodule-basic.sh | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index 812db137b8..401adaed32 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -171,12 +171,12 @@ test_expect_success 'submodule add to .gitignored path with --force' '
>  test_expect_success 'submodule add to reconfigure existing submodule with --force' '
>  	(
>  		cd addtest-ignore &&
> -		git submodule add --force bogus-url submod &&
> -		git submodule add -b initial "$submodurl" submod-branch &&
> -		test "bogus-url" = "$(git config -f .gitmodules submodule.submod.url)" &&
> -		test "bogus-url" = "$(git config submodule.submod.url)" &&
> +		git submodule add --force /bogus-url submod &&
> +		git submodule add --force -b initial "$submodurl" submod-branch &&
> +		test "/bogus-url" = "$(git config -f .gitmodules submodule.submod.url)" &&
> +		test "/bogus-url" = "$(git config submodule.submod.url)" &&
>  		# Restore the url
> -		git submodule add --force "$submodurl" submod
> +		git submodule add --force "$submodurl" submod &&
>  		test "$submodurl" = "$(git config -f .gitmodules submodule.submod.url)" &&
>  		test "$submodurl" = "$(git config submodule.submod.url)"
>  	)

This breaks on Windows because of the absolute Unix-y path having to be
translated to a Windows path:

	https://git-for-windows.visualstudio.com/git/git%20Team/_build/results?buildId=12365&view=logs

(In this case, it is prefixed with `C:/git-sdk-64-ci` because that is the
pseudo root when running in a Git for Windows SDK that is installed into
that directory.)

I could imagine that using "$(pwd)/bogus-url" (which will generate a
Windows-y absolute path on Windows) would work, though.

Ciao,
Dscho
