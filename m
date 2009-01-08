From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Can I prevent someone clone my git repository?
Date: Thu, 8 Jan 2009 15:32:57 +0100
Message-ID: <20090108143257.GX21154@genesis.frugalware.org>
References: <856bfe0e0901072303i4fcd3bf6u99790ab9f4170937@mail.gmail.com> <7vr63e42ke.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901081227170.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="55pgo4yTr53jOkhk"
Cc: Junio C Hamano <gitster@pobox.com>,
	Emily Ren <lingyan.ren@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 08 15:34:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKvxn-0004QO-Sw
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 15:34:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757018AbZAHOdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 09:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755095AbZAHOc7
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 09:32:59 -0500
Received: from virgo.iok.hu ([212.40.97.103]:58902 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754871AbZAHOc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 09:32:59 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 3AB3D5809A;
	Thu,  8 Jan 2009 15:32:59 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 42D8F4465E;
	Thu,  8 Jan 2009 15:32:57 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 949FB11B8630; Thu,  8 Jan 2009 15:32:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901081227170.30769@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104921>


--55pgo4yTr53jOkhk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 08, 2009 at 12:27:59PM +0100, Johannes Schindelin <Johannes.Sch=
indelin@gmx.de> wrote:
> > like git://your-host/repository.git
>=20
> If the people are on different IPs, a hook can restrict who may clone,=20
> since commit v1.6.1-rc1~109.

Hmm, but I think there is no hook called "pre-send" or so that could
return status code 1 to prevent receiving, so that commit on its own
does not does what Emily needs here.

Or have I missed something?

--55pgo4yTr53jOkhk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklmDpkACgkQe81tAgORUJagVwCfdyv09O4HErStQy6GRAJoCpc+
5j8An0m8yg/dYwcYy2unyqP0uCi8AH2C
=A3hH
-----END PGP SIGNATURE-----

--55pgo4yTr53jOkhk--
