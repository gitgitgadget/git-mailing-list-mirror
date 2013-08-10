From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/2] submodule: don't print status output with ignore=all
Date: Sat, 10 Aug 2013 16:37:09 +0000
Message-ID: <20130810163709.GD164436@vauxhall.crustytoothpaste.net>
References: <1375550060-5406-1-git-send-email-sandals@crustytoothpaste.net>
 <1375550060-5406-3-git-send-email-sandals@crustytoothpaste.net>
 <20130803182420.GG2893@elie.Belkin>
 <51FE9C49.4020902@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pQhZXvAqiZgbeUkD"
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	judge.packham@gmail.com, iveqy@iveqy.com,
	Jorge-Juan.Garcia-Garcia@ensimag.imag.fr, gitster@pobox.com
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Aug 10 18:37:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8CAe-0000BN-HK
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 18:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966006Ab3HJQhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 12:37:35 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:45769 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965743Ab3HJQhP (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Aug 2013 12:37:15 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 8C35780001;
	Sat, 10 Aug 2013 16:37:14 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <51FE9C49.4020902@web.de>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.10-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232106>


--pQhZXvAqiZgbeUkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 04, 2013 at 08:24:09PM +0200, Jens Lehmann wrote:
> I'm a bit confused. The commit message talks about "git status", but the =
code
> you changed handles "git submodule summary". Looks like you are trying to=
 fix
> the output of status when the status.submodulesummary option is set, righ=
t?
> That's a good thing to do.
>=20
> But your patch also changes the default behavior of "git submodule summar=
y",
> which is a change in behavior as that is currently not configurable via t=
he
> ignore option (and I believe it should stay that way for backward compati=
bility
> reasons unless actual users provide sound reasons to change that). So a N=
ACK
> on this patch from me (and a note to self that tests are missing that sho=
uld
> have failed due to this change).

Right, that wasn't the intent.

> As a short term solution you could honor the submodule.<name>.ignore sett=
ing
> only if --for-status is used, as that is explicitly given by "git status"=
 when
> it forks the "git submodule summary" script (to make it prepend "# " to e=
ach
> line, which it could do easily itself nowadays using recently added code =
;-).

I think I'm going to go this route.  My goal is to fix up the TODO tests
and make them work so I can get more familiar with the code.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--pQhZXvAqiZgbeUkD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCgAGBQJSBmw1AAoJEL9TXYEfUvaL0gIQAJbv+jo+i0NvbEEIpEsFSN0y
OlmunwCvBXeEO2EoW85yW3DQ+UacNi/n9bBSgFS0+iq7Z9oDONJmN6wATx7i3L/i
3miYg/CtsDP/zJ93tFfTLvyzCWboc6WFzW0ClVgh1V9zpazxwJssZ52h5MWIxKa3
WyM7rmub4A/n2ywNaA1OygOV6juVTrlGPST0zrWadf7Gfsf9CIxRFme8ip15VGSx
E5QthoNLqUP5Z81tbdxftdu4mAwUcGMjlRf5Prr+PTgY08S4qoLFTIcdJGM5X7Jf
V2PIsw5CeJYyKlw6r8ovvjcFU7L6pLjIf4gRuosZCUAWEuvGInHLK+pFvwTsF10t
8rHxofmiBxP5z18nZDyVKb178PxfzvCZeCpcuxGgAl813p8iQCDkvi6IikQ6X9GA
Ip19IuoXA9J7tWVWrZaYF5ltggwZyOyypOoni79ug2ZtEGLFgpOoXEO/X0k76GaV
LllL5TtVVRHv17ZCDTrZB6H73s87QeNMXjgQTDO+hB1izBtae6zO9+j6GMIzl+s1
K5wHf0eKChMoyxajQC8leLbfWfjD6icjtUcCyXrwaRhxVR9iBevQZGobshb+66Xz
SuwBJMqq4QmMGyIcXmIhd6HIiKlHnsbzHF2mjbqgqxeaSNjMuQH2QaUSokt9qgQq
7tmPQsLezwzbGAU7XMed
=MqCb
-----END PGP SIGNATURE-----

--pQhZXvAqiZgbeUkD--
