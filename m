From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 00:09:03 +0100
Message-ID: <20080827230903.GB11005@flint.arm.linux.org.uk>
References: <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vy72kek6y.fsf@gitster.siamese.dyndns.org> <20080826145719.GB5046@coredump.intra.peff.net> <1219764860.4471.13.camel@gaara.bos.redhat.com> <1219766398.7107.87.camel@pmac.infradead.org> <alpine.LFD.1.10.0808260959000.3363@nehalem.linux-foundation.org> <20080826180926.GA25711@isilmar.linta.de> <alpine.LFD.1.10.0808261114070.3363@nehalem.linux-foundation.org> <23DFA9EC-9523-4179-BA3C-ACBDB82953DF@cs.indiana.edu> <alpine.DEB.1.10.0808271126190.10784@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Perry Wagle <wagle@cs.indiana.edu>,
	Kristian =?iso-8859-1?Q?H=F8gsberg?= <krh@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	users@kernel.org, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 01:12:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYUBQ-0001fV-F8
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 01:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754045AbYH0XLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 19:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754030AbYH0XLH
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 19:11:07 -0400
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42265 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754041AbYH0XLG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 19:11:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arm.linux.org.uk; s=caramon; h=Date:From:To:Cc:Subject:
	Message-ID:References:Mime-Version:Content-Type:In-Reply-To:
	Sender; bh=hbvGgWAh3BK9tYWbwOtaCejL25INv4l5AjXkCm9lOnI=; b=WptA9
	y2HHGdyOb6J0qajvfOA2TShnJ+/JZJfqPV7RB2ekTDb9SDJDj+UBpG0P9XPK1/6g
	pOQPuMV8j2eIcdPgeJwY8W0tNRmF3HZCjIypv8Q6cLa34ptiYuwSZyMqt6YSAlTW
	TviRdk7fialJC6EK66TxDl8+3/GwSKnKX/3HOs=
Received: from flint.arm.linux.org.uk ([2002:4e20:1eda:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <rmk@arm.linux.org.uk>)
	id 1KYU8Q-0003cn-Q9; Thu, 28 Aug 2008 00:09:07 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.69)
	(envelope-from <rmk@flint.arm.linux.org.uk>)
	id 1KYU8O-0004JY-A6; Thu, 28 Aug 2008 00:09:04 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0808271126190.10784@gandalf.stny.rr.com>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93978>

On Wed, Aug 27, 2008 at 11:27:04AM -0400, Steven Rostedt wrote:
> 
> On Tue, 26 Aug 2008, Perry Wagle wrote:
> > 
> > I'm trying to upgrade the git that our scripts use, and having the  
> > users modify their paths doesn't work.
> > 
> > Not that horrible to fix some other way, but still a rude thing to  
> > wake up to one day. (ie, today)
> > 
> 
> Did you see the yellow bulldozer coming at your house while brushing your 
> teeth?

That is not a valid point of view when you're a git user, and things
suddenly change from working one day, to not working the next _and_
you don't know why the commands you were using have suddenly vanished.

And there is no documentation seemingly available to tell you what to
use instead.

And the available documentation tells you that the commands you were
using are still there.

And no warnings before hand that the commands you were using were
deprecated.

*That* is what is soo abhorrent about this whole business.

How would you feel if, tomorrow, 'ls', 'tar' etc all gave you "command
not found", 'man ls' still gave you a man page for ls(1) but the
command was now actually called 'listfiles' instead ?

Just put 'alias ls=listfiles' in your .bashrc !

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
