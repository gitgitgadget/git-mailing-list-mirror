From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Splitting up a changeset
Date: Mon, 20 Aug 2007 21:53:51 +0200
Message-ID: <20070820195351.GF8542@efreet.light.src>
References: <e1bf234c0708200632g3a2282bfr76863555493d513@mail.gmail.com> <20070820193128.GC5544@steel.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iBwuxWUsK/REspAd"
Cc: Frank Showman <fshowman@googlemail.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 21:54:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INDK8-0001iz-E1
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 21:54:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953AbXHTTx7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 15:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752856AbXHTTx7
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 15:53:59 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:47504 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751105AbXHTTx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 15:53:58 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id C70A95730E;
	Mon, 20 Aug 2007 21:53:57 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id ZnQaqBBWtSYA; Mon, 20 Aug 2007 21:53:54 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 539F7573E0;
	Mon, 20 Aug 2007 21:53:53 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1INDJv-0006yz-Ba; Mon, 20 Aug 2007 21:53:51 +0200
Content-Disposition: inline
In-Reply-To: <20070820193128.GC5544@steel.home>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56245>


--iBwuxWUsK/REspAd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 20, 2007 at 21:31:28 +0200, Alex Riesen wrote:
> Frank Showman, Mon, Aug 20, 2007 15:32:11 +0200:
> > What happens to remote repositories that already have the big
> > original changeset (and possibly changes based on it)?
>=20
> If someone (or something) has already fetched, pulled, cloned or
> otherwise copied them, you basically can't do anything anymore.
> It is a thing you fundamentally cannot do, unless you're prepared to
> deal with consequences. Not hard, but can be unexpected for some.

If something might already be based on the unsplit change, you probably want
to make the last commit of the split be a merge from the unsplit. Merge will
notice that the changes on both sides are the same and resolve them cleanly
and any further merges won't see them as differences.

If only you or only people you know may have changes based on unsplit, you
can rebase those changes to split for slightly simpler history.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--iBwuxWUsK/REspAd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGyfFPRel1vVwhjGURAtdWAKC35BCCsYNzOcgf0lrxJRxGNrpZbQCdGwuh
MPB+dG9E6R377li6VOgxSFE=
=r3eH
-----END PGP SIGNATURE-----

--iBwuxWUsK/REspAd--
