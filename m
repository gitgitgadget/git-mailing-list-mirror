From: Evan Driscoll <driscoll@cs.wisc.edu>
Subject: Re: Splitting up a repository
Date: Sat, 04 Dec 2010 00:19:10 -0600
Message-ID: <4CF9DD5E.7020400@cs.wisc.edu>
References: <4CF9D15D.7090001@cs.wisc.edu> <20101204053304.GA7311@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig14B4B8AFB12AB0F980F7DFF3"
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 04 07:28:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POlc1-0000A5-Tj
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 07:28:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734Ab0LDGTn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Dec 2010 01:19:43 -0500
Received: from sabe.cs.wisc.edu ([128.105.6.20]:34655 "EHLO sabe.cs.wisc.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752457Ab0LDGTn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Dec 2010 01:19:43 -0500
Received: from [192.168.0.2] (h216-165-158-75.mdtnwi.dsl.dynamic.tds.net [216.165.158.75])
	(authenticated bits=0)
	by sabe.cs.wisc.edu (8.14.1/8.14.1) with ESMTP id oB46JZue018567
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 4 Dec 2010 00:19:35 -0600
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <20101204053304.GA7311@sigill.intra.peff.net>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162885>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig14B4B8AFB12AB0F980F7DFF3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/3/2010 23:33, Jeff King wrote:
>> Is there a better way than making several (recursive) copies of the
>> repository, deleting all but one directory in each copy, then moving t=
he
>> contents of that directory up a level? (And perhaps setting up a Git
>> superproject at the original location. I do know about that.)
>=20
> Rewrite the history of each directory with git-filter-branch. It even
> has a "--subdirectory-filter" option that will do exactly what you want=
=2E

Great, thanks. I had to mess around with a submodule that was inside one
of the subdirectories that didn't make it through the history rewrite,
and I could see that have getting slightly hairy, but at least in my
case it was pretty simple. Other than that, worked like a charm.

Evan


--------------enig14B4B8AFB12AB0F980F7DFF3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEVAwUBTPndXgOzoR8eZTzgAQI1egf+JCKoJm6Bc9UKGABaEbGw22BroiAKTEM9
BViZz9luw66vOsQhfA24ElvaOW2PMTIKuGlh3RGNO+Kijt01qN55yF9g56GLS4S+
q8KFrwdhZmXKJ5qfbo0v2NqKp4VZGAmk1pzMgBII4wUQ1QS9zCxT0lXfZKdrHb9J
welCmyPdCGF2iXENszQlJ/IouE+jH2ZuTJBiD4wKzmrLhmDriN5+s6Q5EAcbqLPn
ICwFoGfQoPKc9L2D4Ipv62yJsf1DHei7K60pSQW0ZEED4/STgFeCWtsAjqrBNGQV
txCvRgGuxTUSbIL/HWZtWGgwtQ+ePzVu9HxXjGNwX5Tob540caCENA==
=EVoX
-----END PGP SIGNATURE-----

--------------enig14B4B8AFB12AB0F980F7DFF3--
