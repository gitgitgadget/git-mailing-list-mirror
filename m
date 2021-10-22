Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1442C433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 08:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85E6B6109F
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 08:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbhJVIcn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 04:32:43 -0400
Received: from mout.gmx.net ([212.227.17.21]:60493 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231773AbhJVIcm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 04:32:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634891424;
        bh=7E8267gcyjeG5xV38/142eCw/6fDPEryKi+VAYmPCMI=;
        h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
        b=jdkYjpmK2CPVHmU26eg8qmpGYY95UgUTTYNDgKK3H6dMHat6v5LKRPSJbc+856gjE
         vLH/XMN9xk1QRQs29kBENXlQEYyAG9KEvAnh8mkZ/qztaa6RfzepHY0Gs0pH5YwhEO
         GreHUmW6zBOhbz+ZKrVL6xoNRmvC38CSzy5wyrws=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.19.78] ([89.1.213.179]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5mGB-1mkBa72m5L-017I4F for
 <git@vger.kernel.org>; Fri, 22 Oct 2021 10:30:24 +0200
Date:   Fri, 22 Oct 2021 10:30:23 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git@vger.kernel.org
Subject: Re: Missing notes, was Re: Notes from the Git Contributors' Summit
 2021, virtual, Oct 19/20
In-Reply-To: <nycvar.QRO.7.76.6.2110221020570.62@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2110221028090.62@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.2110221000480.62@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.2110221020570.62@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-134392965-1634891104=:62"
Content-ID: <nycvar.QRO.7.76.6.2110221028091.62@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:qS/LJ7TZjaSABbjP/pqnIIsXgE4w7/DFfDaLqCcMAj1EepdGKKO
 LJAvfFOe1Mbh3IUHyCG79qQ4Caofm5nsY6dubC7FAamWM1YzJI9y2e/iHhp3+rug3cGZIOm
 gtaWM9H004htcCHWttROudeN+4Z2/PgBJZ299kgPygitQZIXMSpQD1uv/chccCxJvyXr5VN
 /X5R/65nImcNLvA5/YR0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Gvt0dIzGx+M=:9u1n0B4vnFVzfO30bm4aLE
 rvpuiL0shbF2NReE1Vf9MgY4bQX8sLQbDNAbTgIUYb7pseAlVnD80h+NhwDR5Tf6WKQK0Xuea
 kND8+CcMGUzDpTxRUCyN55Qq3ENbDPR6VWJjkiry5fiCto80pIrgRUfxdG8pnV2R+raQqF07l
 6JgMVPAzDbb1S4P+/6/g6Xt31x/T8wNbTkfanGKi65WgetVVrVe+iO4tCsoMO8t2ba3BBYW7W
 5csl7d8D1TX5lp2Bsld2qA95q5GsMOPZSVMFK2ybuxPcGVYrbgHP+PqENxCy/2W2jPjR6tQLh
 2UpVRz9dO9yILx1IlGlnpTkjWGry70DjMui2PQBiV3akn8Rlhv4wztdgJuTUff8TIWNh5Yvpj
 JSAKdMp9uMXg21hTan0LdrIuXM0yfx3hpXonlrMr0DI/S760GBThkYgmuZp8ph1QTVVbq4iSG
 /GnBfbobn4c8iDdI/WljjwL/M+ao3OTPHUsuwASQidAGXSB2aBbyNVFdGQu0f2qbjRB8Qn5Zg
 P98rxyf7+xDKmBSmf2r2KZtZUSMAIObcbGqAqmyTvUnE0ihm9YsN3aJj+XERao0e7ysJfer6/
 8wG0XS3hVIqtPN52FY5nEPD7O88vj6xMIfU+uc+Acbcw/jBQbqA4vVcUiMrbzUzEz6tFaIuAa
 Lh9ubbyyxrxb0L9UzX3miwBJu4UuxCBtRxZxFVVzkEIpYuaa23a3aj9aJxe8Bets1vTSK/Q+T
 eE7Y+BRh9HAldTzzrEaGrSYUD+FSz1/yMRTb/lUOc2tnIDb46R83ekMjU/RpOXnXOBQTc1ZRH
 96c9T/GQ4lNWLuDg8IqzI8JkJVXv/kcEK0BkCFpwAq2s5Mi8BdeoMqiwDy3abhepngQApyU/B
 owCztQIKRPkXJ0Cb91z+foSX5yrZftOiOfoxRK5bIF+yNbR0A79YgKgy+PqcaVHabTevKU07C
 ELsv7RH2iKc4jiE/MkHBzoP7C6qYTDeQOD/KLgN2iGgl9ZULuwGFXowWyYIXI6GfOG49sT1sw
 CyfcwzMSN/9LdmjidNl4a155Wb3rfkOBtT4mazr6qpktVIF4r1SFAlJ2AlPzohTxjx7o66B+j
 0fQxM50Z9qrWIg=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-134392965-1634891104=:62
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <nycvar.QRO.7.76.6.2110221028092.62@tvgsbejvaqbjf.bet>

Continuing... (2nd try, with redactions)

On Fri, 22 Oct 2021, Johannes Schindelin wrote:

> I tried to reply with the full notes, which failed. So I'll try again,
> this time in chunks.
>
> On Fri, 22 Oct 2021, Johannes Schindelin wrote:
>
> > On Thu, 21 Oct 2021, Johannes Schindelin wrote:
> >
> > > Team,
> > >
> > > we held our second all-virtual Summit over the past two days. It was=
 the
> > > traditional unconference style meeting, with topics being proposed a=
nd
> > > voted on right before the introduction round. It was really good to =
see
> > > the human faces behind those email addresses.
> > >
> > > 32 contributors participated, and we spanned the timezones from PST =
to
> > > IST. To make that possible, the event took place on two days, from
> > > 1500-1900 UTC, which meant that the attendees from the US West coast=
 had
> > > to get up really early, while it was past midnight in India at the e=
nd.
> > >
> > > I would like to thank all participants for accommodating the time, a=
nd in
> > > particular for creating such a friendly, collaborative atmosphere.
> > >
> > > A particular shout-out to Jonathan Nieder, Emily Shaffer and Derrick
> > > Stolee for taking notes. I am going to send out these notes in per-t=
opic
> > > subthreads, replying to this mail.
> > >
> > > Day 1 topics:
> > >
> > > * Crazy (and not so crazy) ideas
> > > * SHA-256 Updates
> > > * Server-side merge/rebase: needs and wants?
> > > * Submodules and how to make them worth using
> > > * Sparse checkout behavior and plans
> > >
> > > Day 2 topics:
> > >
> > > * The state of getting a reftable backend working in git.git
> > > * Documentation (translations, FAQ updates, new user-focused, genera=
l
> > >   improvements, etc.)
> > > * Let's have public Git chalk talks
> >
> > You might wonder why I did not send out the notes for this talk.
> >
> > But that is not true! I sent it 6 times already, in various variations=
,
> > and it never came through (but I did get two nastygrams telling me tha=
t my
> > message was rejected because it apparently triggered a filter).
>
> This session was led by Emily Shaffer. Supporting cast: =C3=86var Arnfj=
=C3=B6r=C3=B0
> Bjarmason, brian m. carlson, CB Bailey, and Junio Hamano.
>
> Notes:
>
>  1.  What=E2=80=99s a public chalk talk?
>
>      1.  At Google, once a week, the team meets up with no particular to=
pic in
>          mind, or a couple topics, very informal
>
>      2.  One person=E2=80=99s turn each week to give an informal talk wi=
th a white
>          board (not using chalk)
>
>      3.  Topic should be technical and of interest to the presenter
>
>      4.  For example: how does protocol v2 work
>
>      5.  Collaborative, interactive user session
>
>      6.  Helps by learning about things
>
>      7.  Helps by honing skills like presentation skills
>
>      8.  A lot of (good) humility involved. For example, colleagues who =
have
>          been familiar with the project for a long time admitting they d=
on=E2=80=99t
>          know, or have been wrong about things. Makes others feel more
>          comfortable with their perceived lack of knowledge
>
>      9.  Could be good for everybody on the Git mailing list, might fost=
er less
>          combative communication on the list
>
>      10. Might be a way to attract new people by presenting =E2=80=9Cold=
 timers=E2=80=9D as
>          humble
>
>  2.  Does that appeal to anybody else?

[redacting a word I suspect to have triggered vger's filter: it is a word
starting with "T" and continuing with "witch". Whenever you read "[itch]",
that's what I substitued for the culprit]

 3.  =C3=86var: I think it would be great, has been a long time we=E2=80=
=99ve seen each
     other, and already feels different

 4.  One thing to keep in mind: it=E2=80=99s hard to program on a white bo=
ard :-)

 5.  Emily: some challenges:

     1. How often?

     2. What time?

     3. Probably move things around (because we=E2=80=99re global)

     4. Tech to use? Jitsi? [itch]? ([itch] seems to be particularly popul=
ar to
        teach programming)

     5. Figure out what topics to present

 6.  =C3=86var: does not matter what tech to use

 7.  Emily: some difference may make it matter: on [itch], you can record,=
 and
     they host recordings

 8.  One thing to worry about recording: people might be reticent to make
     public mistakes

 9.  It=E2=80=99s possible to do a [itch] stream, and not record it

to be continued...
>
> >
> > I shall keep trying, but my hopes are pretty low by now.
> >
> > Ciao,
> > Johannes
> >
> > > * Increasing diversity & inclusion (transition to `main`, etc)
> > > * Improving Git UX
> > > * Improving reviewer quality of life (patchwork, subsystem lists?, e=
tc)
> > >
> > > A few topics were left for a later date (maybe as public Git chalk t=
alks):
> > >
> > > * Making Git memory-leak free (already landed patches)
> > > * Scaling Git
> > > * Scaling ref advertisements
> > > * Config-based hooks (and getting there via migration ot hook.[ch] l=
ib &
> > >   "git hook run")
> > > * Make git [clone|fetch] support pre-seeding via downloaded *.bundle=
 files
> > >
> > > Ciao,
> > > Johannes
> > >
> >

--8323328-134392965-1634891104=:62--
