Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0AC220986
	for <e@80x24.org>; Thu,  6 Oct 2016 09:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965868AbcJFJXk (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 05:23:40 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.42]:47569 "EHLO
        smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965567AbcJFJXi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 05:23:38 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay04.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1bs4tq-0005tH-3j; Thu, 06 Oct 2016 11:23:34 +0200
Date:   Thu, 6 Oct 2016 11:23:32 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, peff@peff.net,
        torvalds@linux-foundation.org
Subject: Re: [PATCHv3 1/2] push: change submodule default to check when
 submodules exist
Message-ID: <20161006092332.GB38550@book.hvoigt.net>
References: <CAGZ79kbt+SZoogKTV_-rVfOOFzf6xrhWytrBo2H3r6NQw34WTw@mail.gmail.com>
 <20161004210359.15266-1-sbeller@google.com>
 <20161005135325.GC30930@book.hvoigt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161005135325.GC30930@book.hvoigt.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 05, 2016 at 03:53:25PM +0200, Heiko Voigt wrote:
> On Tue, Oct 04, 2016 at 02:03:58PM -0700, Stefan Beller wrote:
> > Jeff,
> > thanks for the suggestions, both git_path(..) as well as checking the config,
> > this seems quite readable to me:
> 
> When reading the discussion I thought the same: What about the
> "old-style" repositories. I like this one. Checking both locations
> is nice.

BTW, since it seems we all agree on the direction. Should we add some
tests?

Cheers Heiko
