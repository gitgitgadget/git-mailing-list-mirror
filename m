From: Max Horn <max@quendi.de>
Subject: Re: [PATCH v3 2/2] Rename suffixcmp() to has_suffix() and invert its result
Date: Wed, 6 Nov 2013 23:56:15 +0100
Message-ID: <61456C34-834F-4E7B-89D2-9DB45690C9ED@quendi.de>
References: <20131105210237.21525.61810.chriscool@tuxfamily.org> <20131106221735.GB10302@google.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: multipart/signed; boundary="Apple-Mail=_BC51F32B-DDD4-4DFD-B120-4B34A6303EDB"; protocol="application/pgp-signature"; micalg=pgp-sha256
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 06 23:56:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeC1V-00056k-MY
	for gcvg-git-2@plane.gmane.org; Wed, 06 Nov 2013 23:56:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037Ab3KFW40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Nov 2013 17:56:26 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:43929 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751235Ab3KFW4Z (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Nov 2013 17:56:25 -0500
Received: from ip-178-202-253-6.unitymediagroup.de ([178.202.253.6] helo=zanovar.fritz.box); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1VeC1M-0007JF-JD; Wed, 06 Nov 2013 23:56:20 +0100
In-Reply-To: <20131106221735.GB10302@google.com>
X-Mailer: Apple Mail (2.1510)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1383778585;c3871090;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237380>


--Apple-Mail=_BC51F32B-DDD4-4DFD-B120-4B34A6303EDB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


On 06.11.2013, at 23:17, Jonathan Nieder <jrnieder@gmail.com> wrote:

> Hi,
>=20
> Christian Couder wrote:
>=20
>> Now has_suffix() returns 1 when the suffix is present and 0 =
otherwise.
>=20
> Ok.  My only worry is that the function is less discoverable since
> its name is so different from prefixcmp(), which might cause someone
> to invent yet another postfixcmp.

Well, that can always happen, no matter what, can't it?

Though personally I wouldn't mind if there was an has_prefix instead or =
in parallel to prefixcmp.

>=20
>> The old name followed the pattern anything-cmp(), which suggests
>> a general comparison function suitable for e.g. sorting objects.
>> But this was not the case for suffixcmp().
>=20
> It's not clear to me that prefixcmp() is usable for sorting objects,
> either.  Shouldn't it get the same treatment?

Well, unlike suffixcmp, it is transitive, so it could be used for =
sorting. Whether doing that would be sensible is another question, =
though :-).

For clarity, it might indeed be better to also change prefixcmp to =
has_prefix(), and if some code pops up in the future that needs =
something like the current prefixcmp, it can still be added back.


--Apple-Mail=_BC51F32B-DDD4-4DFD-B120-4B34A6303EDB
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iF4EAREIAAYFAlJ6yRQACgkQIpJVslrhe1n5eQD/cJ13xtHHlipAPgjozL7BRSdi
DiJSYdU/rsDJZ/KtYq0A/R+3wN3ADuS5pZEOuWxxM0iQq127dsV5P6CEsg5nkavv
=Jv5x
-----END PGP SIGNATURE-----

--Apple-Mail=_BC51F32B-DDD4-4DFD-B120-4B34A6303EDB--
