From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: Re: [patch pasky] update gitcancel.sh to handle modes as well
Date: Fri, 15 Apr 2005 01:39:06 +0200
Message-ID: <1113521946.23299.143.camel@nosferatu.lan>
References: <1113519445.23299.119.camel@nosferatu.lan>
	 <1113519890.23299.129.camel@nosferatu.lan>
	 <20050414231558.GW22699@pasky.ji.cz>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-SQmo/+ML08cuzC9TxRBa"
Content-Transfer-Encoding: 8bit
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 15 01:33:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMDpN-0007Id-6J
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 01:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbVDNXgG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 19:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVDNXfc
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 19:35:32 -0400
Received: from ctb-mesg2.saix.net ([196.25.240.74]:65416 "EHLO
	ctb-mesg2.saix.net") by vger.kernel.org with ESMTP id S261653AbVDNXfS
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 19:35:18 -0400
Received: from gateway.lan (wblv-146-239-208.telkomadsl.co.za [165.146.239.208])
	by ctb-mesg2.saix.net (Postfix) with ESMTP id 49AB86A13;
	Fri, 15 Apr 2005 01:35:17 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id AE06D3A26DB;
	Fri, 15 Apr 2005 01:41:22 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 15384-01; Fri, 15 Apr 2005 01:41:17 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id 9E9573A26DA;
	Fri, 15 Apr 2005 01:41:17 +0200 (SAST)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050414231558.GW22699@pasky.ji.cz>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-SQmo/+ML08cuzC9TxRBa
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-04-15 at 01:15 +0200, Petr Baudis wrote:
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

PS, shouldn't we add a read-tree $(tree-id) before the checkout-cache?


--=20
Martin Schlemmer


--=-SQmo/+ML08cuzC9TxRBa
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCXv8aqburzKaJYLYRAv2kAJ9TEvat6ftcsRgBozVG8Y/QZyqCjwCfZ/nB
LxTfjZqE7sfuheBRQhD3A0Q=
=6lZv
-----END PGP SIGNATURE-----

--=-SQmo/+ML08cuzC9TxRBa--

