From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [gitosis] unexpected error for a warning msg
Date: Sun, 3 May 2009 16:54:02 -0700
Message-ID: <20090503235402.GA10702@curie-int>
References: <20090503232300.GA20066@vidovic>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
To: Git Mailing List <git@vger.kernel.org>, nicolas.s.dev@gmail.com
X-From: git-owner@vger.kernel.org Mon May 04 01:55:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0lWh-0003Dt-S1
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 01:55:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754657AbZECXyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2009 19:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753420AbZECXyK
	(ORCPT <rfc822;git-outgoing>); Sun, 3 May 2009 19:54:10 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:39641 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753145AbZECXyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2009 19:54:09 -0400
Received: (qmail 12780 invoked from network); 3 May 2009 23:54:05 -0000
Received: from tsi-static.orbis-terrarum.net (HELO curie.orbis-terrarum.net) (76.10.188.108)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Sun, 03 May 2009 23:54:05 +0000
Received: (qmail 4587 invoked by uid 10000); 3 May 2009 16:54:02 -0700
Content-Disposition: inline
In-Reply-To: <20090503232300.GA20066@vidovic>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118197>


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 04, 2009 at 01:23:00AM +0200, Nicolas Sebrecht wrote:
> I had the following issue using gitosis today:
> http://colabti.org/irclogger/irclogger_log/git?date=3D2009-05-03#l2233
>=20
> The name of the key file was 'keydir/Jacques@BLACK_ANTEC.pub' which gave
> the warning (when pushing):=20
> WARNING:gitosis.ssh:Unsafe SSH username in keyfile: Jacques@BLACK_ANTEC.p=
ub
>=20
> Changing the filename into Jacques.pub solved the issue.
>=20
> I was expecting an error message instead (not a warning) as it seems to
> _not_ permit such a filename.
>=20
> Why the initial filename is fobidden?
> Could the warning be substituted by an error?
They are meant to be valid usernames, which don't include the @ symbol.

For the git.overlays.gentoo.org site, where we use gitosis, we had some
issues that were best solved by fixing Gitosis itself (like being able
to pass SSH key options, eg "from=3D" to restrict hosts). Another one that
bugged me was that the string at the end of an ssh key is NOT a
username, it's a freeform (well, no newline) text field.

I've tried to send the patches to upstream on several occasions, but
never gotten any response.=20

I didn't disable the warning you're complaining about, as I wanted it
still, but I do agree it's probably better to upgrade to an error.

You can find the Gentoo fork here:
http://git.overlays.gentoo.org/gitweb/?p=3Dproj/gitosis-gentoo.git;a=3Dsumm=
ary

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.10 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAkn+LpoACgkQPpIsIjIzwixMmwCeMTtHi2zvPTjCyInf8s1nKRVf
RJcAoMC5MXFDKRH15AxAS3XIa2ML7N/G
=/w0w
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
