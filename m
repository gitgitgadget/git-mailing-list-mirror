From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [PATCH] Change "refs/" references to symbolic constants
Date: Tue, 20 Feb 2007 13:24:51 +0100
Message-ID: <45DAE893.9030204@fs.ei.tum.de>
References: <200702191839.05784.andyparkins@gmail.com> <200702201021.58754.andyparkins@gmail.com> <7vabz9w270.fsf@assigned-by-dhcp.cox.net> <200702201057.21398.andyparkins@gmail.com> <Pine.LNX.4.63.0702201235350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig77426A58F0730D4342BA7E72"
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 20 13:25:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJU3O-000183-Dc
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 13:25:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932923AbXBTMZB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 07:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932924AbXBTMZB
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 07:25:01 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:58939 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932923AbXBTMZA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 07:25:00 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 947AD2819F;
	Tue, 20 Feb 2007 13:24:55 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id oo9Meg1gOhye; Tue, 20 Feb 2007 13:24:55 +0100 (CET)
Received: from [62.216.212.7] (ppp-62-216-212-7.dynamic.mnet-online.de [62.216.212.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id EF5C828199;
	Tue, 20 Feb 2007 13:24:54 +0100 (CET)
User-Agent: Mail/News 1.5.0.4 (X11/20060619)
In-Reply-To: <Pine.LNX.4.63.0702201235350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40234>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig77426A58F0730D4342BA7E72
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin wrote:
>> I've never really liked "!" on strcmp() lines (but I accept that that =
is the=20
>> tradition in git) because it implies the the output of prefixcmp is bo=
olean,=20
>> but it's actually ternary.
>=20
> Actually, it's not even ternary, but to the return value should only be=
=20
> handled in terms of >0, =3D=3D0, <0.
>=20
> Ah, and if "!" implies a boolean, then why is "!!" a common construct? =

> Because "!" really does not imply a boolean.

Depends on how you look at it.  I code using semantics which use expressi=
ons only as boolean if they are really are.  So NULL pointers are not tre=
ated like a boolean, and neither are errno nor strcmp.  For me that's par=
t of good, readable style, but people/groups of course are free to disagr=
ee.  Even after so many years of breathing C, I find   "if (!strcmp(foo, =
bar))" misleading, suggesting "not compare", which translates to "not equ=
al".  Of course I know it, and can work with it, but in my own code I'd n=
ever write this.  I don't see any gain except some obfuscation.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enig77426A58F0730D4342BA7E72
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF2uiWr5S+dk6z85oRAsPIAJ0UoQrCOtdPdXO/qagBtLUWV8QGvwCglIy6
sJkh+DKSp7cQS8HmeOGytgU=
=OkkV
-----END PGP SIGNATURE-----

--------------enig77426A58F0730D4342BA7E72--
