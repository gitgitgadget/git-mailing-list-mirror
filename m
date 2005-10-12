From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [PATCH] Add git-index-pack utility
Date: Wed, 12 Oct 2005 19:01:56 +0400
Message-ID: <20051012150156.GB2539@master.mivlgu.local>
References: <20051012173426.56fd5c1c.vsu@altlinux.ru> <20051012135405.CDE55E005E3@center4.mivlgu.local> <Pine.LNX.4.63.0510121632040.6307@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 12 17:04:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPi7G-00083F-H5
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 17:02:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbVJLPB6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 11:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbVJLPB6
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 11:01:58 -0400
Received: from mivlgu.ru ([81.18.140.87]:60289 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S964805AbVJLPB6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Oct 2005 11:01:58 -0400
Received: by master.mivlgu.local (Postfix, from userid 1000)
	id 2D5C218010F; Wed, 12 Oct 2005 19:01:56 +0400 (MSD)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0510121632040.6307@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10034>


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 12, 2005 at 04:33:17PM +0200, Johannes Schindelin wrote:
> you cheated! You use mmap(), not lseek()! Note that mmap() is more=20
> efficient only if the platform provides mmap()...

Yes, I need to steal some code for handling the deflated streams from
unpack-objects.c...

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDTSVkW82GfkQfsqIRAvm/AJ9yNmcuJMgNGlxRwiBWE9H1UnPzpwCgg3c0
wuJs9nqXZYhQMswIJdB1XP8=
=U3Et
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
