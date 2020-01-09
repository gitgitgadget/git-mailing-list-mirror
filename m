Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4214C32771
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 07:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C4472072A
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 07:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgAIH5t (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jan 2020 02:57:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:60856 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728277AbgAIH5t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jan 2020 02:57:49 -0500
Received: (qmail 27274 invoked by uid 109); 9 Jan 2020 07:57:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 Jan 2020 07:57:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16182 invoked by uid 111); 9 Jan 2020 08:03:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Jan 2020 03:03:32 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Jan 2020 02:57:48 -0500
From:   Jeff King <peff@peff.net>
To:     Paul Wise <pabs3@bonedaddy.net>
Cc:     git@vger.kernel.org
Subject: Re: interoperability between git and other VCS and data
 storage/transfer tools?
Message-ID: <20200109075748.GB3978837@coredump.intra.peff.net>
References: <929fe6f7f41a2abca353df4fd7f602a3e22ceb5f.camel@bonedaddy.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <929fe6f7f41a2abca353df4fd7f602a3e22ceb5f.camel@bonedaddy.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 09, 2020 at 08:59:51AM +0800, Paul Wise wrote:

> I still need mostly bi-directional interoperability between git and
> CVS, Subversion, Mercurial, Breezy/Bazaar, Darcs, Mediawiki and rsync.
> On the horizon are Fossil and Pijul but I probably won't need those any
> time soon. Recently I had a situation where GNU Arch support would have
> been helpful for viewing historical commit information but I assumed
> that support for it didn't exist so I didn't bother.

I don't know if you need it to be bidirectional, but there is
git-archimport. I'll warn you that it's pretty unmaintained, though so
best of luck. :)

> Is there a location in the git documentation for pointers to software
> (such as git-remote-* helpers) that can help with VCS interoperability?

There's:

  https://git.wiki.kernel.org/index.php/Interfaces,_frontends,_and_tools#Interaction_with_other_Revision_Control_Systems

I have no idea how up-to-date it is (I admit that I converted all of my
repos to Git in 2006 and haven't really looked back).

> Mercurial: git-remote-hg (there are lots of forks/implementations)

I haven't used it, but there's also:

  https://github.com/glandium/git-cinnabar

which seems to be actively used and maintained.

-Peff
