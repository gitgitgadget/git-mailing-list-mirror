From: martin f krafft <madduck@madduck.net>
Subject: hiding a certain file from gitweb
Date: Tue, 21 Aug 2007 21:02:25 +0200
Message-ID: <20070821190225.GA7133@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 21 21:02:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INYzq-0005co-RM
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 21:02:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758187AbXHUTCa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 15:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755054AbXHUTCa
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 15:02:30 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:52446 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754851AbXHUTC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 15:02:29 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id 48256895D93
	for <git@vger.kernel.org>; Tue, 21 Aug 2007 21:02:28 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 23786-02 for <git@vger.kernel.org>;
	Tue, 21 Aug 2007 21:02:28 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id DF61D895D82
	for <git@vger.kernel.org>; Tue, 21 Aug 2007 21:02:27 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id C42819F16A
	for <git@vger.kernel.org>; Tue, 21 Aug 2007 21:02:26 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id DEE7B43F4; Tue, 21 Aug 2007 21:02:25 +0200 (CEST)
Content-Disposition: inline
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56323>


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear list,

one of my colleagues checked a file with thousands of email
addresses into git and pushed the commit, so now the file is on
gitweb. This was quite a while ago and we have over 500 commits and
several branches between now and then. We want to open our gitweb to
the public, but to do that, I need to somehow ensure that the file's
content is not available via gitweb, or else the spammers will have
a feast. Is it possible to somehow hide the file from gitweb but
keep it in the repo?

Alternatively, would a patch against gitweb be considered, which
obfuscated email addresses? Or would that interfere with the world
=E2=80=94 I note that e.g. ikiwiki's git configuration requires you to
specify the gitweb URL (and not a repo URL).

Cheers,

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
"common sense is the collection of prejudices
 acquired by age eighteen."
                                                    -- albert einstein
=20
spamtraps: madduck.bogus@madduck.net

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGyzbBIgvIgzMMSnURAk10AKCqOvAWj6T+370n0a1zEr5NZstGGQCgqCpc
Kx36s/nvQs9HNldC9VP97oc=
=ymzw
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
