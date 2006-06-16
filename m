From: Keith Packard <keithp@keithp.com>
Subject: Re: parsecvs and unnamed branches
Date: Fri, 16 Jun 2006 15:51:43 -0700
Message-ID: <1150498303.6983.39.camel@neko.keithp.com>
References: <9e4733910606161444i2f996096sbd1f9b3f3ff3a32d@mail.gmail.com>
	 <1150496362.6983.34.camel@neko.keithp.com>
	 <9e4733910606161539t2485e3b3xa9f2852a4d2fc18f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-v15gKeUdldt4cVG+D7Qe"
Cc: keithp@keithp.com, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 17 00:52:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrNAl-00068t-0Z
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 00:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539AbWFPWwI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 18:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751541AbWFPWwH
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 18:52:07 -0400
Received: from home.keithp.com ([63.227.221.253]:28686 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1751539AbWFPWwG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jun 2006 18:52:06 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id B46CB13001F;
	Fri, 16 Jun 2006 15:52:05 -0700 (PDT)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 27833-03; Fri, 16 Jun 2006 15:52:05 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id F1BE113001E; Fri, 16 Jun 2006 15:52:04 -0700 (PDT)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id A94D514001;
	Fri, 16 Jun 2006 15:52:04 -0700 (PDT)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id EEA8E542B2; Fri, 16 Jun 2006 15:51:43 -0700 (PDT)
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606161539t2485e3b3xa9f2852a4d2fc18f@mail.gmail.com>
X-Mailer: Evolution 2.6.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21984>


--=-v15gKeUdldt4cVG+D7Qe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-06-16 at 18:39 -0400, Jon Smirl wrote:

> There is a branch label for SeaMonkey_M8_BRANCH:1.36.0.4 that does
> seems to correspond to anything. Could that be the missing tag?

There's no particular reason to believe it should be; remember that
every file gets a 'magic branch' tag whenever you create a branch in the
repository, but only files with commits along that branch ever see the
revision tree information related to it, so you can expect to see many
branch tags without associated branch revisions in any particular ,v
file. Looking at the commits along 1.3.2, they don't seem particularily
related to the SeaMonkey_M8 branch. =20

--=20
keith.packard@intel.com

--=-v15gKeUdldt4cVG+D7Qe
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEkzX/Qp8BWwlsTdMRAgkXAJ9vrN2GPtaODliI64zDuvwSR+3BSgCfe9AD
JBuH73b2YX2bYAzX+JMzLe8=
=pZKw
-----END PGP SIGNATURE-----

--=-v15gKeUdldt4cVG+D7Qe--
