From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 1/2] t3412: clean up GIT_EDITOR usage
Date: Mon, 2 Feb 2009 09:39:21 +0100
Message-ID: <200902020939.24131.trast@student.ethz.ch>
References: <200901302343.39921.trast@student.ethz.ch> <1233355621-4783-1-git-send-email-trast@student.ethz.ch> <alpine.DEB.1.00.0902012322490.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1427885.DTtizNijLF";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junio@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 02 09:41:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTuML-0001Dm-RN
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 09:40:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbZBBIjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 03:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751631AbZBBIjY
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 03:39:24 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:38372 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751604AbZBBIjY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 03:39:24 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 2 Feb 2009 09:39:23 +0100
Received: from thomas.localnet ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 2 Feb 2009 09:39:22 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.25.20-0.1-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <alpine.DEB.1.00.0902012322490.3586@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 02 Feb 2009 08:39:22.0451 (UTC) FILETIME=[BF23EA30:01C98511]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108072>

--nextPart1427885.DTtizNijLF
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Johannes Schindelin wrote:
> On Fri, 30 Jan 2009, Thomas Rast wrote:
> > +# we always run the interactive rebases unchanged, so just disable the=
 editor
> > +GIT_EDITOR=3D:
> > +export GIT_EDITOR
> > +
>=20
> According to my analysis, this is unneeded.  Just leave GIT_EDITOR alone=
=20
> in the whole test.

You're right, test-lib.sh sets GIT_EDITOR=3D and EDITOR=3D:, so the above
is unneeded (but harmless).

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart1427885.DTtizNijLF
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmGsTwACgkQqUud07tmzP3/twCbBWigk39s28QiH59Qi3k7oynl
QIcAnjIv3SkCpv5B3ZQ7Yn498Q9UO19C
=kXng
-----END PGP SIGNATURE-----

--nextPart1427885.DTtizNijLF--
