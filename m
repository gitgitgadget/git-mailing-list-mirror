From: Nico Schottelius <nico-git-20080428@schottelius.org>
Subject: Re: git push: failed to push some refs and missing commit
Date: Mon, 28 Apr 2008 19:56:10 +0200
Message-ID: <20080428175610.GB10794@denkbrett.schottelius.org>
References: <20080428171020.GF23412@denkbrett.schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 19:57:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqXb5-0000Tc-1a
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 19:57:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933424AbYD1R4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 13:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933249AbYD1R4P
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 13:56:15 -0400
Received: from mx2.schottelius.org ([62.65.138.77]:33750 "EHLO
	mx2.schottelius.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932787AbYD1R4O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 13:56:14 -0400
Received: from denkbrett.schottelius.org (natgw.netstream.ch [62.65.128.28])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.schottelius.org (Postfix) with ESMTPSA id 8CF183480F7
	for <git@vger.kernel.org>; Mon, 28 Apr 2008 19:56:06 +0200 (CEST)
Received: by denkbrett.schottelius.org (Postfix, from userid 1000)
	id D6CC52DA02; Mon, 28 Apr 2008 19:56:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080428171020.GF23412@denkbrett.schottelius.org>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Unix-Info: http://unix.schottelius.org/
X-Netzseite: http://nico.schottelius.org/
X-System-Info: denkbrett running Linux 2.6.25-denkbrett on x86_64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80572>


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Nico Schottelius [Mon, Apr 28, 2008 at 07:10:20PM +0200]:
> Error 2:
>=20
> I miss a commit, that removed the function hideContent();
> [...]

I found out that one of our webdevs used git push -f, which may be
a good reason for that.

Could error 1 also be caused by that?

Nico


--=20
Think about Free and Open Source Software (FOSS).
http://nico.schottelius.org/documentations/foss/the-term-foss/

PGP: BFE4 C736 ABE5 406F 8F42  F7CF B8BE F92A 9885 188C

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIFg+6uL75KpiFGIwRAm0mAJwIHFwMyRyj5jwASfFq2PgYPjEudQCeIx3l
1TSiUGgJRbrCVDOtpFo62Dw=
=XnQA
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--
