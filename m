From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC PATCH] git-add--interactive: manual hunk editing mode v2
Date: Mon, 9 Jun 2008 00:18:45 +0200
Message-ID: <200806090018.48784.trast@student.ethz.ch>
References: <200805232221.45406.trast@student.ethz.ch> <20080606051026.GA18257@sigill.intra.peff.net> <alpine.DEB.1.00.0806061528270.1783@racer>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5887868.41FtyjAeg7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 09 00:34:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5TSy-0004uk-MQ
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 00:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754788AbYFHWda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 18:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754802AbYFHWda
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 18:33:30 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:22649 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752890AbYFHWd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 18:33:29 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 9 Jun 2008 00:33:28 +0200
Received: from [192.168.0.11] ([77.56.223.244]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 9 Jun 2008 00:33:27 +0200
User-Agent: KMail/1.9.6 (enterprise 20070904.708012)
In-Reply-To: <alpine.DEB.1.00.0806061528270.1783@racer>
X-OriginalArrivalTime: 08 Jun 2008 22:33:27.0891 (UTC) FILETIME=[ABD1CA30:01C8C9B7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84337>

--nextPart5887868.41FtyjAeg7
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Johannes Schindelin wrote:
>=20
> On Fri, 6 Jun 2008, Jeff King wrote:
> >   2. It's not integrated into the git-add--interactive loop at all. That
> >      is, I don't start out saying "I want to edit this diff." I look at
> >      the diff while staging with "git add -p" and say "Oops, I need to
> >      edit this hunk." So I think it is better implemented as an "e"
> >      option in the hunk adding loop, with "git add -e" as a shortcut.
> >      Or maybe there is simply room for both (and "git add -e", rather
> >      than being a shortcut, just means "do this on the _whole_ file").
>=20
> This is very much on purpose.  I do not like "git add -i" at all.  It=20
> limits my work unduly.  That's why I tried to change the hunk editing in=
=20
> git-gui once upon a time, but I never got round to fix that, and it does=
=20
> not work well with ssh either.
>=20
> So no, I do not want to use that perl script with that menu.  I want to=20
> have the raw diff in a raw editor, where I can change the things I need t=
o=20
> change.

While there is obviously little point in trying to convince you, let
me briefly explain why I still think it is useful:

I usually run 'add -p' instead of adding specific files.  "Nodding
off" each hunk means that I get a last chance to review my changes,
and perhaps skip some of them (possibly for a later commit).  With my
proposed editing feature, I can split hunks in the middle too.  You
could of course argue that the right way to do this would be staring
at 'git diff', or perhaps scrolling through the entire patch in your
'add -e'.  I just got used to doing the reviews during 'add -p'.  As
Jeff said, by the time I decide to change a hunk, I might already be
halfway through the decisions and _definitely_ don't want to bail out
and restart with 'add -e'.

That, and my Maple worksheets have a tendency to show up when I didn't
want to commit them, so I can just say 'd' there.

=2D Thomas

=2D-=20
Thomas Rast
trast@student.ethz.ch


--nextPart5887868.41FtyjAeg7
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)

iD8DBQBITFrIqUud07tmzP0RAocCAJ47mYPRvDSR8pK2KpVMWzs9B3zEaQCeP5gX
l0+dVmH1jN5NeWcEaBS46nQ=
=j/+F
-----END PGP SIGNATURE-----

--nextPart5887868.41FtyjAeg7--
