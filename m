From: martin f krafft <madduck@debian.org>
Subject: [gitolite] symlink hooks instead of copying them
Date: Thu, 4 Feb 2010 09:47:23 +1300
Organization: The Debian project
Message-ID: <20100203204723.GA30157@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
To: git discussion list <git@vger.kernel.org>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Teemu Matilainen <teemu.matilainen@iki.fi>
X-From: git-owner@vger.kernel.org Wed Feb 03 21:58:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcmIp-0006Kp-L6
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 21:58:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932892Ab0BCU6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 15:58:18 -0500
Received: from clegg.madduck.net ([193.242.105.96]:51386 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932343Ab0BCU6R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 15:58:17 -0500
Received: from lapse.rw.madduck.net (lapse.nz.madduck.net [IPv6:2001:4428:234::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 38C091D409E;
	Wed,  3 Feb 2010 21:47:26 +0100 (CET)
Received: by lapse.rw.madduck.net (Postfix, from userid 1000)
	id 21336FF; Thu,  4 Feb 2010 09:47:23 +1300 (NZDT)
Content-Disposition: inline
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux squeeze/sid kernel 2.6.32-trunk-686 i686
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.95.3 at clegg
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138897>


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear Sitaram, dear Teemo, dear gitolite-fans,

Gitolite currently copies hooks to repositories. For upgrades, it
must thus ensure that all hooks are also upgraded.

It occurs to me that this might be easier done using symlinks, or
with a file that includes the master hook(s) in
~/.gitolite/src/hooks. Then, the hooks just have to be upgraded in
one place.

Do you see a reason not to do this via symlinks?

--=20
 .''`.   martin f. krafft <madduck@d.o>      Related projects:
: :'  :  proud Debian developer               http://debiansystem.info
`. `'`   http://people.debian.org/~madduck    http://vcs-pkg.org
  `-  Debian - when you have better things to do than fixing systems
=20
"we are trapped in the belly of this horrible machine,
 and the machine is bleeding to death."
                                        -- godspeed you black emperor!

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEAREDAAYFAktp4NoACgkQIgvIgzMMSnWPwwCfZHX6wzOi6vt7TJPZMDmn6XWJ
2IQAoK0G96n0ioxWcbqx1+5DZ+hTRHOW
=RY7J
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
