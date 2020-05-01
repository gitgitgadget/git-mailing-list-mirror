Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D86C35280
	for <git@archiver.kernel.org>; Fri,  1 May 2020 20:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D58362137B
	for <git@archiver.kernel.org>; Fri,  1 May 2020 20:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="L7t0ejFc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgEAUCj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 16:02:39 -0400
Received: from mout.gmx.net ([212.227.17.21]:53611 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbgEAUCi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 16:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588363352;
        bh=39ZyXU0Sx40mvJQQ4IORhnrIgWiQMYegeXhcJqCvYKI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=L7t0ejFcHx6oqTOrJTTg4OFv8odT6Lxk0IRqD5im3OWTsvN3m8ZqeMtX8eAWqlcfB
         i9eydRFQM98E394rdzUUMBUmsn6qzwlfsDgn89OepjvA9NTMBoF6yuh+1on4ihslkN
         xqtoQU0Hc4taGr6bz9XFxlN8VL0jDDQ/LzvbT5cQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.213.255]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N63RQ-1j6P3H3XAW-016MOf; Fri, 01 May 2020 22:02:31 +0200
Date:   Fri, 1 May 2020 22:02:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
cc:     Danh Doan <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/4] fix make sparse warning
In-Reply-To: <45522b6a-76a4-a7d9-3cce-a3581aaca899@ramsayjones.plus.com>
Message-ID: <nycvar.QRO.7.76.6.2005012200470.18039@tvgsbejvaqbjf.bet>
References: <cover.1587648870.git.congdanhqx@gmail.com> <nycvar.QRO.7.76.6.2004251511550.18039@tvgsbejvaqbjf.bet> <20200426033201.GA14800@danh.dev> <45522b6a-76a4-a7d9-3cce-a3581aaca899@ramsayjones.plus.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1354744668-1588363351=:18039"
X-Provags-ID: V03:K1:eNd/jAMX9iTRLBGe/TAIGsOavP07qBU3ZraUfUyR8q/JUoAV4nn
 dxYzNBcj/v+IQzovA80tQe/4PPjTmGkcslHFN/Dd6GjI2ADnqgO/dWH/0bRVYnUEDOOHTqo
 VwhImFCu7IKr92rv1WqBJV0FERDmkdj4/R6OM02Tb2k9+xumh93bSXBv9xJmfJFfQT2Vpaz
 uHdU8AQWBwtIkqg9QkMEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cZVvNzVPPd0=:/WSYujm1Fq9kRJNjd7HkBT
 Y0Lk/BalGVyQvSmX4hAUJYHLKGyAIC2g+krQ/R+BUJ6mhca6Spv8pGg6I4HHJ4cnaXVat8lI0
 Vtsf8+XLcvrgYupEsNvhvZGlUyjBxM0AtMTPGDjI5IVmt/reBnmcpAq7CgiE4QgrE5jh0DLQV
 FsuqYSQEzbDwLLmisT5J6Xcu+4s2yCqtFpTa2VCIv16qmv8NP/fOMgdoHnY6GKd7IOXoIdiVX
 TTMkz2nlphLSzaLkwCBIJICMZAY3Yk3XkLfd03sm0RxcjLIVA0poHFlvcXUF3esRh538sCOln
 kpIyMMfyto2QYFjDniN/rWIz10DtAU7njYqz03JxGQ8uENFo5+VULCNjiJ+KqcRY8/MYtEgz9
 r+d02bhV2LknYHJyLqBZSBkfJy3Sw4APsYOnegIiTg654+TS9RpE3yVlA8f5XZysUfcKLcJof
 mgz0t22XqzlNx2JP3DN/wu5Oo5qPLk1u/PaSnbahMVzDUyzHY4xYxwUKx4beFQL8m51BdarIT
 z1WfjEU6qaXC/Wbi8PqmZGmL01EQdP/oj8CTBhgjBr2zxqsFLr0x7Ab1dWPKJpQge56C1cZMx
 zcV/ka5XUofBbnqJ7zSCGdM3nYGYCgzZ0oku6LsTRxQgochT73hG6ZdMxQ5iJe53PogCslmN6
 dYISdIn3+KWWSelIYCuqnX/7CCUBpozbnVYh7/p2BeqRlQIXtZCWjjyxLvtl0QEFl8lTIz3ry
 nGOVE4BSVu8PyQNAMAqoyhresBIesu0eLktMH1gp+e7Sb5CwW2T5a1mJByataqGXJxbs6f605
 1fSNbGcP3FpVC4DjOzJbHvKP4Tcs19YyNyQP9s+vn/T/btSZM5RKHlUFeTpYhl4jvz9F8zvms
 CU2a1M9g94zp7X1J8PxaKPUR+nnvqMnGCtLmwBic+7hmRHUQunZoMBz8WcBFcgP9sYqRL6C94
 jpvI8MNHF0RaL/qzKleDg2tcvQIXqNOvZGU5WElEYqDEYQ4iH4x3QnpsfpzC+R9Gf4Z5SSx4l
 fjRJgCuK78Bwb3zWtQSfEqzo37I7o2t1dr0YrmJ3zszS83aDBU2Z18YLboL917ycoIlSg84ZN
 J7jnxJR/TRU2uKAyODJw/7Q8xfJ7rtWP69wxVtyFW7AafQH8QyWGUsv+TFa+8IKhtHy3ZBgop
 7dPUN1FiSCUSVJH8gfXV+0NkYLqDfL15RR27ZjkJxZmi1M0SpzI3f3Pk+gSmdc5rbULoR0lg/
 wwXxgs3QKjTfz29ER
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1354744668-1588363351=:18039
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, 26 Apr 2020, Ramsay Jones wrote:

