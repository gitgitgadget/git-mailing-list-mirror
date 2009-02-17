From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2 4/5] t3301: use test_must_fail instead of !
Date: Tue, 17 Feb 2009 09:46:48 +0100
Message-ID: <200902170946.52093.trast@student.ethz.ch>
References: <200902142056.42198.trast@student.ethz.ch> <7vvdrcnnl0.fsf@gitster.siamese.dyndns.org> <200902170944.08827.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2979715.Z9O2FAbS3v";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 09:48:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZLcs-0000tm-Mb
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 09:48:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbZBQIqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 03:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbZBQIqy
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 03:46:54 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:33625 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751022AbZBQIqy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 03:46:54 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 17 Feb 2009 09:46:52 +0100
Received: from thomas.localnet ([129.132.153.233]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 17 Feb 2009 09:46:52 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <200902170944.08827.trast@student.ethz.ch>
X-OriginalArrivalTime: 17 Feb 2009 08:46:52.0447 (UTC) FILETIME=[478E1AF0:01C990DC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110335>

--nextPart2979715.Z9O2FAbS3v
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thomas Rast wrote:
> Junio C Hamano wrote:
> > Thomas Rast <trast@student.ethz.ch> writes:
> >=20
> > > +	MSG=3D3 test_must_fail git notes edit
> >=20
> > test_must_fail is a shell function, and we have precedence 2d60615 (tes=
ts:
> > Avoid single-shot environment export for shell function invocation,
> > 2009-01-26) to avoid this construct.
>=20
> I see you took this into the pu branch (currently as 891840b).  I
> assumed you would simply drop it, given the incompatibility?  I'd
> rather have the slight chance of missing a segfault while git is
> trying to execute a shell script (what are the odds that it only does
> so for git-notes?) than be killed by an angry mob of ash users ;-)

Oh, you fixed it up locally, and the next one in the series too.
Thanks, and sorry for the noise!

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart2979715.Z9O2FAbS3v
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmaeXwACgkQqUud07tmzP1S/gCeN//w/mMqhM/Vqy6B8DAAX88c
nwgAoIHHKERJ9aDX5UNpF9l9EtebxAoo
=Cxa9
-----END PGP SIGNATURE-----

--nextPart2979715.Z9O2FAbS3v--
