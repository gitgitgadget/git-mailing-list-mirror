From: martin f krafft <madduck@debian.org>
Subject: Re: linearising TopGit forests into patch series (was: [ANNOUNCE]
	TopGit - A different patch queue manager)
Date: Fri, 8 Aug 2008 14:06:58 -0300
Organization: The Debian project
Message-ID: <20080808170658.GA16055@lapse.rw.madduck.net>
References: <20080803031424.GV32184@machine.or.cz>
	<20080807175623.GA16833@lapse.rw.madduck.net>
	<36ca99e90808071258h62b65981s20a5b053d9bc5754@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0226844854829706067=="
To: Bert Wesarg <bert.wesarg@googlemail.com>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org, vcs distro packaging discussion list
	<vcs-pkg-discuss@lists.alioth.debian.org>
X-From: vcs-pkg-discuss-bounces+gcpv-vcs-pkg-discuss=m.gmane.org@lists.alioth.debian.org Fri Aug 08 19:07:29 2008
Return-path: <vcs-pkg-discuss-bounces+gcpv-vcs-pkg-discuss=m.gmane.org@lists.alioth.debian.org>
Envelope-to: gcpv-vcs-pkg-discuss@m.gmane.org
Received: from alioth.debian.org ([217.196.43.134])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRVQw-0002nn-FQ
	for gcpv-vcs-pkg-discuss@m.gmane.org; Fri, 08 Aug 2008 19:07:22 +0200
Received: from localhost
	([127.0.0.1] helo=alioth.debian.org ident=list)
	by alioth.debian.org with esmtp (Exim 4.63)
	(envelope-from <vcs-pkg-discuss-bounces+gcpv-vcs-pkg-discuss=m.gmane.org@lists.alioth.debian.org>)
	id 1KRVQ1-0001hJ-3O
	for gcpv-vcs-pkg-discuss@m.gmane.org; Fri, 08 Aug 2008 17:06:25 +0000
Received: from clegg.madduck.net ([193.242.105.96])
	by alioth.debian.org with esmtp (Exim 4.63)
	(envelope-from <madduck@lapse.rw.madduck.net>) id 1KRVPq-0001YP-Gb
	for vcs-pkg-discuss@lists.alioth.debian.org;
	Fri, 08 Aug 2008 17:06:22 +0000
Received: from lapse.rw.madduck.net (unknown [209.13.181.29])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.rw.madduck.net",
	Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id EEA5B1D40AE;
	Fri,  8 Aug 2008 19:05:52 +0200 (CEST)
Received: by lapse.rw.madduck.net (Postfix, from userid 1000)
	id 3C11C80B6; Fri,  8 Aug 2008 14:06:58 -0300 (ART)
In-Reply-To: <36ca99e90808071258h62b65981s20a5b053d9bc5754@mail.gmail.com>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel
	2.6.24-etchnhalf.1+scoflowctrl.1-686 i686
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.93.1/7981/Fri Aug 8 17:29:53 2008 on
	clegg.madduck.net
X-Virus-Status: Clean
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on alioth.debian.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=AWL,BAYES_00,URIBL_RED
	autolearn=ham version=3.2.3
X-BeenThere: vcs-pkg-discuss@lists.alioth.debian.org
X-Mailman-Version: 2.1.9
Precedence: list
List-Id: Discussions on using VCS for distro packaging
	<vcs-pkg-discuss.lists.alioth.debian.org>
List-Unsubscribe: <http://lists.alioth.debian.org/mailman/listinfo/vcs-pkg-discuss>,
	<mailto:vcs-pkg-discuss-request@lists.alioth.debian.org?subject=unsubscribe>
List-Archive: <http://lists.alioth.debian.org/pipermail/vcs-pkg-discuss>
List-Post: <mailto:vcs-pkg-discuss@lists.alioth.debian.org>
List-Help: <mailto:vcs-pkg-discuss-request@lists.alioth.debian.org?subject=help>
List-Subscribe: <http://lists.alioth.debian.org/mailman/listinfo/vcs-pkg-discuss>,
	<mailto:vcs-pkg-discuss-request@lists.alioth.debian.org?subject=subscribe>
Mime-version: 1.0
Sender: vcs-pkg-discuss-bounces+gcpv-vcs-pkg-discuss=m.gmane.org@lists.alioth.debian.org
Errors-To: vcs-pkg-discuss-bounces+gcpv-vcs-pkg-discuss=m.gmane.org@lists.alioth.debian.org
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: vcs-pkg-discuss-bounces+gcpv-vcs-pkg-discuss=m.gmane.org@lists.alioth.debian.org
X-SA-Exim-Scanned: No (on alioth.debian.org); SAEximRunCond expanded to false
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91697>


--===============0226844854829706067==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Bert Wesarg <bert.wesarg@googlemail.com> [2008.08.07.1658 -0300=
]:
> Should be doable, I think. At least you can get a topological sorted
> list of the TopGit branches (with git show-branch --topo-order <list
> of TopGit-branches>). But than it get complicated, because you don't
> need the diff from branch-base to branch-head, this would only work
> for a single dependent list of topic branches.

Hm, I am not entirely following. I understand that I can get
a topological list of branches, but why don't I need the diff from
branch-base to branch-head?

Also, what happens if branches cross-merge?

--=20
 .''`.   martin f. krafft <madduck@debian.org>
: :'  :  proud Debian developer, author, administrator, and user
`. `'`   http://people.debian.org/~madduck - http://debiansystem.info
  `-  Debian - when you have better things to do than fixing systems
=20
don't hate yourself in the morning -- sleep till noon.

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkicfSsACgkQIgvIgzMMSnUq1QCgtpjFdQ38s0PgKE6+7+2iN/tf
KM0An0UbRZ7sDwfuXfOLdAWJ4d7637ms
=3grt
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--


--===============0226844854829706067==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
