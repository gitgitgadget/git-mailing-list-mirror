Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B45C433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 03:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237357AbhLTDfW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Dec 2021 22:35:22 -0500
Received: from mail-0201.mail-europe.com ([51.77.79.158]:59201 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233995AbhLTDfW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Dec 2021 22:35:22 -0500
Date:   Mon, 20 Dec 2021 03:35:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1639971318;
        bh=4SipH2Bu2EIcFeqf/HAds2pV5JG4AP6MgIbeVJVtvbY=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:From:To:Cc;
        b=Et1JGTxxXoH1GlxxfIIN0GfL0FnD/tY2xjZqwYj6wjgDh9U/KbiWNgMmAFw1OGfQ7
         oPzZkG8oI3XM2tOflqh5uiUuOM35NTiFY0a4PmN3FqnduQ1S8qQSxaVsDmCPhRuE2y
         yzf6Xe2sQqK65dMuMn8Oe/tv9UCjDv8orkUuXk2w6sVWnxD88E/xzETfEIn3pQok6w
         2W+ToYl+A29AyHyZtYp1YgIlDB2CNTNxbms7+/VeNKFkjdyMiUdzAIR/hlkzdjg1Vg
         rUpEmEk19oglv8/Qscf/GpanWKaKxLaRAzfLRAwm1AghRuOMl9bud5Guj534x31EKN
         2hlghNYPsPgdw==
To:     "emilyshaffer@google.com" <emilyshaffer@google.com>
From:   =?utf-8?Q?Jo=C3=A3o_Victor_Bonfim?= 
        <JoaoVictorBonfim@protonmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Reply-To: =?utf-8?Q?Jo=C3=A3o_Victor_Bonfim?= 
          <JoaoVictorBonfim@protonmail.com>
Subject: Re: Review process improvements
Message-ID: <l_ow6mXECNtAIpZlu0hT_Fd2RE1zbqJjCEwzqeGMdFJsu8o-Ue1QhFU5Y0OJNaXnKEFsttuHkNS9QgrQeWoCaQSJKNKlBraDWpsTUyrrw_Y=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
, be it user by user or
system wide. Maybe also auto-filter messages, even in a dumb way or in a se=
nder dependant way.

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
