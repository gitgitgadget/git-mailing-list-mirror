From: martin f krafft <madduck@madduck.net>
Subject: Re: Help a sed noob
Date: Sat, 4 Aug 2007 12:31:26 +0200
Message-ID: <20070804103126.GA28402@lapse.madduck.net>
References: <fcaeb9bf0708031622w25ab6e9ev61372169cfc0bd98@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 12:31:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHGuR-0004qm-3u
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 12:30:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753744AbXHDKax (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 06:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753396AbXHDKax
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 06:30:53 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:49326 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753321AbXHDKaw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 06:30:52 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id 8F52F895D94;
	Sat,  4 Aug 2007 12:30:47 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 24658-10; Sat, 4 Aug 2007 12:30:47 +0200 (CEST)
Received: from lapse.madduck.net (AToulon-256-1-9-110.w86-211.abo.wanadoo.fr [86.211.64.110])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id E9FBC895D93;
	Sat,  4 Aug 2007 12:30:46 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id 24B434FD3D; Sat,  4 Aug 2007 12:31:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0708031622w25ab6e9ev61372169cfc0bd98@mail.gmail.com>
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.21-2-686 i686
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54819>


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Nguyen Thai Ngoc Duy <pclouds@gmail.com> [2007.08.04.0122 +0200=
]:
>                 sed -ne '/^URL: */{
>                         s///p
>                         q
>                 }' "$GIT_DIR/remotes/$1"

Looks like it prints the first matching line:

  grep '^URL: *' | head -1

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
quantum mechanics: the dreams stuff is made of.
=20
spamtraps: madduck.bogus@madduck.net

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGtFV+IgvIgzMMSnURApVKAKCvpdL6G6LRpR0Gktrnuq5i65jaMgCeJ0jS
lbt8lqu6OB8j1Dlz+RyiO88=
=fuSw
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
