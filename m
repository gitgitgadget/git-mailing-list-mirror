Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EE751F453
	for <e@80x24.org>; Fri,  3 May 2019 09:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfECJcs (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 May 2019 05:32:48 -0400
Received: from mout.gmx.net ([212.227.17.22]:45105 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727010AbfECJcs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 May 2019 05:32:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556875953;
        bh=Xbghj33UMlCMESxHSqaeIjoKCMFT/XnVRQNqcVSHrHY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HxjfAEzbXEDPV7YN8NkZkWksCJq/4CHrb/qFWfgGkT2VaqRge7z5QV94FKEqcQU8X
         XL75oTlYu47o8LNFGExKQ8SaGFWjAUKE9BiXK2YR1Y3qzwgM7mVe+79wZa8qMlwVGX
         D0NfCrqtdwgfJRn8Ha+Mh7M0XfY36o88OgtzYsj4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.171] ([37.201.192.51]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Me4Ly-1h6cf91vIc-00PwRd; Fri, 03
 May 2019 11:32:33 +0200
Date:   Fri, 3 May 2019 11:32:32 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v3 0/4] remove extern from function declarations
In-Reply-To: <20190502000422.GF14763@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1905031127170.45@tvgsbejvaqbjf.bet>
References: <cover.1555352526.git.liu.denton@gmail.com> <cover.1555487380.git.liu.denton@gmail.com> <20190422214901.GA14528@sigill.intra.peff.net> <20190425120758.GD8695@szeder.dev> <nycvar.QRO.7.76.6.1904301919580.45@tvgsbejvaqbjf.bet>
 <20190501100108.GA8954@archbookpro.localdomain> <20190502000422.GF14763@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1880418932-1556875954=:45"
X-Provags-ID: V03:K1:Rap2woXhAH9tXoNLgURFhwPCVG2t2kfgVp58O9MR2PQDFdoiudx
 jtgPmwAjQ0TG9qTmhLB2uMIUU4bYEn7+emj0g1Xc37jLFmtYnM8Pqa5uz1bm0PxYWckAfHA
 VBptOxBBxEpnCtLPsj0UFGOqxvXDKLaCf/1CqWcwioKYztkU3S+HaMu4wZy4DUbjwRBiR8F
 ClcTOGfposvpwPu0qRrjQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ubcvcc8GIiY=:8R6Pw8Ag/YnLgBVx3gR8Gs
 mWieFM/3KHVq8Lz+4X2wi6VOfG+PGyt65yBJ3tzgU9tD7WyrFKGpY/8HxunJsv3BrABFRh0ov
 y6e31tq5tOCk7UVqU57eW+iWDstebneMD59U2OHxQt0iflDG4XJVP/qaSsF32zRW7Cw6rHWgN
 ZcQMWMgmpDtzFmULJDoC3ybSxt6afMlRjf55j3+ctYC98KYMrO8KlOI+IBFsDEvnfqH+Cc5C3
 uAwaHvzTbU/BMghdeBu0elnM8xt64jxA2VdDgQb+1U/VsZdbrW8xo17snykCVkxaeT2CdS71l
 Jhhit2mID93JhOSXzw8s9+l7bjeYHyIW/xe7KT0tla8aIjA7MbzefXDBcl8OCqx8PCMr/KtOA
 Ln71vtOtZ5LcESWV/t5l+vzPPboqnDw8S5gwoPpbaH+KYvS5LvSYcLBXlcooTyO985059GbJU
 YNh8VaA1mxVIBP3hWR/caIOpk01zuo2f1uDbYkaZazqCnF6Z736W2f+MGOY0Bqs4SJB1zN9Mc
 2OWZgIZRqKeYXIyOgTWJNiRpEAWwLZU3mZ3Hp4bmj5YZCVPezlwc5EXpAHthQzaHYJztP4Djp
 SHunWans18ldYGvmmMZzOBC/JyLwzG9RJUu979NRu5y5BTAKIYSiF2j60ZmlbHvwmZ/jCrwms
 L6ZQbJ/LKYLsWUIAesY3bo/pZzBxcZ8LCxNaQp8MjrltEGkvEFAY7tKq1a9SQYUxNQiLlNMeW
 pfDWDpDkVZF8wQCD+c/wVr+aApXMRAycC2DPyKVNLNzYnz0oeXONIQspeh/0OYPz4MRNgYKoj
 13TcLndFiYutsHsqUQLsyOABg1rXuuYRfp4MlKlUnNfA6jFTwFb4Y2mmxWcKxM1GnGob7Js1z
 DxPlOzmCOT8lu+jRxtt5B8wHSmemcjfDEIuzLoImaDP+UpgVidZPLjubwQ1pTbVWFYRjM5M+n
 zNWo9TpmCSQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1880418932-1556875954=:45
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 2 May 2019, SZEDER G=C3=A1bor wrote:

> On Wed, May 01, 2019 at 06:01:08AM -0400, Denton Liu wrote:
> > > Is it not possible to exclude certain directories for certain semant=
ic
> > > patches?
> > >
> > > I guess we could also simply declare that *all* Coccinelle patches s=
hould
> > > leave `compat/` alone, on the basis that those files are likely comi=
ng
> > > from some sort of upstream. But then, `compat/mingw.c` and `compat/w=
in32/`
> > > seem not to fall into that category...
> > >
> > > Ciao,
> > > Dscho
> >
> > Deciding whether this is a good idea is above my paygrade ;)

:-)

As a software developer, you surely have an opinion, though :-D

Thank you for the patch, it is a good conversation starter in the least,
and I hope that some variation of it will even make it to `master`.

> [...] what about 'compat/win32mmap.c' and 'compat/winansi.c'?  They look
> like "ours" as well.

Indeed, this is probably a good indicator that we'd want this to be an
opt-out, rather than an opt-in list.

For example, we know that we want to exclude compat/regex/ and
compat/poll/ from the `coccicheck` target.

> FWIW, out of curiosity I've run 'make coccicheck' on Linux with
> 'compat/mingw.c' and its friends explicitly added to C_SOURCES, and it
> seems to work...  it even found two places in 'mingw.c' where
> COPY_ARRAY could replace memcpy() :)

TBH I had not even known that those files were excluded from coccicheck by
default. I had assumed that all of Git's sources (and not just the
Linux-specific ones) were included in the target.

Since you *could* include it, I now assume that Coccinelle does not need
to follow the `#include`s (otherwise, it would have complained about not
finding the `windows.h` header in your setup).

If this new assumption is true, I wonder why we cannot make my former
assumption true as well: why not include *all* of Git's `.c` files in
`coccicheck`?

Ciao,
Dscho

--8323328-1880418932-1556875954=:45--
