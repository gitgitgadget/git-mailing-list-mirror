From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v2 03/15] user-manual: Use 'remote add' to setup push URLs
Date: Sun, 10 Feb 2013 17:19:52 -0500
Message-ID: <20130210221952.GA8377@odin.tremily.us>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
 <44d89e81a8465d3bbf50b106a8a844c9d90ac384.1360508415.git.wking@tremily.us>
 <7v8v6vua50.fsf@alter.siamese.dyndns.org>
 <20130210215442.GB8000@odin.tremily.us> <20130210220848.GB11720@elie.Belkin>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=qMm9M+Fa2AknHoGS
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 23:20:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4fFx-0001ua-Cu
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 23:20:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756840Ab3BJWTy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 17:19:54 -0500
Received: from vms173013pub.verizon.net ([206.46.173.13]:63058 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756603Ab3BJWTx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 17:19:53 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MI00008SZD4HX10@vms173013.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 10 Feb 2013 16:19:53 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 82C80879A5B; Sun,
 10 Feb 2013 17:19:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1360534792; bh=VNgxVkaXy1h47vnOElQKi6M2te0ni4m71PkpSimNmMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R+i7iW2cBfqTagsMqZT03SULsVOrQ3ALZmtbSZaJxGNQW8IZ20FGHJbXHL7ECSxLC
 xwXEkBIMh/uL0kJaASFLiq7eKoY2TTRn/BxSLpVlFkFGtjT8RU/T6R8QX8Gh5ot/ph
 DhBICPbgZd5Q5VgtKQ4UbjaZgKlZr03zy4mJmaGQ=
Content-disposition: inline
In-reply-to: <20130210220848.GB11720@elie.Belkin>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215951>


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 10, 2013 at 02:08:48PM -0800, Jonathan Nieder wrote:
> For everyday interactive configuration editing, config files have some
> good advantages:
>=20
>  - The settings are easy to read, well organized, and all in one place
>  - The file can include comments.

I'm convinced, although the settings are in at least three places
(--system, --global, and --local).  Throwing in the XDG stuff stirs up
the file locations, but it's probably safe to assume (at the moment),
that anyone going that route knows what they're doing ;).  If we just
assume `.git/config` and `~/.gitconfig` we should be pretty safe=E2=80=A6

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRGB0GAAoJEEUbTsx0l5OM1MkP/0USIBj+mT+IWsKaMA1eRtAC
WUtHerqmRwAqOqzo6KfkVYkkx1vmep7KqEwTAGI1fgsktpyONXbi8acXfJ7LyyfI
p96Aqqr0S1gVUuDiLJ3LKespUoDrh1sKRxCNmIQgm+Ef6SKhWx2mwnCrsz1wFELL
XnE3wAQfhWcynyZJh1VPopagEweIb7KMR/HkywI+7mmICS4yGmfVHTNiTfGcGEga
sbaZOwt41feMOI/eR/6y9M4PT4DkeKu+XzLxxud3n4+6usLwj72iGlBX2GzbZAWs
zpgDfpQsNLTkRS5OcqcMYad3zPaShsexM6/vhByCaMN8Rpj0RIKHowoEw7u1Gn5v
VSgPLllUkOSIsbYYhl7a5qD+u8s3VccsJarIMfukHe1r8tcOt3NNaUxyopcu5fYx
1AY1nrqWjzeBG/DoZjsAbcIJN1soyCtDrtRmlBTrtF4mXpIqcgVCxmssiui5GcX8
p5sJhFSXWoUlA7qNMz6OXECzoli4lf72lqXfWJfiORKSRJiCF9GOs3anpV00W/TF
oLmjU3GPRVAUHF/zcT5VPLjncLgsWQxcIzirs5fkBXmRCyaORqGpo7pytbqgVtRd
1D6oFr+RxtENy3ZSfiWa5qtZ5q5k6XlNxkz46uDHo0j8N5+0LDdx+4Y3j93bL3P0
TxM3lDjRD/NwDquSGjSx
=2zfE
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
