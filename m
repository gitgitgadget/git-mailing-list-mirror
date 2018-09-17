Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E03191F404
	for <e@80x24.org>; Mon, 17 Sep 2018 03:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbeIQIqX (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 04:46:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:50516 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729648AbeIQIqX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 04:46:23 -0400
Received: (qmail 15683 invoked by uid 109); 17 Sep 2018 03:21:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 17 Sep 2018 03:21:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 959 invoked by uid 111); 17 Sep 2018 03:21:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 16 Sep 2018 23:21:18 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Sep 2018 23:21:01 -0400
Date:   Sun, 16 Sep 2018 23:21:01 -0400
From:   Jeff King <peff@peff.net>
To:     David Aguilar <davvid@gmail.com>
Cc:     git@vger.kernel.org, git@sfconservancy.org
Subject: Re: Git trademark status and policy
Message-ID: <20180917032101.GD22024@sigill.intra.peff.net>
References: <20170202022655.2jwvudhvo4hmueaw@sigill.intra.peff.net>
 <20180916101520.GC18517@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180916101520.GC18517@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 16, 2018 at 03:15:20AM -0700, David Aguilar wrote:

> On Thu, Feb 02, 2017 at 03:26:56AM +0100, Jeff King wrote:
> > 
> >   - Commands like "git-foo" (so you run "git foo") are generally OK.
> >     This is Git's well-known extension mechanism, so it doesn't really
> >     imply endorsement (on the other hand, you do not get to complain if
> >     you choose too generic a name and conflict with somebody else's use
> >     of the same git-foo name).
> > 
> >   - When "git-foo" exists, we've approved "Git Foo" as a matching
> >     project name, but we haven't decided on a general rule to cover this
> >     case.  The only example here is "Git LFS".
> 
> The "Git Cola" project[1][2] provides two fully-featured Git porcelains,
> "git-cola" and "git-dag".  The DAG tool is never referred to as a
> separate project, so shouldn't be a concern trademark wise.
> 
> The project dates back to 2007, while the "Git Cola" name dates back to 2008.
> FTR, the name "Cola" is also a shout-out to Linux (comp.os.linux.announce).
> 
> Can we continue to use the name "Git Cola" going forward?

Thanks for asking.

An official answer will have to involve opinions and a vote from the
whole PLC, but let me tell you what _I_ think:

  - we mostly grandfathered good-faith names that predate the trademark,
    even if we probably wouldn't grant them today. Searching my mail
    archives, I see that git-cola did come up (along with a few others
    like Gitolite and TortoiseGit). And we even ended up with written
    agreements for some (at the very least GitLab and Gitolite), but I
    think several (including git-cola) were never officially resolved in
    anyway.

  - In my opinion "Git Cola" is a lot less confusing than something like
    "Git Cloner". Because there is little chance that somebody might say
    "Ah, the official Cola of Git!". Whereas a generic operational term
    like "Cloner" does introduce confusion (the "Git" is easily
    interpreted as "Git presents X" and not "this is an X for using with
    Git").

So my opinion is that it is not something the project should be worried
about. But like I said, do not take that as an official position at this
point.

(Also, to be clear, this is all _only_ about "Git Cola". The "git-cola"
command is explicitly OK in the policy because that's how commands
work).

> > So that's more or less where we're at now.  In my opinion, a few open
> > questions are:
> > 
> >   3. Was granting "Git LFS" the right call? I think the project is a good
> >      one and has worked well with the greater Git community. But I think
> >      the name has implied some level of "officialness". We obviously
> >      need to allow "git-lfs" as a name. But should the policy have said
> >      "you can call this LFS, and the command is git-lfs, but don't say
> >      'Git LFS'". I'm not sure.
> > 
> >      One option would have been to ask "git-foo" to prefer "Foo for Git"
> >      instead of "Git Foo" in their branding (it's too late now for "Git
> >      LFS", so this is a hypothetical question for future requests now).
> 
> In my (biased) opinion, granting "Git LFS" was the right call.
> 
> As long as the project is clearly a separate, but primarily Git-centric,
> project then it seems like the right approach to allow "Git Foo" for
> open source projects that contribute positively to the Git ecosystem.

Yes, I have to admit that being a good citizen of the ecosystem counts
for a lot in my book. But it's often helpful to make these decisions
early on in the project's life (because name changes are awkward later
on), and we have to just guess at how things will play out. Git Cola is
again easier there because of the history.

> Lastly, due to time constraints, the Git Cola logo is a tweaked version
> of the Git logo, which may convey a level of "officialness" that might
> be unwanted.  We can work on a replacement if desired.
> 
> Part of keeping the logo/visual identity close to core Git is because
> the tool was always meant to be strongly tied to Git's unique features.
> It's probably the same reason why the git-lfs branding uses similar
> orange/red palettes -- to convey cohesiveness.  I would prefer to keep
> the visual identity as-is (including the logo).
> 
> Can we continue to use the derivative logo for the time being until a
> replacement is produced?  Alternatively, can we keep the logo as-is?

I don't think this is a question we've ever really considered before.

I had to actually dig a little to find any use of the logo, which
doesn't seem to be on most of your screenshots. :) For reference, this
is the one I found:

  https://github.com/git-cola/git-cola/blob/master/share/git-cola/icons/git-cola.svg

I do think that's much more ambiguous than just the name when it comes
to potentially confusing endorsement. If a random proprietary GUI client
had a logo like that, I think we'd probably ask them to change it. But I
have to admit that given the general good history of git-cola, the fact
that it's open-source, and the fact that its main developer is also a
helpful member of the Git development community, I'm less inclined to do
so here.

So in that sense, I don't have any problem saying "sure, let's make an
explicit exception here". But I do wonder if we're better off trying to
be as even and impartial as possible, so as not to create funny
distortions (i.e., doing anything that endorses one over the other; I
don't really use any graphical interface around Git, and I don't have an
opinion on the technical qualities).

I'd be curious to hear what other people in the community think.

-Peff
