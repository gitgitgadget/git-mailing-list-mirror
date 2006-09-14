From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH 2/2] Handle invalid argc gently
Date: Thu, 14 Sep 2006 05:31:46 +0400
Message-ID: <20060914013146.GD7044@basalt.office.altlinux.org>
References: <20060914010409.GB20593@nomad.office.altlinux.org> <7vu03b5k0t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fXStkuK2IQBfcDe+"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 14 03:32:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNg51-0002IN-Ds
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 03:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWINBbs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 21:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbWINBbs
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 21:31:48 -0400
Received: from mh.altlinux.org ([217.16.24.5]:64926 "EHLO mh.altlinux.org")
	by vger.kernel.org with ESMTP id S1751325AbWINBbr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Sep 2006 21:31:47 -0400
Received: from basalt.office.altlinux.org (localhost.localdomain [127.0.0.1])
	by mh.altlinux.org (Postfix) with ESMTP
	id 5C9CF382CE8E; Thu, 14 Sep 2006 05:31:46 +0400 (MSD)
Received: by basalt.office.altlinux.org (Postfix, from userid 501)
	id 51CC0B0D90; Thu, 14 Sep 2006 05:31:46 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vu03b5k0t.fsf@assigned-by-dhcp.cox.net>
X-fingerprint: FE4C 93AB E19A 2E4C CB5D  3E4E 7CAB E6AC 9E35 361E
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26972>


--fXStkuK2IQBfcDe+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2006 at 06:12:02PM -0700, Junio C Hamano wrote:
> "Dmitry V. Levin" <ldv@altlinux.org> writes:
>=20
> > describe, git: Handle argc=3D=3D0 case the same way as argc=3D=3D1.
>=20
> When does one get (ac =3D=3D 0)?

When one executes something like
execlp("git", NULL, NULL);


--=20
ldv

--fXStkuK2IQBfcDe+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFCLECfKvmrJ41Nh4RAjF8AKDFwD4MsoKJBhbJ1nL+/fgW5RFhqACgnjU4
nFlYeJv3zo5xBxKbXB8Uhzk=
=P11B
-----END PGP SIGNATURE-----

--fXStkuK2IQBfcDe+--
