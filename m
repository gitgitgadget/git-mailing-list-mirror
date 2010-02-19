From: Jelmer Vernooij <jelmer@samba.org>
Subject: Storing (hidden) per-commit metadata
Date: Fri, 19 Feb 2010 18:11:25 +0100
Message-ID: <1266599485.29753.54.camel@ganieda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-4Eh5q+m6DS6hMYDxeFs7"
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 20 13:58:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiouD-0003BD-3z
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 13:57:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755028Ab0BTM5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 07:57:43 -0500
Received: from gwenhwyvar.vernstok.nl ([92.243.4.181]:40894 "EHLO
	gwenhwyvar.vernstok.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753474Ab0BTM5m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 07:57:42 -0500
Received: from ganieda (localhost [127.0.0.1])
	by gwenhwyvar.vernstok.nl (Postfix) with ESMTP id 4B78A2663F;
	Sat, 20 Feb 2010 12:58:57 +0000 (UTC)
Received: by ganieda (Postfix, from userid 1000)
	id 77C8B5ED1D; Fri, 19 Feb 2010 18:11:26 +0100 (CET)
X-Mailer: Evolution 2.28.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140527>


--=-4Eh5q+m6DS6hMYDxeFs7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

To allow round-tripping pushes from Bazaar into Git, I'm looking for a
good place to store Bazaar semantics that can not be represented in Git
at the moment. This data should ideally be hidden from the user as much
as possible; it would e.g. contain mappings from git hashes to Bazaar
ids.=20

One option would be to store it (as hg-git does) at the bottom of each
git commit message. However, given the amount of data and the its kind,
it would be annoying to have it displayed by e.g. "git show" or "git
log".

Some people have suggested I use the new git notes to store this
metadata, but I haven't quite figured out how to add notes that aren't
displayed by git log/show and are still propagated along with the
revision. Is that at all possible using notes, and are they the right
thing to use here?

There also doesn't appear to be any documentation on notes in
Documentation/technical at the moment. I'm happy to contribute some if
somebody can provide pointers.

Cheers,

Jelmer

--=-4Eh5q+m6DS6hMYDxeFs7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABAgAGBQJLfsYzAAoJEACAbyvXKaRXAR8P/juj+V4JZI0TlMUvSwfN5xgc
FsDTytvuHq76G3Pl6njS1/nb5XZoVpDWMaJYw5FgBM3T4njN7Jdpwmo7d9bmYGB3
kGms9lmGfq9DuxI3lgQQoAPsYrzHcT5mdnRiIFQLAI5amN/83vIpqF9cIMHHEHRT
uGtLe0B/x9A84SimAXwPjo1zr0+5E4yOLOneAaiDaJo5NvE/Ys4VJLNg+RoNm17Z
/TtkrvA8sd2Et6xC3v8gXQ71+1HsouLajSE+X2qNLjrK17aTXY6bwnpIpXXnmsnz
bC8HC2mHbKZJlsYGDWjrEqCIaxuzXw4vXzN5dF0tGbyD/BXQQNKoyuFvAUdKz1R1
rBD/Byw6UfGAHP+Gyl8dLvOXFkMkFL4eqbHtxfRH3l1OQVvRDkULC8luBeMq/Ip4
M6pRxkQzJfisPZS+OWdT1tVawi/v0HpawSCtqicKdG7Gw4L94KE60G6mh3M1WKGS
TEdiCnH1RB7Slf/mRZZZIh5OgbVolLXi7BiGkxuvS+3NSioLi67l3bmKKvQk9JNB
KgbjbpIdBOykIoOPxoD+skI7qO2bnMnnbSaMRYCWb5XkLeeCCWi8IygJaMJpK6D3
knrDeTWXerEidb5ToelLbiunlemhw07o/kRutPcVC8M2x7syBn5iW7JdL11Ak/pP
ESYKjDLJ8EBTvLLK2xYE
=KwYL
-----END PGP SIGNATURE-----

--=-4Eh5q+m6DS6hMYDxeFs7--
