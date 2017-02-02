Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E995B20A78
	for <e@80x24.org>; Thu,  2 Feb 2017 02:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751070AbdBBCpG (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 21:45:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:48143 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750861AbdBBCpG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 21:45:06 -0500
Received: (qmail 1732 invoked by uid 109); 2 Feb 2017 02:45:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Feb 2017 02:45:05 +0000
Received: (qmail 16393 invoked by uid 111); 2 Feb 2017 02:45:07 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.42.43.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Feb 2017 21:45:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Feb 2017 03:45:02 +0100
Date:   Thu, 2 Feb 2017 03:45:02 +0100
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: Git / Software Freedom Conservancy status report
Message-ID: <20170202024501.57hrw4657tsqerqq@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since it's been about a year since the last one, I'd like to give a
brief overview of the activities of Git as a member project of the
Software Freedom Conservancy. I plan to have a discussion session at the
Git Merge Contributor Summit tomorrow; I'll try to relay any interesting
points from that session to the list.

# Background

Git is a member project of the Software Freedom Conservancy. We joined
in 2010 so that Conservancy could help us manage our money and other
assets, and represent us for legal stuff like trademarks. Conservancy
doesn't hold any copyright on Git code, and our status as a member
project is totally disconnected from the development of the code.

A "Project Leadership Committee" (PLC) represents Git in Conservancy.
The PLC consists of me, Shawn Pearce, and Junio Hamano.

# Financials

In short, we have about $21K (USD) in our account. Here's the breakdown
of money in versus out (these are sums of double-entry transactions, so
negative is good here):

                 $-27,468.01  Income:Git
                   $6,207.50  Expenses:Git
        --------------------
                 $-21,260.51

You can see we don't actually spend that much. Here's the same report
just since 2016-01-01:

                  $-4,468.64  Income:Git
                   $2,102.32  Expenses:Git
        --------------------
                  $-2,366.32

Those reports come from running "ledger" on the file given to us by
Conservancy. I can run other reports if there are things people want to
know.

I _think_ there are some outstanding transactions that actually bump
that closer to $3K (e.g., money invoiced for GSoC that gets collected by
Conservancy and then eventually dumped into a bank account).

Here's the same report over the last three years:

                 $-12,990.84  Income:Git
                   $2,772.78  Expenses:Git
        --------------------
                 $-10,218.06

So we seem to average about $3K/year ahead of our expenses.

## Where does the income come from?

We get money from the mentor stipends for GSoC. We get about $1K/year in
donations (you can donate to Conservancy and earmark for Git, or there's
a "donate" button on git-scm.com, though it's not particularly
prominent).

Links from git-scm.com to buy the paper copy of the Pro Git book are
Amazon affiliate links. If people buy stuff (either the book, or other
things after clicking around the site), we get some money. This accounts
for ~$800 this year.

Packt Publishing has several technical books related to Git, and they
send some of the royalties to the project. That was ~$400 this year.

## Where do expenses go?

Most of the money goes to travel. Note that this accounts for some of
the income, too. if we send a mentor to the GSoC mentor summit, for
example, we invoice Google for the money, which shows up as income.  And
then it leaves us to reimburse the mentor, which is an expense.  So it's
net-zero for the project, but inflates the numbers.

We also spent ~$900 on legal filing fees for the trademark (not this
year, but that's part of the total income/expenses history I showed
earlier).

# Activity Summary for 2016

This is a summary of interesting things related to the project that
happened in the past year.

## Mentoring

We had one GSoC student, Pranit Bauva (who passed). The actual coding
project has little to do with our Conservancy status, but the Git
project did get the stipend money, and handled the financial logistics
for Christian Couder to go to the mentor summit (the money ultimately
comes from Google for that).

We were a potential Outreachy project last Spring for the first time,
but we didn't end up picking an intern. As a reminder, the Outreachy
program is somewhat similar to GSoC, but with a focus on getting
under-represented groups involved in programming (but not necessarily
college students). The projects themselves have to cover the stipend for
the intern (or get funding elsewhere to do so). Last year GitHub offered
to fund one intern for us, but we didn't end up selecting anyone.

## Travel Money

We paid for travel for one developer to Git Merge last year, and we are
covering one this year, too.

Each year I ask if financial circumstances are preventing anyone from
coming, and if the project can help. Each year I have gotten only one
response. The Git PLC discusses each case, and we decide whether and how
much money to provide; Conservancy handles the logistics. That tries to
balance privacy for individuals who need financial support with some
accountability for the project.

## git-scm.com DNS

We now own the git-scm.com domain, which is held for us in a Conservancy
account (this is mostly for convenience; they hold a ton of domains, and
can just auto-renew out of our money). We also have owned git-scm.org
for a while.

There has never really been an "official" Git website, but git-scm.com
has been the de facto one for a while. I think us actually controlling
the domain makes it more so. The actual governance of the site content
is up in the air. I'll send a separate email about that[1].

## Trademark

We hold a trademark on "Git" and the diamond-shaped logo, and have to
deal with various questions for that. I'll send out a separate, much
more detailed mail about that[2].


That's about it.  I'd be happy to try to answer any questions about this
year's activities, how Git's membership in Conservancy works, etc.

-Peff

[1] http://public-inbox.org/git/20170202023349.7fopb3a6pc6dkcmd@sigill.intra.peff.net/

[2] http://public-inbox.org/git/20170202022655.2jwvudhvo4hmueaw@sigill.intra.peff.net/
