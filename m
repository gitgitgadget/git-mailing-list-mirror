Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B63D1F454
	for <e@80x24.org>; Mon, 11 Nov 2019 08:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfKKIto (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 03:49:44 -0500
Received: from mout.gmx.net ([212.227.17.21]:37771 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbfKKIto (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 03:49:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573462180;
        bh=xjP6I0pmaTwGysutNsoE1piCRcxTzDG+T9hD2bewtNM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=aRkKa1QrQnKjSLOrlj9cUsvjvz8uCDJf5BTMuj4JSjovvpvRtZ8hnkztftO4WkrwN
         dkFVH8IK86WMKJvR0F6k+AQxLcmyX9Lsz81Ol4u4NiJx9syRdEkc+r5MofaGsKEenM
         YAKRCttXmFqB+KrisTxxzbECOHjVFwq6YVSPKDGY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbivG-1huUSQ0MTm-00dI1u; Mon, 11
 Nov 2019 09:49:40 +0100
Date:   Mon, 11 Nov 2019 09:49:24 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Naveen Nathan <naveen@lastninja.net>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: improve readability of --rebase-merges in
 git-rebase
In-Reply-To: <20191110095942.GB6071@a.local>
Message-ID: <nycvar.QRO.7.76.6.1911110948270.46@tvgsbejvaqbjf.bet>
References: <20191110095942.GB6071@a.local>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:EnnfhF98U5/5jMkZufA92+GW661tBoV9ENXxh/UUyw2iihADfxM
 ixAQgT+5692k7cwzau00b0cbizWnMhqk5hKc6pY3l7wXHzgVE67+NUWmO4l5l6qGZForGZg
 mvfwZ0ZpTDhSWJd44N1D/NKpDxs4m0fMFFcUMMLuaC3qMbUbJw2dWFB5YV0RGc5NeqrL9QU
 +hXkKtgDF4n/7OAVdTOMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:onD4hchlByE=:4uvRsOtoeKndgpz3kl5oZM
 zpgJkMwFB0ZrQIme+ANFvfme0KxzXc1+0QKSUiX1f0oWfqtBQxJshRNhc7iv8PbtCPAI/DfcQ
 xpMsx93yx+EaaCdKq4T5bGmhfYbmrBEOYCO5LAJiBJqZbil/eBmJNAmwXwTYfZjdJND3QStMe
 UjaAISxOh4is9rU3UFJJmv2O68Z/dhws7ySfRdNNOunKlqlNeQ/S9AT1792Lj5C4JPYlnayZt
 EBO0lZvHJKvo4c6j2P2xIBZXgdFvuUqg69NY2x8mIKX1FOpMII8r4+dATrP5qgJ0exD+6PaE+
 t1ZJdvKQ11Hq5iSmpMfSrnHJQNsUET1nqkgklqJinMXIRaiKIq8sU+Y/IPN9Z1Ftx9ZSPDz+f
 mg+uc4MLBuian1KKq82OGvQUwSNWitwKeoHgzf2HXNQCidkJ+fHaPrxBs1jXgBdUtNA2BDUSc
 SwquAaLr9MzHVpX7gQVErWeIMmCuMhS6VMY666DaS5ItcdX2vepcpz1SbwJGwDtVzmMEr1+RJ
 TIt8nbBuZD7XxzH9xg+WfsW7Sc+TAuzZwQBv91X0DuS/XsqZ9+i50Z99KS3k/zNuov6/TPawn
 JhYna7XzE2XrRMVMYOqRBetjxWeuO8s0XVMzWRbCCPsCLkRZ4rHqrzrbFDUfFZnmXcVuBDLeI
 xejoSOkSipYB6VwREhF/YbyjjgOu5N5en2byxrIvC9DcYfyFrVy0GLQ3iSyHLVT54rwF++g8W
 kEPHz/ko3Q0ZgLluFMdN2rmvMv5mGRqDLIaHLg8NeXA7tTAZQyAGtERokm3+bDpn7xHSADT8n
 ZQvwwtk2wEXRs3ioGncZt4S52Icarqyoq57g6OSODZNV/LEgiFhwogqWTrcJJCZeaQL56Whvl
 yk7T1mIyMk5W/5PL7L9sxy47L+zGXDfMJS/NcO55LdcgMYFxyae37jL7zkFe0UJ9BTJTZXENt
 J2FR1BNwWZmSwgDyihU1LacJPxnfteQmzRPiCARjJeuuIagMTJWKhzArDvx6DoY5olCYw9WLq
 E8GDgvzaL+Tdmj0+676F2m9GEZj8rHqxU9UmTuSgZBlFW5kAJSkQABgbqUNzKTaPSq9tXQgFz
 erUx4tevwk1joczr8IBwZHo01CElz/xiEYX5gOx/9D9hbbkW5N6Kj4bZVCUWDg+gES46nQ+qH
 2kw4oUGxtPuuBQKwr5U8Gx5nyJtWl201lWlC0bkF6P34liEgQwq3mCll3wJEm+ASgZWduqlIS
 qlnO44vxBIGlRjb2mmd/kIWkL8s2WUhPIJN1uMPkep7n+PkJ1i/S9mZjVJCw=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Naveen,

On Sun, 10 Nov 2019, Naveen Nathan wrote:

> When --rebase-merges was introduced in 427c3bd28a the sentence
> describing the difference between --rebase-merges and --preserve-merges
> is a little unclear and difficult to parse. This patch improves readabil=
ity
> while retaining original meaning.
>
> Signed-off-by: Naveen Nathan <naveen@lastninja.net>
> ---
>  Documentation/git-rebase.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 639a4179d1..6a826b47bd 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -442,9 +442,9 @@ i.e. commits that would be excluded by linkgit:git-l=
og[1]'s
>  the `rebase-cousins` mode is turned on, such commits are instead rebase=
d
>  onto `<upstream>` (or `<onto>`, if specified).
>  +
> -The `--rebase-merges` mode is similar in spirit to the deprecated
> -`--preserve-merges`, but in contrast to that option works well in inter=
active
> -rebases: commits can be reordered, inserted and dropped at will.
> +The `--rebase-merges` mode is similar in spirit to `--preserve-merges`
> +(deprecated) but actually works with interactive rebases, where commits
> +can be reordered, inserted and dropped at will.

I like it!

ACK,
Dscho

>  +
>  It is currently only possible to recreate the merge commits using the
>  `recursive` merge strategy; Different merge strategies can be used only=
 via
> --
> 2.21.0
>
>
>
