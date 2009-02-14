From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 4/4] notes: refuse to edit notes outside refs/notes/
Date: Sat, 14 Feb 2009 20:56:38 +0100
Message-ID: <200902142056.42198.trast@student.ethz.ch>
References: <b36bbe2f7f0ede6a2caa47190ada868dd4c0099c.1234638466.git.trast@student.ethz.ch> <ac3c2ce272e8e7f3000349f682a5a4843aea34e6.1234638466.git.trast@student.ethz.ch> <alpine.DEB.1.00.0902142032210.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1389551.hUCO6CdmCU";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 14 20:58:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYQed-0004fY-M2
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 20:58:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116AbZBNT4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 14:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752046AbZBNT4w
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 14:56:52 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:25085 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752001AbZBNT4v (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 14:56:51 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 14 Feb 2009 20:56:50 +0100
Received: from thomas.localnet ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 14 Feb 2009 20:56:49 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <alpine.DEB.1.00.0902142032210.10279@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 14 Feb 2009 19:56:49.0991 (UTC) FILETIME=[5FEB4D70:01C98EDE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109910>

--nextPart1389551.hUCO6CdmCU
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Johannes Schindelin wrote:
> On Sat, 14 Feb 2009, Thomas Rast wrote:
> > Since it is supposed to be a plumbing frontend for the notes feature,
> > simply forbid editing notes with GIT_NOTES_REF pointing anywhere but
> > refs/notes/*.
>=20
> ACK.
>=20
> Except maybe for calling it "plumbing".  "git notes" is meant to be _the_=
=20
> porcelain of the "notes", and that is why I like the idea to restrict it=
=20
> to refs/notes/* for editing (not for anything else, though).

That's what I actually wanted to write.  Maybe I should go get more
coffee...

Thanks for the acks.  Will resend with 3/4 corrected, and add a
conversion to test_must_fail.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart1389551.hUCO6CdmCU
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmXIfoACgkQqUud07tmzP3OMQCglaQwq1EP9MwPTlShM7raFEtp
/v0An12DuJKOSOvsXuRBwIDCZ3Hy9ZTe
=hnqN
-----END PGP SIGNATURE-----

--nextPart1389551.hUCO6CdmCU--
