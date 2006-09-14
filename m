From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH 2/2] Handle invalid argc gently
Date: Thu, 14 Sep 2006 17:16:26 +0400
Message-ID: <20060914131626.GE6709@basalt.office.altlinux.org>
References: <20060914010409.GB20593@nomad.office.altlinux.org> <7vu03b5k0t.fsf@assigned-by-dhcp.cox.net> <20060914013146.GD7044@basalt.office.altlinux.org> <7vpsdz5542.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jKBxcB1XkHIR0Eqt"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 14 15:17:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNr51-00047p-3D
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 15:16:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWINNQ3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 09:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbWINNQ3
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 09:16:29 -0400
Received: from mh.altlinux.org ([217.16.24.5]:64234 "EHLO mh.altlinux.org")
	by vger.kernel.org with ESMTP id S932077AbWINNQ2 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Sep 2006 09:16:28 -0400
Received: from basalt.office.altlinux.org (localhost.localdomain [127.0.0.1])
	by mh.altlinux.org (Postfix) with ESMTP
	id AC776382CC44; Thu, 14 Sep 2006 17:16:26 +0400 (MSD)
Received: by basalt.office.altlinux.org (Postfix, from userid 501)
	id C87E0B0D90; Thu, 14 Sep 2006 17:16:26 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vpsdz5542.fsf@assigned-by-dhcp.cox.net>
X-fingerprint: FE4C 93AB E19A 2E4C CB5D  3E4E 7CAB E6AC 9E35 361E
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26998>


--jKBxcB1XkHIR0Eqt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2006 at 11:34:05PM -0700, Junio C Hamano wrote:
> "Dmitry V. Levin" <ldv@altlinux.org> writes:
> > On Wed, Sep 13, 2006 at 06:12:02PM -0700, Junio C Hamano wrote:
> >> "Dmitry V. Levin" <ldv@altlinux.org> writes:
> >>=20
> >> > describe, git: Handle argc=3D=3D0 case the same way as argc=3D=3D1.
> >>=20
> >> When does one get (ac =3D=3D 0)?
> >
> > When one executes something like
> > execlp("git", NULL, NULL);
>=20
> Fair enough.
>=20
> What is the valid reason to do execlp("git", NULL, NULL)?

Personally I do not plan to execute git this way on regular basis, indeed. =
:)

But argc =3D=3D 0 is allowed, so why should git crash?


--=20
ldv

--jKBxcB1XkHIR0Eqt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFCVYqfKvmrJ41Nh4RAto6AJ9+hG6ja3uSgnFn4ZnHKyqf3PC4nACgsDrO
kgof/2B/LUc1UNWRjIRyCOk=
=AjKa
-----END PGP SIGNATURE-----

--jKBxcB1XkHIR0Eqt--
