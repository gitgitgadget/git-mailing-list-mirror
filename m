From: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Subject: How to not download objects more than needed?
Date: Tue, 21 Feb 2006 20:38:42 +0100
Message-ID: <43FB6C42.5000208@gorzow.mm.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1E6B6EB3DFAEC2E56AD78299"
X-From: git-owner@vger.kernel.org Tue Feb 21 20:39:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBdLf-0001sz-Sb
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 20:39:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbWBUTi4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 14:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWBUTi4
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 14:38:56 -0500
Received: from goliat1.kalisz.mm.pl ([81.15.136.226]:3206 "EHLO kalisz.mm.pl")
	by vger.kernel.org with ESMTP id S964853AbWBUTiz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2006 14:38:55 -0500
Received: (qmail 16510 invoked from network); 21 Feb 2006 19:38:53 -0000
Received: from unknown (HELO zen.uplink) (astralstorm@[81.190.201.167])
          (envelope-sender <astralstorm@gorzow.mm.pl>)
          by 0 (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 21 Feb 2006 19:38:53 -0000
Received: from [192.168.0.1] (zen.uplink [192.168.0.1])
	by zen.uplink (Postfix) with ESMTP id 260B717905A
	for <git@vger.kernel.org>; Tue, 21 Feb 2006 20:38:49 +0100 (CET)
User-Agent: Mail/News 1.5 (X11/20060219)
To: Git Mailing List <git@vger.kernel.org>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16544>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1E6B6EB3DFAEC2E56AD78299
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I have a pecuilar, but common use case for git.

I have linux-2.6 repository pulled and I'd like to download some branch
(say, netdev-2.6), which uses many of the same objects,
but not to get all the objects from the git server.

I've already tried certain commands, but still can't do it,
and my bandwidth isn't too happy about it.

It seems to require some kind of HEAD rewinding,
or maybe fetching to another branch, I don't know.

Anyone cares to help?

--=20
GPG Key id:  0xD1F10BA2
Fingerprint: 96E2 304A B9C4 949A 10A0  9105 9543 0453 D1F1 0BA2

AstralStorm


--------------enig1E6B6EB3DFAEC2E56AD78299
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD+2xIlUMEU9HxC6IRAlt6AJ0Sk1HTAhWrntfDp6lpiabCxVXz2ACfSfCN
JUdjv5F/46QcSUyGxAahbXk=
=R4+5
-----END PGP SIGNATURE-----

--------------enig1E6B6EB3DFAEC2E56AD78299--
