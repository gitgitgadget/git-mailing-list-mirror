From: Lisandro =?utf-8?q?Dami=C3=A1n_Nicanor_P=C3=A9rez_Meyer?= 
	<perezmeyer@gmail.com>
Subject: Re: [wishlist] support git flow-like view
Date: Tue, 20 Nov 2012 21:13:36 -0300
Message-ID: <201211202113.44459.perezmeyer@gmail.com>
References: <201211202043.00293.perezmeyer@gmail.com> <CAH5451nrcEo3Uxm0x6b39Hq1k-J4=OZPi-Cao7osaiS-w_Z1+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5383117.rJhINEtHYu";
  protocol="application/pgp-signature";
  micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 01:14:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Taxx6-0008Jm-FY
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 01:14:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344Ab2KUANu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2012 19:13:50 -0500
Received: from mail-yh0-f46.google.com ([209.85.213.46]:50758 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466Ab2KUANt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2012 19:13:49 -0500
Received: by mail-yh0-f46.google.com with SMTP id m54so217809yhm.19
        for <git@vger.kernel.org>; Tue, 20 Nov 2012 16:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding:message-id;
        bh=JXtEbL7cQ4Xgf5wzkO3CYBYI8lGQFB5ntRFio/5BSiw=;
        b=ii6qXDQEHovRVR9K1q4FOwwAQcradu/QOaW39iMBZyuxw+kSXCi6y4VEC3f3CyNjU+
         r9GKxjzf6eN0eSsG0e+6/qOmYPaxAfCtcC3Ibdm5E85UeUrUB2Ylw/klf817+b9sGFtz
         G4dVWrv3J+QXFWLw8k1gFR6tYjNpGiyIv6RUkgEsnG4ZMf8ZhztIF3n9Xm00JDRAMrJr
         fifwXn73cok1YUFPnxkfnc+YaOXjBoVY8sNDO8IZA9QJ40jzCpXHE78PdViWdrkUzryU
         LT96mfFB5sNmT3QXNSsiJhtmt2D808jwCcROLCIAzJQVckoKDDPPLshO1R5gr2hxUMdo
         Yf0Q==
Received: by 10.236.142.80 with SMTP id h56mr17215002yhj.10.1353456829289;
        Tue, 20 Nov 2012 16:13:49 -0800 (PST)
Received: from luna.localnet ([190.97.25.23])
        by mx.google.com with ESMTPS id t14sm12968559anl.17.2012.11.20.16.13.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 20 Nov 2012 16:13:48 -0800 (PST)
User-Agent: KMail/1.13.7 (Linux/3.2.21+edid; KDE/4.8.5; x86_64; ; )
In-Reply-To: <CAH5451nrcEo3Uxm0x6b39Hq1k-J4=OZPi-Cao7osaiS-w_Z1+Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210128>

--nextPart5383117.rJhINEtHYu
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue 20 Nov 2012 20:56:26 Andrew Ardill escribi=C3=B3:
> On 21 November 2012 10:42, Lisandro Dami=C3=A1n Nicanor P=C3=A9rez Meyer
>=20
> <perezmeyer@gmail.com> wrote:
> > Hi! I am not suscribed to the list, so please CC-me.
>=20
> That is the default etiquette on this list :)

Great :-)
=20
> > I think this may have been proposed before, but I could not find anythi=
ng
> > in the web, so I better try myself :)
> >=20
> > The idea would be to gitk to show a "git flow-like"[0] view when it
> > detects git flow (or the user ask for it or...)
>=20
> What does it mean to 'show a "git flow-like" view'? Show multiple
> branches? Place commits on each branch in 'swim-lanes', rather than
> moving them around on the horizontal to fit the space available? Some
> more detail, or even a mock-up would help a lot here.

I think the best mock-up would be:

<http://nvie.com/img/2009/12/Screen-shot-2009-12-24-at-11.32.03.png>

Yes, I'm referring to "swim-lanes" like view. Which may be already there an=
d=20
I'm miserably failing to see :-/

> > Basiccaly, you can show the main two branches: master and develop. Of
> > course, having the possibility to show feature/release/hotfixes branches
> > would be ideal.
>=20
> It is already possible to show multiple branches in gitk at the same
> time. You probably have some more specific needs beyond simply showing
> the different branches. Maybe you can be more specific?

Well, two ideas come to my mind:

=2D detect when using git flow (.git/config contains [gitflow "some_branch"=
]=20
entries).
=2D Show "swim-lane"-like graphs, including branches that may not be presen=
t,=20
but where there (release branches often are created and merged back, for=20
example)

Maybe some of this is already there and/or it's too much trouble to do so, =
in=20
those cases, please accept my apologies :-)

Kinds regards, Lisandro.

=2D-=20
Lisandro Dami=C3=A1n Nicanor P=C3=A9rez Meyer
http://perezmeyer.com.ar/
http://perezmeyer.blogspot.com/

--nextPart5383117.rJhINEtHYu
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCAAGBQJQrByxAAoJEKtkX0BihqfQiLoP/i201kYtwsQI+kXZZnvb0EOt
MxxyqGQByYjquD3apSMSot+AVGAVhlqgC8Lz1RQ0b5f5rbMTrgrBgDWYtRKN82Lq
y3/K7ebuuSUSXcYkgdcIKm3IwJX6D9wzNLpFXsmaD5UkiWY6hNxd/felM3LDNNjv
ddUaaPbsPqOnteS5hOYRg9u1LvOq+KYoZ3aTXM17K+/+1WW7qWTAg7ThJlThT2cS
UiZIzCCcvJQ0QHA7BgL+wmcGkrng9w0T2WaSZi/k36eJnG8hYSCempGVbQ8BUyRT
tbwfMnR2llZP3LF4MEKe9MtBjMOPc+yW2iwWq99/bw3n9jj6S6tSVTBDZGaHN3fj
nQKoFfJlmv3oDXiT/q9yqQaWSBHoPhQ1vQ+8cRhPg+M9e7yt7fmZwNi0R8dH2kXa
HGEzuwHz03VRQbDesHg8rV23UjCkf/J+JjIx4a+GdtNwQxttx4kOj5pjJVqYi0ow
T7gqIBerqZKOCsbmhhST1P0WiOsXsAjbtbHsJRslJYx7cx+bC13KFvebscOxUnIk
Y1nL8zEwx8ioHZq2IQuIfWdCNTxgPokBDE8GkHCqxgCRhxDLDZwLuWdq5oQgfM+q
O5VyvubjcDw3rHfKa5l1fggL8HTclyFYNcNrDG19gBd6crHP4xACDbPdi4GZHR61
4XzkobQAM4DZtXDc7Iyu
=WXUE
-----END PGP SIGNATURE-----

--nextPart5383117.rJhINEtHYu--
