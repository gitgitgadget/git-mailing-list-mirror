From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH] Optimize the fetching of data from perforce.
Date: Tue, 04 Mar 2008 11:04:35 +0100
Message-ID: <47CD1EB3.5030608@trolltech.com>
References: <1204624161-17691-1-git-send-email-marius@trolltech.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigAFEF095BF718C5C1335D4F5D"
Cc: git@vger.kernel.org
To: simon@lst.de, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 04 11:06:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWU1L-0008RY-Hl
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 11:05:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754083AbYCDKEi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 05:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753876AbYCDKEi
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 05:04:38 -0500
Received: from hoat.troll.no ([62.70.27.150]:42234 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753840AbYCDKEh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 05:04:37 -0500
Received: from localhost (localhost [127.0.0.1])
	by hoat.troll.no (Postfix) with ESMTP id 88A10581A6;
	Tue,  4 Mar 2008 11:03:53 +0100 (CET)
Received: from hoat.troll.no ([127.0.0.1])
 by localhost (hoat.troll.no [127.0.0.1]) (amavisd-maia, port 10024) with LMTP
 id 13699-05; Tue,  4 Mar 2008 11:03:53 +0100 (CET)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	by hoat.troll.no (Postfix) with ESMTP id 475D4581A5;
	Tue,  4 Mar 2008 11:03:53 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
In-Reply-To: <1204624161-17691-1-git-send-email-marius@trolltech.com>
X-Enigmail-Version: 0.95.6
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAFVBMVEXU1NTAwMABAQGsrKyE
 hIQwMDAEBAS8hGUfAAACQUlEQVQ4jV2TS47cMAxEKSDZW1CfwMB4PYLkrKchsveJRR2gEen+R0hR
 9vziBmahhyqSRQ4NfF1FmIv3dH4usNAGoFprBVguQJmZ1nX0XiHgEukTCK3TairiZeXcVGzmZIoU
 3738pehdVbiU9KFgMQWeZ1fpHZDfRS4rPb3eQVaZChGx4ikt5GDkAZQ2KKohzjklno4+iJpVhxka
 ZjSpasJ4gdGaEQMWTMjRa5uTqza0XDJjzhIdzGTMrqoopimoIPCKZtVOq265MAXpMLXycmVl2Y8C
 oE1FkT/faKauOjYoHJyOxHfvixjowvI0xZJsKykubgLYzuJMdBO+L86TjxfQ9hz9jpSudbnXXzRm
 tor5i3MUONpOfARAhlWbzWF7OhP2eSeEW9HUBNiHOxUM8HLWHhUAj3NZNsdqRZpNA+DJ+XlX+Qc9
 Z4ZjHX8LRUzgTBBef84NQoCMOcS0+BMsj3klbTzRri03ugXr9em1GfgzDAyEn4J3fvFI5YwdTrYu
 1ntAY1h5ysM2OMGm+cBOocCXHisAHu2PagnLghoG2krz8bzsA4fj7KxCGk+63jt+DDCtYjbFNkHD
 nRwpRqsQYx5WYzsbm/eBfn0I4TbOGvMWqhQAiEDzNs4apumCI0x2OyHtY7uAlZff/sanbH9+AGT1
 KOEmUlJISdYPgEgehw+cTZEf6xeFyoEjCPgv+A62KhW3EOy9PL7WmCBMRWmfYN0OqW9krzl/Ay91
 75HMqfDtP8UFckFUX2rwrm/kTVB2gH+hdu4avZVCuAAAAABJRU5ErkJggg==
X-Virus-Scanned: Maia Mailguard 1.0.2a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76059>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAFEF095BF718C5C1335D4F5D
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Marius Storm-Olsen said the following on 04.03.2008 10:49:
> Signed-off-by: Marius Storm-Olsen <marius@trolltech.com>
> ---
>  Huge speedup on Windows (a clone of ~43MB binary file is reduced from =
5m 40s, to ~23s)
>  No measureable impact on Linux for me.

Grr, the commit message was lost in 'translation' it seems. I'll=20
resend, and prefix "git-p4: " on the subject.

--=20
=2Emarius


--------------enigAFEF095BF718C5C1335D4F5D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFHzR6zKzzXl/njVP8RAhkaAKD4S3rOeeUJ3SbfYPLMG7uVFVxB7wCg5BzB
kgjmgVwUbS7ZtRlIp6JrodQ=
=VhXB
-----END PGP SIGNATURE-----

--------------enigAFEF095BF718C5C1335D4F5D--
