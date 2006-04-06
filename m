From: Keith Packard <keithp@keithp.com>
Subject: Re: Fixes to parsecvs
Date: Thu, 06 Apr 2006 10:36:19 -0700
Message-ID: <1144344979.2303.263.camel@neko.keithp.com>
References: <1144305392.2303.240.camel@neko.keithp.com>
	 <20060406120812.GO13324@lug-owl.de>
	 <1144334896.2303.259.camel@neko.keithp.com>
	 <Pine.LNX.4.63.0604061723410.23681@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-LpVYTEpkxNrvW7CEVxvM"
Cc: keithp@keithp.com, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 06 19:37:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRYPn-0006jR-P1
	for gcvg-git@gmane.org; Thu, 06 Apr 2006 19:37:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWDFRgw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Apr 2006 13:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWDFRgw
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Apr 2006 13:36:52 -0400
Received: from home.keithp.com ([63.227.221.253]:50954 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1751248AbWDFRgv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Apr 2006 13:36:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 7B6DC130020;
	Thu,  6 Apr 2006 10:36:50 -0700 (PDT)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 13405-03-4; Thu, 6 Apr 2006 10:36:50 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id 3424613001F; Thu,  6 Apr 2006 10:36:50 -0700 (PDT)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id BF8DB14001;
	Thu,  6 Apr 2006 10:36:49 -0700 (PDT)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id 9CBFF543DB; Thu,  6 Apr 2006 10:36:20 -0700 (PDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0604061723410.23681@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Evolution 2.4.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18475>


--=-LpVYTEpkxNrvW7CEVxvM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-04-06 at 17:26 +0200, Johannes Schindelin wrote:

> Keep in mind that there are many more valid uses for tracking a CVS=20
> repository than to import it once.

Sure, but we should fix parsecvs to handle incremental CVS tracking if
that's one of the goals for this utility. git-cvsimport does this by
skipping commits earlier than a fixed time; if we did that, we'd
eliminate the huge memory usage except for initial imports. I haven't
considered how this might be done in detail yet; I have no personal need
for this functionality.

--=20
keith.packard@intel.com

--=-LpVYTEpkxNrvW7CEVxvM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBENVGTQp8BWwlsTdMRAuj0AKDNEzEX27CZ1t/N4KbzuMZ/+PGf9ACdG7Pk
F00EPM7wRs4Ee/svadyDXWk=
=DSXX
-----END PGP SIGNATURE-----

--=-LpVYTEpkxNrvW7CEVxvM--
