From: Luciano Rocha <luciano@eurotux.com>
Subject: Re: Mirroring mySQL using Git
Date: Tue, 6 May 2008 14:24:22 +0100
Message-ID: <20080506132422.GA13125@bit.office.eurotux.com>
References: <4B58A837F454E14AA0453EDBADE96A62B5F2A2@mildred.leeds-art.ac.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Cc: git@vger.kernel.org
To: Ryan Taylor <ryan.taylor@leeds-art.ac.uk>
X-From: git-owner@vger.kernel.org Tue May 06 15:25:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtNAV-0000Xs-69
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 15:25:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbYEFNYa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 09:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbYEFNYa
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 09:24:30 -0400
Received: from os.eurotux.com ([216.75.63.6]:57881 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751023AbYEFNYa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 09:24:30 -0400
Received: (qmail 7445 invoked from network); 6 May 2008 13:24:28 -0000
Received: from nc.eurotux.com (HELO bit.office.eurotux.com) (luciano@81.84.255.161)
  by os.eurotux.com with AES256-SHA encrypted SMTP; 6 May 2008 13:24:28 -0000
Content-Disposition: inline
In-Reply-To: <4B58A837F454E14AA0453EDBADE96A62B5F2A2@mildred.leeds-art.ac.uk>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81358>


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 06, 2008 at 02:03:01PM +0100, Ryan Taylor wrote:
> Hi,
>=20
> I'm wanting to mirror my mysql databases from my live web box to my dev
> box. The database are updated by a CMS on the live box and I need to be
> able to transfer these updates to the dev box.
>=20
> Is this possible with git?

You'd be better off with asynchronous replication. See
<http://dev.mysql.com/doc/refman/5.0/en/replication.html>.

Note that you go the git route, or other file-based solution, you'll
have to freeze operations to the filesystem where the DBs reside, or
you'll corrupt the copy.

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkggXAYACgkQinSul6a7oB98xQCdHoD0g5l/SxDKdpl4wRotP1Jw
46oAn3Vu5Ed34cE0bnFVRl5n19MPqs3O
=Nq5C
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
