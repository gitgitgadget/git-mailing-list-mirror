Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A84CC208E8
	for <e@80x24.org>; Tue, 24 Jul 2018 19:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388771AbeGXVCI (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 17:02:08 -0400
Received: from ICGRIDDB04.SEAS.UPENN.EDU ([158.130.57.72]:49002 "EHLO
        ICGRIDDB04.SEAS.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388587AbeGXVCI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 17:02:08 -0400
Received: from [10.13.0.6] (helo=ofb.net)
        by ICGRIDDB04.SEAS.upenn.edu with esmtp (Exim 4.89)
        (envelope-from <frederik@ofb.net>)
        id 1fi3Ne-0007yD-JJ; Tue, 24 Jul 2018 15:53:58 -0400
Received: from thutmose (unknown [173.239.75.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ofb.net (Postfix) with ESMTPSA id 5E26A3EDCE;
        Tue, 24 Jul 2018 12:53:53 -0700 (PDT)
Received: from frederik by thutmose with local (Exim 4.91)
        (envelope-from <frederik@thutmose>)
        id 1fi3M2-0000ud-2C; Tue, 24 Jul 2018 12:52:18 -0700
Date:   Tue, 24 Jul 2018 12:52:18 -0700
From:   frederik@ofb.net
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: Re: de-alphabetizing the documentation
Message-ID: <20180724195217.GA9366@ofb.net>
Reply-To: frederik@ofb.net
References: <20180706213239.GA867@flurp.local>
 <20180706211828.GC6195@aiede.svl.corp.google.com>
 <20180706232147.GF6343@ofb.net>
 <20180706234715.GA81694@aiede.svl.corp.google.com>
 <20180708010926.GK6343@ofb.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180708010926.GK6343@ofb.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Jonathan,

Thank you for replying to me earlier. I just wanted to follow up on
this thread. Did you decide not to go with my proposal?

Next week I should have time to send you a patch with the manual page
reordered... although, unless you have a special 'diff' which can
detect when text has been moved from one place to another, I'm
guessing it would take you even longer to check the validity of the
patch than it would for me to create it.

However, I'm happy to do this or whatever other small projects you
would like to delegate as far as improving readability of your
documentation. I just need to know what is likely to be accepted.

Thanks,

Frederick

On Sat, Jul 07, 2018 at 06:09:26PM -0700, frederik@ofb.net wrote:
> Hi Jonathan,
> 
> If it's really just a matter of needing someone with a newcomer's
> perspective, then I'd be happy to look over the ordering of the git
> subcommands. You can run the command I provided to glean the frequency
> of each subcommand from your shell history, I'll look over the output
> and see if the ordering makes sense to me, and then you or someone
> else can rearrange the manual page to list the subcommands in this
> order. Is that a suitable plan?
> 
> Thanks,
> 
> Frederick
> 
> On Fri, Jul 06, 2018 at 04:47:15PM -0700, Jonathan Nieder wrote:
> > Hi,
> > 
> > Frederick Eaton wrote:
> > 
> > >       Unfortunately my contribution will have to be limited for the
> > > moment to making this suggestion, as I am extraordinarily busy. I hope
> > > it will not be too burdensome to add this item to your TODO list and
> > > keep it there until a willing volunteer comes along.
> > 
> > No problem.  If you have time to contribute later, we can wait. :)
> > 
> > > For what it's worth, I made extensive changes to the Arch Wiki Git
> > > article back in 2015, following an initial attempt of mine to
> > > understand various tutorials. It was the most prominent wiki-based Git
> > > documentation I could find at the time. The article has of course seen
> > > numerous improvements since then.
> > 
> > For reference: https://wiki.archlinux.org/index.php/git
> > 
> > > I don't think that it's really important to find a "best" ordering for
> > > commands or glossary terms; it's more a matter of finding someone who
> > > is willing to take responsibility for choosing a reasonable ordering.
> > > Presumably the head maintainer of this project could delegate the task
> > > to a qualified volunteer, not a newbie like myself but not necessarily
> > > someone with expert knowledge either.
> > 
> > I'd have to say, when I compare the troubles a new user and a
> > long-timer would run into, I conclude that the long-timers would be
> > more likely to produce worse documentation.  It is very difficult to
> > remember how new users see things.  The ideal skill set in fact has
> > nothing to do with level of Git expertise: to produce a good result, a
> > good technical writer would ask the right questions to gather
> > information from the experts and then test their documentation on
> > newcomers until it works well.
> > 
> > Based on the work you've described already having done, it sounds like
> > you'd be an ideal person to get this going, if you find yourself with
> > time for it.
> > 
> > >                                       It's too bad that a policy of
> > > not listing things alphabetically wasn't adopted from the beginning of
> > > this project, but I guess that's life.
> > 
> > From this thread I've been convinced that for this kind of reference
> > document, alphabetical organization within each section is a good
> > organization, provided each section is small enough (as in "git help"
> > output).
> > 
> > I'm also a fan of non reference documentation that can use a narrative
> > ordering instead (like "git help core-tutorial", except with more
> > modern commands).
> > 
> > > Thanks Eric for the pointer to "git help". This does indeed provide a
> > > finer and better grouping than the man-page (but it also looks like
> > > another candidate for de-alphabetization...!).
> > 
> > Indeed, copying that organization over from "git help" to the git(1)
> > manpage may be a good step for any interested people overhearing this
> > conversation.
> > 
> > As a first step, how about making git(1) recommend "git help", like
> > this?  It already recommends giteveryday(7) but the more interactive
> > first command might be useful for some people.
> > 
> > Thoughts?  Improvements?
> > 
> > -- >8 --
> > Subject: git doc: recommend "git help" as a starting point
> > 
> > The list of subcommands described in git(1) can be overwhelming.
> > Encourage newcomers to run "git help" to get a shorter list of
> > commands as a starting point.
> > 
> > Based on a suggestion by Frederick Eaton.
> > 
> > Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> > ---
> >  Documentation/git.txt | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/git.txt b/Documentation/git.txt
> > index dba7f0c18e..0149ce9af0 100644
> > --- a/Documentation/git.txt
> > +++ b/Documentation/git.txt
> > @@ -23,9 +23,12 @@ unusually rich command set that provides both high-level operations
> >  and full access to internals.
> >  
> >  See linkgit:gittutorial[7] to get started, then see
> > -linkgit:giteveryday[7] for a useful minimum set of
> > -commands.  The link:user-manual.html[Git User's Manual] has a more
> > -in-depth introduction.
> > +linkgit:giteveryday[7] and run
> > +
> > +    git help
> > +
> > +for a useful minimum set of commands.  The link:user-manual.html[Git
> > +User's Manual] has a more in-depth introduction.
> >  
> >  After you mastered the basic concepts, you can come back to this
> >  page to learn what commands Git offers.  You can learn more about
> > -- 
> > 2.18.0.203.gfac676dfb9
> > 
> 
