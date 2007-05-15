From: Jan Hudec <bulb@ucw.cz>
Subject: Re: testing vger handling of charsets (part 1)
Date: Tue, 15 May 2007 20:12:07 +0200
Message-ID: <20070515181207.GC3653@efreet.light.src>
References: <20070515test.1@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HG+GLK89HZ1zG0kk"
Cc: git@vger.kernel.org, kha@treskal.com, bfields@fieldses.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 15 20:12:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ho1Vq-0002RZ-FL
	for gcvg-git@gmane.org; Tue, 15 May 2007 20:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758391AbXEOSMZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 14:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757540AbXEOSMZ
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 14:12:25 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:37327 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756704AbXEOSMY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 14:12:24 -0400
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 0B9C5573C1;
	Tue, 15 May 2007 20:12:22 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1Ho1VH-0001XT-RC; Tue, 15 May 2007 20:12:07 +0200
Content-Disposition: inline
In-Reply-To: <20070515test.1@coredump.intra.peff.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47360>


--HG+GLK89HZ1zG0kk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 15, 2007 at 03:12:05 -0400, Jeff King wrote:
> This is a test message to check how vger reacts to seeing 8bit
> characters (like Hasselstr=C3=B6m) in a message without the right mime
> header. Previous attempts were eaten by the list because of a lack of a
> message id.
>=20
> If your mail server doesn't advertise the 8BITMIME extensions, I expect
> this message to be corrupted to iso8859-1 during the smtp conversation
> between vger and your server, because it lacks a mime version header.

To me it arrived via vger only, including the =C3=B6, with
Content-Type: text/plain; charset=3Dutf-8

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--HG+GLK89HZ1zG0kk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGSff3Rel1vVwhjGURAr6DAJ4sSDkrJ1QXOh6s2RuDqcIkTiYbXQCgyRxd
BPgJ+XQ5QSJRDst9hiK1ZHY=
=h18S
-----END PGP SIGNATURE-----

--HG+GLK89HZ1zG0kk--
