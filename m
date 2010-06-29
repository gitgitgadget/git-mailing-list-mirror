From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 4/5] merge_recursive: Fix renames across paths below
 D/F conflicts
Date: Wed, 30 Jun 2010 00:33:19 +0200
Message-ID: <20100629223319.GC31048@genesis.frugalware.org>
References: <1277773936-12412-1-git-send-email-newren@gmail.com>
 <1277773936-12412-5-git-send-email-newren@gmail.com>
 <20100629075442.GB31048@genesis.frugalware.org>
 <AANLkTimFBlWiK76quLW1TiUfueGISsW7ZIHgFUcFg4j8@mail.gmail.com>
 <AANLkTil7CdCoP3wLVKX0MEiwp8KaKWFLvRtUWzt2a3Nh@mail.gmail.com>
 <AANLkTilggM9-vBabNvJiYMiQZyZtJMLhfWleYKvuJNMv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ULJ2Z7kCM1hyNsWd"
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de, gitster@pobox.com, spearce@spearce.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 30 00:33:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTjMu-0001dG-Qq
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 00:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756499Ab0F2WdW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jun 2010 18:33:22 -0400
Received: from virgo.iok.hu ([212.40.97.103]:51881 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756258Ab0F2WdW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jun 2010 18:33:22 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 435A6580A0;
	Wed, 30 Jun 2010 00:33:20 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id CDEF344659;
	Wed, 30 Jun 2010 00:33:19 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id C8C9812D90F0; Wed, 30 Jun 2010 00:33:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTilggM9-vBabNvJiYMiQZyZtJMLhfWleYKvuJNMv@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149929>


--ULJ2Z7kCM1hyNsWd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 29, 2010 at 09:55:38AM -0600, Elijah Newren <newren@gmail.com> =
wrote:
> Well, as far as this particular if-block is concerned, blame suggests
> that you and Miklos were responsible (I apologize if gmail screws up
> and inserts line wrapping)::
>=20
> $ git blame -C -C -L 1020,1038 merge-recursive.c
> 9047ebbc (Miklos Vajna  2008-08-12 18:45:14 +0200 1020)
>                  if (mfi.clean &&
> 9047ebbc (Miklos Vajna  2008-08-12 18:45:14 +0200 1021)
>                      sha_eq(mfi.sha, ren1->pair->two->sha1) &&

And if you have a look at what commit 9047ebbc does, that's really just
about changing it to be part of libgit, so I could call it without
fork() from builtin-merge.

To sum up, I sadly have to say I don't know too much about the
merge-recursive internal sematics.

--ULJ2Z7kCM1hyNsWd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkwqdK8ACgkQe81tAgORUJYLvwCeNA27lfANthy60ruWT2pvdN5H
eLAAn1r48EkQECWpRlzy0ZCtlFAz/Wxp
=IpmK
-----END PGP SIGNATURE-----

--ULJ2Z7kCM1hyNsWd--
