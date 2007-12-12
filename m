From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [ANNOUNCE] ugit: a pyqt-based git gui // was: Re: If you would write git from scratch now, what would you change?
Date: Wed, 12 Dec 2007 00:23:29 -0500
Message-ID: <20071212052329.GR14735@spearce.org>
References: <402731c90712110548k67f28b64w5afa93ee908ce73b@mail.gmail.com> <e5bfff550712111020k51829c03n5d64a94ce7c7ac2a@mail.gmail.com> <31e9dd080712111114t2bbdba60m18b7d6210f3f9174@mail.gmail.com> <e5bfff550712111133j66c4b9adx9f57661cc720aa41@mail.gmail.com> <402731c90712111254q1cb99c6al47538971d93b4592@mail.gmail.com> <31e9dd080712111329j2c8b22ebs38ab727a5fbe85fb@mail.gmail.com> <20071212041002.GN14735@spearce.org> <31e9dd080712112113u44b30c62ja012951fba958c5d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David <davvid@gmail.com>, Marco Costalba <mcostalba@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Jason Sewall <jasonsewall@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 06:24:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2K50-0006RA-25
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 06:24:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497AbXLLFXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 00:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752496AbXLLFXe
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 00:23:34 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:43947 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbXLLFXd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 00:23:33 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1J2K4B-0007Za-Ka; Wed, 12 Dec 2007 00:23:31 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B691F20FBAE; Wed, 12 Dec 2007 00:23:29 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <31e9dd080712112113u44b30c62ja012951fba958c5d@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67994>

Jason Sewall <jasonsewall@gmail.com> wrote:
> I don't know much about graphical toolkits and the like, but I think
> that the more modern ones have fancy features like antialiasing and
> subpixel rendering, which makes a big difference when you're working
> on a laptop with a tiny screen.

Oh, that's a good point.  On my Mac OS X system with the aqua port
of Tk the fonts render just as good as anything else on this box.
I guess the Aqua port of Tk is just better than the X11 port of
Tk is.  :)
 
> Take a look for yourself:
> http://img441.imageshack.us/img441/492/comparejd6.png
> 
> They are obviously using different fonts there (because I can't figure
> out what font ugit is using) but there is a difference in rendering
> quality to be sure.

Be nice to know what ugit is using, or really how its guessing the
default font.  I wonder what font you are using with your git-gui.
The default Tk picks on X11 is basically crap, but git-gui goes
with your system default as its own default.
 
> The qt stuff fits better with the rest of my system better too (even
> though I'm using gnome) - it's entirely the result of Tk being
> lightweight and a million years old, when UI conventions were
> different (like every menu being detachable, and antique scrollbars).
> I'm not here to start a toolkit flame war (we had a toolkit dogpile on
> the list last week, I think) I'm just pointing out that Tk is from a
> different era.

Yes.  The tile extension in 8.5 should actually improve this quite
a bit; as I understand it there is a GTK backend for Tk with that
set of extensions, making the UI look more modern on X11, assuming
GTK was available when Tk was compiled, etc...

I have yet to make git-gui use the tile extension.  Its however
planned to happen in the near-ish future.
 
> I use git-gui and gitk for my git graphical needs because they rock
> and at the end of the day, the fonts and antialiasing aren't that big
> of a deal, especially since I'm usually doing quick scans and searches
> over the information those tools display, not reading novels in them.

Good points.  Features win over pretty most of the time.  But at
some point pretty is important; especially to new user adoption.
Plus if you are looking at it all day long it shouldn't be jarring
to the eyes.  But git-gui still isn't even where I want it ot
be feature-wise.  E.g. I'd *love* to teach it inotify support,
so you don't even need to have that Rescan button.

-- 
Shawn.
