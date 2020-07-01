Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F164EC433E0
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 21:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D18012077D
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 21:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgGAV5q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 17:57:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:47918 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbgGAV5q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 17:57:46 -0400
Received: (qmail 27314 invoked by uid 109); 1 Jul 2020 21:57:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Jul 2020 21:57:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11436 invoked by uid 111); 1 Jul 2020 21:57:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Jul 2020 17:57:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Jul 2020 17:57:44 -0400
From:   Jeff King <peff@peff.net>
To:     Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        James Ramsay <james@jramsay.com.au>,
        Bryan Turner <bturner@atlassian.com>
Subject: Re: Consensus on a new default branch name
Message-ID: <20200701215744.GA952178@coredump.intra.peff.net>
References: <20200615205722.GG71506@syl.local>
 <20200615212154.GA79696@syl.local>
 <20200616143107.GL666057@coredump.intra.peff.net>
 <20200617180617.GN21462@kitsune.suse.cz>
 <20200701173108.GD21462@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200701173108.GD21462@kitsune.suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 01, 2020 at 07:31:08PM +0200, Michal Suchánek wrote:

> > > > > My interpretation thus far is that 'main' is the planned replacement for
> > > > > 'master'. Consensus seems to have formed around this name [5], but if that's
> > > > > incorrect--or there are yet-unvoiced opinions that you would like to share--now
> > > > > is the time to discuss further.
> > > 
> > > My opinion is that "main" is the best suggestion I've heard.
> > 
> > See also
> > https://lore.kernel.org/git/20200616210701.22924-1-zeevriend@gmail.com/
> 
> So you completely ignore this input.

I didn't ignore it. I just didn't have anything useful to add after
reading your email.

If there's a potential problem with "main", I think it's worth
considering. But I have a very difficult time figuring out how to
consider all of the inputs. Personally, I don't find "main" to be a
problematic word. It has no other connotations in my personal
experience. But then the same is true of "master" as well.

Anybody in a similar position who is working on the project and might
need to form an opinion about which default word to use has to rely on
input from others. The email linked above is one data point. There are
other data points arguing that "master" is bad.

In an ideal world, we'd have a name that has no data points at all
arguing against it. But I'm not sure how feasible it is to accommodate
everybody. There seem to be enough data points arguing against "master"
that I can believe there's a non-trivial number of people who would like
the default changed to something else[1]. I had wondered if other people
might speak up against "main", but I have not seen anyone do so (neither
here, nor in other forums where the name "main" has been discussed).
That doesn't invalidate the opinion of the author above. But if we have
to choose something from among an imperfect set of options, then that
may involve picking the least-bad name.

I am open to the argument that the very people the author suggests might
be bothered by "main" might also not be well represented on this list or
in other forums discussing the change. It would be helpful if any
proponents of that argument could try to gather some evidence.

> That kind of gives confirmation to the naysayers that point out this is
> not really about inclusivity but about US-internal politics.
> 
> If that is so be more honest and clearly say that by being based in the
> US you must give way to certain activists or be potentailly subject to
> terrorism from the same or more radical colleagues of the activists that
> request the change.

I'm not sure what constructive action you're asking for here. The link
to the email above suggests that you might be arguing for a different
alternative besides "main". If so, please suggest it (or if you did
elsewhere already and I missed it: sorry, please repeat it).

If your point is to argue "you care about master but not about main,
therefore you're a hypocrite and we should change nothing". Then one,
I do not agree with that characterization, and two, I don't think that's
a very helpful addition to the conversation.

If you meant something else, please help me figure out what it is.

-Peff

[1] I'm also open to the argument that the number of data points arguing
    against "master" are inflated by well-meaning people who claim to
    speak on behalf of others. But it seems very hard to me to collect
    useful data on this kind of thing. My personal feeling is that it
    makes sense to err on the side of empathy where it's practical to do
    so.
