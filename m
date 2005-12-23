From: "Fernando J. Pereda" <ferdy@ferdyx.org>
Subject: Re: [PATCH] qgit: allow overriding CCFLAGS
Date: Sat, 24 Dec 2005 00:29:34 +0100
Message-ID: <20051223232934.GA28582@ferdyx.org>
References: <1135380226.18431.21.camel@dv>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
X-From: git-owner@vger.kernel.org Sat Dec 24 00:29:52 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpwM3-0001Et-1a
	for gcvg-git@gmane.org; Sat, 24 Dec 2005 00:29:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161136AbVLWX3k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Dec 2005 18:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161132AbVLWX3k
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Dec 2005 18:29:40 -0500
Received: from 170.Red-213-96-222.staticIP.rima-tde.net ([213.96.222.170]:32900
	"EHLO smtp.ferdyx.org") by vger.kernel.org with ESMTP
	id S1161133AbVLWX3j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Dec 2005 18:29:39 -0500
Received: from localhost (localhost [127.0.0.1])
	by smtp.ferdyx.org (Postfix) with ESMTP id E6A698D314
	for <git@vger.kernel.org>; Sat, 24 Dec 2005 00:26:31 +0100 (CET)
Received: from smtp.ferdyx.org ([127.0.0.1])
	by localhost (tungsteno [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 02056-03 for <git@vger.kernel.org>;
	Sat, 24 Dec 2005 00:26:29 +0100 (CET)
Received: from posidon.ferdyx.org (posidon.ferdyx.org [192.168.0.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.ferdyx.org (Postfix) with ESMTP id 319988D30B
	for <git@vger.kernel.org>; Sat, 24 Dec 2005 00:26:29 +0100 (CET)
Received: by posidon.ferdyx.org (nbSMTP-1.01-cvs) for uid 1000
	(using TLSv1/SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	ferdy@ferdyx.org; Sat, 24 Dec 2005 00:29:35 +0100 (CET)
To: git <git@vger.kernel.org>
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1135380226.18431.21.camel@dv>
User-Agent: Mutt/1.5.11
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at ferdyx.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13999>


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 23, 2005 at 06:23:46PM -0500, Pavel Roskin wrote:
| This patch allows overriding CCFLAGS by setting an environment variable
| or an argument to make.

That'd be nice... I have an ugly sed in the Gentoo ebuild to workaround
that. However...


| -env.Append( CCFLAGS =3D ['-O2', '-Wall' ,'-Wno-non-virtual-dtor'] )
| +env.Append( CCFLAGS =3D os.environ.get('CCFLAGS', ['-O2', '-Wall', '-Wno=
-non-virtual-dtor']) )

=2E.. shouldn't the enviroment variable be CXXFLAGS ?

Cheers,
Ferdy

--=20
Fernando J. Pereda Garcimart=EDn
Gentoo Developer (Alpha,net-mail,mutt,git)
20BB BDC3 761A 4781 E6ED  ED0B 0A48 5B0C 60BD 28D4

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDrIheCkhbDGC9KNQRAoOuAJ4wpVgNHIeiEmiJ19DVXiVOIgmRNQCdGFKr
v53zMb0pJZ3HdD3+4nIlcg4=
=WcEh
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
