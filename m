From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git-clean won't read global ignore
Date: Tue, 13 Nov 2007 23:50:57 +0100
Message-ID: <20071113225057.GB22836@artemis.corp>
References: <30046e3b0711131349h51d253d5n4e5649bde36dc36f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="7ZAtKRhVyVSsbBD2";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: shunichi fuji <palglowr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 23:51:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is4bK-0003Xe-EF
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 23:51:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761725AbXKMWvC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 17:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761656AbXKMWvB
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 17:51:01 -0500
Received: from pan.madism.org ([88.191.52.104]:60249 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761494AbXKMWu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 17:50:59 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id CF8FB2A03C;
	Tue, 13 Nov 2007 23:50:57 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 077F043BD10; Tue, 13 Nov 2007 23:50:57 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	shunichi fuji <palglowr@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <30046e3b0711131349h51d253d5n4e5649bde36dc36f@mail.gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64899>


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 13, 2007 at 09:49:00PM +0000, shunichi fuji wrote:
> hi, i setup git to use with eclipse through global excludesfile config.
> git-status report just ignore files, but git-clean deleted ignore files.
>=20
> ----
> $ git-config -l
> core.excludesfile=3D/home/pal/.gitignore
>=20
> $ cat /home/pal/.gitignore
> # ignore for eclipse
> ..project
> ..cproject
>=20
>  $ git-status
> # On branch master
> nothing to commit (working directory clean)
>=20
> $ git-clean
> Removing .project

=2Eproject is not ..project right ?

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHOipQvGr7W6HudhwRAh/8AKCPxf2e+k2qu1zSTeLiGTZpfhC4egCdF44c
t6EqYhL+gcgUEAKDnkqgHtM=
=l21C
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
