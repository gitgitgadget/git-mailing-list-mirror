From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 1/2] clone: Add an option to set up a mirror
Date: Fri, 1 Aug 2008 16:27:32 +0200
Message-ID: <20080801142732.GS32057@genesis.frugalware.org>
References: <alpine.DEB.1.00.0808011600170.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JF3gJ4dyZQSNE+Mq"
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 01 16:29:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOvcp-0004O7-Ni
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 16:29:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbYHAO1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 10:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbYHAO1h
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 10:27:37 -0400
Received: from virgo.iok.hu ([193.202.89.103]:44322 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751064AbYHAO1h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 10:27:37 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 661791B253A;
	Fri,  1 Aug 2008 16:27:35 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id B8FE24465E;
	Fri,  1 Aug 2008 15:41:08 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 028001770071; Fri,  1 Aug 2008 16:27:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0808011600170.9611@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91069>


--JF3gJ4dyZQSNE+Mq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 01, 2008 at 04:00:45PM +0200, Johannes Schindelin <Johannes.Sch=
indelin@gmx.de> wrote:
>=20
> The command line
>=20
> 	$ git clone --mirror $URL
>=20
> is now a short-hand for
>=20
> 	$ git clone --bare $URL
> 	$ (cd $(basename $URL) && git remote add --mirror origin $URL)

Funny, someone asked exactly this on #git yesterday (IIRC), but we ended
up using clone & remote, since I didn't find clone --mirror in the man.
;-)

Thanks!

--JF3gJ4dyZQSNE+Mq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiTHVQACgkQe81tAgORUJZrrgCgm/LpspXSMAVkvMoJh61ruCJj
TDEAn2mVXeHP7abnkjdkQg5WXZTeC9lS
=u3ZG
-----END PGP SIGNATURE-----

--JF3gJ4dyZQSNE+Mq--
