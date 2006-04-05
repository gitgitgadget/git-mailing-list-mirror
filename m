From: Radoslaw Szkodzinski <astralstorm@o2.pl>
Subject: Re: HTTP repo referencing stale heads (can't clone)
Date: Wed, 05 Apr 2006 14:23:06 +0200
Message-ID: <4433B6AA.6070407@o2.pl>
References: <443146EC.7060704@gentoo.org> <7virpqefp1.fsf@assigned-by-dhcp.cox.net> <4431694C.4000007@gentoo.org> <20060404180130.GF14967@reactrix.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0920F82785CC1F1E5C15E8EA"
Cc: Daniel Drake <dsd@gentoo.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 05 14:28:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FR77B-00064J-Lw
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 14:28:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWDEM1w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 08:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWDEM1w
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 08:27:52 -0400
Received: from mx2.go2.pl ([193.17.41.42]:8325 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S1751204AbWDEM1w (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Apr 2006 08:27:52 -0400
Received: from zen.localdomain (host-81-190-200-101.gorzow.mm.pl [81.190.200.101])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by poczta.o2.pl (Postfix) with ESMTP id 9571474811D;
	Wed,  5 Apr 2006 14:27:46 +0200 (CEST)
Received: from zen.localdomain ([192.168.0.1])
	by zen.localdomain with esmtpa (Exim 4.60)
	(envelope-from <astralstorm@o2.pl>)
	id 1FR72k-0006z0-Mg; Wed, 05 Apr 2006 14:23:26 +0200
User-Agent: Mail/News 1.5 (X11/20060404)
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20060404180130.GF14967@reactrix.com>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18427>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0920F82785CC1F1E5C15E8EA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Nick Hengeveld wrote:
> On Mon, Apr 03, 2006 at 07:28:28PM +0100, Daniel Drake wrote:
>=20
>> Ah, should have known. I am behind a (lame) transparent proxy on port =
80.
>>
>> I opened that file in my web browser and it showed the old heads. Afte=
r=20
>> a force-refresh (ctrl+F5, which sends some additionally http headers t=
o=20
>> refresh the page from the real server), the old heads disappeared, and=
=20
>> git now clones successfully.
>>
>> git-http-fetch should probably send those extra headers too. I'll try =
to=20
>> find some time to look at this next week.
>=20
> git-http-fetch uses the "Pragma: no-cache" header when requesting
> objects that shouldn't be cached.  Is this the additional header you're=

> referring to?
>=20

As per HTTP 1.1, it should also send:
Cache-Control: no-cache

Pragma: no-cache is the deprecated extension.
It's safe to send both.

--=20
GPG Key id:  0xD1F10BA2
Fingerprint: 96E2 304A B9C4 949A 10A0  9105 9543 0453 D1F1 0BA2

AstralStorm


--------------enig0920F82785CC1F1E5C15E8EA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEM7aulUMEU9HxC6IRAuyHAJ0ds4czgYpaQXSOH9T+sGXe2nKKlACfSB6m
NVf9nHEkvhgZ6KjJl+TDBKY=
=6Mrg
-----END PGP SIGNATURE-----

--------------enig0920F82785CC1F1E5C15E8EA--
