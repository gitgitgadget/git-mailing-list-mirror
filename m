From: martin f krafft <madduck@madduck.net>
Subject: Reacting to new commits in a poll-mirror
Date: Wed, 3 Feb 2010 11:02:34 +1300
Message-ID: <20100202220234.GA17107@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 02 23:13:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcQzr-00053K-6C
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 23:13:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757017Ab0BBWNU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 17:13:20 -0500
Received: from clegg.madduck.net ([193.242.105.96]:47707 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756993Ab0BBWNR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 17:13:17 -0500
X-Greylist: delayed 634 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Feb 2010 17:13:17 EST
Received: from lapse.rw.madduck.net (lapse.nz.madduck.net [IPv6:2001:4428:234::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 997CF1D4097
	for <git@vger.kernel.org>; Tue,  2 Feb 2010 23:02:38 +0100 (CET)
Received: by lapse.rw.madduck.net (Postfix, from userid 1000)
	id 7BDEDFF; Wed,  3 Feb 2010 11:02:34 +1300 (NZDT)
Content-Disposition: inline
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux squeeze/sid kernel 2.6.32-trunk-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.95.3 at clegg
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138770>


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Folks,

I am trying to set up Patchwork-Git integration on host A for
a project whose Git repo is on host B. I thought I could use
a mirror (git clone --mirror) on A and regularly fetch from B, but
I cannot find a way (hook) to make Git on A react to new commits it
fetched from B.

I can probably hack something up, e.g. store refs before a fetch and
then iterate the refs between the stored refs and the HEAD, but this
seems exceedingly hackish and I'd much rather have this information
=66rom git-fetch (like git-push calls post-receive).

Is this at all possible?
Would it be possible?
Where would this be done?

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
the uncertainty principle:
  you can never be sure how many
  beers you had last night.
=20
spamtraps: madduck.bogus@madduck.net

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEAREDAAYFAktooPcACgkQIgvIgzMMSnUZzgCeJ8Im22Bc+gmI/9AC8Jp84OWH
qfwAn2jrQI43bXm8IlcQtJOOhust686P
=W3cn
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
