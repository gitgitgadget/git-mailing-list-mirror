From: "Boyd Stephen Smith Jr." <bss03@volumehost.net>
Subject: Re: [PATCH] guilt: add option guilt.diffstat
Date: Sat, 13 Dec 2008 00:18:50 -0600
Message-ID: <200812130018.56061.bss03@volumehost.net>
References: <20081213021422.GA28249@localhost> <20081213044357.GD15407@josefsipek.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart26156997.290zRAtrA8";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Wu Fengguang <fengguang.wu@intel.com>, git@vger.kernel.org
To: Josef Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Sat Dec 13 07:20:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBNrD-0005wX-6F
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 07:20:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755133AbYLMGSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 01:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbYLMGSs
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 01:18:48 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:44127 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745AbYLMGSr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 01:18:47 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20081213061845.WALX8485.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sat, 13 Dec 2008 01:18:45 -0500
Received: from [10.0.0.123] ([72.204.50.125])
	by fed1rmimpo01.cox.net with bizsmtp
	id qWJl1a00G2i4SyG03WJm31; Sat, 13 Dec 2008 01:18:46 -0500
X-Authority-Analysis: v=1.0 c=1 a=1metSixEPA0A:10 a=p-oTUCxTtpUA:10
 a=nEQGfrJnAAAA:8 a=gHxHgVAZIrvJZtd9MZkA:9 a=Q4vf12VJ9YT8r24a4CZCN2YMz5oA:4
 a=B7iFY6Z7H_gA:10 a=LY0hPdMaydYA:10 a=eEOe38istZ0ie_ZyWH8A:9
 a=caGbF00bMtzjT3JKLX7CXwG_c-0A:4 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
User-Agent: KMail/1.9.9
In-Reply-To: <20081213044357.GD15407@josefsipek.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102989>

--nextPart26156997.290zRAtrA8
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 2008 December 12 22:43:57 Josef Jeff Sipek wrote:
>> +		if [ -n "$5" -o "x$diffstat" =3D "x1" ]; then
>
>Why the 'x' thing? I've seen it is some scripts before, but I can't think =
of
>a reason to use it if the variable is surrounded in quotation marks.

'[' or test see the arguments after they are unquoted (normally).  So,=20
if "$diffstat" is "-n" it might try and do the -n test, rather than the =3D=
=20
test.

It could be re-written as "1" =3D=3D "${diffstat}" instead to avoid the x, =
but=20
it's not a big deal (to me).  That also looks backwards to a lot of people.
=2D-=20
Boyd Stephen Smith Jr. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ,=3D ,-_-. =
=3D.=20
bss03@volumehost.net =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((_/)o o(\_=
))
ICQ: 514984 YM/AIM: DaTwinkDaddy =A0 =A0 =A0 =A0 =A0 `-'(. .)`-'=20
http://iguanasuicide.org/ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\_/ =
=A0 =A0=20

--nextPart26156997.290zRAtrA8
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklDU9AACgkQdNbfk+86fC2hmQCfY5nJ/qe5l8Y8TmuT6HBVJts3
q0sAn3c/oBtQw47hIYGJSHUQ1rLFxj0l
=a+2k
-----END PGP SIGNATURE-----

--nextPart26156997.290zRAtrA8--
