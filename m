From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] parse-opt: migrate builtin-ls-files.
Date: Sun, 15 Feb 2009 23:07:06 +0100
Message-ID: <20090215220706.GB4371@genesis.frugalware.org>
References: <1234727647-18523-1-git-send-email-vmiklos@frugalware.org> <alpine.DEB.1.00.0902152108370.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RyOXVFQXzAE23HDB"
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 15 23:08:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYpAM-0005pO-Hy
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 23:08:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443AbZBOWHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 17:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752845AbZBOWHL
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 17:07:11 -0500
Received: from virgo.iok.hu ([212.40.97.103]:54708 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752503AbZBOWHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 17:07:09 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id EB22A580AE;
	Sun, 15 Feb 2009 23:07:07 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 647BF446A6;
	Sun, 15 Feb 2009 23:07:06 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 8988211B877C; Sun, 15 Feb 2009 23:07:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0902152108370.10279@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110066>


--RyOXVFQXzAE23HDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 15, 2009 at 09:13:42PM +0100, Johannes Schindelin <Johannes.Sch=
indelin@gmx.de> wrote:
> > > > +   dir->show_ignored =3D !unset;
> > > > +
> > > > +   return 0;
> > > > +}
> > >
> > > Maybe this wants to be converted into an OPTION_BIT compatible data=
=20
> > > type?
> >=20
> > I think that's not possible, as show_ignored is a bitfield.
>=20
> Well, in my juvenile folly I dreamt of turning this into a proper=20
> bitfield...

Uhm, I think I haven't got what you mean. ;-)

Personally I would just remove all problematic bitfields in struct
dir_struct as I think it does not worth using them, but getting rid of
them just because of parseopt sounds insane as well - so I sended up
writing callback functions, as you saw in the patch.

--RyOXVFQXzAE23HDB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmYkgoACgkQe81tAgORUJYa3gCeJn2lQDXAzx0Djs2+6ee87o15
6ecAn1R1e6Tk+A0ywOSGZZWJErk+0+F9
=SKZS
-----END PGP SIGNATURE-----

--RyOXVFQXzAE23HDB--
