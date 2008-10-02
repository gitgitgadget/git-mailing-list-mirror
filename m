From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: Git commit hash clash prevention
Date: Thu, 2 Oct 2008 18:04:28 +0200
Message-ID: <20081002160427.GD7288@leksak.fem-net>
References: <20081002085358.GA5342@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Cc: git discussion list <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Thu Oct 02 18:06:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlQgZ-00071L-CR
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 18:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272AbYJBQEc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 12:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753457AbYJBQEc
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 12:04:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:45684 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752205AbYJBQEb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 12:04:31 -0400
Received: (qmail invoked by alias); 02 Oct 2008 16:04:30 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp033) with SMTP; 02 Oct 2008 18:04:30 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1++hRYcxd6+BVgBFfwP0Z8c6N+RU0YVV/NBBMbWly
	GEntY9zWL/fIV5
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KlQfE-0008UV-1z; Thu, 02 Oct 2008 18:04:28 +0200
Content-Disposition: inline
In-Reply-To: <20081002085358.GA5342@lapse.rw.madduck.net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97359>


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

martin f krafft wrote:
> Hi folks,
>=20
> the other day during a workshop on Git, one of the attendants asked
> about the scenario when two developers, Jane and David, both working
> on the same project, both create a commit and the two just so happen
> to have the same SHA-1.

Changing the committer time is the easiest way to solve this problem,
if it ever happens.

I have wondered how Git would behave if there are two files that are
not equal but have the same SHA-1. But I haven't found any such example
files to test this scenario and have not had the time to write or
look for a tool that generates them. (MD5 collisions can be generated
within 2 hours on usual home hardware and even Wikipedia links to
collided files. An intelligent search for SHA-1 collisions takes
2^63 evaluations and not 2^80 (simple birthday attack) as expected.
So it should be possible to find some random collisions and test the
behavior...)

But even if git behaves terrible useless in such situations, it
does not make any sense to guard against them, because in practice
they just do not happen. (And I think such guards will just slow git
down in the usual case.)

Regards,
  Stephan

--=20
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQIVAwUBSOTxC1YyGwbnBMmFAQL6cg/+ID7e+rzepCs2ED8LGnpTADzslr/xzuvi
ZD3eUGiWtpraCfy6OeDhA0GavOnaxHcljE3CfwXcTy/SGLxOJlChnRswn0/dpoVD
IVTJn1R5w6zAb2V+l+kqnwW2jk6UNpixRUSCKVx6xkUZDztqYeOZkLy+ri9iakYd
lAdO3xQ/HjtylkkK+65RgXOc8abHuNAdIbvj1/WsAOqYAQ5IDWKY3TUBL+0eivKv
BmC+ORY5IA39gFYWQ4LJgGQYcCmbxFAcEggsNG8FKBfDweqp5sIi5EzKndtcUrc/
+mMzD5xdD6/H98RylT64NxfQcCwnENa5pVxYAFb+XbIfLikd5kxMmyE6b6YxcXws
gbL6iW1tuXgOT7WQ7Y7tdKlaBwOgc8xQHyhFh49AocjcrIa6xbYr2uOcvBX6LGLI
uL8+qCDVT96KFssdeIaBEgzUYOLvKZ5O+/Q2yKFSCVCYhK/bCMn8rEf7ltFmu2I3
BjQ+Rv8LwqyBdVi/nO0CVjFfffmt/+nvMGaeVROrBkn5WHtParDIxEh6RwuYP4+k
MTixzpfuKvyXguMk0R4IKqv2VLIwIsMGpq+2s+kFLaY/DZun7V5Yb/Xb684Vpqh5
ddAGCyM785CypbJv1M3vWpnMhEwOeJ+Gv7BUaNwpehhmZP9bamjt7egfGkLCVlnK
Z/df9npO0TM=
=QwrL
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--
