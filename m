From: martin f krafft <madduck@madduck.net>
Subject: gitweb fails with pathinfo and project with ++ in the name
Date: Sun, 20 Apr 2008 16:46:54 +0200
Message-ID: <20080420144654.GA11479@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Cc: 476076@bugs.debian.org
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 20 16:47:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jnaph-0000j0-6D
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 16:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429AbYDTOrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 10:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752821AbYDTOrK
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 10:47:10 -0400
Received: from clegg.madduck.net ([82.197.162.59]:41539 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691AbYDTOrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 10:47:09 -0400
Received: from wall.oerlikon.madduck.net (84-75-148-163.dclient.hispeed.ch [84.75.148.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id 5156EA80FF;
	Sun, 20 Apr 2008 16:46:55 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 7567A9F18E;
	Sun, 20 Apr 2008 16:46:54 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 2C94BC1757; Sun, 20 Apr 2008 16:46:54 +0200 (CEST)
Content-Disposition: inline
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.24-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Virus-Scanned: ClamAV 0.91.2/6847/Sun Apr 20 16:14:42 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79958>


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

please have a look at http://git.madduck.net/v/code/libfactory++.git
or http://git.madduck.net/v/code/libfactory%2b%2b.git.

I narrowed this down to the first line of CGI.pm's path_info sub:

  my ($self,$info) =3D self_or_default(@_);

but then my perl-foo wouldn't take me further.

gitweb works fine if I turn off pathinfo, but when it's turned on,
it cannot deal with two ++ in the name of projects.

The bug seems to be in CGI.pm, and I now wonder what to do about it.

Please keep the bug address <476076@bugs.debian.org> in Cc.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"the association on this web site and in peter chappell
 publications, articles and books, made between remedy and diseases
 is used for clarity, but is not the functional reality and does not
 imply these resonances treat any disease. they merely vitalise and
 inform the self healing system."
                                                   -- peter chappell
=20
spamtraps: madduck.bogus@madduck.net

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIC1dZIgvIgzMMSnURAoOPAKDuGSj0rA93MEskjekomFJ4gWTP5ACfYzPG
1xPqMiIzq4yHLMU5fv4O5RM=
=3Ytb
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
