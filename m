Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63D29207E4
	for <e@80x24.org>; Wed, 26 Apr 2017 01:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1434429AbdDZBrK (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 21:47:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:40245 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1434425AbdDZBrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 21:47:09 -0400
Received: (qmail 30757 invoked by uid 109); 26 Apr 2017 01:47:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 26 Apr 2017 01:47:07 +0000
Received: (qmail 11839 invoked by uid 111); 26 Apr 2017 01:47:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Apr 2017 21:47:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Apr 2017 21:47:05 -0400
Date:   Tue, 25 Apr 2017 21:47:05 -0400
From:   Jeff King <peff@peff.net>
To:     liam Beguin <liambeguin@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] rebase -i: add config to abbreviate command-names
Message-ID: <20170426014704.blyczgmbuqd5amys@sigill.intra.peff.net>
References: <20170424032347.10878-1-liambeguin@gmail.com>
 <20170425044320.17840-1-liambeguin@gmail.com>
 <alpine.DEB.2.20.1704252148400.3480@virtualbox>
 <1493165607.29673.31.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1493165607.29673.31.camel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 25, 2017 at 08:13:27PM -0400, liam Beguin wrote:

> > > +rebase.abbrevCmd::
> > > +	If set to true, `git rebase -i` will abbreviate the command-names in the
> > > +	instruction list. This means that instead of looking like this,
> > 
> > This is by no means your fault, but it is really horrible by how many
> > different names Git's documentation refers to the todo script, nothing
> > short of confusing. It is the todo script (which I called it initially,
> > maybe not a good name, but it has the merit of the longest tradition at
> > least), the todo list, the instruction sheet, the rebase script, the
> > instruction list... etc
> > 
> > However, the thing is called "todo list" elsewhere in the same file,
> > therefore lets try to avoid even more confusion and use that term instead
> > of "instruction list" here.
> 
> thanks for pointing this out, I was not quite sure what to call this list.

I think the words "instruction list" may have come from my suggestion. I
used them because that is the term used in the rebase.instructionFormat
documentation directly above the option you are adding.

It may be worth a follow-on patch to convert that one to "todo list" if
that's the preferred name.

-Peff
