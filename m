From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: Pushing to a non-bare repository
Date: Sat, 03 Feb 2007 10:46:05 +0100
Message-ID: <45C459DD.8080201@fs.ei.tum.de>
References: <45C3FB08.1020805@midwinter.com> <7vfy9ndiqp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig27E97B4B98E7A30E8563ED5C"
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 03 10:46:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDHTR-0006Cw-Ae
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 10:46:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933193AbXBCJqO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 04:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933285AbXBCJqO
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 04:46:14 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:48364 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933193AbXBCJqM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 04:46:12 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id DBB61281E8;
	Sat,  3 Feb 2007 10:46:08 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id TTrDIO2PtpRO; Sat,  3 Feb 2007 10:46:08 +0100 (CET)
Received: from [192.168.10.124] (ppp-62-216-203-135.dynamic.mnet-online.de [62.216.203.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 6F294281E6;
	Sat,  3 Feb 2007 10:46:08 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; DragonFly pc32; en-US; rv:1.8.0.8) Gecko/20061212 Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
In-Reply-To: <7vfy9ndiqp.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38559>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig27E97B4B98E7A30E8563ED5C
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
>> This keeps coming up as I introduce people to git. In previous
>> discussions, the conclusion often seems to be that users don't really
>> know what they want the semantics to be.
>=20
> I do not think that was the conclusion.  My suggestion to you
> would be to stop thinking as if push is a converse of pull
> (because it is not; push is a counterpart of fetch), and leave
> push as is.

However, your suggestion does not help people who don't know better.  Pus=
hing into the HEAD branch of another repo breaks stuff there.  Badly.  Th=
is should be prevented, really.

I don't say "Push needs to behave like a fast forward pull", because that=
's wrong.  You can't just change the workdir, possibly due to permissions=
 problems.  But push has to abort if you try to forward HEAD on the remot=
e, except if it is bare, of course.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enig27E97B4B98E7A30E8563ED5C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFxFnfr5S+dk6z85oRAiIrAKCYIDTi2Xf7sRt4V7O0rsrXw8CaUwCg8mek
6T2qfBr/3ZO55kWuJSBhVg8=
=Vew4
-----END PGP SIGNATURE-----

--------------enig27E97B4B98E7A30E8563ED5C--
