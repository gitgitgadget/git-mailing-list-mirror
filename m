From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: "warning: no common commits" triggered due to change of remote's IP address?
Date: Mon, 2 Mar 2009 09:56:42 +0100
Message-ID: <200903020956.45975.trast@student.ethz.ch>
References: <e38bce640903011001p2d705707o9f7145ab5ab68929@mail.gmail.com> <e38bce640903011501t2c7a134dp887f5a96db3db0f4@mail.gmail.com> <200903020940.24813.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart29433115.yD11nU1j4F";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Brent Goodrick <bgoodr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 09:58:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Le3yx-0007y5-3N
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 09:58:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756753AbZCBI5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 03:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756605AbZCBI5J
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 03:57:09 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:22103 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756667AbZCBI5J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 03:57:09 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 2 Mar 2009 09:57:07 +0100
Received: from thomas.localnet ([129.132.153.233]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 2 Mar 2009 09:57:06 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.19-3.2-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <200903020940.24813.trast@student.ethz.ch>
X-OriginalArrivalTime: 02 Mar 2009 08:57:06.0283 (UTC) FILETIME=[DCCCCBB0:01C99B14]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111919>

--nextPart29433115.yD11nU1j4F
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thomas Rast wrote:
> If you still have a repo that can reproduce the problem, please keep a
> copy for future investigation, and then try
>=20
>   git fetch-pack -v $url refs/remotes/origin/home 2>&1 \
>   | git name-rev --stdin

Actually this should name the remote's idea of the ref, i.e.,

  git fetch-pack -v $url refs/heads/home 2>&1 \
  | git name-rev --stdin

Sorry.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart29433115.yD11nU1j4F
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmrn00ACgkQqUud07tmzP06dQCcD424grJ+L0ZHy90Riq5fNN2M
IvEAnAhrMcNVLD3LElKQJ3huKQkevW/p
=1+P8
-----END PGP SIGNATURE-----

--nextPart29433115.yD11nU1j4F--
