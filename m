From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 20:19:56 +0100
Message-ID: <20080828191956.GA7906@flint.arm.linux.org.uk>
References: <20080826145719.GB5046@coredump.intra.peff.net> <1219764860.4471.13.camel@gaara.bos.redhat.com> <1219766398.7107.87.camel@pmac.infradead.org> <alpine.LFD.1.10.0808260959000.3363@nehalem.linux-foundation.org> <20080826180926.GA25711@isilmar.linta.de> <alpine.LFD.1.10.0808261114070.3363@nehalem.linux-foundation.org> <23DFA9EC-9523-4179-BA3C-ACBDB82953DF@cs.indiana.edu> <alpine.DEB.1.10.0808271126190.10784@gandalf.stny.rr.com> <20080827230903.GB11005@flint.arm.linux.org.uk> <48B5E90E.3000601@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Kristian =?iso-8859-1?Q?H=F8gsberg?= <krh@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	users@kernel.org, Jeff King <peff@peff.net>,
	Perry Wagle <wagle@cs.indiana.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
X-From: git-owner@vger.kernel.org Thu Aug 28 21:28:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYnAG-0005ML-0C
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 21:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753624AbYH1T1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 15:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753552AbYH1T1M
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 15:27:12 -0400
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34685 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795AbYH1T1L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 15:27:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arm.linux.org.uk; s=caramon; h=Date:From:To:Cc:Subject:
	Message-ID:References:Mime-Version:Content-Type:In-Reply-To:
	Sender; bh=l+8qFKVcN1zMNGN+chqGkeZf2JETA2JPIXbNlRZJHdQ=; b=V9t3h
	K3HQdU/Z3fx/AQRG6s6iT64Ej6u9YStjOBC3tzRm/QFU5AgWMWxRsCzbHcaKAmnV
	8f/xjmUyj9yaYVyQcF4L6q8CmilHGgUKxL432jmcOS1NVJkLRUJvnWtGGvub14MV
	qFe44uMXanNu9aLL49ijusQNLXQPUwbnmeC/vY=
Received: from flint.arm.linux.org.uk ([2002:4e20:1eda:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <rmk@arm.linux.org.uk>)
	id 1KYn2F-0004g8-PZ; Thu, 28 Aug 2008 20:20:00 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.69)
	(envelope-from <rmk@flint.arm.linux.org.uk>)
	id 1KYn2D-0002HA-78; Thu, 28 Aug 2008 20:19:57 +0100
Content-Disposition: inline
In-Reply-To: <48B5E90E.3000601@s5r6.in-berlin.de>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94122>

On Thu, Aug 28, 2008 at 01:53:50AM +0200, Stefan Richter wrote:
> Russell King wrote:
> >And no warnings before hand that the commands you were using were
> >deprecated.
> 
> (a) They weren't deprecated, they were moved into a different directory.

I think Junio will tell you differently on the "deprecation" bit.

> (b) There have been several announcements of the 1.6.0 prereleases and 
> the 1.6.0 release crossposted.  Of course somebody forgot to tell you 
> what you will learn from these release notes.  Unfair.

Cross posting to high traffic mailing lists doesn't guarantee that
it'll be read.  It's the wrong place to do it.

Arguably, though, the lack of information to users on the system affected
is not git maintainers fault.  It's the fault of the admins on that system
not having read the release notes themselves, and warning their users (for
whom git is a *critical* bit of software) that an upgrade is going to take
place, and they should read such-and-such.

Like a note in the system MOTD.

> (c) There do happen unannounced software updates on shell servers over 
> which you don't have control.  Ask for your money back.
> 
> (d) "-" -> " "?  Molehill.

"ls" -> "listfiles" - how would you feel about that change happening
behind your back?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
