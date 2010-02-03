From: martin f krafft <madduck@debian.org>
Subject: [gitolite] repo config for delegated projects
Date: Thu, 4 Feb 2010 09:22:49 +1300
Organization: The Debian project
Message-ID: <20100203202249.GA27125@lapse.rw.madduck.net>
References: <20100203035718.GA30644@lapse.rw.madduck.net>
 <2e24e5b91002022222h5ca3ebe6k75854a9a056f0ed1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Teemu Matilainen <teemu.matilainen@iki.fi>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 03 21:23:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nclko-0004Ad-HV
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 21:23:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757894Ab0BCUXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 15:23:10 -0500
Received: from clegg.madduck.net ([193.242.105.96]:47341 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757687Ab0BCUXG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 15:23:06 -0500
Received: from lapse.rw.madduck.net (lapse.nz.madduck.net [IPv6:2001:4428:234::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 7015A1D40A1;
	Wed,  3 Feb 2010 21:22:52 +0100 (CET)
Received: by lapse.rw.madduck.net (Postfix, from userid 1000)
	id 41D1BFF; Thu,  4 Feb 2010 09:22:49 +1300 (NZDT)
Mail-Followup-To: git discussion list <git@vger.kernel.org>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Teemu Matilainen <teemu.matilainen@iki.fi>
Content-Disposition: inline
In-Reply-To: <2e24e5b91002022222h5ca3ebe6k75854a9a056f0ed1@mail.gmail.com>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux squeeze/sid kernel 2.6.32-trunk-686 i686
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.95.3 at clegg
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138883>


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear Sitaram, dear Teemo, dear gitolite-fans,

src/gl-compile-conf:261 prohibits delegated repositories to make use
of the functionality to configure config variables of the
repositories:

  die "$WARN $fragment attempting to set repo configuration\n"
    if $fragment ne 'master';

This is a bit unfortunate and makes me reconsider the use of
delegations.

What is the reason for this restriction?

Are there settings that are potentially compromising?

Would it be worth to consider making it configurable (e.g.
~/.gitolite.rc) whether to allow delegated repos to set config
variables?

--=20
 .''`.   martin f. krafft <madduck@d.o>      Related projects:
: :'  :  proud Debian developer               http://debiansystem.info
`. `'`   http://people.debian.org/~madduck    http://vcs-pkg.org
  `-  Debian - when you have better things to do than fixing systems
=20
"there are two major products that come out of berkeley: lsd and unix."
 one caused me an addiction
                                                             -- fyodor

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEUEAREDAAYFAktp2xkACgkQIgvIgzMMSnUO2ACXXlfoaVTHnoSolI5wWh//NctT
bACggqO7LiMhtd8Bfxy/kDjbMmnXycs=
=I64H
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
