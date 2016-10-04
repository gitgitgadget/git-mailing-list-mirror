Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B59020986
	for <e@80x24.org>; Tue,  4 Oct 2016 15:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752629AbcJDPgA (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 11:36:00 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:47833 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751648AbcJDPf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 11:35:59 -0400
Received: from mfilter45-d.gandi.net (mfilter45-d.gandi.net [217.70.178.176])
        by relay4-d.mail.gandi.net (Postfix) with ESMTP id 271AD1720E2;
        Tue,  4 Oct 2016 17:35:57 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter45-d.gandi.net
Received: from relay4-d.mail.gandi.net ([IPv6:::ffff:217.70.183.196])
        by mfilter45-d.gandi.net (mfilter45-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id xFHA8xWeVkt7; Tue,  4 Oct 2016 17:35:25 +0200 (CEST)
X-Originating-IP: 46.232.148.34
Received: from localhost (ip-46-232-148-34.static.adsl.cheapnet.it [46.232.148.34])
        (Authenticated sender: strk@kbt.io)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 208FD1720C8;
        Tue,  4 Oct 2016 17:35:24 +0200 (CEST)
Date:   Tue, 4 Oct 2016 17:35:23 +0200
From:   Sandro Santilli <strk@kbt.io>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: color.diff.whitespace unused on removed lines
Message-ID: <20161004153523.GA2798@localhost>
References: <20161004081429.GC17002@localhost>
 <20161004152954.74bojbyagxr2xefz@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161004152954.74bojbyagxr2xefz@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 04, 2016 at 11:29:55AM -0400, Jeff King wrote:
> On Tue, Oct 04, 2016 at 10:14:29AM +0200, Sandro Santilli wrote:
> 
> > The color.diff.whitespace configuration is not used on
> > removed lines, but only on added lines.
> 
> Right. The original purpose was to warn you when you were introducing
> whitespace breakages. Getting rid of other people's whitespace breakages
> is OK.
> 
> We later did b8767f7 (diff.c: --ws-error-highlight=<kind> option,
> 2015-05-26) to let you see them on other lines, though. I think that
> would do what you want.

Thanks, it does do what I want.
Any chance to specify it in the config file that I want it
always to behave in a certain way ?

--strk;
