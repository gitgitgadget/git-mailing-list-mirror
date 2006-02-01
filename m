From: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Subject: Re: git-unadd anyone?
Date: Wed, 01 Feb 2006 17:11:00 +0100
Message-ID: <43E0DD94.6080300@gorzow.mm.pl>
References: <43E0D469.1030404@gorzow.mm.pl> <20060201153823.GB16461@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCFE2AAB3CE5E3C5A16E632B1"
X-From: git-owner@vger.kernel.org Wed Feb 01 17:12:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4KZc-0000ti-GK
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 17:11:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422669AbWBAQLJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 11:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422670AbWBAQLJ
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 11:11:09 -0500
Received: from goliat1.kalisz.mm.pl ([81.15.136.226]:24249 "EHLO kalisz.mm.pl")
	by vger.kernel.org with ESMTP id S1422669AbWBAQLI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Feb 2006 11:11:08 -0500
Received: (qmail 4925 invoked from network); 1 Feb 2006 16:11:06 -0000
Received: from unknown (HELO zen.uplink) (astralstorm@[81.190.201.167])
          (envelope-sender <astralstorm@gorzow.mm.pl>)
          by 0 (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 1 Feb 2006 16:11:06 -0000
Received: from [192.168.0.1] (zen.uplink [192.168.0.1])
	by zen.uplink (Postfix) with ESMTP id DD7EA178C60
	for <git@vger.kernel.org>; Wed,  1 Feb 2006 17:11:04 +0100 (CET)
User-Agent: Thunderbird 1.4.1 (X11/20051010)
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <20060201153823.GB16461@informatik.uni-freiburg.de>
X-Enigmail-Version: 0.93.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15425>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCFE2AAB3CE5E3C5A16E632B1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Uwe Zeisberger wrote:
> Hello Radoslaw,
>=20
> Radoslaw Szkodzinski wrote:
>> Is there an easy way to just unmark files wrongly marked as added?
>>
>> I'm not thinking about something like git-reset --mixed,
>> which would discard the index as a whole.
>> I only want to unmark files I git-add(1)ed.
> How about
>=20
> 	git update-index --force-remove <filename>
>=20
>=20
> Best regards
> Uwe
>=20

Thank you, it's exactly what I was looking for.

If I was mad enough, I'd use git-update-index --add instead of git-add.
I'll have to reacquaint with git low-level commands anyway.

It's weird that there's git-add, yet no git-remove.
The only difference is the exclude file handling (not a problem with remo=
ve)
and doing global changes when no parameters are given.

Actually, I don't like the second property that much.
I'd prefer an explicit -a for --all. But it's probably for CVS users sake=
, right?

--=20
GPG Key id:  0xD1F10BA2
Fingerprint: 96E2 304A B9C4 949A 10A0  9105 9543 0453 D1F1 0BA2

AstralStorm


--------------enigCFE2AAB3CE5E3C5A16E632B1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD4N2YlUMEU9HxC6IRAtRhAJ0Sw+bWbMtTY0hCJ6nxxIyBJfojHwCggfp7
qaON8YDkQDtyYEyx9+V2qFo=
=x3un
-----END PGP SIGNATURE-----

--------------enigCFE2AAB3CE5E3C5A16E632B1--
