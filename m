Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFFAC433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 08:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5239860FD8
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 08:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbhJVIZD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 04:25:03 -0400
Received: from mout.gmx.net ([212.227.17.21]:37563 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231984AbhJVIZB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 04:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634890963;
        bh=MxcI33tSv78fgDu5AE7v3rDLHD+XHH/8RfkY5yBKfw4=;
        h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
        b=XyexjW532KSGa0VRBssmy4EJZeMIgDPmYKTdcn4hFQqQRsGCEFFGspT+xFWOXC0Jj
         +dVjPYreCjd8R3lzVDiNjVNPj0L9LZusmWGHskIKIPFGtxlDWj9QFuYb1QZ8WM9DJW
         QhrA7vhlBcFb0XkMKyVHWyAMgaC2SQPBOTf5ARtc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.19.78] ([89.1.213.179]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MeU4y-1nEGVL1STM-00aRo5 for
 <git@vger.kernel.org>; Fri, 22 Oct 2021 10:22:43 +0200
Date:   Fri, 22 Oct 2021 10:22:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git@vger.kernel.org
Subject: Re: Missing notes, was Re: Notes from the Git Contributors' Summit
 2021, virtual, Oct 19/20
In-Reply-To: <nycvar.QRO.7.76.6.2110221000480.62@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2110221020570.62@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.2110221000480.62@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1410805247-1634890963=:62"
X-Provags-ID: V03:K1:aKuDVPi1DUt1CMhEFuSiJg4nL99bZD6zM8iWwWJY+UJD/xqZGwK
 AuSmOXtm8FUtVkiDaaNAbzftXow2GD6bv4gM8cMk3+Sx5NOkoc9pF/Imw8L7/tqJtNndcwh
 Upoq3B14NKYweC1gm7TrUYMvERNu6uOf1uZCkDQGk7rdnPXUsu1aN99f7z6Pk51J0Dchiwg
 U40tnN/0abMZw6z7Zvt5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hxemdi0gdY0=:PMszdFPb7O103LVpPKUpKl
 oWf28wjnBlZA48oaElH3PE4CLT/1OUQn125yrupf67qZSe3YVtO4qrV+ZJ7LiyLYghHGUqhgc
 +8fPjR//jyAZ6Vx9y4kPAHtGBJxQ7LknZI4EBo4IJwM29KrH0z9vaGop5uYyGS/5AOBXMAvOY
 69rrzmisIqVkMcmJg756BY+OatRL7pXLOjccinGms6PL1wchvj3hR8JMSLrj1c2S1zrxy73t2
 QlwR/9OJVg/Uz3h8JzpPhwi09lS7i0v0/0WaGv8CM8sIdyId6ExLWiV8rMfyTh5QhLpHNa2u3
 oun2uhMX7R+MpqHYzeIUw4SzyQD0KrZklTzyOK1aunQVSir9q0APa0NfEcDA5dni+uyIIiIXf
 S6S6Ui05uPWITTxrV4RMLWVQR4Z0hFAsWeO+gGh7VQ2+8KKIBRP1X4B4DZz5v8LfXG4hNzRGt
 rUhdS8Jiff2GeMQxMO7VOxVDQ2cZxfM4PWFB3goeIy6PPlm1b56P2HoiWmmarcVJgAbhRNZAK
 CumqFJbj5n2yvQdl+hXzxTbg5i7KgVgQS3y96D+HzLLQ4B58iR1HC2OtYIXWjkZ2NygsqV4Gl
 hbvhH9wbHe1AyMCf8Fu2mwdFRKzyXxGPwrM9CHDJ6+ZivsR4QrL3EAFyYc1ugOW6Bd9V7yCZt
 NpuuwjDcUf0vHqOZiErAZXJnYj37Z6/ChGaPlOybjRUXMeDovWqgOzzWfBYkr1QKIj9t+cCR0
 w5llPQsuaVdu4TXHPEz+vVzpzMxE8Ct5KfQwyBStuD5YkYwVO8aOKWsXJkAlPSwVsbq1evpYc
 F6pRo9maOsiU1S6p4WCYNakn1aSbd40JoRkZPqkZuMnaRo6JVh45OP7KK0IucOx8PMA11Eng8
 b8/3LSpKw1e3iUx5st/K9hNZm49qYH7z5xIBjrvXwtH5HEgBMDCb4rbH1ovFk00tmemeS91M8
 4aWaSt4xDq3O3FHo7RC5R2IDNbyLm1i/6br1B1xIdLhfZ4FqR3jxVM/ufqNDU1YpZw3Um6ozU
 nL4MRKhsYTXkyNCfPYjfP9muexDU3bNWb3OnpKRBaRScIHEDazIy9me0q7//bYcs/4vEcLtXo
 i8+pooRDtSzFTo=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1410805247-1634890963=:62
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Team,

I tried to reply with the full notes, which failed. So I'll try again,
this time in chunks.

On Fri, 22 Oct 2021, Johannes Schindelin wrote:

> Hi,
>
> On Thu, 21 Oct 2021, Johannes Schindelin wrote:
>
> > Team,
> >
> > we held our second all-virtual Summit over the past two days. It was t=
he
> > traditional unconference style meeting, with topics being proposed and
> > voted on right before the introduction round. It was really good to se=
e
> > the human faces behind those email addresses.
> >
> > 32 contributors participated, and we spanned the timezones from PST to
> > IST. To make that possible, the event took place on two days, from
> > 1500-1900 UTC, which meant that the attendees from the US West coast h=
ad
> > to get up really early, while it was past midnight in India at the end=
.
> >
> > I would like to thank all participants for accommodating the time, and=
 in
> > particular for creating such a friendly, collaborative atmosphere.
> >
> > A particular shout-out to Jonathan Nieder, Emily Shaffer and Derrick
> > Stolee for taking notes. I am going to send out these notes in per-top=
ic
> > subthreads, replying to this mail.
> >
> > Day 1 topics:
> >
> > * Crazy (and not so crazy) ideas
> > * SHA-256 Updates
> > * Server-side merge/rebase: needs and wants?
> > * Submodules and how to make them worth using
> > * Sparse checkout behavior and plans
> >
> > Day 2 topics:
> >
> > * The state of getting a reftable backend working in git.git
> > * Documentation (translations, FAQ updates, new user-focused, general
> >   improvements, etc.)
> > * Let's have public Git chalk talks
>
> You might wonder why I did not send out the notes for this talk.
>
> But that is not true! I sent it 6 times already, in various variations,
> and it never came through (but I did get two nastygrams telling me that =
my
> message was rejected because it apparently triggered a filter).

This session was led by Emily Shaffer. Supporting cast: =C3=86var Arnfj=C3=
=B6r=C3=B0
Bjarmason, brian m. carlson, CB Bailey, and Junio Hamano.

Notes:

 1.  What=E2=80=99s a public chalk talk?

     1.  At Google, once a week, the team meets up with no particular topi=
c in
         mind, or a couple topics, very informal

     2.  One person=E2=80=99s turn each week to give an informal talk with=
 a white
         board (not using chalk)

     3.  Topic should be technical and of interest to the presenter

     4.  For example: how does protocol v2 work

     5.  Collaborative, interactive user session

     6.  Helps by learning about things

     7.  Helps by honing skills like presentation skills

     8.  A lot of (good) humility involved. For example, colleagues who ha=
ve
         been familiar with the project for a long time admitting they don=
=E2=80=99t
         know, or have been wrong about things. Makes others feel more
         comfortable with their perceived lack of knowledge

     9.  Could be good for everybody on the Git mailing list, might foster=
 less
         combative communication on the list

     10. Might be a way to attract new people by presenting =E2=80=9Cold t=
imers=E2=80=9D as
         humble

 2.  Does that appeal to anybody else?

to be continued...

>
> I shall keep trying, but my hopes are pretty low by now.
>
> Ciao,
> Johannes
>
> > * Increasing diversity & inclusion (transition to `main`, etc)
> > * Improving Git UX
> > * Improving reviewer quality of life (patchwork, subsystem lists?, etc=
)
> >
> > A few topics were left for a later date (maybe as public Git chalk tal=
ks):
> >
> > * Making Git memory-leak free (already landed patches)
> > * Scaling Git
> > * Scaling ref advertisements
> > * Config-based hooks (and getting there via migration ot hook.[ch] lib=
 &
> >   "git hook run")
> > * Make git [clone|fetch] support pre-seeding via downloaded *.bundle f=
iles
> >
> > Ciao,
> > Johannes
> >
>

--8323328-1410805247-1634890963=:62--
