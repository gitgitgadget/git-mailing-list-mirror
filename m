Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9594C433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 15:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DB1B6138D
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 15:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbhKRPj2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 10:39:28 -0500
Received: from mout.gmx.net ([212.227.17.22]:49267 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232469AbhKRPj1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 10:39:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637249750;
        bh=3xvPzpQzccRSpsbnNUtI0/t7p1oj8KeR+p7v9ZfeSBQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=VC39qKS8br2nEla84lBTLOHDEkcMRai3tGKvYSWS7YcZoojXAeHgaOcx08ZL1/T1x
         7iygLSbKKP6yRzdRdeW1AC1q831pxIq85eQNPjCZosFhkKIrcqwDvTnbHI6L4B1jF4
         sHqsv5HPYimWTf4xK2rjgckDj0NAxb2IdwRLuoOE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.166.205] ([89.1.213.220]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8ofO-1mYtxg1jgU-015puA; Thu, 18
 Nov 2021 16:35:50 +0100
Date:   Thu, 18 Nov 2021 16:35:48 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Derrick Stolee <stolee@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/3] diff histogram: intern strings
In-Reply-To: <88eaee89-4536-fba4-3aa0-c3693f58eae0@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2111181631260.11028@tvgsbejvaqbjf.bet>
References: <pull.1079.git.1637148025.gitgitgadget@gmail.com> <38c771a74d2a348e6a752555f95b746de029b1d7.1637148025.git.gitgitgadget@gmail.com> <2b2bd380-540f-959b-b950-cfdc95cbff29@gmail.com> <88eaee89-4536-fba4-3aa0-c3693f58eae0@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:YaH1ZehioG14pxqSlNAU7xIvfbZaGNMfc1k2XRejp0ML8RiX7o3
 HJTr5KEogvFaxcYK+UEff16mVSYOfrDA+Q/iqtQQW6caNhPc1ZqPLhWbjFA7Qqc2OtyOHJo
 bLPgXbjqfQap80J6+IKdKGBO9VBySiR71sd4EeUlTl/iN1adEuw6qo6hPX/0yWeWzT4Ehpr
 Ahe5vjzQ0O7JUp+LMbD3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Sl4Etveiyx4=:6Hxw4zGLCNyVedU7ZALTy3
 XF3rj8ieVzA/+Le2T5W2jOZq0G7Uaba9IFBjs2fd57HmmsLnjYGS5r7vJf09F1TMtVeQzQBJP
 mmpSSNUIY3v22r+AMX2jUj5rjdB0ZChDUlaRUzyVU82gXcUD0dB+2a39DxkHgGkaMCxHCmlsG
 5E5jVXTtKp+6Kf10513aD/f5jlf3AcXXxnbUm3tfz6AynQCWogx6KJo6Uy4oJTlJUW/7TPuZK
 iN7p0GF4XFeYRVuDXKGGIMqn0pTf4VAwO3UACe2/Qc5TbujSo2Z82VBTMJAt3hmlmFlXP1k7T
 JiKk6/Wz3MaTEzL1FBbQTscE+Ii6HdP1I5SYJ9k8Ev5eetNlTC6rYfuCkA4K2H+7NL/euoDu2
 Nn1uC9YYw6j2LLCVSIPnPJe9OnjniSynJiSb7AaBBpCCMDKLd7UzpHRRmz8qOD5DCZ2CSErFt
 CPbhkLGJWtGkwT+VKhamsstbuQQwceIC7RH1kF3bMTDsORisZCultz6/DscrOtRxQh7KTsJCU
 tTtLmwAl1tA6C6m6dZUaOHXyev3kPGpea4CsTa1+9mrFrAkz/AMBDQKGci4mYqR8A9QLBLXjn
 m4tzrPnhK87yOjfOBhhiybc3+ldwvuE/i9z9kldynd2YeXOHRQn7HgzPRguI52l9MuVJwoIjp
 2u51lpk7sQY0OlfE2/xpLhbMVA/iCB8sBo6ZSgGcaAFvYPt3P8c6PoxXac414x/YNf7NHxoOV
 GxMF/CSsV/h4IyaLPeUSDcWigYA7BYtlxNKcnYSS96pkeA09/yV35DYk3scptUI6XUYP6nf6o
 6F3711X8r6S5aVpoghNEiLuSNU0qxwi0pFn1QMupMbdwr7LiF1MD8FQgqGWKVVGWrcJ5f3Srv
 7gUYSGM5FX9ElAK6ir8x+E10CxxRkiPJGzsonS2rEPKmCKJaE1bBY2VkUArw9o9Rj+9sMBYaB
 fBC18HVkOGffwlJhBq0/sFGoJDGsFtJvkicn3a9xKKqW9Q9aNbt1Nu24wGLN3bkdZIqTs2hx/
 DMEVO1Dyo5DDmKL9FwYMteJQvxzoOz2cSVelpJPfGQ6M6mKUJjhttRqMwddW6KnzulRaUMrj/
 dV4cmM/qOpQzIo=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 17 Nov 2021, Phillip Wood wrote:

