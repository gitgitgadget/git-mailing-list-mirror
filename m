From: Petr Baudis <pasky@ucw.cz>
Subject: Re: full kernel history, in patchset format
Date: Mon, 18 Apr 2005 02:50:32 +0200
Message-ID: <20050418005032.GE1461@pasky.ji.cz>
References: <20050416131528.GB19908@elte.hu> <Pine.LNX.4.58.0504160953310.7211@ppc970.osdl.org> <1113780698.11910.8.camel@localhost.localdomain> <20050417233936.GV1461@pasky.ji.cz> <1113782805.11910.36.camel@localhost.localdomain> <20050418003526.GD1461@pasky.ji.cz> <1113785123.11910.43.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 02:47:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNKPg-0002V8-U8
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 02:46:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVDRAup (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 20:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVDRAup
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 20:50:45 -0400
Received: from w241.dkm.cz ([62.24.88.241]:10395 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261359AbVDRAud (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 20:50:33 -0400
Received: (qmail 3267 invoked by uid 2001); 18 Apr 2005 00:50:32 -0000
To: David Woodhouse <dwmw2@infradead.org>
Content-Disposition: inline
In-Reply-To: <1113785123.11910.43.camel@localhost.localdomain>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, Apr 18, 2005 at 02:45:22AM CEST, I got a letter
where David Woodhouse <dwmw2@infradead.org> told me that...
> On Mon, 2005-04-18 at 02:35 +0200, Petr Baudis wrote:
> > > For the special case of removing history before 2.6.12-rc2 from the
> > > trees, I certainly think we can do it by leaving out all the commits,
> > > not just the trees. We can do that easily, but there's no way we can
> > > _add_ that history retrospectively if we omit it in the first place.
> > 
> > I'm confused by this paragraph, but that might be my English skills
> > failing somehow.
> 
> "For the general case of people pruning their own trees, _maybe_ you're
> right that it would be good to keep the commits even if we delete the
> actual trees. But for history older than 2.6.12-rc2, that's a special
> case -- I think we can happily delete the commits too.

Ah _so_. Thanks for explanation.

I think I will make git-pasky's default behaviour (when we get
http-pull, that is) to keep the complete commit history but only trees
you need/want; togglable to both sides.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
