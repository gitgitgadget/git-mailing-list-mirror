From: Joey Hess <joey@kitenet.net>
Subject: fully deepening a shallow clone
Date: Mon, 16 Aug 2010 20:49:05 -0400
Message-ID: <20100817004905.GA8305@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 17 04:29:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlBvZ-0005r3-Pu
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 04:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754498Ab0HQC3T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Aug 2010 22:29:19 -0400
Received: from wren.kitenet.net ([80.68.85.49]:48871 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753277Ab0HQC3T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Aug 2010 22:29:19 -0400
X-Greylist: delayed 617 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Aug 2010 22:29:19 EDT
Received: from gnu.kitenet.net (dialup-4.153.253.215.Dial1.Atlanta1.Level3.net [4.153.253.215])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id AE0ED119042
	for <git@vger.kernel.org>; Mon, 16 Aug 2010 22:19:00 -0400 (EDT)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id C82F140B77; Mon, 16 Aug 2010 20:49:05 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153685>


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

git-pull(1):
       --depth=3D<depth>
           Deepen the history of a shallow repository created by git clone
           with --depth=3D<depth> option (see git-clone(1)) by the specified
           number of commits.

Well, what if I want to deepen an existing shallow clone to include
the full history? In practice, something like --depth=3D100000000 is going
to work, but in theory, that will eventually fail some day when there are
enough commits. :)

--=20
see shy jo

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUBTGncfckQ2SIlEuPHAQj5gRAAnpPV/GqGLGo1IlUzR22y9e3oEFJZvmTX
a9E0ZVLB+p63/Pk5KH8iHzgDPqc8FVZtmpOar+Ga9PIiAje6oN7Ps7eRzgUzKZAZ
D3aeh9g0ArrY0vZozvBFhQ9TT39v0AK0wlyrBy+KECj0D3l4eORywhZNo3L7KG7r
s5vhOSgNXu6lD+/NC26k7Bg2+6+a4V4Dn/QtwZMCgDEIDnhdNz6KucPex9magR23
DCrsjtmXff0odBoxGK4VKzILQMRgZBI/NV+/UZW5rVWoq+sP9ksTJDGfWurHyrg0
TdM2A/fwJnuPya6ObTEeLVOVbctdQ0h5COcInhHtWv9nO0MRBmIF3vKOZ5+WFhuN
QpjoTAB3BNfXNeI93F1Q1OVdbduSnYEbGezqLFAFxv7CyrMa6uRw3uwttyW1vEuy
Y+EZU9JHaeQxNd9AjvT69KvX+i9202MUYkUUuKJwWZ1eb2jo4DNQuDExXQEGiF2x
HiyjdGZsMPIgTqXutZ7zoj6qo0mGMtLpnP5O9c7wkLB0CpS1XtM43GHKQgxP90GB
+BRi/u9j20c0nuLvV+f9ECcdQDkBmI4GGC8l2pMqnRogIS4soGYzVDwiWEJFrEXP
Dc8UCFdQlqSBvbhXOsCxfdGHJevi8u6DDq4Gd1M7VIJJXIirIWUtpykP2XtklsTs
tfuZLfHdixE=
=r9M8
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
