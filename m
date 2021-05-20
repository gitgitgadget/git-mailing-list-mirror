Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AFEC433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 17:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E36C561279
	for <git@archiver.kernel.org>; Thu, 20 May 2021 17:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhETRUZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 13:20:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:60820 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231391AbhETRUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 13:20:25 -0400
Received: (qmail 28772 invoked by uid 109); 20 May 2021 17:19:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 20 May 2021 17:19:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1102 invoked by uid 111); 20 May 2021 17:19:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 20 May 2021 13:19:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 20 May 2021 13:19:02 -0400
From:   Jeff King <peff@peff.net>
To:     Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>,
        Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
Subject: Re: Should we do something with #git-devel on Freenode?
Message-ID: <YKaaBj0KmJ3K5foC@coredump.intra.peff.net>
References: <CAJoAoZ=e62sceNpcR5L5zjsj177uczTnXjcAg+BbOoOkeH8vXQ@mail.gmail.com>
 <YKViF9OVLeA95JPH@google.com>
 <20210520071141.GZ8544@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210520071141.GZ8544@kitsune.suse.cz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 20, 2021 at 09:11:41AM +0200, Michal Suchánek wrote:

> > It looks like most of the Freenode admins have moved to
> > https://libera.chat/, so that would be a close equivalent.  Another
> > alternative is OFTC <https://www.oftc.net/>, which is used by
> > irc.debian.org, for example.
> > 
> > There are also other real-time chat programs such as Zulip (open
> > source, used in Outreachy), Discord (used by LLVM), and Slack (used by
> > Chromium); each has its benefits and flaws.
> 
> Or Matrix used by Mozilla, GNOME, and others.
> 
> Unlike the others Matrix intends to be not just a chat application
> (opensource or proprietary) but open standard which has multiple
> implementetions of both the server and the client.
> 
> In that way it is the most flexible option allowing communication
> between people with different UX preferences.

I don't have much of an opinion either way, as I do not usually use the
irc channel at all. And my comment is perhaps more about #git than
#git-devel.

But I would say that the decision to move to another application would
be one that can be made by individual people. I.e., the reason people
come to freenode #git to ask questions is because there are useful
people hanging out there who will answer them. And likewise to
#git-devel, because that's where the people who can have useful
discussions are.

So if there is a critical mass of useful people that will hang out on
the Matrix equivalent of #git (or whatever other tool), then that may
become a new place. And people who want to do that should let people
know where they can be found (whatever happens, I'd appreciate a PR to
https://github.com/git/git-scm.com updating the "Community" page).

Of course there's value in coordinating. Everybody _can_ hang out on
their favorite venues and eventually talk to each other, but it's much
easier if everybody agrees where to go. :) I think Emily's question is
more "where do folks who hang out on #git-devel want to hang out now".
And that's why I say my comments are probably more relevant for #git
(where devs don't need to coordinate as much; useful people can just
hang out and help folks with questions).

-Peff

PS A lot of this may reflect my view that there is no "official"
structure for a lot of Git. We all used gmane as an archive because it
was the best option at the time. Then it got worse, and Eric made
public-inbox because it was what he wanted. And we all used it because
it was so good. But there never needed to be any official adoption
decision. Likewise for irc. I don't think #git or even #git-devel has
any official status. It is simply where people doing things chose to go.
Now they may choose to go somewhere else, but they don't necessarily
have to do it as a unit.
