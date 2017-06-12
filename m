Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FB8920401
	for <e@80x24.org>; Mon, 12 Jun 2017 22:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752661AbdFLWGJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 18:06:09 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36505 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752619AbdFLWGI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 18:06:08 -0400
Received: by mail-pg0-f51.google.com with SMTP id a70so50676736pge.3
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 15:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8xhQJeAjI8uHkvvuVicJ38dggEWjp2URxQROdK8dcqY=;
        b=hDDQmqBEj/bL80y0TRbCij7hW3GzwocZ6hjNJ/B4DBcDuJ6B+IpWJostsJY2oLLVac
         UtyEjFGvIcrlf+/790mfUZ3VwYBZZixC7JGKUibUnwGFlUGSwOeceTSMY+gtJKp9PlO6
         2YJybLnLZBjAz1fHsuvyBwOWvGcceJFdysi4jVf6+7xceerhag6HusW3bP4p/rMmCOed
         hy8AgsjsBgBobmY4cdUuJdarYd5ZPABX6j4TY3WlyB7wxscMktjqDPgSOHlMZko133f7
         iqFanmNzkxmFLlznZIwoB2KbtreHuhRwozdwvM1mMofZdkrUHWzl2iSiVol0Hk9nPVHU
         Z6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8xhQJeAjI8uHkvvuVicJ38dggEWjp2URxQROdK8dcqY=;
        b=otLpIEDKrXrCYuGlINo4r1GP2qRe7e8L/CEnye2znzqyV0HWIki0zuYFtMzw4lq2IZ
         fq8PN3Q+ggmAPA/JW0+Nv5wYhdV7dJkqrWG/WAHo1bVcXq/hYpZ+GIIGQtyrBCLYkx7V
         Ytm0KE3VtvQQBmwlHckvlZyKUpI9pvlwADtZhAR8M96uwnZRaUIzgLukufXLRvlXYAm1
         MPvDaS2V920thAce+1K4Ii/ziiqO2RDl2iU/RabkO7nJDKBSjQT2sB9ttqOXRNkvqnof
         Cr8OqFP3E7tjcbDX2kCx6VtsRAzaoQD+ekRUg8po4cuINuPqybPIcI9l19LqcDO+3QRD
         KG9Q==
X-Gm-Message-State: AODbwcA7zIZ9ePZvkdhX0fQoQcA0Z+49IW5Ee6FxdQCmX36keFYC5pGc
        QC0Hg1AXQH0GMCfNpmWSkg==
X-Received: by 10.98.51.129 with SMTP id z123mr58847241pfz.100.1497305167903;
        Mon, 12 Jun 2017 15:06:07 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:9d75:7c5f:d212:fb28])
        by smtp.gmail.com with ESMTPSA id 67sm20213791pfn.84.2017.06.12.15.06.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 15:06:07 -0700 (PDT)
Date:   Mon, 12 Jun 2017 15:06:05 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com
Subject: Re: [PATCH 0/4] config.h
Message-ID: <20170612220605.GF154599@google.com>
References: <20170612213406.83247-1-bmwill@google.com>
 <20170612214502.xynyfswj2ipf25ah@sigill.intra.peff.net>
 <20170612215352.GE154599@google.com>
 <20170612220244.dcndhmxpnsz2tg5d@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170612220244.dcndhmxpnsz2tg5d@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/12, Jeff King wrote:
> On Mon, Jun 12, 2017 at 02:53:52PM -0700, Brandon Williams wrote:
> 
> > > These all seem reasonable to me. Patch 3 made me shrug a little, because
> > > it seems like the majority of C files end up including it anyway. I
> > > suspect you could break config.h down into two files: the few things
> > > that everybody needs (git_config() and the few parsing functions needed
> > > in callbacks) and the ones for commands that actually manipulate the
> > > config.
> > > 
> > > That would reduce the surface area of the module that most callers look
> > > at, but I don't think there's a huge benefit to doing so (mostly it just
> > > makes re-compiling faster by decreasing the chance that a dependent
> > > header has changed for each file).
> > 
> > Yes, ultimately I think it would be a good thing to break config.c down
> > into at least 2 more files (the file parsing logic and the config_set
> > logic) but that can be done at a later point.  I started looking at
> > doing that now but that logic is a little more entangled than I thought
> > it was.
> 
> To be clear, I don't mind that sort of module refactoring and like the
> results.  But it almost certainly isn't the biggest bang-for-buck in
> terms of the time it takes versus the benefit it brings. So take my
> comment as "we could also do..." but not "we should not take your patch
> because it does not go far enough".

Yes, that's how I understood your comment.  I realize that there's a lot
of improvements that can be done across our code base and one rabbit
hole that is easy to fall into is "fix all the things right now!" hence
why I decided to defer doing that to a later date.  And I agree that
doing that extra work doesn't buy us 'all too much'.

Having said that I do think it was worthwhile to remove the config
declarations from cache.h.  I think in the long term it would be nice to
limit cache.h's scope as it is very unapproachable in its current form.

-- 
Brandon Williams
