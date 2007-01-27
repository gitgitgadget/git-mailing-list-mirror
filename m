From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [PATCH] Allow the tag signing key to be specified in the config
 file
Date: Sat, 27 Jan 2007 17:44:38 +0100
Message-ID: <45BB8176.9080106@fs.ei.tum.de>
References: <200701261413.46823.andyparkins@gmail.com> <7vodolnfes.fsf@assigned-by-dhcp.cox.net> <45BB55B4.5090303@fs.ei.tum.de> <200701271624.50336.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCEBE7EB3A4B8BD4E7E5249DF"
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 27 17:44:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAqfb-00019s-Ni
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 17:44:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631AbXA0Qop (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 11:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751905AbXA0Qop
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 11:44:45 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:51718 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbXA0Qoo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 11:44:44 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 44D5C281C0;
	Sat, 27 Jan 2007 17:44:43 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id e9gE80agCiCt; Sat, 27 Jan 2007 17:44:43 +0100 (CET)
Received: from [192.168.10.124] (ppp-62-216-202-61.dynamic.mnet-online.de [62.216.202.61])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id A5DF52816E;
	Sat, 27 Jan 2007 17:44:42 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; DragonFly pc32; en-US; rv:1.8.0.8) Gecko/20061212 Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
In-Reply-To: <200701271624.50336.andyparkins@gmail.com>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37960>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCEBE7EB3A4B8BD4E7E5249DF
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Andy Parkins wrote:
>> is there a reason to use name + email as keyid and not just the email
>> address?  that would also mitigate the need to specify user.sigingkey
>> if only the names missmatch between gpg and git, but the email
>> addresses are the same.
> That was my original solution, but it was rejected.
>=20
> http://www.gelato.unsw.edu.au/archives/git/0610/29733.html

oh well.  I don't think this was discussed properly.  The question for me=
 is, what should be the default:  fail if there is no matching key which =
also matches the comment field, or choose the default (sub)key even when =
a different subkey matches (based on the comment field).  First of all, I=
 think the default should be "try not to fail", so that is the second way=
=2E  Additionally, people can specify a different keyid if they want to s=
ign with a different key.

Oh well, I don't really care about this.  I just say that I'd expect it n=
ot to fail...

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enigCEBE7EB3A4B8BD4E7E5249DF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFu4F5r5S+dk6z85oRApHwAKC5uVop8p6QLc8D+dV1wbMcm8XBPwCgxlh/
ew7uM9u8zjGy1QobJGjotyU=
=SBAr
-----END PGP SIGNATURE-----

--------------enigCEBE7EB3A4B8BD4E7E5249DF--
