From: Matthias Beyer <mail@beyermatthias.de>
Subject: Why is there no execution of the pre-commit hook while rebasing?
Date: Thu, 13 Feb 2014 19:15:04 +0100
Message-ID: <20140213181504.GC28173@fu.3gs>
Reply-To: Matthias Beyer <mail@beyermatthias.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O3RTKUHj+75w1tg5"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 13 19:23:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WE0wF-0008A6-Lr
	for gcvg-git-2@plane.gmane.org; Thu, 13 Feb 2014 19:23:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722AbaBMSXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Feb 2014 13:23:00 -0500
Received: from libra.uberspace.de ([95.143.172.171]:42628 "HELO
	libra.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752540AbaBMSW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Feb 2014 13:22:59 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Feb 2014 13:22:59 EST
Received: (qmail 30521 invoked from network); 13 Feb 2014 18:16:17 -0000
Received: from unknown (HELO localhost) (141.28.134.26)
  by libra.uberspace.de with SMTP; 13 Feb 2014 18:16:17 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242070>


--O3RTKUHj+75w1tg5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I'm wondering why there is no execution of the pre-commit hook when
rebasing.

When I do a rebase of N commits (say, 3 or so) onto another branch,
each of the rebased commits gets "recommitted" to the branch, am I
right?

If yes, wouldn't it make sense to run the pre-commit hook after each
applied commit?

Just wondering...

--=20
Mit freundlichen Gr=FC=DFen,
Kind regards,
Matthias Beyer

Proudly sent with mutt.
Happily signed with gnupg.

--O3RTKUHj+75w1tg5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS/QuoAAoJEJi+S08gyg+UipkQANIMQTp/7VAfQGaYtP2kOkk4
1/aKhbgYA1tUOtp5HEdPIQ3Poq1oIVNkPb4fL7AohxwftQqfY7dIDdT3c8QTisn5
di+thTeuTaVKkzqnX4Tee7aYGgsmJU/KOwLs/LjbUHk2qnj9ldkvzqTvFM7JdZ7H
3AqOBO3OZN8gK6M1B+XqZEegbgYA/E15vofKh1xr8Px6k9zkQX943xN6/xLyohPE
tMBQFQHm0RWPfYY7bX4F1yLIfv7W1bDo5iFBlBrV8sWYAeSSXge7WIKMfbnm353P
XL098lIN8VPdI4oyGXw1plCFSDelW8txWFT3bDu6c3q4tYSMhdHQTM+NQtef1MRw
yKKIobcn3gpjvndlQmmywjBV1+3J3VC5JMxUxpLMvQyYRTmdvvifKmdIo6d3GGER
Z6b0NiJpt9Zzxg8zBmSfBJ3agb2a2sTSzjAAelp/fRlXvKQtioPXYSFAcKRWELAj
sVuPxqf9GyIbiGT5VA2cAIkIYZeISGwaFWUrS0fd1vX9kP/m85apgzleUX7cb2iL
8DS5B5qNHa1Bm9OO/XpRCyS1eGkbqM799p5Yovp6UfPPq6oH+x0gOSfBNZ31Qd0C
fDE/e2/ogKayLW3/NtZ3mwlNRqhZJezRK+td3QlAv5FFJ4rGFLlrbycOuvnRpy7W
Geam1mbua7ghfD+Coe6T
=CT8d
-----END PGP SIGNATURE-----

--O3RTKUHj+75w1tg5--
