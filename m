Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 343C41F404
	for <e@80x24.org>; Mon, 26 Mar 2018 19:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbeCZTVj (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 15:21:39 -0400
Received: from mout.gmx.net ([212.227.17.22]:44863 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751157AbeCZTVh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 15:21:37 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MHbpA-1ezRDd3W6m-003KZb; Mon, 26
 Mar 2018 21:21:33 +0200
Date:   Mon, 26 Mar 2018 21:21:33 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Joel Teichroeb <joel@teichroeb.net>
cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/6] stash: Add tests for passing in too many refs
In-Reply-To: <20180326011426.19159-2-joel@teichroeb.net>
Message-ID: <nycvar.QRO.7.76.6.1803262110000.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180326011426.19159-1-joel@teichroeb.net> <20180326011426.19159-2-joel@teichroeb.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:1VrxAqxdAqR5RHFXS4lis/edowkaUJdGo4PfsH7lnAkGFIb5kcV
 7UKyaeSi9NIQleFjaetmmegaotxGLVEiRJLFk6N3JC2Rm7FEE0r4jgRLW1NuZ1W8fN5iVZC
 dPBDGSDj1Rvaxa2vbRrhXNy0X5GMWK1V89W2dI3zN7qrTnzYTUsEpMuFcOJu9r7vgZ9pS4J
 hV19JzYB/xYa6LENNpcSA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:D7ytwdQ6fpU=:E5iTwVDL/Uk0MIN7jGsLn8
 iqkEq61ZrLIK4f0Gdzfxy29birrJjE075wLZ95YVZgXAms8bm60EnfSzggtsRD9dqrP1t5LEs
 jw/GRd4K6VYIBZ1zWGdgb53YR4NvsFxH9zId4VCeM6bVqPBBv/Y0tDSDdZ+zkj06YsulRPd2T
 yI3hEsyJ1S7OijU8iCDVYUFXufufYeSvqKD9SStcUdPi+PkOpwJyW4U+dMFISrImI49Kjc38G
 kYjy+uVj9Im0fvJNpy+t/Xw7wdwBYaEwyAOymcrx8OEUcuaGTph1XtZberdwYyUS+HBvDRxNW
 UCfyfnnEz5+KP5bwl606sUFKWsJczDBSkmINsUgAIJQ8YKaVcK7rqa7iDfKnDm/eSTZOoH/TS
 wlTh+SvrDMSZCjZhyKnSaGkloS79vj9A6ET9RFp/E+N9AOTzp4Ef64m5wFrX/X5psMYVdnBWF
 Knxzmo3bw/FSRh1FYtjZEuDDXfvpMMGT2BGVOmV6d8IVBLgv/BA8Jv9p8STACpu3HEud10ZjF
 DDsDVgXtjGBpTNi2qz2fLmKHeVx7+Hp36f3o4NNqXwjkxEUMZEMexpCPrbX1rrgat77KAmvaZ
 sZo55clVPKFkZ9BX0nqRR69zVtEBWR4KMxYaI6VOfyw7836hB0VO+fKrmIlIZt2vXp/zzGwSb
 sgmIAYShfH/pPLla3jO5QsLoe8juq2VD/9Ir0oelnyzBAvVHR7CCXZyIACOVJF4b2oVKkVXkM
 lsrPcHEUQz7CvbMJgvMHCYRtE5u/1oJsXOfR9dQdmxue4zhVQ7QyXk4EGCghbET1SPOwZo6ZN
 ApeKbtW1pJIRJ5GGwIWeisged2APAMSGzyuAXAD7FhN6zI2fE5EjCP/HW7F4Y9qrYAvlxgN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Joel,

On Sun, 25 Mar 2018, Joel Teichroeb wrote:

> Signed-off-by: Joel Teichroeb <joel@teichroeb.net>

I could imagine that the commit message would benefit from this body:

	In preparation for converting the stash command incrementally to
	a builtin command, this patch improves test coverage of the option
	parsing.

> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index aefde7b172..7146e27bb5 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -45,6 +45,12 @@ test_expect_success 'applying bogus stash does nothing' '
>  	test_cmp expect file
>  '
>  
> +test_expect_success 'applying with too many agruments does nothing' '
> +	test_must_fail git stash apply stash@{0} bar &&
> +	echo 1 >expect &&
> +	test_cmp expect file
> +'

I suppose you encountered a problem where `stash apply a b` would modify
the file?

And if you really want to verify that the command does nothing, I guess
you will have to use

	test-chmtime =123456789 file &&
	test_must_fail git stash apply stash@{0} bar &&
	test 123456789 = $(test-chmtime -v +0 file | sed 's/[^0-9].*$//')

> @@ -97,6 +103,10 @@ test_expect_success 'stash drop complains of extra options' '
>  	test_must_fail git stash drop --foo
>  '
>  
> +test_expect_success 'stash drop complains with too many refs' '
> +	test_must_fail git stash drop stash@{1} stash@{2}

I wonder whether you might want to verify that the error message is
printed, e.g. via

	test_must_fail git stash drop stash@{1} stash@{2} 2>err &&
	test_i18ngrep "Too many" err

Also, since the added tests look very similar, it might make sense to use
a loop (with fixed revision arguments).

Ciao,
Dscho
