From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git-bisect feature suggestion: "git-bisect diff"
Date: Tue, 11 Dec 2007 12:59:14 +0100
Message-ID: <20071211115914.GJ30948@artemis.madism.org>
References: <20071207093439.GA21896@elte.hu> <200712080636.12982.chriscool@tuxfamily.org> <20071211092446.GA4703@elte.hu> <20071211092916.GF30948@artemis.madism.org> <m3ve75sfn3.fsf@roke.D-201>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="APlYHCtpeOhspHkB";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Ingo Molnar <mingo@elte.hu>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 12:59:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J23ly-00011G-GQ
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 12:59:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925AbXLKL7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 06:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751638AbXLKL7R
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 06:59:17 -0500
Received: from pan.madism.org ([88.191.52.104]:35420 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750986AbXLKL7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 06:59:16 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 7DA912F53C;
	Tue, 11 Dec 2007 12:59:15 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id A2C4D2BCA65; Tue, 11 Dec 2007 12:59:14 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Jakub Narebski <jnareb@gmail.com>, Ingo Molnar <mingo@elte.hu>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <m3ve75sfn3.fsf@roke.D-201>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67841>


--APlYHCtpeOhspHkB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2007 at 10:13:45AM +0000, Jakub Narebski wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > On Tue, Dec 11, 2007 at 09:24:46AM +0000, Ingo Molnar wrote:
> > > ---------{ git-authors }--------->
> > > #!/bin/bash
> > >=20
> > > git-log $@ | grep Author: | cut -d: -f2 | sort | uniq -c | sort -n
> >=20
> > You mean:
> >     git shortlog -n -s HEAD -- "$@"
> > to do exactly the same right ? :)
>=20
> Not exactly, as it does not give us email address.

  maybe it should be "fixed" so that it does, not to mention that other
concerns ingo raised look legit to me.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--APlYHCtpeOhspHkB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHXnuSvGr7W6HudhwRAhpBAJ9vXTeIxKX+IdDXkIkng1U65WYMrACfYnsf
ObSTgRODMtaMY7Jy2FGlNxE=
=z+jO
-----END PGP SIGNATURE-----

--APlYHCtpeOhspHkB--
