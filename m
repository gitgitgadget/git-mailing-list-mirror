From: Radoslaw Szkodzinski <astralstorm@o2.pl>
Subject: Re: [BUG] git-http-fetch segfault
Date: Tue, 04 Apr 2006 22:25:26 +0200
Message-ID: <4432D636.4050407@o2.pl>
References: <4432A8CC.5020200@o2.pl> <20060404184935.GG14967@reactrix.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0FB30B7F03325558F419408D"
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 04 22:30:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQsAY-00021S-PG
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 22:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbWDDUa1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Apr 2006 16:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbWDDUa1
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Apr 2006 16:30:27 -0400
Received: from mx.go2.pl ([193.17.41.41]:12483 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S1750840AbWDDUaZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Apr 2006 16:30:25 -0400
Received: from zen.localdomain (host-81-190-200-101.gorzow.mm.pl [81.190.200.101])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by poczta.o2.pl (Postfix) with ESMTP id 7DAB113793E;
	Tue,  4 Apr 2006 22:30:23 +0200 (CEST)
Received: from zen.localdomain ([192.168.0.1])
	by zen.localdomain with esmtpa (Exim 4.60)
	(envelope-from <astralstorm@o2.pl>)
	id 1FQs6B-0005lZ-Rm; Tue, 04 Apr 2006 22:25:59 +0200
User-Agent: Mail/News 1.5 (X11/20060404)
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20060404184935.GG14967@reactrix.com>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18408>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0FB30B7F03325558F419408D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Nick Hengeveld wrote:
> On Tue, Apr 04, 2006 at 07:11:40PM +0200, Radoslaw Szkodzinski wrote:
>=20
>> I have some problems cloning stgit repository (maybe something's broke=
n there).
>>
>> astralstorm@zen /home/devel $ git clone
>> http://homepage.ntlworld.com/cmarinas/stgit.git stgit
>> error: Unable to find adad46f365219e9bcc1a212826ca65eaac09729c under
>> http://homepage.ntlworld.com/cmarinas/stgit.git/
>> Cannot obtain needed blob adad46f365219e9bcc1a212826ca65eaac09729c
>> while processing commit 8847a11b3bbf5406f37a360e5466f0e392c56383.
>=20
> That host name resolves to multiple IP addresses, is it possible that
> one of the servers was out of sync?  I tried cloning directly from each=

> address and couldn't reproduce the problem.
>=20

Okay, I've nailed it. It's caused by Privoxy.
It seems that Privoxy sends its 404 page with 200 OK reply.
Clearly a broken response.

Does anyone have any better proxy supporting real SOCKS 4a/5 upstream pro=
xy?
(for Tor)
Delegate doesn't count - it has broken HTTP code, 1.0 only and slow too.

--=20
GPG Key id:  0xD1F10BA2
Fingerprint: 96E2 304A B9C4 949A 10A0  9105 9543 0453 D1F1 0BA2

AstralStorm


--------------enig0FB30B7F03325558F419408D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEMtY6lUMEU9HxC6IRAuGtAKCraNNsmgEDzd/h3i5PR/h/CmGOnwCghiWx
/JeW/hEGUmGZAR/oZF03LxM=
=Ttj0
-----END PGP SIGNATURE-----

--------------enig0FB30B7F03325558F419408D--
