From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: how to backup git
Date: Mon, 12 May 2008 16:54:27 +0200
Message-ID: <20080512145426.GN27724@genesis.frugalware.org>
References: <4827DEF6.1050005@gmail.com> <87ej87is50.fsf@offby1.atm01.sea.blarg.net> <alpine.DEB.1.00.0805121428310.30431@racer> <48285087.3090402@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hnsKUeImFCk/igEn"
Cc: git@vger.kernel.org
To: bill lam <cbill.lam@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 16:55:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvZQs-0000pT-0c
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 16:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbYELOy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 10:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbYELOy3
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 10:54:29 -0400
Received: from virgo.iok.hu ([193.202.89.103]:49006 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750897AbYELOy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 10:54:28 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 7071E1B24FA;
	Mon, 12 May 2008 16:54:27 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 8A3574465E;
	Mon, 12 May 2008 16:46:51 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 245DC1190498; Mon, 12 May 2008 16:54:27 +0200 (CEST)
Mail-Followup-To: bill lam <cbill.lam@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <48285087.3090402@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81868>


--hnsKUeImFCk/igEn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2008 at 10:13:27PM +0800, bill lam <cbill.lam@gmail.com> wr=
ote:
> Thanks to all responders for quick reply. I still have a related question=
=2E=20
> svn has a hotcopy command to ensure integrity so that it is possible to=
=20
> backup without shutting down the svn server. If someone update the .git=
=20
> while I am performing backup using tar or rsync? Will the atomicity of th=
at=20
> commit still preserve in my backup copy?

the only problem can be when someone runs git-gc (as it runs git-prune)
while you are doing the backup. other commands never remove objects.

--hnsKUeImFCk/igEn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkgoWiIACgkQe81tAgORUJasAQCggZ512CR0HoDJzdm9aeXkNOZa
FWcAn33b417kiJEj/sHSt5zSfTvWhg5D
=WLzi
-----END PGP SIGNATURE-----

--hnsKUeImFCk/igEn--
