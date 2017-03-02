Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EC5520133
	for <e@80x24.org>; Thu,  2 Mar 2017 08:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754187AbdCBILU (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 03:11:20 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:54722 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753798AbdCBILR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 03:11:17 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 930A720133;
        Thu,  2 Mar 2017 07:34:21 +0000 (UTC)
Date:   Thu, 2 Mar 2017 07:34:21 +0000
From:   Eric Wong <e@80x24.org>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] README: create HTTP/HTTPS links from URLs in Markdown
Message-ID: <20170302073421.GA2528@whir>
References: <20170301222204.GA5413@whir>
 <20170302071810.pbczh3p4w4bnyqzg@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170302071810.pbczh3p4w4bnyqzg@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> On Wed, Mar 01, 2017 at 10:22:04PM +0000, Eric Wong wrote:
> 
> > Markdown supports automatic links by surrounding URLs with
> > angle brackets, as documented in
> > <https://daringfireball.net/projects/markdown/syntax#autolink>
> 
> One of the joys of markdown is that there are so many variants. A lot of
> them (including GitHub-flavored markdown) will linkify URLs even when
> they're not inside angle brackets.
> 
> So I don't mind this patch, but I'm curious what's rendering the
> markdown you're seeing. I'd think online that one would either come
> across the raw text, or the GFM from https://github.com/git/git.

I was using Gruber's reference implementation from Debian stable
(1.0.1-7).

Also, pandoc (also Debian stable 1.12.4.2~dfsg-1+b14) seems to
require angle brackets by default.  pandoc also supports the
"-f markdown_github" option where it seems to behave like GFM.

But yeah, I much prefer the unambiguity of angle brackets,
especially when URLs are followed immediately but punctuation
such as ',' or '.'.
