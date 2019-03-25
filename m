Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C492620248
	for <e@80x24.org>; Mon, 25 Mar 2019 15:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfCYPaD (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 11:30:03 -0400
Received: from mout.gmx.net ([212.227.17.20]:43723 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfCYPaD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 11:30:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553527801;
        bh=Y/FiylvTe4U6T/sGxGEcATFtPOCJX4YDD/wXLsXevco=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bDvbVgkOjbo2C6ufi8u7063aMlR+1Hsu8S17d8xL0OvYk09sAY2gDBCuJF5p1guzN
         SSM42ZDhHaSLMBeLjvFEaqIYZxFgnjN3R8N9C68VC03UuEvgi62ZksgPGZyhsR6A1m
         s30uiQNi8cUF+F9T8Lzh5rX4lI/gJQrEqm+/UK5A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MLvLE-1h2wIX0voS-007psZ; Mon, 25
 Mar 2019 16:30:01 +0100
Date:   Mon, 25 Mar 2019 16:29:42 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Keith Smiley <keithbsmiley@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] Make stashing nothing exit 1
In-Reply-To: <CAPig+cT99t1y8kMdGLF_GU0cvaVm=GKMRJ+xRcgS80rRgdQZDQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1903251625250.41@tvgsbejvaqbjf.bet>
References: <01020169a7ad6af3-ad50e2d1-19fb-46eb-b397-759f8d579e8b-000000@eu-west-1.amazonses.com> <87d0mic9fm.fsf@evledraar.gmail.com> <CAPig+cT99t1y8kMdGLF_GU0cvaVm=GKMRJ+xRcgS80rRgdQZDQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1843981721-1553527801=:41"
X-Provags-ID: V03:K1:GxCdUtLn2HzVmjohM2PdJmM+HEDz1VB5ASsi+jEan7L8NbKFbDM
 iG+eeBi79TDiTAyYu1JJ4ddMFbRJgaqvOn09uNHPxNVw5exKwo0/MvIHJfGmnu4ckfY+H4h
 RlF4A78PXzfAGN3Y3Jg89NdIifa0wSCNqacYdFuDVr+d5HtVtgNDffURyjMaB+WTVnkIDUt
 cuPh1LmXkVUKwv/SgnmCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q0NbW3Dvoh8=:UaPGBAkrQSW5IwvnFDupuf
 LY5rqs3dmmFfONWCAbmQXcLOhGs8QNGJBtfH67nZKpGphUzocrRrdnXon4RsadUXRU4iwMVla
 X0sUTb6+ciZ32qrMh9Zc3B8jBnoHsK45UfOZRAoUnhgcDQ4pxMp4zPGt0b0ngYL+AmdAE9D2J
 To9Ha/QYeR0UZlStaF7vJ/CRQ+IAPkBgNK4wj2z7Np4ZuJzK0ESmy3LDAX9b84CFyiMbnTmUY
 Mm+8ZaHXsANKriWbkv/L/ar+HEt3aPP9ZkjwatTHmEn6EyjaUsyamQHb87n+pLzB1LQWqziVd
 WCuam1Z7BR77jCRRdDa8uWVPeUjjP8wyUsG2CTsYl/470n29uny1rRBm08O8Z1L95MpkhVhhd
 ZZYjJOMUy47KuSB2hg7zo6nYiMRUbv1nFsCZk85wiirHf7kzt7hRvr1y65/S/WmCB7AIEF8Yo
 Qzz/05MWCnja0LNt9CjJXsbezSEjGA19k/2GeUxt+WinIjIMxWWiLlCNn3yM8U0ykVox+Pmvv
 ///BuLNzQZk4vxRpy92ZsZpZ1fBxRhERpGRyRRLqtLYwpWrUuEPSlsGIZGxW1OKxbS3SVzR19
 bn1zu6qaZ5IMdOLjTBU/m32+TZNXuI8+6OqSaudk4fjEI6YDAXRZ6ohu/EtUu1CLL1xV867+o
 T1DX2wvbljok5OL7wb/x8Qwu7to0zGCIfY0h6on8WrEbfsY5kab/WcXPQ+1xLf+IxJa0RCytv
 VdufWxKJsLottqBdRhO6waUyh2H0NgmlZj8p6ADZ7nMk3Ujj32+QKHDKl6cvorWQYQudSVj02
 Uqx/3BTR+llETQWNX2R0MLo/tY+Z/2Cc70tjPMrtCcIRGDtnAkUTcRNYCDHfEPKhkjKO25znA
 LftLzdjqTvpWTFn4uQ/9igqVKEZcHx0RaUsGTmBPf8eSXC91xgXQWgKl6PY6MiKTzNQl7BElk
 aE77/yQCnUA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1843981721-1553527801=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Sat, 23 Mar 2019, Eric Sunshine wrote:

> On Sat, Mar 23, 2019 at 3:54 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
> > On Sat, Mar 23 2019, Keith Smiley wrote:
> > > In the case there are no files to stash, but the user asked to stash=
, we
> > > should exit 1 since the stashing failed.
> > > ---
> > > diff --git a/git-stash.sh b/git-stash.sh
> > > @@ -318,7 +318,7 @@ push_stash () {
> > >       if no_changes "$@"
> > >       then
> > >               say "$(gettext "No local changes to save")"
> > > -             exit 0
> > > +             exit 1
> > >       fi
> >
> >  * Shouldn't we do this consistently across all the other sub-commands=
?
> >    Trying some of them seems 'push' may be the odd one out, but maybe
> >    I've missed some (and this would/should be covered by
> >    tests). I.e. some single test that does a bunch of ops with no
> >    entries / nothing to stash and asserts exit codes.
>
> A bigger question is why is this change desirable?

Indeed. When I run `git stash`, my intention is to make sure that I can
get back whatever edits I had made, but right now, I want a clean
worktree.

So for me, `git stash` does *the exact right thing*.

I could see, however, that other users might think that it is more like a
"uh oh, I have modifications that I do not want to commit right now!
Please, Git, put all my local changes into a stash", and when there are
not even any changes to stash, they want the command to fail.

However, I think that this is not only a change in behavior, but probably
a minor use case compared to what I feel *my* use case is ;-)

As such, the new behavior should be hidden behind an option (say,
`--fail-if-clean`).

> What is the justification for turning this into an error and possibly
> breaking existing automation scripts? Arguing that this case should be
> an "error" is difficult considering that there are many other commands
> (inside and outside of Git) which exit with 0 when they have nothing to
> do. I can't find the message in the archive right now, but I recall a
> few months ago Junio shooting down an analogous change to some other
> command, so the justification needs to be a strong one.

Indeed, the commit message should make a case for the change. Otherwise,
it will be less convincing...

Ciao,
Johannes

>
> Also, your Signed-off-by: is missing. See
> Documentation/SubmittingPatches.  Thanks.
>

--8323328-1843981721-1553527801=:41--
