From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [PATCH] Allow the tag signing key to be specified in the config
 file
Date: Sat, 27 Jan 2007 14:37:56 +0100
Message-ID: <45BB55B4.5090303@fs.ei.tum.de>
References: <200701261413.46823.andyparkins@gmail.com> <7vodolnfes.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA93B997E10E22CC38EECC6EC"
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jan 27 14:38:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAnkx-0003qR-MY
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 14:38:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbXA0NiI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 08:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752270AbXA0NiI
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 08:38:08 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:34143 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673AbXA0NiH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 08:38:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id C2CD82816A;
	Sat, 27 Jan 2007 14:38:05 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id S6oCE3NVqehu; Sat, 27 Jan 2007 14:38:05 +0100 (CET)
Received: from [62.216.202.61] (ppp-62-216-202-61.dynamic.mnet-online.de [62.216.202.61])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 0753528165;
	Sat, 27 Jan 2007 14:38:04 +0100 (CET)
User-Agent: Mail/News 1.5.0.4 (X11/20060619)
In-Reply-To: <7vodolnfes.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37956>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA93B997E10E22CC38EECC6EC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
>> +	: ${keyid:=3D$(expr "z$tagger" : 'z\(.*>\)')}

is there a reason to use name + email as keyid and not just the email add=
ress?  that would also mitigate the need to specify user.sigingkey if onl=
y the names missmatch between gpg and git, but the email addresses are th=
e same.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enigA93B997E10E22CC38EECC6EC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFu1W4r5S+dk6z85oRAl/oAJ4xKC+tklukWfq3txpDEkW2eVO94QCeOgsY
6HM2ScgA/Vy+qoPgXff1kYM=
=l5/q
-----END PGP SIGNATURE-----

--------------enigA93B997E10E22CC38EECC6EC--
