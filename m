Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A98181F461
	for <e@80x24.org>; Thu, 27 Jun 2019 13:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfF0NEO (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 09:04:14 -0400
Received: from mout.gmx.net ([212.227.15.19]:50459 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbfF0NEO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 09:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561640648;
        bh=7SbNShYIcVj6zy6fdBJvPtVv8JfAGhFI+0534XYymiY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=VM3getbUwcfrvz94RoMCcGUsXW93NgfEfYV/H+GxqK409+wI1egXnYOGzj30GKqtl
         ypETmO1+gcEu+h5Ww6IVJJDs5RypmiVPEyEABS6a5fMkWIEAZ61M8t2R2lZOUY3s1z
         wvFgpJBmJPyoO7MgcesdLk0OnNUcGQMY5KNIDcxE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Ltr89-1if9FF0xWv-011DvW; Thu, 27
 Jun 2019 15:04:08 +0200
Date:   Thu, 27 Jun 2019 15:04:29 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/6] Kill the_repository in tree-walk.c
In-Reply-To: <xmqq5zose00p.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1906271458240.44@tvgsbejvaqbjf.bet>
References: <20190624095533.22162-1-pclouds@gmail.com> <xmqq5zose00p.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-105596653-1561640670=:44"
X-Provags-ID: V03:K1:Ez1RjA0WIB7aHNdyuojRjoan+DESdkvCH2Rt1zErJ275CDunelX
 oXscbOL3UP7IUwW3tzbJvFbEmifBMJ9dFhmMXVCkcciaYYNoLummT0L5m2lyBEofjTdsGwE
 f+767Aa+BNI4sVv0+97XrcA31wO0R/LKtKYeXg2/e2OjIuWQwRgF0NffARzK7Mpy0lwgXhP
 QesH0eYeaGQ7LWU3KObPA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xBlQQaTjyyM=:Xa0nyBfNzGyk5oCWxD0cOC
 P8whqZDXqcNv5G18mX0iD3pLqze7vqkJlGjXHGLQPC6VNFTZge9FGk260xbLxgJDZEhI16sSE
 yJzXBmVmtZ4Oj4dNgyxjphHh5+onGJmMN5ElNBEw84zmIP7++mk+cChhc+ZAfwBvAWq0NC1n2
 DX21JNnJ5WOscIr1UQpCEd/su963lP1m9EXXhus/ZaAhaWZG2nZAAdtLmF+9hkn9sPaE3KDQ4
 5No+cN+gC1FjUMkvqM5Qee1iSD3w6qFgUE7/G8O/fawMOh7mxxOUXDFBP3JLZZ1FZsdPJognB
 RFZ0e2gZpHehrLcaCHsCCDdr1+QW3g9OpatFCMKmh+J6O4ZPLyCGXuzmP0tteyoPbY8Mtx/sV
 bvkNNCZ++g5mBhYIXEZOO9XJ0dDmfpBGUNxtdxJj+/kxep5RWXT0pi1VThkwEJdGIGZ0P+5wl
 8QuQgmhGTw2MQ520OVy9i/MskuTbGegc66C4GE2qurAZm++Aph9uGZCE7eK283P8S+7fgLvMN
 znLexJjtQLvtCoNgk6F80mfcTL4AZYmb5TRQ6EzCl0Z4Nrft2ZWxIkHN+p/NOStfANj+/Bw3n
 emKxgIVmNzuOiOlDp7WId3hMd4d3s+JY1zV5QaNKj+BfFGHTzNh3rSR7JTM7EVHoFYIO4jOnT
 ufCALo1zKwD2ANzNWMxgMz3m8ZTphZL5SFptkUqePNmQIJ7hwr6SqNSI1f7Lhj3g0j/PVWWku
 cZwX6BZt8IIwUpy2w474ykUGCyucXLTVQCN2NXUokGFj/bNvs8AMPNy6iKTUQ17x5HDPIsvEp
 yv1cI+I/e9EpCiFFQGv/vG/lZ5Sp1lVMeM7F+34+/FRPb/1auNh7uycapbNtv8cH4neKSC8+T
 NakYsAeK/NyH+oF/xH2v32Y3nNKioYlJOqTBeRKIzjBjU1709GKZ65fQkBu5fxvkfxVqI4lmr
 lDxtMDhJPg24bQbV1RngFc1HcyKjShlJB+45o2yK/LTxUf4s+MCB9hhd8TWwkd7LcdF7Rg+DC
 cUP1aGTBuXdx7CwoP/zPq4uWG4DqTR79HHhWFPpgNZrLdKtC/JePEfItcyrjDupnFXsFIW1zm
 AZGw5pZa0XhuF2btdAsnxKp6w2VOtptXm7w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-105596653-1561640670=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Wed, 26 Jun 2019, Junio C Hamano wrote:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
> > This is the continuation of nd/sha1-name-c-wo-the-repository. In that
> > series I sealed off one place in sha1-name.c that cannot walk trees
> > from arbitrary repositories. With tree-walk.c taking 'struct
> > repository *' directly, that check in there can now be removed.
>
> Thanks.
>
> With these queued on 'master', t7814 seems to become flaky (tried
> running it with --stress, with and without these patches).  Are we
> touching a wrong index file in some codepaths or something?

It's not flaky, as it fails consistently, and yes, we're touching the
wrong repository in at least this one code path. I think I would have
wished for a more careful conversion in this patch series, as it does
touch critical code paths.

Given that this bug was only caught by a failing CI build, it does make me
wonder what other bugs are hidden and would slip into our code base just
because of gaps in the code coverage.

Ciao,
Dscho

--8323328-105596653-1561640670=:44--
