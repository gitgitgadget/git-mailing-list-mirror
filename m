From: Keith Packard <keithp@keithp.com>
Subject: Re: parsecvs tool now creates git repositories
Date: Mon, 03 Apr 2006 19:24:33 -0700
Message-ID: <1144117473.2303.132.camel@neko.keithp.com>
References: <1143956188.2303.39.camel@neko.keithp.com>
	 <46a038f90604031538x3c94d86ap9f1400427513a3a7@mail.gmail.com>
	 <1144116459.2303.129.camel@neko.keithp.com>
	 <46a038f90604031916r4651b572lb9bae4c5a3d47bc9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-i2juzy3pykzLrcxNg8Kb"
Cc: keithp@keithp.com, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 04 04:25:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQbE6-0003xr-AP
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 04:25:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964968AbWDDCY7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 22:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964966AbWDDCY7
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 22:24:59 -0400
Received: from home.keithp.com ([63.227.221.253]:62218 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S964968AbWDDCY7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 22:24:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 4639213001F;
	Mon,  3 Apr 2006 19:24:58 -0700 (PDT)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 08155-04; Mon, 3 Apr 2006 19:24:57 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id E02A113001E; Mon,  3 Apr 2006 19:24:57 -0700 (PDT)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id D36FD14001;
	Mon,  3 Apr 2006 19:24:57 -0700 (PDT)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id 76E40543DB; Mon,  3 Apr 2006 19:24:34 -0700 (PDT)
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90604031916r4651b572lb9bae4c5a3d47bc9@mail.gmail.com>
X-Mailer: Evolution 2.4.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18372>


--=-i2juzy3pykzLrcxNg8Kb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-04-04 at 14:16 +1200, Martin Langhoff wrote:

> Meh, had you done it in Perl, I'd be helping you with the Pg repo,
> attic files and ensuring that files created on a branch and then put
> into HEAD are handled gracefully. (But you'll get Linus' and Junio's
> attention. Smarty cookie.)

I think those parts are working correctly, I've had plenty of examples
of that kind of adventure.

> Does it run incrementally? Can it discover non-binary files and pass -kk?

It doesn't run incrementally, and it unconditionally passes -kk. It's
currently using rcs to check out versions of the files, so it should
deal with binary content as well as rcs does. Is there something magic I
need to do here? Like for DOS?

--=20
keith.packard@intel.com

--=-i2juzy3pykzLrcxNg8Kb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEMdjgQp8BWwlsTdMRAqCVAJ4n9PCOMijFKL6StBnLhSfZP3tPmQCguPtv
nlG4MiY9Sq9OIySFp44T0RM=
=r6SC
-----END PGP SIGNATURE-----

--=-i2juzy3pykzLrcxNg8Kb--
