From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [ANNOUNCE] git-pasky-0.6.2 && heads-up on upcoming changes
Date: Thu, 21 Apr 2005 08:49:31 +0200
Message-ID: <20050421064931.GA31910@pasky.ji.cz>
References: <20050420205633.GC19112@pasky.ji.cz> <20050420211919.GA20129@kroah.com> <20050420215117.GJ19112@pasky.ji.cz> <Pine.LNX.4.58.0504201503050.6467@ppc970.osdl.org> <20050420222815.GM19112@pasky.ji.cz> <Pine.LNX.4.58.0504201710500.2344@ppc970.osdl.org> <Pine.LNX.4.58.0504201809170.2344@ppc970.osdl.org> <20050421033526.GA9404@nevyn.them.org> <Pine.LNX.4.58.0504202056310.2344@ppc970.osdl.org> <20050421042833.GA10934@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 08:46:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOVRo-0002BV-6u
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 08:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVDUGuB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 02:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVDUGuA
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 02:50:00 -0400
Received: from w241.dkm.cz ([62.24.88.241]:55527 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261238AbVDUGtd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 02:49:33 -0400
Received: (qmail 3285 invoked by uid 2001); 21 Apr 2005 06:49:32 -0000
To: Daniel Jacobowitz <dan@debian.org>
Content-Disposition: inline
In-Reply-To: <20050421042833.GA10934@nevyn.them.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Apr 21, 2005 at 06:28:34AM CEST, I got a letter
where Daniel Jacobowitz <dan@debian.org> told me that...
> On Wed, Apr 20, 2005 at 09:00:44PM -0700, Linus Torvalds wrote:
> > 
> > 
> > On Wed, 20 Apr 2005, Daniel Jacobowitz wrote:
> > > 
> > > My logic: it's a lot more intuitive to say "cg-log | less" to get
> > > paginated output than it is to say "cg-log | cat" to get unpaginated
> > > output.
> > 
> > I disagree.
> > 
> > There is _never_ any valid situation where you do "cg-log" with 
> > unpaginated output to a tty.
> > 
> > In _any_ real system you'll be getting thousands of lines of output. 
> > Possibly millions. unpaginated? What the hell are you talking about?
> 
> OK, so I'm crazy.  I must have hallucinated doing this sort of thing on
> a regular basis... :-) Examples: terminals with good scrollback,
> screen, script.  Small repositories.  Irritation at less's habit of
> using the alternate xterm buffer, whatever the technical term for that
> is.

... Plan9. But I guess you won't even have a pager there. ;-)

A little off-topic, anyone knows how to turn off that damn alternate
screen thing on the xterm level? (Or any other level which makes _all_
programs not to use it.)

More seriously, I think Linus' patch is fine; the usage in scripts is
not affected, and alternatives were suggested. When we have cg-admin, I
might even let you set per-repository git-specific PAGER (which you
could set to be even some fancy script which would parse the stuff, open
a cute window and display stuff graphically, or whatever).

Linus, ahem, could you please sign off your patch? :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
