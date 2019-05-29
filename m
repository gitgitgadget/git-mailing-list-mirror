Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1AC31F462
	for <e@80x24.org>; Wed, 29 May 2019 18:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfE2SKh (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 14:10:37 -0400
Received: from mout.gmx.net ([212.227.17.20]:45165 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727626AbfE2SKc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 14:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559153425;
        bh=gqZ2rFFUqkQdVGVR9HApJWsquSMT6P0EzVxGnSiThZo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=M8M5ExaXIO2GaY6cljGqYYC2xedBmpHb7nOqSAcWj4Ix4KHP6J6ZZtGfNvIKp0ehS
         9/4hVULgriOSFbZ43kguXgPzsGQdElBnYviSbpfwt1y6cjiZXKiQ3Q8sygwHoSgKfb
         gP+3nWA8EMN/ywz8r473F1MoR0AmYj0byzQFlKHg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M42nY-1hW31t1VR2-00047P; Wed, 29
 May 2019 20:10:25 +0200
Date:   Wed, 29 May 2019 20:10:09 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: Re: ab/send-email-transferencoding-fix, was Re: What's cooking in
 git.git (May 2019, #04; Tue, 28)
In-Reply-To: <xmqqh89dyxp1.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1905292009030.44@tvgsbejvaqbjf.bet>
References: <xmqqtvdez0yo.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1905291424140.44@tvgsbejvaqbjf.bet> <877ea9mo98.fsf@evledraar.gmail.com> <xmqqh89dyxp1.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1044786231-1559153353=:44"
Content-ID: <nycvar.QRO.7.76.6.1905292009210.44@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:01/w8ewtV1G8d4Jd7QvsFjE/opnK9S0yqjeFrXrA43nGaxhTwp7
 kZprczYpq2ZDhE6DohfanD8PaDn5zCFIRijRZkmj3zi3JWeCjNbcFDH/yKwCI3DkuOAoDDd
 HUZZzatGH+fjY1G7BbxqtECrv3ZLodGeEYsAFlVnY72T5R/dsdlqv4vFVvir+Ms12qr6XUo
 DYPtoWSbmv5yeKfUyA8qQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z4LNWivzb9s=:zfBfwkJIA6CTvDaLkhtKz/
 QKNSZCQGVjB0mKepq83v3NRIs7GfmOBYjSoEqXBPrVFw/VoAaIjZiwDVarhTU/wsYBTYrcGe6
 CQlnUilASEDSMAIRSLK0c0DqqZRnCx4J8gBrUyK3CYYBYDvVXhKXcCW9NS1ZEj94Jb9To1hph
 333K4APvOVtjNUs57EMzbtPjFRrSVcfM61BNqluoV5z7KYWUAm9eZepMn9Q9CO86b6GYJdfyJ
 svgxrhcgzfYoSbXOE++DR3Egn6rhlYam0Q8F9/6x41pcgiybrDkiqdvEJyVIIzK9zMR6xtZH0
 i5vzZNm6vgKiTaejoVzP/PbSBJCnzYtPCvr9+XFsrnDBnvweg6AMwIUJW46ktvc3Lf/jemLyj
 My0rfJn//J7x3OOmhjs/PkQsGw9nrEziz/d3FPL7GoxB/SSI+/tE1fI0zfCmppL5+dJf07BPl
 dbyl5z73pB6Nsi4FK816gphWFCo+CqwDMQpHWlkl7s1PV4Uy/Zwz27+coAe8A4nAKwRb5VLK2
 OwOwXnQAR2qdDP6Ay9euhzw+y2U8vLqzREemFrmzDfu53kEbFrMeyGpU3vaLuVWmE/va/e/Sq
 ebXVGXV3KckR6lKCqv+eeQBwY+62B+JXxV6Q8gRaZ3VAGjFL9qBxuc6AL386/32O+SdVFHK7B
 y5SUK8f2AayQPvWZ6tQS12k5rjwAjuuc2EzaggY89Y96Z/CGFn0x6oiq0ZGL0YT+102J1Aayn
 /3vnkRmzcMqblzCeIaMoDCj9vDcZuiGKmGVGjVuVV+Q3gY9iw1aP2p783tJQmrj5fm3ylEFSo
 25T6v/pZ5q9owB2F52hLfk2hhM6g2FCPHZ8UL9sT4FJIOwNdGoRGkl6+/D+YlJDrAqco6JTea
 3VyiqxII9OBhv4c0UOCsXofKa5JGS3qSp60OpmFuzI8jJfAiJX+efhtxHbyYmeswOdoHUHYou
 XJYr4HYScz6lRoUrsk5Q9VyuuJCNGS85opKRY17hySFj+qlZHtSQH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1044786231-1559153353=:44
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <nycvar.QRO.7.76.6.1905292009211.44@tvgsbejvaqbjf.bet>

Hi Junio,

On Wed, 29 May 2019, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
> > On Wed, May 29 2019, Johannes Schindelin wrote:
> >
> >> On Tue, 28 May 2019, Junio C Hamano wrote:
> >>
> >>> * ab/send-email-transferencoding-fix (2019-05-19) 7 commits
> >>>  - send-email: fix regression in sendemail.identity parsing
> >>>  - send-email: document --no-[to|cc|bcc]
> >>>  - send-email: fix broken transferEncoding tests
> >>>  - send-email: remove cargo-culted multi-patch pattern in tests
> >>>   (merged to 'next' on 2019-05-13 at 38c6a1e7e0)
> >>>  + send-email: do defaults -> config -> getopt in that order
> >>>  + send-email: rename the @bcclist variable for consistency
> >>>  + send-email: move the read_config() function above getopts
> >>>
> >>>  Since "git send-email" learned to take 'auto' as the value for the
> >>>  transfer-encoding, it by mistake stopped honoring the values given
> >>>  to the configuration variables sendemail.transferencoding and/or
> >>>  sendemail.<ident>.transferencoding.  This has been corrected to
> >>>  (finally) redoing the order of setting the default, reading the
> >>>  configuration and command line options.
> >>>
> >>>  Will merge to 'next'.
> >>
> >> I just sent a reminder that the tip commit is broken under NO_PERL, a=
nd
> >> accompanied the report with a diff that could be squashed in. =C3=86v=
ar, please
> >> have a look and say yay or nay, and please let's only let this enter
> >> `next` once it is fixed (because otherwise the Azure Pipeline will sp=
am me
> >> every tim `next` is psuhed -- thanks, Emily, now I mistype this every
> >> single time).
> >
> > Sorry about missing this. Your prereq addition in
> > <nycvar.QRO.7.76.6.1905291106540.44@tvgsbejvaqbjf.bet> looks obviously
> > correct to me.
>
> Yeah, I recall that one from previous week.  Let's queue it on top
> (and find the right place tos quash it in).

Sorry, I was unclear. The commit to amend is the tip one: "send-email: fix
regression in sendemail.identity parsing".

Thanks,
Dscho

--8323328-1044786231-1559153353=:44--
