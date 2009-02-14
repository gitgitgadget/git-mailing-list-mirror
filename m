From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2] gc: make --prune useful again by accepting an optional parameter
Date: Sat, 14 Feb 2009 23:38:43 +0100
Message-ID: <200902142338.46632.trast@student.ethz.ch>
References: <1234545279-23153-1-git-send-email-trast@student.ethz.ch> <alpine.DEB.1.00.0902142301030.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0902142306400.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart12256260.xUn7GUfJYL";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Jan =?utf-8?q?Kr=C3=BCger?= <jk@jk.gs>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 14 23:40:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYTBQ-0001wR-Lr
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 23:40:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344AbZBNWi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 17:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752164AbZBNWi4
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 17:38:56 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:42008 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752138AbZBNWi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 17:38:56 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 14 Feb 2009 23:38:54 +0100
Received: from thomas.localnet ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 14 Feb 2009 23:38:54 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <alpine.DEB.1.00.0902142306400.10279@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 14 Feb 2009 22:38:54.0506 (UTC) FILETIME=[042E88A0:01C98EF5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109945>

--nextPart12256260.xUn7GUfJYL
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Johannes Schindelin wrote:
> With this patch, "git gc --no-prune" will not prune any loose (and
> dangling) object, and "git gc --prune=3D5.minutes.ago" will prune
> all loose objects older than 5 minutes.
>=20
> This patch benefitted from suggestions by Thomas Rast and Jan Kr=FCger.
>=20
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  Documentation/git-gc.txt |   10 +++++++++-
>  builtin-gc.c             |   19 ++++++++++++-------
>  t/t5304-prune.sh         |   38 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 59 insertions(+), 8 deletions(-)

Ack.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart12256260.xUn7GUfJYL
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmXR/YACgkQqUud07tmzP25aACfZ0njPnxHtQnfC2efmLfwpWI9
YK4An1acDIq8zcLXt2TOpEKTggzMQcor
=zK65
-----END PGP SIGNATURE-----

--nextPart12256260.xUn7GUfJYL--
