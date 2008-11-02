From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] prepare deprecation of git-revert
Date: Sun, 02 Nov 2008 10:30:30 +0100
Message-ID: <20081102093030.GD4066@artemis>
References: <1225468527-29694-1-git-send-email-madcoder@debian.org> <20081102044159.GF5261@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="NklN7DEeGtkPCoo3";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 02 10:31:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwZJD-0004dg-8h
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 10:31:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753087AbYKBJad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 04:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753090AbYKBJad
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 04:30:33 -0500
Received: from pan.madism.org ([88.191.52.104]:57663 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753065AbYKBJac (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 04:30:32 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 8FE2D3B957;
	Sun,  2 Nov 2008 10:30:31 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 09B99373C2; Sun,  2 Nov 2008 10:30:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081102044159.GF5261@coredump.intra.peff.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99830>


--NklN7DEeGtkPCoo3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 02, 2008 at 04:41:59AM +0000, Jeff King wrote:
> On Fri, Oct 31, 2008 at 04:55:27PM +0100, Pierre Habouzit wrote:
>=20
> >  I've not kept the auto-edit feature of git-revert for the git-cherry-p=
ick -R
> >  case as I don't believe it makes a lot of sense. But if people are unh=
appy
> >  with that, I can easily "fix" it.
>=20
> I disagree. I write a new commit message for every revert I do.
>=20
> When you cherry-pick, you are pulling a good commit from somewhere else.
> So its commit message should suffice to explain why you are making the
> change (and infrequently, you might want to give more context or say
> "and here is where this comes from").
>=20
> But when you revert, you are saying "this other commit was bad, so let's
> reverse it." So you can look at the other commit to see what it did, but
> you still don't know _why_ it was bad. A revert should always give
> information about what you know _now_ that you didn't know when you
> made the commit originally.

Indeed that makes sense, I'll update the patch then, and be lighter on
the deprecation side since it seems I misunderstood what people agreed
on.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--NklN7DEeGtkPCoo3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkNczUACgkQvGr7W6HudhyW/ACggP18p3UJTeHBSuWzsGbRoLPv
srwAoIYvbAPymaNfzxNowltOXoLLLmxi
=1/MW
-----END PGP SIGNATURE-----

--NklN7DEeGtkPCoo3--
