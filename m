From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 0/2] request-pull: protect against OPTIONS_KEEPDASHDASH
 from environment
Date: Mon, 26 Apr 2010 02:12:56 +0200
Message-ID: <20100426001256.GJ19595@genesis.frugalware.org>
References: <20100424120437.GA12237@progeny.tock>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RdFV+w+cvF4K0RSy"
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 02:13:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6Bwm-0004uz-3M
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 02:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753359Ab0DZANF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Apr 2010 20:13:05 -0400
Received: from virgo.iok.hu ([212.40.97.103]:48781 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753239Ab0DZANE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 20:13:04 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 132E258070;
	Mon, 26 Apr 2010 02:12:57 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id A647E42F09;
	Mon, 26 Apr 2010 02:12:56 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 044561240005; Mon, 26 Apr 2010 02:12:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100424120437.GA12237@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145775>


--RdFV+w+cvF4K0RSy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 24, 2010 at 07:10:10AM -0500, Jonathan Nieder <jrnieder@gmail.c=
om> wrote:
> At last, the mysterious t7400 test failure has been solved, thanks to
> Gerrit Pape.  It was caused by an assumption in git that a certain
> variable not in its namespace would not be set.
>=20
> Here???s a problem of the same kind, though harder to trip.  I can???t
> imagine why anyone would be exporting the OPTIONS_KEEPDASHDASH
> variable, but it is not in git???s namespace so it seems better not
> to make any assumptions.

Ack - I really just did cosmetics on request-pull's output, nothing
more. :)

--RdFV+w+cvF4K0RSy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkvU2ogACgkQe81tAgORUJYlgACaAmz2Ecgvwq6kF957GkBH16L6
OzoAniLLkzV2a2Waf8xYnkpTh9f8LKn8
=ELQ+
-----END PGP SIGNATURE-----

--RdFV+w+cvF4K0RSy--
