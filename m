From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC PATCH] format-patch: thread as reply to cover letter even with in-reply-to
Date: Tue, 17 Feb 2009 00:27:04 +0100
Message-ID: <200902170027.09406.trast@student.ethz.ch>
References: <cover.1234801852.git.trast@student.ethz.ch> <200902162134.28850.trast@student.ethz.ch> <m3bpt2t8a6.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1405767.nhKByW6jN2";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jakub Narebski <jnareb@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 00:28:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZCtJ-0001VY-0j
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 00:28:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbZBPX1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 18:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbZBPX1N
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 18:27:13 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:20400 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750727AbZBPX1M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 18:27:12 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 17 Feb 2009 00:27:11 +0100
Received: from thomas.localnet ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 17 Feb 2009 00:27:10 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <m3bpt2t8a6.fsf@localhost.localdomain>
X-OriginalArrivalTime: 16 Feb 2009 23:27:10.0585 (UTC) FILETIME=[17349E90:01C9908E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110262>

--nextPart1405767.nhKByW6jN2
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Jakub Narebski wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
> > Jay Soffian wrote:
>=20
> > > I think this change may be okay, but I think to go with it the
> > > cover-letter and all the patches should have a "References:" header
> > > with the message-id given by --in-reply-to.
> >=20
> > That's a completely separate issue.  I'm only proposing to change
> > what is formatted as a reply to what, the In-Reply-To and References
> > formatting is handled by the existing code.
[...]
> patches had both '--in-reply-to' message id AND cover letter id in
> "References:" header.  That would make for safer threading...

Oh, now I see what you meant.

It seems that right now, send-email appends the right references for
=2D-thread mode, and format-patch only does the one-reference case.
I'll try and make a patch for that.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart1405767.nhKByW6jN2
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmZ9k0ACgkQqUud07tmzP01+ACcD6fzC+P3cPs/AYJu6jTk1sUy
yuQAn1D7l2/Z1GA8jfBQrg2i3DfA9YYI
=sDrO
-----END PGP SIGNATURE-----

--nextPart1405767.nhKByW6jN2--
