From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: Problem with clone hanging
Date: Mon, 7 Aug 2006 21:52:01 +0400
Message-ID: <20060807215201.b54da1ce.vsu@altlinux.ru>
References: <1154968942.26375.23.camel@sardonyx>
	<20060807171240.GA19907@harddisk-recovery.com>
	<1154971295.26375.48.camel@sardonyx>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__7_Aug_2006_21_52_01_+0400_TT_Z9KuP=DeSw.e."
Cc: Erik Mouw <erik@harddisk-recovery.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 07 19:52:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GA9HJ-0006DR-Dl
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 19:52:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWHGRwd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 13:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbWHGRwd
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 13:52:33 -0400
Received: from master.altlinux.org ([62.118.250.235]:22277 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP
	id S1750823AbWHGRwc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Aug 2006 13:52:32 -0400
Received: from procyon.home (localhost.localdomain [127.0.0.1])
	by master.altlinux.org (Postfix) with ESMTP
	id C326BE3256; Mon,  7 Aug 2006 21:52:24 +0400 (MSD)
Received: by procyon.home (Postfix, from userid 500)
	id B2116E3669E; Mon,  7 Aug 2006 21:52:01 +0400 (MSD)
To: Bryan O'Sullivan <bos@serpentine.com>
In-Reply-To: <1154971295.26375.48.camel@sardonyx>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.17; i586-alt-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25022>

--Signature=_Mon__7_Aug_2006_21_52_01_+0400_TT_Z9KuP=DeSw.e.
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 07 Aug 2006 10:21:35 -0700 Bryan O'Sullivan wrote:

> On Mon, 2006-08-07 at 19:12 +0200, Erik Mouw wrote:
>=20
> > Looks like the same problem that kernel.org used to have. The other
> > side probably runs git-1.4.0, they should upgrade to 1.4.1.
>=20
> OK, thanks for the helpful response.
>=20
> >  In the mean
> > time, you could clone using http and later on switch to git transport.
>=20
> It seems like Mellanox doesn't publish that repository over HTTP, so I'm
> stuck.  Tziporet, can you upgrade your git installation, please?

In the meantime, you can try to specify a local clone of the mainline
Linux repository with the --reference=3D... option to git-clone.  Then
the server will need to send only objects which do not exist in the
mainline tree, and should be able to prepare the pack faster.

--Signature=_Mon__7_Aug_2006_21_52_01_+0400_TT_Z9KuP=DeSw.e.
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.17 (GNU/Linux)

iD8DBQFE133BW82GfkQfsqIRAjHyAJ9p9yOz5SAHCKfCzEy+MCLcIVo6RwCbBOP0
QNU0woDTAKsT8dttc/sWV5U=
=roNM
-----END PGP SIGNATURE-----

--Signature=_Mon__7_Aug_2006_21_52_01_+0400_TT_Z9KuP=DeSw.e.--
