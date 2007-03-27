From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: Submodule object store
Date: Tue, 27 Mar 2007 21:42:33 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070327194233.GA28229@informatik.uni-freiburg.de>
References: <20070326220302.GH22773@admingilde.org> <7vfy7rvct2.fsf@assigned-by-dhcp.cox.net> <20070326231637.GJ22773@admingilde.org> <7vy7ljtwir.fsf@assigned-by-dhcp.cox.net> <20070326233603.GL22773@admingilde.org> <20070327112549.GA12178@informatik.uni-freiburg.de> <20070327115029.GC12178@informatik.uni-freiburg.de> <20070327155306.GQ22773@admingilde.org> <20070327172216.GA24200@informatik.uni-freiburg.de> <Pine.LNX.4.64.0703271124590.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Waitz <tali@admingilde.org>,
	Junio C Hamano <junkio@cox.net>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Eric Lesh <eclesh@ucla.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Mar 27 21:43:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWHZP-00025k-20
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 21:43:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbXC0Tmp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 27 Mar 2007 15:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934204AbXC0Tmp
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 15:42:45 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:51022 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932359AbXC0Tmn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Mar 2007 15:42:43 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1HWHZ0-0005y0-6w; Tue, 27 Mar 2007 21:42:38 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l2RJgY7j028859;
	Tue, 27 Mar 2007 21:42:35 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l2RJgXbX028858;
	Tue, 27 Mar 2007 21:42:33 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Martin Waitz <tali@admingilde.org>, Junio C Hamano <junkio@cox.net>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Eric Lesh <eclesh@ucla.edu>, Matthieu Moy <Matthieu.Moy@imag.fr>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703271124590.6730@woody.linux-foundation.org>
User-Agent: Mutt/1.5.14+cvs20070315 (2007-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43298>

Hello Linus,

Linus Torvalds wrote:
> On Tue, 27 Mar 2007, Uwe Kleine-K=F6nig wrote:
> >=20
> > 	embeddedproject$ git ls-tree HEAD | grep linux
> > 	040000 commit 0123456789abcde0... linux-2.6
> >=20
> > (or how ever you save submodules).  Then you might have to duplicat=
e the
> > objects of linux-2.6, because they are part of both histories.
>=20
> No they are not. Unless you do it wrong.
>=20
> The *only* object that is part of the superproject would be the tree =
that=20
> *contains* that entry itself.
Yes, I got that.  I think my concern is still valid, so probably I was
just unable to phrase it explicitly.  So I retry:

In the state above (i.e. linux-2.6 being a commit) the
superproject's odb doesn't necessarily needs the object
0123456789abcde0, right.  But the commit before that had linux-2.6 bein=
g
a tree.  And in that state linux-2.6/Makefile has to be in the
superproject's odb.  So if you choose the save the objects of submodule=
s
in a different odb, linux-2.6/Makefile has to be in both of them.
=20
I agree with the things you said afterwards, but they don't match the
issue I wanted to point out.

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D2004+in+roman+numerals
