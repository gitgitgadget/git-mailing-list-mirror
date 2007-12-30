From: Jan Hudec <bulb@ucw.cz>
Subject: Re: How to bypass the post-commit hook?
Date: Sun, 30 Dec 2007 22:50:08 +0100
Message-ID: <20071230215008.GB20098@efreet.light.src>
References: <46dff0320712300712l78c1cdaeya5fa105be01f6b74@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
Cc: Git Mailing List <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 30 22:50:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J963Q-0001uJ-IQ
	for gcvg-git-2@gmane.org; Sun, 30 Dec 2007 22:50:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753215AbXL3VuT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2007 16:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752095AbXL3VuS
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Dec 2007 16:50:18 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:51029 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751132AbXL3VuR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2007 16:50:17 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id E2DDB573ED;
	Sun, 30 Dec 2007 22:50:15 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id JeZLgKVGK3QS; Sun, 30 Dec 2007 22:50:13 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id E34C55733D;
	Sun, 30 Dec 2007 22:50:12 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1J962q-00012d-Te; Sun, 30 Dec 2007 22:50:08 +0100
Content-Disposition: inline
In-Reply-To: <46dff0320712300712l78c1cdaeya5fa105be01f6b74@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69380>


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 30, 2007 at 23:12:12 +0800, Ping Yin wrote:
> --no-verify can bypass pre-commit hook? Then how to bypass post-commit ho=
ok?
>=20
> Usually I want post-commit take effect. However, in the middle of
> git-rebase, i want to bypass post-commit when 'git-commit --amend'
> since my post-commit hooks will modify the working directory and so
> make following rebase troubesome.

There does not seem to be an option to do it, but you can always temporarily
disable it (unset the executable permission on it).

By the way, what is your post-commit hook doing anyway? Modifying the work
tree *after* a commit does not sound like a common thing to do.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHeBKQRel1vVwhjGURAoKmAJ94mYlx7chUulmeaUC01ma4YEuBiwCg4jlm
lN9kTUyWhROD7XZkBgy7nmw=
=GRB2
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--
