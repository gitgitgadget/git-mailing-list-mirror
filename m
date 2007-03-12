From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: What's the best method between merging and rebasing ?
Date: Mon, 12 Mar 2007 13:08:20 +0100
Message-ID: <20070312120820.GE18952@mad.intersec.eu>
References: <200703121139.l2CBdcUL022906@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="DqhR8hV3EnoxUkKN";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Cc: git@vger.kernel.org
To: Xavier Maillard <zedek@gnu.org>
X-From: git-owner@vger.kernel.org Mon Mar 12 13:33:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQjiU-0006fd-9c
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 13:33:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965760AbXCLMdQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 08:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965786AbXCLMdQ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 08:33:16 -0400
Received: from rudy.intersec.eu ([88.191.20.202]:58058 "EHLO mx2.intersec.fr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965760AbXCLMdP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 08:33:15 -0400
X-Greylist: delayed 1490 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Mar 2007 08:33:15 EDT
Received: from localhost.localdomain (beacon-free1.intersec.eu [81.57.219.236])
	by mx1.intersec.eu (Postfix) with ESMTP id B7F2FD884D;
	Mon, 12 Mar 2007 13:08:20 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 1003)
	id 10DD1ABC3D9; Mon, 12 Mar 2007 13:08:20 +0100 (CET)
Mail-Followup-To: Xavier Maillard <zedek@gnu.org>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200703121139.l2CBdcUL022906@localhost.localdomain>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42023>


--DqhR8hV3EnoxUkKN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 12, 2007 at 12:39:38PM +0100, Xavier Maillard wrote:
> Hi,
>=20
> Say I have a project in this state:
>=20
> orig master -> A -> B -> C -> HEAD
>=20
> I want to make A diverging from the original branch so I would be
> at this state :
>=20
> orig master -> A -> B -> C -> HEAD
>      	    \
> 	     -> D -> E -> F ->=20
>=20
> I want master to be at  HEAD of the new branch and I want to pick
> commits here and there from the original master branch.

  I'm not sure I get this right, but if I understand you correctly, I'd
say that you could branch your master into a old-master branch.

  then delete the master branch, and branch it again from the "orig
master", then cherry pick from old-master what you want to keep.

  Of course those approachs only "work" if nobody clones your
repository, as you will rewrite history with that.

  But Maybe I missed what you want to achieve :)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--DqhR8hV3EnoxUkKN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFF9UKzvGr7W6HudhwRAuFiAJ9vol/K1CRqUqS3kgJ39sK3CbHxHgCgnsAP
55xkCmJxkTVVx1oIc+QZmMg=
=YJja
-----END PGP SIGNATURE-----

--DqhR8hV3EnoxUkKN--
