From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [RFC] Authenticate push via PGP signature, not SSH
Date: Mon, 28 Jan 2008 22:06:40 +0100
Message-ID: <20080128210640.GC5788@efreet.light.src>
References: <479D5611.4010205@vilain.net> <20080128081258.GE24004@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 28 22:07:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJbCJ-0001lL-Qe
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 22:07:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752038AbYA1VGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 16:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbYA1VGr
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 16:06:47 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:51009 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751818AbYA1VGq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 16:06:46 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 444B157285;
	Mon, 28 Jan 2008 22:06:45 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id mtNeneeNzQ3Y; Mon, 28 Jan 2008 22:06:42 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 8896C57283;
	Mon, 28 Jan 2008 22:06:42 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1JJbBg-0001f9-PT; Mon, 28 Jan 2008 22:06:40 +0100
Content-Disposition: inline
In-Reply-To: <20080128081258.GE24004@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71900>


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 28, 2008 at 03:12:58 -0500, Shawn O. Pearce wrote:
> Sam Vilain <sam@vilain.net> wrote:
> > This does force potential contributors to get PGP keys, and get them
> > signed - but that seems to me to be a reasonable barrier of entry and
> > may even help drive some PGP adoption.
>=20
> In many cases today such contributers would have been forced to get
> an SSH account on the server they want to push to.  Getting an SSH
> account configured and a key installed may be more difficult than
> generating a PGP key pair and emailing in the public key.

Actually no. SSH key pair is good enough in current situation. In fact
it might be *better* than SSH account, because with SSH account, the user
either has or does not have write access, while with SSH key pair he is sti=
ll
subject to limitations enforced by the receive-hook.

> Of course the PGP based system is nicer in that the administrator
> might get a public key that has been signed by others he trusts,
> and thus is more readily able to verify that the contributor is
> who they think it is.

That, however, is an advantage of PGP. Obviously, additional rules can still
be enforced by the receive-hook.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHnkPgRel1vVwhjGURAi7+AKCZmTa38K6FT+hgJwHiqrj2bMJm8QCgqMWd
QEnzcWkVt4jywJSMKvi7rvE=
=n2kG
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
