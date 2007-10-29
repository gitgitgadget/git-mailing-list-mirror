From: Jan Hudec <bulb@ucw.cz>
Subject: Re: remote#branch
Date: Mon, 29 Oct 2007 18:40:00 +0100
Message-ID: <20071029174000.GA4449@efreet.light.src>
References: <20071015233800.6306e414@paolo-desktop> <20071016021933.GH12156@machine.or.cz> <Pine.LNX.4.64.0710161139530.25221@racer.site> <20071016210904.GI26127@efreet.light.src> <Pine.LNX.4.64.0710162228560.25221@racer.site> <20071027204757.GA3058@efreet.light.src> <Pine.LNX.4.64.0710280000240.4362@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Cc: Petr Baudis <pasky@suse.cz>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 29 18:48:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImYip-0007TW-5W
	for gcvg-git-2@gmane.org; Mon, 29 Oct 2007 18:48:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755534AbXJ2Rrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 13:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755494AbXJ2Rrm
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 13:47:42 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:50210 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755448AbXJ2Rrl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 13:47:41 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id A66DA57361;
	Mon, 29 Oct 2007 18:47:39 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id 6Lb1w5QZl-AH; Mon, 29 Oct 2007 18:47:36 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 9BD8257374;
	Mon, 29 Oct 2007 18:47:35 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1ImYam-0001AC-Lm; Mon, 29 Oct 2007 18:40:00 +0100
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710280000240.4362@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62623>


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 28, 2007 at 00:01:57 +0100, Johannes Schindelin wrote:
> Hi,
>=20
> On Sat, 27 Oct 2007, Jan Hudec wrote:
>=20
> > On Tue, Oct 16, 2007 at 22:35:25 +0100, Johannes Schindelin wrote:
> >
> > > ',' is allowed in ref names, so ',' is out.
> >=20
> > Actually since many characters that are allowed in ref name are not=20
> > allowed in URL at all, the ref-name has to be url-escaped. Which brings=
=20
> > all characters back in, because they can always be specified escaped.
>=20
> No.  The URL part of it has to be encoded.  But the ref names do _not_. =
=20
> (If we really want to have a way to specify the remote URL and the=20
> branch(es) we want to fetch _at the same time_.)

If the branch names are not url-escaped, than the result is not an URL. Whi=
ch
is just ugly and confusing. If it looks like an URL, it should better be on=
e.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHJhrwRel1vVwhjGURAkXDAJ4gno+DGGilsGjOAiWBC3+XFismewCgt2lr
uLO6pHPWKvXc24SGX3dZU/o=
=PF+I
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
