Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AD261F731
	for <e@80x24.org>; Thu,  1 Aug 2019 00:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfHAAiH (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 20:38:07 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43705 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfHAAiH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 20:38:07 -0400
Received: by mail-io1-f67.google.com with SMTP id k20so140438454ios.10
        for <git@vger.kernel.org>; Wed, 31 Jul 2019 17:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dereferenced-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YzkOp4VGW47Y5yd3t9/QHk1ZodGPi24d0SXX3/R3sJM=;
        b=UBpcCydkWlheRb5JSwlv0TMXj7cajOf0lqCnDmE/YIOWN3TleW6Btwf+hO0yao7Gvj
         RJ6ULIAfdzU/ExPy0OO8+Qw+UfGcXh16ndGKAmUbjJ5d50MMcuhp/AMAg5Mmk/YikzrE
         9HGASdExzXHRtahwUEyjXffQgD96IhR1h8I3CdjZwjgeknxro5ZQ/VlCS//4ryd8Bv6/
         VwbFSwRsrI+NKYFnczte5k+D7BtIL887zdPXlYFrOer4PpzSCaq0FumbGIMhbJ5/koNP
         15HJCWONqt0DoFy6TYi1COTrcPjFQHriOp4SbxfQX2pr79RJckHTdhdcgxrGmp0w5NOx
         t3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YzkOp4VGW47Y5yd3t9/QHk1ZodGPi24d0SXX3/R3sJM=;
        b=sngnhwhlrvFzCkhW0VPZ3pojwmPG6j4oWWnWZUwsIEnrghdGsuIJa45Nb5ZG7RWWoq
         a4fbW11JKUiOtu60ra8UiI6nNRmd7GCELOfRPmpxTFdZH5deV/zG+iwZOCzEBb9YlZF7
         LCccLV/SrW18/8Hz5jeZNLiKA2O3W+pPpMbqDzv3N/MnqHW7nTxaRCEvNnwKneRys+Uh
         /8aMh8L+6zcp2c3Y36+nWUoFHt30E7WiVkEU2HhMCZMIsJzJQV5HdAQ4icXnjev0FVPK
         CvUQut4wnYXiaMTsrRDQbpfk2V2tfDJJfxKErfkrgfWqGCvRmr3qEn2Ipws3fupwA1aB
         UB6g==
X-Gm-Message-State: APjAAAWy8MSq2p2u0Kr47W/n6kUAFYxAJlelsyuYdYY12mHWp0lkWAoU
        vpeHMYuRqH79PGWfbkKLBYmxg4uoL+G03jAHvCw=
X-Google-Smtp-Source: APXvYqyrRQ+jhcM+AFnYTVNwb61vSvA74XmL7OT/bk/xUw1ovLKKUUqRvIHYKebPierNf5HtmXOW+9n+kmNr4fphbCQ=
X-Received: by 2002:a6b:f406:: with SMTP id i6mr44555029iog.110.1564619886022;
 Wed, 31 Jul 2019 17:38:06 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqh874tssp.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1907311440130.21907@tvgsbejvaqbjf.bet>
 <20190731231848.GC1933@sigill.intra.peff.net> <20190801002125.GA176307@google.com>
In-Reply-To: <20190801002125.GA176307@google.com>
From:   Ariadne Conill <ariadne@dereferenced.org>
Date:   Wed, 31 Jul 2019 19:37:55 -0500
Message-ID: <CAAOiGNyCrUSPiF9GjXmpPjosV6Ef8B72v54=-5UTqaTBg2hkFA@mail.gmail.com>
Subject: Re: Git for Windows v2.23.0-rc0, was Re: [ANNOUNCE] Git v2.23.0-rc0
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        git-for-windows@googlegroups.com,
        Git Mailing List <git@vger.kernel.org>,
        git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Wed, Jul 31, 2019 at 7:21 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Jeff King wrote:
>
> > I think part of what my annoyance is responding to (and your willingness
> > to just squelch this for everybody) is that switching this particular
> > default isn't really that big a deal, that it requires annoying people
> > on every single "git log" invocation. Perhaps we would be better
> > squelching it entirely and just putting a mention in the release notes.
>
> Yes.
>
> Although as Dscho mentions, it's particularly irritating because it is
> not part of the paginated output.
>
> I wonder if the ideal might not be to trigger it more selectively, when
> the output actually changed due to a reflog entry.  I mean something
> like
>
>         commit 393a9dd0f9762c69f753a8fa0bc89c203c6b4e9e (HEAD, origin/foo, other/pu)
>         Merge: 18598e40e6 1eba6eb1c2
>         Author: A U Thor <author@example.com> (see "git help mailmap")
>         Date:   Tue Jul 30 15:05:41 2019 -0700
>
>             Merge branch 'jt/fetch-cdn-offload' into foo
>
> The message
>
>         warning: log.mailmap is not set; its implicit value will change in an
>         upcoming release. To squelch this message and preserve current
>         behaviour, set the log.mailmap configuration value to false.
>
>         To squelch this message and adopt the new behaviour now, set the
>         log.mailmap configuration value to true.
>
> is *particularly* unactionable in the current state where we're not
> rewriting authors.  I think we should bite the bullet and just flip
> the default to "true", with the config as an escape hatch to allow
> going back to the old behavior.

This is what I originally proposed, but it was suggested that we
should go through the typical cycle for changing default behaviour in
Git, e.g. issue a warning and then flip the default in a later release
cycle (my plan was to do so in the next cycle, in fact).

>
> Is it too late in the release cycle to do that?  If not, we can do
>
> -- >8 --
> Subject: log: use mailmap by default in interactive use
>
> In f0596ecc8de9 (log: add warning for unspecified log.mailmap setting,
> 2019-07-15), we prepared for a future where "git log" uses the mailmap
> by default, using the following conditions:
>
>  1. If log.mailmap or --[no-]use-mailmap is set explicitly explicitly,
>     respect that.  Otherwise:
>
>  2. If output is not going to a terminal or pager, we might be in a
>     script.  Match historical behavior by not using the mailmap.
>     Otherwise:

For what it's worth, personally, I believe that it is best to just
always use the mailmap (even in scripts), because most likely if you
care about the author line, you're probably caring about the *present*
identity of the author who made the commit, because you wish to ask
them a question.  However, I decided that it would be best to be
conservative with the behaviour, for now, just in case somebody was
dependent on the historical author lines.

>  3. If the output format was specified using --pretty, we might be in
>     a script that produces output intended for copy/paste.  Match
>     historical behavior by not using the mailmap.  Otherwise:

This one is definitely intentional, as the user specified exactly what
they wanted.  So, we give them what they want -- if they want the raw
author lines, they get that, if they want the mapped version, then
they get that, because they explicitly asked for one or the other.

>  4. This is an interactive use, where we will be able to change the
>     default behavior.  Print a warning about the upcoming change
>     but don't use the mailmap yet.
>
> In practice, the case (4) turns out to be irritating.  It prints
> before pager setup, so it just flashes on the screen.  It appears on
> every "git log" invocation, even when the mailmap would not result in
> the output changing.  The change is not meaningful to most people, and
> the new default of --use-mailmap is likely to be preferable for all of
> them.
>
> Let's bite the bullet and jump straight to --use-mailmap in case (4).

Yes, I agree, the warning is suboptimal when used with a pager, but we
can only write to stderr, since writing to stdout may break scripts.
So, given the request of having a transitional period, I felt this was
the best we could do without breaking anything.

> While at it, add a new log.mailmap setting "auto" that can be used to
> explicitly request the new automatic behavior (so that e.g. if
> log.mailmap is set to "true" system-side, I can set it to "auto" in my
> per-user configuration).

This sounds like a great compromise, but honestly we should just flip
the default.  I can't think of any situation where the non-mapped
author lines wouldn't be the more preferable default.  If you want the
raw ones explicitly, you can just ask for them, either with
`--no-use-mailmap` or with `log.mailmap=false`.

> Reported-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

At any rate... I don't have any major objections with going this route
as it solves the problem for the typical use-case, so...

Acked-by: Ariadne Conill <ariadne@dereferenced.org>

Ariadne
