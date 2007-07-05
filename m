From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [PATCH] stash: end commit log with a newline
Date: Thu, 5 Jul 2007 13:58:25 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070705115825.GA13654@informatik.uni-freiburg.de>
References: <200707042324.l64NOp8I019289@mi0.bluebottle.com> <7vbqere732.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 05 13:58:38 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6Pyn-0005bR-O5
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 13:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760450AbXGEL6d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 5 Jul 2007 07:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760277AbXGEL6d
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 07:58:33 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:47057 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759392AbXGEL6c (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jul 2007 07:58:32 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1I6Pyh-0000lP-8y; Thu, 05 Jul 2007 13:58:31 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l65BwQWF013862;
	Thu, 5 Jul 2007 13:58:26 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l65BwPgl013861;
	Thu, 5 Jul 2007 13:58:25 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7vbqere732.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51670>

Junio C Hamano wrote:
> =E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93 <nana=
ko3@bluebottle.com> writes:
>=20
> > I am sorry to join the discussion late, but I think it is much bett=
er to let
> > the user give a short reminder message from the command line.  For =
example,
> >
> >   $ git stash add customized message to stash
> >
> > When I say "git stash list", I want to see which branch I was on wh=
en I was
> > in the middle of doing something, and what that something was.  It =
is not
> > interesting which commit on that branch I started that change from.=
  After
> > creating a stash without a message, and then another stash with a m=
essage, I
> > want to see:
> >
> >   $ git stash list
> >   stash@{0}: On master: add customized message to stash
> >   stash@{1}: WIP on master: 36e5e70... Start deprecating "git-comma=
nd" in favor of "git command"
>=20
> Hmph.  I only recently got interested in "stash", so have not
> enough real-life experience to base my judgement on, but I think
> I'd agree with your reasoning.
>=20
> Perhaps something like this?
I didn't test it yet, but it sounds good.  I will apply your patch and
work a while with it.  But I think if someone adds documentation, I wil=
l
give my Ack. :-)

BTW: I prefer help over usage, but if it nanako prefers usage, why not
both?

Best regards
Uwe

--=20
Uwe Kleine-K=C3=B6nig

http://www.google.com/search?q=3D1+stone%3D
