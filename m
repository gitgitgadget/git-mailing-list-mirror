From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [BUG?] Fail to pull from kernel.org: pack has bad object
Date: Mon, 20 Oct 2008 16:10:51 +0200
Message-ID: <200810201610.54427.trast@student.ethz.ch>
References: <200810201010.29173.johan@herland.net> <20081020121533.GA2177@coredump.intra.peff.net> <alpine.LFD.2.00.0810200955250.26244@xanadu.home>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4489048.9dC85Ff0fh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Oct 20 22:13:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrvUK-0000Cr-PL
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 16:12:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbYJTOKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 10:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752031AbYJTOKw
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 10:10:52 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:13199 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751535AbYJTOKw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 10:10:52 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 20 Oct 2008 16:10:51 +0200
Received: from pcjremy.inf.ethz.ch ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 20 Oct 2008 16:10:50 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.LFD.2.00.0810200955250.26244@xanadu.home>
X-OriginalArrivalTime: 20 Oct 2008 14:10:50.0653 (UTC) FILETIME=[A80EF4D0:01C932BD]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98697>

--nextPart4489048.9dC85Ff0fh
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Nicholas Pitre wrote:
> When index-pack dies like that, a temporary (and incomplete) pack file=20
> is left in .git/objects/pack/ with tmp in the file name.  I'd need only=20
> that to reproduce the issue.

Like this?

  http://n.ethz.ch/~trast/download/tmp_pack_NMj69p
 =20
=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch


--nextPart4489048.9dC85Ff0fh
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkj8kW4ACgkQqUud07tmzP2fdwCgk63+wGy6+ddAxWe8LGJL0j/7
A7MAn1LewegA6RzkZ5pNpEG0YWcZABVl
=XB+U
-----END PGP SIGNATURE-----

--nextPart4489048.9dC85Ff0fh--
