From: Pirate Praveen <praveen@debian.org>
Subject: Re: support git+mosh for unreliable connections
Date: Wed, 15 Apr 2015 20:13:51 +0530
Message-ID: <552E7927.5030803@debian.org>
References: <552E628C.7040809@debian.org> <20bd52de595018f49eeeea64128e3a77@www.dscho.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jnBtgEj2kMkK0JOtw8NIhgXvFmwUHp9LQ"
Cc: git@vger.kernel.org, git-owner@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 15 17:16:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiP3h-00014h-I8
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 17:16:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751729AbbDOPQx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 11:16:53 -0400
Received: from perdizione.investici.org ([94.23.50.208]:39444 "EHLO
	perdizione.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054AbbDOPQv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 11:16:51 -0400
X-Greylist: delayed 1959 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Apr 2015 11:16:51 EDT
Received: from [94.23.50.208] (perdizione [94.23.50.208]) (Authenticated sender: praveen@autistici.org) by localhost (Postfix) with ESMTPSA id 3E799121BD5;
	Wed, 15 Apr 2015 14:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=debian.org;
	s=stigmate; t=1429109050;
	bh=3CbOZS4pHo/nAkD4SwZlBW5HCCUxLO92OriIbQyZnvk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=dF7PjLo77LzdPJgFx1fma7lBKK7RX2ok4q+A/Yx2iFQ8DuvyGHoKdkjb+b2Gk0n0G
	 DE+MOG+SnKr36TAj5PEGq9nUCLbVtYGvRzLtodTkZQ8zGmpMAZ2kJBJLm5QNS1GANX
	 ctY6ysAu0ZY44K+r7k8ZOIDZjUCnp+VbvgMx6b1s=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <20bd52de595018f49eeeea64128e3a77@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267205>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jnBtgEj2kMkK0JOtw8NIhgXvFmwUHp9LQ
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On Wednesday 15 April 2015 07:52 PM, Johannes Schindelin wrote:
> From https://github.com/keithw/mosh:
>=20
>> Mosh does not support X forwarding or the non-interactive uses of SSH,=
 including port forwarding.
>=20
> In particular it "does not support [...] the non-interactive uses of SS=
H", which the git+mosh transport would require, though.
>=20
> That means that you would have to invest quite a bit of effort into enh=
ancing mosh to *support* the non-interactive uses of SSH before you could=
 start implementing `git-remote-mosh`...
>=20
> Ciao,
> Johannes
>=20

Q: Are the mosh principles relevant to other network applications?

    We think so. The design principles that Mosh stands for are
conservative: warning the user if the state being displayed is out of
date, serializing and checkpointing all transactions so that if there
are no warnings, the user knows every prior transaction has succeeded,
and handling expected events (like roaming from one WiFi network to
another) gracefully.

Can the ideas be used to resume a pull, push or clone operation?
Especially serializing and checkpointing.


--jnBtgEj2kMkK0JOtw8NIhgXvFmwUHp9LQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCAAGBQJVLnknAAoJEM4fnGdFEsIqyh4QAKWglk3A5xNRoQKknoEIcKxd
wB6asGv/B84s13/1wbOsqAH8YJIf4KmsIwYPQLbo835a2CxWax4XEYtdtt7j9UqK
Eo9WPg+HwY6SO52cfSYDXIPcHtmaIGZXlPQYJspAOBedbY2y7YEc3525EjPZZRV2
Z9MU1PSVTnZ6588wrsVGLnCUOWvxXUlrdYY8p1x24fw4QX1Xtxw565GMrZXLMICK
b9U90gI+Otvg/VZmqU+cphmbaBnJzE3Lr448Rt+h3ZxyyHXCqjMWvsbg18PVu+Hb
TzDNdoex40tHCZ59B9oINWFO4WlKWQ5cODCKz9gyU/DRlyF4vmreYI1+zL7fK1ln
HPAsQ7D92IokpM90A07GX6yCqGfUe1c/zD517SlinfgVzAFU2MTBh0g1NHtj/kRM
fJ6K3dfOzJJtWtvZG3KhYX3JBSxT4JL/NLng35XU20T8X3iLBHQAm214SEqfhwhv
i05FrxktjToKS7zAZyQHkq7whDi6EMqgLAHQDY/wilafdTgzaZY2zeSXo+LH6icM
5giYhSqWgH+s/dK9TWePBJyxkDay62Uqk30wxRYFmR50nHMfwpLjcqXQUiM3fqe8
+HLFyHN7wP5a4V21ixnkqy+n/aqvHLApJb5eLpsPfLY93x7eEEAoipfSaEfogpf+
iguSfbEtkhQvdFgVnJ6c
=AxLE
-----END PGP SIGNATURE-----

--jnBtgEj2kMkK0JOtw8NIhgXvFmwUHp9LQ--
