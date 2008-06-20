From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 09/11] Introduce filter_independent() in commit.c
Date: Fri, 20 Jun 2008 15:25:06 +0200
Message-ID: <20080620132506.GZ29404@genesis.frugalware.org>
References: <45f73cd0355a5375dcd8a123dd0facf5cad99061.1213917600.git.vmiklos@frugalware.org> <f41fbf4630e6341ae89eacad52c465cecc605e42.1213917600.git.vmiklos@frugalware.org> <702cfa09fdf6203e1199415af21de787c4a19ead.1213917600.git.vmiklos@frugalware.org> <adba33a239d99b30fcccedc0638b060daec1016e.1213917600.git.vmiklos@frugalware.org> <6323597c45d409498ce231b063737bb36c52ef9f.1213917600.git.vmiklos@frugalware.org> <172740d7c998269dd0c454a1365a429acdf7cae2.1213917600.git.vmiklos@frugalware.org> <c83288c0995a7b4463b66e2f45d1a14839f0901c.1213917600.git.vmiklos@frugalware.org> <0d95a099ad6e47c60894983ab7bfd94a3aeddce7.1213917600.git.vmiklos@frugalware.org> <7vabhgq02p.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0806201350000.32725@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="j6SHqnckpA+VQtNZ"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 20 15:26:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9gdf-0003Vx-21
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 15:26:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755727AbYFTNZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 09:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754780AbYFTNZJ
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 09:25:09 -0400
Received: from virgo.iok.hu ([193.202.89.103]:40075 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754027AbYFTNZI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 09:25:08 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 3D5061B2510;
	Fri, 20 Jun 2008 15:25:07 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 0638444668;
	Fri, 20 Jun 2008 15:02:28 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id E37CB1190AD9; Fri, 20 Jun 2008 15:25:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0806201350000.32725@wbgn129.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85644>


--j6SHqnckpA+VQtNZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2008 at 01:53:06PM +0200, Johannes Schindelin <Johannes.Sch=
indelin@gmx.de> wrote:
> A test case would be desirable, but probably pretty complicated.  Hmm.  I=
=20
> like tests when they are simple, because they are easy to verify by a=20
> human.  Miklos, any chance for such a test case?

Not that complicated:

http://repo.or.cz/w/git/vmiklos.git?a=3Dcommit;h=3Dc19b568714c7141e9f96ebea=
3990f7dae615223b

At the moment it passes on master and fails on mv/merge-in-c.

--j6SHqnckpA+VQtNZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhbr7IACgkQe81tAgORUJYblwCfcx8VU7t+OsBfo+y8Nqls+RLt
3acAoJkiDPg9ZJkpuNdG7ydS7YabkMmd
=L4o5
-----END PGP SIGNATURE-----

--j6SHqnckpA+VQtNZ--
