From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: Re: [patch pasky] update gitcancel.sh to handle modes as well
Date: Fri, 15 Apr 2005 01:14:07 +0200
Message-ID: <1113520447.23299.137.camel@nosferatu.lan>
References: <1113519445.23299.119.camel@nosferatu.lan>
	 <1113519890.23299.129.camel@nosferatu.lan>
	 <20050414230712.GT22699@pasky.ji.cz>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-MP5cQpT96HPt/a9/5VM4"
Content-Transfer-Encoding: 8bit
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 15 01:07:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMDQd-0004jV-T7
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 01:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbVDNXKk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 19:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbVDNXKk
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 19:10:40 -0400
Received: from ctb-mesg2.saix.net ([196.25.240.74]:10491 "EHLO
	ctb-mesg2.saix.net") by vger.kernel.org with ESMTP id S261627AbVDNXKT
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 19:10:19 -0400
Received: from gateway.lan (wblv-146-239-208.telkomadsl.co.za [165.146.239.208])
	by ctb-mesg2.saix.net (Postfix) with ESMTP id DD1E470F8;
	Fri, 15 Apr 2005 01:10:17 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id 738703A26DB;
	Fri, 15 Apr 2005 01:16:23 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 32536-07; Fri, 15 Apr 2005 01:16:19 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id 898953A26DA;
	Fri, 15 Apr 2005 01:16:19 +0200 (SAST)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050414230712.GT22699@pasky.ji.cz>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-MP5cQpT96HPt/a9/5VM4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-04-15 at 01:07 +0200, Petr Baudis wrote:
> Dear diary, on Fri, Apr 15, 2005 at 01:04:50AM CEST, I got a letter
> where Martin Schlemmer <azarah@nosferatu.za.org> told me that...
> > Rather use checkout-cache to sync our tree, as should do the right thin=
g
> > instead of diffing (cancel imply just blow away everything).
> >=20
> > Signed-off-by: Martin Schlemmer <azarah@nosferatu.za.org>
> >=20
> > gitcancel.sh:  839b3c58f20f6eb8412f499a891e007e2e67d114
> > --- 839b3c58f20f6eb8412f499a891e007e2e67d114/gitcancel.sh
> > +++ uncommitted/gitcancel.sh
> > @@ -10,9 +10,8 @@
> >  #
> >  # Takes no arguments. Takes the evil changes from the tree.
> >=20
> > -# FIXME: Does not revert mode changes!
> >=20
> > -show-diff | patch -p0 -R
> >  rm -f .git/add-queue .git/rm-queue
> > +checkout-cache -q -f -a
> >=20
> >  update-cache --refresh
>=20
> Why -q?
>=20
> Never make things silent unless you really know what are you doing and
> why. The same goes for popular throwing of -f to rm's of files which
> should always exist or 2>/dev/null for cats.
>=20

Uhm, no particular reason (other than perhaps working usually on stuff
where too much info just confuses the user).  If its fine in spirit, the
-q can go.


--=20
Martin Schlemmer


--=-MP5cQpT96HPt/a9/5VM4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCXvk/qburzKaJYLYRAmsqAJ9a866chLWLgNdIFTUJh55FcX68CACfZkAP
K0Zb0Zopr/lTJmXxPDsPNdc=
=ZhAx
-----END PGP SIGNATURE-----

--=-MP5cQpT96HPt/a9/5VM4--

