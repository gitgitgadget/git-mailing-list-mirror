From: "Fernando J. Pereda" <ferdy@gentoo.org>
Subject: Re: git and larger trees, not so fast?
Date: Sat, 11 Aug 2007 22:51:37 +0200
Message-ID: <20070811205137.GC4710@ferdyx.org>
References: <20070809163026.GD568@mbox.bz> <alpine.LFD.0.999.0708111137250.30176@woody.linux-foundation.org> <20070811190201.GB4710@ferdyx.org> <alpine.LFD.0.999.0708111337280.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
Cc: moe <moe-git@mbox.bz>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Aug 11 22:52:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJxwI-00049m-KF
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 22:52:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755797AbXHKUvq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 16:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756102AbXHKUvq
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 16:51:46 -0400
Received: from 170.Red-213-96-222.staticIP.rima-tde.net ([213.96.222.170]:56460
	"EHLO smtp.ferdyx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353AbXHKUvp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 16:51:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp.ferdyx.org (Postfix) with ESMTP id 510B68D315;
	Sat, 11 Aug 2007 22:51:43 +0200 (CEST)
Received: from smtp.ferdyx.org ([127.0.0.1])
	by localhost (tungsteno.ferdyx.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g5DLwjNZj3Hc; Sat, 11 Aug 2007 22:51:42 +0200 (CEST)
Received: from posidon.ferdyx.org (posidon.ferdyx.org [192.168.0.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.ferdyx.org (Postfix) with ESMTP id 85C578D306;
	Sat, 11 Aug 2007 22:51:40 +0200 (CEST)
Received: by posidon.ferdyx.org (nbSMTP-1.01-cvs) for uid 1000
	(using TLSv1/SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	ferdy@gentoo.org; Sat, 11 Aug 2007 22:51:38 +0200 (CEST)
Mail-Followup-To: "Fernando J. Pereda" <ferdy@gentoo.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	moe <moe-git@mbox.bz>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0708111337280.30176@woody.linux-foundation.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55631>


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 11, 2007 at 01:38:34PM -0700, Linus Torvalds wrote:
>=20
>=20
> On Sat, 11 Aug 2007, Fernando J. Pereda wrote:
> >=20
> > Just for the record, I tried those patches on a real tree of ~120k files
> > and ~25k directories, and Git is now _usable_. (The repository was
> > created from an old checkout of the gentoo-x86 tree).
>=20
> What does "usable" mean? Is it still slow ("barely usable") or is it=20
> actually fast enough to be truly _nice_ to use?

Very nice to use considering my hardware is rather old. git status used
to take >1m and it now takes ~3s and git commit takes ~7s while it used
to take >1m too. So it makes things nice to use and I guess things are
MUCH better on faster hardware.

(This is running on a 'AMD Athlon(TM) XP 2000+' and the repo is in a USB
Hard drive)

- ferdy

--=20
Fernando J. Pereda Garcimart=EDn
20BB BDC3 761A 4781 E6ED  ED0B 0A48 5B0C 60BD 28D4

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGviFZCkhbDGC9KNQRAuSLAJ44McuMfxGFi1bVW0Cxi6tk2gdzkQCfXcDh
vNkI5zu//w4R6mx+FwE8FMk=
=ztlD
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--
