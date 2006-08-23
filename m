From: Tilman Sauerbeck <tilman@code-monkey.de>
Subject: Re: [PATCH] Added support for dropping privileges to git-daemon.
Date: Wed, 23 Aug 2006 18:45:18 +0200
Message-ID: <20060823164517.GA1066@code-monkey.de>
References: <7vhd05s2b5.fsf@assigned-by-dhcp.cox.net> <1156268432.16120@hammerfest> <7virkkl4ph.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
X-From: git-owner@vger.kernel.org Wed Aug 23 18:46:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFvr3-0002y5-Nt
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 18:45:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965056AbWHWQpW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Aug 2006 12:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965057AbWHWQpW
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Aug 2006 12:45:22 -0400
Received: from code-monkey.de ([81.169.170.126]:25359 "EHLO code-monkey.de")
	by vger.kernel.org with ESMTP id S965056AbWHWQpV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Aug 2006 12:45:21 -0400
Received: from hammerfest (c-180-198-68.bi.dial.de.ignite.net [62.180.198.68])
	by code-monkey.de (Postfix) with ESMTP id 2657CB428
	for <git@vger.kernel.org>; Wed, 23 Aug 2006 18:45:18 +0200 (CEST)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7virkkl4ph.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25921>


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Junio C Hamano [2006-08-22 16:40]:
> Tilman Sauerbeck <tilman@code-monkey.de> writes:
>=20
> > +	These two options may be used to make `git-daemon` change its uid and
> > +	gid	before entering the server loop.
> > +	The uid that's used is the one of 'user'. If `group` is specified,
> > +	the gid is set to the one of 'group', otherwise, the default gid
> > +	of 'user' is used.
>=20
> Funny whitespaces all over the place...

There's exactly _one_ stray \t in the middle of a line. Not quite what
I'd call "all over the place' ;)
I should probably tell vim to hilight space errors in txt files, too.

> Gaah again.  These options do not have any effect (other than
> sanity checking) on the inetd_mode codepath, so instead of
> saying this in the documentation I would suggest specifying
> these options an error under --inetd.

Good point.

Regards,
Tilman

--=20
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing on usenet and in e-mail?

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE7IYd27uLisrW2w8RAnuRAJ9QAPUeZN73a0wPfFsPuojWVTbMbACfesMj
8IiFo9Ymbwh8r5Ulvsob2N0=
=ezCn
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
