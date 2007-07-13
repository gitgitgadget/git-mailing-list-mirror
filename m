From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: mtimes of working files
Date: Sat, 14 Jul 2007 00:46:54 +0100
Message-ID: <1184370414.2785.79.camel@shinybook.infradead.org>
References: <f36b08ee0707110808h56ecbc7at9c92727c01cca508@mail.gmail.com>
	 <Pine.LNX.4.64.0707111940080.4516@racer.site>
	 <20070711202615.GE3069@efreet.light.src>
	 <200707120857.53090.andyparkins@gmail.com>
	 <1184261246.31598.139.camel@pmac.infradead.org>
	 <20070713003700.GA21304@thunk.org>
	 <1184367619.2785.58.camel@shinybook.infradead.org>
	 <alpine.LFD.0.999.0707131617270.20061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Theodore Tso <tytso@mit.edu>, Andy Parkins <andyparkins@gmail.com>,
	git@vger.kernel.org, Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jul 14 01:49:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9Usq-0000vc-OE
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 01:49:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757179AbXGMXtJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 13 Jul 2007 19:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757248AbXGMXtI
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 19:49:08 -0400
Received: from canuck.infradead.org ([209.217.80.40]:36838 "EHLO
	canuck.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782AbXGMXtH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 19:49:07 -0400
Received: from shinybook.infradead.org ([90.155.92.197])
	by canuck.infradead.org with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1I9Ush-00068M-1Q; Fri, 13 Jul 2007 19:49:03 -0400
In-Reply-To: <alpine.LFD.0.999.0707131617270.20061@woody.linux-foundation.org>
X-Mailer: Evolution 2.10.2 (2.10.2-2.fc7.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52423>

On Fri, 2007-07-13 at 16:18 -0700, Linus Torvalds wrote:
> Why would anybody force you to do that?
>=20
> The "switch between branchs in the same repo" is really convenient.
> But nobody *forces* you to do it.=20

This is true. I already mirror a bunch of CVS and SVN repositories into
git so that I can use them without too much pain=C2=B9, and I can do th=
e same
for git trees which use branches too; mirroring them into a bunch of
separate trees for easy access.

On the occasions I actually try to _use_ branches, I find it very
suboptimal. Perhaps it's just because I'm stupid. I'm sure that's why I
ended up committing changes to the wrong branch. But having to rebuild
(even with ccache) after changing branches is a PITA. Just changing
branches at all is a PITA if you have uncommitted changes (which I
usually do because I've usually tested _some_ random patch in a build
tree for the hardware which is closest to hand). Pulling a whole bunch
of unwanted changes on the 'development' branch while on GPRS, when all
I really needed was a single commit from the 'stable' branch also didn'=
t
amuse me, although I'm sure if I had the time to play with it I'd have
been able to avoid that.

I can, and do, mirror stuff from all kinds of suboptimal version contro=
l
systems into single-branch git trees. And I include multi-branched git
trees in my definition of 'suboptimal'. My ability to do that doesn't
really help the newbies who are expected with branches, though.

I just wish people would make stuff available on the _servers_ in
separate trees rather than in branches -- if some people prefer branche=
s
locally then that's their option; at the moment we kind of force people
into it. They _could_ avoid it but they'd have to know what they're
doing.

But I didn't really mean to start an argument; it's just my opinion.

--=20
dwmw2

=C2=B9 and I'd do the same for Hg if I could get hg2git to work.
