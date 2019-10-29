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
	by dcvr.yhbt.net (Postfix) with ESMTP id 713C41F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 13:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388118AbfJ2NGz (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 09:06:55 -0400
Received: from mout.gmx.net ([212.227.17.21]:49181 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728735AbfJ2NGz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 09:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572354413;
        bh=yMAcyQVh7bsGFeEeupQKYfKRg+/mZz8SXX2KhGwYdKs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TaHrgwtvBedmVsP8BFKYK7gp8DEI03Za83rSCcW0+KLdkdPJcUdRGK9VhtCj+zICk
         AA+lCtF8deSMsoWzvhwlt2ojK8rsuT5mdqtl11BAuSAmqIb134t6eKZs6Fu0Jv5Bb/
         5FV0goHx9687ORXBlFjtWAdIQAJGV9MlCGOt0U1I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDQeU-1iIGCJ0Mic-00AXDy; Tue, 29
 Oct 2019 14:06:53 +0100
Date:   Tue, 29 Oct 2019 14:06:38 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Denton Liu <liu.denton@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] git-diff.txt: document return code of `--no-index`
In-Reply-To: <3f6d132663cacde01df68bfe88c6ef108cf6cf74.1572337045.git.liu.denton@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910291405090.46@tvgsbejvaqbjf.bet>
References: <3f6d132663cacde01df68bfe88c6ef108cf6cf74.1572337045.git.liu.denton@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:lM8Ba6FxErXJa0IPvNI9mz8zXCCMWA1QX/S3F+decXJOJblazDr
 KRZHui2EUv6p6esBWWGjis396PlidR+0c9E0gI5/UDSpZVTiT7TEpzhvNownPGp+SAYI3EO
 shZqBQ7NdvSvKI30U+QfmCHZVYJK3AmRZlZHdzsc6DYau2zbMsv3Cr/t9hwyhyPbYgBoFZZ
 XiluRWM1SL+cLqZvSGWIQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xCKPCGgtReE=:35YKxGglE5uEZzpPNmFBI9
 liL0maRi+oQXbPampYeimI0Qg23FcbtQkXvStmsQSpj5DgPEc7uFTKpwiRwNwAYWjjbhrnsvt
 Zk4g8ZDbTmgfXA+M6LgK9FwK6m9vU5k4LorgKD+urkFsonLnaxel2S/2HTOAnLwrxlUGVmWm4
 Xz7MXiJIqJ8kYvNtGcih0UCiaC+oBhwiOTRwIQgtzl3QfzsYYsArQxALlwdCi5EAt9vbde2QG
 RsCkyFSfunswaZ4hnqzOU94oKGJBtM38NPRz+LnLipkGQmyRHp4enuMHDp0+HDr0EkjB9umkA
 22w9s0fhFgKOCTNBi2rc8M4M/H+11YEPBlno0EXO/QXDjFdXmquB3+SBo7LjwwWS32WR1mko7
 MF+XnY5GuVP4nxwutan0yImtaQLWMeC/UbL8vHsAkLIUl+Jfgd8t6JGcdCdvNqHBaAAUh2XvW
 F/S+rxPI6+91ZGEbz73Ngd472sqCkfG/rLNt5NYKXjvgOJeUrvXlxnnBc+RMyXDJP3QIfQ6GJ
 58+LNiGIaBQO537cxsDPJJ28NFlsU0nVtE+Izrqt1nXQeus45hzoCu6WlBWfNOiaNT0PHIYNC
 34NWKzDZola3yUcew2Ka/AVllxSwrCxFwm5Do1gsnjDlQ6KLuIn+i6ol3PLH3roP9aeltHB3B
 rVcqIVVn0dqhgF3YYUaVvKLpk3PaH38CKKO9fBpecpS0UXWwhQAsNvHYcg2aqrpxygTqT5DCC
 sfwZb8DnSKf4T9Xv89uWKMg+kSaoLFvNyLeG1MtLETv1H5z2UlzCT9a4VKa7VFV1EziinqzEc
 lStM53ckVBrccY3clEZLvx8RJ/8V51snkC0UlsA4pWi/WtGkQgynVbItBO+wzdcKOSmN4pJSb
 RASfHIuUnJBIzP0Zm+3AzcmCjxftOus6Dv5pUrrsx9J+Y1q5GTvEJ5HiCKcm5Gc5P+pQarwTB
 FOPPNEbXzzVh69yXhCUf+Ig7aYINtZSyFefXocdlGwOnBuOOrz/Gnn6i93vGxE7HALICl1fed
 oRq5szujmPOtqZ7C8c7aw/mvUErBY2MLHZUxO5kima9SbFaR0woKxIU+Iav3ZexbjIlmhnoLH
 KHQ9yL36atHzy5Hqrfqcj09DgdpCTpxRmO8G0atPg2iOhUui1A20DMgXqN3R/nGQigl+oD85a
 xrgbFNgAty3l/NPqpFj2bhZ/vFIGYiaTFkKyToc2Um4eLlkMIdV96FrVRJeySLr3vb9gZlfz0
 a7cqN0CgoQYmonuLO0R7Kn/WGvZzGdcgqoDC/OttA/jsCpEuUk7/Pa1xpZdE=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton,

On Tue, 29 Oct 2019, Denton Liu wrote:

> According to the end of diff_no_index(),
>
> 	/*
> 	 * The return code for --no-index imitates diff(1):
> 	 * 0 =3D no changes, 1 =3D changes, else error
> 	 */
> 	return diff_result_code(&revs->diffopt, 0);
>
> However, this is not properly documented in git-diff.txt.
>
> Shamelessly steal from the `--exit-code` text and give it to the
> `--no-index` documentation to explain that the return code is similar to
> diff(1).

Speaking of `--exit-code`...

> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  Documentation/git-diff.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
> index 72179d993c..1e363bd200 100644
> --- a/Documentation/git-diff.txt
> +++ b/Documentation/git-diff.txt
> @@ -36,7 +36,10 @@ two blob objects, or changes between two files on dis=
k.
>  	running the command in a working tree controlled by Git and
>  	at least one of the paths points outside the working tree,
>  	or when running the command outside a working tree
> -	controlled by Git.
> +	controlled by Git. With `--no-index`,
> +	the program exits with codes similar to diff(1). That is, it
> +	exits with 1 if there were differences and 0 means no
> +	differences.

... a shorter alternative would be to state: This implies `--exit-code`.

Ciao,
Dscho

>
>  'git diff' [<options>] --cached [<commit>] [--] [<path>...]::
>
> --
> 2.24.0.rc0.197.g0926ab8072
>
>
