From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Worktree vs. working copy
Date: Tue, 20 Sep 2011 09:50:08 +0200
Message-ID: <1316505022.13996.12.camel@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-oGckTu67cOr9uisPRhak"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 09:50:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5v65-0007WD-LB
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 09:50:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753144Ab1ITHuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 03:50:24 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:53252 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750986Ab1ITHuY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 03:50:24 -0400
Received: from [10.10.10.234] (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id B68DA4617B
	for <git@vger.kernel.org>; Tue, 20 Sep 2011 09:50:02 +0200 (CEST)
X-Mailer: Evolution 3.0.3- 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181736>


--=-oGckTu67cOr9uisPRhak
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I've noticed that in some places in git.git, the term 'working copy' is
used. Mostly it's in git-cvsserver which I guess it's fine, but the
git-config man page talks about the 'working copy' in three places.

    $ git grep 'worktree' | wc -l
    412
    $ git grep 'working copy' | grep -v ^git-cvsserver |  wc -l
    32

Most of the references to a 'working copy' are in Git.pm, and the
git-gui glossary treats them as the same thing.

Is there some sort of official position, or rough agreement that we
should use woktree instead of working copy? The latter term IMHO implies
a centralised system, where an user gets a copy.

   cmn

--=-oGckTu67cOr9uisPRhak
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOeEWxAAoJEHKRP1jG7ZzTp3QH/2vrV+wJGnScSfKHdmwZWV5+
KhP75YB3EVo8qI3BwajGhXjgiAYCgwpwSfl3C3stZE5RUO17ESr1aCWkXw0jy2e+
Z3eQXvIDfvkyQYan+TV/2mIQ293jbiAlI8FHXeEIUPEy4QJ42vL6T/aj2kQwEPui
H39RoGwniYk5GbNBEXKbAkWQKdMzghe7TLY3ntE/bDZp/+h6Qe4/Sa/d7RJaNO3V
TCua20EgrR3SL99rS77FNNgr3TE07xSvG1NwNJYUNrUcF85BYmNQ5Twabx7u5yjN
wlvl6kgbADbxqksL2jeMMue0zg0CpHBtZakScDR9kfdKjyp/3BDnf5l8J0Sm/aM=
=Odls
-----END PGP SIGNATURE-----

--=-oGckTu67cOr9uisPRhak--
