Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A202AC433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 09:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AE1A60F43
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 09:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbhJVJJ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 05:09:58 -0400
Received: from mout.gmx.net ([212.227.15.15]:48137 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232406AbhJVJJ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 05:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634893658;
        bh=IUzhfKoDuV0RntvTEKBq97Cs7+dNjlCezHFFQTc60xs=;
        h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
        b=ip7/aCJgUIyWYUTDl94EbTA1Xi7DCZ66OsF+aKUNAKUYvycSVOCbX3eA9mrDa+GyJ
         VuYNwzA+qZ8hheO7naPEfYW976qtjd2HUwsTBQeDPgtMM7DZDuzDVclUZzNAM/QF6A
         NBOZUEpFZEau5khAk8WcQW/mMMdqoZRbSITq83ok=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.19.78] ([89.1.213.179]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtOKi-1myFUK1gXm-00uoQt for
 <git@vger.kernel.org>; Fri, 22 Oct 2021 11:07:38 +0200
Date:   Fri, 22 Oct 2021 11:07:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git@vger.kernel.org
Subject: Re: Missing notes, was Re: Notes from the Git Contributors' Summit
 2021, virtual, Oct 19/20
In-Reply-To: <nycvar.QRO.7.76.6.2110221028090.62@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.2110221000480.62@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.2110221020570.62@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.2110221028090.62@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1785661176-1634891636=:62"
Content-ID: <nycvar.QRO.7.76.6.2110221041470.62@tvgsbejvaqbjf.bet>
Message-ID: <1M4JmN-1me7VT1yCn-000Mey@mail.gmx.net>
X-Provags-ID: V03:K1:XE2qm4dQqe2Kn/kgilmwHskwv6waesb2H2zeegRnD3gmuMzolmW
 shSEnmMi6SjsQ6EyT8Xda9eL/lhp43pHZF48F6W3tvU7RySE0Ef7dxa/h/Ofbkjg8UdTBRQ
 0m205J/N8p/y1rGA24xYfQoM29qxPfjQrkIq1xv13pKESFBxXzD47kKXspvZTnKL68nfjIB
 0g4hU15gAY2e1oMqh+5qg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3Jlw/VULC14=:CcA7vzK3k0o1/JHZkP/hnq
 BcCZxZaaa2A2zsWTmUJRGsGgtJjqtTMh6YxIn6XaxwTeO6R1+eI7rvng02+FT+h1aRtBbO/3Y
 mLAmozxJDr2SEsWDFMU9VyYApu3O8ShjlTmDUF9qakvp8DQCZN4wbiDSkTBVpYD+2WU4Tn8Id
 WGOb77zbXl3hQ6c24Z2Dl7O0sltChlu4fHhhgvRO98b7IfbonlSTGL/+bOhCxh/TFJC5VsMZR
 +6QpOi4LCWehXcQn94SLMo6z0b6R4dBOFYur85jpjI7U5IhwyZ2edJbBJJ2GAX2aeOtYgOCm8
 bgJa3clqFPm87mLeyPrfCOGjoWBvwwzYWJZ4OZcRyY8K2cI6m2L/bmBdwuHW1g/OFMRQaX0uC
 0b8ljHe/RgpRM+c9XLMkxVi15a+vN5OucyqZgnzmWAIkEaRnq5vZE+6kWP1xCmwaLmc634S4F
 y1dxO0482eW3SDCqLYCYu/Jkuc3+BoTbM2rhOouS6KKri2+c3PhVUzuuP09DTyJlEB2z2PwEK
 j+WxK05XSYgkMJFGlgDLoSL1SYghfrhySlKjXxf9o+yyUFLlFg7pgaVyL9igzK3OTQIJmFG2Q
 ljpH3WZNkLtu3ZiZ33eZST8Xi+Itn3pUKEBnrJpau/v0B9amqx3Zq3vQuJd7nNqLb7NkiQieC
 rmNQkSVKaASdoV/YvgXaZuuo82PIOlBbhapBvL5jZSQS5K4QSKrasCMKezD32MOm5SNywvQdr
 AP18RLqr1T3ecs9kqHeSHAnujo5UgJE+RWJWjI4Uk8XVHMIO3UsLLXSrQGj8zQG2nSEjMzgzQ
 w0F83jqtb+zKhBgElQt26JH0mK0F4Qht0vxfuq3n49IwWNDuVcMiyPEhpcNUQAmLT+FtyInUK
 q0zNmBP4y4Xox6L5BQUcOyD1qdpUOru5CBA/YNvXtfmAhsgriE7vmwiyAZnhjfthrRPUHAqmB
 DM2OeRIqniiPb0s/0fNBtXg59fUOn8quSLOD6/wywcxzekwVzodyXkGlN+9VmHK3UZYa8kV35
 WV3elCEwm33U6NSg4bC2bFIEAlLugaQbajLk0ZvI2WQ4QXoqXGHBH8CyWOQwiM0HHQZDoZ84A
 hXjH6vUMm7Cq3Y=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1785661176-1634891636=:62
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <nycvar.QRO.7.76.6.2110221041471.62@tvgsbejvaqbjf.bet>

Team,

after 10 failed attempts to send more notes, this might start to get a bit
annoying on my side.

On Fri, 22 Oct 2021, Johannes Schindelin wrote:

> On Fri, 22 Oct 2021, Johannes Schindelin wrote:
>
> > On Fri, 22 Oct 2021, Johannes Schindelin wrote:
> >
> > > On Thu, 21 Oct 2021, Johannes Schindelin wrote:
> > >
> > > > * Let's have public Git chalk talks
> > >
> > > You might wonder why I did not send out the notes for this talk.
> > >
> > > But that is not true! I sent it 6 times already, in various variatio=
ns,
> > > and it never came through (but I did get two nastygrams telling me t=
hat my
> > > message was rejected because it apparently triggered a filter).
> >
> > This session was led by Emily Shaffer. Supporting cast: =C3=86var Arnf=
j=C3=B6r=C3=B0
> > Bjarmason, brian m. carlson, CB Bailey, and Junio Hamano.
> >
> > Notes:
> >
> >  1.  What=E2=80=99s a public chalk talk?
> >
> >      1.  At Google, once a week, the team meets up with no particular =
topic in
> >          mind, or a couple topics, very informal
> >
> >      2.  One person=E2=80=99s turn each week to give an informal talk =
with a white
> >          board (not using chalk)
> >
> >      3.  Topic should be technical and of interest to the presenter
> >
> >      4.  For example: how does protocol v2 work
> >
> >      5.  Collaborative, interactive user session
> >
> >      6.  Helps by learning about things
> >
> >      7.  Helps by honing skills like presentation skills
> >
> >      8.  A lot of (good) humility involved. For example, colleagues wh=
o have
> >          been familiar with the project for a long time admitting they=
 don=E2=80=99t
> >          know, or have been wrong about things. Makes others feel more
> >          comfortable with their perceived lack of knowledge
> >
> >      9.  Could be good for everybody on the Git mailing list, might fo=
ster less
> >          combative communication on the list
> >
> >      10. Might be a way to attract new people by presenting =E2=80=9Co=
ld timers=E2=80=9D as
> >          humble
> >
> >  2.  Does that appeal to anybody else?
>
> [redacting a word I suspect to have triggered vger's filter: it is a wor=
d
> starting with "T" and continuing with "witch". Whenever you read "[itch]=
",
> that's what I substitued for the culprit]
>
>  3.  =C3=86var: I think it would be great, has been a long time we=E2=80=
=99ve seen each
>      other, and already feels different
>
>  4.  One thing to keep in mind: it=E2=80=99s hard to program on a white =
board :-)
>
>  5.  Emily: some challenges:
>
>      1. How often?
>
>      2. What time?
>
>      3. Probably move things around (because we=E2=80=99re global)
>
>      4. Tech to use? Jitsi? [itch]? ([itch] seems to be particularly pop=
ular to
>         teach programming)
>
>      5. Figure out what topics to present
>
>  6.  =C3=86var: does not matter what tech to use
>
>  7.  Emily: some difference may make it matter: on [itch], you can recor=
d, and
>      they host recordings
>
>  8.  One thing to worry about recording: people might be reticent to mak=
e
>      public mistakes
>
>  9.  It=E2=80=99s possible to do a [itch] stream, and not record it

The brian m. carlson offered the idea to be considerate of reservations by
participants, but also accommodate Git contributors who would have loved
to see the presentation but were unable to attend due to timezones, time
conflicts, etc: offer it for viewing only for a short while.

to be continued

> > >
> > > I shall keep trying, but my hopes are pretty low by now.
> > >
> > > Ciao,
> > > Johannes
> > >
> > > > * Increasing diversity & inclusion (transition to `main`, etc)
> > > > * Improving Git UX
> > > > * Improving reviewer quality of life (patchwork, subsystem lists?,=
 etc)
> > > >
> > > > A few topics were left for a later date (maybe as public Git chalk=
 talks):
> > > >
> > > > * Making Git memory-leak free (already landed patches)
> > > > * Scaling Git
> > > > * Scaling ref advertisements
> > > > * Config-based hooks (and getting there via migration ot hook.[ch]=
 lib &
> > > >   "git hook run")
> > > > * Make git [clone|fetch] support pre-seeding via downloaded *.bund=
le files
> > > >
> > > > Ciao,
> > > > Johannes
> > > >
> > >
>

--8323328-1785661176-1634891636=:62--
