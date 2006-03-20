From: Radoslaw Szkodzinski <astralstorm@o2.pl>
Subject: Question about possible git races
Date: Mon, 20 Mar 2006 17:24:05 +0100
Message-ID: <200603201724.12442.astralstorm@o2.pl>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart38115385.1nqfU9AK5M";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Mar 20 17:28:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLNEx-0000UN-4i
	for gcvg-git@gmane.org; Mon, 20 Mar 2006 17:28:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965099AbWCTQ1v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Mar 2006 11:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965091AbWCTQ1a
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Mar 2006 11:27:30 -0500
Received: from mx2.go2.pl ([193.17.41.42]:11472 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S965094AbWCTQ10 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Mar 2006 11:27:26 -0500
Received: from zen.localdomain (host-81-190-201-167.gorzow.mm.pl [81.190.201.167])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by poczta.o2.pl (Postfix) with ESMTP id AAC0D748087
	for <git@vger.kernel.org>; Mon, 20 Mar 2006 17:27:19 +0100 (CET)
Received: from zen.localdomain ([192.168.0.1])
	by zen.localdomain with esmtpa (Exim 4.60)
	(envelope-from <astralstorm@o2.pl>)
	id 1FLNBC-0003bS-Rq
	for git@vger.kernel.org; Mon, 20 Mar 2006 17:24:26 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17756>

--nextPart38115385.1nqfU9AK5M
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I'd like to write a multithreaded application using git, so I'd like to see=
 if=20
there are any races:

=2D push vs pull
One thread pushes to the repository while another is pulling from it at the=
=20
same time. I should get the older commit.

=2D push vs push
Both threads push at the same time. What happens?
Any good way to merge those pushes?
(I have full access to both repos)

Possibly those two aren't fast-forward of each other.
I think one of the pushes should abort in this case unless I force it.

=2D fetch vs fetch
I mean that two threads try to fetch from different repositories to a singl=
e=20
one. Possibly those two aren't fast-forward of each other.
Any good way to merge those fetches?
(I have full access to both repos)

I'm meaning really bare git there, w/o bash+perl scripts.

=2D-=20
GPG Key id:  0xD1F10BA2
=46ingerprint: 96E2 304A B9C4 949A 10A0  9105 9543 0453 D1F1 0BA2

AstralStorm

--nextPart38115385.1nqfU9AK5M
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQBEHtcslUMEU9HxC6IRAgU8AJ0fFIgYd5mTzisxBW1C9jjvNKKB7QCbBoma
AWkXebV53Xc1IeNsp9WVaE4=
=XkAG
-----END PGP SIGNATURE-----

--nextPart38115385.1nqfU9AK5M--
