From: martin f krafft <madduck@debian.org>
Subject: Re: merging .gitignore
Date: Tue, 2 Oct 2007 22:49:19 +0100
Organization: The Debian project
Message-ID: <20071002214919.GA21260@lapse.madduck.net>
References: <20071001130314.GA5932@lapse.madduck.net> <Pine.LNX.4.64.0710011457120.28395@racer.site> <20071001130314.GA5932@lapse.madduck.net> <200710011448.17701.andyparkins@gmail.com> <20071002195148.GA14171@lapse.madduck.net> <20071002201318.GD16776@artemis.corp> <20071002204748.GA19710@artemis.corp> <20071002205618.GA19097@lapse.madduck.net> <20071002210748.GC19710@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
To: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org,
	Andy Parkins <andyparkins@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 02 23:51:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icpdt-0006wW-CN
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 23:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754595AbXJBVuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 17:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754381AbXJBVuv
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 17:50:51 -0400
Received: from clegg.madduck.net ([82.197.162.59]:49914 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753909AbXJBVuu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 17:50:50 -0400
Received: from lapse.madduck.net (213-202-173-105.bas504.dsl.esat.net [213.202.173.105])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id EFBE7BA2A9;
	Tue,  2 Oct 2007 23:50:36 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id C73793FDED; Tue,  2 Oct 2007 22:49:19 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20071002210748.GC19710@artemis.corp>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-2-686 i686
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: ClamAV 0.91.2/4456/Tue Oct  2 17:11:59 2007 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59745>


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Pierre Habouzit <madcoder@debian.org> [2007.10.02.2207 +0100]:
> > >        (a*)
> > >       /    \
> > >   (ab*)    (ac*)
> > >       \    /
> > >        ????
> >=20
> > (a*, ab*, ac*)
>=20
>   Definitely not. a* -> ab* is making a?* unignored for any value of ?
> except b. So adding a* is definitely invalid.

In left, ab* is still ignored, in right ac* is still ignored, and in
the integration branch, they're all ignored. We don't merge up in
this model...

--=20
 .''`.   martin f. krafft <madduck@debian.org>
: :'  :  proud Debian developer, author, administrator, and user
`. `'`   http://people.debian.org/~madduck - http://debiansystem.info
  `-  Debian - when you have better things to do than fixing systems
=20
"if there's anything more important than my ego,
 i want it caught and shot now."
                                                -- zaphod beeblebrox

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHArzfIgvIgzMMSnURAmXpAKDBf1N//1/e8wy+QRaV7EvoiPExxgCdFDun
qJj2nFTXNoHg+S4Ilc/IAro=
=QrJo
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
