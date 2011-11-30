From: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <carlos@cmartin.tk>
Subject: Re: BUG: "--work-tree blah" does not imply "--git-dir blah/.git" or
 fix misleading error message
Date: Wed, 30 Nov 2011 20:42:33 +0100
Message-ID: <20111130194233.GD12096@centaur.lab.cmartin.tk>
References: <CAEUMa-cA8qPjJuPBREE1RqhgwmcZG7x1MjBYkxa3i+ZSAnMPOA@mail.gmail.com>
 <7vaa7dquva.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DIOMP1UsTsWJauNi"
Cc: John Twilley <mathuin@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 30 20:42:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVq3D-0001DJ-S8
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 20:42:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061Ab1K3Tmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 14:42:35 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:49414 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751567Ab1K3Tme (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 14:42:34 -0500
Received: from centaur.lab.cmartin.tk (brln-4dbc7c68.pool.mediaWays.net [77.188.124.104])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 2696C461A5;
	Wed, 30 Nov 2011 20:41:52 +0100 (CET)
Received: (nullmailer pid 28808 invoked by uid 1000);
	Wed, 30 Nov 2011 19:42:33 -0000
Mail-Followup-To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <carlos@cmartin.tk>,
	Junio C Hamano <gitster@pobox.com>,
	John Twilley <mathuin@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vaa7dquva.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186139>


--DIOMP1UsTsWJauNi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 30, 2011 at 11:21:29AM -0800, Junio C Hamano wrote:
> subdirectory "blah/.git"), but I do not think this is likely to change, as
> I suspect that people and scripts are relying on the current behaviour to
> be able to do something like this:
>=20
>     cd /pub/scm/git/git.git ;# this is a bare repository
>     mkdir /var/tmp/git
>     git --work-tree=3D/var/tmp/git checkout
>=20

This is in fact the way that many (or from what I can see the most
popular) tutorials for abusing git as a deployment system tell you to
run it (though more often than not setting GIT_WORKTREE in the
environment).

   cmn


--DIOMP1UsTsWJauNi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJO1ocpAAoJEHKRP1jG7ZzTBYwH/2nlCwv2wQDmy0CHeYie7LPy
eIHBFyJvOTlDsnpJwurDOdd54V2xGJSFHOAkF4H9UDQY4kmE2wh4Fabboihfnh7D
QbqkjJETOXiYs7dBaDteWE8RzNDzd/qrd/7iKVWz0feat9VFoQXMlR0d5tyPTI3c
Q0Er33kC1VMISa61A7ondfBhDmHJAWpyGBNqq619QYKjpEIOBH93fCnghEQ81Noa
RVYwDO3yBqb9qks7AuXRy4fcNTeZ7f1qSRJKDeKkgWVLWRG21kXUb4Cjfqu9Pj6A
4dUSAOQ7RawPeBnVpKx8zrYL8cOx8Deh06tVFWkr4lLPrcgUg9MC8dPGRYQ89pA=
=MCBQ
-----END PGP SIGNATURE-----

--DIOMP1UsTsWJauNi--
