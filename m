X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: Joining cg-*-id
Date: Tue, 20 Sep 2005 17:07:19 +0200
Message-ID: <20050920150719.GB1836@pasky.or.cz>
References: <1127166049.26772.26.camel@dv> <20050919215608.GA13845@pasky.or.cz> <Pine.LNX.4.58.0509191505470.2553@g5.osdl.org> <20050919225422.GG18320@pasky.or.cz> <Pine.LNX.4.58.0509191746130.2553@g5.osdl.org> <20050920135735.GC1884@pasky.or.cz> <Pine.LNX.4.58.0509200734440.2553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 20 Sep 2005 15:09:29 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, Pavel Roskin <proski@gnu.org>,
	fonseca@diku.dk, git <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509200734440.2553@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9000>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1EHjiO-0003tw-9b for gcvg-git@gmane.org; Tue, 20 Sep
 2005 17:07:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964822AbVITPHV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 20 Sep 2005
 11:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbVITPHV
 (ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 11:07:21 -0400
Received: from w241.dkm.cz ([62.24.88.241]:34229 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S964822AbVITPHV (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 20 Sep 2005 11:07:21 -0400
Received: (qmail 12371 invoked by uid 2001); 20 Sep 2005 17:07:19 +0200
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Dear diary, on Tue, Sep 20, 2005 at 04:53:11PM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> On Tue, 20 Sep 2005, Petr Baudis wrote:
> > > 
> > > So I'd love to have
> > > 
> > > 	git diff yesterday..
> > > 
> > > but the fact is, there's no sensible semantics for it. _which_ yesterday? 
> > > There might be five different points that are "close to 24 hours ago", 
> > > along five different paths backwards in the history.
> > 
> > A well-defined meaning for this from Cogito standpoint would be "the
> > last commit on our HEAD before the date and all commits committed and
> > merged to the HEAD". In Cogito, you don't merge two branches _together_,
> > you merge one branch _into_ another (represented by the parents order),
> > so this would be sensible.
> 
> No, it's _not_ sensible or well-defined.
> 
> The order of the parents does not matter. It fundamentally _cannot_ 
> matter. I realize that both git and cogito put the "primary parent" first, 
> but that doesn't help one iota - because git is distributed, if the other 
> side merged and we just did a fast-forward, the "primary parent" will be 
> the _other_ side.
> 
> In other words, anybody who thinks that the order of parents is meaningful 
> is in for some nasty shocks. It really _fundamentally_ isn't true. I 
> realize that's hard to accept, but it's a truism in a distributed system. 
> You really cannot have parent ordering and distribution at the same time.

Ok ok. I can now remember already learning about this once, but I forgot
again. I should write it down into some README for myself or so, I
guess. ;-) Sorry about the noise.

I'll just drop the date revision specifier support from Cogito. I don't
know if any measurable number of people actually use it in the real
world anyway.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
