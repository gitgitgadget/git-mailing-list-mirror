Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32B3B20446
	for <e@80x24.org>; Tue, 17 Oct 2017 16:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933109AbdJQQic (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 12:38:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:55540 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932503AbdJQQib (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 12:38:31 -0400
Received: (qmail 4030 invoked by uid 109); 17 Oct 2017 16:38:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 17 Oct 2017 16:38:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24794 invoked by uid 111); 17 Oct 2017 16:38:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 17 Oct 2017 12:38:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Oct 2017 12:38:29 -0400
Date:   Tue, 17 Oct 2017 12:38:29 -0400
From:   Jeff King <peff@peff.net>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Minor man page weirdness?
Message-ID: <20171017163828.igmlsbdynpe6m37w@sigill.intra.peff.net>
References: <A4E5D8CC-19A7-442A-814C-FD5A46391982@gmail.com>
 <20171016225641.x76jwycb7mcpvrw3@sigill.intra.peff.net>
 <87d15lu48o.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87d15lu48o.fsf@linux-m68k.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 17, 2017 at 06:29:59PM +0200, Andreas Schwab wrote:

> On Okt 16 2017, Jeff King <peff@peff.net> wrote:
> 
> > I get:
> >
> >   Reset <branchname> to <startpoint> if <branchname> exists already\&. Without
> >   \fB\-f\fR
> >   \fIgit branch\fR
> >   refuses to change an existing branch\&. In combination with
> 
> I see this in git-branch.1:
> 
>   Reset <branchname> to <startpoint> if <branchname> exists already\&. Without
>   \fB\-f\fR\fIgit branch\fR
>   refuses to change an existing branch\&. In combination with
> 
> This is with asciidoc 8.6.9.

Thanks, that seems a likely culprit, then. What's in your git-branch.xml
after you build the documentation?

-Peff
