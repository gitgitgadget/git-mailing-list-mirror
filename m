Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A73C1FE4E
	for <e@80x24.org>; Sun, 19 Jun 2016 10:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbcFSKKs (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 06:10:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:56882 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751578AbcFSKKr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2016 06:10:47 -0400
Received: (qmail 32203 invoked by uid 102); 19 Jun 2016 10:10:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 19 Jun 2016 06:10:47 -0400
Received: (qmail 6491 invoked by uid 107); 19 Jun 2016 10:11:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 19 Jun 2016 06:11:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 19 Jun 2016 06:10:44 -0400
Date:	Sun, 19 Jun 2016 06:10:44 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2016, #08; Thu, 26)
Message-ID: <20160619101044.GA12994@sigill.intra.peff.net>
References: <xmqqeg8otowp.fsf@gitster.mtv.corp.google.com>
 <20160527003621.GB26262@sigill.intra.peff.net>
 <xmqqy462x9es.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqy462x9es.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jun 18, 2016 at 06:19:23PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Thu, May 26, 2016 at 03:50:14PM -0700, Junio C Hamano wrote:
> >
> >> * jk/upload-pack-hook (2016-05-24) 6 commits
> >>  - upload-pack: provide a hook for running pack-objects
> >>  - config: add a notion of "scope"
> >>  - config: return configset value for current_config_ functions
> >>  - config: set up config_source for command-line config
> >>  - git_config_parse_parameter: refactor cleanup code
> >>  - git_config_with_options: drop "found" counting
> >> 
> >>  Allow a custom "git upload-pack" replacement to respond to
> >>  "fetch/clone" request.
> >> 
> >>  Will merge to 'next'.
> >
> > I just sent a replacement for the fourth patch that avoids the t/helper
> > problem. It's probably worth dealing with before even hitting "next" so
> > as not to break bisection.
> >
> > You should probably hold off on merging the top one. The discussion
> > stalled because I was on vacation, but it has resumed now (the earlier
> > refactoring bits are uncontroversial, I think).
> 
> And then it seems nothing happened.  Can we settle this soonish?

I am OK with what you have queued; I was mostly giving Ævar a chance to
respond to my final response in the thread[1].

-Peff

[1] http://article.gmane.org/gmane.comp.version-control.git/295634
