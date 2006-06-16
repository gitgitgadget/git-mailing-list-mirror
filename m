From: Petr Baudis <pasky@suse.cz>
Subject: Re: Autoconf/Automake
Date: Fri, 16 Jun 2006 22:42:44 +0200
Message-ID: <20060616204244.GH2609@pasky.or.cz>
References: <1150324030.23268.12.camel@dv> <20060615072450.GF7766@nowhere.earth> <20060615133146.GA5794@steel.home> <20060615201000.600939E2BC@derisoft.derived-software.demon.co.uk> <Pine.LNX.4.63.0606152239270.7480@wbgn013.biozentrum.uni-wuerzburg.de> <20060615220534.GL7766@nowhere.earth> <Pine.LNX.4.63.0606160053560.7480@wbgn013.biozentrum.uni-wuerzburg.de> <20060616201715.GM7766@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phil Richards <news@derived-software.ltd.uk>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 16 22:42:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrL93-0000BZ-Fb
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 22:42:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbWFPUlr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 16:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbWFPUlr
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 16:41:47 -0400
Received: from w241.dkm.cz ([62.24.88.241]:51434 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751454AbWFPUlr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jun 2006 16:41:47 -0400
Received: (qmail 25790 invoked by uid 2001); 16 Jun 2006 22:42:44 +0200
To: Yann Dirson <ydirson@altern.org>
Content-Disposition: inline
In-Reply-To: <20060616201715.GM7766@nowhere.earth>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21969>

Dear diary, on Fri, Jun 16, 2006 at 10:17:15PM CEST, I got a letter
where Yann Dirson <ydirson@altern.org> said that...
> On Fri, Jun 16, 2006 at 12:58:30AM +0200, Johannes Schindelin wrote:
> > > On Thu, Jun 15, 2006 at 10:42:40PM +0200, Johannes Schindelin wrote:
> > > > As for now, I fail to see why the current system is not adequate for git!
> > > 
> > > I can reassure you, gazillions of people still fail to see why cvs is
> > > not adequate for their project.  And the ratio of devs in the
> > > corporate world not knowning git to those not knowning cvs is far
> > > superior to 2.  And everyone here knows cvs is not more adequate than
> > > git for so many tasks :)
> > 
> > You know as well as I that this comparison is unfair. I am _NOT_ a 
> > corporate person. I hope that you do not judge me as a complete airhead.
> 
> Well, I have to apologize - especially after looking closer at the
> current Makefile.  I think I understand now why autoconf was suggested
> in the first place, but it what it would achieve would mostly moving
> the ifdef's to configure.ac, which would not be such a gain anyway.

Except that then I don't need to bother manually adding NO_EXPAT to the
makefile on all systems I compile git on.

Yes, it's not a huge bother per se, but since almost all other
non-obscure projects do figure these things out automagically, git kind
of stands out negatively here. "Wah, it needs me tweak the Makefile to
be able to compile it."

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
