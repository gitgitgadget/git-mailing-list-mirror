From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git-svn-import or CVS import from local HD rather than remote.
Date: Thu, 12 Jun 2008 21:23:54 +0200
Message-ID: <20080612192354.GO29404@genesis.frugalware.org>
References: <Pine.LNX.4.64.0806121214210.18454@xenau.zenez.com> <20080612185545.GN29404@genesis.frugalware.org> <Pine.LNX.4.64.0806121315540.18454@xenau.zenez.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KWqj/C5KzoWE0Q2t"
Cc: Git List <git@vger.kernel.org>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 21:24:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6sPj-0001H1-WF
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 21:24:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980AbYFLTX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 15:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753092AbYFLTX4
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 15:23:56 -0400
Received: from virgo.iok.hu ([193.202.89.103]:40366 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752042AbYFLTX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 15:23:56 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 411371B2517;
	Thu, 12 Jun 2008 21:23:55 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 690E44469A;
	Thu, 12 Jun 2008 21:05:19 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id ED7351770022; Thu, 12 Jun 2008 21:23:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0806121315540.18454@xenau.zenez.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84775>


--KWqj/C5KzoWE0Q2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2008 at 01:20:40PM -0600, Boyd Lynn Gerber <gerberb@zenez.c=
om> wrote:
> Thanks, I was not sure which I should use,  I had tried both with similar=
=20
> results.  Here is what I used with git-svn
>=20
> > git-svn clone /working/svn/networking/wireshark .
> Initialized empty Git repository in .git/
> Bad URL passed to RA layer: Unrecognized URL scheme for=20
> '/working/svn/networking/wireshark' at /usr/bin/git-svn line 934

I would try "git-svn clone file:///working/svn/networking/wireshark".

See also the svn-remote.<name>.rewriteRoot setting in the git-svn
manpage.

--KWqj/C5KzoWE0Q2t
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhRd8oACgkQe81tAgORUJaVZgCgiQTJeZgob5mYZuj4Sod5SNIi
C7QAoIOyyODqwjOWY7DyqBRSXQhHyo++
=wrqZ
-----END PGP SIGNATURE-----

--KWqj/C5KzoWE0Q2t--
