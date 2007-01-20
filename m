From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [PATCH] Don't call fstat() on stdin in index-pack.
Date: Sat, 20 Jan 2007 19:00:54 +0100
Message-ID: <45B258D6.8090602@fs.ei.tum.de>
References: <20070118212615.GO8624@jukie.net>	<20070119024436.GQ8624@jukie.net>	<45B034D2.6010007@fs.ei.tum.de> <20070120183519.3a182064.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4B000DD23103AAEE3A153F4D"
Cc: Bart Trojanowski <bart@jukie.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 19:01:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8KWX-0005FV-Dl
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 19:01:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965342AbXATSBB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Jan 2007 13:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965343AbXATSBB
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 13:01:01 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:41852 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965342AbXATSBA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jan 2007 13:01:00 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 82791280D2;
	Sat, 20 Jan 2007 19:00:58 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id MG0ePvkacAhE; Sat, 20 Jan 2007 19:00:58 +0100 (CET)
Received: from [62.216.203.207] (ppp-62-216-203-207.dynamic.mnet-online.de [62.216.203.207])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id DEA18280BD;
	Sat, 20 Jan 2007 19:00:57 +0100 (CET)
User-Agent: Mail/News 1.5.0.4 (X11/20060619)
To: Sergey Vlasov <vsu@altlinux.ru>
In-Reply-To: <20070120183519.3a182064.vsu@altlinux.ru>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37277>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4B000DD23103AAEE3A153F4D
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Sergey Vlasov wrote:
> Compiling git with -D_FILE_OFFSET_BITS=3D64 will make ino_t 64-bit and
> therefore will fix the problem (however, I'm not sure whether the git
> code is ready for this).

It better be :)  My OS of choice has 64bit off_t and ino_t since a long t=
ime now...

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enig4B000DD23103AAEE3A153F4D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFsljZr5S+dk6z85oRAlsfAKCxuVoibBC8ApzH5bpq1FVCCoyE6gCgks2p
d4qOSOHxvwaqV0qXXOa/C3Q=
=vYdy
-----END PGP SIGNATURE-----

--------------enig4B000DD23103AAEE3A153F4D--
