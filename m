From: "Fernando J. Pereda" <ferdy@ferdyx.org>
Subject: Re: ./configure script prototype
Date: Mon, 14 Nov 2005 17:32:40 +0100
Message-ID: <20051114163240.GA32445@ferdyx.org>
References: <43788078.4040403@op5.se> <437880AC.3040101@op5.se> <20051114132956.GT30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
X-From: git-owner@vger.kernel.org Mon Nov 14 17:36:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbhGF-0001vm-AK
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 17:32:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbVKNQcs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 11:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbVKNQcs
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 11:32:48 -0500
Received: from 170.Red-213-96-222.staticIP.rima-tde.net ([213.96.222.170]:15522
	"EHLO smtp.ferdyx.org") by vger.kernel.org with ESMTP
	id S1751165AbVKNQcr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 11:32:47 -0500
Received: from localhost (localhost [127.0.0.1])
	by smtp.ferdyx.org (Postfix) with ESMTP id 3DE778D33D
	for <git@vger.kernel.org>; Mon, 14 Nov 2005 17:32:45 +0100 (CET)
Received: from smtp.ferdyx.org ([127.0.0.1])
	by localhost (tungsteno [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 13163-08 for <git@vger.kernel.org>;
	Mon, 14 Nov 2005 17:32:41 +0100 (CET)
Received: from posidon.ferdyx.org (posidon.ferdyx.org [192.168.0.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.ferdyx.org (Postfix) with ESMTP id 618C48D30B
	for <git@vger.kernel.org>; Mon, 14 Nov 2005 17:32:41 +0100 (CET)
Received: by posidon.ferdyx.org (nbSMTP-1.01-cvs) for uid 1000
	(using TLSv1/SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	ferdy@ferdyx.org; Mon, 14 Nov 2005 17:32:41 +0100 (CET)
To: Git Mailing List <git@vger.kernel.org>
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20051114132956.GT30496@pasky.or.cz>
User-Agent: Mutt/1.5.11
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at ferdyx.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11809>


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 14, 2005 at 02:29:56PM +0100, Petr Baudis wrote:
| Dear diary, on Mon, Nov 14, 2005 at 01:18:52PM CET, I got a letter
| where Andreas Ericsson <ae@op5.se> said that...
| > 		--prefix=3D*)
| > 			prefix=3D${1##*=3D}
|=20
| Aren't those heavy bashisms?

As far as I know, it should be supported by a POSIX 'sh'[1]:

---8<---
${parameter##word}

Remove Largest Prefix Pattern. The word shall be expanded to produce a
pattern. The parameter expansion shall then result in parameter, with
the largest portion of the prefix matched by the pattern deleted.
---8<---

Whether other shells support it or not... I don't know.

Cheers,
Ferdy

[1] http://www.opengroup.org/onlinepubs/009695399/utilities/xcu_chap02.html

--=20
Fernando J. Pereda Garcimartin
Gentoo Developer (Alpha,net-mail,mutt,git)
20BB BDC3 761A 4781 E6ED  ED0B 0A48 5B0C 60BD 28D4

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDeLwoCkhbDGC9KNQRAtU9AJ0by6rwNe47XUzWjW8d2y4LNzdAawCcDc6d
lWslwwkl7UDrfEC/jS78JqY=
=QKWf
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
