From: Petr Baudis <pasky@suse.cz>
Subject: Re: Should cg-mkpatch output be usable with cg-patch?
Date: Mon, 25 Jul 2005 00:48:30 +0200
Message-ID: <20050724224830.GG7601@pasky.ji.cz>
References: <20050720234904.B3ED735267C@atlas.denx.de> <20050722210352.GG11916@pasky.ji.cz> <20050724175018.3D721352B73@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 25 00:49:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwpH8-000630-0Z
	for gcvg-git@gmane.org; Mon, 25 Jul 2005 00:48:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbVGXWsg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jul 2005 18:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbVGXWsg
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jul 2005 18:48:36 -0400
Received: from w241.dkm.cz ([62.24.88.241]:55818 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261422AbVGXWsf (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jul 2005 18:48:35 -0400
Received: (qmail 28455 invoked by uid 2001); 24 Jul 2005 22:48:30 -0000
To: Wolfgang Denk <wd@denx.de>
Content-Disposition: inline
In-Reply-To: <20050724175018.3D721352B73@atlas.denx.de>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, Jul 24, 2005 at 07:50:18PM CEST, I got a letter
where Wolfgang Denk <wd@denx.de> told me that...
> In message <20050722210352.GG11916@pasky.ji.cz> you wrote:
> >
> > > I wander what I should do with "cg-mkpatch" generated output;  I  had
> > > the  impression that this should be usable with "cg-patch", but these
> > > are incompatible with each other.
> > 
> > They certainly aren't.
> 
> Is this a problem with the current implementation, or intentional?

Implementation. Should be fixed now, after rewriting part of it. ;-)

> > The message is surely confusing, but appeared to be rather corner-casy
> > and after I imagined the required complexity of filtering this, I
> > decided to spend my time on something more useful for the time being. :)
> 
> I don't think this is a corner case. I think it is  pretty  important
> to be able to promote permissiong changes.

Of course. By the corner case I meant "the external patch tool invoked
by cg-patch emits bogus error in case of patch containing only mode
changes and nothing else". I wasn't aware that the changes wouldn't
apply at all - actually, I was when I was writing the code, but
completely forgot about it later.

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
