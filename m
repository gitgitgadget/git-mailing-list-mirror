Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 578981F404
	for <e@80x24.org>; Thu, 30 Aug 2018 19:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbeH3XqM (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 19:46:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:34490 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727337AbeH3XqL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 19:46:11 -0400
Received: (qmail 7993 invoked by uid 109); 30 Aug 2018 19:42:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Aug 2018 19:42:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30772 invoked by uid 111); 30 Aug 2018 19:42:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 30 Aug 2018 15:42:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Aug 2018 15:42:24 -0400
Date:   Thu, 30 Aug 2018 15:42:24 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: Git in Outreachy Dec-Mar?
Message-ID: <20180830194223.GD19685@sigill.intra.peff.net>
References: <20180828151419.GA17467@sigill.intra.peff.net>
 <8736uxe2pm.fsf@evledraar.gmail.com>
 <20180830031607.GB665@sigill.intra.peff.net>
 <87sh2wcak4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sh2wcak4.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 30, 2018 at 02:18:19PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > It doesn't need to be. As far as I know, the main reasons (from the
> > perspective of a project) to do it through Outreachy are:
> >
> >  - being part of a larger program generates attention and gets the
> >    interest of intern candidates (free advertising, if you will)
> 
> I was wondering if we couldn't do it through Outreachy *and* also do our
> own advertisements / possibly recruit candidates outside of the
> Outreachy pool. In that case we'd still get the attention/outreach
> benefits, in addition to our own...

True. I'd worry about spreading our mentor resources too thinly (which I
think are probably a bigger bottleneck than actual money). But I guess
you're proposing to issue a larger call for candidates, and then we pick
from the result (so in the end we'd end up with the same number of
actual interns, just from a bigger pool).

> Yup, but just as a clarifying point here wouldn't the participants also
> get all the same benefits of this in the case of Outreachy+OurOwnProgram
> if we ran OurOwnProgram concurrently to Outreachy?
> 
> I.e. I was assuming that once candidates are "handed off" to a project
> they're communicating within that project (possibly with other
> candidates), and Outreachy is no longer very involved (except maybe for
> progress reports / final report, but wouldn't we also do that for a
> OurOwnProgram?).
> 
> I may have that completely wrong though, which is why I'm asking, which
> b.t.w. I'm doing mostly just to get an idea of how what Outreachy's role
> is in this exactly, not to strongly advocate for a OurOwnProgram.

I think there _is_ some contact and group resources between Outreachy
and the interns. But I'm actually not sure of the extent. I know they
encouraged interns to blog (and read each other's blogs). I don't know
if there's an intern mailing list, irc, etc. I had the impression that
there is, but I don't actually know the details.

> >   - it naturally limits the candidate pool to under-represented groups
> >     (which is the whole point of the program, but if you don't
> >     actually care about that, then it's just a complication)
> 
> I'm fine with doing selection discrimination of under-represented groups
> through such a program. Particularly if, as you mention, there's
> earmarked funding for it which otherwise might not be available, so it's
> not zero-sum when it comes to a hypothetical alternative of casting a
> wider net of our own (and as you mention, that would be more work).

Yeah, just for reference, my "you" there was a hypothetical "one might
or might not care about...", not responding to your particular email.

> I do think it's unfortunate that the selection criteria for the program
> privileges U.S. citizens and U.S. residents above other people,
> particularly since they're also accepting worldwide candidates (and
> we've had at least one non-American participant that I know about), so
> it's not e.g. for U.S. administrative or tax reasons as one might expect
> if they only accepted Americans.

I assume you mean this bit from the eligibility rules:

  You must meet one of the following criteria:
    - You live any where in the world and you identify as a woman (cis
      or trans), trans man, or genderqueer person (including genderfluid
      or genderfree).
    - You live in the United States or you are a U.S. national or
      permanent resident living abroad, AND you are a person of any
      gender who is Black/African American, Hispanic/Latin@, Native
      American/American Indian, Alaska Native, Native Hawaiian, or
      Pacific Islander

So there are more categories for the US, but I think that is largely
because under-representation is somewhat regional. Being black in the US
is different than being black in Africa. Certainly one could argue that
Africa as a whole is under-represented in the tech world, but I think
you'd probably need to draw different boundaries in different places if
you want to extend opportunities to those who are least likely to
already have them.

I don't know what those groupings would look like in, say, Europe. If
you're suggesting that the program would be better off having
region-specific rules for more regions, I'd certainly agree with that. I
don't know if it's something the Outreachy folks have considered or
discussed; it might be worth bringing it up.

-Peff
