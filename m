From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [PATCH] Allow git-diff exit with codes similar to diff(1)
Date: Thu, 15 Mar 2007 13:49:36 +0100
Message-ID: <45F940E0.60302@fs.ei.tum.de>
References: <81b0412b0703131717k7106ee1cg964628f0bda2c83e@mail.gmail.com>	 <Pine.LNX.4.64.0703131757080.9690@woody.linux-foundation.org>	 <Pine.LNX.4.63.0703140216480.22628@wbgn013.biozentrum.uni-wuerzburg.de>	 <Pine.LNX.4.64.0703131831390.9690@woody.linux-foundation.org>	 <Pine.LNX.4.63.0703140237270.22628@wbgn013.biozentrum.uni-wuerzburg.de>	 <81b0412b0703140137i6d0df44aua9205e81249570ea@mail.gmail.com>	 <Pine.LNX.4.63.0703141301210.22628@wbgn013.biozentrum.uni-wuerzburg.de> <81b0412b0703140526p454ee85fk74dcd76fb684217c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1A318A33AAAF9FE30DE41B77"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 13:49:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRpOu-0001tj-MF
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 13:49:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030181AbXCOMtp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Mar 2007 08:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030185AbXCOMtp
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Mar 2007 08:49:45 -0400
Received: from stella.fs.ei.tum.de ([129.187.54.7]:44022 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030181AbXCOMto (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2007 08:49:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 19E9828416;
	Thu, 15 Mar 2007 13:49:42 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id zAfGDJpHQToP; Thu, 15 Mar 2007 13:49:40 +0100 (CET)
Received: from [62.216.202.19] (ppp-62-216-202-19.dynamic.mnet-online.de [62.216.202.19])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 203C528415;
	Thu, 15 Mar 2007 13:49:39 +0100 (CET)
User-Agent: Mail/News 1.5.0.4 (X11/20060619)
In-Reply-To: <81b0412b0703140526p454ee85fk74dcd76fb684217c@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42278>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1A318A33AAAF9FE30DE41B77
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Alex Riesen wrote:
> We have "PAGER=3Dcat" in test-lib.sh which just disables pager,
> so gits tests do not have the problem (maybe it was disabled just
> because of this?). And if someone has own tests _with_ pager active
> the one better be aware of what the one doing.

Does PAGER=3Dcat really disable the pager?  seems to me that it simply pa=
sses the data through cat.  That's not disabling it, but it is instead re=
ndering the pager transparent.  Not for the exit code though.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enig1A318A33AAAF9FE30DE41B77
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF+UDjr5S+dk6z85oRAn6HAJ9Jac+8ENd39KjGtXLlFfoBKCicbwCeJZmZ
c669zjycRiNN9/93vZ2/K5k=
=D9G6
-----END PGP SIGNATURE-----

--------------enig1A318A33AAAF9FE30DE41B77--
