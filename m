From: Max Horn <max@quendi.de>
Subject: Re: [PATCH 03/16] pull: cleanup documentation
Date: Thu, 31 Oct 2013 20:27:19 +0100
Message-ID: <ADB546B4-992E-4B54-953E-B721BECD19B2@quendi.de>
References: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com> <1383211547-9145-4-git-send-email-felipe.contreras@gmail.com> <xmqqiowd71kv.fsf@gitster.dls.corp.google.com> <CAMP44s3AKnZUJy0O0Hg+G=ER2bRn1nHMBeoJQ=ugCzO4d2WZ-g@mail.gmail.com> <xmqqob655kqi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: multipart/signed; boundary="Apple-Mail=_16008E5E-2A07-4AD6-A91D-8F01308F0AEF"; protocol="application/pgp-signature"; micalg=pgp-sha256
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 20:27:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbxu1-00042J-J9
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 20:27:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752265Ab3JaT13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 15:27:29 -0400
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:38931 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751852Ab3JaT12 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Oct 2013 15:27:28 -0400
Received: from fb07-alg-gast1.math.uni-giessen.de ([134.176.24.161]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1Vbxtr-0007L0-Jp; Thu, 31 Oct 2013 20:27:23 +0100
In-Reply-To: <xmqqob655kqi.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1510)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1383247648;d403fd62;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237162>


--Apple-Mail=_16008E5E-2A07-4AD6-A91D-8F01308F0AEF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


On 31.10.2013, at 20:00, Junio C Hamano <gitster@pobox.com> wrote:

> Felipe Contreras <felipe.contreras@gmail.com> writes:

[...]

>=20
>>=20
>> If you want to be pedantic, this is the "reality":
>>=20
>>  ------------
>>      D---E---F---G master
>>  ------------
>=20
> You are wrong again.  The "reality" is more like this:
>=20
>      origin/master in your repository
>      |
>      v
>      A---B---C master at origin
>     /
>    D---E---F---G master in your repository
>=20
> if you really want to write origin/master somewhere in this
> illustration.

Actually, I kind of like that. After just reading the existing phrasing =
in git-pull.txt, I doubt that a newbie would catch the difference =
between "origin/master" and "master at origin". With this illustration, =
it's very clearly conveyed that there is a difference.


--Apple-Mail=_16008E5E-2A07-4AD6-A91D-8F01308F0AEF
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iF4EAREIAAYFAlJyrxsACgkQIpJVslrhe1mzwAEAkCIS6OFr70WV5GPgxNXThCdq
dl//ZckAPBft73O/uXgA/0k+aK4op+9uU6/d5GOopTGpHBg1FxQ8UV/O9xpO6mbO
=t8vy
-----END PGP SIGNATURE-----

--Apple-Mail=_16008E5E-2A07-4AD6-A91D-8F01308F0AEF--
