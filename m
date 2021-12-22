Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DE5C433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 16:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238464AbhLVQQg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 11:16:36 -0500
Received: from mout.gmx.net ([212.227.15.15]:36867 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234704AbhLVQQf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 11:16:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1640189793;
        bh=TCsby42uA+FuWbgLuVxj3SQMufPvwZZ9hyc5xP6jeHQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ll7cMq0L90iis/Am3xdnGGOZI6y/FhWohPcu+fVvoOnswq8J8GURYpp00AhqYpxmJ
         UBX5cca9ZgibfOO5bCDufF5dNKLqaZ1w0NqRm24KTguqEb16M1kf0dYwoJAD6Br8eg
         2mLRX8+s6mkqZ4hfJCa+bYf99/5O7R5zv/iJiHac=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.215.148] ([89.1.215.174]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1OXZ-1mJXNi1fop-012q9b; Wed, 22
 Dec 2021 17:16:33 +0100
Date:   Wed, 22 Dec 2021 17:16:31 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Sean Allred <allred.sean@gmail.com>, git@vger.kernel.org
Subject: Re: Custom subcommand help handlers
In-Reply-To: <211221.86k0fysm0i.gmgdl@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2112221640340.347@tvgsbejvaqbjf.bet>
References: <CABceR4ZW4rRWZnH0ZBkWty_H84Z4CmXque_LO+1edETEWrO8PQ@mail.gmail.com> <nycvar.QRO.7.76.6.2112202324110.347@tvgsbejvaqbjf.bet> <211221.86k0fysm0i.gmgdl@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1308102730-1640189793=:347"
X-Provags-ID: V03:K1:+zN/WgbP3ufgSpaGxcAqwomp+q5dz4Y7WO7oNQ9ISsKAcFbChZC
 sHOzjAfQV7EeNDJsTs/hojDdhXY6L3O/TIVYzQ9a3Xmo2bIcEW0c0wvFIrYl+M+GMcRhAlW
 FZqYVH/mEC2TKwgMnkVR1KBws37r5CqV/yI8jYbe3PH+2Qsqi7PxwMghNTkqCnP3aszakAZ
 n7Ji+K/hF+2Pv8Ob+Vy+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Lomlu3Z3NcI=:uBM9dMjOZUszZsIm7X2+oU
 xPRC3Zkp0mLxzB3CetdBxmqKk76nmZxpWccVkWUyMrvaD1f9aLnDg7Ak5iacnopZMU7girduX
 F/ViIBEenL799otZhpged/TedMXO2eYdKTFEk+Lg2nSQNozU9J9Io6UUb3Cz+UJyZtXtmE6JP
 55LrYIGbXji/OILYu/tylMpUXUE8Uxu3pWMnOMB4jHYTW6AS3rcf/6oL/M+2Dh87ApuXRX7LO
 jM/EYuUUsYN2VBkz2e7ujTurg/a0JfwiD+LHksRyBs/bvD3JGWbe+StFt/NLPaAJkOewY2Le2
 471kyjTiBiH1k+QENbWloB+byQg6MBjuxk5pz1h8qZce7bkQLclzCF5F5BV54Dihr4PEPSKFN
 xKcQwWX0qYRZchbXJhavcZPx42V6EqJdOTpLmO+p/xNt0rS2zXuNKsOVj1HQ6C5GrqWZz+/24
 Gb/3MlYKNrSM2Uhxr7jbxqr4QOzItbGoXuyNcE8JkkqYK9Q1vqZ89FeaMRWwCCouug1tsjMmd
 P8sxEg5ws6SjFV9bWtXhrK5LsJ1fTRjDdwD/+fDSrGAQRml4h3Q24nDNtte3OxzHFn8G2wI94
 xHCgC98DwUguWX/6altqNxZ80eR80gOX2LSjsgEZNcFWmiLEh9k+6zDbB9etYoTOLXDcQuFOh
 lctzB0HmrkBhOnpnkYeToFZ88h2PplZklV7Mm/u3+QGMwbINfTWe1BpDJLns0n/0xAwLpzILG
 pN+hFHbSjBYinytG6lbMJ3pf30s9T4Y0+CpThqpBkayjHZYD9Lrs8hcZol/pnH4l3gBz0T6Cp
 3j3Rpf5a19qwvkYs0q/iRtHIkBl0Dxrg+EqLKX+1zRv+lC8tWGBDb04XQRUHz5ij46hGlz1Hi
 NEYrCdHVYdbLwuVrlyFTQjyMdsZwbBXUDkeJ3d2oiX+oeyNWbq41etwNpEJN0j6O53WNz3Cb2
 YfJtg+Rij5DSMqomwYa+aimwpO2jXzLOlQPYB55ZJEBAkfx7YR/PZuJLTyqEIMuCMdM96BytL
 1PCOMPNQLHOpLatk/FO56pUOTe5ISL4cn3x02RdqonVPpssUHblVHB0cFsBgsfq1AQSwGTUv7
 6/PE1rr02UKxBo=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1308102730-1640189793=:347
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Tue, 21 Dec 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Mon, Dec 20 2021, Johannes Schindelin wrote:
>
> > On Sat, 18 Dec 2021, Sean Allred wrote:
> >
> >> I've got a custom subcommand I'm distributing in my company to integr=
ate
> >> with our bug-tracker. It's a pretty robust utility and has its own he=
lp
> >> function, but running `git foo --help` doesn't pass --help to my git-=
foo
> >> utility. [...]
> >>
> >> What's the best way to go about this?
> >
> > I think you might need to be a bit more careful than just looking whet=
her
> > the command in question is a built-in or not. It could be delivered as=
 a
> > script or executable inside `libexec/git-core`. So maybe check that,
> > something like this:
> >
> > -- snip --
> > [...]
> > -- snap --
> >
> > Of course, this might break existing users' setups where they ship a G=
it
> > command together with a manual page.
> >
> > A potential remedy against that would be, as you say, a config option.
> > Maybe defaulting to the manual page if `help.format` is `man`, otherwi=
se
> > defaulting to passing `--help` to the command.
>
> What are the cases that require us to inexpect our --exec-path at
> runtime, as opposed to having a list of commands we know we put there at
> "install" time?

It is a simple solution. Why even suggest a complex alternative, I wonder.

Ciao,
Johannes

--8323328-1308102730-1640189793=:347--
