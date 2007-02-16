From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [PATCH] pager: use an environment variable for pager_in_use
Date: Fri, 16 Feb 2007 20:43:30 +0100
Message-ID: <45D60962.6010605@fs.ei.tum.de>
References: <20070216151925.GA28974@moooo.ath.cx> <20070216155658.GB7183@coredump.intra.peff.net> <20070216182231.GA31676@moooo.ath.cx> <Pine.LNX.4.63.0702161934230.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070216185653.GA10308@moooo.ath.cx> <Pine.LNX.4.63.0702162004590.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB6717578C866BFDF1CB0AA38"
Cc: Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 16 20:43:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HI8zf-0000mY-2L
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 20:43:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946085AbXBPTnk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 14:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946088AbXBPTnj
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 14:43:39 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:57284 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946085AbXBPTnj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 14:43:39 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id B756428115;
	Fri, 16 Feb 2007 20:43:34 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id SxtboB6VYCAt; Fri, 16 Feb 2007 20:43:34 +0100 (CET)
Received: from [62.216.209.99] (ppp-62-216-209-99.dynamic.mnet-online.de [62.216.209.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 3E70328101;
	Fri, 16 Feb 2007 20:43:34 +0100 (CET)
User-Agent: Mail/News 1.5.0.4 (X11/20060619)
In-Reply-To: <Pine.LNX.4.63.0702162004590.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39942>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB6717578C866BFDF1CB0AA38
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin wrote:
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>>> +int pager_in_use =3D getenv("GIT_PAGER_IN_USE");
>> test.c:3: error: initializer element is not constant
> Sorry.
>=20
> Still, it feels wrong to use two system calls when you need none.

getenv() is usually no system call, but processed in userland.

However, I also always get the feeling that using environment variables w=
ithin one process to communicate state seems wrong, but many old unix too=
ls do it this way.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enigB6717578C866BFDF1CB0AA38
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF1gllr5S+dk6z85oRAlD1AKDmkuuJyhrt51tv8axEn48V0CQ3MQCggvi6
IuvA8MptMOC8BneKu7u4YCU=
=kcf9
-----END PGP SIGNATURE-----

--------------enigB6717578C866BFDF1CB0AA38--
