From: "Boyd Stephen Smith Jr." <bss03@volumehost.net>
Subject: Re: fatal output from git-show really wants a terminal
Date: Wed, 10 Dec 2008 16:24:06 -0600
Message-ID: <200812101624.11255.bss03@volumehost.net>
References: <ghop5d$qud$1@ger.gmane.org> <200812102046.50186.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7598268.3DVMe100J9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>, Tim Olsen <tim@brooklynpenguin.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 10 23:25:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAXUr-0001pi-G4
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 23:25:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753485AbYLJWYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 17:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753409AbYLJWYJ
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 17:24:09 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:64748 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753356AbYLJWYI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 17:24:08 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20081210222407.CKGH2948.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 10 Dec 2008 17:24:07 -0500
Received: from [10.0.0.123] ([72.204.50.125])
	by fed1rmimpo02.cox.net with bizsmtp
	id paQ61a00A2i4SyG04aQ6vX; Wed, 10 Dec 2008 17:24:07 -0500
X-Authority-Analysis: v=1.0 c=1 a=4x8eZqvhE5cA:10 a=cCwArZ2WySYA:10
 a=nEQGfrJnAAAA:8 a=pPtlm3eTAPfBldqyw0wA:9 a=TIvKYbPKmq7eX8v19k8EvC8_vn8A:4
 a=B7iFY6Z7H_gA:10 a=LY0hPdMaydYA:10 a=wVZX06xqH1-Fx18mdYcA:9
 a=dFsmT-2iDlEIXykH1prNJcv2-okA:4 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
User-Agent: KMail/1.9.9
In-Reply-To: <200812102046.50186.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102731>

--nextPart7598268.3DVMe100J9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 2008 December 10 13:46:50 you wrote:
>On Mittwoch, 10. Dezember 2008, Tim Olsen wrote:
>> It appears that when outputting a fatal error, git-show will choose
>> stdout over stderr if stdout is a terminal and stderr is not.
>
>This is by design.

Then it is poor design. :P j/k

Why not use the pager only if git-show is "interactive", using the same tes=
t=20
for interactivity as SUSv3/POSIX shells use?  IIRC, a shell is interactive =
if=20
both stdin and stderr are terminals.  That test for interactivity -- a=20
associated difference in behavior -- predates git by a number of years.  Is=
=20
there a reason for being different?  Is the porcelain consistent about that=
=20
behavior?
=2D-=20
Boyd Stephen Smith Jr. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ,=3D ,-_-. =
=3D.=20
bss03@volumehost.net =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((_/)o o(\_=
))
ICQ: 514984 YM/AIM: DaTwinkDaddy =A0 =A0 =A0 =A0 =A0 `-'(. .)`-'=20
http://iguanasuicide.org/ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\_/ =
=A0 =A0=20

--nextPart7598268.3DVMe100J9
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklAQYsACgkQdNbfk+86fC14igCdFYhXYRfBS2sZPavGLtLmX5e6
/jUAn27B0JrCEWK4OVhjqCRaTCha7Z6z
=10XR
-----END PGP SIGNATURE-----

--nextPart7598268.3DVMe100J9--
