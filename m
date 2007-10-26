From: "Fernando J. Pereda" <ferdy@gentoo.org>
Subject: Re: [PATCH] git-mailsplit: with maildirs try to process new/ if
	cur/ is empty
Date: Fri, 26 Oct 2007 18:01:18 +0200
Message-ID: <20071026160118.GA5076@ferdyx.org>
References: <20071026141539.29928.qmail@d3691352d65cf2.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Fri Oct 26 18:11:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlRme-000771-M5
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 18:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754650AbXJZQLU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 12:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753314AbXJZQLU
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 12:11:20 -0400
Received: from 170.Red-213-96-222.staticIP.rima-tde.net ([213.96.222.170]:47420
	"EHLO smtp.ferdyx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754650AbXJZQLT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 12:11:19 -0400
X-Greylist: delayed 580 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Oct 2007 12:11:18 EDT
Received: from localhost (localhost [127.0.0.1])
	by smtp.ferdyx.org (Postfix) with ESMTP id 89B558D30C;
	Fri, 26 Oct 2007 18:02:21 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at ferdyx.org
Received: from smtp.ferdyx.org ([127.0.0.1])
	by localhost (tungsteno.ferdyx.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3NwUWitjbfcL; Fri, 26 Oct 2007 18:02:04 +0200 (CEST)
Received: from posidon.ferdyx.org (posidon.ferdyx.org [192.168.0.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.ferdyx.org (Postfix) with ESMTP id 0BB438D308;
	Fri, 26 Oct 2007 18:02:04 +0200 (CEST)
Received: by posidon.ferdyx.org (nbSMTP-1.01-cvs) for uid 1000
	(using TLSv1/SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	ferdy@gentoo.org; Fri, 26 Oct 2007 18:01:18 +0200 (CEST)
Mail-Followup-To: "Fernando J. Pereda" <ferdy@gentoo.org>,
	Gerrit Pape <pape@smarden.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20071026141539.29928.qmail@d3691352d65cf2.315fe32.mid.smarden.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62422>


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 26, 2007 at 02:15:39PM +0000, Gerrit Pape wrote:
> When saving patches to a maildir with e.g. mutt, the files are put into
> the new/ subdirectory of the maildir, not cur/.  This makes git-am state
> "Nothing to do.".  This patch lets git-mailsplit fallback to new/ if the
> cur/ subdirectory is empty.
>=20
> This was reported by Joey Hess through
>  http://bugs.debian.org/447396
>=20

By that reasoning, you should make it parse both cur/ and new/.

This didn't bit me because I always check mails I queue, so they ended
up in cur/.

Other than that, ack from me.

- ferdy

--=20
Fernando J. Pereda Garcimart=EDn
20BB BDC3 761A 4781 E6ED  ED0B 0A48 5B0C 60BD 28D4

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHIg9OCkhbDGC9KNQRAsOgAJ9qB9m4S9g4Ve6s5loY0iYULgQQeQCffIdb
XfzclRmt1FgNzmzZU52NxgQ=
=O4/c
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
