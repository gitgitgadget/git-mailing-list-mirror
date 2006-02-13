From: "Fernando J. Pereda" <ferdy@ferdyx.org>
Subject: Re: git-bisect problem
Date: Mon, 13 Feb 2006 10:58:59 +0100
Message-ID: <20060213095859.GA17115@ferdyx.org>
References: <20060213002502.5c23122c.akpm@osdl.org> <7virrj1v44.fsf@assigned-by-dhcp.cox.net> <20060213013205.4ba47836.akpm@osdl.org> <20060213093938.GC11053@mythryan2.michonline.com> <20060213015146.26e6c09d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
X-From: git-owner@vger.kernel.org Mon Feb 13 10:59:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8aU7-0003nh-3X
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 10:59:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbWBMJ7E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 04:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751697AbWBMJ7E
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 04:59:04 -0500
Received: from 170.Red-213-96-222.staticIP.rima-tde.net ([213.96.222.170]:23689
	"EHLO smtp.ferdyx.org") by vger.kernel.org with ESMTP
	id S1751691AbWBMJ7C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2006 04:59:02 -0500
Received: from localhost (localhost [127.0.0.1])
	by smtp.ferdyx.org (Postfix) with ESMTP id B25368D30C
	for <git@vger.kernel.org>; Mon, 13 Feb 2006 10:59:00 +0100 (CET)
Received: from smtp.ferdyx.org ([127.0.0.1])
	by localhost (tungsteno [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 03973-05 for <git@vger.kernel.org>;
	Mon, 13 Feb 2006 10:58:59 +0100 (CET)
Received: from posidon.ferdyx.org (posidon.ferdyx.org [192.168.0.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.ferdyx.org (Postfix) with ESMTP id 7BD5F8D303
	for <git@vger.kernel.org>; Mon, 13 Feb 2006 10:58:59 +0100 (CET)
Received: by posidon.ferdyx.org (nbSMTP-1.01-cvs) for uid 1000
	(using TLSv1/SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	ferdy@ferdyx.org; Mon, 13 Feb 2006 10:58:59 +0100 (CET)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060213015146.26e6c09d.akpm@osdl.org>
User-Agent: Mutt/1.5.11
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at ferdyx.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16061>


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 13, 2006 at 01:51:46AM -0800, Andrew Morton wrote:
| Assuming I find the bad commit, how do I extract it as a patch?
|=20
| I tried
|=20
| git-format-patch -o ~/a 386093ef9a6c88576d8b418bf1c8616d5e410a20 git-netd=
ev-all
|=20
| and that chewed 10 minutes CPU time and produced no output, so I killed i=
t.

This gives you the whole info about the commit, including a patch:

git cat-file commit 386093ef9a6c88576d8b418bf1c8616d5e410a20

Cheers,
Ferdy

--=20
Fernando J. Pereda Garcimart=EDn
Gentoo Developer (Alpha,net-mail,mutt,git)
20BB BDC3 761A 4781 E6ED  ED0B 0A48 5B0C 60BD 28D4

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD8FhjCkhbDGC9KNQRAuyeAJ9wnMexeF+fR78QTc42XSuwyDM81wCePQm3
qa45PwL+98yPF83i3jgAOZI=
=ESh8
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
