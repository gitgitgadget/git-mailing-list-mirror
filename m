From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: [pasky] recent changes to gitdiff.sh
Date: Mon, 18 Apr 2005 12:40:08 +0200
Message-ID: <1113820808.16288.9.camel@nosferatu.lan>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-p3vSeJ40vYpYjjiDhnw9"
Content-Transfer-Encoding: 8bit
Cc: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Mon Apr 18 12:33:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNTZ4-000258-7M
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 12:33:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbVDRKge (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 06:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbVDRKge
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 06:36:34 -0400
Received: from ctb-mesg5.saix.net ([196.25.240.77]:51604 "EHLO
	ctb-mesg5.saix.net") by vger.kernel.org with ESMTP id S262021AbVDRKg0
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 06:36:26 -0400
Received: from gateway.lan (wblv-146-244-27.telkomadsl.co.za [165.146.244.27])
	by ctb-mesg5.saix.net (Postfix) with ESMTP id 687B66A07;
	Mon, 18 Apr 2005 12:36:15 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id C0E1D3A26DB;
	Mon, 18 Apr 2005 12:42:27 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 27883-12; Mon, 18 Apr 2005 12:42:23 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id 129FB3A26DA;
	Mon, 18 Apr 2005 12:42:23 +0200 (SAST)
To: GIT Mailing Lists <git@vger.kernel.org>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-p3vSeJ40vYpYjjiDhnw9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I see the recent changes to gitdiff.sh requires you to pass -r (git diff
-r local:$tracking) even if you separate the branches via ':'.  Is this
intended (seems like it)?  If so, then gittrack.sh, gitpull.sh and
gitmerge.sh needs to be updated ...

(I did not want to add a patch as I am not sure which it is)


Thanks,

--=20
Martin Schlemmer


--=-p3vSeJ40vYpYjjiDhnw9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCY46IqburzKaJYLYRAh3ZAKCW2F6xdte7uZb1Lm4DEHPc89eGrQCggJ03
QmzIA1GVILkRXv7+mkXEF1o=
=XR6G
-----END PGP SIGNATURE-----

--=-p3vSeJ40vYpYjjiDhnw9--

