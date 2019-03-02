Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ACE220248
	for <e@80x24.org>; Sat,  2 Mar 2019 20:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfCBUZe (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Mar 2019 15:25:34 -0500
Received: from mout.gmx.net ([212.227.17.20]:53791 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbfCBUZe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Mar 2019 15:25:34 -0500
Received: from [192.168.0.171] ([37.201.195.16]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LsTjw-1h6Xxl49eq-011wf3; Sat, 02
 Mar 2019 21:25:26 +0100
Date:   Sat, 2 Mar 2019 21:25:28 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Taylor Blau <me@ttaylorr.com>
cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH] builtin/config.c: don't print a newline with --color
In-Reply-To: <b5ca6391fd0273fb7d6b92bc5ada96df93bc5cf2.1551487219.git.me@ttaylorr.com>
Message-ID: <nycvar.QRO.7.76.6.1903022123160.45@tvgsbejvaqbjf.bet>
References: <b5ca6391fd0273fb7d6b92bc5ada96df93bc5cf2.1551487219.git.me@ttaylorr.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:XFzvn2XX4E0jct99lebyhEQpJUvIrOH/WAhkzgTxfOjAp/BHnsW
 htLHZwISB8F8xw7eAjfIDSyhIIO2I/XGkWGuIqadILvE7fxqaL5YemG2UXZ1ygOmxcn7+MS
 GNLGicFVpkD5sUFqfpystdb9z6s4RQrv2vU5vKzDxGHOQjOaLMI8Zgiq4UDJ3lu9es+OwGF
 xnE9WxL6RGBgzA+FnuUoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sjtwrsyLpNI=:2lNRvLYeVmub9ZsxgLZ78R
 2azXCoK3XlBRgWgssIYrI0OU0eWLYvrXOlL/L9THW2nI36Y4Y2xKHkUoD7dgzFwvuYnAM/NgF
 Xn5pn5T5AYidgZUQVD3jdo8oo9uTeh5lGZZ1rcg+Z2f25Vc/D4dOCicyBj/pNdiLsdh9WuY3M
 AaQ6MZL0LCr7K+gCMsu3ZGoT59F+ZiNrGYxSS/hWouHb2YTLLDPTlsWPCydqZPGj5nDwHfqGM
 yafl1oI1NGMNcG9VMpxwQGU0J6DDMoVp1SJM4kXbUK+d8VewYXO0fNZZ+SAbfauhN305dmc9F
 c0Eq9fqVaiSxWzr35GElA/bY3H71NuylFAOpFjSFdo9yazxxjoNIfD2KcmSw3REBzlV1Fx1vB
 Of6qcFiRMKgrpywwSPK6VhLfazrS2T7lEOJXJ8dcYh9Yos5sAeay6vTi60Qb8wdCskDjYRIWx
 P3HQJ38zw9YvNwigoXnFFsk9ZLva5h6wPoRWRiobc4nOkSjeK3KKQ39f/fRT0fLrMjjlm/6nK
 16fYD9gH5lB91z7vpEp5AWw4Zg1NFf5kKbWPxwAS2Wts20w69H2xue1KAtzrm0DcuHaA1DDJ+
 cD9P+muqb//wSAu8gWavaP07UoHXfL4EGZ8MrEuAzzHL7WSVmAVEj31amSbR5/TLJj63cOueo
 A8yWL/6SS4d/ctJdGWKdVpc9LL5ZowyV8ogejgxkewODIvB5rHmSKwenhSoLWaCEdP0nYhIsD
 iMFFsW2RAsX4z1kSFHrnyo7xgBZgI2/TPU/2cqMh+bD9wlugppU2yUI1TMoAtsuPAhHmN4TU3
 6mXFdIBS4EDiaFEwJV3XBQ/JLNTf7AO0gRuA573mCFBNI8XjAatS5agFsXtCNGP04/BNosMDl
 w7Mv+CWS+ywzqOLO9V8lGXOIiWQFW+yQC1L1e+2Ww3Dny/lM/pCwRuaUC9ZOB4iTxD6Ryaf4x
 v8ca5JU4OWA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

On Fri, 1 Mar 2019, Taylor Blau wrote:

> Invocations of 'git config <name>' print a trailing newline after
> writing the value assigned to the given configuration variable.
> 
> This has an unexpected interaction with 63e2a0f8e9 (builtin/config:
> introduce `color` type specifier, 2018-04-09), which causes a newline to
> be printed after a color's ANSI escape sequence.
> 
> In this case, printing a terminating newline is not desirable. Callers
> may want to print out such a configuration variable in a sub-shell in
> order to color something else, in which case they certainly don't want a
> newline.
> 
> This bug has survived because there was never a test that would have
> caught it. The old test used 'test_decode_color', which checks that its
> input begins with a color, but stops parsing once it has parsed a single
> color successfully. In this case, it was ignoring the trailing '\n'.

Isn't the reason rather that our test compared the output to an expected
text *with a newline*? IOW:

> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index 428177c390..ec1b3a852d 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -907,9 +907,8 @@ test_expect_success 'get --expiry-date' '
>  test_expect_success 'get --type=color' '
>  	rm .git/config &&
>  	git config foo.color "red" &&
> -	git config --get --type=color foo.color >actual.raw &&
> -	test_decode_color <actual.raw >actual &&
> -	echo "<RED>" >expect &&

This should do the right thing if you write

	printf "<RED>" >expect

instead?

Ciao,
Dscho

> +	printf "\\033[31m" >expect &&
> +	git config --get --type=color foo.color >actual &&
>  	test_cmp expect actual
>  '
>  
> -- 
> 2.20.1
> 
