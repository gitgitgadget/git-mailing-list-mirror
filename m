From: Hugo Roy <hugo@fsfe.org>
Subject: [bug report] Signing your work: GnuPG signing failed (gpg version
 2.1)
Date: Wed, 5 Aug 2015 22:35:45 +0200
Message-ID: <20150805203545.GD4325@xps>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LTeJQqWS0MN7I/qa"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 22:41:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZN5Uv-0001NO-Lf
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 22:41:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753250AbbHEUlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 16:41:08 -0400
Received: from cavendish.fsfeurope.org ([217.69.89.162]:42825 "EHLO
	cavendish.fsfeurope.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752577AbbHEUlH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 16:41:07 -0400
X-Greylist: delayed 314 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Aug 2015 16:41:07 EDT
Received: from localhost (localhost [127.0.0.1])
	by cavendish.fsfeurope.org (Postfix) with ESMTP id 2E80F63B5FA
	for <git@vger.kernel.org>; Wed,  5 Aug 2015 22:35:58 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at cavendish
Received: from cavendish.fsfeurope.org ([127.0.0.1])
	by localhost (cavendish.fsfeurope.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kKTVB9y4Urmw for <git@vger.kernel.org>;
	Wed,  5 Aug 2015 22:35:55 +0200 (CEST)
Received: from localhost (unknown [IPv6:2a01:e35:8beb:ba0:3e77:e6ff:fe18:ed03])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: hugo)
	by cavendish.fsfeurope.org (Postfix) with ESMTPSA id 8307063B50C
	for <git@vger.kernel.org>; Wed,  5 Aug 2015 22:35:55 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275394>


--LTeJQqWS0MN7I/qa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hello,

I've tried to sign a commit following
https://git-scm.com/book/tr/v2/Git-Tools-Signing-Your-Work however,
this is what happened:

    % git commit -a -S -m "signed commit testing"
    gpg: =C3=A9chec de la signature : Op=C3=A9ration annul=C3=A9e
    gpg: signing failed: Op=C3=A9ration annul=C3=A9e
    error: gpg n'a pas pu signer les donn=C3=A9es
    fatal: =C3=A9chec de l'=C3=A9criture de l'objet commit

sorry for the locale, "annul=C3=A9e" means cancelled and the last two
lines mean:

    error: gpg could not sign data
    fatal: failure to write the commit object

However, when I tried later, nothing specific happened and the commit
was done just as if I did not add the -S option:

    % git commit -a -S -m "signed commit test"
    [master 739cdd3] signed commit test
    1 file changed, 5 deletions(-)

Commit:
https://github.com/hugoroy/.emacs.d/commit/b8e5b72def0c5fcc760c84d6ecd2b95b=
9727ae62



I notice in the git-scm.com manual that they use GnuPG version 1. I
use GnuPG 2.1.6 with libgcrypt 1.6.3.

Let me know if you need more information or any pointer to help me
debug this more in depth.

thanks,
Hugo


--=20
Hugo Roy =E2=80=93 Free Software Foundation Europe https://fsfe.org/about/r=
oy
=20
Please use cryptography for email: see https://emailselfdefense.fsf.org/en/
Merci d=E2=80=99utiliser la cryptographie pour l=E2=80=99email=C2=A0: voir =
https://emailselfdefense.fsf.org/fr/

--LTeJQqWS0MN7I/qa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJVwnOgAAoJEI0CLJmz17eVzFIH/2viiqYVvL0Ftz3ykvqK1evN
DEJWe1FAuCumVY0PtjpM1Y2talrjyhspNtofCMAwjft9NiM27DNWevgL7tjTKPMC
1e21fUBAUKbOO42fJ1+g1Ce3LcYbwzU9sjZ8CuSUKBkhmnu/IxtgMxuOlCejdR8L
C+wk+/MWGub7Nixt9o1Q/MN+/Q5CAp+280ejS6QXPE69QTqWrOojtI+sF9W2SrnT
x0XqICQk89F2/b/fvqW2pZnOLCVZT5dyXj6+z2IVYRJe4jFj0JzN5ePz32hkHdQU
u9lcCPUJXycSqezJ+bMYA9FSz03jQjJq+ZNHZnmbXGh7ly4BJYOcbHT+7k3pOrw=
=+t6e
-----END PGP SIGNATURE-----

--LTeJQqWS0MN7I/qa--
