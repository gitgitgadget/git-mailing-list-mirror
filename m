From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Thu, 01 Feb 2007 08:59:12 +0100
Message-ID: <45C19DD0.20504@fs.ei.tum.de>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com> <200702010058.43431.jnareb@gmail.com> <20070201003429.GQ10108@waste.org> <200702010157.51452.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4E2BEB4615BBCD09AD59BD25"
Cc: Matt Mackall <mpm@selenic.com>, mercurial@selenic.com,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 01 08:59:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCWqo-0002JH-Tk
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 08:59:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161025AbXBAH7T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 02:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030570AbXBAH7T
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 02:59:19 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:39471 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030540AbXBAH7S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 02:59:18 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 8377A2824E;
	Thu,  1 Feb 2007 08:59:16 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id IjKQUBVORTOp; Thu,  1 Feb 2007 08:59:16 +0100 (CET)
Received: from [192.168.10.124] (ppp-62-216-202-10.dynamic.mnet-online.de [62.216.202.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 00E2B2824B;
	Thu,  1 Feb 2007 08:59:15 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; DragonFly pc32; en-US; rv:1.8.0.8) Gecko/20061212 Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
In-Reply-To: <200702010157.51452.jnareb@gmail.com>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38330>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4E2BEB4615BBCD09AD59BD25
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Jakub Narebski wrote:
>>> Sidenote 2: Mercurial repository structure might make it use "file-id=
s"
>>> (perhaps implicitely), with all the disadvantages (different renames
>>> on different branches) of those.
>> Nope.
> How it is so, if the blobs (file contents) are stored filename hashed?
> IIRC hg has some scheme to deal with renames, but it is file-id (file
> identity) based AFAIK.

No, the buckets are simply the filename.  If you rename, you take the pen=
alty of duplicating the content (compressed) with a new name.  No big dea=
l there.  So there are *no* file-ids.  Blobs go into the data/index file =
which corresponds to their filename.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enig4E2BEB4615BBCD09AD59BD25
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFwZ3Tr5S+dk6z85oRAuKHAKDc2gosEP1sWodzhmsDYS9oBAavswCfTHdU
ZIgdeNZm8sCS/4aBw6uT6A8=
=I1r0
-----END PGP SIGNATURE-----

--------------enig4E2BEB4615BBCD09AD59BD25--
