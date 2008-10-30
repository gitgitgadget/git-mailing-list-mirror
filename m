From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Using the --track option when creating a branch
Date: Thu, 30 Oct 2008 15:41:07 +0100
Message-ID: <20081030144107.GE24098@artemis.corp>
References: <18696.32778.842933.486171@lisa.zopyra.com> <1225343538.10803.9.camel@maia.lan> <18697.41702.241183.408377@lisa.zopyra.com> <18697.42140.459170.891195@lisa.zopyra.com> <4909A7C4.30507@op5.se> <2008-10-30-14-52-52+trackit+sam@rfc1149.net> <4909BF58.9010500@op5.se> <2008-10-30-15-23-16+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="n+lFg1Zro7sl44OB";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Andreas Ericsson <ae@op5.se>, Bill Lear <rael@zopyra.com>,
	git@vger.kernel.org
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Thu Oct 30 15:42:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvYjD-0000GK-LX
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 15:42:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754821AbYJ3OlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 10:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754725AbYJ3OlM
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 10:41:12 -0400
Received: from pan.madism.org ([88.191.52.104]:54953 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754710AbYJ3OlL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 10:41:11 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id EF4963B3C4;
	Thu, 30 Oct 2008 15:41:08 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id A7B0F5EE23B; Thu, 30 Oct 2008 15:41:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <2008-10-30-15-23-16+trackit+sam@rfc1149.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99474>


--n+lFg1Zro7sl44OB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2008 at 02:23:16PM +0000, Samuel Tardieu wrote:
> I think it would be better to have :
>=20
>   git push                <=3D push the current branch
>   git push --all          <=3D push all matching refs
>   git push --all --create <=3D push all matching refs, create if needed
>=20
> The latest command is probably used so rarely (compared to the others)
> that it wouldn't be a problem to make it longer. Of course, if a
> refspec is given explicitely, it should be honored and remote refs
> created if needed.

Fwiw I'm in favor of that, and it was what I advocated at the time.

Though I think than as soon as you add an explicit remote name, like:
git push origin, pushing all matched references makes sense. Which is
also what I advocated at the time.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--n+lFg1Zro7sl44OB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkJx4MACgkQvGr7W6HudhwDJACfRYL7Zub9X/FGHRTTsu6C3NXo
cmcAmgINgPOr1tWvBlqk+Xk/SLJTUbzH
=BZkE
-----END PGP SIGNATURE-----

--n+lFg1Zro7sl44OB--
