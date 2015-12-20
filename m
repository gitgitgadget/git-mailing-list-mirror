From: David Hirsch <dhirsch@me.com>
Subject: Possible bug in "git mv"
Date: Sat, 19 Dec 2015 16:34:29 -0800
Message-ID: <E9114719-0012-4C70-BC02-EF0DAF196C5B@me.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: multipart/signed;
 boundary="Apple-Mail=_605E40FE-DC90-491C-AF44-2CA48293782C";
 protocol="application/pgp-signature"; micalg=pgp-sha512
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 20 02:34:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAStV-0003Ie-5A
	for gcvg-git-2@plane.gmane.org; Sun, 20 Dec 2015 02:34:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854AbbLTBef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2015 20:34:35 -0500
Received: from st11p01im-asmtp001.me.com ([17.172.204.151]:38483 "EHLO
	st11p01im-asmtp001.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbbLTBee (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2015 20:34:34 -0500
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Dec 2015 20:34:34 EST
Received: from [192.168.89.101]
 (c-50-135-139-169.hsd1.wa.comcast.net [50.135.139.169])
 by st11p01im-asmtp001.me.com
 (Oracle Communications Messaging Server 7.0.5.36.0 64bit (built Sep  8 2015))
 with ESMTPSA id <0NZM0133NS9I7M50@st11p01im-asmtp001.me.com> for
 git@vger.kernel.org; Sun, 20 Dec 2015 00:34:33 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,,
 definitions=2015-12-19_13:,, signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1011 suspectscore=14 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1510270003 definitions=main-1512200010
X-Pgp-Agent: GPGMail 2.6b2
X-Mailer: Apple Mail (2.3112)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282755>


--Apple-Mail=_605E40FE-DC90-491C-AF44-2CA48293782C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

I think this might be a bug, albeit a minor one:

If you have a folder containing only files not tracked by git, and you =
try to use =E2=80=9Cgit mv=E2=80=9D to relocate it, then (at least on my =
machine, running git version 2.6.3), I get this error message:

"fatal: source directory is empty, source=3DSRCDIR, =
destination=3DDESTDIR=E2=80=9D

when a better message might be something like:

=E2=80=9Cno files in directory are under version control, source=3DSRCDIR,=
 destination=3DDESTDIR=E2=80=9D

David Hirsch
dhirsch@me.com
http://davehirsch.com

-----BEGIN PGP PUBLIC KEY BLOCK-----
Comment: GPGTools - https://gpgtools.org

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
YPtDo+Gm0NHXlNRhsyJ9vjBMgPOc
=3DpWwJ
-----END PGP PUBLIC KEY BLOCK-----




--Apple-Mail=_605E40FE-DC90-491C-AF44-2CA48293782C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJWdfeVAAoJECUR8fe3gjpFD/IQAJUnTZ7FpNKrtWUmMzHiNT+i
hILiOqWEq3jDo9YVjhhKwlpuVU946T/d4Diphw2XuW4MGv9KA86+gNmOKbTCwV/2
XR+CdwjGknYA5lIodNcc9Ln9bGkrhPf5+MXKzffBo+whDawcbGhK+9DQ3VQejq4s
q1ndKPjdxtfS6Q3UgUvD4GZVuFlmB5E1lIzbzdJLN5pXokoa3IF9sI7iqUVGSsnm
VeQf2ujT/1a0QFe8xXECuoL9gNjwy7yKQHjRH5iAEZNqsZVpbAzWudfBl1NuPoUx
uThvhGF3Dxr1Fgg4MmvZqp1mdv7r+I2YuHMyIYAmGlXceyamgkTzabLNxwXPCIg+
yhu0505VytfD/fCulYmAIKDQVbRQL+mnad71QHiRzqE5qNARb3APrMSxun88dm+A
4w7OnI+nZVT2eYYEDcDd5zdeWIf28GJ2hZDZexs5moL4lL6LKDui0mwaDakHMLKe
cqah6SPs02uQOG57cz8ypTVEJSXGTLFyCaVSekw9eTciJl/U1y4Eb92JyhNahcYM
BZ06tGzTmAs6C7b2cpQCI2cNhoNFXs/ZnTiqnE2alfQdDIMvigI6TxFn2JjTMtdD
Oi1FjrH6tIvWgQHAi2daZUtWXZErPakS57B4YyM3XUWREBw9kjWV3gC259pC0BG+
hmSiEw2lAwJAY+lJmvia
=gSjN
-----END PGP SIGNATURE-----

--Apple-Mail=_605E40FE-DC90-491C-AF44-2CA48293782C--
