Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0CFC433E0
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 20:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 075112151B
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 20:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbgLWUZg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 15:25:36 -0500
Received: from mout.gmx.net ([212.227.15.19]:59557 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbgLWUZf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 15:25:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608755042;
        bh=Q51of7X7R7tN17Bup7/ciiAvdM7LLr5QA7SX0lbhVJ0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=R8puJeLXL/1vqMMBv+q4X8TVDs6EgMh+2+E2EEOAgNtwVbx9XubGeHuzeLEbkue6n
         poH05XS5vHP3dCOR7p5wGI7aib2l2SH6zNC2vZkvGDjDC0MRXhTrgkhWN9cMMDWwF0
         MtDnI/Tnw6S17IXxZOauikZh0sw+78HV+VYI1dE8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.251.4] ([89.1.213.150]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mj8mV-1kO4al2gOj-00f9NS; Wed, 23
 Dec 2020 21:24:02 +0100
Date:   Wed, 23 Dec 2020 21:24:00 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee <stolee@gmail.com>
cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] CODE_OF_CONDUCT: expect tolerance, not respect
In-Reply-To: <X+OkOGkBrpbHhHkb@camp.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2012232122460.56@tvgsbejvaqbjf.bet>
References: <20201223061718.102779-1-felipe.contreras@gmail.com> <3d21cc06-415d-860b-7bd2-31047d68bc05@gmail.com> <X+OkOGkBrpbHhHkb@camp.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:WZyos0boiXuOb1KcFaSavkOKUBcQZbuUtTW3a6sqail3W73WP3W
 xWGvvUF1Zzz4Gi5UtN9FR4NRCZiBX2pqAYFpCLrhklDdhaYWpwELUwMXcEfcX2H//RLP1ir
 sdGWGEuQycDcJ+xDdhJeQbqjry5EyP10iRp/9jIFPvPwafqiOMSSGIls6KWhgkKWNVTB0sQ
 2bQCsk5DpEFrCAohp/tIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PTP2DYgRy/8=:qL++bK+1/JU4Ud1PUW7xtg
 BykXTS3kMB2CN2+Ib1X7H7R5L9rLE02AdLSQhDtoyYMMLyBpIloI8nkvsGEfQF6Jz1P4Mm8nB
 rpIeXneEftzToWdPHIgpMKWXlrg1XKAEhXfPi8c4RP/vjrhDrEmDmWMSvC2mQAHHb7nffXb6K
 IAp14aq2KnOGfMVz8MMDz0MQUdDggXWAMdOMvbCT4Fbol0+KyiXATLAv/RuKFuMLbsjfJv5wX
 OtjUGyZyXiTNKhww0f9UyF9DwaA1pmpZDjMYCBq3hXA2wA7rGHybVwPylri98xYVuxbO/ZY3L
 5mVuRHbgTLhLwNoZeCHri6yO8ZpQWukRPL0DfRtZxnrk2/oURXpS3Pkv56U5bgJzXvYs/Kxc+
 X9PyJ3PNeFOJWleAaqJYdZkB+HY8fvgV7qa1xmLqFBY7Q3GY61TWZhSFk4Lvw7l37rZQxX7PA
 t20gMb6EXO9FNjmSmXw+IgWrFxGibGLW7MEB0BRaMFvxkaXxnyblQnI4VsLZNg/Oi7X1oFVqN
 hAAwyTzPGaIWIyYZMADhGDMhSxd6GpqfDPg4fC9a0sv0x7D4Jle+kFX7ZCPMNXjiqdH06V0FP
 rPSfu0Z4I45UAbzROo3xCOGHX4SXksG5OytS9ZE0NPCthgtmWg+A73BuhIIKhCk7MQToEOll0
 vOF7pKNRl0UvjOHvMk0V989kz6SXkPN4D13SHe5V4RoEbiXLCOTCopYfdOGIuGmkVWSgzWyBT
 +nbyuNkTx3njthu4dtw9Y/9PGUIcbapojNiwMHk5rhQZB/FKb85mr+zUHLqU3VPiQv7uH/8pH
 LtMcFSJrrOzmWIu9hqj3VSPd1AA0bGuxHUGnS+7kaJvBbwPqsGW4Q3ZlAv6xdfm2q2jX4AovB
 1di5TnTpt/ReTCooaCPz3eUurgsj+LFd0ZHNfvSFM=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

[dropping brian from the Cc: list as per their request]

On Wed, 23 Dec 2020, brian m. carlson wrote:

> On 2020-12-23 at 14:46:56, Derrick Stolee wrote:
> > On 12/23/2020 1:17 AM, Felipe Contreras wrote:
> > > As many argued; respect cannot be manufactured at will. If you don't
> > > respect an idea (for example that the Earth is flat), then it doesn'=
t
> > > matter how hard you try; you still will not respect it.
> >
> > ...
> >
> > >  * Using welcoming and inclusive language
> > > -* Being respectful of differing viewpoints and experiences
> > > +* Being tolerant of differing viewpoints and experiences
> > >  * Gracefully accepting constructive criticism
> > >  * Focusing on what is best for the community
> > >  * Showing empathy towards other community members
> >
> > As mentioned in 5cdf230 (add a Code of Conduct document, 2019-09-24):
> >
> >     This patch adapts the Contributor Covenant Code of Conduct. As opp=
osed
> >     to writing our own from scratch, this uses common and well-accepte=
d
> >     language, and strikes a good balance between illustrating expectat=
ions
> >     and avoiding a laundry list of behaviors. It's also the same docum=
ent
> >     used by the Git for Windows project.
> >
> > It is highly recommended to stick to the widely-used and carefully
> > crafted phrasing.
>
> I am also strongly in favor of keeping the commonly used wording.  If
> you feel that wording is inappropriate, it would be better to have the
> change adopted upstream.

Just in case another vote is needed to keep the current form: here is
mine.

Thanks,
Dscho
