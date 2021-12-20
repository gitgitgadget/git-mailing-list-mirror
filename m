Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC553C433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 03:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237371AbhLTDrJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Dec 2021 22:47:09 -0500
Received: from mail-0201.mail-europe.com ([51.77.79.158]:57293 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237307AbhLTDrI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Dec 2021 22:47:08 -0500
Date:   Mon, 20 Dec 2021 03:47:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1639972025;
        bh=+CPC0aYIj/gUBUkThqpfROfLSnfhLHbz1b9EUOgCIes=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=B78/yVIX/UKwLxZntsEcI0ahO9e9JdSKyWNRfqtIJA2Fn1r1UZ6SBX5ljkISD+JxT
         O01xWU2RF+woYgUb0CzzPVAbI1NkTe9rY1WzUR9CbbPwKpAS7j5OgWKU3alsTSMvyg
         plG1ddHwBVJYYmzyjmgNHEKNBzKeoH3nR6QkCV9PUmJPrcs4p26KERGbP7XO2gGBcF
         YDWPzFOrhg7Ab6jdXf8bXY68AlijVZtGnfdcEo2vdAU/KBDVBUuuhYnhn6vMSFZGCN
         K/lB6Cp7G4rtuaV2sea+xCWav4bsW+yTfW8BBpLxuM4+/yly0Ty4jS+3nPz4k3BFm3
         Kif9vw8+J+O7Q==
To:     "gitster@pobox.com" <gitster@pobox.com>
From:   =?utf-8?Q?Jo=C3=A3o_Victor_Bonfim?= 
        <JoaoVictorBonfim+Git-Mail-List@protonmail.com>
Cc:     "emilyshaffer@google.com" <emilyshaffer@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Reply-To: =?utf-8?Q?Jo=C3=A3o_Victor_Bonfim?= 
          <JoaoVictorBonfim+Git-Mail-List@protonmail.com>
Subject: Re: Review process improvements
Message-ID: <PG21Is5hk4g4UczwJ3KWm5PECcgG_znjB-Q9AlIZqnKS9hM9JKIYGywQJ_rY2DljLpa-JNO3qgo5P8uM-wA1Qk2UyH1kIUIYD93-Zgg93t4=@protonmail.com>
In-Reply-To: <l_ow6mXECNtAIpZlu0hT_Fd2RE1zbqJjCEwzqeGMdFJsu8o-Ue1QhFU5Y0OJNaXnKEFsttuHkNS9QgrQeWoCaQSJKNKlBraDWpsTUyrrw_Y=@protonmail.com>
References: <l_ow6mXECNtAIpZlu0hT_Fd2RE1zbqJjCEwzqeGMdFJsu8o-Ue1QhFU5Y0OJNaXnKEFsttuHkNS9QgrQeWoCaQSJKNKlBraDWpsTUyrrw_Y=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To address Junio Hamano's comment:
>  But don't spend too much time on it to waste your momentum.  Having
> sounding board in your buddies is much better than not having any,
> but your buddies may already share too much background context with
> you to blind them from noticing why it is unclear to outsiders.

 Maybe ask someone like your mom, dad, aunt, cousin, long past college acqu=
aintance to comment on the commit/log/patch comment itself and maybe also t=
he code published? It might me more helpful the less they understand about =
code or are knowledgeable about your personal quirks.

Jo=C3=A3o Victor Bonfim (any pronouns).

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90

Em segunda-feira, 20 de dezembro de 2021 =C3=A0s 00:35, Jo=C3=A3o Victor Bo=
nfim <JoaoVictorBonfim@protonmail.com> escreveu:

> First and foremost, there is a saying in Brazil that goes by as "an empty=
 bag never holds itself standing", so always remember to care for yourself,=
 eat a snack, drink fluids of your choice (from tea, water and coffee to so=
up and porridge), rest a little, stop doom scrolling social media and so on=
.
>
> Second, want to address the giant essay by Emily Shaffer (aka: Review pro=
cess improvements) and give my opinions on some of the points made. Third, =
sorry for the botched response, but I wasn't on the mailing list before the=
 mail was posted, so couldn't directly respond the message.
>
> Addressing point #1, titled "Draft a MAINTAINERS file": seems quite reaso=
nable, I would also like to address some matters about this, first is that =
there is no point of contact for "trusted sources" within the git project a=
nd it is quite negative for historical purposes, because maintainers and mo=
re prolific parties will inevitably retire or move on from Git themselves a=
nd their prestige won't be recorded beyond their commit history within the =
project and it might lead to their contributions being forgotten. Second is=
 that it is hard to know who is responsible to what from the get go without=
 being in the know already. Third, please make all entries on any and such =
file that might auto send messages non-committal, why? Nobody wants to rece=
ive a message from a third party that the git mailing list deems "trustwoth=
y" only for it to be some scam of sorts that only happened because a modifi=
cation to the file managed to fly under the radar, so make it a one way pas=
s and all tags are only to people, not from. Fourth, I, personally, only wa=
nt to partake on discussions, but barely want to see patches and commits, m=
aybe allow for some sot of group inheritance and group message allow or den=
y lists? So people that don't want patches don't receive patches, but they =
can filter to receive only "memory allocation" topics, but they won't recei=
ve patches that are for memory allocation, because the "patches" and "discu=
ssion" topics take higher system priority than the "memory allocation" topi=
c, be it user by user or
>
> system wide. Maybe also auto-filter messages, even in a dumb way or in a =
sender dependant way.
>
> Addressing point #2, titled "Draft a ReviewingPatches doc", and point #3,=
 titled "Google Git team will review cover letters and commit messages inte=
rnally before sending series to the list": not much to say beyond, people, =
share your reviewing know how, including you Google folks, if you interpret=
 the reviewing process as an algorithm, it would make sense that all mechan=
isms of human interaction and review to be shared as part of the code base.=
 So please, Google people, share what and how you do your reviews. It is al=
so a matter of security, if your review process isn't transparent, we can't=
 know whether we can trust everything you provide, because you might be lea=
ving or dismissing problems and it might fly under the radar or malicious a=
ction could be taken and, since the group as a whole is already trusted, so=
me malicious code could be included, even if it is not explicitly so.
>
> Addressing point #4, titled "Documentation changes to encourage commit me=
ssage quality": This isn't stressed enough in many Git tutorials and the li=
ke, and it should, the commit messages are for the journaling of changes, s=
o you or third parties can understand the thought process behind changes an=
d not feel like headless chickens running around a barn whenever you attemp=
t to understand what has been done, maybe addressing it on the source code =
of git and its documentation might help address this topic.
>
> Extra notes: As a person with ADHD, REAMEs can be daunting at times, spec=
ially when they are boring word walls, and they can be incomplete or repeti=
tive if there are other documents addressing information contained within t=
hem, maybe reference files such as "Contributing.md" instead of copying the=
m verbatim? An example would be "To read more on how to contribute to proje=
cts, read 'Contributing.md'." instead of what is information contained with=
in "Contributing.md", it would help a lot with human to human interactions.
>
> Thanks for the attention, take care!
>
> Jo=C3=A3o Victor Bonfim (any pronouns).
