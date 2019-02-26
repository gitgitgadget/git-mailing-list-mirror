Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC2F120248
	for <e@80x24.org>; Tue, 26 Feb 2019 12:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfBZMkr (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 07:40:47 -0500
Received: from mout.gmx.net ([212.227.17.22]:60637 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbfBZMkq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 07:40:46 -0500
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LeSOH-1hLX8V2iL7-00qEwS; Tue, 26
 Feb 2019 13:40:38 +0100
Date:   Tue, 26 Feb 2019 13:40:22 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v13 00/27] Convert "git stash" to C builtin
In-Reply-To: <20190225231631.30507-1-t.gummerer@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1902261330560.41@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet> <20190225231631.30507-1-t.gummerer@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:E/kqskOp/YFEAY1w0gvcsE5pVLeqUmocu7sE52qjUqOdfD4/Jq6
 hVfSe8Qq1wBHaOtGDox6DLj2w8V9qBoi1d1OSirLNXluFI+FTaEy4LFuxuWhwQZP6VO9xdP
 XxsBmtC3OCoHuGh5JiKGJyu1hVJpPdxsX2yMFDOFoLZY3Xiygm7vTTOXqtH2EhQt6ENct3v
 b7mrIqHhsWYQID/i7x35A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cKouocac3eE=:A+tsTTHPcjlTyLsFhWkFyp
 y9ttiMQ/ifeYsOAWYzNNj8oG7jQlbP4p+mdc5ond0p6RuYUdgJ+r7qHVn6ls1L+znz/k3vq/m
 we96LSlq87ZV31GF5ang5IWmFh5P/tqskBT0LJXpUMCA/RA5ljsT7zw1Zccr3LHV10CRcRMbZ
 pPjCO6WKOt2sr5OjzA8mtYRT0ysgd9YgbUnhFGw7IxxgmwuAoVB2+7BZgn9VltnI7OVexzt9Y
 SYBW8Am78lrCquj/mft4g5gKVDx85Vy5G3J2oCSGcqhVdAm+kecuFsy82f3Ard98UVQyvT1aG
 RnslGXyh7Cf7UnZRoP+T/fgeuKlHhyG4mjY0+94NrAaGRczU3NEtAMuZeXjB7fL3K96yptvFg
 CeiE4EySNFd5QRdclBr0vdi86OmhcyDPLk/zplisT+H4T9H8T3vApc5/eBn0PyqKBCKAfO8XX
 RQ0BsOO/3+lf2iUzSys0CNpOM+VEIWq5qyfWqBBVMvlZagNxtoMQL7GdToxKQkDUnJiS9anma
 EJCJPNovBpIpym98CuEaZGSogneyRMCZwY8M32r9z2crDRohztSS4i20efnYEFJPsuYfo6NGQ
 V+4UwEYp93EN85uuv43FMHF1SndhRuTYYYrZoDdNMQrnFr1AnD72AppGqObefBD4Ef50e/7Cs
 82rQ0U2vaNUTxy+5TLskZ8poTgutT8tWaYQjdd/cW1V53HoFtxt++0KkpbpR44a3I6NVjjT3z
 2D7bT5HaMRw5VJbFn8Olqd23wWy/bnqMsv2Cedtt/mMnLW+y8x11Y0wSLiY9oB55WV6l0SjMc
 KRDdahxoeTzzHfUQ3Ciwl9g0pb4KPlcluU/9bC+iYRvk/gDuZsv+Nab1r3cti4Ejq8SN6kgkE
 aYzAZjYnOFGzDUd4oorvcPtygHrrPz9vs2O4PenX+gzIEVdxacRwIwaDAdavJjXiAl7Ptrr67
 OS+F0ATArRA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Mon, 25 Feb 2019, Thomas Gummerer wrote:

> As I was advocating for this series to go into 'next' without a large
> refactor of this series, I'll put my money were my mouth is and try to
> make the cleanups and fixes required, though without trying to avoid
> further external process calls, or changing the series around too much.

Thank you.

> range-diff below:
> 
> [...]
>  9:  f6bbd78127 ! 10:  45670448e8 stash: convert apply to builtin
>     @@ -17,7 +17,7 @@
>      
>          Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
>          Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
>     -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
>     +    Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
>      
>       diff --git a/.gitignore b/.gitignore
>       --- a/.gitignore
>     @@ -96,7 +96,6 @@
>      + * i_tree is set to the index tree
>      + * u_tree is set to the untracked files tree
>      + */
>     -+
>      +struct stash_info {
>      +	struct object_id w_commit;
>      +	struct object_id b_commit;
>     @@ -357,7 +356,7 @@
>      +	if (refresh_cache(REFRESH_QUIET))
>      +		return -1;
>      +
>     -+	if (write_cache_as_tree(&c_tree, 0, NULL) || reset_tree(&c_tree, 0, 0))
>     ++	if (write_cache_as_tree(&c_tree, 0, NULL))

Thank you for picking this up.

>      +		return error(_("cannot apply a stash in the middle of a merge"));
>      +
>      +	if (index) {
>
> [...]
> 22:  51809c70ca ! 23:  56a5ce2aeb stash: convert `stash--helper.c` into `stash.c`
>     @@ -13,7 +13,7 @@
>          called directly and not by a shell script.
>      
>          Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
>     -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
>     +    Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
>      
>       diff --git a/.gitignore b/.gitignore
>       --- a/.gitignore
>     @@ -273,9 +273,11 @@
>       		return 0;
>       
>      -	strbuf_addstr(&stash_msg_buf, stash_msg);
>     - 	if (!(ret = do_create_stash(ps, &stash_msg_buf, 0, 0, &info, NULL, 0)))
>     +-	ret = do_create_stash(ps, &stash_msg_buf, include_untracked, 0, &info,
>     ++	ret = do_create_stash(ps, &stash_msg_buf, 0, 0, &info,
>     + 			      NULL, 0);

I do not quite understand this change, though. The end result seems to
look similar enough to the previous iteration (except for the kept line
wrapping which I would have undone in this patch), but how come that the
`include_untracked` crept into some earlier patch in this iteration?

The rest was obvious enough, thank you.

As I said before, I was very much in favor of getting this `stash-in-c`
business moving again by advancing it to `next`.

From my perspective (which is not informed by any official statement about
the role of `pu` or `next` because there is none as far as I know), the
purpose of `pu` is to get patches into a shape where the original author
is no longer the only one working on them. In my mind, that moment has
long passed, and the fact that `ps/stash-in-c` is still stuck in `pu`
really held me back on working more on this.

So if you manage to get this finally cooking again, all hail to you!

Thanks,
Dscho
