From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [PATCH] New files in git weren't being downloaded during CVS
 update
Date: Sat, 20 Jan 2007 11:41:29 +0100
Message-ID: <45B1F1D9.7090903@fs.ei.tum.de>
References: <200701191049.40833.andyparkins@gmail.com> <45B16E29.7000607@fs.ei.tum.de> <200701201025.31251.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig31C768219909E365572CA948"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 11:41:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8DfK-0007xu-63
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 11:41:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965237AbXATKli (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Jan 2007 05:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965251AbXATKli
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 05:41:38 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:57204 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965237AbXATKlh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jan 2007 05:41:37 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 0D69D280D2;
	Sat, 20 Jan 2007 11:41:34 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id cCxDDNSzreyN; Sat, 20 Jan 2007 11:41:33 +0100 (CET)
Received: from [192.168.10.124] (ppp-62-216-203-207.dynamic.mnet-online.de [62.216.203.207])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id A8D07280A7;
	Sat, 20 Jan 2007 11:41:33 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; DragonFly pc32; en-US; rv:1.8.0.8) Gecko/20061212 Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
To: Andy Parkins <andyparkins@gmail.com>
In-Reply-To: <200701201025.31251.andyparkins@gmail.com>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37267>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig31C768219909E365572CA948
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Andy Parkins wrote:
> On Saturday 2007, January 20 01:19, Simon 'corecode' Schubert wrote:
>=20
>> I think this is the wrong fix.  Reading cvs's classify.c, T_ADDED is
>> only generated for *locally* added files, never for added files in
>> the repo.  The correct status would be "U" as well.
>=20
> I'm sure you're right; I don't know enough about CVS to comment.  The=20
> real fix would seem to be to completely remove the special case for=20
> added files and let it drop through to the normal update code.=20

yes, that's what I ment.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enig31C768219909E365572CA948
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFsfHbr5S+dk6z85oRAhCkAJ9Vi3461RqwLcnGHZ/tOA9U74bEIgCgozdk
rYu8soqI86GNN8v64j+YMco=
=bxR2
-----END PGP SIGNATURE-----

--------------enig31C768219909E365572CA948--
