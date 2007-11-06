From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [bug in next ?] git-fetch/git-push issue
Date: Tue, 06 Nov 2007 18:56:27 +0100
Message-ID: <20071106175627.GB9517@artemis.corp>
References: <20071105175654.GD6205@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Fba/0zbH8Xs+Fj9o";
	protocol="application/pgp-signature"; micalg=SHA1
To: Nicolas Pitre <nico@cam.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>, Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 06 18:56:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpSfN-0004SS-96
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 18:56:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754504AbXKFR4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 12:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753268AbXKFR4a
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 12:56:30 -0500
Received: from pan.madism.org ([88.191.52.104]:38980 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754195AbXKFR4a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 12:56:30 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 8874D26487;
	Tue,  6 Nov 2007 18:56:28 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 721B11456CC; Tue,  6 Nov 2007 18:56:27 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Nicolas Pitre <nico@cam.org>,
	Daniel Barkalow <barkalow@iabervon.org>, Jeff King <peff@peff.net>,
	Git ML <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20071105175654.GD6205@artemis.corp>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63692>


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

  On the same vein, with today's next:

    $ git push origin :teaser
    To ssh://git.corp/srv/git/mmsx.git
     - [deleting]        teaser
    refs/heads/teaser: 05518bc7df1af680447f58b034b108f66668db03 -> deleted
    Everything up-to-date
    fatal: Invalid revision range 05518bc7df1af680447f58b034b108f66668db03.=
=2E0000000000000000000000000000000000000000
    fatal: ambiguous argument 'refs/heads/teaser': unknown revision or path=
 not in the working tree.
    Use '--' to separate paths from revisions

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHMKrLvGr7W6HudhwRAno6AJ9ZstYO1XwSAKY5a6lzGFdxFPinRQCfevUM
5qwIithBf4U93ITeFMe5exE=
=CZUx
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--
