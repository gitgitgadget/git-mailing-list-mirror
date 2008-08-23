From: Andi Kleen <andi@firstfloor.org>
Subject: Re: nicer frontend to get rebased tree?
Date: Sat, 23 Aug 2008 18:45:46 +0200
Message-ID: <20080823164546.GX23334@one.firstfloor.org>
References: <20080822174655.GP23334@one.firstfloor.org> <alpine.LFD.1.10.0808221053080.3487@nehalem.linux-foundation.org> <20080822182718.GQ23334@one.firstfloor.org> <alpine.LFD.1.10.0808221233100.3487@nehalem.linux-foundation.org> <20080823071014.GT23334@one.firstfloor.org> <alpine.LFD.1.10.0808230853170.3363@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andi Kleen <andi@firstfloor.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Aug 23 18:45:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWwF3-0008VX-0A
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 18:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbYHWQng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 12:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbYHWQng
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 12:43:36 -0400
Received: from one.firstfloor.org ([213.235.205.2]:46949 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055AbYHWQng (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 12:43:36 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
	id 92BD61AD0020; Sat, 23 Aug 2008 18:45:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0808230853170.3363@nehalem.linux-foundation.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93465>

> Note that the "don't rebase" (as usual) only concerns your published tree. 
> You can certainly rebase non-published stuff.
> 
> As to the "don't base your development on somebody who does" - base your 

That's not practical for me. Maybe it's for you, but it doesn't really
work if you're sufficiently down the food tree. You just have to work
with what other maintainers have and you can't really yell at them
when they do something inconvenient like you do all the time, because
they just ignore you then.

> development either on my tree (I don't rebase) or talk to the d*ck-head 
> that you _want_ to work with, but who rebases.
> 
> > > Remember how I told you that you should never rebase?
> > 
> > I suspect your recommendation does not match real world git use.
> 
> A lot of the trees don't rebase. The rest of the trees may not realize 

That's not my experience, sorry (even on other other trees than linux-next,
linux-next was just an example).  e.g. the original ACPI tree did it,
the x86 tree jungle does it, most of the other architecture trees do it,
the networking tree does it. etc.etc.

Then for linux-next it's reasonable to say that one shouldn't 
do development on top of it, but still if there is supposed
to be a tester base for it it requires at least reasonable
support in git for regular read-only download and right now that
support is at best obscure and unobvious (to avoid stronger words)

> And linux-next has _never_ been appropriate as a development base for 
> other reasons, so forget about linux-next. It's to find merge conflicts 
> and possibly boot/test failures of the trees it contains, not for anything 
> else.

Well it sounds like most people except you get it "wrong". Or maybe
it's more that your intended usage model just does not match what
people really do.

-Andi 
