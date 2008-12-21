From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [PATCH] Make git revert warn the user when reverting a merge commit.
Date: Sat, 20 Dec 2008 21:11:13 -0600
Message-ID: <200812202111.17831.bss@iguanasuicide.net>
References: <200812182039.15169.bss@iguanasuicide.net> <200812210031.08443.robin.rosenberg.lists@dewire.com> <7viqpetfs3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3495349.NpKEPfJeOF";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 21 04:12:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEEk4-0000hB-Uj
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 04:12:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbYLUDLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 22:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751597AbYLUDLI
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 22:11:08 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:36324 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbYLUDLH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 22:11:07 -0500
Received: from ip72-204-50-125.fv.ks.cox.net ([72.204.50.125] helo=[10.0.0.123])
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LEEic-0000WL-LR; Sun, 21 Dec 2008 03:11:02 +0000
User-Agent: KMail/1.9.9
In-Reply-To: <7viqpetfs3.fsf@gitster.siamese.dyndns.org>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103686>

--nextPart3495349.NpKEPfJeOF
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 2008 December 20 20:37:16 Junio C Hamano wrote:
> Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:
> > An alternative, would be "removing changes relative to .."
> > (mainline).
>
> But that is exactly what "This reverts commit X" means, isn't it?

When X is a merge commit, the phrase "the reverts commit X" is ambiguous.  =
Did=20
you revert the tree to X^, X^2, or X^8?  I'd be fine with "This reverts=20
commit X to X^y", but we definitely need some mention of X^y.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart3495349.NpKEPfJeOF
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklNs9UACgkQdNbfk+86fC3ppQCfdmPOTI3vnyXD6a5oa5I4mWvX
fycAnjq0h5u4lnLCnn+phu3r2UGl+Abu
=T2h+
-----END PGP SIGNATURE-----

--nextPart3495349.NpKEPfJeOF--
