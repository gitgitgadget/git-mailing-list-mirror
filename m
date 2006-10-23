From: Jelmer Vernooij <jelmer@samba.org>
Subject: Re: VCS comparison table
Date: Mon, 23 Oct 2006 20:26:41 +0200
Organization: Samba Team
Message-ID: <1161628001.27312.8.camel@charis.lan.vernstok.nl>
References: <45357CC3.4040507@utoronto.ca>
	 <200610231953.19605.jnareb@gmail.com>
	 <Pine.LNX.4.64.0610231103460.3962@g5.osdl.org>
	 <200610232021.55625.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-TyxRxP0TvpsvO89LXzaq"
Cc: Linus Torvalds <torvalds@osdl.org>,
	James Henstridge <james@jamesh.id.au>,
	bazaar-ng@lists.canonical.com,
	"Matthew D. Fuller" <fullermd@over-yonder.net>,
	Andreas Ericsson <ae@op5.se>, Carl Worth <cworth@cworth.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 20:27:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc4W1-0001lX-1H
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 20:27:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbWJWS1J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 14:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964998AbWJWS1J
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 14:27:09 -0400
Received: from smtp-vbr11.xs4all.nl ([194.109.24.31]:55822 "EHLO
	smtp-vbr11.xs4all.nl") by vger.kernel.org with ESMTP
	id S964996AbWJWS1G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 14:27:06 -0400
Received: from rhonwyn.vernstok.nl (a62-251-123-16.adsl.xs4all.nl [62.251.123.16])
	by smtp-vbr11.xs4all.nl (8.13.8/8.13.8) with ESMTP id k9NIQtU3056705;
	Mon, 23 Oct 2006 20:26:56 +0200 (CEST)
	(envelope-from jelmer@samba.org)
Received: from localhost (localhost [127.0.0.1])
	by rhonwyn.vernstok.nl (Postfix) with ESMTP id 30BFC39A3C1;
	Mon, 23 Oct 2006 20:26:47 +0200 (CEST)
Received: from rhonwyn.vernstok.nl ([127.0.0.1])
	by localhost (rhonwyn.vernstok.nl [127.0.0.1]) (amavisd-new, port 10024)
	with SMTP id 27714-07; Mon, 23 Oct 2006 20:26:34 +0200 (CEST)
Received: from charis.vernstok.nl (charis.vernstok.nl [IPv6:2001:7b8:37b:1:210:dcff:fecb:a9e3])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by rhonwyn.vernstok.nl (Postfix) with ESMTP id C7EDE39A3B8;
	Mon, 23 Oct 2006 20:26:33 +0200 (CEST)
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610232021.55625.jnareb@gmail.com>
X-Mailer: Evolution 2.6.3 
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29854>


--=-TyxRxP0TvpsvO89LXzaq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-10-23 at 20:21 +0200, Jakub Narebski wrote:
> Linus Torvalds wrote:
> > On Mon, 23 Oct 2006, Jakub Narebski wrote:
> >>=20
> >> Besides, you need [constant] network access for this mapping.
> >=20
> > I _think_ that Aaron was trying to say that
> >=20
> > 	abentley@panoramicfeedback.com-20060927202832-9795d0528e311e31
> >=20
> > is always constant, so you can use that.
> >=20
> > Of course, nobody will ever do that, because in practice they're not=20
> > shown, the same way the "true" BK revision names were never shown and t=
hus=20
> > never really used.
>=20
> By the way, I wonder if accidentally identical revisions
> (see example for accidental clean merge on revctrl.org)
> would get the same revision id in bzr. In git they would.
They won't. The revision id is made up of the committers email address,
a timestamp and a bunch of random data. It wouldn't be hard to switch
using checksums as revids instead, but I don't think there are any plans
in that direction.

Cheers,

Jelmer
--=20
Jelmer Vernooij <jelmer@samba.org> - http://samba.org/~jelmer/

--=-TyxRxP0TvpsvO89LXzaq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFPQlhPa9Uoh7vUnYRAonsAJ4/Dm/7VysbDHJNb4ePDmeyhXZg+ACeOERr
tNPhhbEuDy91T1LTD6GbyGY=
=wuEA
-----END PGP SIGNATURE-----

--=-TyxRxP0TvpsvO89LXzaq--