> On 17/11/2021 15:55, Derrick Stolee wrote:
> >
> > On 11/17/2021 6:20 AM, Phillip Wood via GitGitGadget wrote:
> > > From: Phillip Wood <phillip.wood@dunelm.org.uk>
> > >
> > > Histogram is the only diff algorithm not to call
> > > xdl_classify_record(). xdl_classify_record() ensures that the hash
> > > values of two strings that are not equal differ which means that it =
is
> > > not necessary to use xdl_recmatch() when comparing lines, all that i=
s
> > > necessary is to compare the hash values. This gives a 7% reduction i=
n
> > > the runtime of "git log --patch" when using the histogram diff
> > > algorithm.
> > >
> > > Test                                  HEAD^             HEAD
> > > --------------------------------------------------------------------=
---------
> > > 4000.1: log -3000 (baseline)          0.18(0.14+0.04)   0.19(0.17+0.=
02)
> > > +5.6%
> > > 4000.2: log --raw -3000 (tree-only)   0.99(0.77+0.21)   0.98(0.78+0.=
20)
> > > -1.0%
> > > 4000.3: log -p -3000 (Myers)          4.84(4.31+0.51)   4.81(4.15+0.=
64)
> > > -0.6%
> > > 4000.4: log -p -3000 --histogram      6.34(5.86+0.46)   5.87(5.19+0.=
66)
> > > -7.4%
> > > 4000.5: log -p -3000 --patience       5.39(4.60+0.76)   5.35(4.60+0.=
73)
> > > -0.7%
> > >
> > > Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> > > ---
> > >   xdiff/xhistogram.c |  5 ++---
> > >   xdiff/xprepare.c   | 24 ++++++++----------------
> > >   2 files changed, 10 insertions(+), 19 deletions(-)
> > >
> > > diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
> > > index e694bfd9e31..6c1c88a69a1 100644
> > > --- a/xdiff/xhistogram.c
> > > +++ b/xdiff/xhistogram.c
> > > @@ -91,9 +91,8 @@ struct region {
> > >   static int cmp_recs(xpparam_t const *xpp,
> > >   	xrecord_t *r1, xrecord_t *r2)
> > >   {
> > > -	return r1->ha =3D=3D r2->ha &&
> > > -		xdl_recmatch(r1->ptr, r1->size, r2->ptr, r2->size,
> > > -			    xpp->flags);
> > > +	return r1->ha =3D=3D r2->ha;
> > > +
> >
> > nit: stray newline.
> >
> > The only meaningful change here is that you are relying entirely on
> > the hash and not checking the content again. This means that hash
> > collisions on this 32-bit hash could start introducing different
> > results. Are we worried about that?
>
> xdiff-interface.c limits the size of the file that can be passed to just=
 below
> 1GB so we are safe. The other diff algorithms are already using this
> optimization. (the hash is 64 bits on most platforms, the xdiff code cou=
ld
> really benefit from a unsigned long -> size_t cleanup)

I think the really important thing to point out is that
`xdl_classify_record()` ensures that the `ha` attribute is different for
different text. AFAIR it even "linearizes" the `ha` values, i.e. they
won't be all over the place but start at 0 (or 1).

So no, I'm not worried about collisions. That would be a bug in
`xdl_classify_record()` and I think we would have caught this bug by now.

Ciao,
Dscho
