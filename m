From: Andi Kleen <andi@firstfloor.org>
Subject: Re: nicer frontend to get rebased tree?
Date: Fri, 22 Aug 2008 20:27:18 +0200
Message-ID: <20080822182718.GQ23334@one.firstfloor.org>
References: <20080822174655.GP23334@one.firstfloor.org> <alpine.LFD.1.10.0808221053080.3487@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andi Kleen <andi@firstfloor.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 20:27:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWbLs-0004Ga-K6
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 20:27:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbYHVSZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 14:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752351AbYHVSZN
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 14:25:13 -0400
Received: from one.firstfloor.org ([213.235.205.2]:38815 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbYHVSZM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 14:25:12 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
	id 15FB718900B8; Fri, 22 Aug 2008 20:27:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0808221053080.3487@nehalem.linux-foundation.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93339>

On Fri, Aug 22, 2008 at 10:55:35AM -0700, Linus Torvalds wrote:
> 
> 
> On Fri, 22 Aug 2008, Andi Kleen wrote:
> > 
> > Especially in Linux kernel land there seem to be quite a few tree
> > which are frequently rebased, which means that the usual "git pull -u"
> > usually leads to conflicts even when one hasn't changed anything
> > at all and just wants the latest state of that tree.
> 
> What drugs are you on?
> 
> "git pull" is not "download". It's "download and merge".

Well it's in pretty much every tutorial.  And none of them
said "you have to figure out first if the person maintaining
the tree ever uses git rebase or not".

I also don't know of any good way to detect this. One has
to just guess and try and error.

> 
> If you just want download, use "git fetch". You should never _ever_ use 
> "git pull -u", and the docs even tell you so.

Well git fetch does nothing by itself.

Yes I know it can be done (which I figured out after a extended
oddysee through git's great documentation), but it's quite complicated 
and definitely nowhere near intuitive.

> And if you _really_ haven't changed anything, then "git pull" will never 
> _ever_ generate a conflict, not with -u, not without, not _ever_. 

Sorry that's what I though initially too. But that's wrong.  Just clone
e.g. linux-next and then try to update it with pull a day later.  

rebase messed this all up majorly.  And people use that unfortunately.

In fact most kernel trees except yours seem to do rebase sooner 
or later. 

-Andi
