From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: git bundle vs git rev-list
Date: Fri, 5 Dec 2014 23:42:02 +0000
Message-ID: <20141205234201.GC223328@vauxhall.crustytoothpaste.net>
References: <CAL3By--xYnXFUdDP3MDxAxvfeBT3ArFrdAV=apzdWg6_kiD2Yg@mail.gmail.com>
 <20141205231350.GB223328@vauxhall.crustytoothpaste.net>
 <xmqq4mt9oecp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rQ2U398070+RC21q"
Cc: Jesse Hopkins <jesse.hops@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 00:42:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx2Vr-0003nH-15
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 00:42:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753096AbaLEXmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 18:42:09 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:55051 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752676AbaLEXmI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Dec 2014 18:42:08 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 7150B2808F;
	Fri,  5 Dec 2014 23:42:05 +0000 (UTC)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	Jesse Hopkins <jesse.hops@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <xmqq4mt9oecp.fsf@gitster.dls.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.17-1-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260917>


--rQ2U398070+RC21q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 05, 2014 at 03:40:06PM -0800, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > On Fri, Dec 05, 2014 at 03:36:18PM -0700, Jesse Hopkins wrote:
> >> 1. Any thoughts on why a tag would be included by 'git bundle', when
> >> 'git rev-list' with the same arguments returns empty?
> >
> > I think the answer to this is found in the git rev-list manpage:
> >
> >   List commits that are reachable by following the parent links from the
> >   given commit(s), but exclude commits that are reachable from the
> >   one(s) given with a ^ in front of them.
> >
> > The operative word here is "commits".  A bundle might include one or
> > more tag objects, or unannotated tags, even though no new commits were
> > available within the time frame.
>=20
> Is this what a recent "git bundle create" change in 2.1.1 and 2.2
> fixed?  The Release Notes to them seem to have this entry:
>=20
>  * "git bundle create" with date-range specification were meant to
>    exclude tags outside the range, but it did not work correctly.

That certainly could be the case.  I was thinking that perhaps someone
had created a tag recently, but your explanation is more likely.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--rQ2U398070+RC21q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUgkLJAAoJEL9TXYEfUvaLaW0P+QF6x2rdUhUnGf13Z3mNAAWV
Snt1MuopzuP2nkYu+pOfTUrd3bNmX1a5tYCEmLTP6n+MZEP9xLav/kBtBfWWVhOB
ZIDD66rSvzZQw68jFuNeMR8JpIip4HV2nr7Eo14gvzY4vUHiZjT8dbtpaYQNVCuV
aBz+5WberJTjm8gbKhawvc87FkS1UNCPQu575uJSO17jVV8vxEVZEYfTzVvucDhr
zOVAS0uvm1KmD4/7Sk/8CASXreAyWwpoD2xQdQYMT2mukQ0jOS1QwYOXzqhxLOgz
axxtoY+lsFmc6wD5gpDQz/lUgj+hAQuLJbbSymBycV5lLqT0u5jfzKigtTfZYBO/
FFKZuFvZ4V7pQtctjKJdB4mW9yDQI3YI//MOLxEtUBMfDP6dQSDmuyUnk4YA7WAZ
L5/iXa3mRo7HWMyW3hNg28jXA/2rZPxWh/KU9trvVfal5ZGvdj5jZRP5xl7jA05X
WCSwl2WBwQ45qVTDNT5pbj6zLa85PuZ5YlsZoVim6S+NYQ3GezecoNNZ1KUylWan
uAQ3yFduGdaZDHxioDqO5v5BmRdnKqiJ3BG5cHMrct7qDZckkNrN9OPRM3Jo+iDh
1lCPHShbdddy208iwaUSi5PqjtweF2iAmm1tmuWP9NiAM3wtFkC76CgXOH5/Qh7n
fTvmvC2FUPpbSffYkZbe
=bE2e
-----END PGP SIGNATURE-----

--rQ2U398070+RC21q--
