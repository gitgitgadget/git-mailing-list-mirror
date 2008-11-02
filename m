From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] git send-email: allow any rev-list option as an  argument.
Date: Sun, 02 Nov 2008 10:39:07 +0100
Message-ID: <20081102093907.GF4066@artemis>
References: <1225450632-7230-3-git-send-email-madcoder@debian.org> <1225471925-2750-1-git-send-email-madcoder@debian.org> <20081102043523.GE5261@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="AH+kv8CCoFf6qPuz";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 02 10:40:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwZRd-0006KP-Ji
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 10:40:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753223AbYKBJjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 04:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753215AbYKBJjK
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 04:39:10 -0500
Received: from pan.madism.org ([88.191.52.104]:55435 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753191AbYKBJjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 04:39:09 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 8D1CC3B7E2;
	Sun,  2 Nov 2008 10:39:08 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 3F0CC37A8B; Sun,  2 Nov 2008 10:39:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081102043523.GE5261@coredump.intra.peff.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99834>


--AH+kv8CCoFf6qPuz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 02, 2008 at 04:35:23AM +0000, Jeff King wrote:
> On Fri, Oct 31, 2008 at 05:52:05PM +0100, Pierre Habouzit wrote:
>=20
> > Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> > ---
> >=20
> >   One can consider to squash that on top of
> >   <1225450632-7230-3-git-send-email-madcoder@debian.org> to be able to =
pass
> >   all non path arguments before a possible '--' to git format-patch.
>=20
> Personally, I think the other patch is not useful without this. I often
> pull out funny subsets of patches if I know it is safe to do so (e.g., I
> collect small, unrelated bugfixes directly onto a single branch, but I
> send them separately).
>=20
> With this patch, I might even find send-email usable. :)

Well it still messes the file/reference name conflict with no way to
prevent it because of the backward compatibility, and even if unlikely
it's still possible.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--AH+kv8CCoFf6qPuz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkNdTsACgkQvGr7W6Hudhx4NQCggeDbx1WoNlqr2D7j4bphpRn4
4CkAn2btYqGpQonFaM1KMfSCFgY4ktZS
=paDU
-----END PGP SIGNATURE-----

--AH+kv8CCoFf6qPuz--
