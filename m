From: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Subject: Adding push configuration to .git/config
Date: Wed, 21 Nov 2007 11:55:17 +0100
Message-ID: <20071121105517.GA11875@denkbrett.schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 21 12:48:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iuo48-0004JB-96
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 12:48:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757339AbXKULsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 06:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757252AbXKULsE
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 06:48:04 -0500
Received: from natgw.netstream.ch ([62.65.128.28]:35972 "EHLO
	denkbrett.schottelius.org" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754793AbXKULsD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Nov 2007 06:48:03 -0500
X-Greylist: delayed 3149 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Nov 2007 06:48:02 EST
Received: from nico by denkbrett.schottelius.org with local (Exim 4.68)
	(envelope-from <nico-linux-git@schottelius.org>)
	id 1IunEj-0005tm-DM
	for git@vger.kernel.org; Wed, 21 Nov 2007 11:55:17 +0100
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Unix-Info: http://unix.schottelius.org/
X-Netzseite: http://nico.schottelius.org/
X-System-Info: denkbrett running Linux 2.6.23.1-denkbrett on i686
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65632>


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello guys!

We are working pretty much with branches here and I think it would be
pretty cool, to make git-push recognize some configuratio in
~/.git/config that describes where to push what:

   git-push origin master:<name of worker> is what we currenty do
   manually

Nice would be

[branch "master"]
   remote-push          =3D origin
   remote-push-merge    =3D another_branch

And thus perhaps also changing the existing specs:

   remote =3D ... to remote-fetch =3D ...
   merge =3D ... to remote-fetch-merge =3D=20

And perhaps it would also make sense to replace "refs/heads/master" with
only "master"?

What do you think about those three ideas?

Nico

--=20
Think about Free and Open Source Software (FOSS).
http://nico.schottelius.org/documentations/foss/the-term-foss/

PGP: BFE4 C736 ABE5 406F 8F42  F7CF B8BE F92A 9885 188C

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHRA6VuL75KpiFGIwRAngAAJ91qHqODMGsxn4zR9xnSydCUwXgHQCgpHAt
J3e5CfipOKHb570gXJYNLrs=
=vBJS
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
