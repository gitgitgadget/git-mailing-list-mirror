Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED22A1F731
	for <e@80x24.org>; Wed,  7 Aug 2019 17:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbfHGRM0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 13:12:26 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39752 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729804AbfHGRM0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 13:12:26 -0400
Received: by mail-qt1-f194.google.com with SMTP id l9so89046370qtu.6
        for <git@vger.kernel.org>; Wed, 07 Aug 2019 10:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AaX7zmss72E582wKEfnXLfHCtfW70A2Msd6tZSmhXkk=;
        b=Pox37SMhoMcQSsN/IFR3KDmHgz2LzT+23vXTLBuTl7aAYlJDcPjNYmOYQ4nGtrNq0T
         rpYBLUGwz+Fvc/n8HeoJoraYYvu9I0lLcmQS06vwYWXBZ+jVQ9qe/xdEVqn55mAnHnng
         YB4QEnJTE/2asQIoKlR/L6nwM4oXZCpmcwB9pIFjIDHUhIJurvIQMrKMV2XCZ9aD66yQ
         5cdWUieKRXj6i4a/g5a44Rdb/GWOFWsKT9sxd/CDuWIRLhH39oR40Y6FYxiwmWZM8jD5
         nppab6Wha18ik27tnFbowlRfNqWykML2YKLceKw58SSa6SjCLB8MMKUGv2b3t2UN+4MS
         pH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AaX7zmss72E582wKEfnXLfHCtfW70A2Msd6tZSmhXkk=;
        b=inUfECvK1QMzj2F2irwJdvc8f2WYBkXDrGgk72kQxewUKUMy280/15XUEaaE2DMc56
         oep2QLzFJSmPfwYgnPjRsWwCArsiiWiu72HMPTOH0vMNWYefTXtOe6gaiW1QB+ccv9o+
         rDKWKTDIqTRVXpxI7P2IUafiVyWt4OWxCOhPTInszBJ7FrOubSF6/8vcQmBvOuxYvr9U
         4RAdVJUoDoSCxMlWjG60uJsgH777GcVeHiNKT8SO8XatvmUeuwGZabn5uYPL7QjBvzoh
         M4Dv4ALYkbeOYGsivzjqOlFBThV4q9KgGJOUuK+phoO03c6BAT96+rv5+wTIa05d4xna
         qGrA==
X-Gm-Message-State: APjAAAXTtjkQXs9HMhtt1fRw0j7vH9j8OTb1EvbBYmyKPr+obbebwsOG
        jexn06mrJVtOU28BgSSVncyNjQ==
X-Google-Smtp-Source: APXvYqx67lwBJAy3Na2jZnm8C6SPdJ6fPDseIZNcDRUZo+GAASpoh5Q2WMVJK5LvSR+Z7RXAKqbUtg==
X-Received: by 2002:ac8:1c4:: with SMTP id b4mr8952329qtg.42.1565197945236;
        Wed, 07 Aug 2019 10:12:25 -0700 (PDT)
Received: from localhost ([173.225.52.219])
        by smtp.gmail.com with ESMTPSA id v192sm890569qka.74.2019.08.07.10.12.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 10:12:24 -0700 (PDT)
Date:   Wed, 7 Aug 2019 13:12:24 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Andrew Ardill <andrew.ardill@gmail.com>,
        git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: RFC - Git Developer Blog
Message-ID: <20190807171224.GB61464@syl.local>
References: <20190806014935.GA26909@google.com>
 <CAH5451=Qa5BGnoRdvtcmT6mXXK+i8iD7WAkKFfNU4b6J-0bX9g@mail.gmail.com>
 <e97608ed-1900-e2c0-c20d-e73586c1fdd5@gmail.com>
 <20190806210015.GB196191@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190806210015.GB196191@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Tue, Aug 06, 2019 at 02:00:15PM -0700, Emily Shaffer wrote:
