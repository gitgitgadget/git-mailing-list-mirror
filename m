From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [BUG?] Fail to pull from kernel.org: pack has bad object
Date: Mon, 20 Oct 2008 10:26:55 +0200
Message-ID: <200810201026.57306.trast@student.ethz.ch>
References: <200810201010.29173.johan@herland.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4589766.Ox37uJUgWJ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Oct 20 19:47:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Krq7V-0008W3-D6
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 10:28:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719AbYJTI04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 04:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751660AbYJTI04
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 04:26:56 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:21924 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751591AbYJTI0z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 04:26:55 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 20 Oct 2008 10:26:53 +0200
Received: from pcjremy.inf.ethz.ch ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 20 Oct 2008 10:26:53 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <200810201010.29173.johan@herland.net>
X-OriginalArrivalTime: 20 Oct 2008 08:26:53.0432 (UTC) FILETIME=[9B50EF80:01C9328D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98683>

--nextPart4589766.Ox37uJUgWJ
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Jonathan Herland wrote:
>
> Currently I get the following error when trying to pull from git.git at=20
> kernel.org:
>=20
> $ git pull
> remote: Counting objects: 279, done.
> remote: Compressing objects: 100% (78/78), done.
> remote: Total 177 (delta 136), reused 135 (delta 99)
> Receiving objects: 100% (177/177), 66.59 KiB | 59 KiB/s, done.
> fatal: pack has bad object at offset 53487: failed to apply delta
> fatal: index-pack failed

I just had the same, panicked, then compiled 'maint' and the fetch
worked.  Unfortunately I wasn't awake enough to make a copy of the
repo.  Maybe you can make one, then use it to bisect the problem
between maint and next...

=2D Thomas

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch




--nextPart4589766.Ox37uJUgWJ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkj8QNEACgkQqUud07tmzP3wDgCfchDgnc85/vVIGRZLcvAYFW7j
bQ0An0a9a3PNiW/ZCgaC0j0csQSixvHp
=K5wW
-----END PGP SIGNATURE-----

--nextPart4589766.Ox37uJUgWJ--
