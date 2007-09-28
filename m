From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Mergetool generating blank files (1.5.3)
Date: Fri, 28 Sep 2007 08:35:46 +0200
Message-ID: <20070928063546.GA19299@artemis.corp>
References: <94ccbe710709271131o620bf1far8893328ce98f0ba4@mail.gmail.com> <20070927185707.GC12427@artemis.corp> <46FBFDD7.1080300@gmail.com> <20070927191125.GD12427@artemis.corp> <20070927222326.GB8688@thunk.org> <20070927222825.GG12427@artemis.corp> <20070928051503.GA19815@xp.machine.xx>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="ibTvN161/egqYuK8";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, Russ Brown <pickscrape@gmail.com>,
	Kelvie Wong <kelvie@ieee.org>
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 28 08:36:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ib9S9-0007QR-BQ
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 08:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756801AbXI1Gfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 02:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756774AbXI1Gfu
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 02:35:50 -0400
Received: from pan.madism.org ([88.191.52.104]:49246 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756761AbXI1Gft (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 02:35:49 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id F2D2519476;
	Fri, 28 Sep 2007 08:35:47 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 0B1D3D253; Fri, 28 Sep 2007 08:35:47 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Peter Baumann <waste.manager@gmx.de>, git@vger.kernel.org,
	Russ Brown <pickscrape@gmail.com>, Kelvie Wong <kelvie@ieee.org>
Content-Disposition: inline
In-Reply-To: <20070928051503.GA19815@xp.machine.xx>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59371>


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 28, 2007 at 05:15:03AM +0000, Peter Baumann wrote:
> FWIW, xxdiff has support to handle halfway merged files, so that if git
> could merge some hunks already for you (e.g. rerere kicked in), you
> don't have to redo the _whole_ merge by hand, just call
>=20
> 	xxdiff -U file/with/mergemarkers/inside
>=20
> and it will do the right thing. Not sure if the other tools could handle
> it, but any pointers appreciated, because it often happens to me that
> only one hunk out of several wasn't merged automatically by git. And
> mergetool wants to always redo the whole merge, which isn't the best it
> can do.

  For what I've seen, it's how meld works, and I find it nice too. Meld
is quite slow (python + gnomeish doesn't help) but well, I don't merge
things that often, so like said I think I'll give it a try for a while
and see if it has what it takes :)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG/KDCvGr7W6HudhwRAoXNAKCVSm+Qgcldd24brivJCTNqh9UGJwCeMRN+
1/XmVHlTyB1gJvnj/pErv0Q=
=wH1C
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
