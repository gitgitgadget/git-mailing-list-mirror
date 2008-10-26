From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] add -p: warn if only binary changes present
Date: Sun, 26 Oct 2008 12:28:09 +0200
Message-ID: <200810261128.14735.trast@student.ethz.ch>
References: <1224884916-20369-1-git-send-email-trast@student.ethz.ch> <20081026051013.GD21178@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3454408.HVfYsEObHh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junio@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 26 11:29:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ku2sD-0000Gr-HS
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 11:29:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360AbYJZK2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2008 06:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752298AbYJZK2P
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 06:28:15 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:6881 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752270AbYJZK2O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 06:28:14 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 26 Oct 2008 11:28:12 +0100
Received: from [192.168.0.8] ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 26 Oct 2008 11:28:12 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <20081026051013.GD21178@coredump.intra.peff.net>
X-OriginalArrivalTime: 26 Oct 2008 10:28:12.0108 (UTC) FILETIME=[8C3940C0:01C93755]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99155>

--nextPart3454408.HVfYsEObHh
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Jeff King wrote:
> > +			print STDERR "No changes except to binary files.\n";
>=20
> This wording seems a little awkward to me, though. Maybe
>=20
>   No changed text files.
>=20
> ?

I tried to make a more precise statement.  "No changed text files"
also holds if no files at all were changed.  A user can only infer
that there _are_ binary changes if he knows that the message in the
latter case would have been "No changes".

That being said, it is somewhat awkward, I just couldn't come up with
a better message with this meaning.  I considered some other options,
such as giving a hint to use git-add or running git-status for the
user, but these would have been far more verbose.

=2D Thomas

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch



--nextPart3454408.HVfYsEObHh
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkkERj4ACgkQqUud07tmzP2RTQCgnq4iXY2wC5l+c684gL+yLkjL
oMoAnAsjxd9nvSdi313yfi5GhgFtzV3K
=4hJh
-----END PGP SIGNATURE-----

--nextPart3454408.HVfYsEObHh--
