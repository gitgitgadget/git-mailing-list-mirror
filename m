Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 846F820A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 07:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbeLLH7D (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 02:59:03 -0500
Received: from cpanel4.indieserve.net ([199.212.143.9]:44574 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbeLLH7D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 02:59:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6hZ5Pl9xjZ00KHw8vfYOkv/V+QZPRqMGEhoMHFtMW8U=; b=eP3YL9CovV3N6A85E1arNTZFE
        gQWO5aYFYgKMKIuPcRJpKd8rY9/EI/wGFvUsv98NXIUyoLepYwHyVApL8O/APhba6XOU8+Az1XNEx
        w1KLuEn28pSY3NOxQB4l1h+4Wcs9o19gASoEkQXUVFjquQbA97kG2b5925j6MehrDEUc9nv/BFK7F
        VbQ5W1+HOL2CZbAGuJgSExs8mMM0c/8EDrhKxMCMtcsyPUUPGqnIW2th/ujhu6N/zuvZJJJ2iB7BL
        hs8bcOcgmKq10WLBXkOJBB+xsKpMSH1ttZQObRlM3c1drv81Tk2p54/nViox+BabEqq4hqxdQ/S7f
        Dbxmjzgeg==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:48564 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1gWzQ4-00FCUW-4m; Wed, 12 Dec 2018 02:59:01 -0500
Date:   Wed, 12 Dec 2018 02:58:46 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Jon Forrest <nobozo@gmail.com>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: Announcing Pro Git Second Edition Reedited
In-Reply-To: <a1941151-9453-5830-7175-7c8e27425274@gmail.com>
Message-ID: <alpine.LFD.2.21.1812120254430.19520@localhost.localdomain>
References: <pujni2$ulb$1@blaine.gmane.org> <20181211105007.GD7233@sigill.intra.peff.net> <a1941151-9453-5830-7175-7c8e27425274@gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 11 Dec 2018, Jon Forrest wrote:

> On 12/11/2018 2:50 AM, Jeff King wrote:
>
> > The content at https://git-scm.com/book is pulled regularly from
> > https://github.com/progit/progit2, which has collected a number of
> > fixes (as well as translations) since the 2nd edition was
> > released.
> >
> > Have you considered sending some of your edits there? It sounds
> > like they may be too large to just dump as a big PR, but it might
> > be possible to grow together over time.
>
> Fair question. I had tried doing this for the first edition of Pro
> Git, but the person who was in charge of accepting changes wasn't a
> native speaker of English. As a result I had a hard time convincing
> him that my changes were necessary. Many of my changes were very
> subjective, and not technical, so this was hard to overcome. Things
> might have been different if I were correcting technical errors or
> adding significant sections to the book. But, since I'm not a Git
> expert, that's not what I was attempting to do.
>
> Things have changed for the better for the second edition of Pro
> Git. Its management seems much more willing to accept the kind of
> changes I make, as shown by their reaction to the excellent work by
> Robert Day.

  thank ya, thank ya very much. :-) most of my submissions to that
book have been cosmetic -- punctuation, font changes, clarifications
-- and others are to keep up with changes to git. that said, i
definitely have ideas for more wide-ranging changes if i ever get the
time; i think some section re-ordering could be helpful but that's all
in due time.

  i do what i can.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
