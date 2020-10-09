Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E7EC43457
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 13:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A5AA222E8
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 13:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="dYgmS5UF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388152AbgJINHL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 09:07:11 -0400
Received: from mout.gmx.net ([212.227.17.20]:37973 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732863AbgJINHK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 09:07:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602248817;
        bh=/oSVm1wmZxGzDg3gHUBYobwJieOAVXfRtaCCyACccSM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dYgmS5UFm/saHarDI3/kNHxHVtSK16XWKpiTQQ+qLH9SUnmINl6TTmRJPBO5R94/k
         O2AhfzkliN2BH4yOiG4PJOPvlSvKz90XQfYl9Tw9equW8upgqCkbg9aY1Pj2FmXb2i
         iWIzA34eHkGC4mlbPnfrEC0Se5wbc3zFP/G2clPM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([89.1.213.205]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mplbx-1k8aBI3K6H-00qEga; Fri, 09
 Oct 2020 15:06:57 +0200
Date:   Fri, 9 Oct 2020 12:49:15 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] Makefile: ASCII-sort += lists
In-Reply-To: <20201008160816.GC2823778@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2010091246420.50@tvgsbejvaqbjf.bet>
References: <f0f1ef1f677133eabd1bce00c6cdbbcc6477f00b.1602142738.git.liu.denton@gmail.com> <nycvar.QRO.7.76.6.2010081156350.50@tvgsbejvaqbjf.bet> <20201008160816.GC2823778@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:P/gns6pog/jjwF/7qiWwk0UnQ7ABqB5HY8la0oFEaWk2BnJqbQX
 cKaLehZRvL+444+JWGOF1ai/nk0xC09qnXGhD6nyMJkPzVcXuaVllMs2QWoNYJWzpnwq5Na
 yIqsAd7naAOvgsYUwDslvWuOR4K/GET8B+Du8AyhQ3M2THAPjdGnBtLgI+qpguYlYx3zumA
 XKnnIP9fDAFzZqmtH9jEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5bOVu6mpcOE=:FNg5xQ7xgXbdnQsJxWceqx
 lo6E0czMNNZdtSn1qM6MhaS+Vt+EPDfWlI4kYy1isMACXAItZIdGtjdtgWQCCQBHQjobUsNbc
 8Un9FxY4d2Kf7MbRsmx4sOz/YTFc2Ul4IGM/pRKTxcDwb9Pml3zRF+pBFoNUzQCJmvnJ4+dw+
 lIgQFFFpvxsYMMocmRM/dHMDj8PrGvGpCSTdGExN7IB042ywYRdlr7wAdULfO+DBdjyeowQGe
 yto5PN8Qlq6et3Rlt8gMG9yLKNXF75sl4z2o1jl2tbsgVSfozTQUjXxZCUt/TP9KPrfmX8lgO
 7grplSARc/V1Es/UPqRtXeG6Go+77cCob941LSlQPzk5Dbsod4HgUp0ZWKjQZ/LotkCa9f8GT
 rDsQXAAMWFv9hMc+Bh6CxET06PuL+W7nrl/oivDkFCZyv+nNfmkDqGcZfmJT8fvgrO3qCHPTQ
 VSP6virMBrAeaclbY7CAa3h/YiAc9/qjSgOy85Og20LOgrTB4udodA6+XokmogreRYCR29uYc
 wSJkS5Cv7lovGbj4IoN5xVt3ZbELbP7EDcfCG1e0tj+dhGQ5JAR7SKsD0fI/O/KTJbOQVp6IX
 63AAxQtbHglAbuG/OJe5IBB0u3WdvGoNz3euvon0Vf6Cf8puYWO/qAPtfzVu9W8eb2qXRqI8s
 WWcOpy+S8vLPY/u1pkaBWGLNyRtnNR/dryYN8hypfODEVBpKtiQUuWuTdnhviIf3G21A5BVpm
 SDpvHS4P7JwjJI38k4QYTDpIqcDVONNzDVoRh/Z1mgpbhlI7VblhWfVyj9Ia5rUb+0cwsOzt3
 O/a/iBhufnFUvrUWEGJMX/AEHLc8tM9YrfLlTDJq4CRkWZuDdMaAm4jW8euzoYLpGT1BunodZ
 KYgQgxjYaUMfBoON0uClpTglaGtsIOv7yhU6dUDy+xrkR2O2wJpBd5ONUhxQVsHpjo40E1kjN
 ZlVam63xqxBVcKDRkO5p9ED2TIks7a6zLxwuiMsw1A0qGs4yDGEjO8YrGkV4UwSOrmu2nhJ6e
 xFJY5pEBNB/jbmLCyQicrt1ypnmmH3QvKHkPqOljEAqcHr50IK6HaKeeCN5RvfpuxyyrGWVPG
 R3F/ijcB/OyeyOn31AiZv3Hc1dEjozKLCGYUH/aWnAfdvwln0ZfUbPEF+ViivwDgPFmelyxP7
 C8UmJWsC2g8s6QfrfJSBRS7lYHRPlIBk1gHdAg9jFfig8RWzqaZNvBLZjBziMkfH1ztnmXBrG
 K2xszc2VQLMvlxkhIS/Xiqb2KsVoUXe1sgMNEag==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 8 Oct 2020, Jeff King wrote:

> On Thu, Oct 08, 2020 at 12:06:47PM +0200, Johannes Schindelin wrote:
>
> > My little script also finds this:
> >
> > -- snip --
> > @@ -1231,8 +1231,8 @@ space :=3D $(empty) $(empty)
> >
> >  ifdef SANITIZE
> >  SANITIZERS :=3D $(foreach flag,$(subst $(comma),$(space),$(SANITIZE))=
,$(flag))
> > -BASIC_CFLAGS +=3D -fsanitize=3D$(SANITIZE) -fno-sanitize-recover=3D$(=
SANITIZE)
> >  BASIC_CFLAGS +=3D -fno-omit-frame-pointer
> > +BASIC_CFLAGS +=3D -fsanitize=3D$(SANITIZE) -fno-sanitize-recover=3D$(=
SANITIZE)
> >  ifneq ($(filter undefined,$(SANITIZERS)),)
> >  BASIC_CFLAGS +=3D -DSHA1DC_FORCE_ALIGNED_ACCESS
> >  endif
> > -- snap --
> >
> > I am not _so_ sure that we want to order `BASIC_CFLAGS`, but then, it =
does
> > not hurt, does it?
>
> I agree it would not be wrong to reorder here from the compiler's
> perspective, but:
>
>   - the current ordering is not arbitrary; the intent was to show that
>     we are enabling -fsanitize, and then follow it up with any other
>     related options (first any that apply to all sanitizers, of which
>     there is only one, and then any sanitizer-specific ones). The patch
>     above splits that logic apart.
>
>   - I'd worry that there are cases in which order _does_ matter to the
>     compiler. I'm not sure if anything that goes in CFLAGS might
>     qualify, but certainly order can matter for other parts of the
>     command-line (e.g., static library order).
>
>     So it might be setting us up for confusion later.

Fair enough. It's easy to exclude `.*_CFLAGS` via a negative look-behind:

	$key =3D '';
	@to_sort =3D ();
	while (<>) {
		if ($#to_sort >=3D 0) {
			if (/^$key \+=3D/) {
				push @to_sort, $_;
				next;
			}
			print join('', sort @to_sort);
			@to_sort =3D ();
		}
		if (/^(\S+(?<!_CFLAGS)) \+=3D/) {
			$key =3D $1;
			push @to_sort, $_;
		} else {
			print $_;
		}
	}

	if ($#to_sort >=3D 0) {
		print join('', sort @to_sort);
	}

Ciao,
Dscho
