Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC29C433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 09:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75D5560FED
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 09:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhKDJbt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 05:31:49 -0400
Received: from mout.gmx.net ([212.227.17.20]:49763 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230363AbhKDJbq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 05:31:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636018145;
        bh=b+wK5xImxEgsL8MKf2uNgsUa2sYjaHO6HxnQgA/1goM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GUx1gBReI3IqaOh6Kou26gSs7ARc/tW9pMthaA18XVUG+cyIEGU5Be+dv+NKT0JWu
         yOp9M+64GmXIwFKW1m0QX/dOYxAjH+3kun9JcJDhcfEGT6U4JemYXhxyTvDhaIWThm
         PWGLBiZrKT46/Xl7//ofH1nzigRR0Cdo+9676onI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.119.151] ([89.1.212.10]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MacOQ-1mAsvr2Kok-00cCjj; Thu, 04
 Nov 2021 10:29:05 +0100
Date:   Thu, 4 Nov 2021 10:29:04 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eli Schwartz <eschwartz@archlinux.org>
cc:     =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] pretty: add abbrev option to %(describe)
In-Reply-To: <nycvar.QRO.7.76.6.2111040018240.56@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2111041028170.56@tvgsbejvaqbjf.bet>
References: <20211024014256.3569322-1-eschwartz@archlinux.org> <20211026013452.1372122-1-eschwartz@archlinux.org> <20211026013452.1372122-4-eschwartz@archlinux.org> <YXfvY3n9wEwctjUR@danh.dev> <43fe6d5c-bdb2-585c-c601-1da7a1b3ff8b@archlinux.org>
 <nycvar.QRO.7.76.6.2111040018240.56@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2062448435-1636018145=:56"
X-Provags-ID: V03:K1:1B56ofklZuG1XTxUgOzATzd9elHSRIBUzRbBXQdwfox7qQD96V0
 JARQT41PW4RmeOIneEmGmuuyaVPvEEWatMBzc9KMYKT8lKVxn9z9SJ4ivA0q7nbVkfywI+m
 XJ5OnwTF7eVNE+wRzE2CRfOwhKU8eKvRnoxM9uCxEueFH6TFtfaPNVZdnxOyPGpAbVa1+zq
 hvDejeWOo+qGdjfPrtcEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:K68vbWYrpRU=:lPSDME+RSRDAfYEo+6wD9q
 afVKEDXv7GveWwkDe/shc8juO8ddD7GtphGXUTEM3IavA7US4ic8aOLjGZ3qFFzHngePDUiXp
 hV7TFCmD3XsEaxVce0cioApH0wKMpZXE8wQDfYvlD2sUGnZ2Ei+TrnHL2Qt+dOTA0d+PWfm3+
 1EvrrhjfU31Kwdnc/0cyiV/f6txpPHe20qZjQGYVdavfvOgTqovsiXtyeUYGxiTqXBndM8YK/
 vQhkczzoj8LguKmirH5JfF/fD1Sj7UlG+4DegBeAqIoQuL3WiOBpKIUpfY8FNbazZexk2TKE7
 Oa6Q26ifo/XvPGGW0yosmJ7vYVfxgGHBgKzTv66jy/Tms7wE8DNdIjGUUynXsWqv1Saxh9cpV
 d4u9hWRG6xd0L5mmrmCYLSVP6nSINdC5D8eZwXSWhAtFf3+Z3RX0ZN0KfxYmdOW1XhFBMFdNE
 CsCySuIxWkChibJK31ZQO+XDQ4v92TDZEFm4Nt5s6SiWy3IPAPYCo2v2Tiq9ex5yxzV3G6cAe
 5Em3adG7wN/SzQB+X3zSMPh6fgMCB/pYIY82NUJOjGTkoFHyEtrI4OCRZifHr4C5PzAxb4Bkt
 MVAHPCtDndlbcio/zNXHyLInrQbV90CISUj14Eq9cxDADdpGP1l1FfZW9LVWpZEGAhEL507ik
 iB5tgNpy6PlqyvpTHEVlfkP4o4SkDmFuvQb5TAfKCY2bptL2wA854dtDrdx9ac1CH57KoLwZe
 loGR/270/knKNVjL7bQbTWb+k1Lb77+UNsFMzyjnmACk1BfzQLD/TRuq+Xq6ML4Olg7hj2NIJ
 I+YlLl2Wf/eEUnvh+W7pw3isZBQvOdHmWLoQoIseVVtFeAq83qP9Hzsoc6+uacLgsY++WOx/F
 W2ySh+m5kr9HZ3g134lg9ZkyCzTtO0/3wABmXLdhn07FZlXavjj962h04ZQBTNLEFQJE6vfEf
 c1JI5Q3se4QGy7+QitK/ILW6U6iXPx6QzhFPnNDli2yuArYJRlYGo4d2scKjFgSAGuJNrKa2A
 tObKfFDyEMgKC+EexdgsZ99YF3sF+Cnuw5Jw9R6+wb3ubkUM+jDV3wU0RhXoR7r2HirPEZytH
 bfy5uCc7kukfE0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2062448435-1636018145=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Eli,

On Thu, 4 Nov 2021, Johannes Schindelin wrote:

> On Tue, 26 Oct 2021, Eli Schwartz wrote:
>
> > On 10/26/21 8:06 AM, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:
> > > Other than the question pointed out by Eric,
> > >
> > > with DEVELOPER=3D1, -Werror=3Ddeclaration-after-statement
> > > We'll need this change squashed in:
> >
> >
> > Thanks for the advice. In v1 of this patchset I attempted to do a
> > developer build but failed due to preexisting errors:
> >
> >
> >     CC run-command.o
> > run-command.c: In function =E2=80=98async_die_is_recursing=E2=80=99:
> > run-command.c:1102:9: error: =E2=80=98pthread_setspecific=E2=80=99 exp=
ecting 1 byte in a
> > region of size 0 [-Werror=3Dstringop-overread]
> >  1102 |         pthread_setspecific(async_die_counter, (void *)1);
> >       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > In file included from /usr/include/openssl/crypto.h:415,
> >                  from /usr/include/openssl/comp.h:16,
> >                  from /usr/include/openssl/ssl.h:17,
> >                  from git-compat-util.h:309,
> >                  from cache.h:4,
> >                  from run-command.c:1:
> > /usr/include/pthread.h:1308:12: note: in a call to function
> > =E2=80=98pthread_setspecific=E2=80=99 declared with attribute =E2=80=
=98access (none, 2)=E2=80=99
> >  1308 | extern int pthread_setspecific (pthread_key_t __key,
> >       |            ^~~~~~~~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
> >
> >
> >
> > My system has a custom compiled glibc from git roughly around the 2.34
> > release (a similar environment could be obtained by using Fedora rawhi=
de
> > I guess), and this commit looks mighty suspicious:
> > https://sourceware.org/git/?p=3Dglibc.git;a=3Dcommitdiff;h=3Da1561c3bb=
e8e72c6e44280d1eb5e529d2da4ecd0
> >
> > For this reason, I did not bother to try testing v2 under a developer
> > build, leading to my overlooking this issue. ;)
>
> It seems that this issue now hit an official version. As I explained in
> https://lore.kernel.org/git/nycvar.QRO.7.76.6.2111040007170.56@tvgsbejva=
qbjf.bet/T/#u,
> my colleague Victoria Dye will send a fix for this later.

FYI here is the patch:
https://lore.kernel.org/git/pull.1072.v2.git.1635998463474.gitgitgadget@gm=
ail.com/

Ciao,
Johannes

--8323328-2062448435-1636018145=:56--
