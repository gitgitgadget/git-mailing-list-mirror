From: martin f krafft <madduck@madduck.net>
Subject: Re: [PATCH] translate bad characters in refnames during git-svn
	fetch
Date: Mon, 16 Jul 2007 19:47:31 +0200
Message-ID: <20070716174731.GA4792@lapse.madduck.net>
References: <20070715130548.GA6144@piper.oerlikon.madduck.net> <20070716033050.GA29521@muzzle> <20070716111509.GC18293@efreet.light.src> <20070715130548.GA6144@piper.oerlikon.madduck.net> <20070716033050.GA29521@muzzle>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 16 19:47:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAUfV-0005bh-Bo
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 19:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751782AbXGPRra (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 13:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751725AbXGPRra
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 13:47:30 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:57894 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbXGPRr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 13:47:29 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id BD2E7895D8D
	for <git@vger.kernel.org>; Mon, 16 Jul 2007 19:47:27 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 10598-10 for <git@vger.kernel.org>;
	Mon, 16 Jul 2007 19:47:27 +0200 (CEST)
Received: from lapse.madduck.net (absinthe.ifi.unizh.ch [130.60.75.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 03934895D8C
	for <git@vger.kernel.org>; Mon, 16 Jul 2007 19:47:26 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id 09E454F89B; Mon, 16 Jul 2007 19:47:31 +0200 (CEST)
Mail-Followup-To: git discussion list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070716111509.GC18293@efreet.light.src> <20070716033050.GA29521@muzzle>
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.21-2-686 i686
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52697>


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Eric Wong <normalperson@yhbt.net> [2007.07.16.0530 +0200]:
> The major issue with this is that it doesn't handle odd cases
> where a refname is sanitized into something (say "1234~2"
> sanitizes to "1234=3D2"), and then another branch is created named
> "1234=3D2".

Well, we can't please everyone, can we? :)

I like Jan's proposal about using the % escape, even though it
doesn't make pretty branch names.

On the other hand, we could make the translation regexps
configurable...

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
spamtraps: madduck.bogus@madduck.net
=20
"if they can get you asking the wrong questions,
 they don't have to worry about answers."
                                                     -- thomas pynchon

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature (GPG/PGP)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGm68zIgvIgzMMSnURAoLzAKCS18EcSR8s0oIlPKrGN2fO3CTizQCeNfls
oajlEwIzMAzeOpUDr8Viejg=
=eZfr
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
