From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Any way to ignore a change to a tracked file when committing/merging?
Date: Wed, 13 Jun 2007 18:33:12 +0200
Message-ID: <20070613163312.GJ5311@artemis.intersec.eu>
References: <A30E217A-084E-4019-949F-5918EAA6368E@mimvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="o7gdRJTuwFmWapyH";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: David Watson <dwatson@mimvista.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 18:33:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyVmX-0004nL-R7
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 18:33:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758162AbXFMQdQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 12:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758628AbXFMQdP
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 12:33:15 -0400
Received: from pan.madism.org ([88.191.52.104]:44645 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758162AbXFMQdP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 12:33:15 -0400
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id DA809D694;
	Wed, 13 Jun 2007 18:33:13 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id D7E1453B6; Wed, 13 Jun 2007 18:33:12 +0200 (CEST)
Mail-Followup-To: David Watson <dwatson@mimvista.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <A30E217A-084E-4019-949F-5918EAA6368E@mimvista.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50093>


--o7gdRJTuwFmWapyH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2007 at 11:47:33AM -0400, David Watson wrote:
> I've got a problem, or maybe annoyance is more the proper term, that I=20
> haven't seen solved by any SCM system (at least not to my knowledge).=20
> Basically, I may make some changes, e.g. to a Makefile or somesuch, that=
=20
> I want to ignore when looking at what's changed from the repository. The=
=20
> only problem is, the file I've modified is already under version control,=
=20
> so .gitignore doesn't do anything.
>=20
> Now, I can commit it, so it will stop bugging me, but then when I push=20
> out it will include that change, unless I back it out. This is a change=
=20
> that I don't want propagated anywhere else, because it's specific to my=
=20
> machine or development sandbox.
>=20
> Is there any way to do this? I'd really love to use git-commit -a in this=
=20
> situation, and I could hack up a script to undo my change, run git-commit=
=20
> -a, and reapply the change, but makes me a bit squirmy. If I could put=20
> something in a .git config file to say "commit 237ab should not be=20
> propagated under any circumstances", that would be fantastic.

  please read the thread [ pull into dirty working tree ] that is just
about this, and like errr 2 threads before yours.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--o7gdRJTuwFmWapyH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGcBxIvGr7W6HudhwRAos+AJ9RRu/OW81VCVeHV78rCIRGpCpjpwCgqWmr
g2ft01LKHafJejdqAuspAqI=
=T5Uu
-----END PGP SIGNATURE-----

--o7gdRJTuwFmWapyH--
