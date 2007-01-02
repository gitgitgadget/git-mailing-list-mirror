From: Pierre Habouzit <madcoder@debian.org>
Subject: [RFC] Re: git-svn: make git-svn commit-diff able to work without explicit arguments
Date: Tue, 2 Jan 2007 23:27:08 +0100
Message-ID: <20070102222708.GG17898@hades.madism.org>
References: <459AA31E.5070705@gmail.com> <7vr6udtbmv.fsf@assigned-by-dhcp.cox.net> <20070102211339.GF17898@hades.madism.org> <052E1601-5422-48A0-81B3-9A454467CE5F@silverinsanity.com> <enekbs$n8g$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="RDS4xtyBfx+7DiaI";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 02 23:27:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1s6G-0002sc-B9
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 23:27:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964990AbXABW1N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 17:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964996AbXABW1N
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 17:27:13 -0500
Received: from pan.madism.org ([88.191.16.128]:33777 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964990AbXABW1M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 17:27:12 -0500
Received: from hades.madism.org (olympe.madism.org [82.243.245.108])
	by hermes.madism.org (Postfix) with ESMTP id EDB90C001;
	Tue,  2 Jan 2007 23:27:08 +0100 (CET)
Received: by hades.madism.org (Postfix, from userid 1001)
	id 946CB62750; Tue,  2 Jan 2007 23:27:08 +0100 (CET)
To: Jakub Narebski <jnareb@gmail.com>
Mail-Followup-To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <enekbs$n8g$1@sea.gmane.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel-git (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35832>


--RDS4xtyBfx+7DiaI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 02, 2007 at 10:58:14PM +0100, Jakub Narebski wrote:
> Brian Gernhardt wrote:
>=20
> >>   The reason is simple, I often use git commit as :wq in my editor, =
=20
> >> and
> >> sometimes think that in a A--B--C--D and in fact, I'd prefer to have:
> >>
> >>   {A,C}--B--D. how is it possible to do that in a not too cumbersome
> >> way? because that would make sens to work in some scratch branch, and
> >> then reorganize patches in a saner better way in the master branch.
> >>
> >>   But I fail to see how to achieve that without using cumbersome
> >> export-to-patch then git apply patch and edit logs which is painful =
=20
> >> and
> >> not really using git.
> >=20
> > The command you seem to be looking for is git-cherry-pick.  To =20
> > combine the two commits, I'd do something like:
> >=20
> > $ git cherry-pick A
> > $ git cherry-pick C
> > $ git reset HEAD~2
> > $ git add <files>
> > $ git commit
>=20
> Or better learn about --no-commit option of git-cherry-pick. Or if you
> don't mind additional tools I think you can do this using StGIT.

  oh those solutions look awsome and easily scriptable, which is
exactly what I need, and it feels simpler to use for my small brain than
the solution Junio proposed. thanks a lot !

  I wonder why I never got to that alone ...
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--RDS4xtyBfx+7DiaI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFmtw8vGr7W6HudhwRAjhqAJ9TY3BKEDrtCpP//JX859coWVv/wACfQAYh
k2yeNFBkfhGG+KwWqwUB+h0=
=OUK+
-----END PGP SIGNATURE-----

--RDS4xtyBfx+7DiaI--
