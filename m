From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: git ls-files -o under .git/ prints all repository files
Date: Fri, 19 Jan 2007 08:51:17 +0100
Message-ID: <45B07875.9030506@fs.ei.tum.de>
References: <87r6trsu7n.wl@mail2.atmark-techno.com> <7vwt3jjywc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFEF49C9F0A1CCEA090A1C094"
Cc: Yasushi SHOJI <yashi@atmark-techno.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 19 08:51:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7oX1-0002Ep-0W
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 08:51:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbXASHvY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 02:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbXASHvX
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 02:51:23 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:55267 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964920AbXASHvX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 02:51:23 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id A9DE828177;
	Fri, 19 Jan 2007 08:51:21 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id rCHxHVhUnkcq; Fri, 19 Jan 2007 08:51:21 +0100 (CET)
Received: from [62.216.208.62] (ppp-62-216-208-62.dynamic.mnet-online.de [62.216.208.62])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 24DEB2816B;
	Fri, 19 Jan 2007 08:51:21 +0100 (CET)
User-Agent: Mail/News 1.5.0.4 (X11/20060619)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwt3jjywc.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37157>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFEF49C9F0A1CCEA090A1C094
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> Yasushi SHOJI <yashi@atmark-techno.com> writes:
>=20
>> ls-files -o prints all files under .git if you are in the .git
>> directory.  this is pretty dangerous since we now have git clean to
>> delete files marked others.
>>
>> sure in UNIX env., you can easily shoot yourself in the foot. but it'd=

>> might be nice to help newbies.
>=20
> It's amusing to see that people can find obscure ways to shoot
> themselves in the foot.
>=20
> Amusing problems deserve an equally amusing solution.

I guess you are not serious.  I wonder, why does git-ls-files ever list f=
iles under .git?  I'd just say:  fail if you want to list $GIT_DIR.  Mayb=
e other tools should do so as well.

% cd .hg && hg status -A .
abort: path contains illegal component: .hg

I think this is a sensible thing to do.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enigFEF49C9F0A1CCEA090A1C094
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFsHh3r5S+dk6z85oRAiL5AJwLhCqRqu+/o69rNgW5FbZW72l8UwCgvMnZ
YRLkOd+IKK0f2zH2tyZev0g=
=DEhH
-----END PGP SIGNATURE-----

--------------enigFEF49C9F0A1CCEA090A1C094--
