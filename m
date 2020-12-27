Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30BEC433E0
	for <git@archiver.kernel.org>; Sun, 27 Dec 2020 15:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B25820867
	for <git@archiver.kernel.org>; Sun, 27 Dec 2020 15:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgL0PIV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Dec 2020 10:08:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:41118 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbgL0PIV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Dec 2020 10:08:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 41409AD0F;
        Sun, 27 Dec 2020 15:07:39 +0000 (UTC)
Date:   Sun, 27 Dec 2020 16:07:37 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, git@sfconservancy.org,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>,
        'Junio C Hamano ' <gitster@pobox.com>
Subject: Re: [PATCH] CODE_OF_CONDUCT: expect tolerance, not respect
Message-ID: <20201227150737.GM6564@kitsune.suse.cz>
References: <20201223061718.102779-1-felipe.contreras@gmail.com>
 <87wnx8uirn.fsf@evledraar.gmail.com>
 <5fe40778321c5_7855a20819@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5fe40778321c5_7855a20819@natae.notmuch>
User-Agent: Mutt/1.11.3 (2019-02-01)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Thanks for bringing this up.

On Wed, Dec 23, 2020 at 09:14:00PM -0600, Felipe Contreras wrote:
> Ævar Arnfjörð Bjarmason wrote:
> > 
> > On Wed, Dec 23 2020, Felipe Contreras wrote:
> > 
> > >  * Using welcoming and inclusive language
> > > -* Being respectful of differing viewpoints and experiences
> > > +* Being tolerant of differing viewpoints and experiences
> > >  * Gracefully accepting constructive criticism
> > >  * Focusing on what is best for the community
> > >  * Showing empathy towards other community members
> > 
> > [I happen to be on the PLC, and I'm not speaking for the PLC, just
> > myself]
> > 
> > Generally speaking, and not just commenting on this specific patch: I'm
> > not in principle against us forking the upstream CoC if we as a project
> > & community deem that a worthy trade-off for whatever reason.
> > 
> > But in the case of this specific patch, (and I'm focusing on points not
> > already raised by others):
> > 
> > 1. The specific wording you're changing is something that changed in the
> >    CoC from version 1.4 (which we adopted) to upstream's 2.0.
> > 
> >    My reading of the 2.0 wording is that it contradicts your
> >    interpretation, it talks about "being respectful of differing
> >    opinions".
> 
> I don't see how the change from "differing viewpoints" to "differing opinions,
> viewpoints" contradicts my interpretation.
> 
> >    If the CoC means to enforce something about privately held views as
> >    you seem to suggest (and not just behavior in public),
> 
> No, that's not necessarily what I'm suggesting.
> 
> Let me try again:
> 
>   1. Respecting differing opinions is an internal matter. You can't
>      really do it, even if you want to. Also, it can't be enforced,
>      because nobody can know if you are actually doing it or not.
> 
>   2. Behaving respectfully of differing opinions is an external matter.
>      You can do it, even if you don't really respect an opinion, you can
>      act as if you do. It can be enforced, because others can see how
>      you behave.
> 
> Even if the CoC is trying to enforce #2, it's still not desirable to do
> so.
> 
> Now, it's debatable whether or not "being respectful" is taking about #1
> or #2, I don't think it particularly matters, since #1 is asking for
> something impossible, and #2 is asking to lie. Either way it's not good.
> 
> >    then it seems like a paradox to me that it also asks participants
> >    to be respectful of differing opinions.
> 
> I don't see how "views" or "opinions" alter the argument.
> 
> >    To be clear I don't agree with your reading of it. I'm just
> >    suggesting that any proposed updates to the CoC that rely on reading
> >    specific intent into the wording therein attempt to do the legwork of
> >    convincing this ML to accept the proposed change in a way that
> >    provides more context for the change.
> 
> It is not my reading; it's literally saying "being respectful". The word
> "respect" has an established meaning, and it doesn't matter if they are
> asking to actually *be* respectful (#1), or merely *show* respect (#2);
> both are a problem.
> 
> So at the very least it's asking to show respect.
> 
> What is your reading? Does your reading not imply showing respect?
> 
> >    Discussing that upstream has changed the relevant part from A to B,
> >    but we're proposing a change from A to C seems highly relevant.
> 
> Yes, it is relevant, and I will contact upstream about it, but even if
> they deny the change, what part of the rationale is not correct?
> 
> Many more people with a lot more knowledge about the philosophy of
> freedom of speech weighted in the University of Cambridge debate, and
> the exact same rationale applies here.
> 
> > 2. The CoC has official translations into a bunch of languages:
> >    https://www.contributor-covenant.org/translations/
> > 
> >    So I think that even if we deem a git.git-specific change to the CoC
> >    to be worthwhile losing a 1=1 mapping between our version and those
> >    translations should give us pause since we'd be less inclusive to
> >    non-native English speaking contributors of the project.
> > 
> >    Furthermore, I think a really basic sanity check on any specific
> >    reading or interpretation of the CoC is to see if also holds true if
> >    you read some of the official translations.
> 
> Yes, that is a good point.
> 
> This is why usually it's a good idea to look back at the etymology of
> a word.
> 
> In both words the etymology goes back to Latin, and since I speak
> Spanish I can grasp pretty clearly what is meant in the four cases
> {English,Spanish}{respect,tolerance}.
> 
> From my point of view it's really simple:
> 
>  a. Respect: hold in high regard
>  b. Tolerance: endure
> 
> Whether it's "respect" (English), or "respeto" (Spanish), doesn't really
> change the meaning. Same with "tolerance" and "tolerancia".
> 
> >    In the language I speak natively this reading of "respect" doesn't
> >    agree with your interpretation.
> 
> We would need to see which interpretation you are talking about.
> 
> One example to show the difference is that you are supposed to hold in
> high regard (respect) your parents, or the King, whereas in a Thanksgiving dinner
> you are supposed to endure (tolerate) your uncle talking about conspiracy
> theories.
> 
> These are of course culturally-specific examples. But I hope you get the
> point.

This is rather sensitive issue. I think there are other two things that
are often conflated: respect for views and opinions and respect for
people.

It is certainly true that respecting people cannot be enforced as much
as respecting opinions cannot be. However, it is shown that not behaving
respectfully to people stifles constructive discussion (eg. speech
against ad-hominem arguments). What you can enforce is that people who
do not behave respectfully to other participants of discussion are
excluded from the discussion. Note: it is shown that under specific
circumstances respectful behavior is not required for constructive
discussion - on 4chan all users are anonymous and can easily express
totally opposite view from one post to the next, and respectful behavior
is not required to have a constructive discussion. Git is not hosted on
4chan, however.

On the other hand, showing respect to useless views or ideas stifles
constructive discussion as well. Useless ideas should be pointed out as
such and discarded.

The reason why respect to ideas is often part of code of conduct is
likely religion. There are precious few people who hold religious
beliefs and at the same time encourage scrutiny of religion.

For the vast majority of religious people it seems religion is something
to be followed blindly, and view the religion as integral part of their
person. Then any doubt about the religion is viewed as doubt about their
very person. Until people are mature enough to have constructive debate
about religion I think CoC should simply ban religious topics from
places which are dedicated to technical discussion such as this
mailinglist. That is a reasonable way to sidestep the issue.

Thanks

Michal
