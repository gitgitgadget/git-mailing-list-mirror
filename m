From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [PATCH] sha1_file.c: Avoid multiple calls to find_pack_entry().
Date: Mon, 22 Jan 2007 21:56:01 +0100
Message-ID: <45B524E1.5060205@fs.ei.tum.de>
References: <20070122202945.GA29297@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB94262E5FEFD6B62E76350CA"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 21:56:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H96D6-00017y-Vu
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 21:56:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932613AbXAVU4J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 15:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbXAVU4J
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 15:56:09 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:46480 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932613AbXAVU4H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 15:56:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 3B831280FA;
	Mon, 22 Jan 2007 21:56:05 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 1j0UT69VC0lk; Mon, 22 Jan 2007 21:56:05 +0100 (CET)
Received: from [192.168.10.124] (ppp-62-216-209-216.dynamic.mnet-online.de [62.216.209.216])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id D00B6280F7;
	Mon, 22 Jan 2007 21:56:04 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; DragonFly pc32; en-US; rv:1.8.0.8) Gecko/20061212 Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
To: Peter Eriksen <s022018@student.dtu.dk>
In-Reply-To: <20070122202945.GA29297@bohr.gbar.dtu.dk>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37452>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB94262E5FEFD6B62E76350CA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Peter Eriksen wrote:
> We used to call find_pack_entry() twice from read_sha1_file() in order
> to avoid printing an error message, when the object did not exist.  Thi=
s
> is fixed by moving the call to error() to the only place it really
> could be called.
>=20
> Signed-off-by: Peter Eriksen <s022018@student.dtu.dk>

I noticed this originally, Peter was so kind to come up with a patch.  Re=
viewed and found +1, so:

Signed-off-by: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enigB94262E5FEFD6B62E76350CA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFtSTkr5S+dk6z85oRAh66AKDjP9eYk2HkYlPCJXzCt+fwRb4EaACeOdhY
dQNZ1JhjJA6lx6IPDPIy6kc=
=WCyG
-----END PGP SIGNATURE-----

--------------enigB94262E5FEFD6B62E76350CA--
