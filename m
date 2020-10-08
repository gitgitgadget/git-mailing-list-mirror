Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB0CC43467
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 10:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2692E2065C
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 10:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="TVUh9H8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbgJHKGv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 06:06:51 -0400
Received: from mout.gmx.net ([212.227.17.21]:37663 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729148AbgJHKGv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 06:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602151608;
        bh=jWGKGQ+y3IwuHWDe2lRgIXorh2Who/Y1IpoCB7a3PKY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TVUh9H8yJEmAkoJYiFOtQiBY8Nl4ErQS/KaRI5IbSfYpL8HV8QERNtOFpgA5m3pr9
         4Wu0mQ1Fz3j9BU0UJ2nl9KIcuXYUkUgxGvW/qh1S9qacCGIct1K68L8syrBO9BN8+2
         3icCZgNWl4mZM0cyOQePWN02IF6PaW59oo7dcV0A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([213.196.213.184]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mdvqg-1kxs6A24ZC-00b7FX; Thu, 08
 Oct 2020 12:06:48 +0200
Date:   Thu, 8 Oct 2020 12:06:47 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Denton Liu <liu.denton@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] Makefile: ASCII-sort += lists
In-Reply-To: <f0f1ef1f677133eabd1bce00c6cdbbcc6477f00b.1602142738.git.liu.denton@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2010081156350.50@tvgsbejvaqbjf.bet>
References: <f0f1ef1f677133eabd1bce00c6cdbbcc6477f00b.1602142738.git.liu.denton@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:WLj1lZ8YX77GvkH8fJXUvnb2ctWZLxfBQxoQ988hW4Oy2DU7127
 ont+MEn8Ym2q0MeKj+kwEw05jo/uaRukZs0RoAQg5P5Fshl/hlqZPW9EG9f/mQ3WGJfYu9M
 tggHeW0YGCGaRaGke/uKfgAoF4t8+ws91JfpsmLIvLABScuNGko2YDyxh3R3ahFk50SL8W1
 aMezmfzZ592JlMK7s0tEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MteDY+ICpLQ=:od5k60OE4+PJ4PRL1W/MEh
 eo5TVhWtYW5BUfXidmhzBqdhN+ioiJXFigxeEx+6GSoksMvWJ306TqDleA4CdLvQPNlC37trv
 FxLdO1xHSuE3NhwMOpAzmwdy5QbLDmgYjAb4rNLRZSjblmgZ5D63jJeYT3yg2fpI2Bq0Wv7Jx
 XivhBgbWmvzqtqPTlA8xrrGhrHzHKqrKrQFxTpJccNLCfZ7/guD+07+zMQh9IiRNJqriBHodO
 XF4oTefnGwTs7uGdiubmOlz0ibh8i0i/v//2LJdSv/vJnvcDzkQBQiUNz/eqQzyTVniTIQneN
 ywLtl0TCYYWeVA9PzvMY4cSX4Xxhfia2YA2W2rNxC1ArR0zDTX7KhCV89JHldRP8XK0PYhAla
 +2EMTqrjtN0o1D8eHxrgakRZE/Elhjbta6YP+CPsKI7gFIMdhneYy7224Z5BIqZhc+I+yt1QU
 a+sC4TQJ/bM4GGHzNGSDjKuYKthrC0sIIzjihBFyevCyjRbgJgND791aY3wSEGtM2Lnm+11wC
 fqqzNMW5agsVxAy/vofLx0M6UbXqgczukY8VvnvwSWSJavUoG71pKOGMwi88v857EHfMknrYw
 h6RQQDNEgSOTr6kZ5Des1YjDf/hu0+RDdSm7DfQV90ywjrvtxOINZGm2B3lB2AORRQr/Q+9+i
 Asac5trdZu1JSb7vXAas+q6XiUMfand9rVCJmIHAeOIR2w3ajRmsDef7HZtkZITy1Sg94XgiO
 yBqk042bgLTyyMrB28CtoWhyD1yF6gjQ/4Y56h5DPtE703MMmp2NIkkilU46MJtmEtQzwpHL8
 Oiegu4GnZtU/ieamR4OjMBJ4WySgG46Nqg4Va9lZGARJIfVbQT0wTrUAsn0rCetbAXT67m6eM
 2VLwbUsQwN34ARcL2fspV5nKtqLxfP44Enl1u8Ui7e9/SvGSbWhPILIiqCee8UummH26sWJEl
 Y09DJMapmBOEwXrQeabtkYfn80pb+ZJb34DJt1AsoN4i0yfdvaRSHRmwB15jRsPoLJLAPiunQ
 2EZOBpp4WnLJnwqG4Rs7vuq2W1Rvv7gPaOOJm/+94su7xbM3aC2KGU4AGDRLqNBSquB/t7uMi
 yUCvRmvKTyE1hfVcy+jaTRfRAFX/dedvdp7FOwB24wBBpmSU48PfUUX5Ddv6TODyD79wG/3Z5
 656T3NiYYzQ2tM3YpS73M/fodvheF8Bf+1LVAhAiqLxiw9rKG9K/qzdt0Y3TG14B7fQDJPzg5
 S54xXRh3aWpN22H66DRYcMFgpRJ3tLzBSXeLXvQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton,

On Thu, 8 Oct 2020, Denton Liu wrote:

> In 805d9eaf5e (Makefile: ASCII-sort +=3D lists, 2020-03-21), the +=3D li=
sts
> in the Makefile were sorted into ASCII order. Since then, more out of
> order elements have been introduced. Resort these lists back into ASCII
> order.

Personally, I would write "Re-sort" or even "Sort again", so that readers
such as myself do not stumble over the verb "resort" (as in "We resort to
desperate measures").

Also, this strikes me as yet another task that is so automatable that we
should really avoid bothering humans with it. I gave it a quick whirl, and
this Perl script seems to do the job for me:

	$key =3D '';
	@to_sort =3D ();

	sub flush_sorted {
		if ($#to_sort >=3D 0) {
			print join('', sort @to_sort);
			@to_sort =3D ();
		}
	}

	while (<>) {
		if (/^(\S+) \+=3D/) {
			if ($key ne $1) {
				flush_sorted;
				$key =3D $1;
			}
			push @to_sort, $_;
		} else {
			flush_sorted;
			print $_;
		}
	}
	flush_sorted;

It is not the most elegant Perl script I ever wrote, but it does the job
for me. And we could probably adapt and use it for other instances where
we want to keep things sorted (think `commands[]` in `git.c` and the
`cmd_*()` declarations in `builtin.h`, for example) and hook it up in
`ci/run-static-analysis.sh` for added benefit.

My little script also finds this:

=2D- snip --
@@ -1231,8 +1231,8 @@ space :=3D $(empty) $(empty)

 ifdef SANITIZE
 SANITIZERS :=3D $(foreach flag,$(subst $(comma),$(space),$(SANITIZE)),$(f=
lag))
-BASIC_CFLAGS +=3D -fsanitize=3D$(SANITIZE) -fno-sanitize-recover=3D$(SANI=
TIZE)
 BASIC_CFLAGS +=3D -fno-omit-frame-pointer
+BASIC_CFLAGS +=3D -fsanitize=3D$(SANITIZE) -fno-sanitize-recover=3D$(SANI=
TIZE)
 ifneq ($(filter undefined,$(SANITIZERS)),)
 BASIC_CFLAGS +=3D -DSHA1DC_FORCE_ALIGNED_ACCESS
 endif
=2D- snap --

I am not _so_ sure that we want to order `BASIC_CFLAGS`, but then, it does
not hurt, does it?

Ciao,
Dscho

>
> This patch is best viewed with `--color-moved`.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  Makefile | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 5311b1d2c4..95571ee3fc 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -820,8 +820,8 @@ TEST_SHELL_PATH =3D $(SHELL_PATH)
>  LIB_FILE =3D libgit.a
>  XDIFF_LIB =3D xdiff/lib.a
>
> -GENERATED_H +=3D config-list.h
>  GENERATED_H +=3D command-list.h
> +GENERATED_H +=3D config-list.h
>
>  LIB_H :=3D $(sort $(patsubst ./%,%,$(shell git ls-files '*.h' ':!t/' ':=
!Documentation/' 2>/dev/null || \
>  	$(FIND) . \
> @@ -998,9 +998,9 @@ LIB_OBJS +=3D sigchain.o
>  LIB_OBJS +=3D split-index.o
>  LIB_OBJS +=3D stable-qsort.o
>  LIB_OBJS +=3D strbuf.o
> -LIB_OBJS +=3D strvec.o
>  LIB_OBJS +=3D streaming.o
>  LIB_OBJS +=3D string-list.o
> +LIB_OBJS +=3D strvec.o
>  LIB_OBJS +=3D sub-process.o
>  LIB_OBJS +=3D submodule-config.o
>  LIB_OBJS +=3D submodule.o
> @@ -1066,15 +1066,15 @@ BUILTIN_OBJS +=3D builtin/checkout-index.o
>  BUILTIN_OBJS +=3D builtin/checkout.o
>  BUILTIN_OBJS +=3D builtin/clean.o
>  BUILTIN_OBJS +=3D builtin/clone.o
> -BUILTIN_OBJS +=3D builtin/credential-cache.o
> -BUILTIN_OBJS +=3D builtin/credential-cache--daemon.o
> -BUILTIN_OBJS +=3D builtin/credential-store.o
>  BUILTIN_OBJS +=3D builtin/column.o
>  BUILTIN_OBJS +=3D builtin/commit-graph.o
>  BUILTIN_OBJS +=3D builtin/commit-tree.o
>  BUILTIN_OBJS +=3D builtin/commit.o
>  BUILTIN_OBJS +=3D builtin/config.o
>  BUILTIN_OBJS +=3D builtin/count-objects.o
> +BUILTIN_OBJS +=3D builtin/credential-cache--daemon.o
> +BUILTIN_OBJS +=3D builtin/credential-cache.o
> +BUILTIN_OBJS +=3D builtin/credential-store.o
>  BUILTIN_OBJS +=3D builtin/credential.o
>  BUILTIN_OBJS +=3D builtin/describe.o
>  BUILTIN_OBJS +=3D builtin/diff-files.o
> --
> 2.29.0.rc0.261.g7178c9af9c
>
>
