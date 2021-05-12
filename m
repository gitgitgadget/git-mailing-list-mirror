Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD698C433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 04:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F9F061584
	for <git@archiver.kernel.org>; Wed, 12 May 2021 04:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhELEKg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 00:10:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:56566 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229787AbhELEKf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 00:10:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 988E9B01E;
        Wed, 12 May 2021 04:09:27 +0000 (UTC)
Date:   Wed, 12 May 2021 06:09:26 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Varun Varada <varuncvarada@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
Message-ID: <20210512040926.GN12700@kitsune.suse.cz>
References: <CAD2i4DBj6fNvq=Lc3KiXJj5uBpteyKfEKp7ATOWrTE36KUeRww@mail.gmail.com>
 <20210406092440.GZ6564@kitsune.suse.cz>
 <CAD2i4DDr3Ftk6RE8cA74iSsJTpC9nEb=Cqvr79pF51BpcWEnsA@mail.gmail.com>
 <609ae224aa509_6064920851@natae.notmuch>
 <20210511202502.GM12700@kitsune.suse.cz>
 <CAD2i4DALKgw2wG6QGs-oQhAHnS3AG1j1BSq2bxjPojVOtw+WjA@mail.gmail.com>
 <609b4eea1088a_678ff208ba@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <609b4eea1088a_678ff208ba@natae.notmuch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 11, 2021 at 10:43:38PM -0500, Felipe Contreras wrote:
> Varun Varada wrote:
> 
> > Re: your point about me not pointing out specific examples: the
> > command output for detached HEAD state reads "you can discard any
> > commits you make in this state without impacting any branches by
> > switching back to a branch". I'm incredibly passionate about this
> > example. Here, the user is left to think, "wait...so this will not
> > impact (significantly affect) any branches, but will it affect them?
> > As in, are there side effects that I should be aware of? Where do I go
> > to find out what they are?" All of this mental energy is completely
> > unnecessary. Mind you, this is regarding discarding commits, which is
> > a destructive action.
> 
> Completely agree.
> 
> I'm not a native speaker of English, but nowadays I use English more
> than any other language, and when I read *impact* I read alarm bells.
> 
> First I'm reminded of "brace for impact", which something nobody should
> take lightly (native speaker or not), and when I search for "impact" on
> IMDB the first result I find is Deep Impact [1]. Not something bland.
> Maybe my understanding of the word has been tainted by my experience,
> sure...
> 
> But I'm still waiting for anybody to explain what's wrong with "affect".
> 
> > > > But why bother? The word "affect" is a much superior choice.
> > >
> > > Why bother with a chenge at all?
> > 
> > It seems like you already previously agreed with the premise that the
> > word means "a significant effect" or "to significantly affect". I
> > understand and appreciate your thoroughness to scrutinize changes to
> > the repo, but I'm frankly surprised that such a small change is
> > attracting such fierce debate. This is meant to be a change that is
> > probably one of the easiest ones to decide on: it only consists of
> > one-word changes that don't change functionality, yet undeniably
> > reduce confusion.
> 
> When I started contributing to the git project more than 10 years ago I
> noticed precisely the same thing.
> 
> It is a paradox called "the bikeshedding effect". When you contribute a
> complex and convoluted change it's easier to get it in because few people
> can object (as few people can understand it). But when you contribute a
> change as simple as changing the color of something, then *everyone* can
> opine (literally).

You forget that what you are doing right now is bikeshedding after the
fact.

You can use 'affect' or 'impact' and it generally conveys the same
meaning. Some speakers find 'affect' more natural. Clearly other
speakers such as authors of the changes that use the word 'impact' find
'impact' more natural. If we give in to the desire to pick the more
natural sounding synonym we will get endless back and forth of patches
changing one synonym to another.

Thanks

Michal
