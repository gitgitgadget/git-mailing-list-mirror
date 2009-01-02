From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2 1/3] rebase: learn to rebase root commit
Date: Fri, 2 Jan 2009 23:54:15 +0100
Message-ID: <200901022354.17922.trast@student.ethz.ch>
References: <200812301323.30550.trast@student.ethz.ch> <200901022320.14055.trast@student.ethz.ch> <7vzli9b9y6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1333007.ayK46nt1XZ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 02 23:55:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIsvS-00074K-FJ
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 23:55:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbZABWyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 17:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758282AbZABWyG
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 17:54:06 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:4007 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758215AbZABWyF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 17:54:05 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 2 Jan 2009 23:54:02 +0100
Received: from [192.168.0.3] ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 2 Jan 2009 23:54:01 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <7vzli9b9y6.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 02 Jan 2009 22:54:01.0855 (UTC) FILETIME=[013DC0F0:01C96D2D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104441>

--nextPart1333007.ayK46nt1XZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
>=20
> > I'm still not sure what ${1+"$@"} was about by the way.
>=20
> It is one of the many old-timer's portability idioms that let us work
> around bugs in some ancient shell implementations.
>=20
> ${1+"$@"} should be equivalent to "$@" in modern Bourne shell variants
> that are POSIX compliant.

So do you want me to change it back to ${1+"$@"}?

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch


--nextPart1333007.ayK46nt1XZ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklemxkACgkQqUud07tmzP0negCffmSKpNQCLHw33UR1R5RoPPWP
SI4An0k6FYhTxxFJ39yM8+lbyLBEV0Ov
=NUaC
-----END PGP SIGNATURE-----

--nextPart1333007.ayK46nt1XZ--
