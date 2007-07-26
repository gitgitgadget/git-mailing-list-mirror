From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Windows support
Date: Wed, 25 Jul 2007 23:15:46 -0400
Message-ID: <20070726031546.GN32566@spearce.org>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com> <46A73015.7020306@midwinter.com> <a1bbc6950707251956h3db847c9v8db438f4c665b2cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 05:15:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDtpU-0005FJ-GO
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 05:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756073AbXGZDPy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 23:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755772AbXGZDPy
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 23:15:54 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38466 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755832AbXGZDPx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 23:15:53 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IDtpA-0005kQ-Vj; Wed, 25 Jul 2007 23:15:37 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DDE87230807; Wed, 25 Jul 2007 23:15:46 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <a1bbc6950707251956h3db847c9v8db438f4c665b2cf@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53753>

Dmitry Kakurin <dmitry.kakurin@gmail.com> wrote:
> On 7/25/07, Steven Grimm <koreth@midwinter.com> wrote:
> > > How serious are you guys about Windows support?
> > Much (nearly all?) of the core git team never touches Windows, so they
> > both have no selfish motivation to get it working well and no way to
> > test their changes even if they decide to take it up for the greater good.
> 
> This actually answers my question (if it's true).
> If core team is not interested in supporting Windows then I cannot
> trust this system with my source code :-(.

It more or less is.  Those of us that are most active as Git
developers don't really use Windows as our core development platform.
Well, that is not entirely true.  Day-job forces Windows on me,
because its the Most Secure Operating System Evar!.  :-) I run Cygwin
there so I have a sane user interface, and build Git under Cygwin
rather than MSYS because I just expect the UNIX-like environment
that Cygwin gives me.

Why Cygwin?  Because I have to use Windows, but I'd rather use Linux.
No, Linux isn't permitted.  And Solaris/x86 is only allowed on
"servers".  I have yet to find a way to classify my desktop as
a server.  :-|

git-gui is fairly well supported under Cygwin, as I use it a lot
in my day-job.  As do a lot of my coworkers.  Which actually gives
me a pretty good testing ground; ~20 people all beating on git-gui
all day long is a pretty sizable testing group.  I actually wonder
some days if git-gui is better tested on Cygwin than it is on Linux.

But as has been stated on this thread, Cygwin isn't native Windows.
 
> My concerns are (mostly):
> * lack of (or insufficient) testing for Windows platform
> * possibly lower code quality of Windows port, since core devs don't
> touch it and don't care

We do care.  Its just not our primary focus.  Dscho, Junio, Daniel
Barkalow, Johannes Sixt, myself, even Linus have all contributed
patches to git that help make it run better on Windows, or make
it easier to port there.  But none of us are running out and
dedicating our lives to making Git the best software to ever run
on that platform.  There's other things more important to us.

> * possible troubles with support if issues arise
> * Windows port could become abandoned if those few brave people, who
> work on it right now will leave

That's always a concern.  Heck, day-job invested untold fortunes in
a product we purchased from a large commerical vendor.  Runs only on
Windows.  Vendor just up and decided to no longer support the product
anymore and has left us hanging out to dry.  Did I mention that the
product is also closed source and less stable than Git is on Windows?

So no matter what you use, if the developers leave, you are stuck.
But one thing I *really* love about Git is how simple the data
structures are and how easy it is to read the repository.  Its under
500 lines of C code to unpack a working directory.  More if you
want something that's blazing fast and always reliable, but if you
just want to get the data out its quite simple.

Its also fully open source.  GPL'd even.  So there's never the
issue that your vendor runs away and prevents you from taking on
development yourself, or just fixing those minor issues that you
really need to have fixed.
 
-- 
Shawn.
