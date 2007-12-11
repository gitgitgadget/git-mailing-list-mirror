From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git-bisect feature suggestion: "git-bisect diff"
Date: Tue, 11 Dec 2007 10:29:16 +0100
Message-ID: <20071211092916.GF30948@artemis.madism.org>
References: <20071207093439.GA21896@elte.hu> <200712080636.12982.chriscool@tuxfamily.org> <20071211092446.GA4703@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="gneEPciiIl/aKvOT";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Tue Dec 11 10:29:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J21Qq-0002Q3-4q
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 10:29:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbXLKJ3T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 04:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbXLKJ3T
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 04:29:19 -0500
Received: from pan.madism.org ([88.191.52.104]:41872 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750829AbXLKJ3S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 04:29:18 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 6B4FD2F4B6;
	Tue, 11 Dec 2007 10:29:17 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id AFED7105FD; Tue, 11 Dec 2007 10:29:16 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Ingo Molnar <mingo@elte.hu>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20071211092446.GA4703@elte.hu>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67832>


--gneEPciiIl/aKvOT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2007 at 09:24:46AM +0000, Ingo Molnar wrote:
> ---------{ git-authors }--------->
> #!/bin/bash
>=20
> git-log $@ | grep Author: | cut -d: -f2 | sort | uniq -c | sort -n

You mean:
    git shortlog -n -s HEAD -- "$@"
to do exactly the same right ? :)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--gneEPciiIl/aKvOT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHXlhsvGr7W6HudhwRAi9MAJ9xMPQwVqd+8U3ygSU+6TEkLqXH6wCgjP/b
ueGUWfVXf0joJtimxZsIhjc=
=gryD
-----END PGP SIGNATURE-----

--gneEPciiIl/aKvOT--
