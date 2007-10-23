From: martin f krafft <madduck@madduck.net>
Subject: unmerging feature branches
Date: Tue, 23 Oct 2007 17:24:45 +0200
Message-ID: <20071023152445.GA10070@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 23 17:48:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkLzY-0002bs-Pr
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 17:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753453AbXJWPsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 11:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753367AbXJWPsQ
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 11:48:16 -0400
Received: from clegg.madduck.net ([82.197.162.59]:34009 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202AbXJWPsO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 11:48:14 -0400
X-Greylist: delayed 1403 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Oct 2007 11:48:14 EDT
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id 2CFACA800D
	for <git@vger.kernel.org>; Tue, 23 Oct 2007 17:24:57 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 707C89F13B
	for <git@vger.kernel.org>; Tue, 23 Oct 2007 17:24:46 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id DEFDF4408; Tue, 23 Oct 2007 17:24:45 +0200 (CEST)
Content-Disposition: inline
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-2-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: ClamAV 0.91.2/4574/Tue Oct 23 16:57:10 2007 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62133>


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear list,

Let's say I developed a feature Foo on a branch off master, and at
some point I merged it back into master (commit M) and published the
repo. Since M, a number of commits have been made onto master.

Now I woul like to undo the merge.

I could rebase (M+1)..master onto M^ (on the former master branch),
but that would orphan the commits between the merge point and the
tip of master, which others are tracking.

I'd love to have git-revert, but that cannot undo a multi-parent
commit.

I could git-revert every commit on the feature branch between the
branch point and the merge point, even squash them into a single
commit, but that is a lot of work.

Are there any other methods? Is it conceivable to let git-revert
revert a merging commit if you tell it somehow which of the two (or
more) parents are the ones you want undone, meaning that you'd like
to keep the others?

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"a man who does not realise
 that he is half an animal
 is only half a man."
                                                    -- thornton wilder
=20
spamtraps: madduck.bogus@madduck.net

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHHhI9IgvIgzMMSnURAq7MAKCBT2SKx+axl1mdB0azmoadamtgZwCfe15y
m33zjwWKrS302f6v8efEKSA=
=Rz0F
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
