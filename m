From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git-stash segfaults ...
Date: Mon, 20 Aug 2007 22:50:38 +0200
Message-ID: <20070820205038.GA9024@artemis.corp>
References: <20070820174427.GC7206@artemis.corp> <7vmywmrl5l.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="OXfL5xGRrasGEqWY";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 22:50:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INED0-00062J-9C
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 22:50:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755115AbXHTUul (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 16:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754232AbXHTUul
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 16:50:41 -0400
Received: from pan.madism.org ([88.191.52.104]:46202 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751964AbXHTUuk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 16:50:40 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 8F37D1B30B;
	Mon, 20 Aug 2007 22:50:39 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id CE2B7430F; Mon, 20 Aug 2007 22:50:38 +0200 (CEST)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vmywmrl5l.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56259>


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 20, 2007 at 08:44:22PM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> >   When you don't use it from the root of the tree: I was in a subdir of
> > my git tree, trying to do:
> >
> >   git stash apply
> >
> >   and I had:
> >
> >   $ git stash apply
> >   error: missing object referenced by
> >   '0ca54c1fba7fea7dca8a1cc59bce2b2849f26d20' Segmentation fault
> >
> >   going in the root of the repository (where .git is), all went fine.
>=20
> I think this was fixed on Jul 25 with ceff079b and 1.5.3-rc4
> should have it.

  Oh ok, sorry for the noise then, I was using rc3 indeed, debian does
not has rc4 packaged yet :)

Cheers,
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGyf6evGr7W6HudhwRAnZ9AJ9+vYD9CJltmA8ehuGJdLjLK5DYOwCggGCs
tO2ogf3CfY56uj86qM33mk0=
=g3IY
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
