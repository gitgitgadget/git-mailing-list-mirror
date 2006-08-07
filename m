From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: Problem with clone hanging
Date: Mon, 7 Aug 2006 22:32:30 +0400
Message-ID: <20060807183230.GA14955@procyon.home>
References: <1154968942.26375.23.camel@sardonyx> <20060807171240.GA19907@harddisk-recovery.com> <1154971295.26375.48.camel@sardonyx> <20060807215201.b54da1ce.vsu@altlinux.ru> <1154975000.26375.86.camel@sardonyx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Cc: Erik Mouw <erik@harddisk-recovery.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 07 20:34:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GA9ue-00007T-Ci
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 20:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWHGSdK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 14:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWHGSdK
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 14:33:10 -0400
Received: from master.altlinux.org ([62.118.250.235]:36878 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP id S932299AbWHGSdJ
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 7 Aug 2006 14:33:09 -0400
Received: from procyon.home (localhost.localdomain [127.0.0.1])
	by master.altlinux.org (Postfix) with ESMTP
	id F1DA4E35B7; Mon,  7 Aug 2006 22:33:01 +0400 (MSD)
Received: by procyon.home (Postfix, from userid 500)
	id D0743E3669E; Mon,  7 Aug 2006 22:32:30 +0400 (MSD)
To: Bryan O'Sullivan <bos@serpentine.com>
Content-Disposition: inline
In-Reply-To: <1154975000.26375.86.camel@sardonyx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25025>


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 07, 2006 at 11:23:20AM -0700, Bryan O'Sullivan wrote:
> On Mon, 2006-08-07 at 21:52 +0400, Sergey Vlasov wrote:
>=20
> > In the meantime, you can try to specify a local clone of the mainline
> > Linux repository with the --reference=3D... option to git-clone.=20
>=20
> Thanks.  I don't know if what I'm cloning is actually a kernel tree,
> unfortunately.

At least git ls-remote git://www.mellanox.co.il/~git/infiniband
suggests this.  Of course, it might contains some completely unrelated
branches (with git this is possible), but at least you won't need to
download the whole kernel history since 2.6.12-rc2.

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFE14c+W82GfkQfsqIRAmItAJ9xPUE5YFLO6qcHEaQyYVT10ryw7wCdFak6
BZgDXHaUawM7sbwwsYWydSI=
=Bj3Z
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
