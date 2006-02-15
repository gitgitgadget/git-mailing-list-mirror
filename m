From: Keith Packard <keithp@keithp.com>
Subject: Re: several quick questions
Date: Tue, 14 Feb 2006 21:25:45 -0800
Message-ID: <1139981145.4341.137.camel@evo.keithp.com>
References: <43F20532.5000609@iaglans.de>
	 <Pine.LNX.4.64.0602140845080.3691@g5.osdl.org>
	 <87k6bxvmj6.wl%cworth@cworth.org> <1139943349.4341.66.camel@evo.keithp.com>
	 <Pine.LNX.4.64.0602141101110.3691@g5.osdl.org>
	 <1139945967.4341.71.camel@evo.keithp.com>
	 <46a038f90602142011o36b975b7s1833953db3b6d376@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-a8AFAGY0kfCDBU5WLdR5"
Cc: keithp@keithp.com, Linus Torvalds <torvalds@osdl.org>,
	Carl Worth <cworth@cworth.org>,
	Nicolas Vilz 'niv' <niv@iaglans.de>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 15 06:25:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9FAq-0000dW-87
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 06:25:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422959AbWBOFZx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 00:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422964AbWBOFZx
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 00:25:53 -0500
Received: from home.keithp.com ([63.227.221.253]:42000 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1422959AbWBOFZw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Feb 2006 00:25:52 -0500
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 2B07013002C;
	Tue, 14 Feb 2006 21:25:51 -0800 (PST)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 24302-07; Tue, 14 Feb 2006 21:25:50 -0800 (PST)
Received: by keithp.com (Postfix, from userid 1033)
	id B875F130020; Tue, 14 Feb 2006 21:25:50 -0800 (PST)
Received: from evo.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id AF4FF14001;
	Tue, 14 Feb 2006 21:25:50 -0800 (PST)
Received: from keithp by evo.keithp.com with local (Exim 4.60)
	(envelope-from <keithp@keithp.com>)
	id 1F9FAi-0008FE-ID; Tue, 14 Feb 2006 21:25:48 -0800
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90602142011o36b975b7s1833953db3b6d376@mail.gmail.com>
X-Mailer: Evolution 2.4.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16212>


--=-a8AFAGY0kfCDBU5WLdR5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-02-15 at 17:11 +1300, Martin Langhoff wrote:

> Did that lead to finding any problems with the import? Can I get my
> hands on that script you've written to run the comparison?

The only issues we had were with manual changes to the repository; other
than that, we now has a usable git repository for cairo (visible at
git://git.cairographics.org/cairo). The comparison tool that I wrote was
a cheesy shell script; I think Carl has updated it to do something less
severe than rm -rf *; git-reset --hard; if he can share that, I think
you'll like it a lot better than mine.

Our CVS import script has some magic ChangeLog-style mangling which
we've posted to the list before; that clearly needs to be encapsulated
in an optional log-reformatting bit for it to be generally useful.=20
=20
--=20
keith.packard@intel.com

--=-a8AFAGY0kfCDBU5WLdR5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD8rtZQp8BWwlsTdMRArz8AKDN6foU+K4Ncgpxi/nGFxEjEAf7rgCfbVUZ
JxS32GV+H3OKRBiNTq2gyeo=
=Fxpn
-----END PGP SIGNATURE-----

--=-a8AFAGY0kfCDBU5WLdR5--
