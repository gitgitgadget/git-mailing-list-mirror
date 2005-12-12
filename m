From: Petr Baudis <pasky@suse.cz>
Subject: Re: Latest cogito broken with bash-3.1
Date: Mon, 12 Dec 2005 11:40:39 +0100
Message-ID: <20051212104039.GJ10680@pasky.or.cz>
References: <1134220724.15125.4.camel@blade> <20051211001106.GV22159@pasky.or.cz> <1134289867.9541.9.camel@blade> <20051212002631.GW22159@pasky.or.cz> <1134379801.1468.5.camel@blade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 12 11:44:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ell6s-0003uN-IM
	for gcvg-git@gmane.org; Mon, 12 Dec 2005 11:40:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbVLLKkn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 05:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbVLLKkn
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 05:40:43 -0500
Received: from w241.dkm.cz ([62.24.88.241]:27328 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751210AbVLLKkn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Dec 2005 05:40:43 -0500
Received: (qmail 6951 invoked by uid 2001); 12 Dec 2005 11:40:39 +0100
To: Marcel Holtmann <marcel@holtmann.org>
Content-Disposition: inline
In-Reply-To: <1134379801.1468.5.camel@blade>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13517>

  Hi,

Dear diary, on Mon, Dec 12, 2005 at 10:30:01AM CET, I got a letter
where Marcel Holtmann <marcel@holtmann.org> said that...
> > > There exists also another problem with the new bash. It is the broken
> > > pipe error from cg-log.
> > > 
> > > cg-log: line 141: echo: write error: Broken pipe
> > > 
> > > The line number varies depending how much you scrolled and when you
> > > scrolled to the end no broken pipe error comes up. Do you have any idea
> > > on how to deal with this. I saw your comment about that bash is broken
> > > and the extra trap command, but it doesn't help. I never saw that
> > > problem with older versions of bash.
> > 
> >   Then that's quite funny, one-line broken pipe message has been always
> > there (in the past it looked much worse, we thankfully managed to bring
> > it down to this at least).
> 
> I have some machines where I stopped installing the latest bash version
> and they don't have this problem. With bash-2.05b.0 and bash-3.00.16 I
> never (and really mean never) saw this problem.

  this might be some Debian patches then. Indeed, with bash-3.00.16 on
both systems, the line is shown on my home Gentoo system but not on my
Debian machine at work. On RHEL at kernel.org the line is not printed
either. Hmm. So either it's not really bash what emits this (but what
then?) or most of the distributions override that stupid bash behaviour
with a patch already. And Debian didn't foreport the patch to bash-3.1.
Well, this would make the weekend research more interesting, at least.
;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
