From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: commit takes 8 secs; but instant when offline - can I fix this?
Date: Sun, 2 Nov 2008 15:13:56 +0100
Message-ID: <200811021514.00057.trast@student.ethz.ch>
References: <1225634894605-1445352.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5402581.by7yQ21afJ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: 13ren <melbourne.research@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 02 15:15:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwdjV-0003jp-L0
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 15:15:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753398AbYKBOOA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 09:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753385AbYKBON7
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 09:13:59 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:51271 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753384AbYKBON7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 09:13:59 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 2 Nov 2008 15:13:57 +0100
Received: from [192.168.0.8] ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 2 Nov 2008 15:13:56 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <1225634894605-1445352.post@n2.nabble.com>
X-OriginalArrivalTime: 02 Nov 2008 14:13:56.0723 (UTC) FILETIME=[3E55BC30:01C93CF5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99844>

--nextPart5402581.by7yQ21afJ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

13ren wrote:
> With the network plugged in, git-commit takes 8 seconds.
>=20
> When I unplug the network, commit is instant...

Configure your user.email (and user.name), see man git-config.  If the
email is not set, Git tries to figure out your hostname, which
depending on DNS misconfigurations can apparently cause such delays.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch


--nextPart5402581.by7yQ21afJ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkkNtagACgkQqUud07tmzP3wIQCdG+iCBIuAPVZWufz6uHq3IMcv
azsAoIliEg1DLJcOT4GbMO0h48AaI3iy
=HHD4
-----END PGP SIGNATURE-----

--nextPart5402581.by7yQ21afJ--
