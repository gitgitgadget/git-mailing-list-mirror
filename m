Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A2BE1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 10:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbeGQKlT (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 06:41:19 -0400
Received: from mout.gmx.net ([212.227.15.15]:45645 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729712AbeGQKlT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 06:41:19 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M5cpk-1fyzGo077A-00xbsx; Tue, 17
 Jul 2018 12:09:18 +0200
Date:   Tue, 17 Jul 2018 12:09:00 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 11/25] t7400: fix broken "submodule add/reconfigure
 --force" test
In-Reply-To: <20180716230535.GA49654@flurp.local>
Message-ID: <nycvar.QRO.7.76.6.1807171208120.71@tvgsbejvaqbjf.bet>
References: <20180702002405.3042-1-sunshine@sunshineco.com> <20180702002405.3042-12-sunshine@sunshineco.com> <nycvar.QRO.7.76.6.1807161641140.71@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1807161749410.71@tvgsbejvaqbjf.bet> <CAPig+cRFeNt9FVDGnbGcp8Bvfh0ohay+p+tLhfx=EFvJg=Q1Sg@mail.gmail.com>
 <xmqq7elusvz7.fsf@gitster-ct.c.googlers.com> <20180716230535.GA49654@flurp.local>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:N9wvNT+WdWEECK6pZ7yb883niaqZOooYjplWZ6VEvgkVxWUe+k7
 JXc75qk/PU0Ge9IPppXhQhbfdwzeKIGHY+Y6iEJRwyH+2PMwV/W825t6Bo1GZToTDsugPt1
 RoW3m7wljDdKYpVr2wbc5aZSigADIi33v4nTQirCtJWKEqrMTccXOimxkQ0t1mY780VopF3
 k9WDNrBxGvNht8ixXlSPw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Dx5JHg/PlPw=:kMR73P1F5vw4h2ak7ycVaF
 nN9qDdWQt9fRVaiCHppkSGI2wmzjHx+oINTmrELlswjHG6DJyHaDV5bXNeeFUhWo3+dPKgV8f
 Zd9RwzDAINHgIL0VEOdchrABMMzdKw74p7fSjtbxcRIRIPyG/jf+bd8ucyRYbaUpa4txIP9zv
 eDtcqAneCxfSabXDItTX6RomyId3cWoalMMpxgOnITrIlORyerSF/6yCnlgfl5uWHIxYAEyHC
 KOug3RES2NpgvXkgmLrWYklJok1uxoHsPC/yWobG5lDrUQ17jd8bgy4fOebnmEwAVG7n28GmH
 fzlBKbTJA2mJgvxQAl2jbEYJWkeZ8vQWiqoiLwpkFZ7UNLX0mHyzKKyI8nV3ooKyjWlN4Nwak
 MnKpknl7SVYB2wkI4bjHGi3bIrSVsdaOFykqgUGUXiLdS8uCFd2afv3W2JIdIhxpc0OmbvzSK
 9q2XqIgR4UGMJ1tsJFgRdazx1DcdpmK7yX0tmU/wXv6YO85507gnzg1G+Sguyv3KoaoM18zZH
 O9kk/LIXl7w+jHDt+z0xbWJ8Ad/lGx1dQsX1hHNn0i9LLf6h4TP7sVuHO6wMraE1QqBsPPJgr
 rbA8pM25dz/+a4HvVFgFQThH51nXK79qJvRfT+ERdgbrHKfJHuEcnf71J/9aUpl11eqopa45+
 B8pE1IK7EVESZ7N0/tF4xXWYDko9nBT6XA9YzcOq6vhtmajAlD/a31z2BXN5PUjr+Ih1qbbEw
 GxaXkD0vcktpsh40ZSHPI511pEKozjL2dgVuvyXT1Vr99uL2vsdBe98kHTriWgqOw5buSJx8v
 MZbd4mf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Mon, 16 Jul 2018, Eric Sunshine wrote:

> On Mon, Jul 16, 2018 at 02:37:32PM -0700, Junio C Hamano wrote:
> > Eric Sunshine <sunshine@sunshineco.com> writes:
> > > On Mon, Jul 16, 2018 at 11:51 AM Johannes Schindelin
> > > <Johannes.Schindelin@gmx.de> wrote:
> > >> On Mon, 16 Jul 2018, Johannes Schindelin wrote:
> > >> > > -           git submodule add --force bogus-url submod &&
> > >> > > +           git submodule add --force /bogus-url submod &&
> > >> > This breaks on Windows because of the absolute Unix-y path having to be
> > >> > translated to a Windows path:
> > >> > I could imagine that using "$(pwd)/bogus-url" (which will generate a
> > >> > Windows-y absolute path on Windows) would work, though.
> > >>
> > >> Yes, this works indeed, see the patch below. Could you please squash it in
> > >> if you send another iteration of your patch series? Junio, could you
> > >> please add this as a SQUASH??? commit so that `pu` is fixed on Windows?
> > >
> > > So, this SQUASH looks like the correct way forward. Hopefully, Junio
> > > can just squash it so I don't have to flood the list again with this
> > > long series.
> > 
> > The topic already has another dependent topic so rerolling or
> > squashing would be a bit cumbersome.  I'll see what I could do but
> > it may not be until tomorrow's pushout.
> 
> No problem. Here's Dscho's fix in the form of a proper patch if
> that makes it easier for you (it just needs his sign-off):
> 
> --- >8 ---
> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Subject: [PATCH] t7400: make "submodule add/reconfigure --force" work on
>  Windows
> 
> On Windows, the "Unixy" path /bogus-url gets translated automatically to
> a Windows-style path (such as C:/git-sdk/bogus_url). This is normally
> not problem, since it's still a valid and usable path in that form,

s/not problem/not a problem/

> however, this test wants to do a comparison against the original path.
> $(pwd) was invented exactly for this case, so use it to make the path
> comparison work.
> 
> [es: commit message]
> 

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  t/t7400-submodule-basic.sh | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index 76cf522a08..bfb09dd566 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -171,10 +171,11 @@ test_expect_success 'submodule add to .gitignored path with --force' '
>  test_expect_success 'submodule add to reconfigure existing submodule with --force' '
>  	(
>  		cd addtest-ignore &&
> -		git submodule add --force /bogus-url submod &&
> +		bogus_url="$(pwd)/bogus-url" &&
> +		git submodule add --force "$bogus_url" submod &&
>  		git submodule add --force -b initial "$submodurl" submod-branch &&
> -		test "/bogus-url" = "$(git config -f .gitmodules submodule.submod.url)" &&
> -		test "/bogus-url" = "$(git config submodule.submod.url)" &&
> +		test "$bogus_url" = "$(git config -f .gitmodules submodule.submod.url)" &&
> +		test "$bogus_url" = "$(git config submodule.submod.url)" &&
>  		# Restore the url
>  		git submodule add --force "$submodurl" submod &&
>  		test "$submodurl" = "$(git config -f .gitmodules submodule.submod.url)" &&
> -- 
> 2.18.0.233.g985f88cf7e

Thanks!
Dscho
