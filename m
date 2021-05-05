Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E08C433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 14:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44387610E7
	for <git@archiver.kernel.org>; Wed,  5 May 2021 14:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbhEEOTl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 10:19:41 -0400
Received: from mout.gmx.net ([212.227.17.20]:52741 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233045AbhEEOTL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 10:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1620224293;
        bh=2Co926wsQKZgefb4tsPlGxfzAHcFZkAPUtKjVaZSRtw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=aJ+COx1wMMXIAEuvsKTN3x5ar88Z4WFDXnJaHFLkQRZ3oUIlCOAVKL+cIWMSoHp7T
         ely5DROshr7y7kB1zA/Ioxb+ObipIHjM1JdBJPkl1QTWoRhmdear7Kk21wqEHvgsPU
         L0tUgXiBT7QP0x2wS3QU7ivtnx9VoWYNqDqCXMRM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.146.104] ([89.1.212.20]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPogF-1lrJ4B431f-00Mvz2; Wed, 05
 May 2021 16:18:13 +0200
Date:   Wed, 5 May 2021 16:18:11 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     =?UTF-8?Q?G=C3=A1bor_Farkas?= <gabor.farkas@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git switch/restore, still experimental?
In-Reply-To: <CABPp-BHBcjSQbkotrzwDtVRSC-qqjEyP4m=biY-0+=Jdg9ETQw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2105051554250.50@tvgsbejvaqbjf.bet>
References: <CAPiPmQnb=XMaF2+YkryEbiX8zA=jwa5y=fbAGk9jpCExpbS4Rw@mail.gmail.com> <CABPp-BHBcjSQbkotrzwDtVRSC-qqjEyP4m=biY-0+=Jdg9ETQw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1204387783-1620224293=:50"
X-Provags-ID: V03:K1:5n282IQnWrWJzLIJT51pZJq2lQrBEweBezmQkqDWpvA1IP+La3x
 j1FRI6uaQ4F7EeTT9w1hm9NJFoxJQb+Rz7DnUFdhZXdtu8h/P0XDvYrjWl0VcwAYr8xwvfP
 mmGGiOLYazo+oNzfD9hDpBxoEo88OlqSUWtSrwUq1zA7Z/49jQFGmvLrRWQ3ShGZkIRMf2Z
 cBaJXE3HPHHhYfyYHmhEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8XEDBSLh4gY=:yz9xBDB7M74zwybzQ9ZGN7
 O0gzgJi2yLeAd/I53XLztjw61m5PzGznLiy7QhgGEnkCbHQo6y+RRvr0fi4drLZEaaaw+NMBY
 mH0s8IBTqKknFjeJNlyQMxfnNvQtQHZonHsq6w9AlUXDhjFibl3cC5Uep0PvyDLXb1kwUfg5f
 Azl+dpF3x9hhyg8Ic8++9viEZEP2YaQruIZNA7BrNMPzc/TmOBJm/rsrdIBWKiVItiek1D0GF
 fjjfFlA/L3STNT/RK4XGVTOFMQS/bvOpQI0aWeeaGhmtavc4ppNsZiKF8A+ruEWjnXSNka5M4
 F6zUtIesdVui14QL/8n1Exl0EE86gCUMVDOYLrtkSJTpUQMhNPWShjRl1NzXys5qSIpDry6z9
 vRHm4vNVlSFsFU8k0YTFO3A2C2XZJkjMy0kTSeUAvjZnxHWhLdDdZl8b5POx1ldK7448g3N+O
 c2AMH6HG4H2G0TIFSRLTaRjjquceeRorpohvyGFZwKHtnPclkh8URY4MWefzvSAY4sVhx1X72
 yz2XvrJ2DckyI3KcE52ghOrX012hoKb8uNyKjuMmLeGlhelQn6aRguBYi0jqqGIY7TTGzT46A
 3VgpKHG0bUZiaN2pub/nAxO2eXUTY+KQuV8M4D3p9rlHjOSpjSMXWGyHsjFYAlg+aZsk+5EB+
 EZu11McRc80cx/9pnPX4yTuIwMaybEbFC5AIYCUqlIb3Tsh9wSzJzKrPxLOKFCJj1QUfimSnV
 5opnCabb7Zwzr/rPREvqCrFuoReAkh2SK9wd7VcPFTwndETgssGc2r3ut/nugUIEPVCaen0rZ
 Bunf4T8IDJ2nK3C4/bSTZqluULGGn1o80DV+3avrSJ71muUQL7HXiVnhvVlXQLDzKd+V2Fdvc
 rmC03g6bPMdZF0vHuR+yz4mKfbK+lbofagAkxAS4FjxxNbYwIfyiVnsmveY33jj+IdpJHdNY3
 poSpYbfcvUcGA+XlKujzWw+vSVg2/FdoLDXIgByam1hSKTTPkd7K7U69Bn4LdcF6N1P2La3LC
 nJo9v6kLtKZLxGQaOpvwKDHyU7K+pcNMZA2wgJVjx7xvimoixEAYN1UV4zCHJ2BT2GoRrqt/t
 fh7qSYNIjsIhwXHhQfnMTDAZ6xPpsjsqLEaWmjF1asN439sc2A3cVGumrq8sTHJQKCAmOqBSY
 z1kqC6Hzi9meX5DdhFxXOjAW2S8cI5L9VEuG0PIBYlFaFfRBRqfGJrBBF7jgfHV2yg3XSFjPs
 4hB/KYdoYsRh879mZ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1204387783-1620224293=:50
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Elijah,

On Tue, 4 May 2021, Elijah Newren wrote:

> On Tue, May 4, 2021 at 3:36 AM G=C3=A1bor Farkas <gabor.farkas@gmail.com=
> wrote:
> >
> > the "git switch" and "git restore" commands were released two years
> > ago, but the manpage still says "THIS COMMAND IS EXPERIMENTAL. THE
> > BEHAVIOR MAY CHANGE.".
> >
> > i'd love to use them, but this warning gives me pause, perhaps i
> > should wait until it stops being experimental, i worry that it might
> > change in behavior unexpectedly and cause problems for me.
> >
> > considering that they were released two years ago, could the
> > experimental-warning be removed now?
>
> This probably makes sense.  The author of switch and restore isn't
> involved in the git project anymore.  He decided to work on other
> things, which was and is a big loss for us.  I think others (myself
> included) didn't know all the things that might have been in Duy's
> head that he wanted to verify were working well before marking this as
> good, but these two commands have generally been very well received
> and it has been a few years.  Personally, I'm not aware of anything
> that we'd need or want to change with these commands.

I think that part of the intention to mark this as experimental was to
gather feedback about the commands. After all, the goal was to improve the
user experience of Git (because `git checkout` does too many things, and
its major accomplishment is to confuse literally every single new Git
user).

However, that hope never was fulfilled if I may say so, we simply did not
attract the best-suited experts to this mailing list, not if what we set
out was to improve usability.

Which leaves us with two hard choices regarding switch/restore, none of
them really being comfortable:

- we scrap switch/restore because their usability is not really all that
  improved relative to `git checkout`.

- we leave switch/restore as-are (because by now, changing the options or
  the design would be almost certainly disruptive to users who already
  tried to adopt the new commands, I being one of those users).

I say that neither of them is a really splendid choice because the
original goal is not only not accomplished, but I would say it is even
harder now than it was when we accepted switch/restore into an official
release, because of that experience with switch/restore. We simply do not
have the right expertise on this list, and therefore anything we do will
always have that "UX designed by an engineer" feel.

So I'm not sure what to do, either.

Ciao,
Dscho

> That said, we're only a few weeks from -rc0, and I'd rather remove the
> experimental label early in a release cycle, so maybe this would be a
> good thing to do after the June git-2.32 release.  That'd give plenty
> of time for others to chime in with anything they might be aware of
> that they want or need fixed.
>
> Thanks for flagging this.
>
> Elijah
>

--8323328-1204387783-1620224293=:50--
