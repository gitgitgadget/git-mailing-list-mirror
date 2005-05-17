From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Darcs-git: a few notes for Git hackers
Date: Tue, 17 May 2005 22:21:50 +0200
Message-ID: <20050517202150.GG7136@pasky.ji.cz>
References: <20050515114847.GD13024@pasky.ji.cz> <Pine.LNX.4.44.0505151204230.2136-100000@bellevue.puremagic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 22:25:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DY8ZB-0000LR-NV
	for gcvg-git@gmane.org; Tue, 17 May 2005 22:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVEQUV5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 May 2005 16:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbVEQUV5
	(ORCPT <rfc822;git-outgoing>); Tue, 17 May 2005 16:21:57 -0400
Received: from w241.dkm.cz ([62.24.88.241]:22755 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261724AbVEQUVz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2005 16:21:55 -0400
Received: (qmail 19866 invoked by uid 2001); 17 May 2005 20:21:50 -0000
To: Brad Roberts <braddr@puremagic.com>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0505151204230.2136-100000@bellevue.puremagic.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, May 15, 2005 at 09:06:27PM CEST, I got a letter
where Brad Roberts <braddr@puremagic.com> told me that...
> > > 2) Should the index changing areas be constructing a new index instead of
> > > shuffling bits within the current index?
> >
> > When I have a big cache (the only time it matters), I do usually only
> > relatively small changes to it, so...
> 
> The entire index is bit shuffled around even if nothing changed.  At least
> today, size and amount changed doesn't matter.

At the very least, it probably shouldn't get shuffled around if there
are no changes whatsoever.

> > I'd imagine the plan of attack to continue by changing active_cache to
> > be struct cache, then making it local.
> 
> Which is what the rest of that patch does.

Well, the important word there was "then". :-) I think the patch is too
big, do you think it would be possible to separate it to those two
stages? (I could do it on my own when I get enough time, but who knows
when that happens... ;-)

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
