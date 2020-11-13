Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2B7C388F9
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 06:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69846208D5
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 06:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgKMGJQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 01:09:16 -0500
Received: from mail-40131.protonmail.ch ([185.70.40.131]:26589 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbgKMGJP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 01:09:15 -0500
Date:   Fri, 13 Nov 2020 06:09:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodman-wilson.com;
        s=protonmail; t=1605247751;
        bh=5/GgBw38W7X1mQtmVIqBHhkG0or37aRbXoCnvcW9uUY=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=VdY15hMXiAom+EzMe6rBCWiOMGBbz5VePtD4vgB/rHkczx086Li2tpjBvMM0XXU94
         7kSkmfr97hfzCC+Py7tVgWAXSvqdJezjucivNpMy3Ci/Wa88x7cV0KswYbJWBWNI3G
         vD5v19KUXU3Zsb+4QysGxaoQSmjEbhdA2sPz2wIwcOvunmCeu16cBbLI42PJStGxHC
         ozntk6ONRdZuTEenlQpJ4sOCbCmHLOIYIGRg9r1+iyH6a2o9HJkNh2rphbODBSNSvv
         pGa+l60NTSgGUQYIE81pswx1j7OanSeyuEzRdPFTng+vMKV7c0uZuL0EjrFlQLE3A+
         ae5rAeehtSphw==
To:     Felipe Contreras <felipe.contreras@gmail.com>
From:   Don Goodman-Wilson <don@goodman-wilson.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Reply-To: Don Goodman-Wilson <don@goodman-wilson.com>
Subject: Re: The master branch rename, and avoiding another v1.6.0 git-foo fiasco
Message-ID: <CAB8EDE5-5082-456E-A585-01E8B9FE548D@goodman-wilson.com>
In-Reply-To: <CAMP44s1U1FevS7NrAYxvgVyzfR5tnD9-+BbPdw5bKnaNHkyD+A@mail.gmail.com>
References: <CAMP44s3BJ3dGsLJ-6yA-Po459=+m826KD9an4+P3qOY1vkbxZg@mail.gmail.com> <20201113010107.GL6252@camp.crustytoothpaste.net> <CAMP44s1U1FevS7NrAYxvgVyzfR5tnD9-+BbPdw5bKnaNHkyD+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Did we hear the testimony of a single black person that was offended
by the word?

> Nobody affected by this change actually asked for this change

Five minutes searching Twitter will reveal a great number of Black git user=
s championing this change.

How is reopening this discussion anything but a distraction?

Don Goodman-Wilson

> On 13 Nov 2020, at 05:27, Felipe Contreras <felipe.contreras@gmail.com> w=
rote:
>=20
>=20
> On Thu, Nov 12, 2020 at 7:01 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
>>=20
>> On 2020-11-13 at 00:04:23, Felipe Contreras wrote:
>>> *If* we are going to rename the master branch, it should be with a
>>> good reason, after discussing it appropriately, in a major release
>>> (i.e. Git 3.0), after a period of deprecation, and a big warning to
>>> invite users to provide feedback about the important upcoming change.
>>> We can hedge these types of changes with a "core.mode=3Dnext"
>>> configuration, as I argued back in 2013. [3]
>>=20
>> When the original email that proposed this change came up, I did suggest
>> that this would be suitable for a Git 3.0.  I think such a version
>> number bump would be valuable, but I know that Git doesn't follow
>> semantic versioning and I'm happy for Junio to make the call.  Git has
>> made incompatible changes in the past in non-major versions, so there is
>> precedent for this, although I agree it has the potential to be
>> surprising.  Again, I defer to Junio's judgment here.
>=20
> I have not been following the Git project for a while, but during the
> Git 2.0 development I proposed considerable drastic changes, which
> Junio said could not fit into v2.0, but perhaps v3.0, which according
> to him: [1]
>=20
> "Even if we end up having to wait for 3.0, it will happen within two
> years max, if not earlier." -- Junio 2014
>=20
> There are actual good backwards-incompatible changes that a new major
> release of Git would benefit from, so if Junio changed his mind about
> considering these types of changes, it would be good to know.
>=20
> I for one haven't noticed a single backwards-incompatible change since v2=
.0.
>=20
>> I should point out that there is an option to test or set this already,
>> with init.defaultBranch.  I have used this feature for testing in the
>> past, and I use the feature now to set default branches.  It's also
>> possible to use the template functionality to set a default branch name
>> for new repositories and I've tested support for this back to at least
>> Git 2.0 (but I believe it goes back even farther).  And, of course,
>> either of these options can be used for developers to choose the branch
>> name which meets the needs of the project best.
>=20
> There was also the option to test the future changes in v1.6.0, that's
> not the point.
>=20
> The point is that users **must be warned**--and very annoyingly
> so--before obsoleting something.
>=20
>> As for consultation with users, there was a discussion about this on the
>> list a few months back and we did get a lot of input from various
>> parties.  Some of that feedback was hostile and inappropriate and some
>> even violated our code of conduct in my view, as is all too common with
>> potentially controversial topics, and I'm not eager to repeat such a
>> discussion, since I don't think it's going to result in a productive,
>> positive outcome.
>=20
> I looked for this kind of discussion, but didn't find it. I didn't
> imagine it was as far back as June.
>=20
> It took a while, but I finally read the whole thread, and I understand
> your unwillingness to repeat such a discussion, but unfortunately it
> will have to happen again, because the people that participated in
> that discussion are but a tiny minority that is not representative of
> all Git users. If not now, it will happen in the future. This is
> exactly what happened in 2008, when the issue was discussed in at
> least three big threads.
>=20
> Moreover, my point was not discussed in that thread. You mentioned it,
> but everyone focused on tangents, such as the state of the culture
> war, and the etymology of the word "master".
>=20
> To try to save your sanity I will attempt to be brief (but probably
> not as brief as you would like to).
>=20
> This is what was discussed:
>=20
> 1. Adding a configuration (init.defaultbranch)
> 2. Should the name of the master branch be changed?
> 3. Best alternative name for the master branch
> 4. Culture war
> 5. The impact to users
>=20
> I have a lot to say about 4, 3, and 2, and perhaps I will do so in
> another thread, but that's not important, what is important is the
> thing that was not discussed: the users.
>=20
> I like to refer to a panel Linus Torvalds participated in regarding
> the importance of users [2]. I consider this an explanation of the
> first principles of software: the main purpose of software is that
> it's useful to users, and that it continues to be useful as it moves
> forward. To quote Torvalds:
>=20
> "Any time a program breaks the user experience, to me that is the
> absolute worst failure that a software project can make." -- Linus
> Torvalds
>=20
> This is the first thing the Git project should be worried about, not
> the current state of the culture war, and I didn't see anyone
> championing the users, and how this change will negatively impact
> their experience, which arguably has been pretty stable throughout the
> years (at least since 2008).
>=20
> That being said, I want to touch on only one point you brought
> forward, that is indirectly relevant to the users.
>=20
> You mentioned the importance of intent [3], and how we can never be
> certain of the intent of another person, this is true. However, we
> must try to guess what the interlocutor might have meant, otherwise
> there is no point in communication. This is realized in Wikipedia's
> fundamental principle of always assuming good faith [4], Grice's
> philosophical razor: prefer what the speaker meant over what the
> sentence they spoke literally meant [5][6].
>=20
> You cannot stand in a comedy special without realizing what the comic
> actually means, and it rarely is what he literally says. If I utter
> the phrase "kill me now", you know what I mean, or more importantly;
> what I don't mean.
>=20
> A lot of people today want to ignore this fundamental aspect of human
> language, and they do so for political reasons. But it doesn't stop it
> from being the case. It's not a coincidence that since 2005 nobody had
> any problem with the word "master", it's only in 2020 that the issue
> "magically" popped up. And it's no coincidence either what kind of
> people are pushing for this change.
>=20
> This is a solution looking for a problem.
>=20
> There is a concept called "the silent majority" which applies in
> software. Most Git users are not going to participate in culture war
> debates in the mailing list. It is usually a tiny vociferous minority
> that drives these kinds of discussions (and if it has to be said; I
> don't mean any negative connotation, simply stating that they are the
> opposite of silent). Even the users that are supposedly the target of
> these progressive changes (e.g. black users descendant of slaves) will
> probably not care at all about such changes, because they are part of
> the silent majority that uses common sense and understands that
> nothing ill was intended by the word "master". It is usually white
> people that "defend" these "oppressed minorities" without their
> consent, or need.
>=20
> Did we hear the testimony of a single black person that was offended
> by the word?
>=20
> The intellectual Gad Saad wrote about a disorder called Munchausen
> syndrome by proxy, and how it explains what many modern activists do:
> [7]
>=20
> "Munchausen Syndrome is where a person feigns illness, or medical
> conditions, to garner empathy and sympathy. Munchausen Syndrome by
> proxy is when you take someone who is under your care (your biological
> child, your pet, your elderly parent) and then harm that person or
> entity that=E2=80=99s under your care so that you can then garner the emp=
athy
> and sympathy by proxy."
>=20
> Nobody affected by this change actually asked for this change, it is
> being done *preemptively* just in case some actual target user might
> find it offensive. The only people actually being offended are
> offended *by proxy*.
>=20
> I recommend the book The Parasitic Mind: How Infectious Ideas Are
> Killing Common Sense, which explains this and many more problems of
> the current culture war.
>=20
> I have a lot more to say about this, believe me, and perhaps I will do
> so in another thread, but for now the summary is this:
>=20
> We are going to *actually* harm true users that understand the intent
> behind the word "master" hoping we might benefit marginally some
> imaginary users.
>=20
> And if we don't warn them about the upcoming change, before the change
> is actually implemented (as we did with push.default), they will
> complain. Because unlike the users that are descendants of black
> slaves who misinterpret what Git developers meant by the word "master"
> and get offended as result--they are *real*, and they are a lot.
>=20
> Cheers.
>=20
> [1] https://lore.kernel.org/git/xmqqioq12eif.fsf@gitster.dls.corp.google.=
com/
> [2] https://www.youtube.com/watch?v=3DkzKzUBLEzwk
> [3] https://lore.kernel.org/git/20200614190842.GC6531@camp.crustytoothpas=
te.net/
> [4] https://en.wikipedia.org/wiki/Wikipedia:Assume_good_faith
> [5] https://rationalwiki.org/wiki/Logical_razor#Grice.27s_razor
> [6] https://plato.stanford.edu/entries/implicature/
> [7] https://thoughteconomics.com/gad-saad/
>=20
> --
> Felipe Contreras


