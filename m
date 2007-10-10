From: martin f krafft <madduck@madduck.net>
Subject: Re: inexplicable failure to merge recursively across cherry-picks
Date: Wed, 10 Oct 2007 11:25:28 +0100
Message-ID: <20071010102528.GB20390@lapse.madduck.net>
References: <20071010015545.GA17336@lapse.madduck.net> <alpine.LFD.0.999.0710091926560.3838@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 10 12:25:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfYlB-00062e-Dt
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 12:25:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849AbXJJKZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 06:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752818AbXJJKZi
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 06:25:38 -0400
Received: from clegg.madduck.net ([82.197.162.59]:42576 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752684AbXJJKZg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 06:25:36 -0400
Received: from lapse.madduck.net (absinthe.ifi.unizh.ch [130.60.75.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id A0D2DBE83;
	Wed, 10 Oct 2007 12:25:29 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id B4EC54FD4A; Wed, 10 Oct 2007 11:25:28 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0710091926560.3838@woody.linux-foundation.org>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-2-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: ClamAV 0.91.2/4521/Wed Oct 10 09:58:01 2007 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60489>


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Linus Torvalds <torvalds@linux-foundation.org> [2007.10.10.0354=
 +0100]:
> Cherry-picking is immaterial. It doesn't matter how the changes
> come into the tree. It doesn't matter what the history is. The
> only thing git cares about is the content, and the end result.

This is the part I over-estimated. I thought that Git would figure
out that commits 1-3 had been merged into the target and thus apply,
in sequence, only the commits from the source which had not been
merged.

Many thanks (again), Linus! Looking forward to your next content
manager; you know, the one with artificial intelligence built in!
You could call it "wit" :)

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
dies ist eine manuell generierte email. sie beinhaltet
tippfehler und ist auch ohne gro=DFbuchstaben g=FCltig.
=20
spamtraps: madduck.bogus@madduck.net

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHDKiYIgvIgzMMSnURAnajAKCE4EmiAstUqXj0sBhYsFkMPGQMSgCg5/4n
/LuNXtKZ4wO7O2qYFuZrfUE=
=o/JX
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
