Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B0891F463
	for <e@80x24.org>; Tue, 24 Sep 2019 13:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505039AbfIXNVP (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 09:21:15 -0400
Received: from mout.gmx.net ([212.227.15.18]:33259 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728325AbfIXNVP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 09:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569331259;
        bh=oFI/BPy9qGAff2a6yBGxbOyYXYqvYimg1cPqd5BQn4I=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TSIHeI5yxc48/J1Snk+V6ENpdnR2vxmEN0O3ODQ7ww5vSBRUN0Z3GTA5xDRlVa6vN
         MFP+VR8sYQMZFmX/F7SVsO06Gcgfp4idZ2GpYM58BnBoTdNV50PoqvVhbFVG1sLFLU
         cvAM42FeZqEY6NbZpBrSaxkLg7qpjT9tvRUHUJsk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1HZo-1i9zrF0aMc-002kza; Tue, 24
 Sep 2019 15:20:59 +0200
Date:   Tue, 24 Sep 2019 15:20:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        git@sfconservancy.org, Derrick Stolee <stolee@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, garimasigit@gmail.com
Subject: Re: [PATCH] add a Code of Conduct document
In-Reply-To: <20190924090152.GA7209@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1909241426580.15067@tvgsbejvaqbjf.bet>
References: <20190924064454.GA30419@sigill.intra.peff.net> <20190924090152.GA7209@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1837161224-1569331259=:15067"
X-Provags-ID: V03:K1:nkl6PAaETL9MKCERFJMZqYObbHUQIWuiPNd4qKR6urQx3uXg0jc
 pW2Nq/n2UnTaPtZN7wrx+c7TPmLipyHtRgXhykiW1eC9E7i0moE5edK5db7MKfWr/1p2EUV
 JSW/KHuJSJ0HqjgttgV6A4kQbVZMnz+WcDqIwXLAQMS0b7aek1Cskt9Xbw8wpfCV+XKBdTj
 yhioS39Rmu/em7cTycoKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OTNAjJmKYHA=:0vivhPu9Cp2D3FEaBYBuMC
 eWuCxcatbZMER+0uEzlgnAc3GyfQu5ZJjnHcUsf5K56hEBMCWYpmbIxP//YSxW++F9mvq+Dbv
 E0BFBocea5SUl+5Te4ZyXwJrkQwAhwfwjaaWBIqZAyONJ4WONpv75XvR/sw98rW4LFWgyqdS9
 xVwOydYF+AdaPZoeyKMQaUObpG5I2qW8CzXkPcbEyzAychnpyM1BwLNIlhUDFc01YD5BIz4go
 TPsGXW8g8k2BeX6AthU1jYOASWd935J4kRCMdtWVKhTMD/jFM/E7ZZfCoqukUSslSDshxjJEe
 S5eaQ2CT07uYVvPe4oSBtSyXjrVPQxmLinanSEcEbCK+cQQzQJu8rn147YfYjjmKaezbPeBQ+
 tz0Ow5cJqyZUY4ypWN5YCUWfu+fIMinxgIFImzCRuHdeGHq/Hba3uvp/UuB1EtRHjZNxGu7iV
 yvr4Hbog9NCeAp+jlqovK32T1We4gz/3jPTHCu2w05rd3mgPiSAtm+5d6YwKvy7w4uDB+ovgC
 6RLcAZ9ZkFkRuSB2OJWwoEsxqNAPF7+j0kKLiqrWPH4Mlxs6spjF7bDSJZjKRuBDF1KB1aYEo
 Tpq2DQ+xGkyCu9M0F1bw3eO9GG0jMdrv9wtDdNagDTDLap+sdGbH00SDzX0Or2bquJUiTZiOn
 zknEqKcLsNMDn2BFlgTEfVBVkKTd5xXyHMGjGyOwgiMhWQBar72Dg5wf6IgzPLknoNx2DIvzQ
 Hs9l7FVas1rSEH8tdcfUC8d9uQ5Cf35Nqn9OwQwaMhLJnE31tiYPX+hG6tdDgjZflU2atNg13
 d5uHhjFtzrMR0RnSDYp34dVYMA3rvn6VfmDFmJlKwuN+0/KCtBChochallHZtHiiHcGJtZZ07
 UqXVefz5HSO92KWKaUgyhXSBpZOVA3UfqWD5M5Ciw2EJxSYlRClOgcqjDg+hTvBU/eE9rHlrn
 QdnVUtgIOdrnZ1InY/Lz2MpApTaIHe86Vb0GRZQPw3D1/1reB5JHD1LJGfYr4UFzNRiqNCF6j
 eDCB0Azy1slRRpUOvdpGjOpgszhC/BtkrbxxijDO8FNl5CoUD/YGT+7MULP45Prj2WiScafPY
 VzZYBOSSU4yU57Gq9+mL3QNBKZOexMxxy+T9x9+SDTJLEsb4IKDPDjT8woUyukBkzOfBT5pkx
 rJpsHGL93ZDnASMpeg15PzBSEaZdpWNZNwgJxhB+VxisP8EcB6pNNzHfBqTc+dWFNap4teVTw
 v3izqTZPObm/bWWh1pORMEim35OHnFMFh+XYh1N5qxvWLC9BGISp/Hn7u+Dc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1837161224-1569331259=:15067
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Tue, 24 Sep 2019, SZEDER G=C3=A1bor wrote:

> On Tue, Sep 24, 2019 at 02:44:54AM -0400, Jeff King wrote:
> > We've never had a formally written Code of Conduct document. Though it
> > has been discussed off and on over the years, for the most part the
> > behavior on the mailing list has been good enough that nobody felt the
> > need to push one forward.
> >
> > However, even if there aren't specific problems now, it's a good idea =
to
> > have a document:
> >
> >   - it puts everybody on the same page with respect to expectations.
> >     This might avoid poor behavior, but also makes it easier to handle
> >     it if it does happen.
> >
> >   - it publicly advertises that good conduct is important to us and wi=
ll
> >     be enforced, which may make some people more comfortable with
> >     joining our community
> >
> >   - it may be a good time to cement our expectations when things are
> >     quiet, since it gives everybody some distance rather than focusing
> >     on a current contentious issue
> >
> > This patch adapts the Contributor Covenant Code of Conduct. As opposed
> > to writing our own from scratch, this uses common and well-accepted
> > language, and strikes a good balance between illustrating expectations
> > and avoiding a laundry list of behaviors. It's also the same document
> > used by the Git for Windows project.
> >
> > The text is taken mostly verbatim from:
> >
> >   https://www.contributor-covenant.org/version/1/4/code-of-conduct.htm=
l
> >
> > I also stole a very nice introductory paragraph from the Git for Windo=
ws
> > version of the file.
> >
> > There are a few subtle points, though:
> >
> >   - the document refers to "the project maintainers". For the code, we
> >     generally only consider there to be one maintainer: Junio C Hamano=
.
> >     But for dealing with community issues, it makes sense to involve
> >     more people to spread the responsibility. I've listed the project
> >     committee address of git@sfconservancy.org as the contact point.
> >
> >   - the document mentions banning from the community, both in the intr=
o
> >     paragraph and in "Our Responsibilities". The exact mechanism here =
is
> >     left vague. I can imagine it might start with social enforcement
> >     (not accepting patches, ignoring emails) and could escalate to
> >     technical measures if necessary (asking vger admins to block an
> >     address). It probably make sense _not_ to get too specific at this
> >     point, and deal with specifics as they come up.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > Obviously related to the discussion in:
> >
> >   https://public-inbox.org/git/71fba9e7-6314-6ef9-9959-6ae06843d17a@gm=
ail.com/
> >
> > After some poking around at various CoC options, this one seemed like
> > the best fit to me. But I'm open to suggestions or more discussion. It
> > seems to me that the important piece is having _some_ CoC, and picking
> > something standard-ish seems a safe bet.
>
> We are decent people,

Okay, you are _asking_ for a devil's advocate, like, _really asking_ for
it, and I will bite.

You don't know that we are decent people. I don't know whether you are a
decent person, neither do you know whether I am a decent person.

To make things worse: your concept of "decent" might be very different
from mine. In fact, I am almost certain that they are different, _and_
Git is an international project that attracts different people that have
yet different notions of what constitutes "decent".

Concrete example: a former mentee of mine, from a different cultural
background than mine, found it indecent to voice disagreement with me,
on the sole ground that I was their mentor. Let that sink in for a
while. In the Git project, we _expect_ contributors to disagree with
reviews that miss a point, to make a counterargument. That act alone
would have been considered "indecent" by at least one contributor.

And to make things _even_ worse: even a decent person has bad days, and
bad days make for poor decisions, including how to treat fellow human
beings. Having a "banister" (as the CoC would provide) is pretty helpful
on those days.

> and know how to behave properly and treat each other with respect.  It
> is my fundamental assumption that all future contributors are decent
> and respectful human beings as well.

Judging from certain examples in the past, I expect that Git will see
the occasional future contributor where having a CoC comes in real
handy.

> A CoC like this, which is "explicit about the behavior we want to
> model" (quoting the original discussion starter) inherently insinuates
> that we aren't decent, and can't behave without being told how to do
> so.  Frankly, I find this borderline insulting to me, to my parents,
> to all fellow contributors, and to future contributors as well.

By that token, you should find any law offensive that forbids you from
stealing. Because you, and your family, are not thieves.

Does that sound reasonable? I would contest that.

Just because you abide by a code of conduct does not mean that you are
prone to violate it. In fact, I would expect that those who are the
least prone to violate it are the ones who would be least opposed to
one: what would they have to fear from it?

> There are locations, nationalities and cultures, where the avarage
> wide-spread CoCs, like Contributor Covenant and its derivatives, are
> perceived as (paraphrasing) too "American", politically overcorrect,
> corporate BS, etc., which are forced upon open-source projects.

This knife cuts both ways, of course. I cannot count how many times I
heard unflattering things about e.g. a former Hungarian colleague of
mine who voiced opinions that were, at times, quite offensive to the
rest of the staff, and it was often excused as "East European".

In a multi-cultural team, respect often comes in the form of learning
about one another's cultural background, and compromising, sometimes
unexpectedly so.

A CoC can very easily create clarity in such circumstances. By stating
explicitly the standards to which we promise to hold ourselves, as well
as others. And it can even help those who think of themselves as decent
to improve on that front.

Example: in Git for Windows, we adopted a variant of the Contributors'
Covenant a couple of years ago. From my side, it was specifically
intended not only to create a safe space for underrepresented groups, it
was also intended to give a promise to contributors that I will hold
myself to that standard, too. Guess what: several times I failed. I am
human. I was called out for it, rightfully so, and it helped me improve
the way I communicate. (I still have a ways to go, of course.)

I still stand by my statement from above: nobody has anything to fear
from a CoC, except those who are prone or even intent on violating it.
In which case I am very much in favor of a CoC, and very, very much not
against it.

> Consequently, such CoCs are often found rather discouraging, and
> announcements about their adoption in open-source projects generally
> get negative reaction.

That does not match my experience. In Git for Windows' case, I can
recall only one minor negative reaction (private, if I remember
correctly), and in that case, I have to admit that I feel my statement
from above very much validated: that person did not seem to _want_ to
abide by the common decency called for by the CoC.

> Less is more.  Much-much more.  A concise CoC that treats its readers
> as responsible, well-behaved human beings is met with much approval.

But do those readers approve of the same thing? Like, do they really
have the same understanding of that concise CoC? I have experienced
_way_ too diverging interpretations of short texts like the one you
linked below to believe _that_.

> Take, for example, the TrueOS Rules of Conduct, which in just a few
> short sentences covers everything that's worth covering:
>
>   https://www.trueos.org/rulesofconduct/

This is what I understand from reading this very terse statement: "We do
not want to be criticized for the way we talk, no matter how offended
people might get, and here is an email address that might, or might not,
be monitored, where you can complain, if you must. Good luck to you."

> If diversity and inclusion of other cultures is indeed a priority,
> then we should carefully consider that some potential contributors
> will rather choose not to contribute because of a CoC like this.

Let me be blunt for a minute. The proposed CoC would not change anything
for any contributor I consider decent. Not one thing. There would not be
any need to change any behavior, no need to complain, they could just
read the CoC and say: "Yep, that's right, that's exactly how I want to
behave, and that's how I want the others in this project to behave. Back
to this bug I wanted to debug/this feature I wanted to implement..."

> > If people are on board with this direction, it might be fun to pick
> > up a bunch of "Acked-by" trailers from people in the community who
> > agree with it. It might give it more weight if many members have
> > publicly endorsed it.
>
> Because of the above I'm leaning towards NACK.

It makes me sad to hear that, in particular because I give this patch a
big ACK.

To understand better why you are so negative about it:

- would you feel that you have to do anything differently from before?

- do you think that the CoC does not describe your values that you have
  already?

- could you propose a better alternative to the CoC, which -- by Junio's
  own words -- would have helped tremendously in the past, would have
  made it easier for Junio and some others to deal with at least one
  very real, and very damaging problem?

Thanks,
Dscho

--8323328-1837161224-1569331259=:15067--
