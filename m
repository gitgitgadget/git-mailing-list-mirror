From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: nicer frontend to get rebased tree?
Date: Sat, 23 Aug 2008 10:58:55 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808231054400.3363@nehalem.linux-foundation.org>
References: <20080822174655.GP23334@one.firstfloor.org> <alpine.LFD.1.10.0808221053080.3487@nehalem.linux-foundation.org> <20080822182718.GQ23334@one.firstfloor.org> <alpine.LFD.1.10.0808221233100.3487@nehalem.linux-foundation.org> <20080823071014.GT23334@one.firstfloor.org>
 <alpine.LFD.1.10.0808230853170.3363@nehalem.linux-foundation.org> <20080823164546.GX23334@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Sat Aug 23 20:00:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWxPO-0007XJ-Cg
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 20:00:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752998AbYHWR7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 13:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753004AbYHWR7E
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 13:59:04 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42845 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752977AbYHWR7D (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Aug 2008 13:59:03 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7NHwujR010698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 23 Aug 2008 10:58:57 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7NHwtRB026691;
	Sat, 23 Aug 2008 10:58:56 -0700
In-Reply-To: <20080823164546.GX23334@one.firstfloor.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.429 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93468>



On Sat, 23 Aug 2008, Andi Kleen wrote:
> > 
> > A lot of the trees don't rebase. The rest of the trees may not realize 
> 
> That's not my experience, sorry (even on other other trees than linux-next,
> linux-next was just an example).  e.g. the original ACPI tree did it,
> the x86 tree jungle does it, most of the other architecture trees do it,
> the networking tree does it. etc.etc.

So _complain_ to those people. Tell them that they are making your life 
harder. Let them know.

I sure as hell let people know when they are making _my_ life harder. It 
has helped. The networking tree stopped rebasing, and the x86 tree doesn't 
do it for the topic branches (although I think it re-creates the "common" 
branches all the time, kind of like linux-next).

That said, why the hell do you even care? You shouldn't base your work on 
other trees anyway. You should base your work on something as stable as 
possible. IOW, not necessariyl even my "tree-of-the-day", but actually try 
to do as much development based on real releases as possible.

Yeah, sometimes you need to synchronize with other people, but that really 
should be avoided. Not because git doesn't do it well, but because any 
time you have multiple people working in the same area, there is something 
generally WRONG. It's indicative that there is a lack of modularity when 
people step on each others toes too much.

> Then for linux-next it's reasonable to say that one shouldn't 
> do development on top of it, but still if there is supposed
> to be a tester base for it it requires at least reasonable
> support in git for regular read-only download and right now that
> support is at best obscure and unobvious (to avoid stronger words)

Umm. How obscure was it really to do

	git fetch
	git checkout

Hmm?

		Linus
