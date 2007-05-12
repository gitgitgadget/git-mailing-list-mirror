From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [BUG?] Detaching head at checked out point does not work.
Date: Sat, 12 May 2007 22:18:15 +0200
Message-ID: <20070512201815.GC8983@efreet.light.src>
References: <20070512172105.GB32764@efreet.light.src> <7v7ird2902.fsf@assigned-by-dhcp.cox.net> <20070512191833.GA8983@efreet.light.src> <7vd515ygw5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2/5bycvrmDh4d1IB"
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 12 22:18:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hmy34-00039k-Ic
	for gcvg-git@gmane.org; Sat, 12 May 2007 22:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754797AbXELUSe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 16:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754998AbXELUSe
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 16:18:34 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:3711 "EHLO mail.bluetone.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754797AbXELUSe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 16:18:34 -0400
Received: from ([85.207.119.145])
	by mail.bluetone.cz with ESMTP with TLS id 5203017.198078;
	Sat, 12 May 2007 22:18:15 +0200
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1Hmy2h-0002hD-8Q; Sat, 12 May 2007 22:18:15 +0200
Content-Disposition: inline
In-Reply-To: <7vd515ygw5.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-esp: ESP<0>=
	RBL:<0> 
	SHA:<0> 
	UHA:<0> 
	BAYES:<0> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47089>


--2/5bycvrmDh4d1IB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 12, 2007 at 12:35:22 -0700, Junio C Hamano wrote:
> Jan Hudec <bulb@ucw.cz> writes:
>=20
> > On Sat, May 12, 2007 at 11:26:53 -0700, Junio C Hamano wrote:
> >> Jan Hudec <bulb@ucw.cz> writes:
> >>
> >> > I can correctly detach head by saying:
> >> >
> >> >   git checkout master^0
> >> >
> >> > (or git checkout master^{} or git checkout refs/heads/master), but N=
ONE of
> >> > these work, if I currently have master checked out. Shouldn't it det=
ach
> >> > anyway?
> >>=20
> >> Yes, and it does as far as I know.
> >>=20
> >> Do you have 3e0318a3?
> >
> > It does not seem to be in 1.5.1.4, so no, I don't.
>=20
> As that commit is directly on top of v1.5.1, I think it may not
> hurt to cherry-pick that single commit to 'maint' for 1.5.1.5,
> although some may argue that it is not strictly a bugfix but a
> new feature.

I would not call it a new feature, since it worked if I had something else
than master checked out. It is not a regression though and given that 1.5.2
is getting closer I'm not sure it's worth bothering.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--2/5bycvrmDh4d1IB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGRiEHRel1vVwhjGURAikCAJ9tcii7g6MSxNuRmb6g+LCn5AMBbQCfbRzh
3+Dcgi7hbijQjdk/OjNxXu4=
=MHZ7
-----END PGP SIGNATURE-----

--2/5bycvrmDh4d1IB--
