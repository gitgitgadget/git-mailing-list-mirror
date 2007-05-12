From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [BUG?] Detaching head at checked out point does not work.
Date: Sat, 12 May 2007 21:18:33 +0200
Message-ID: <20070512191833.GA8983@efreet.light.src>
References: <20070512172105.GB32764@efreet.light.src> <7v7ird2902.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 12 21:19:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hmx7O-000360-J1
	for gcvg-git@gmane.org; Sat, 12 May 2007 21:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754920AbXELTS6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 15:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755932AbXELTS6
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 15:18:58 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:3341 "EHLO mail.bluetone.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754920AbXELTS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 15:18:57 -0400
Received: from ([85.207.119.145])
	by mail.bluetone.cz with ESMTP with TLS id 5203017.197695;
	Sat, 12 May 2007 21:18:34 +0200
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1Hmx6v-0002XT-Ue; Sat, 12 May 2007 21:18:33 +0200
Content-Disposition: inline
In-Reply-To: <7v7ird2902.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-esp: ESP<0>=
	RBL:<0> 
	SHA:<0> 
	UHA:<0> 
	BAYES:<0> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47074>


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 12, 2007 at 11:26:53 -0700, Junio C Hamano wrote:
> Jan Hudec <bulb@ucw.cz> writes:
>=20
> > Hello,
> >
> > I can correctly detach head by saying:
> >
> >   git checkout master^0
> >
> > (or git checkout master^{} or git checkout refs/heads/master), but NONE=
 of
> > these work, if I currently have master checked out. Shouldn't it detach
> > anyway?
>=20
> Yes, and it does as far as I know.
>=20
> Do you have 3e0318a3?

It does not seem to be in 1.5.1.4, so no, I don't.

I apologise for not looking whether head has a fix.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGRhMJRel1vVwhjGURAizFAJ9JNAOihwB6JBny4iBGOrgG3UxvFwCg67rV
zRIcU3FXnGVjkXhTDZFwGyk=
=Re1v
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
