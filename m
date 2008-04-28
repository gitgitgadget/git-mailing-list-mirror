From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] git-daemon: fix for rotating logs
Date: Mon, 28 Apr 2008 20:21:14 +0200
Message-ID: <20080428182114.GF26880@genesis.frugalware.org>
References: <alpine.DEB.1.00.0804281523040.5399@eeepc-johanness> <7vtzhmaqpd.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804281908290.19187@eeepc-johanness>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Rgf3q3z9SdmXC6oT"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 28 20:22:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqXzG-0001ee-Vj
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 20:22:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935208AbYD1SVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 14:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935219AbYD1SVS
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 14:21:18 -0400
Received: from virgo.iok.hu ([193.202.89.103]:52543 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933074AbYD1SVR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 14:21:17 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 66AB61B253A;
	Mon, 28 Apr 2008 20:21:15 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id C8EB644659;
	Mon, 28 Apr 2008 20:17:34 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id C63CE1190AC9; Mon, 28 Apr 2008 20:21:14 +0200 (CEST)
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0804281908290.19187@eeepc-johanness>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80577>


--Rgf3q3z9SdmXC6oT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2008 at 07:08:50PM +0100, Johannes Schindelin <Johannes.Sch=
indelin@gmx.de> wrote:
> > > With rotating logs, there is a problem when the syslog is opened only=
=20
> > > once (in the beginning).  So open the log everytime we write=20
> > > something, and close it directly after writing.
> >=20
> > Gaah, this is ugly.
> >=20
> > Is this something all the daemons need to deal with?
>=20
> I have no idea, but it seems to fix a real issue.

logrotate supports sending a signal (typically SIGHUP) to the process
after it rotated the log. Couldn't we just re-open the log on SIGHUP?

--Rgf3q3z9SdmXC6oT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)

iEYEARECAAYFAkgWFZoACgkQe81tAgORUJbjCgCeIexen1rv7SPlpBwq59OP9FkK
SMIAniAU7mDzBkjKARTS9AxvPVEL09TN
=GaPr
-----END PGP SIGNATURE-----

--Rgf3q3z9SdmXC6oT--
