Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0020DC433B4
	for <git@archiver.kernel.org>; Mon, 17 May 2021 09:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8D5761184
	for <git@archiver.kernel.org>; Mon, 17 May 2021 09:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235828AbhEQJHk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 05:07:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:56122 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233552AbhEQJHk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 05:07:40 -0400
Received: (qmail 4651 invoked by uid 109); 17 May 2021 09:06:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 17 May 2021 09:06:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26710 invoked by uid 111); 17 May 2021 09:06:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 May 2021 05:06:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 May 2021 05:06:23 -0400
From:   Jeff King <peff@peff.net>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Allan Ford <allan.ford17@gmail.com>, git@vger.kernel.org
Subject: Re: Git Gui - Searching for in Google
Message-ID: <YKIyD3QXQYHJVSS0@coredump.intra.peff.net>
References: <CAL-6oQo3KDrrw+DiQsJJR_2tMjrLY3xu5ARJz0SJJ-naQqo8Rw@mail.gmail.com>
 <20210516090133.xe2cooqzr2knyt46@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210516090133.xe2cooqzr2knyt46@yadavpratyush.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 16, 2021 at 02:31:33PM +0530, Pratyush Yadav wrote:

> On 14/05/21 07:17PM, Allan Ford wrote:
> > Dear Git Community,
> > 
> > Just a thought and suggestion ..
> > 
> > Git Gui comes with Git download .. (remember this now ..)
> > 
> > https://git-scm.com/downloads states this in text.
> > https://git-scm.com/downloads/guis states this in text.
> > 
> > 
> > However .. If a person is using Google and searching for Git Gui
> > download am thinking a picture of what Git Gui interface looks like
> > would help flag to the searcher that they are in the right place ! ?
> > 
> > I.e. https://git-scm.com/downloads/guis has pictures of all the other
> > GUI Clients .. but not git gui !
> > 
> > Git Gui has the recognizable vertical Git in large Grey Red and Green letters ..
> > 
> > What do you think ?
> > Can we add a picture of Git Gui interface to either
> > https://git-scm.com/downloads or https://git-scm.com/downloads/guis ?
> 
> I think this would be a good idea. I have added Jeff in Cc who I think 
> maintains the git-scm.com website at [0]. Please create a Pull Request 
> there to add the screenshots.
> 
> [0] https://github.com/git/git-scm.com

The site is developed and maintained collaboratively, but yes, please
point people to making PRs at the repository you linked. :)

(I don't have a real opinion either way on screenshots for git-gui; it
is mentioned on the "GUIs" page, but it does not have its own entry in
the list, so that's an obvious thing to change).

-Peff
