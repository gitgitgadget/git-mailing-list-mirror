From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git push refspec problem
Date: Wed, 07 Nov 2007 16:20:03 +0100
Message-ID: <20071107152003.GL18057@artemis.corp>
References: <7B37E361-9606-447C-B853-001182688AFA@nc.rr.com> <Pine.LNX.4.64.0711071510480.4362@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="GU3/x65mZ6MFE8p3";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: James <jtp@nc.rr.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 07 16:20:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpmhZ-0007uh-PA
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 16:20:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752336AbXKGPUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 10:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752627AbXKGPUG
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 10:20:06 -0500
Received: from pan.madism.org ([88.191.52.104]:57334 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752336AbXKGPUF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 10:20:05 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 322D127DB3;
	Wed,  7 Nov 2007 16:20:04 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id C266F1AB3E; Wed,  7 Nov 2007 16:20:03 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	James <jtp@nc.rr.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711071510480.4362@racer.site>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63820>


--GU3/x65mZ6MFE8p3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 07, 2007 at 03:11:46PM +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Wed, 7 Nov 2007, James wrote:
>=20
> >        fetch =3D +refs/heads/*:refs/remotes/origin/*
>=20
> This is a refspec.
>=20
> >        push =3D ssh://james@my.server.com/home/james/scm/git/project.gi=
t/
>=20
> This is a URL.  It does not specify any refs.  But "push =3D" expects a U=
RL.
>=20
> You probably want to setup a different remote if you want to push to a=20
> different URL than you are fetching from.

  Oh, there is no way to pull through git:// and push to ssh://
perfectly knowint it's the same physical repository so that the fetch
doesn't have the ssh-handhshake-overhead ?


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--GU3/x65mZ6MFE8p3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHMdejvGr7W6HudhwRAnGsAKCC2M20GzRMK48HG29YN4rr5vsqogCcCOhU
PcpK8cz+T/3j8NyI+Dxd5BU=
=ERkJ
-----END PGP SIGNATURE-----

--GU3/x65mZ6MFE8p3--
