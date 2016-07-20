Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31B6F1F744
	for <e@80x24.org>; Wed, 20 Jul 2016 20:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492AbcGTU56 (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 16:57:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:47785 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751762AbcGTU55 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 16:57:57 -0400
Received: (qmail 29102 invoked by uid 102); 20 Jul 2016 20:57:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Jul 2016 16:57:57 -0400
Received: (qmail 24747 invoked by uid 107); 20 Jul 2016 20:58:20 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Jul 2016 16:58:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jul 2016 14:57:53 -0600
Date:	Wed, 20 Jul 2016 14:57:53 -0600
From:	Jeff King <peff@peff.net>
To:	Jeff Hostetler <git@jeffhostetler.com>
Cc:	Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org,
	gitster@pobox.com
Subject: Re: [PATCH v1 0/6] Porcelain Status V2
Message-ID: <20160720205753.GC578@sigill.intra.peff.net>
References: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com>
 <20160720161543.GD24902@sigill.intra.peff.net>
 <578FD0B1.9030709@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <578FD0B1.9030709@jeffhostetler.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 20, 2016 at 03:27:45PM -0400, Jeff Hostetler wrote:

> > A totally reasonable response is "haha no. Please stop moving the
> > goalposts". I just wanted to throw it out there as an option (and in
> > case you are interested, to let you think about it before any more work
> > goes into this direction).
> 
> haha no.... :-)
> 
> Short term, I'd rather nail down what I have now (both content-wise
> and format-wise) and see how we like it.  And have a follow-up task
> to look at the --state header we spoke of earlier.  And save the JSON
> version as an independent task for later.
> 
> I understand the motivation for a JSON option (and have thought
> about it before) but I think it ought to be kept separate.
> At a higher-level, it seems like a JSON option would be an
> opportunity to start a project-wide conversation about formats,
> consistency, plumbing, and etc.  A top-down conversation if you
> will about which commands will/won't get enhanced, legacy cruft
> that would not need to be converted, JSON style and naming and
> consistency issues, current best practices in the node/whatever
> community, and etc.  I could be wrong, but this feels like a
> top-down feature conversation in a wider audience.

I agree with everything you've said here.

If we add JSON, we'd want to do it everywhere: lists of commits, lists
of refs, status output, etc. I mentioned that somebody had asked me
about it recently; they are working on a git client and finding that
libgit2 is not serving their needs well, so they'd like to shell out to
git more, and wanted to have a standard way to get the data back in.

-Peff
