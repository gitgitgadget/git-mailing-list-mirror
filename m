Return-Path: <SRS0=CKFy=AO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B330AC433DF
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 14:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 858DC20899
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 14:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="PMtHCDHs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgGCO6O (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jul 2020 10:58:14 -0400
Received: from mout.gmx.net ([212.227.17.20]:39491 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbgGCO6O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jul 2020 10:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593788279;
        bh=o+FrMLU3h6tYPqaISIndlb6j1cfK0K1x5B6tg3aH5bY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PMtHCDHs6GUaV2AZCOtkL1twy/EI50O5oz75SauqQyavaxbeJBzB2d2da8QmX58dL
         o6K1TXHZ3+G5ApAP37ZUZvyeXwMMJmWvsUewJZ7oKdnuN1YI4ru8Dj5RW/88EVDTHs
         p8MyUSFv6ZTtP11UTEmqQNOifdz/caw8vuHctK6w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.26.78] ([213.196.213.64]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiacR-1jBzu41smd-00fgnL; Fri, 03
 Jul 2020 16:57:59 +0200
Date:   Fri, 3 Jul 2020 16:57:55 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
cc:     git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
        liu.denton@gmail.com, kaartic.sivaraam@gmail.com,
        pc44800@gmail.com, sbeller@google.com, pclouds@gmail.com,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/4] submodule: amend extra line feed between callback
 struct and macro
In-Reply-To: <20200702192409.21865-2-shouryashukla.oo@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2007031653570.50@tvgsbejvaqbjf.bet>
References: <20200702192409.21865-1-shouryashukla.oo@gmail.com> <20200702192409.21865-2-shouryashukla.oo@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:SrHG5RhKc4y0L1OIWJZebJ5ciQhAK3Xa1+Kd5vmhqSrss641mnK
 Z3HdjXNBAql1dVOYt2jy5DuueQHm1JGW/UQbW+OQjqRP80ixj1T1Ef1BEXpOeBv0hiE1vDr
 afAoM2jpL2d8WKc+8GzGuGBg36pTahyqqSsNq8tbhnj9mJXKsuKsW6OA7pgCQxcuPFQuLyB
 Vfl8xMQTfRKUS0Ccb8kzg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:q8puWmb/pb8=:oZ+7wqRfknztBNtthMh4SM
 L61SCgzMBATm3Mtg2B5jZXGa+OYK6zBZN4KhHzUJSoaa1asTb+YNgRllcssA0oukx+yTTXBax
 fnXHF0yVe2dSkDCzJnIA8ys2Eabc9AdxWRnsffS3f3/0gcKnhLYy9cn4YXtheKHz8gPdPCeJJ
 BSjA8lGYmNGLHi8knNYythoUj4nDU6XkKTF+k+bLyI7Fa21V3CXc99yCcBf3uoOHOGXtHRzsq
 ynp6mGA00lylZCL6OgIYad2GKp7MbXI/tQgrBIOcoR6Hz+8siQHLDLbORA0S3saheJ+rvRZXu
 AwTxgy3MKQIanH602wBV4fM/CH8PiynwRQjSWM6sWVBSqPEBHNe/uRC/6PDJwz2ZbLLjlN0uW
 1yy0TMCDG3L98iHuQ0WMMOsoEJRLcqcExxzw++XVkpTePu+EsOSP9d8pNoecNBw4mi4/pVSlz
 IpTvhZmtqKRYfy9MJZQp5zLxxgCfh82VZdLWBYNCN2jt1NZHWvHeMNxjmxVuP0rS+1Wb3bMsB
 PF1jssrOQorVpIZxucjKghBJuLMHoPrNiwLmILvsX2HQKc82zUeHRe+5aOH1nUP6k8Gs2SMe4
 rB7eZ4kZqF1/nTaN7noUiV5rOiolOzwXp4Fdmw+nvivBhbmYoCkHksZ7DNCMGEj6pa/QApeMN
 5CLzHQiGxJkgdzkCwYWt8c24TF3VNkROfB2lg0VI5SEYFjJ01+E3lezyCXbV35CaWn1TZ6wzA
 4hrq8ZvcTRZ9SKVBsw7bx4lfnl9xdASF+9kF67JlCKZFIM+h37Cr/drnGl1JIge7GbnpVk8Nz
 vvc6ZR3ldBuf6J1FniPOQmA4nsGVQe4TqPhLTiDassovxW7EmNJ+3L0z8N4qSBigOKNjDDRG2
 VisHX0Jlowb8EJnIe2czmuH/8HUbTGRUNpvtpnMayh5tnAqNgI7XeDOWPvPhMDQ9yLiJZdnJE
 U/7lhTwJfWHvxpIqFrXAoH/xXnlI+y0b1M9LHzaaqIZ2na+B4Y7r1UOr1xnzvEAZbGzMBC9Vu
 wyAU8V/zEt0+JymXeem02MnVrt11Xv6QVnwTOTrcQiCxZY9x1reVgkrKRuwtD9AcsDR2mg+Fp
 5W2O/maTkLGCSWFrY3r9sXGJALaVkEY0x5U2QnjL66q6R1kcQ/wT99OfrJfc4ttqosxxiZX3f
 n5zDeZiGZZvis2YMvwt+k3cRTqtNs/zpYVHc+scrDfl3G8H3t4MhQuhjBJRj965Pg5EGXiUlM
 01a7C+tH/3VvnnXoxl176z9kZHz2k0oeJ5ay3Pw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shourya,

"amend" sounds a little awkward to describe what the patch does. Maybe
"submodule: remove extra empty lines"?

On Fri, 3 Jul 2020, Shourya Shukla wrote:

> All subcommands of 'git submodule' using a callback mechanism had
> absence of an extra linefeed between their callback structs and
> macros. Subcommands 'init', 'status' and 'sync' did not follow suit.
> Amend the extra line feed.

Maybe a native reader can suggest something that flows a bit easier? I am
not a native English speaker, but I'd prefer something along those lines:

	Many `submodule--helper` subcommands follow the convention a
	struct defines their callback data, and the declaration of said
	struct is followed immediately by a macro to use in static
	initializers, without any separating empty line.

	Let's align the `init`, `status` and `sync` subcommands with that
	convention.

The patch obviously does what the commit message promises.

Ciao,
Dscho

> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
>  builtin/submodule--helper.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 59c1e1217c..eea3932c40 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -612,7 +612,6 @@ struct init_cb {
>  	const char *prefix;
>  	unsigned int flags;
>  };
> -
>  #define INIT_CB_INIT { NULL, 0 }
>
>  static void init_submodule(const char *path, const char *prefix,
> @@ -742,7 +741,6 @@ struct status_cb {
>  	const char *prefix;
>  	unsigned int flags;
>  };
> -
>  #define STATUS_CB_INIT { NULL, 0 }
>
>  static void print_status(unsigned int flags, char state, const char *pa=
th,
> @@ -933,7 +931,6 @@ struct sync_cb {
>  	const char *prefix;
>  	unsigned int flags;
>  };
> -
>  #define SYNC_CB_INIT { NULL, 0 }
>
>  static void sync_submodule(const char *path, const char *prefix,
> --
> 2.27.0
>
>
