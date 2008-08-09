From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: keeping /etc under git with etckeeper
Date: Sun, 10 Aug 2008 01:42:32 +0200
Message-ID: <20080809234232.GB18960@genesis.frugalware.org>
References: <14b409fc0808091148k69f4019n6996261a710adfca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Cc: git@vger.kernel.org
To: Pierre-Julien Bringer <pj.bringer@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 10 01:42:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRy4P-0001GM-Td
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 01:42:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455AbYHIXlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 19:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753409AbYHIXlA
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 19:41:00 -0400
Received: from virgo.iok.hu ([193.202.89.103]:47124 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752809AbYHIXk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 19:40:59 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 7F92E1B2504;
	Sun, 10 Aug 2008 01:40:57 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 8FF3544699;
	Sun, 10 Aug 2008 00:50:05 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 778B41190007; Sun, 10 Aug 2008 01:42:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <14b409fc0808091148k69f4019n6996261a710adfca@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91795>


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 09, 2008 at 08:48:39PM +0200, Pierre-Julien Bringer <pj.bringer=
@gmail.com> wrote:
> 3 If Git has some sort of merge conflict on important config files
> (passwd, etc...), it would be pretty bad [3].
>=20
> When using etckeeper:
> 1 There would be a link between the changes if a commit occurs between ta=
sks.

I don't exactly see what the problem is here.

> 2 Permissions are stored thanks to Metastore.

Actually it no longer uses metastore, but yes, etckeeper handles
permissions properly, so it is not a problem. The second problem is
point 3) from your previous list, but that's easy to avoid: never ever
merge, rebase (or any other task that can result in a conflict) in your
/etc.

In short, if you want to just track your directory, then it's OK, but if
you want to use git to handle the config of multiple machines, it'll be
too problematic, I would not suggest doing so.

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkieK2gACgkQe81tAgORUJbWUwCfSe1yQfBtxWbjhvHNtmVINBb+
GFoAniAh8Qkwb4lu52Q1vVHSRr0azPtA
=eauc
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
