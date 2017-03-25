Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,UNPARSEABLE_RELAY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D46E1FC19
	for <e@80x24.org>; Sat, 25 Mar 2017 02:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937029AbdCYCRS (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 22:17:18 -0400
Received: from mx1.riseup.net ([198.252.153.129]:54884 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936815AbdCYCRQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 22:17:16 -0400
Received: from piha.riseup.net (unknown [10.0.1.163])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id 2F9491A194D;
        Sat, 25 Mar 2017 02:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1490408235; bh=pgXYTirKcVXbvgSu3yka82U5io5bsVczDKpet4vj8Ho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hBY+r1twJCNeCo08UgZ+tAoTlNwOgJrCKe6/02gz8dqjMEYjbspXCa32Kv3fIQ2hv
         3QSPCdjvMlUjzM80s4GgBY+/SzdciPvuMGmIUnzTk8pYP5x8Jzpf1LPUCS6hztpmeS
         AOjAzkkRURa2ffseiHrLjqmyCsBmLSzRWrejACdk=
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: pickfire)
        with ESMTPSA id D9BBC1C01A6
Date:   Sat, 25 Mar 2017 10:17:03 +0800
From:   Inaw Tham <pickfire@riseup.net>
To:     Johannes.Schindelin@gmx.de
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: Re: Re: GSoC Project | Convert interactive rebase to C
Message-ID: <20170325021703.Tjq7i-hO7%pickfire@riseup.net>
References: <20170320164154.xBcU6rG0C%pickfire@riseup.net>
 <CAGZ79kbF+O6tgn-4ivmOza3QGA4oFyJS=9eGHYZ1HQgw6+rEtQ@mail.gmail.com>
 <20170321060526.sXz0cdJwc%pickfire@riseup.net>
 <alpine.DEB.2.20.1703231827060.3767@virtualbox>
In-Reply-To: <alpine.DEB.2.20.1703231827060.3767@virtualbox>
Mail-Followup-To: sbeller@google.com, Johannes.Schindelin@gmx.de,
 git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Tue, 21 Mar 2017, Ivan Tham wrote:
> > Stefan Beller <sbeller@google.com> wrote:
> > > On Mon, Mar 20, 2017 at 9:41 AM, Ivan Tham <pickfire@riseup.net> wrote:
> > > > I am Ivan Tham. Currently studying in Computer Science in APIIT
> > > > Malaysia. I am interested particapate in Google Summer of Code 2017
> > > > under git organization. I would like to attempt "Add more builtin
> > > > patterns for userdiff" particularly for shell for my microproject.
> > >
> > > I'd love to see proper shell support!  Although there is already some
> > > support for shell (by looking at diffs on our test suite) ? So I am
> > > not sure what there is left to do? Can you clarify what you're trying
> > > there?
> > 
> > Are you sure about that? From what I had looked into userdiff.c, there
> > is no support for shell. There just a recent patch for [go patterns][0].
> > Or perhaps I should have rename it as "userdiff.c: patterns for "shell"
> > language"?
> 
> I also could not find any shell patterns in the userdiff code...

Thanks a lot for replying me, I thought no one was intereted. :D

> > > > I am interested to work on "Convert interactive rebase to C"
> > >
> > > +cc Johannes, who recently worked on rebase and the sequencer.
> 
> Glad you are interested! Please note that large parts of the interactive
> rebase are already in C now, but there is enough work left in that corner.

Glad to hear that, I would really like to see interactive rebase in C.

> > > > aiming to port most builtins stuff to C in which we can reduce the
> > > > size of git. Additionally, I would also like to convert scripts to
> > > > builtins as an additional milestone.
> 
> Careful. It is a ton of work to get the rebase -i conversion done, and
> then a ton of work to get it integrated. That will fill 3 months, very
> easily.

My main aim is to reduce the extra dependency of perl, but planning to start
with rebase, can I make that an optional task where I can help out after I
had completed my main task during gsoc?

> > > > What do you think of these projects? Would it collide with Valery
> > > > Tolstov's Shell to Builtins proposal?
> 
> I missed that proposal, and could only find submodule-related mails on the
> public-inbox server. Care to provide a pointer?
> 
> > > Curious why all people ask about colliding with Valerys proposal here?
> > > I do not think it would collide, as submodules and rebase are very
> > > different areas of the code base.
> 
> Indeed ;-)

Cheers,
Ivan Tham