> On Tue, Aug 06, 2019 at 08:19:15AM -0400, Derrick Stolee wrote:
> > On 8/6/2019 12:52 AM, Andrew Ardill wrote:
> > > On Tue, 6 Aug 2019 at 11:51, Emily Shaffer <emilyshaffer@google.com> wrote:
> > >
> > >> Are folks interested in writing and reviewing this kind of content?
> >
> > I am interested in writing and reviewing! Here are some topics I am
> > interested in writing:
> >
> > * Updates to the commit-graph feature
> > * What is a multi-pack-index and what is it for?
> > * Git at Scale: What makes a repo big, and how to avoid it?
> > * Advanced Git config settings
> >
> > Here are some topics I'd be interested in seeing in the wild
> > (and was considering writing them myself if I didn't see them elsewhere):
> >
> > * Partial clone: what, why, and how?
> > * Life cycle of a patch series
> > * Crafting perfect patches with interactive add and rebase
> Oh, I'd love to write one on interactive add and rebase. Maybe it's
> weird to have a favorite Git feature, but mine's add -p :)
>
> Since we're volunteering, my todo list for my personal blog also
> contains:
>
>  - How to use bisect
>  - How to use Git pathspecs
>
> I also have a couple pre-existing personal blog posts on
> nasamuffin.github.io:
>
>  - How to use git format-patch and git send-email for mailing list based
>    reviews
>  - Overview of Git object types
>
> >
> > It would also be helpful to have a post for every major release
> > highlighting new features and giving users examples of how to use them.
> > Taylor has been writing these on the GitHub blog [1], but maybe he
> > would be interested in writing them for this new venue?
> >
> > [1] https://github.blog/2019-06-07-highlights-from-git-2-22/
> >
> > > The idea sounds great, and I would be happy to review content - even
> > > if it's only for readability and spelling!
> > >
> > > In terms of collaborating, I've found the processes over at Git Rev
> > > News[0] straightforward and sensible, if you're looking for ideas.
> >
> > I agree that the review process there is helpful, and users contributing
> > edits via PRs to a feature branch works quite well. I would also suggest
> > writing a "request for review" on the mailing list before merging any
> > pull requests.
> >
> > One goal I think would be important is that this blog is that the posts
> > come with some amount of blessing from "the Git Dev Community". That is,
> > they should be service-agnostic and focused on helping _all_ Git users.
>
> By this do you mean "not about how to use Git with Github", or "not
> about how to use Git for Windows"? I initially read it as the latter but
> I think you mean the former, right?
>
> I believe there's a lot of value in the former - lately it seems to me
> like the lines are really blurred between which parts are Git and which
> parts are Github. It'd be nice to clear up some of that confusion and
> writing pieces concerning "vanilla Git".

Yeah, this is a concern of mine, too. I try and make quite clear that
GitHub isn't the author of these features (we are for some, but
obviously not all), and instead that we're merely summarizing the
interesting work that's happening upstream, and that the project is, of
course, open-source.

The posts aren't really a "using Git with GitHub" guide, per-se,
although we usually will have remotes with 'git@github.com' in them when
included in examples.

> > That said, I also suggest that the authors can list their professional
> > affiliation as some minimum amount of credit to their employers. Something
> > as simple as "Author: Derrick Stolee, Microsoft" would go a long way to
> > justifying the work it takes to write these on the community blog and not
> > a company-owned blog.
>
> Yes, I agree - this seems to have a double win of lending credibility to
> the author and giving good optics for the company. Plus, as mentioned
> before, crossposting seems like a good fit here.

Doubly agreed. I am considering proposing a blog post about some of the
work around alternates that we have done upstream, and the impact it's
had on GitHub. This sort of walks the line between talking about an
upstream contribution and a more traditional corporate engineering blog
post, so I think that type of content certainly belongs on a comapny
blog.

> > Thanks,
> > -Stolee

Thanks,
Taylor
