From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: More precise tag following
Date: Sat, 27 Jan 2007 20:55:41 +0100
Message-ID: <45BBAE3D.6000805@fs.ei.tum.de>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org> <Pine.LNX.4.63.0701271352170.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45BB5888.9020608@fs.ei.tum.de> <Pine.LNX.4.63.0701271728020.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45BB87EB.7010200@fs.ei.tum.de> <Pine.LNX.4.63.0701272004250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3A3906816B6BFF225C562F3C"
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 27 20:55:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAteR-0006ga-0Y
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 20:55:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826AbXA0Tzr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 14:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752371AbXA0Tzr
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 14:55:47 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:55656 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751826AbXA0Tzq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 14:55:46 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id E3879280BF;
	Sat, 27 Jan 2007 20:55:44 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id dgSfO2cd-ilk; Sat, 27 Jan 2007 20:55:44 +0100 (CET)
Received: from [192.168.10.124] (ppp-62-216-202-61.dynamic.mnet-online.de [62.216.202.61])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 8533E28084;
	Sat, 27 Jan 2007 20:55:44 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; DragonFly pc32; en-US; rv:1.8.0.8) Gecko/20061212 Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
In-Reply-To: <Pine.LNX.4.63.0701272004250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37993>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3A3906816B6BFF225C562F3C
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin wrote:
> So you want to store it in a pack, fetchable?

Or wherever.  Main point was "reusable", but actually that depends on how=
 long it takes to build the cache (okay, i'll call it cache).

>>> It also gives me a warm fuzzy feeling that no bogus "auxillary=20
>>> information" can be introduced by fetching from somewhere else. (It=20
>>> does not matter if intended or unintended.)
>> I agree on that.
>=20
> So you agree we should _not_ store it in a pack, fetchable?

I agree that it had advantages if you can opt out.

> So, if you _do_ have it in a pack, fetchable, what happens if you=20
> regenerated it locally, fixing a flaw, but then fetch it from somewhere=
=20
> else, where the flaw possibly still exists, what do you do?

the same what happens if you repack a pack locally.  the pack won't be re=
-fetched, thus your data won't be overwritten.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enig3A3906816B6BFF225C562F3C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFu64/r5S+dk6z85oRApPnAKDpJwf4W4JJKfjB2PBNxF0LZOXpZwCgmQRy
Ot00G5iUisRA6f6LWu7EXPY=
=jG6s
-----END PGP SIGNATURE-----

--------------enig3A3906816B6BFF225C562F3C--
