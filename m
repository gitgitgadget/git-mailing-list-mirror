From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] Per branch properties for pull and fetch
Date: Thu, 27 Jul 2006 10:55:16 +0200
Message-ID: <20060727085516.GC27593@admingilde.org>
References: <87lkqfcvm2.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 10:55:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G61ea-0003zm-Pm
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 10:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbWG0IzU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 04:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbWG0IzU
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 04:55:20 -0400
Received: from admingilde.org ([213.95.32.146]:3480 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S932543AbWG0IzS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 04:55:18 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1G61eG-0003vt-FJ; Thu, 27 Jul 2006 10:55:16 +0200
To: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>
Content-Disposition: inline
In-Reply-To: <87lkqfcvm2.fsf@gmail.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24271>


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Thu, Jul 27, 2006 at 10:14:45AM +0200, Santi B=E9jar wrote:
> It allows to specify on a per branch basis the following:
> .- default repository to fetch
> .- default branches to merge on a per repository basis
> .- default pull.{octopus,twohead}
>=20
> So if you have this in the config:
> [branch "my"]
> 	remote=3Dyours
> 	merge=3Dmaster
> 	merge=3Dour from theirs
> 	merge=3Dmine from .

could we default the to-be-merged branch to "remotes/$remote/$branch" if
that exists?. That could make life a lot easier when using
clone --use-separate-remote.

--=20
Martin Waitz

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEyH90j/Eaxd/oD7IRAj+vAJ9dw2oNzu18cUVmv8We0KbdEgYCXwCdHlim
eeiJ/D36UWhadAthQfFDXsQ=
=t6YD
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--
