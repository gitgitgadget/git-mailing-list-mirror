From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC PATCH v2] fetch-pack: log(n)-transmission find_common()
Date: Tue, 28 Oct 2008 21:37:33 +0200
Message-ID: <200810282037.36275.trast@student.ethz.ch>
References: <1224790716-20551-1-git-send-email-trast@student.ethz.ch> <7vljw9h061.fsf@gitster.siamese.dyndns.org> <alpine.LFD.2.00.0810281034500.13034@xanadu.home>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart22280432.hnpdXruQRk";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Oct 28 20:39:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuuOv-0003Sc-4v
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 20:38:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbYJ1Thg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 15:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752368AbYJ1Thg
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 15:37:36 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:18984 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751650AbYJ1Thf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 15:37:35 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Oct 2008 20:37:33 +0100
Received: from [192.168.0.4] ([84.75.157.245]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Oct 2008 20:37:32 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.LFD.2.00.0810281034500.13034@xanadu.home>
X-OriginalArrivalTime: 28 Oct 2008 19:37:33.0057 (UTC) FILETIME=[9F4E6F10:01C93934]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99315>

--nextPart22280432.hnpdXruQRk
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Nicolas Pitre wrote:
>=20
> FWIW, I had to back this patch out from my version as things seemed to=20
> fall into an infinite loop of ref negotiation while fetching the Linux=20
> kernel repository at some point.  Doing a "git fetch -v -v" turned up an=
=20
> endless stream of "got" and "have" lines.  I was in a hurry for $work so=
=20
> didn't think of preserving my local refs for reproduction of the=20
> problem.

Ah.  Thanks for the report, though having a test case would be great.
I've been running it without problems since I completed v2 more than a
month ago, so I don't expect it to be an obvious mistake.

=2D Thomas

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch


--nextPart22280432.hnpdXruQRk
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkkHagAACgkQqUud07tmzP0+rgCgj4K+Jdtl6hiPwIumX58BRBaV
T+UAnAv+zID0zSroGLXaTBjoIXm2EYqc
=Q54D
-----END PGP SIGNATURE-----

--nextPart22280432.hnpdXruQRk--
