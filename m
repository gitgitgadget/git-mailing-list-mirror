From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: merging .gitignore
Date: Wed, 03 Oct 2007 10:58:45 +0200
Message-ID: <20071003085845.GB12042@artemis.corp>
References: <20071001130314.GA5932@lapse.madduck.net> <200710011448.17701.andyparkins@gmail.com> <20071002195148.GA14171@lapse.madduck.net> <20071002201318.GD16776@artemis.corp> <20071002204748.GA19710@artemis.corp> <20071002205618.GA19097@lapse.madduck.net> <20071002210748.GC19710@artemis.corp> <20071002214919.GA21260@lapse.madduck.net> <20071002220749.GE19710@artemis.corp> <20071003084259.GA25838@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="p4qYPpj5QlsIQJ0K";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: martin f krafft <madduck@debian.org>
X-From: git-owner@vger.kernel.org Wed Oct 03 10:58:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id04F-0003mw-Qc
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 10:58:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755570AbXJCI6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 04:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755590AbXJCI6r
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 04:58:47 -0400
Received: from pan.madism.org ([88.191.52.104]:45141 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755058AbXJCI6q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 04:58:46 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id B55AE2323C;
	Wed,  3 Oct 2007 10:58:45 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 6C308342E59; Wed,  3 Oct 2007 10:58:45 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	martin f krafft <madduck@debian.org>, git@vger.kernel.org,
	Andy Parkins <andyparkins@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <20071003084259.GA25838@lapse.madduck.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59812>


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 03, 2007 at 08:42:59AM +0000, martin f krafft wrote:
> also sprach Pierre Habouzit <madcoder@debian.org> [2007.10.02.2307 +0100]:
> >      (a*)
> >     /    \
> >    v      v
> > (ab*)    (ac*)
> >     \    /
> >      v  v
> >      ????
> >=20
> >   This is a perfectly sensible history. Or I miss sth on your end.
>=20
> So these are revs, not branches?

  Yes, those are the contents of the .gitignores on refs, on top is the
common ancestor, and you have two branches that you want to merge into
one. I pretend that if in one branch the content of the .gitignore was
a* and becomes ab* and than on the other it was a* and became ac*, then
you cannot know how to merge.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHA1nFvGr7W6HudhwRAiZHAJ9niNrvpERbT8hVXQVXRN+8/SD2xQCeJqz5
7SBhzUHQcS1V9cxX4uzDOIw=
=rqzr
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
