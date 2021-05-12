Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B30C43603
	for <git@archiver.kernel.org>; Wed, 12 May 2021 17:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33BDC61434
	for <git@archiver.kernel.org>; Wed, 12 May 2021 17:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236728AbhELRnS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 13:43:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:57928 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344920AbhELRDF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 13:03:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AB600B1B4;
        Wed, 12 May 2021 17:01:54 +0000 (UTC)
Date:   Wed, 12 May 2021 19:01:53 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Varun Varada <varuncvarada@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
Message-ID: <20210512170153.GE8544@kitsune.suse.cz>
References: <20210406092440.GZ6564@kitsune.suse.cz>
 <CAD2i4DDr3Ftk6RE8cA74iSsJTpC9nEb=Cqvr79pF51BpcWEnsA@mail.gmail.com>
 <609ae224aa509_6064920851@natae.notmuch>
 <20210511202502.GM12700@kitsune.suse.cz>
 <CAD2i4DALKgw2wG6QGs-oQhAHnS3AG1j1BSq2bxjPojVOtw+WjA@mail.gmail.com>
 <609b4eea1088a_678ff208ba@natae.notmuch>
 <20210512040926.GN12700@kitsune.suse.cz>
 <609b63e48fd49_6d7da2086@natae.notmuch>
 <20210512064733.GP12700@kitsune.suse.cz>
 <CAD2i4DBF3Tvf62Zyh0XnNH=5ifTD2QQNL5Fx01UHMzoTn3OMVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD2i4DBF3Tvf62Zyh0XnNH=5ifTD2QQNL5Fx01UHMzoTn3OMVw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 12, 2021 at 11:47:15AM -0500, Varun Varada wrote:
> On Wed, 12 May 2021 at 01:47, Michal Suchánek <msuchanek@suse.de> wrote:
> >
> > On Wed, May 12, 2021 at 12:13:08AM -0500, Felipe Contreras wrote:
> > > Michal Suchánek wrote:
> > > > On Tue, May 11, 2021 at 10:43:38PM -0500, Felipe Contreras wrote:
> > > > > It is a paradox called "the bikeshedding effect". When you contribute a
> > > > > complex and convoluted change it's easier to get it in because few people
> > > > > can object (as few people can understand it). But when you contribute a
> > > > > change as simple as changing the color of something, then *everyone* can
> > > > > opine (literally).
> > > >
> > > > You forget that what you are doing right now is bikeshedding after the
> > > > fact.
> > >
> > > Except that's not what I'm doing.
> > >
> > > > You can use 'affect' or 'impact' and it generally conveys the same
> > > > meaning.
> > >
> > > That's clearly *your* opinion, but that's not my opinon.
> > >
> > > I'm not arguing between blue and red; I'm arguing between water-based and
> > > lead-based paint.
> >
> > No, you are not. There is no clear problem with 'impact', either.
> >
> > So if somebody comes along later and says that they find 'affect'
> > confusing and impact should be used does that need to be accepted as
> > well, back and forth ad nauseam?
> 
> This is whataboutism and hypothetical. But even if one were to
> disregard those facts, I'm willing to bet actual money that no one (at
> least anyone with access to a dictionary or even a basic grasp of the
> English language) would do this because "affect" has a universal
> definition and is not in the realm of jargon in any dictionary or
> style guide. The same cannot be said about "impact".
> 
> >
> > > The difference may not matter to you, but it matters to me.
> > >
> > > If it's bikeshedding to you, and it "gnerally conveys the same meaning",
> > > why are you arguing against?
> >
> > So if 'for' loops and 'while' loops generally convey the same meaning
> > should we accept patches that replace some 'for' loops with 'while'
> > lopps or vice versa?
> >
> > Surely not. There are different situations in which loops can be used,
> > and different people find 'for' and 'while' loops clearer and and easier
> > to understand in different situations. If you rewrite the piece of code
> > that includes a loop it might be worthwhile to change the loop type for
> > clarity, and at the time when the code is added or modified it is time
> > to discuss which one is better, not after.
> >
> > On the other hand if you state the goal to not have redundant semicolons
> > then even if code with and without redundant semicolons is the same and
> > in most cases it does not make any difference for human understanding
> > either patches that just remove redundant semicolons work towards a
> > specific goal. That makes them acceptable even if they are very minor
> > because there is clear metric they improve which makes the inverse patch
> > not acceptable.
> >
> > If you want to make the case for 'impact' in general being obscure or
> > hard to understand you will have hard time doing so. There are
> > dictionaries that recognize 'impact' as synonymous to 'affect' without
> > any difference in degree. In the COCA corpus there is around 200k
> > instances of 'effect', around 100k instances of 'affect', and around
> > 100k instances of 'impact' which makes effect/affect about 3 times more
> > frequent than 'impact'. That's not even an order of magnitude - clearly
> > not enough to claim it obscure. All of the words are within first 1k so
> > arguably if you have intermediate knowledge of (US) English you should
> > be familiar with all three.
> >
> > However, there is a different corpus that is much more relevant for the
> > git project:
> >
> > ✔ ~/git [master|…9]
> > 06:35 $ git grep affect | wc -l
> > 368
> > ✔ ~/git [master|…9]
> > 06:41 $ git grep effect | wc -l
> > 350
> > ✔ ~/git [master|…9]
> > 06:42 $ git grep impact | wc -l
> > 54
> >
> > There are only 54 instances of the word 'impact' in the git repository
> > which make up only 7.5%. It is feasible to eliminate those 54 instances
> > completely. In doing so you will make the git project use the same
> > wording consistently which makes it arguably more approachable to
> > non-native speakers with limited vocabulary. That states a clear metric
> > that is improved by such patch which also makes the reverse patch not
> > acceptable and prevents potential for infinite back-and-forth changing
> > from one synonym to the other.
> >
> > Bonus points if you add a test that prevents adding new instances of
> > 'impact' in the future.
> 
> So you're saying you're OK with getting rid of all instances of
> "impact"? I'm for this, but insofar as I searched the code base, I
> only found the ones I'm changing in my patch (save for a couple that,
> as a previous reviewer mentioned, are included from other repos, so I
> left those).

Yes, I am not opposed to the change in principle. You just failed to
provide any valid reason.

Part of writing a patch is coming up with sound reasoning why the change
is desirable and stating that clearly in the commit message.

I don't know if this reasoning is acceptable to git maintainers but at
least there is some real data it is based on.

Thanks

Michal
