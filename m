From: Jason McMullan <jason.mcmullan@timesys.com>
Subject: Re: [PATCH-RFC] Rewrite ls-tree to behave more like "/bin/ls -a"
Date: Sat, 28 May 2005 18:02:08 -0400
Message-ID: <1117317729.11542.32.camel@jmcmullan.timesys>
References: <20050527120851.GA11823@port.evillabs.net>
	 <7vmzqgzg8a.fsf@assigned-by-dhcp.cox.net>
	 <1117221986.11542.29.camel@jmcmullan.timesys>
	 <7v1x7syqkm.fsf@assigned-by-dhcp.cox.net>
	 <7vll5zygn1.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Do8dqdJ7jTUiCivXQdUP"
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 29 00:01:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dc9Lm-0005Lh-AF
	for gcvg-git@gmane.org; Sun, 29 May 2005 00:00:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVE1WCQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 May 2005 18:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVE1WCQ
	(ORCPT <rfc822;git-outgoing>); Sat, 28 May 2005 18:02:16 -0400
Received: from mail.timesys.com ([65.117.135.102]:56435 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261185AbVE1WCK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2005 18:02:10 -0400
Received: from jmcmullan by owa.timesys.com; 28 May 2005 18:02:09 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vll5zygn1.fsf_-_@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.0.4-3mdk 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-Do8dqdJ7jTUiCivXQdUP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-05-28 at 00:05 -0700, Junio C Hamano wrote:
>  - Unlike the old ls-tree behaviour that used paths arguments to
>    restrict output (not that it worked as intended---as pointed
>    out in the mailing list discussion, it was quite incoherent),
>    this rewrite uses paths arguments to specify what to show.
>=20
>  - Without arguments, it implicitly uses the root level as its
>    sole argument ("/bin/ls -a" behaves as if "." is given
>    without argument).
>=20
>  - Without -r (recursive) flag, it shows the named blob (either
>    file or symlink), or the named tree and its immediate
>    children.
>=20
>  - With -r flag, it shows the named path, and recursively
>    descends into it if it is a tree.
>=20
>  - With -d flag, it shows the named path and does not show its
>    children even if the path is a tree, nor descends into it
>    recursively.

This behavior pattern is very agreeable. I'll take it!

Consider your patch:

Signed-Off-By: Jason McMullan <jason.mcmullan@timesys.com>

--=20
Jason McMullan <jason.mcmullan@timesys.com>
TimeSys Corporation


--=-Do8dqdJ7jTUiCivXQdUP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCmOpg8/0vJ5szK6kRAm0ZAJ4+PXooPyMMAyvdw61exsiY9LWQcgCgp/U5
kD28kzyiaELblfgfxlgZheM=
=LIhi
-----END PGP SIGNATURE-----

--=-Do8dqdJ7jTUiCivXQdUP--
