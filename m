From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH] Add example xinetd(8) configuration to Documentation/everyday.txt
Date: Mon, 5 Jun 2006 04:01:44 +0400
Message-ID: <20060605000144.GA12641@basalt.office.altlinux.org>
References: <11494652252294-git-send-email-vonbrand@inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 05 02:02:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fn2XV-0006v0-NW
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 02:01:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbWFEABr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 20:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWFEABq
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 20:01:46 -0400
Received: from mh.altlinux.org ([217.16.24.5]:13500 "EHLO mh.altlinux.org")
	by vger.kernel.org with ESMTP id S932339AbWFEABq (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Jun 2006 20:01:46 -0400
Received: from basalt.office.altlinux.org (localhost.localdomain [127.0.0.1])
	by mh.altlinux.org (Postfix) with ESMTP
	id C19095F406; Mon,  5 Jun 2006 04:01:44 +0400 (MSD)
Received: by basalt.office.altlinux.org (Postfix, from userid 501)
	id 7B856B0D91; Mon,  5 Jun 2006 04:01:44 +0400 (MSD)
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Content-Disposition: inline
In-Reply-To: <11494652252294-git-send-email-vonbrand@inf.utfsm.cl>
X-fingerprint: FE4C 93AB E19A 2E4C CB5D  3E4E 7CAB E6AC 9E35 361E
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21297>


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 04, 2006 at 07:53:45PM -0400, Horst H. von Brand wrote:
> Many Linux distributions use xinetd(8), not inetd(8).
> Give a sample configuration file.
[...]
> @@ -377,6 +377,29 @@ git	stream	tcp	nowait	nobody \
[...]
> +        user            =3D root
> +        server          =3D /usr/bin/git-daemon

It is a bad advice to run git-daemon as root.


--=20
ldv

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEg3RofKvmrJ41Nh4RAh/gAKCnW0xW2l0c7OCoBshRnKpQyOZ3/ACeOJqg
lE017n0Pd8RAESzILPJft5E=
=I+LX
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
