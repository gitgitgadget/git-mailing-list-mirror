From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC/RFH] Fun things with git-notes, or: patch tracking backwards
Date: Wed, 11 Feb 2009 00:12:30 +0100
Message-ID: <200902110012.34717.trast@student.ethz.ch>
References: <200902091508.11460.trast@student.ethz.ch> <200902102342.29962.trast@student.ethz.ch> <7v7i3xlwz4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1660041.dKqZOfxfBT";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 00:14:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX1nt-0001Nz-GH
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 00:14:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756125AbZBJXMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 18:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754895AbZBJXMm
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 18:12:42 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:34693 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756057AbZBJXMl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 18:12:41 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 11 Feb 2009 00:12:40 +0100
Received: from thomas.localnet ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 11 Feb 2009 00:12:40 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <7v7i3xlwz4.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 10 Feb 2009 23:12:40.0161 (UTC) FILETIME=[11E9F510:01C98BD5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109338>

--nextPart1660041.dKqZOfxfBT
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
>=20
> > I have imported all commits, and mails since roughly July 2008
> > (starting with Gmane 89000).  In this timeframe there were 1802
> > non-merge commits, and the mailnotes tree now holds 1122 annotations.
>=20
> How do you match the mails to commits?
>=20
> I am curious what the right balance for the matching algorithm should be,
> between being forgiving about amending of commit log message and the patch
> text to fix minor typos and obvious bugs, and being strict not to cause
> false matches to a message that contains the second iteration of the
> patch, when what was committed was the first iteration.

Right now it's just the patch-id.  Maybe filtering (author,subject)
and then picking the one that is the most similar could work.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart1660041.dKqZOfxfBT
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmSCeIACgkQqUud07tmzP033QCfTgibvZMq50z8UvweG6Peupvp
2mYAoJIgBtXlw8gy7h6C0R8OtwNiNoYc
=gFIT
-----END PGP SIGNATURE-----

--nextPart1660041.dKqZOfxfBT--
