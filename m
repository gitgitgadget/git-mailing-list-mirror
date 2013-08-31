From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 3/4] get rid of "git submodule summary --for-status"
Date: Sat, 31 Aug 2013 17:08:30 +0000
Message-ID: <20130831160759.GB899703@vauxhall.crustytoothpaste.net>
References: <1377781536-31955-1-git-send-email-Matthieu.Moy@imag.fr>
 <1377781536-31955-4-git-send-email-Matthieu.Moy@imag.fr>
 <521FA6ED.9010005@web.de>
 <vpqioyonqdn.fsf@anie.imag.fr>
 <5220F539.9050700@web.de>
 <5220F7D7.2000300@web.de>
 <5220FBD5.6020807@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="32u276st3Jlj2kUU"
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	gitster@pobox.com
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Aug 31 19:09:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFofb-0007VR-5w
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 19:09:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753901Ab3HaRIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 13:08:37 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:60006 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753286Ab3HaRIg (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Aug 2013 13:08:36 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id ECDA328072;
	Sat, 31 Aug 2013 17:08:33 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <5220FBD5.6020807@web.de>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-rc4-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233523>


--32u276st3Jlj2kUU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2013 at 10:08:53PM +0200, Jens Lehmann wrote:
> Am 30.08.2013 21:51, schrieb Jens Lehmann:
> > Am 30.08.2013 21:40, schrieb Jens Lehmann:
> >> Am 29.08.2013 23:23, schrieb Matthieu Moy:
> >>> Jens Lehmann <Jens.Lehmann@web.de> writes:
> >>>
> >>>> Am 29.08.2013 15:05, schrieb Matthieu Moy:
> >>> Because of the missing quotes around $for_status, it seems the test is
> >>> unconditionnaly true:
> >>>
> >>> $ test -n t ; echo $?
> >>> 0
> >>> $ test -n   ; echo $?
> >>> 0
>=20
> Right you are, I did not notice the missing "" in my review. Looks like
> we also should add one or more tests making sure that submodule summary
> and status never honor the ignore settings.

How do we want to handle this?  I can send a reroll and include some
new tests, but if this code is going away, then there's no point.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--32u276st3Jlj2kUU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCgAGBQJSIiMMAAoJEL9TXYEfUvaLXAIP/2G0WK668plV6CO0LxaaVyJX
/nLAwyHSyNa9gWJMoFbHv0AUD2Y7cU5MOcdFoWjNyYNkekBzlKSancZCRWAoug8H
T4vkVQJErSybihqi/4odpseEqvDIk+1sSiYoMylbdIwOF0TBwyUs4ZaMd0utGgP4
7th0qRiyOvzz2KftX08RegDZo/vGyvmkh195qgYcHnWnfYex+En99XLzZeAfneBF
OUQZiiB/e1RaUiv3jkxfeyeIO+Nde/QL+2SyZ3jCt4UxlM1qHnb6b3vUGxvCTayR
FCkjyXH51m5FnYwntRFzaHK19l+5pkIh+LsLss0qA6S2hR7GGUTKt6O5TeTfwASr
QOuT2MKY5abEymdTIL+AQ419yoXULzK+FZ9U58X0FWRQ8fd4NphuP6SQQ3vtxFY9
MK0n0s6ljG5OwUr/Xte+LC+hydXhvv9geFd/cQJueGiUGg/Ig1oKZ7qXs9M/WTZU
8Ykw2cE/MIXA/GZv9D1hRQcZReWkBkksl7xqi+VOWVEp98eXdZtsBe6j/8iGcOWG
V7p6WAUoJ6umB2GPRaHrNSacD3RvsitVHvdV7A0u5+ib4sZFK0yWtkRdxIXOZFR3
ttETa40whTcMraM2+NS3pEgSoQL6I1wGWHZ285ZT24oM6b1hl+jJFoKPQZlZtN5H
6N6BPjeH4TeIGofm5pmJ
=B+JC
-----END PGP SIGNATURE-----

--32u276st3Jlj2kUU--
