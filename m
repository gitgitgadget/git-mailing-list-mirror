From: Nicolas Vilz <niv@iaglans.de>
Subject: Re: Moving a directory into another fails
Date: Thu, 27 Jul 2006 01:25:30 +0200
Message-ID: <20060726232530.GC30601@vsectoor.geht-ab-wie-schnitzel.de>
References: <9e4733910607260800v618edf0em7b0f5c3332bf8fc5@mail.gmail.com> <20060726223459.GA30601@vsectoor.geht-ab-wie-schnitzel.de> <9e4733910607261603m6772602cr333d8c58f555edaa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 01:25:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5slE-0003Fq-PQ
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 01:25:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbWGZXZt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 19:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWGZXZt
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 19:25:49 -0400
Received: from geht-ab-wie-schnitzel.de ([217.69.165.145]:31245 "EHLO
	vsectoor.geht-ab-wie-schnitzel.de") by vger.kernel.org with ESMTP
	id S1751242AbWGZXZs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jul 2006 19:25:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 6AE353E87;
	Thu, 27 Jul 2006 01:25:47 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at vsectoor.geht-ab-wie-schnitzel.de
Received: from vsectoor.geht-ab-wie-schnitzel.de ([127.0.0.1])
	by localhost (vsectoor.geht-ab-wie-schnitzel.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MRsXtL5Dnvh0; Thu, 27 Jul 2006 01:25:33 +0200 (CEST)
Received: by vsectoor.geht-ab-wie-schnitzel.de (Postfix, from userid 1000)
	id 059DE3E90; Thu, 27 Jul 2006 01:25:30 +0200 (CEST)
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <9e4733910607261603m6772602cr333d8c58f555edaa@mail.gmail.com>
X-message-flag: Please send plain text messages only. Thank you.
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24260>


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2006 at 07:03:30PM -0400, Jon Smirl wrote:
> This is a simpler sequence
>=20
> cg clone git foo
> cg clone git foo1
> cd foo
> mkdir zzz
> git mv gitweb zzz
> cg diff >patch
> cg ../foo1
> cg patch <../foo/patch
>=20
> Fails with these errors. We have determined that git apply patch is ok
> and this is a bug in cg patch.

Well, perhaps i should react faster and I shouldn't pause my fetchmail
for 2 or 3 hours... this is bad for this list :) You are kind of fast :)=20

Nicolas

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEx/nqSlT0CowElk8RAo78AJ0U6cBPOhtgUnHOpbSvO6KyXZHoyQCeOKiQ
xIu+NEjXKc71PQgMmstZdM8=
=BWo7
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--
