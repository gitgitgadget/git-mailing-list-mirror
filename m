Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A523C433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 21:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhLTV1p (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 16:27:45 -0500
Received: from mail-4319.protonmail.ch ([185.70.43.19]:58123 "EHLO
        mail-4319.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbhLTV1o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 16:27:44 -0500
Date:   Mon, 20 Dec 2021 21:27:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1640035662;
        bh=1QlowpRkdFigL4B1qRxTzRDvfuKsCYJArGQLO0Ff4XM=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=Oz/+qHiD21rBUXlhi3Qrr5ch9+Mr266EY9Rorn5R4uGyonl/1iseYD7OlnR/lRf30
         jDZsObjoYkaMySy9D8b6924YDKQdKbRVE0CHJhy6EiIcavKyLcIToZ92O73OoYUns1
         jD2H84WWn5PIztSBDzTDBu5N/exbmGj3GtrdAM4e8oXiFBKerxNBCICf4PmP0Ak+zg
         6N1FpVWGKegwhtbz+dpdHaU4/BsTuszNYbV5m+3fNHJZMgaGgSMKCrZTTBVAEfpR3N
         HkAV2xt5CrAwM//VyHVX0JJ+cERrwoKfX6hOr4oLDLIEfgIhWnHhW5CD8KJkmS+r4l
         bRtUjjT87BS0w==
To:     Eric Sunshine <sunshine@sunshineco.com>
From:   =?utf-8?Q?Jo=C3=A3o_Victor_Bonfim?= 
        <JoaoVictorBonfim+Git-Mail-List@protonmail.com>
Cc:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Glen Choo <chooglen@google.com>, calvinwan@google.com,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Reply-To: =?utf-8?Q?Jo=C3=A3o_Victor_Bonfim?= 
          <JoaoVictorBonfim+Git-Mail-List@protonmail.com>
Subject: Re: Review process improvements
Message-ID: <J3wlC13aBBawF42_jmIX-9_4S5yvG4W-8miLgPASeby-v_QHn5Vw72gGy8E8WB-TQhGvrvpeC4Y2PnTIy3b1o6In_WHDzZ3s9nf2getOzRU=@protonmail.com>
In-Reply-To: <CAPig+cT+NshUMS+BNLKDMuwOEXKEzS3Ve=hK3kCYEBvJNzXuxQ@mail.gmail.com>
References: <YbvBvch8JcHED+A9@google.com> <211220.86fsqnwkzs.gmgdl@evledraar.gmail.com> <CAPig+cT+NshUMS+BNLKDMuwOEXKEzS3Ve=hK3kCYEBvJNzXuxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I added on to this on another e-mail thread, however, it got no response, s=
pecially because I didn't have an e-mail to reply to, so I am copy and past=
ing the messages here.

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 E-mail one =
=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
 First and foremost, there is a saying in Brazil that goes by as "an empty =
bag never holds itself standing", so always remember to care for yourself, =
eat a snack, drink fluids of your choice (from tea, water and coffee to sou=
p and porridge), rest a little, stop doom scrolling social media and so on.

 Second, want to address the giant essay by Emily Shaffer (aka: Review proc=
ess improvements) and give my opinions on some of the points made. Third, s=
orry for the botched response, but I wasn't on the mailing list before the =
mail was posted, so couldn't directly respond the message.

 Addressing point #1, titled "Draft a MAINTAINERS file": seems quite reason=
able, I would also like to address some matters about this, first is that t=
here is no point of contact for "trusted sources" within the git project an=
d it is quite negative for historical purposes, because maintainers and mor=
e prolific parties will inevitably retire or move on from Git themselves an=
d their prestige won't be recorded beyond their commit history within the p=
roject and it might lead to their contributions being forgotten. Second is =
that it is hard to know who is responsible to what from the get go without =
being in the know already. Third, please make all entries on any and such f=
ile that might auto send messages non-committal, why? Nobody wants to recei=
ve a message from a third party that the git mailing list deems "trustwothy=
" only for it to be some scam of sorts that only happened because a modific=
ation to the file managed to fly under the radar, so make it a one way pass=
 and all tags are only to people, not from. Fourth, I, personally, only wan=
t to partake on discussions, but barely want to see patches and commits, ma=
ybe allow for some sot of group inheritance and group message allow or deny=
 lists? So people that don't want patches don't receive patches, but they c=
an filter to receive only "memory allocation" topics, but they won't receiv=
e patches that are for memory allocation, because the "patches" and "discus=
sion" topics take higher system priority than the "memory allocation" topic=
, be it user by user or system wide. Maybe also auto-filter messages, even =
in a dumb way or in a sender dependant way.

 Addressing point #2, titled "Draft a ReviewingPatches doc", and point #3, =
titled "Google Git team will review cover letters and commit messages inter=
nally before sending series to the list": not much to say beyond, people, s=
hare your reviewing know how, including you Google folks, if you interpret =
the reviewing process as an algorithm, it would make sense that all mechani=
sms of human interaction and review to be shared as part of the code base. =
So please, Google people, share what and how you do your reviews. It is als=
o a matter of security, if your review process isn't transparent, we can't =
know whether we can trust everything you provide, because you might be leav=
ing or dismissing problems and it might fly under the radar or malicious ac=
tion could be taken and, since the group as a whole is already trusted, som=
e malicious code could be included, even if it is not explicitly so.

 Addressing point #4, titled "Documentation changes to encourage commit mes=
sage quality": This isn't stressed enough in many Git tutorials and the lik=
e, and it should, the commit messages are for the journaling of changes, so=
 you or third parties can understand the thought process behind changes and=
 not feel like headless chickens running around a barn whenever you attempt=
 to understand what has been done, maybe addressing it on the source code o=
f git and its documentation might help address this topic.

 Extra notes: As a person with ADHD, REAMEs can be daunting at times, speci=
ally when they are boring word walls, and they can be incomplete or repetit=
ive if there are other documents addressing information contained within th=
em, maybe reference files such as "Contributing.md" instead of copying them=
 verbatim? An example would be "To read more on how to contribute to projec=
ts, read 'Contributing.md'." instead of what is information contained withi=
n "Contributing.md", it would help a lot with human to human interactions.

 Thanks for the attention, take care!

 Jo=C3=A3o Victor Bonfim (any pronouns).
=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 E-mail two =
=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
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

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90------------=
=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90

Yes, I know I wrote an essay-esque message myself.
It was a lot.
Hope it helps to move the conversation along.

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90

Em segunda-feira, 20 de dezembro de 2021 =C3=A0s 14:14, Eric Sunshine <suns=
hine@sunshineco.com> escreveu:

> On Mon, Dec 20, 2021 at 7:27 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>
> avarab@gmail.com wrote:
>
> > Whereas the only cases that really applies to in git.git (and I think i=
t
> >
> > might be useful to have a MAINTAINERS for these) are:
> >
> >     # but not all of po/, see caveats in po/README etc.
> >     po/ -> https://github.com/git-l10n/git-po/
> >     # Pulled from their respective upstreams
> >     {gitweb,git-gui}/
> >     # Anyhing else I'm missing? Maybe {sha1dc,sha1collisiondetection}/*=
?
> >
> >
> > We should be leaning into helper scripts like
> >
> > contrib/contacts/git-contacts (and I'm aware of some out-of-tree "bette=
r
> >
> > git-contacts", but have not used them myself).
>
> For completeness, the granddaddy of out-of-tree "better" tools is
>
> Felipe's git-related[1], which is maintained and more functional.
>
> [1]: https://github.com/felipec/git-related
