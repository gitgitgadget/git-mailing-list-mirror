Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C79C2D0EC
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 22:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D10882063A
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 22:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="JgtDPSKZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgDGWlj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 18:41:39 -0400
Received: from mout.gmx.net ([212.227.15.15]:44407 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgDGWlj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 18:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586299297;
        bh=cJPzAXEH4qws2Cwnv0lTJQny2qCLgXW/SIlrZeX1dJg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JgtDPSKZwlR3Ysqfkh5K628oDIeXT2SBlnoD+iqKFhnnzzu5R5RZs5tQyxN+wm0fq
         I+cqAJTXutcElYyfZDY79v00DX5V6RBkqtzvJOMJXghuxK+JCvbfl8F5eRksFOjdpr
         Wa05DsDNHy2ckM5vrbZh3J6Y0tXxbe8mxidgcaKY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.212.75]) by mail.gmx.com
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Md6Mj-1inAG210Il-00aAYi; Wed, 08 Apr 2020 00:41:37 +0200
Date:   Wed, 8 Apr 2020 00:41:36 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Danh Doan <congdanhqx@gmail.com>
cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/5] ci/lib: allow running in GitHub Actions
In-Reply-To: <20200405000108.GC1896@danh.dev>
Message-ID: <nycvar.QRO.7.76.6.2004080039240.46@tvgsbejvaqbjf.bet>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com> <d9227c87a7bb2872f6a69f48f6a4988f08545d8a.1585658913.git.gitgitgadget@gmail.com> <20200403084654.GK2224@szeder.dev> <nycvar.QRO.7.76.6.2004042207410.46@tvgsbejvaqbjf.bet>
 <20200405000108.GC1896@danh.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2069516959-1586299297=:46"
X-Provags-ID: V03:K1:/apxKrHBf9bfLGe9bZnzu6QfmBnSpG13nVQtFYYJxKvmHeNhPET
 DrJNSdZFaXsrQwlhsDjsksWNGOJPf4n9UPkEt9ufVw/wlfPqUgQ8szTihy3I3Bb1D66BV78
 SBAUMeYsTUa4rOnS9PLBUpp/rq0loaPx3Wk4ef6Gyk9Mf/2V4ALR06FR+JDoAtMLuyACHBq
 XLgVaLHuZu8ocFqGciNVA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NUWn8Mv39dg=:2MOsT17Lw1PkD+pGrr+sKG
 8jChn4E4mDQrXq2YfWhNG2+weVXpNg6GeD0TowI6UUz47rjZSP9yrieeaq7p0fILXxwr8ougF
 YRwK5HyyLdMRoTl811aSAEmEX2kSM+pMVkVMaJ73pgW9J9D+uYAgcsrdQgPBYKLsFhEi73fPI
 EPj9B6cadms63vY67vBXYZktbZaaHAzkSVBIZSKtmpmnTK8owg5W04S8WW3vF8+5h+k4blBLu
 CzAWXY2akb5vNw/k+BHbZLriZfThqIW5pB65LffICNukPBbqEjqsc0DcgETmq1d+kDZ6nLsI9
 SagjNqD8UukvRTpTOVYqnQaQsS+D3ee6vpv6EK2XQNBCMxfonJ0K/taM3bCUdKwFl7KOW4bao
 znSNZ6TzYOgT8JCDlp7sHed5yVHnThqEAyXFz1C0af/1/ebY7t3Jl1yzHfOBkWjTOOVGMDCdg
 ui+bS4vA7V52Ogk3R19jqkTGJwTX/kjzAmT3hQ4AbheffTbMIcylJCb4owa67i0In0cR2V7yO
 aHKd4DCuFsK5Q4FxamlllTMDm4aSC4PP0eQcDMCGHyM8Bm0fMg14pvPq4sM+aRg9KTSb2FXHa
 7ttru9pUKIu4nbNKcvHfWYlwBlyrWeIZhFK40gwhdZvgJFnc6e2DIEm3TolHvGSKmf0nG85Bd
 NAkK+F5KRMNMX+y4LnXsicuA2BEFQNGliFHjDEtfSE1DoNlefvWRJea47Zt83gbfXEzEXA8iZ
 DKyOZjDUDcF+E504c+CsBdRokr68a/EIHGCqVZLExI5OmL3x6b9rt9RyixbJclwy5LxBhZN7l
 j6oVdBx/K822cdQx157XKr2m1Y5ZOootlYWU89HA4oLDPdYGrvOI9hY5F2xaAn7p1juLFjrQn
 A7ZqahTgMsc+dlAA4nM0thvPzp653UFOEwCgl29hxWiTugUH7E0Xavr7YQn0x3qb+sb8hhxDh
 908DOuIkkrGAECpK0REkx5JXr/kQoa9TbsZBbJBGHBtjGW0tPkBlWZ2WFjszF+GjUNUcgrmdh
 gh4lLQ3oFmW+1wEyHCPf3g+ijuUVglb9RkW9MvmM4jFn+b6+of/NBrhUxtRg7/4FyHR6XQp1N
 xYi+TRSePcMGZPBR3/V5NBb+jyIGCmED0S/RwZ2s74l+/5gwPmFa6WD8MtLeKbyQ+N6WEru1A
 fHNREbWzGRzos5CJjoLDnGbHxtKOGaoOu0V1hnhH+aC5nQkUfvhsGbZeuJ2IqitBAMRgivxDq
 d+mWV9wNLRSgf4SPOEDTBtrcTDEeC0ImSuojLyA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2069516959-1586299297=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Danh,

On Sun, 5 Apr 2020, Danh Doan wrote:

> On 2020-04-04 22:08:56+0200, Johannes Schindelin <Johannes.Schindelin@gm=
x.de> wrote:
> > Hi G=C3=A1bor,
> >
> > On Fri, 3 Apr 2020, SZEDER G=C3=A1bor wrote:
> >
> > > > +	CI_TYPE=3Dgithub-actions
> > > > +	CI_BRANCH=3D"$GITHUB_REF"
> > > > +	CI_COMMIT=3D"$GITHUB_SHA"
> > > > +	CI_OS_NAME=3D"$(echo "$RUNNER_OS" | tr A-Z a-z)"
> > > > +	test macos !=3D "$CI_OS_NAME" || CI_OS_NAME=3Dosx
> > >
> > > Hmm, if "macos" isn't not equal to $CI_OS_NAME, then set
> > > CI_OS_NAME=3Dosx.  This is head-scratchingly backwards, and I think
> > >
> > >   test "$CI_OS_NAME" =3D macos && CI_OS_NAME=3Dosx
> > >
> > > would read better.
> >
> > I can understand where you come from, but your code is not `set -e` sa=
fe,
> > which is the reason why I wrote the code this way (compare to the alre=
ady
> > existing code in the previous clause, which was copy-edited here).
>
> I certainly saw a shell that broke on
>
> set -e
> test false && ..
>
> I couldn't recall it, though.
>
> Would it be OK if we change it this way:
>
> 	if "$CI_OS_NAME" =3D macos; then CI_OS_NAME=3Dosx; fi

We would have to fix quite a bit of code if we wanted to avoid the
`<opposite> || <action>` pattern.

If we _would_ need to (which I don't think we do), I'd prefer:

	case "$CI_OS_NAME" in macos) CI_OS_NAME=3Dosx;; esac

But again, we would have to clean up quite a few instances of this, I am
sure, and it might not be worth the effort, given the short-and-sweet
nature of the originally-proposed solution.

Ciao,
Dscho

--8323328-2069516959-1586299297=:46--
