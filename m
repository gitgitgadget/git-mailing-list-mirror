From: "Fernando J. Pereda" <ferdy@gentoo.org>
Subject: Re: git and larger trees, not so fast?
Date: Sat, 11 Aug 2007 21:02:01 +0200
Message-ID: <20070811190201.GB4710@ferdyx.org>
References: <20070809163026.GD568@mbox.bz> <alpine.LFD.0.999.0708111137250.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Cc: moe <moe-git@mbox.bz>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Aug 11 21:35:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJwk2-0000O3-Nh
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 21:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbXHKTe4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 15:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbXHKTe4
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 15:34:56 -0400
Received: from 170.Red-213-96-222.staticIP.rima-tde.net ([213.96.222.170]:39153
	"EHLO smtp.ferdyx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145AbXHKTez (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 15:34:55 -0400
X-Greylist: delayed 1968 seconds by postgrey-1.27 at vger.kernel.org; Sat, 11 Aug 2007 15:34:54 EDT
Received: from localhost (localhost [127.0.0.1])
	by smtp.ferdyx.org (Postfix) with ESMTP id E2FED8D315;
	Sat, 11 Aug 2007 21:02:06 +0200 (CEST)
Received: from smtp.ferdyx.org ([127.0.0.1])
	by localhost (tungsteno.ferdyx.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VZEJf4I0Tk1O; Sat, 11 Aug 2007 21:02:05 +0200 (CEST)
Received: from posidon.ferdyx.org (posidon.ferdyx.org [192.168.0.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.ferdyx.org (Postfix) with ESMTP id 975578D306;
	Sat, 11 Aug 2007 21:02:04 +0200 (CEST)
Received: by posidon.ferdyx.org (nbSMTP-1.01-cvs) for uid 1000
	(using TLSv1/SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	ferdy@gentoo.org; Sat, 11 Aug 2007 21:02:02 +0200 (CEST)
Mail-Followup-To: "Fernando J. Pereda" <ferdy@gentoo.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	moe <moe-git@mbox.bz>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0708111137250.30176@woody.linux-foundation.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55622>


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 11, 2007 at 11:47:42AM -0700, Linus Torvalds wrote:
> Anyway, it would be good if you re-did your real work tree with current=
=20
> commit, just to verify. You have slower hardware than I do, but hopefully=
=20
> it is now just about as fast as it can be.

Just for the record, I tried those patches on a real tree of ~120k files
and ~25k directories, and Git is now _usable_. (The repository was
created from an old checkout of the gentoo-x86 tree).

- ferdy

--=20
Fernando J. Pereda Garcimart=EDn
20BB BDC3 761A 4781 E6ED  ED0B 0A48 5B0C 60BD 28D4

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGvgepCkhbDGC9KNQRAuD7AJ9s0f/5Pv7q/poamGOAjsZzc5iHlQCdHZ4Y
q4JRgHMEo2i4Mm7z3iLT0Qs=
=haxV
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
