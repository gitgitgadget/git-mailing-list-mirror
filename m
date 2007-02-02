From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Fri, 02 Feb 2007 14:51:09 +0100
Message-ID: <45C341CD.7020301@fs.ei.tum.de>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com> <200702010058.43431.jnareb@gmail.com> <20070201003429.GQ10108@waste.org> <200702021055.49428.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBC75B00BF0804B56BBF2CE5A"
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 02 14:51:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCyot-0001Fl-LC
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 14:51:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423089AbXBBNvM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 08:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423031AbXBBNvM
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 08:51:12 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:50818 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423089AbXBBNvM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 08:51:12 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id B1EA728296;
	Fri,  2 Feb 2007 14:51:10 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id AxvsQD1jnbYO; Fri,  2 Feb 2007 14:51:10 +0100 (CET)
Received: from [192.168.10.124] (ppp-62-216-203-79.dynamic.mnet-online.de [62.216.203.79])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 5D58E28293;
	Fri,  2 Feb 2007 14:51:10 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; DragonFly pc32; en-US; rv:1.8.0.8) Gecko/20061212 Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
In-Reply-To: <200702021055.49428.jnareb@gmail.com>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38499>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBC75B00BF0804B56BBF2CE5A
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Jakub Narebski wrote:
>>> Integrity checks can tell you that repository is corrupted, but it wo=
uld
>>> be better if it didn't get corrupted in first place.
>> Obviously. Hence our append-only design. Data that's written to a repo=

>> is never rewritten, which minimizes exposure to software bugs and I/O
>> errors.
>=20
> By the way, RCS / CVS rewrote relevant data (to have diff from the top
> structure) on each commit.
>=20
> I wonder if git could generate pack on the fly fastimport like...

What do you mean with that?  generate the pack on which occasion?  CVS im=
port?  I do this already.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enigBC75B00BF0804B56BBF2CE5A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFw0HNr5S+dk6z85oRAmstAKCk3drtbP6GLGIEh9IAbReVLyOcAQCgkTaK
9+1dSZuWaRxptUKJDDkiXjA=
=qBm6
-----END PGP SIGNATURE-----

--------------enigBC75B00BF0804B56BBF2CE5A--
