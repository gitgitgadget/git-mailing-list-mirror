From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <carlos@cmartin.tk>
Subject: Re: git gc exit with out of memory, malloc failed error
Date: Thu, 15 Sep 2011 11:16:13 +0200
Message-ID: <1316078174.2019.15.camel@bee.lab.cmartin.tk>
References: <CAGAhT3mbGB-0q3EKh5MrGqB59wUea7NfaaY18DvnL3qimwh9QA@mail.gmail.com>
	 <CA+sFfMcfy=GCFrCjonQXvXRQu=hLjDvQViJJ75xqa72Gb23MgQ@mail.gmail.com>
	 <CA+sFfMdXLkSE_RXB28TSx0JpPVjwe1Rf+03TkiT2YJjYH7m9MQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-MwHSGJYJIKKs8ZOn37y0"
Cc: git@vger.kernel.org, Alexander Kostikov <alex.kostikov@gmail.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 11:16:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R483R-0000Xm-0L
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 11:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755770Ab1IOJQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 05:16:16 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:57727 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755752Ab1IOJQP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 05:16:15 -0400
Received: from [10.10.10.234] (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 38636460AC;
	Thu, 15 Sep 2011 11:15:56 +0200 (CEST)
In-Reply-To: <CA+sFfMdXLkSE_RXB28TSx0JpPVjwe1Rf+03TkiT2YJjYH7m9MQ@mail.gmail.com>
X-Mailer: Evolution 3.0.3- 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181450>


--=-MwHSGJYJIKKs8ZOn37y0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2011-09-14 at 21:29 -0500, Brandon Casey wrote:
> [resend since gmail's Rich formatting was enabled]
>=20
> On Wed, Sep 14, 2011 at 8:33 PM, Alexander Kostikov
> <alex.kostikov@gmail.com> wrote:
> >
> > I'm new to git and I'm getting the following out of memory error on git=
 gc:
> >
> > $ git gc
> > Counting objects: 80818, done.
> > Delta compression using up to 8 threads.
> > fatal: Out of memory, malloc failed (tried to allocate 24359675 bytes)
> > error: failed to run repack
>=20
> Try reducing the number of threads that are used.  You must have some
> pretty large objects if you have 24GB and ran out of memory.  The

IIRC the 32-bit Windows builds limit each user process to 2GB. If
msysgit is built in 32-bit mode, it's possible (probable even, in order
to remain backwards-compatible) that it's hitting this limit, rather
than the physical limit of the machine. If it's using 8 threads, it
means that there are 256MB available for each thread.

   cmn

--=-MwHSGJYJIKKs8ZOn37y0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOccJdAAoJEHKRP1jG7ZzTCGoIAI7ATxyBlNzIyJvImKB+Ej+v
m531LDW8XpHZnMSKBiUWXS4CLCcYpc7iAsweJgW1rqdugMcihfiryFmVHgJv8xzn
cauU6usMTj6ZIon8REfJRmrGsXgHF8JzdpgkxZZF454y9K8MdBRSLEvehoiv9jaP
B5ogqEn7Vn8AkaLzHsHl3kbiNdhWOQBDl18U8DI6Xv8vWm4MuOM7S1PdZ4Vguwv3
U0ZRNNhVe8NLFHKFa8pfJScdvMYb3CvX2tQtLMXoDxgEMNmwfDA22R9rsIPm+q31
PpVePxp0Pqhg++M5pYnQQNuxnHC0vwn/l5wR7NPvyMvowqw3/U/GV2UVZgGLsGQ=
=Qdm1
-----END PGP SIGNATURE-----

--=-MwHSGJYJIKKs8ZOn37y0--
