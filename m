From: Martin Waitz <tali@admingilde.org>
Subject: Re: Improved git-gui blame viewer
Date: Mon, 4 Jun 2007 09:38:27 +0200
Message-ID: <20070604073827.GF16637@admingilde.org>
References: <20070602041723.GD7044@spearce.org> <f3rhme$2h9$1@sea.gmane.org> <20070604060720.GF4507@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aPdhxNJGSeOG9wFI"
Cc: Matthijs Melchior <mmelchior@xs4all.nl>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jun 04 09:38:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hv79B-0006J9-1V
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 09:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940AbXFDHi3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 03:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752086AbXFDHi3
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 03:38:29 -0400
Received: from mail.admingilde.org ([213.95.32.147]:42442 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940AbXFDHi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 03:38:28 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1Hv791-0006pE-C8; Mon, 04 Jun 2007 09:38:27 +0200
Content-Disposition: inline
In-Reply-To: <20070604060720.GF4507@spearce.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49076>


--aPdhxNJGSeOG9wFI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, Jun 04, 2007 at 02:07:20AM -0400, Shawn O. Pearce wrote:
> >   When clicking on a light gray line to become a green line, then
> >   adjacent areas are not correctly colored.  A few adjacent entries
> >   become all same gray... [Look around git-gui.sh:340]
>=20
> This (I think) is because of the way the color selections are
> being done.  git-gui is being stupid and just alternating colors to
> commits as they come in from `git blame --incremental`.  The thing
> about the incremental blame is I can receive data for any part of
> the file at any time.  So in general what happens is I get data for
> one part of the file, give it color A, then data for another part,
> give it color B, and then get data for part that is right next to the
> first A and assign it A again.  So you see chunks where there is no
> alternating...

If you use three colors you can always select one which is different
to the hunk above and below.  But I don't know if that would be
visually appealing...

Another nice thing would be a smooth gradient for each hunk.
Then we could use the same colors for every hunk, but the top of each
hunk would be a little bit lighter/darker than the bottom so that
it is easy to see the border.  Is that doable in Tk?
Perhaps a simple small line between hunks is enough, too?

--=20
Martin Waitz

--aPdhxNJGSeOG9wFI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGY8Fzj/Eaxd/oD7IRAqOkAJ9OU3rwFTz7uY2j81iEL4DxNJOOBACdFrsH
P1t6UehWjW0w1qZaxWXoeQ8=
=P2AQ
-----END PGP SIGNATURE-----

--aPdhxNJGSeOG9wFI--
