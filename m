Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEB601F404
	for <e@80x24.org>; Thu, 16 Aug 2018 22:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbeHQBmf (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 21:42:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:58182 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725903AbeHQBmf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 21:42:35 -0400
Received: (qmail 22771 invoked by uid 109); 16 Aug 2018 22:41:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 16 Aug 2018 22:41:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20073 invoked by uid 111); 16 Aug 2018 22:41:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 16 Aug 2018 18:41:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Aug 2018 18:41:38 -0400
Date:   Thu, 16 Aug 2018 18:41:38 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Git Project Leadership Committee
Message-ID: <20180816224138.GA15490@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a followup to the issue I raised back in March[1], which is
that our project committee at Software Freedom Conservancy has two
members, but is required by the charter to have at least three.

There wasn't any substantive discussion in response to that email or at
the contributor summit. I intentionally left my own opinions out of that
mail to avoid biasing discussion, and meant to follow-up after everyone
had a chance to speak. I didn't intend to leave it this long, though. :)

Just to recap: the project leadership committee (PLC) represents the Git
project within Conservancy and decides on project-specific matters,
including allocation of funds. Since joining in 2010, the PLC consisted
of me, Junio, and Shawn Pearce.  With Shawn's passing, we need to elect
another member (by simple majority of the remaining members) to meet our
minimum number of three.

You can get a sense of the types of issues and decisions from looking at
my report in [1], as well as past-year reports linked from there. If you
want a more precise picture of the day-to-day, it's mostly just
monitoring and discussing things on a project-specific mailing list that
gets an average of about 2-4 messages per month (usually one thread
every month or two). I'm happy to answer any other questions people have
about it.

Here are _my_ opinions on how we should fill the role. As 50% of the
voting populace, it's perhaps a disproportionately important opinion,
but I really would like to hear and take into account opinions from the
larger development community.

 - it should probably be somebody who has been with the project for a
   while (so we feel comfortable that they are representative) and that
   we expect to stay with the project for a while (so we're not doing
   this again in 6 months). But those are negotiable. It's not the worst
   thing for somebody to serve for a year or two and then move on.

 - we should avoid anyone who is affiliated with a company that already
   has a member on the committee. So nobody from Google and nobody from
   GitHub. I would extend that to Microsoft, too, given a certain
   impending acquisition. I'd expect anybody who is affiliated with a
   company to recuse themselves from decisions that directly affect that
   company (which is what we've done so far).

 - I think ideally the candidate would be somebody who represents the
   long tail of volunteer community members who don't work on Git as
   part of their day-job. The current members have a fairly skewed view
   in that respect. At the same time, we can't really represent the
   _really_ long tail of infrequent contributors, by the "stick around"
   criterion above.

 - I considered mostly people who have expressed interest in non-code
   issues (e.g., GSoC, money policy, etc). But I don't think that's a
   strict requirement if somebody is interested.

 - We're not restricted to three members. So we could add multiple
   people. Four may be bad because it creates ties. On the other hand,
   every decision so far has been unanimous. :)

So here are the nominations I came up with. If you'd like to nominate
somebody else (or yourself!), please do. If you have opinions, let me
know (public or private, as you prefer).

 - Christian Couder
 - Ævar Arnfjörð Bjarmason

Both are active, have been around a long time, and have taken part in
non-code activities and governance discussions. My understanding is that
Christian freelances on Git, which doesn't quite fit my "volunteer
representative" request, but I think contracting on Git is its own
interesting perspective to represent (and certainly he spent many years
on the volunteer side).

Phew. That turned out a little longer than I meant it to be, but I
wanted to lay out my thought process, both for this decision and because
we may eventually have to do this again in the future.

-Peff

[1] https://public-inbox.org/git/20180306231609.GA1632@sigill.intra.peff.net/

