From: Brett Schwarz <brett_schwarz@yahoo.com>
Subject: Re: [ANNOUNCE] ugit: a pyqt-based git gui // was: Re: If you would write git from scratch now, what would you change?
Date: Wed, 12 Dec 2007 12:20:13 -0800 (PST)
Message-ID: <427778.4653.qm@web38908.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David <davvid@gmail.com>, Marco Costalba <mcostalba@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Jason Sewall <jasonsewall@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 21:28:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2YBX-00040E-Q9
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 21:28:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368AbXLLU04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 15:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758755AbXLLU0z
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 15:26:55 -0500
Received: from web38908.mail.mud.yahoo.com ([209.191.125.114]:31871 "HELO
	web38908.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758652AbXLLU0x (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Dec 2007 15:26:53 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Dec 2007 15:26:53 EST
Received: (qmail 5801 invoked by uid 60001); 12 Dec 2007 20:20:13 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Message-ID;
  b=FpabxAbBsOMrXP77x8R7vBlz6K0ESrqldlI0qyKu03RdUY0fxFGEMeSYZ2mvnKH+t+6YuNZFWqZ+mCzlJOYYMjMvwLCtiFCgRST68NPWfT1+JW+Tqxrd+xPYAthVEWnk50vXzleBWuF7xhIOANvM2wKUzSsFO079vPyr30BIDUc=;
X-YMail-OSG: 01g_BhIVM1kLsMHGPTcR3wauDqmCMw.oanjEVNrjEsgOOc2rByLTKBOu.9Pt73hx1g--
Received: from [128.251.102.188] by web38908.mail.mud.yahoo.com via HTTP; Wed, 12 Dec 2007 12:20:13 PST
X-Mailer: YahooMailRC/818.31 YahooMailWebService/0.7.158.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68099>

Not to belabor the point, but just some comments, since this seems
to come up often enough...

> Jason Sewall <jasonsewall@gmail.com> wrote:
> > I don't know much about graphical toolkits and the like, but I think
> > that the more modern ones have fancy features like antialiasing and
> > subpixel rendering, which makes a big difference when you're working
> > on a laptop with a tiny screen.
>
> Oh, that's a good point.  On my Mac OS X system with the aqua port
> of Tk the fonts render just as good as anything else on this box.
> I guess the Aqua port of Tk is just better than the X11 port of
> Tk is.  :)
>

Yes, it is a known issue that Tk on unix still has the "old look"
out of the box. Some of this is just due to how the defaults
for some of the options are shipped. The default options for 8.5
have changed, so it is a little better, but Tile is really better.

The same with fonts. Anti-aliased fonts for unix have not been
supported, but in 8.5 they are.

8.5 is due out by the end of this week I believe.

> > The qt stuff fits better with the rest of my system better too (even
> > though I'm using gnome) - it's entirely the result of Tk being
> > lightweight and a million years old, when UI conventions were
> > different (like every menu being detachable, and antique scrollbars).
> > I'm not here to start a toolkit flame war (we had a toolkit dogpile on
> > the list last week, I think) I'm just pointing out that Tk is from a
> > different era.
>
> Yes.  The tile extension in 8.5 should actually improve this quite
> a bit; as I understand it there is a GTK backend for Tk with that
> set of extensions, making the UI look more modern on X11, assuming
> GTK was available when Tk was compiled, etc...
>

Tile will ship with 8.5, but it is also an extension that can be used
with 8.4.

Here's some screenshots to give you an example of Tk with Tile with
Qt theme (add-on theme).

http://personal1.iddeo.es/andresgarci/getleft/english/snaps.html

http://sk1project.org/modules.php?name=Products&product=sk1
(scroll down towards bottom)

and generic Tile screenshots:
http://tktable.sourceforge.net/tile/screenshots/unix.html


> I have yet to make git-gui use the tile extension.  Its however
> planned to happen in the near-ish future.
>
> > I use git-gui and gitk for my git graphical needs because they rock
> > and at the end of the day, the fonts and antialiasing aren't that big
> > of a deal, especially since I'm usually doing quick scans and searches
> > over the information those tools display, not reading novels in them.
>
> Good points.  Features win over pretty most of the time.  But at
> some point pretty is important; especially to new user adoption.
> Plus if you are looking at it all day long it shouldn't be jarring
> to the eyes.  But git-gui still isn't even where I want it ot
> be feature-wise.  E.g. I'd *love* to teach it inotify support,
> so you don't even need to have that Rescan button.

I have not used it, but this may help in regards to the
inotify stuff: 

    http://wiki.tcl.tk/3643

Cheers,
    --brett





      ____________________________________________________________________________________
Be a better friend, newshound, and 
know-it-all with Yahoo! Mobile.  Try it now.  http://mobile.yahoo.com/;_ylt=Ahu06i62sR8HDtDypao8Wcj9tAcJ 