> On 26/04/2020 04:32, Danh Doan wrote:
> > On 2020-04-25 15:13:53+0200, Johannes Schindelin <Johannes.Schindelin@=
gmx.de> wrote:
> >> Hi Danh,
> >>
> >> On Thu, 23 Apr 2020, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote=
:
> >>
> >>> It's happened that I tried to run make check on project that support=
 autoconf.
> >>> Git's Makefile told me to run `make sparse` instead.
> >>>
> >>> I /think/ if we have a rule in Makefile, we should adhere to it.
> >>> I also fix another change in ds/blame-on-bloom, which I think it's w=
orth to
> >>> fix, see: <20200423133937.GA1984@danh.dev>
> >>
> >> FWIW there is still an Azure Pipeline building `sparse` for Ubuntu ev=
ery
> >> two weeks: https://dev.azure.com/git/git/_build?definitionId=3D10&_a=
=3Dsummary
> >>
> >> I created this Pipeline in order to support the proposed project at
> >> https://github.com/gitgitgadget/git/issues/345 which is: teach our CI
> >> builds to run `make sparse`.
> >>
> >> Maybe it is time to tackle that?
> >
> > I don't think it's ready, yet!
>
> Heh, not too long ago, the 'master' and 'next' branches were 'sparse cle=
an'.
> (on non NO_REGEX builds anyway, and even on those for some of us. ;-) )

Maybe we should spend the time to make it "sparse clean" again.

Of course, that would mean that reftables would have a ton of work in
front of it (not that it does already...).

> The 'pu' branch was frequently 'unclean', of course.

But mostly because there was no automated job to tell contributors about
it.

Ciao,
Dscho

>
> ATB,
> Ramsay Jones
>
> >
> > May be it's.
> >
> > But we'll need
> >
> > 	make sparse |
> > 	grep -v -e 'plain integer as NULL pointer' \
> > 		-e 'redeclared with different type'
> >
> > The first one for:
> >
> > 	struct foo val =3D { 0 };
> >
> > to zero structure.
> >
> > The second one for different in declaration and definition (which is
> > fixed in sparse's master).
> >
> >
>

--8323328-1354744668-1588363351=:18039--
