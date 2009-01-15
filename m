From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] checkout: implement "-" shortcut name for last branch
Date: Thu, 15 Jan 2009 15:01:24 +0100
Message-ID: <200901151501.26394.trast@student.ethz.ch>
References: <1231977976-8739-1-git-send-email-trast@student.ethz.ch> <alpine.DEB.1.00.0901150141570.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3045446.mvk5VelMy5";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junio@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 15 15:02:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNSno-0002z5-Bj
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 15:02:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757682AbZAOOBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 09:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757642AbZAOOBK
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 09:01:10 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:45332 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756228AbZAOOBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 09:01:09 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 15 Jan 2009 15:01:07 +0100
Received: from pcjremy.inf.ethz.ch ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 15 Jan 2009 15:01:07 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0901150141570.3586@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 15 Jan 2009 14:01:07.0586 (UTC) FILETIME=[B6763E20:01C97719]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105813>

--nextPart3045446.mvk5VelMy5
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Johannes Schindelin wrote:
> On Thu, 15 Jan 2009, Thomas Rast wrote:
>=20
> > Let git-checkout save the old branch as a symref in LAST_HEAD, and
> > make 'git checkout -' switch back to LAST_HEAD, like 'cd -' does in
> > the shell.
>=20
> Actually, what you want is in the reflog, no?  So... parsing=20
> .git/logs/HEAD for the latest occurrence of "checkout: moving from " and=
=20
> then using everything up until the next space should give you the branch=
=20
> name, right?

It just feels wrong to grab that information from there; it's a
free-form comment field for user consumption.  And it wasn't even that
hard to implement a LAST_HEAD.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch


--nextPart3045446.mvk5VelMy5
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklvQbYACgkQqUud07tmzP0v4wCfVt6SoLG7bCDUJFSbCmIFOS6t
nTwAoIUTEYJubtdz64VhxJxiO5vHHEoG
=2kQz
-----END PGP SIGNATURE-----

--nextPart3045446.mvk5VelMy5--
