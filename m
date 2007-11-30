From: Jan Hudec <bulb@ucw.cz>
Subject: Re: git bug/feature request
Date: Fri, 30 Nov 2007 19:21:21 +0100
Message-ID: <20071130182121.GC30048@efreet.light.src>
References: <200711271127.41161.gapon007@gmail.com> <figv47$926$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 19:21:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyAUk-0000WZ-TO
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 19:21:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762842AbXK3SV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 13:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761587AbXK3SV2
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 13:21:28 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:58361 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760622AbXK3SV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 13:21:27 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 91B3F578AC;
	Fri, 30 Nov 2007 19:21:26 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id SCeMcx1TsRyq; Fri, 30 Nov 2007 19:21:24 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 2FC21575AA;
	Fri, 30 Nov 2007 19:21:24 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1IyAUL-0003Uh-Oo; Fri, 30 Nov 2007 19:21:21 +0100
Content-Disposition: inline
In-Reply-To: <figv47$926$1@ger.gmane.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66652>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2007 at 12:30:16 +0100, Jakub Narebski wrote:
> gapon wrote:
>=20
> > hi all,
> > first of all i don't know if there's a bugzilla or something similar
> > for git - i have found just this email (on http://git.or.cz/ webpage).
>=20
> There isn't any bug tracker for git. Use git mailing list for bug
> reports and feature requests.
>=20
> > i have discovered "weird" behaviour of git in this scenario*:
> > - user A is working in repo A
> > - user B clones repo A
> > - user B makes some changes, commits, pushes
>=20
> Do not push into checked out branch!

Push is the only non-local operation, that could break the checked out stat=
e,
right? Than it should be possible to add a check that a push is trying to
change the checked-out ref and detach the HEAD if so.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHUFShRel1vVwhjGURAmKtAJ9jZVTEGRs86z6gbzgU/Ifel9ZvowCglH1P
VOuz3BdIho9hkTQ6mAtMmJc=
=h8zA
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
