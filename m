From: Petr Baudis <pasky@suse.cz>
Subject: Re: git pull for update of netdev fails.
Date: Wed, 20 Sep 2006 18:18:25 +0200
Message-ID: <20060920161825.GR8259@pasky.or.cz>
References: <20060920080308.673a1e93@localhost.localdomain> <Pine.LNX.4.64.0609200816400.4388@g5.osdl.org> <20060920155431.GO8259@pasky.or.cz> <7vhcz2jzfd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Hemminger <shemminger@osdl.org>,
	Jeff Garzik <jgarzik@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Sep 20 18:19:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ4mM-0003CV-Ik
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 18:18:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731AbWITQS2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 12:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbWITQS1
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 12:18:27 -0400
Received: from w241.dkm.cz ([62.24.88.241]:44161 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751730AbWITQS1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 12:18:27 -0400
Received: (qmail 4625 invoked by uid 2001); 20 Sep 2006 18:18:25 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vhcz2jzfd.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27363>

Dear diary, on Wed, Sep 20, 2006 at 06:05:58PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > Dear diary, on Wed, Sep 20, 2006 at 05:28:08PM CEST, I got a letter
> > where Linus Torvalds <torvalds@osdl.org> said that...
> >> However, you can tell git that Jeff is being difficult by marking such 
> >> branches individually as being rebased.
> >
> > This is really a wrong way of describing the problem - I'd say that Git
> > is being difficult here. The point is, the subsystem maintainers need to
> > maintain stacks of patches and rebase against the main kernel branch
> > regularily, and they want to still publish their current state. So it's
> > not really any of them being strange or difficult, but Git being so
> > because it has no seamless support for tracking those branches.
> 
> Seamless support is there and Linus described how without
> breaking the usual "if not fast forward you may lose some
> patches so be extra careful" safety valve.

  I argue that this safety valve is useless for most people (and
actually I have hard time imagining a plausible scenario in which it
actually _is_ useful). The support is not really seamless since you have
to make manual changes to refspecs, while most people probably don't
understand them (and shouldn't be required to if they are just tracking
someone else anyway).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
