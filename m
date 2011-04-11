From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: gitattributes - clean filter invoked on pull?
Date: Mon, 11 Apr 2011 11:31:14 +0200
Message-ID: <20110411093114.GY5146@genesis.frugalware.org>
References: <20110411084229.GW5146@genesis.frugalware.org>
 <20110411091919.GE28959@kytes>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bwMunqOr7B7rzQrh"
Cc: git@vger.kernel.org, timar74@gmail.com
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 11:31:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9DT8-0002FW-Bu
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 11:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755197Ab1DKJbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 05:31:22 -0400
Received: from virgo.iok.hu ([212.40.97.103]:43592 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754990Ab1DKJbV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 05:31:21 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id CB58C580CA;
	Mon, 11 Apr 2011 11:31:14 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 90F8744965;
	Mon, 11 Apr 2011 11:31:14 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 90047BAC005; Mon, 11 Apr 2011 11:31:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110411091919.GE28959@kytes>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171320>


--bwMunqOr7B7rzQrh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 11, 2011 at 02:49:21PM +0530, Ramkumar Ramachandra <artagnon@gm=
ail.com> wrote:
> > Is this a bug? I don't exactly understand why this would be necessary.
>=20
> From config.txt:
> - 'clean' is "The command which is used to convert the content of a
> worktree file to a blob upon checkin".
> - 'smudge' is "The command which is used to convert the content of a
> blob object to a worktree file upon checkout."
>=20
> According to the documentation, 'smudge' is *supposed* to be invoked
> on a clone/ pull, since it involves a checkout.  I don't see how you
> can avoid running these filters on every checkin/ checkout unless you
> cache the result somewhere.

That's not a problem - the issue I pointed out is that the 'clean' one
is invoked on pull/clone, and it takes time if it's applied to several
files.

'smudge' is just a 'cat', I don't care about it. :)

Thanks.

--bwMunqOr7B7rzQrh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk2iymIACgkQe81tAgORUJY37wCeLX8q6uTDgRQ9mCB/yvRCGzzK
SvIAmwXTOwvvNF8XnRXZDxkH1Zgwn1H4
=W3Ba
-----END PGP SIGNATURE-----

--bwMunqOr7B7rzQrh--
