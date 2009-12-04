From: Nathaniel W Filardo <nwf@cs.jhu.edu>
Subject: Endianness bug in git-svn or called component?
Date: Fri, 4 Dec 2009 12:44:58 -0500
Message-ID: <20091204174458.GV17192@gradx.cs.jhu.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PgFjNgMZ2k7V6t4+"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 04 19:08:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGcaB-0003Rs-2H
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 19:08:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbZLDSIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 13:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbZLDSIb
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 13:08:31 -0500
Received: from blaze.cs.jhu.edu ([128.220.13.50]:56881 "EHLO blaze.cs.jhu.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932315AbZLDSIa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 13:08:30 -0500
X-Greylist: delayed 1418 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Dec 2009 13:08:30 EST
Received: from gradx.cs.jhu.edu (gradx.cs.jhu.edu [128.220.13.52])
	by blaze.cs.jhu.edu (8.14.3/8.14.3) with ESMTP id nB4Hiw95005584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Fri, 4 Dec 2009 12:44:58 -0500 (EST)
Received: from gradx.cs.jhu.edu (localhost.localdomain [127.0.0.1])
	by gradx.cs.jhu.edu (8.14.2/8.13.1) with ESMTP id nB4Hiwai030268
	for <git@vger.kernel.org>; Fri, 4 Dec 2009 12:44:58 -0500
Received: (from nwf@localhost)
	by gradx.cs.jhu.edu (8.14.2/8.13.8/Submit) id nB4Hiwie030266
	for git@vger.kernel.org; Fri, 4 Dec 2009 12:44:58 -0500
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134559>


--PgFjNgMZ2k7V6t4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On this machine,

mirrors hydra:/tank0/mirrors/misc% uname -a
FreeBSD hydra.priv.oc.ietfng.org 9.0-CURRENT FreeBSD 9.0-CURRENT #13: Sat N=
ov 14 19:40:25 EST 2009 root@hydra.priv.oc.ietfng.org:/systank/obj/systank/=
src/sys/NWFKERN  sparc64

attempting to fetch from an svn source yields the following error:

rs hydra:/tank0/mirrors/misc% git svn init -s https://joshua.svn.sourceforg=
e.net/svnroot/joshua test-joshua
Initialized empty Git repository in /tank0/mirrors/misc/test-joshua/.git/  =
                                    =20
mirrors hydra:/tank0/mirrors/misc% cd test-joshua                          =
                                    =20
mirrors hydra:/tank0/mirrors/misc/test-joshua% git svn fetch
        A       scripts/distributedLM/config.template      =20
[...]
        A       build.xml
r1 =3D fe84a7d821ec6d92da75133ac7ad1deb476b6484 (refs/remotes/trunk)
error: index uses  extension, which we do not understand
fatal: index file corrupt
write-tree: command returned error: 128

Even on previously initialized and fetched git-svn repos, "git svn fetch"
produces the same response.

This is the same symptom as an older bug, but I have not attempted to track
down what's going wrong this time in hopes that somebody more familiar can
fix it faster; see
http://kerneltrap.org/mailarchive/git/2006/5/28/205750/thread#mid-205750 .

If there's anything more that would be helpful to know, please just ask.

Thanks.
--nwf;

--PgFjNgMZ2k7V6t4+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAksZSpoACgkQTeQabvr9Tc9+DwCfWgomrm2XIjksojfIIgDIZumU
tfQAmQHidvWLZn87gK4VjWC/sHtNKVrl
=zVWq
-----END PGP SIGNATURE-----

--PgFjNgMZ2k7V6t4+--
