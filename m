From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: StGIT 0.14.3: extra space is added before e-mail on export after "stg edit"
Date: Sun, 19 Oct 2008 12:09:07 +0400
Message-ID: <200810191209.14597.arvidjaar@mail.ru>
References: <200810152025.19995.arvidjaar@mail.ru> <b0943d9e0810180148k4ba5bb2bgf3c5cdb2358b9419@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart11892371.3RtMfmQnOR";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Catalin Marinas" <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 19 16:17:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrTsp-00048Y-Gk
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 10:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbYJSIkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 04:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbYJSIkh
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 04:40:37 -0400
Received: from mx28.mail.ru ([194.67.23.67]:23036 "EHLO mx28.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751098AbYJSIkg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 04:40:36 -0400
X-Greylist: delayed 1876 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Oct 2008 04:40:35 EDT
Received: from mx30.mail.ru (mx30.mail.ru [194.67.23.238])
	by mx28.mail.ru (mPOP.Fallback_MX) with ESMTP id 1AFDF783206
	for <git@vger.kernel.org>; Sun, 19 Oct 2008 12:09:50 +0400 (MSD)
Received: from [91.77.192.7] (port=32079 helo=cooker.net)
	by mx30.mail.ru with asmtp 
	id 1KrTLh-0004Ys-00; Sun, 19 Oct 2008 12:09:17 +0400
User-Agent: KMail/1.9.10
In-Reply-To: <b0943d9e0810180148k4ba5bb2bgf3c5cdb2358b9419@mail.gmail.com>
X-Spam: Not detected
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98600>

--nextPart11892371.3RtMfmQnOR
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 18 October 2008, Catalin Marinas wrote:
> 2008/10/15 Andrey Borzenkov <arvidjaar@mail.ru>:
> > Funny problem. I have following export template:
> >
> > Subject: [PATCH] %(shortdescr)s
> > From: %(authname)s %(authemail)s
> >
> > %(longdescr)s
> > Signed-off-by: %(authname)s %(authemail)s
>=20
> The default templates contain "%(authname)s <%(authemail)s>", i.e.
> with the angle brackets arount authemail and I've never seen this
> problem. Does it work if you change them (or use the default
> templates)?
>=20

Well, my GIT_AUTHOR_EMAIL was with angle brackets. I do not remember, why
(apparently I had some issues in the past). I stripped brackets and changed
template, now it seems to work. I was never sure what exactly e-mail should
like like.

Thank you!

--nextPart11892371.3RtMfmQnOR
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkj66yQACgkQR6LMutpd94yu1QCguNTSqPyQ4B5L+Vhl81GrzcWa
DTkAoKYsXSaR6cpQyXf7eybzii4Curha
=ulFQ
-----END PGP SIGNATURE-----

--nextPart11892371.3RtMfmQnOR--
