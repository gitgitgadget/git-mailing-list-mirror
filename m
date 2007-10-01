From: martin f krafft <madduck@madduck.net>
Subject: merging .gitignore
Date: Mon, 1 Oct 2007 14:03:14 +0100
Message-ID: <20071001130314.GA5932@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 01 15:03:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcKvs-00030k-GY
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 15:03:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596AbXJANDY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 09:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbXJANDY
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 09:03:24 -0400
Received: from clegg.madduck.net ([82.197.162.59]:38350 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbXJANDX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 09:03:23 -0400
Received: from lapse.madduck.net (absinthe.ifi.unizh.ch [130.60.75.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id B9955C00D
	for <git@vger.kernel.org>; Mon,  1 Oct 2007 15:03:18 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id 5B174827; Mon,  1 Oct 2007 14:03:14 +0100 (BST)
Content-Disposition: inline
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-2-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: ClamAV 0.91.2/4445/Mon Oct  1 10:32:46 2007 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59612>


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear gits (oh dear=E2=80=A6),

we just ran into a problem in a git-managed project and I'd be
interested to learn how you approach this.

Our main line ("upstream"), which tracks a remote repository, does
not have a .gitignore file. For new features, we use feature
branches, and we merge those into an integration branch ("master")
and track them separately of upstream.

Feature branch A has a .gitignore file, and it's been merged into
master for a while. Today, feature branch B failed to merge into
master because it also provides a .gitignore file. We can obviously
resolve the conflict, but I wonder whether there is a better way to
deal with this since we deal with quite a large number of new
feature branches and it's only a matter of time until the next one
will conflict because of .gitignore.

(and yes, this is basically a reincarnation of my case for
=2Egitignore.d [http://lists.zerezo.com/git/msg627581.html]).

Thoughts,

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
kermit: why are there so many songs about rainbows?
fozzy: that's part of what rainbows do.
=20
spamtraps: madduck.bogus@madduck.net

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHAPASIgvIgzMMSnURAp4TAKDnbpqhPWk4XeyktuzBCMQbv0xLpACdG6Fa
VSAMazJ6jA7mR5KtWd3f0A8=
=c9Qz
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
