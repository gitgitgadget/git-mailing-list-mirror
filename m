From: Keith Packard <keithp@keithp.com>
Subject: Re: parsecvs fails even on simple input
Date: Wed, 27 Jun 2007 10:20:21 -0700
Message-ID: <1182964822.4031.193.camel@neko.keithp.com>
References: <20070622113625.GD12473@rkagan.sw.ru>
	 <1182720667.13289.41.camel@neko.keithp.com>
	 <20070627153300.GA27933@rkagan.sw.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-rXb68jcR/VZgAKY1rNq2"
Cc: keithp@keithp.com, Al Viro <viro@zeniv.linux.org.uk>,
	git@vger.kernel.org
To: Roman Kagan <rkagan@sw.ru>
X-From: git-owner@vger.kernel.org Wed Jun 27 19:20:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3bCA-0006tQ-ET
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 19:20:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758764AbXF0RUo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 13:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758590AbXF0RUo
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 13:20:44 -0400
Received: from home.keithp.com ([63.227.221.253]:3910 "EHLO keithp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758194AbXF0RUn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 13:20:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id F36CF114328;
	Wed, 27 Jun 2007 10:20:40 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id W0O+A7ZOj3Ic; Wed, 27 Jun 2007 10:20:35 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id 79D8A114327; Wed, 27 Jun 2007 10:20:34 -0700 (PDT)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 360A9114315;
	Wed, 27 Jun 2007 10:20:34 -0700 (PDT)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id 9B77454252; Wed, 27 Jun 2007 10:20:27 -0700 (PDT)
In-Reply-To: <20070627153300.GA27933@rkagan.sw.ru>
X-Mailer: Evolution 2.10.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51059>


--=-rXb68jcR/VZgAKY1rNq2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-06-27 at 19:33 +0400, Roman Kagan wrote:

> OTOH git-fast-import seems to be essentially the public API for the
> parsecvs kind of tasks.  It may be wiser from the maintenance POV to use
> that instead of direct libgit calls (unless parsecvs is going to land in
> the git tree).  I'll try to find the time and take a look at this
> somewhere next week.

Yeah, I didn't quite understand how git-fast-import worked. Looks like
it aligns with parsecvs's structure fairly well. Let me know if you get
it working.

--=20
keith.packard@intel.com

--=-rXb68jcR/VZgAKY1rNq2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGgpxVQp8BWwlsTdMRAkmjAJ9vfa/U/fiAdYauwHJtOW2aJUziUQCgxqe6
7kKPYkSpcotg51y5esb34/I=
=ioh6
-----END PGP SIGNATURE-----

--=-rXb68jcR/VZgAKY1rNq2--
