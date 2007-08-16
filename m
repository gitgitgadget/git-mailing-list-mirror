From: martin f krafft <madduck@madduck.net>
Subject: Re: using .gitmodule as default (was: git submodule init and
	redundant data in .gitmodules/.git/config)
Date: Thu, 16 Aug 2007 16:21:33 +0200
Message-ID: <20070816142133.GA26013@piper.oerlikon.madduck.net>
References: <20070815162005.GA18463@piper.oerlikon.madduck.net> <20070815163822.GC1070MdfPADPa@greensroom.kotnet.org> <20070815222907.GA7395@piper.oerlikon.madduck.net> <200708161553.10991.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 16 16:22:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILgEZ-0003gU-Uy
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 16:22:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756075AbXHPOVh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 10:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758363AbXHPOVh
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 10:21:37 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:59518 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753553AbXHPOVg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 10:21:36 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id E02F5895F4A
	for <git@vger.kernel.org>; Thu, 16 Aug 2007 16:21:34 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 30973-10 for <git@vger.kernel.org>;
	Thu, 16 Aug 2007 16:21:34 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 9DE9E895F48
	for <git@vger.kernel.org>; Thu, 16 Aug 2007 16:21:34 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id D15679F171
	for <git@vger.kernel.org>; Thu, 16 Aug 2007 16:21:33 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 9A41643F9; Thu, 16 Aug 2007 16:21:33 +0200 (CEST)
Mail-Followup-To: git discussion list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200708161553.10991.Josef.Weidendorfer@gmx.de>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56016>


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Josef Weidendorfer <Josef.Weidendorfer@gmx.de> [2007.08.16.1553=
 +0200]:
> The information in .gitmodules is only a default value for the
> URL, and not to be actually used. The URL in the config has to
> exist and will be used for updating. So the config value is not
> about overriding anything, but is required information.

It's not required for git-submodule status.

> The URL should not depend on the current revision you have checked
> out at the moment; otherwise, if the default URL in .gitmodules
> changed at some point in the history, and you check out some
> earlier commit in the superproject, the update of the submodule
> would not work: the submodule project still resides on the new
> URL, regardless of the old information in .gitmodules at the time
> of the old commit.

Fair point. Thanks,

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
"heuristic is computer science jargon for 'doesn't actually work.'"
                                                     -- charlie reiman
=20
spamtraps: madduck.bogus@madduck.net

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGxF1tIgvIgzMMSnURAsm9AJ9bvLxIcC3KSAGTAUZM35KIYn99yACeOCrV
7vRW/wbBa+ay/VkwfPZKXL8=
=bT9u
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
