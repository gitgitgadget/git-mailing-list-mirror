Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8259F209AB
	for <e@80x24.org>; Tue,  5 Sep 2017 20:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752614AbdIEUbd (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 16:31:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:57796 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752176AbdIEUbc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 16:31:32 -0400
Received: (qmail 1385 invoked by uid 109); 5 Sep 2017 20:31:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 20:31:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16573 invoked by uid 111); 5 Sep 2017 20:32:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 16:32:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Sep 2017 16:31:30 -0400
Date:   Tue, 5 Sep 2017 16:31:30 -0400
From:   Jeff King <peff@peff.net>
To:     wafflecode@openmail.cc
Cc:     git@vger.kernel.org
Subject: Re: Empty directories in Git: Current guidance for historical
 commits?
Message-ID: <20170905203130.fgleyt7josyjnps7@sigill.intra.peff.net>
References: <20170905124743.Horde.bgYg8gUhE6ubSHtPAr3lCGl@vfemail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170905124743.Horde.bgYg8gUhE6ubSHtPAr3lCGl@vfemail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 05, 2017 at 12:47:43PM +0000, wafflecode@openmail.cc wrote:

> Is just dropping a ".gitignore" or "README" file in the empty directories
> during conversion still the most reasonable approach?

Yes, I think so.

> If so, is there a way
> to do this automatically during the conversion using "git svn" or the like?

I haven't used git-svn in years, but the manpage says:

  --preserve-empty-dirs
      Create a placeholder file in the local Git repository for each
      empty directory fetched from Subversion. This includes directories
      that become empty by removing all entries in the Subversion
      repository (but not the directory itself). The placeholder files
      are also tracked and removed when no longer necessary.

-Peff
