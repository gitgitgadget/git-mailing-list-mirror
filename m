From: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Subject: Git on MSys broken
Date: Thu, 26 Feb 2009 20:56:39 +0100
Message-ID: <20090226195639.GB19384@denkbrett.schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 26 20:58:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcmN2-0004Rd-QU
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 20:58:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753528AbZBZT4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 14:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753451AbZBZT4o
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 14:56:44 -0500
Received: from mx3.schottelius.org ([77.109.138.221]:49981 "EHLO
	mx3.schottelius.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753297AbZBZT4n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 14:56:43 -0500
Received: from ikn.ethz.ch (217-162-227-168.dclient.hispeed.ch [217.162.227.168])
	by mx3.schottelius.org (Postfix) with ESMTPSA id BC08B197A056
	for <git@vger.kernel.org>; Thu, 26 Feb 2009 20:56:36 +0100 (CET)
Received: by ikn.ethz.ch (Postfix, from userid 1000)
	id 9758C2E052; Thu, 26 Feb 2009 20:56:39 +0100 (CET)
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Unix-Info: http://unix.schottelius.org/
X-Netzseite: http://nico.schottelius.org/
X-System-Info: ikn (Linux 2.6.29-rc4-ikn-00001-gd5b5623 x86_64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111591>


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

I just wanted to show my father how well git works, but the experience
is rather bad:

All files have a "beta" label, which makes not a really stable impression.
And indeed, when trying to start git bash, we get this error:

c:\Programme\Git\bin>bash
0 [main] us 0 init_cheap: VirtualAlloc pointer is null, Win32 error 487
AllocationBase 0x0, BaseAddress 0x71540000, RegionSize 0x1C0000, State
0x10000
c:\Programme\Git\bin\bash.exe: *** Couldn't reserve space for cygwin's
heap, Win
32 error 6

Well, it's already known, but the the hint from
http://code.google.com/p/msysgit/issues/detail?id=3D133
(found only from
http://code.google.com/p/msysgit/issues/detail?id=3D176)

to install a differnt dll can just be considered a dirty hack.

Sorry msys-guys, the only thing left now is a bad impression.

Nico

--=20
Think about Free and Open Source Software (FOSS).
http://nico.schottelius.org/documentations/foss/the-term-foss/

PGP: BFE4 C736 ABE5 406F 8F42  F7CF B8BE F92A 9885 188C

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmm8/cACgkQuL75KpiFGIwyeACeLO16/ocVfgruW7VXRlUqG7/p
VrQAoKewtdKJO6O/ywKEg/35lAiQFf5V
=hkau
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--
