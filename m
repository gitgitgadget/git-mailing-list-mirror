Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EAAC433EF
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 23:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5F08611C3
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 23:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhKCXXR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 19:23:17 -0400
Received: from mout.gmx.net ([212.227.17.22]:46677 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230479AbhKCXXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 19:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635981636;
        bh=cG1fv4r8F78oDoDmj56tSFBlosE8DxNSXS5dXPsXoDk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=R2XS+KTrBNzLdABzBkS/MYEoORCPnyeNnhVZ74UodHJVvxPqlpXPKpmq9JoaKCofx
         OqnCwvCpeyhSWJ7ZfuKiXNf/DvBBdwHHQ9aAXk0WAchb2b0MyEDskgEuw5gRae8guC
         z9ESRSP/7RGf5gyurHJjNJxxoaBTJ5KoqYAHQwWk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.119.151] ([89.1.212.10]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MowKc-1mPJda15qQ-00qW0x; Thu, 04
 Nov 2021 00:20:36 +0100
Date:   Thu, 4 Nov 2021 00:20:34 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eli Schwartz <eschwartz@archlinux.org>
cc:     =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] pretty: add abbrev option to %(describe)
In-Reply-To: <43fe6d5c-bdb2-585c-c601-1da7a1b3ff8b@archlinux.org>
Message-ID: <nycvar.QRO.7.76.6.2111040018240.56@tvgsbejvaqbjf.bet>
References: <20211024014256.3569322-1-eschwartz@archlinux.org> <20211026013452.1372122-1-eschwartz@archlinux.org> <20211026013452.1372122-4-eschwartz@archlinux.org> <YXfvY3n9wEwctjUR@danh.dev> <43fe6d5c-bdb2-585c-c601-1da7a1b3ff8b@archlinux.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1443130748-1635981546=:56"
Content-ID: <nycvar.QRO.7.76.6.2111040019230.56@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:a8oBv68FG6k0bPhmYpAjlZpfzD1JxKFO7Ul0TqvO4MMCtANmKYi
 x4azJHl1eHrL8Gh/5kXQzHCjnf/yC5eF8/pdPDhj0iITbqeMO4rkmBuG7s0eZGLuC6NUpJe
 Sgc63LbFr0Ib2lweuhRKiGzKT2b5NP/9AgD3dbLlwCeRLixFUTqhYGa8QrzBVtltxLef0Ll
 5PMmaBT3IJ94fY5Sd2syw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LkaV4VtJoAs=:MWhpUf+BzblKTi3Uf/IyEJ
 zcbw/47gtQiqstQQUfme/cbIvqypzFCe0vmiIl12IcunGIUFn7+ugyddqShM/xLL1Th5FHbQQ
 1hZxA9z+T6wO20mHCA1XVhq6+C6NcjpH2l+JhuIpkCCg3gyJl9LqTdlxFv9kiqojUZoVQXvQO
 E+siNEAw73jaUW5h6HvzCKLkrduTP56iwhVfqTB/jCcKzUspfuX1806D03CqCspGX/MyT0+pv
 VKEPTQzmZhGRXYtKcKZylgpX7RWDGAi4WUGqooIkR4ERw3319tQR0W/TqsDNsoRKZ0NxEw/y1
 xT7BtnwrXoS0PV1WtqaoTCaIxQ2HXHWZxlROXO5uV2SyzRlsqshvWUO7UbX1+eAmfK6gKNuCB
 DXlo5l8YvhEhuLz+/9Rgtt93kO0zQ3QPJQW20cELpOiVitKxHpJGBWCmHEMamNa4TMV/VF4iG
 ZOqu2SIhBSibPYwcaDb4YnqTdRHeYh5BiyLij9OvdTzcdVyOSBqidx+L03l+xgmOPg5jOS3mM
 pjuegDEibpcrw5NT1zcpFkNchYkfc3QxlggWYqPGLDOWDNYmeWp6U5xbU9AJN4kaJf547qtLw
 e7MLtfRIsFrTHxTwGbMsW3A8iI7qLd5/ILDI7Nk0rBZqx1veGj1zgdC/fOqn/Nh9XpA5+KFWX
 iT8dj/S161OUevzkdhRQnrdTZmiNlKzBMJNHfiL7woMgq6cOzEvOgMqpIqqY0M9g3RdAjLW44
 rrnlb4U81sghIeTQafTrQEDjdrVU2q4adRcDDd5Fnzw/bP3i2KOZ6uaUkdiy148unkU7w1KmW
 8LMFUE73oezRNxOGTZo8pCdIVj6hLSMe1xdw4FS9eAKl1Sa6ka1bPNA8wq1wNiysRMJPCQXqy
 zIOxgCC7GwZCo/SLnfWru0Kpenlrxref9PHiB618RBFoCA5PLMdi5f2OKffHgEdj0R4jpXPVM
 rLt46oCjeDWdzArKImByLGhUpwvAabOejO0u4WCvn1pVUADdGSasY6GO8wiZqvzgiKDNEqJL3
 7a1HMkozV8CGLK6Aefi5cS8lnOjMFnGj70lzeEeIYJxspzm6ajlmBk3kr8X7bNtdEc3rA9g2i
 0HJy+bwIyPPc4Q=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1443130748-1635981546=:56
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <nycvar.QRO.7.76.6.2111040019231.56@tvgsbejvaqbjf.bet>

Hi Eli,

On Tue, 26 Oct 2021, Eli Schwartz wrote:

> On 10/26/21 8:06 AM, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:
> > Other than the question pointed out by Eric,
> >
> > with DEVELOPER=3D1, -Werror=3Ddeclaration-after-statement
> > We'll need this change squashed in:
>
>
> Thanks for the advice. In v1 of this patchset I attempted to do a
> developer build but failed due to preexisting errors:
>
>
>     CC run-command.o
> run-command.c: In function =E2=80=98async_die_is_recursing=E2=80=99:
> run-command.c:1102:9: error: =E2=80=98pthread_setspecific=E2=80=99 expec=
ting 1 byte in a
> region of size 0 [-Werror=3Dstringop-overread]
>  1102 |         pthread_setspecific(async_die_counter, (void *)1);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from /usr/include/openssl/crypto.h:415,
>                  from /usr/include/openssl/comp.h:16,
>                  from /usr/include/openssl/ssl.h:17,
>                  from git-compat-util.h:309,
>                  from cache.h:4,
>                  from run-command.c:1:
> /usr/include/pthread.h:1308:12: note: in a call to function
> =E2=80=98pthread_setspecific=E2=80=99 declared with attribute =E2=80=98a=
ccess (none, 2)=E2=80=99
>  1308 | extern int pthread_setspecific (pthread_key_t __key,
>       |            ^~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>
>
>
> My system has a custom compiled glibc from git roughly around the 2.34
> release (a similar environment could be obtained by using Fedora rawhide
> I guess), and this commit looks mighty suspicious:
> https://sourceware.org/git/?p=3Dglibc.git;a=3Dcommitdiff;h=3Da1561c3bbe8=
e72c6e44280d1eb5e529d2da4ecd0
>
> For this reason, I did not bother to try testing v2 under a developer
> build, leading to my overlooking this issue. ;)

It seems that this issue now hit an official version. As I explained in
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2111040007170.56@tvgsbejvaqb=
jf.bet/T/#u,
my colleague Victoria Dye will send a fix for this later.

Stay tuned,
Johannes

--8323328-1443130748-1635981546=:56--
