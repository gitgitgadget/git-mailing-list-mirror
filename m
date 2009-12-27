From: Nathaniel W Filardo <nwf@cs.jhu.edu>
Subject: Re: [RESEND] [PATCH] Endianness bug in index cache logic
Date: Sun, 27 Dec 2009 11:12:46 -0500
Message-ID: <20091227161246.GQ14941@gradx.cs.jhu.edu>
References: <20091204202928.GW17192@gradx.cs.jhu.edu> <20091227061121.GP14941@gradx.cs.jhu.edu> <40aa078e0912270439i3948a38fw9784e23e7cdc4407@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oDto3OTLsk6uOlQH"
Cc: Nathaniel W Filardo <nwf@cs.jhu.edu>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Sun Dec 27 17:13:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NOvkB-00060Y-Qx
	for gcvg-git-2@lo.gmane.org; Sun, 27 Dec 2009 17:13:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752291AbZL0QNS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Dec 2009 11:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752248AbZL0QNS
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Dec 2009 11:13:18 -0500
Received: from blaze.cs.jhu.edu ([128.220.13.50]:53219 "EHLO blaze.cs.jhu.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751915AbZL0QNR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Dec 2009 11:13:17 -0500
Received: from gradx.cs.jhu.edu (gradx.cs.jhu.edu [128.220.13.52])
	by blaze.cs.jhu.edu (8.14.3/8.14.3) with ESMTP id nBRGCkJX007809
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 27 Dec 2009 11:12:46 -0500 (EST)
Received: from gradx.cs.jhu.edu (localhost.localdomain [127.0.0.1])
	by gradx.cs.jhu.edu (8.14.2/8.13.1) with ESMTP id nBRGCktv022851;
	Sun, 27 Dec 2009 11:12:46 -0500
Received: (from nwf@localhost)
	by gradx.cs.jhu.edu (8.14.2/8.13.8/Submit) id nBRGCkkh022850;
	Sun, 27 Dec 2009 11:12:46 -0500
Content-Disposition: inline
In-Reply-To: <40aa078e0912270439i3948a38fw9784e23e7cdc4407@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135705>


--oDto3OTLsk6uOlQH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 27, 2009 at 01:39:24PM +0100, Erik Faye-Lund wrote:
> On Sun, Dec 27, 2009 at 7:11 AM, Nathaniel W Filardo <nwf@cs.jhu.edu> wro=
te:
> > I got some free time and tracked it down. =A0The following one-line del=
ta
> > fixes this issue for me; AIUI on sparc64 "unsigned long" is 8 bits and =
in
>=20
> You mean 8 bytes, right?

Yes, sorry.  How embarrassing. :)
--nwf;

--oDto3OTLsk6uOlQH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAks3h34ACgkQTeQabvr9Tc/qUwCfXgJxh9wFTc9YOEituzwen9Es
684Aniy1j16TLyWHupKbkfppUzTCazKb
=aFLH
-----END PGP SIGNATURE-----

--oDto3OTLsk6uOlQH--
