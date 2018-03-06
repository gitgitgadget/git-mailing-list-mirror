Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 150F91F404
	for <e@80x24.org>; Tue,  6 Mar 2018 23:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932147AbeCFXQQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 18:16:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:49556 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753996AbeCFXQP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 18:16:15 -0500
Received: (qmail 17462 invoked by uid 109); 6 Mar 2018 23:16:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 06 Mar 2018 23:16:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10454 invoked by uid 111); 6 Mar 2018 23:17:06 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 06 Mar 2018 18:17:06 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Mar 2018 00:16:11 +0100
Date:   Wed, 7 Mar 2018 00:16:11 +0100
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: Git / Software Freedom Conservancy status report (2018)
Message-ID: <20180306231609.GA1632@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's been about a year since I sent a big update regarding our
activities with Conservancy. So I'm going to pretend that it was all a
plan to have an annual report, and this is the 2018 one. The previous
report can be found at:

  https://public-inbox.org/git/20170202024501.57hrw4657tsqerqq@sigill.intra.peff.net/


# Background

Most people who work on the project know this already, but here's a
little background.

Git is a member project of the Software Freedom Conservancy. We joined
in 2010 so that Conservancy could help us manage our money and other
assets, and represent us for legal stuff like trademarks. Conservancy
doesn't hold any copyright on Git code, and our status as a member
project is totally disconnected from the development of the code. The
technical direction of the project is delegated back to Git.

A "Project Leadership Committee" (PLC) represents Git in Conservancy.
The PLC currently consists of Junio Hamano and me.


# Financials

We have ~26k USD in our account. That's up ~5k from last year. Here are
the ledger numbers from the last year (it's double-entry, so negative is
good):

            $-6,632.97  Income:Git
            $-5,368.20    Donations
            $-1,174.86    Royalties
               $-89.91    Currency Conversion
             $1,117.79  Expenses:Git
                $58.69    Currency Conversion
               $176.98    Banking Fees
               $882.12    Conferences:Travel
               $225.00      Per Diem
  --------------------
            $-5,515.18

Most of our money is taken in from donations. About 20% of it comes from
"royalties". Most of that is from the Amazon affiliate links on
git-scm.com (we link to the Pro Git book, but if people click through
and buy other stuff, that counts too). A little bit of the money comes
from Packt Publishing, who sends the project royalties based on sales of
their Git-related books. We give 10% of incoming money to Conservancy's
general fund (these numbers are after the 10%).

Our main expense was travel money for last year's Contributor Summit. It
looks like we spend a lot on banking fees and currency conversion, but
really those are just necessary parts of taking in the donations (e.g.,
somebody donates through paypal who charges a small cut to process the
transaction).

We'll probably spend about the same amount this year for travel to Git
Merge (more on that below).


# Trademark

As I reported last year, we hold a trademark on the term "Git" in the
space of software and version control. I won't repeat all the details;
see last year's report.

There were a few requests this year from various entities; we mostly
followed the rules of thumb I laid out last year.

Subjectively, it felt like there were fewer requests this year than in
the past. I suspect last year's discussion may have gotten our trademark
policy a bit more attention (most of the previous requests are of the
form "I've been using the name "Git Foo" for my project and just found
out you don't want me to do so).


# Travel Budget Allocation

As with past years, we offered money for community members to come to
Git Merge (and the contributor summit). We've always sort of made up the
procedure each year, but this year tried to formalize it a little more.
Our procedure was basically:

  0. We picked an amount that seemed OK to spend. For this year we
     picked $2,000 (which admittedly is kind of made up).

  1. I put out a call for requests to the mailing list.

  2. For each request, I asked the requester to ballpark the cost of the
     flight plus lodging to cover the conference.

  3. We ordered the requests roughly by contribution history. We also
     treated people in programs like GSoC and Outreachy as frequent
     contributors. Even though they haven't contributed as much code
     yet, the point of the program is getting them involved.

  4. We walked down the list until we ran out of budget. At any given
     level, the amount of money offered was tweaked manually based on
     need/fairness (i.e., to offer more to people whose flights are more
     expensive).

     This meant that we extended an offer of partial funds in some
     cases (at the end of the line).

That whole procedure is totally open to comment and suggestions. There's
a huge amount of hand-waving and subjectivity there. It also doesn't
really work as a general procedure if somebody were to request one-off
funding for a conference besides Git Merge (which has never actually
happened so far).


# Project Governance

As many of you know, the third member of the PLC, Shawn Pearce, passed
away early this year. Our charter calls for a minimum of three PLC
members. New members are decided by a simple majority vote of the
existing committee (of which there are now 2 members, but Conservancy
has a tie-breaking vote if for some reason we deadlock).

Beyond that, there's no specified procedure. Junio and I have some
thoughts on candidates, but we want to open it up to the list for
discussion and possible nominations.


# Conclusion

That's it for this year. I'm happy to answer any questions on the list,
and I'll propose a session at tomorrow's Contributor Summit in case
anybody wants to discuss it in person.

-Peff
