Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CB9D1FA21
	for <e@80x24.org>; Sun,  8 Oct 2017 20:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751496AbdJHUmn (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Oct 2017 16:42:43 -0400
Received: from imap.thunk.org ([74.207.234.97]:49750 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751308AbdJHUmm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2017 16:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ACQjQEYlUDZjvYjo5ddFflTuGEmoW+mscj2k6/64GlA=; b=xqOx+SQ/coM1Oaoa/SukvfmwmR
        4JA10J+4AEZ6jhb6tP4sHpRrDAfSR8gwUAY30eK/uOGKlyIJXPFfm8wU2mFyvge7cF7jvYoUwgIiZ
        Oq7SKTTmQJBqDZ7lVYodKjFV2Fib4nV1AVqNVdg0x68zIOlHpJR1QWlFUULBhV3y+wj8=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1e1IP6-0001c7-Co; Sun, 08 Oct 2017 20:42:28 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 612AEC00A52; Sun,  8 Oct 2017 16:42:27 -0400 (EDT)
Date:   Sun, 8 Oct 2017 16:42:27 -0400
From:   Theodore Ts'o <tytso@mit.edu>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Paul Smith <paul@mad-scientist.net>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: "git rm" seems to do recursive removal even without "-r"
Message-ID: <20171008204227.f6wgaobosa6yn62g@thunk.org>
References: <alpine.LFD.2.21.1710071506210.15271@localhost.localdomain>
 <20171007192902.ma4s47hn6edwldx5@sigill.intra.peff.net>
 <alpine.LFD.2.21.1710071531090.15738@localhost.localdomain>
 <20171007193805.a2mwzkweonb6ymdk@sigill.intra.peff.net>
 <alpine.LFD.2.21.1710071541430.15964@localhost.localdomain>
 <1507412674.8322.4.camel@mad-scientist.net>
 <alpine.LFD.2.21.1710071749240.16818@localhost.localdomain>
 <1507473160.8322.12.camel@mad-scientist.net>
 <20171008184046.uj7gcutddli54ic3@thunk.org>
 <alpine.LFD.2.21.1710081536180.28646@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1710081536180.28646@localhost.localdomain>
User-Agent: NeoMutt/20170609 (1.8.3)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 08, 2017 at 03:44:14PM -0400, Robert P. J. Day wrote:
> >
> >     find <find args> | xargs git rm
> >
> > myself.
> 
>   that's what i would have normally used until i learned about git's
> magical globbing capabilities, and i'm going to go back to using it,
> because git's magical globbing capabilities now scare me.

Hmm, I wonder if the reason why git's magically globbing capabilities
even exist at all is for those poor benighted souls on Windows, for
which their shell (and associated utilities) doesn't have advanced
tools like "find" and "xargs"....

				- Ted
