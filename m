From: martin f krafft <madduck@madduck.net>
Subject: git-svn: expand svn:keywords, or how else to deal with them?
Date: Fri, 9 May 2008 11:19:19 +0100
Message-ID: <20080509101919.GA25037@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 09 12:20:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuPi3-00077t-QU
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 12:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752769AbYEIKT0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 06:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752715AbYEIKT0
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 06:19:26 -0400
Received: from clegg.madduck.net ([82.197.162.59]:34381 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752470AbYEIKTZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2008 06:19:25 -0400
Received: from lapse.madduck.net (chiu.ifi.unizh.ch [130.60.75.74])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id 72301A81C1
	for <git@vger.kernel.org>; Fri,  9 May 2008 12:19:20 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id 600124FD40; Fri,  9 May 2008 11:19:19 +0100 (IST)
Mail-Followup-To: git discussion list <git@vger.kernel.org>
Content-Disposition: inline
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.24-1+scoflowctrl.1-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Virus-Scanned: ClamAV 0.92.1/7076/Fri May  9 09:38:02 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81611>


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I am using git-svn to track an upstream SVN project, which I then
package for Debian. Upstream uses $Id:$ all over the source code,
but I am not ready to argue with him that this ought to be removed.

The problem is that I build the Debian packages out of the git-svn
tree, but use the published tarball. The latter has $Id:$ expanded
in all files, while the git-svn tree does not - git-svn does not
expand them.

The result is that my Debianisation diff now reverts the expansion
for every single file. This is quite ugly.

I realise there are ways to prevent this, but I think that the
cleanest would be if git-svn could be taught to expand svn:keywords.

Is this something you could live with, Eric? I am willing to have
a go at the patch, but my Perl-foo is crap, so I may well fail...

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"a mathematician is a device for turning coffee into theorems."
                                                         -- paul erd=F6s
=20
spamtraps: madduck.bogus@madduck.net

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIJCUnIgvIgzMMSnURAim2AJ4g50SiGPDg2Ba5Ss6xNCQb/QwWmQCdGWJT
t547Gn+bOJvPQEQ/C7hP2pM=
=cYy3
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
