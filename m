From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [REGRESSION] git-gui
Date: Thu, 3 Apr 2008 21:27:23 -0400
Message-ID: <20080404012723.GL10274@spearce.org>
References: <007901c89590$a827f7c0$93a7c10a@LGE.NET> <57518fd10804030700r6de977f5p6f0418e6eaea2583@mail.gmail.com> <200804032304.17054.barra_cuda@katamail.com> <57518fd10804031615m5c299df6hf31de3c689e16521@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michele Ballabio <barra_cuda@katamail.com>, git@vger.kernel.org,
	=?utf-8?B?QW5kcsOp?= Goddard Rosa <andre_rosa@lge.com>
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Fri Apr 04 03:28:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jhaj0-0005Wn-6Z
	for gcvg-git-2@gmane.org; Fri, 04 Apr 2008 03:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754832AbYDDB1a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Apr 2008 21:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752831AbYDDB1a
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 21:27:30 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35605 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084AbYDDB13 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Apr 2008 21:27:29 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Jhai3-0006wh-7d; Thu, 03 Apr 2008 21:27:15 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6E10C20FBAE; Thu,  3 Apr 2008 21:27:24 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <57518fd10804031615m5c299df6hf31de3c689e16521@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78790>

Jonathan del Strother <maillist@steelskies.com> wrote:
> On Thu, Apr 3, 2008 at 10:04 PM, Michele Ballabio
> <barra_cuda@katamail.com> wrote:
> > On Thursday 03 April 2008, Jonathan del Strother wrote:
> >  > On Thu, Apr 3, 2008 at 2:43 PM, Andr=C3=A9 Goddard Rosa <andre_r=
osa@lge.com> wrote:
> >  > >
> >  > >  # git gui
> >  > >  Error in startup script: bad event type or keysym "["
> >  > >     while executing
> >  > >  "bind $ui_comm <$M1B-Key-\[> {show_less_context;break}"
> >  >
> >  > Doh, I broke git :(

You and me both Jonathan.  I tested it on both Mac OS X and Win32,
and on Tcl/Tk 8.4.1, 8.4.10, 8.4.15, and 8.5.0.  Never ran into
this failure.  So the original poster must be running 8.4.0, and
8.4.0 must not support this binding.  Added in 8.4.1?  *sigh*

> >  These changes should help (haven't tried):
> >         \[ -> bracketleft
> >         \] -> bracketright
> >  but some European keyboards do not have easy access to brackets, s=
o
> >  other keys would be preferable (comma and period, for example, or =
1 and 2).
>=20
> Anyone else got any opinions on an appropriate shortcut?  How about
> '=3D' and '-' (+ and - without the shift), or are those not necessari=
ly
> together either?  (Are there really layouts where '[' and ']' aren't
> next to each other?)

I don't know, [ and ] seem reasonable to me.  Git is mostly a source
code control system.  A lot of languages use [ and ] as part of
their syntax.  If you are typing on a keyboard that is difficult to
access these keys on, you are probably already used to contorting
your fingers.  :-|

I wrote up a patch today based on Michele's suggested change.
It works everywhere I can test, but I don't have an 8.4.0
installation like the original poster.

Unless someone posts a patch to change the keys away from [ and ]
I say leave them as-is.  But I'm willing to entertain a change if
someone who cares writes a patch for it.

--=20
Shawn.
