From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: Newbie Query
Date: Tue, 20 Jan 2009 15:34:12 -0600
Message-ID: <200901201534.16571.bss@iguanasuicide.net>
References: <20090120191952.GA25322@uts.thewillards.local> <3f4fd2640901201217x22262655w115cc2a25e32865e@mail.gmail.com> <49763D2B.1000607@morey-chaisemartin.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5685295.xBojrSSfGg";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: devel@morey-chaisemartin.com
X-From: git-owner@vger.kernel.org Tue Jan 20 23:15:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPOsg-0004Z5-NN
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 23:15:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756072AbZATWOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 17:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755153AbZATWOJ
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 17:14:09 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:51517 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753180AbZATWOI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 17:14:08 -0500
Received: from [63.167.79.115]
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LPODu-0002In-Op; Tue, 20 Jan 2009 21:33:27 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <49763D2B.1000607@morey-chaisemartin.com>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106530>

--nextPart5685295.xBojrSSfGg
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 2009 January 20 15:07:55 Nicolas Morey-Chaisemartin wrote:
>I did the rookie mistkae on the central server to create the main
>reposity in non-bare mode. So i need to checkout the HEAD revision each
>time I push.
>Is there a cleaner way to convert a non-bare git repo into a bare repo
>than cloning it?
>My repo have a lot of remote branch registered, and cloning them to a
>new bare repo mean I'll have to add all those remote branches again
>(except if there is another trick here I don't know about).

Well, if you can make sure no one is pushing into the repo for a bit: clone=
 it=20
and replace the original with a symlink to new, bare one.  Your clients wil=
l=20
be able to use the same URL, so they should be happy.  (I haven't tried thi=
s,=20
but it should work.)
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart5685295.xBojrSSfGg
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkl2Q1gACgkQdNbfk+86fC0ZtQCeMODu1njv0JgE6Q8n3QnxMC4A
VJoAn0LEC3TOPBSGS4KCFYyKHhs6NF9Y
=feEF
-----END PGP SIGNATURE-----

--nextPart5685295.xBojrSSfGg--
