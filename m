From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [RFC] git-send-email: Cache generated message-ids, use them when
 prompting
Date: Sun, 18 Aug 2013 22:24:00 +0000
Message-ID: <20130818222359.GF64402@vauxhall.crustytoothpaste.net>
References: <1376701126-5759-1-git-send-email-rv@rasmusvillemoes.dk>
 <7vvc32n1vz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z0mFw3+mXTC5ycVe"
Cc: Rasmus Villemoes <rv@rasmusvillemoes.dk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 19 00:24:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBBOl-0008Mu-Ek
	for gcvg-git-2@plane.gmane.org; Mon, 19 Aug 2013 00:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755398Ab3HRWYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 18:24:09 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:59725 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755151Ab3HRWYI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Aug 2013 18:24:08 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 7CA4D28073;
	Sun, 18 Aug 2013 22:24:05 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vvc32n1vz.fsf@alter.siamese.dyndns.org>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-rc4-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232522>


--Z0mFw3+mXTC5ycVe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 18, 2013 at 02:08:00PM -0700, Junio C Hamano wrote:
> Rasmus Villemoes <rv@rasmusvillemoes.dk> writes:
> > +# Return an array of cached message-ids, ordered by "relevance". It
> > +# might make sense to take the Subject of the new mail as an extra
> > +# argument and do some kind of fuzzy matching against the old
> > +# subjects, but for now "more relevant" simply means "newer".
> > +sub msgid_cache_getmatches {
> > +	my ($maxentries) =3D @_;
> > +	$maxentries //=3D 10;
>=20
> The //=3D operator is mentioned in perl581delta.pod, it seems, and
> none of our Perl scripted Porcelains seems to use it yet.  Is it
> safe to assume that everybody has it?

This operator is new in Perl 5.10.  If you want the code to work on
RHEL/CentOS 5, you need to avoid it, since they only have 5.8 available.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--Z0mFw3+mXTC5ycVe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCgAGBQJSEUl/AAoJEL9TXYEfUvaLW6sP/20xH7/jS4/kre0zEXBQT2PX
zQUSq6oNLXF3nb68N4KCVfIgJESQq09juHD5ZyO3Wk7WXUlp7UqMeIE5d4ngveqI
HMlQNbVAxDbWTeweg5fmTbXi6ZVP6mHciAxJZcVsPY0ulbQxfLuOlBKOmBhLLD6x
36YgzWJgmleKjGwENL4IejtHofriNJ0eZXINc2enKvO/QW25oCrU9o91shUouGtY
UACQqETjYdovUb27HIDeHJKqT2fbN2kFArfpgYDfosq0oG7cbNoIwluGqbQXobu4
NHni/89fOmXavFWn+GL9zbZqDEsqDSJYf9yp/mhaiSg54ABx9E4sLpLCkxXqBO9j
i7sM1t2TqOgVbNWfRARoiSHS91FUpOoFHFOlnwCckkIp0K4RynwweH8QKYVLPuOp
7uMSuTgnm6/pgQGYFYA25RRbBnT5DfxEn6XDGkHCASsjS4RI7jvzp+LGFeSb6+4B
RavyeBeCF6YzYCTXPAQchS45rFPnEPsonwwAC+dRPPHnpc456UpU8G5jOL7DW9Hw
U9xf3BLINHP3IPxAcFw7PFdjXRynTNadc37NXdthtnaqYD4Mo+7Iub14l8rZNf7h
eIAraMzNxqY0l47DzXj72okFXKa/s68gwTH2mkVKoWDyStznVxdbXYEzpJFVU6vA
AR336BYnXRbmUlfwyWZe
=XyHB
-----END PGP SIGNATURE-----

--Z0mFw3+mXTC5ycVe--
