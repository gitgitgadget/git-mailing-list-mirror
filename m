From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: How can I restrict git-diff to a specific set of directories?
Date: Tue, 13 Jan 2009 18:02:29 -0600
Message-ID: <200901131802.33879.bss@iguanasuicide.net>
References: <1231890543.31432.5.camel@rotwang.fnordora.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1252521.0H1HqKnzAZ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alan <alan@clueserver.org>
X-From: git-owner@vger.kernel.org Wed Jan 14 01:03:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMtE6-0008NS-6r
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 01:03:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756375AbZANABx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 19:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756227AbZANABx
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 19:01:53 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:39143 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754245AbZANABw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 19:01:52 -0500
Received: from [206.104.163.94]
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LMtCg-0000my-SN; Wed, 14 Jan 2009 00:01:50 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <1231890543.31432.5.camel@rotwang.fnordora.org>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105563>

--nextPart1252521.0H1HqKnzAZ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 2009 January 13 17:49:03 Alan wrote:
>I need to generate a diff
>between one commit and another, but only for the contents of a specific
>directory.
>
>I am not finding a real straightforward way to do that.

I think:
git diff one_commit another -- specific/directory
is supposed to do what you want.  However, I've never used it myself.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart1252521.0H1HqKnzAZ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkltK5kACgkQdNbfk+86fC0wUwCfbsHwyTs2KuxpnwOOToarmC51
hu4Ani8FiXBsDetgmVuacmwEE2VahT8A
=L0xO
-----END PGP SIGNATURE-----

--nextPart1252521.0H1HqKnzAZ--
