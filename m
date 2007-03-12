From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: What's the best method between merging and rebasing ?
Date: Mon, 12 Mar 2007 20:43:09 +0100
Message-ID: <20070312194309.GI30489@mad.intersec.eu>
References: <200703121139.l2CBdcUL022906@localhost.localdomain> <20070312120820.GE18952@mad.intersec.eu> <200703121634.l2CGYtGx027263@localhost.localdomain> <45F589BF.28E3A5AD@eudaptics.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="NzX0AQGjRQPusK/O";
	protocol="application/pgp-signature"; micalg=pgp-sha1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 12 20:43:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQqQP-0005Nr-Tg
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 20:43:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829AbXCLTnP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 15:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752810AbXCLTnO
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 15:43:14 -0400
Received: from rudy.intersec.eu ([88.191.20.202]:53586 "EHLO mx2.intersec.fr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752829AbXCLTnO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 15:43:14 -0400
Received: from localhost.localdomain (beacon-free1.intersec.eu [81.57.219.236])
	by mx1.intersec.eu (Postfix) with ESMTP id 713DAD8855
	for <git@vger.kernel.org>; Mon, 12 Mar 2007 20:43:09 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 1003)
	id 51096ABD6A4; Mon, 12 Mar 2007 20:43:09 +0100 (CET)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <45F589BF.28E3A5AD@eudaptics.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42069>


--NzX0AQGjRQPusK/O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 12, 2007 at 06:11:27PM +0100, Johannes Sixt wrote:
> Xavier Maillard wrote:
> > -> D -> E -> F -> several commits from old master -> HEAD (of new maste=
r)
> >=20
> > So it seems to be cherry-picks + rebase master on new HEAD but I
> > am not sure at how things are doing :)
>=20
> Just to get the wording straight: You mean "reset master to new HEAD",
> not "rebase". "reset" means to point the branch identifier ("master") to
> some commit - with or without modifying the working directory
> accordingly. OTOH, "rebase" means to re-apply a string of commits on top
> of some other commit.
 =20
  err that was indeed a lapsus from me. Sorry for the mistake, that was
indeed what I intended to say.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--NzX0AQGjRQPusK/O
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFF9a1NvGr7W6HudhwRAuCoAJ41S827ptLKp53eL5FWHpKohupR+wCggdIr
2jxg16Aj0q6ZdhZ0OFFdppM=
=TGBi
-----END PGP SIGNATURE-----

--NzX0AQGjRQPusK/O--
