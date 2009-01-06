From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Migration problems from SVN
Date: Tue, 6 Jan 2009 13:39:47 +0100
Message-ID: <200901061339.49843.trast@student.ethz.ch>
References: <c09652430901060409p23d2737ck6e41b3f8f1eaf01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1337752.VhF7tIIfpv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "=?utf-8?q?=C3=98yvind?= Harboe" <oyvind.harboe@zylin.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 13:41:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKBFR-0005Os-O0
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 13:41:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754153AbZAFMjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 07:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754136AbZAFMjh
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 07:39:37 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:3286 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754107AbZAFMjf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 07:39:35 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 6 Jan 2009 13:39:34 +0100
Received: from pcjremy.inf.ethz.ch ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 6 Jan 2009 13:39:33 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <c09652430901060409p23d2737ck6e41b3f8f1eaf01@mail.gmail.com>
X-OriginalArrivalTime: 06 Jan 2009 12:39:33.0802 (UTC) FILETIME=[D3D250A0:01C96FFB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104681>

--nextPart1337752.VhF7tIIfpv
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

=D8yvind Harboe wrote:
> If I early on and accidentally commit a *large* binary object, how do I g=
et rid
> of it from .git again?

git-filter-branch can do that.  See the top of the EXAMPLES section in

  http://www.kernel.org/pub/software/scm/git/docs/git-filter-branch.html

This requires a rewrite of all history affected; make sure you
understand the implications if you have already published it.  See the
DISCUSSION in the same manpage.

Also note that due to the distributed nature, you cannot force such
changed history upon anyone; i.e., you cannot remove the objects from
anyone else's repository.  You can only ask them to accept your new
history and forget that the old one was ever there.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch



--nextPart1337752.VhF7tIIfpv
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkljURUACgkQqUud07tmzP2jWQCfahMpT68yHN2UsOn4IUEGIn5Q
QRAAnimaKZiAwYWluQiosvbd+lGuyjQP
=Ab6t
-----END PGP SIGNATURE-----

--nextPart1337752.VhF7tIIfpv--
