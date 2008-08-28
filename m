From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Wed, 27 Aug 2008 21:25:47 -0400 (EDT)
Message-ID: <alpine.DEB.1.10.0808272117300.1782@gandalf.stny.rr.com>
References: <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vy72kek6y.fsf@gitster.siamese.dyndns.org> <20080826145719.GB5046@coredump.intra.peff.net> <1219764860.4471.13.camel@gaara.bos.redhat.com> <1219766398.7107.87.camel@pmac.infradead.org>
 <alpine.LFD.1.10.0808260959000.3363@nehalem.linux-foundation.org> <20080826180926.GA25711@isilmar.linta.de> <alpine.LFD.1.10.0808261114070.3363@nehalem.linux-foundation.org> <23DFA9EC-9523-4179-BA3C-ACBDB82953DF@cs.indiana.edu>
 <alpine.DEB.1.10.0808271126190.10784@gandalf.stny.rr.com> <20080827230903.GB11005@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Perry Wagle <wagle@cs.indiana.edu>,
	=?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
X-From: git-owner@vger.kernel.org Thu Aug 28 03:26:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYWHn-0001LR-De
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 03:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928AbYH1BZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 21:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752882AbYH1BZu
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 21:25:50 -0400
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.125]:47248 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752845AbYH1BZu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 21:25:50 -0400
Received: from gandalf ([74.74.65.243]) by hrndva-omta04.mail.rr.com
          with ESMTP
          id <20080828012548.CWOK20979.hrndva-omta04.mail.rr.com@gandalf>;
          Thu, 28 Aug 2008 01:25:48 +0000
X-X-Sender: rostedt@gandalf.stny.rr.com
In-Reply-To: <20080827230903.GB11005@flint.arm.linux.org.uk>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94007>


On Thu, 28 Aug 2008, Russell King wrote:

> On Wed, Aug 27, 2008 at 11:27:04AM -0400, Steven Rostedt wrote:
> > 
> > On Tue, 26 Aug 2008, Perry Wagle wrote:
> > > 
> > > I'm trying to upgrade the git that our scripts use, and having the  
> > > users modify their paths doesn't work.
> > > 
> > > Not that horrible to fix some other way, but still a rude thing to  
> > > wake up to one day. (ie, today)
> > > 
> > 
> > Did you see the yellow bulldozer coming at your house while brushing your 
> > teeth?
> 
> That is not a valid point of view when you're a git user, and things
> suddenly change from working one day, to not working the next _and_
> you don't know why the commands you were using have suddenly vanished.
> 
> And there is no documentation seemingly available to tell you what to
> use instead.

I think you may have totally missed my reference to the beginning of
"The Hitchhikers Guide to the Galaxy", where Aurther saw the Bulldozer 
about to destroy his house. As he layed in front of the bulldozer, he was 
told that he had plenty of time to complain. Aurther replied that the 
posting was in some strange hidden location. Kind of like what release 
notes are.

But I digress, this thread is totally offtopic for users@kernel.org, can 
we finally take it off (as I just did).

-- Steve


> 
> And the available documentation tells you that the commands you were
> using are still there.
> 
> And no warnings before hand that the commands you were using were
> deprecated.
> 
> *That* is what is soo abhorrent about this whole business.
> 
> How would you feel if, tomorrow, 'ls', 'tar' etc all gave you "command
> not found", 'man ls' still gave you a man page for ls(1) but the
> command was now actually called 'listfiles' instead ?
> 
> Just put 'alias ls=listfiles' in your .bashrc !
> 
> -- 
> Russell King
>  Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
>  maintainer of:
> 
