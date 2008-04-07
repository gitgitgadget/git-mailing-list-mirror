From: Luciano Rocha <luciano@lsd.di.uminho.pt>
Subject: Re: git repo being corrupted?
Date: Mon, 7 Apr 2008 17:47:38 +0100
Message-ID: <20080407164738.GA4053@bit.office.eurotux.com>
References: <47F9F1A1.30009@diamand.org> <20080407111740.GA12776@bit.office.eurotux.com> <47FA03C4.9030104@diamand.org> <20080407113921.GA13667@bit.office.eurotux.com> <20080407161525.GA25894@old.davidb.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
To: Luke Diamand <luke@diamand.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 07 18:48:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiuWK-0000f3-GA
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 18:48:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbYDGQrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2008 12:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbYDGQrv
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 12:47:51 -0400
Received: from linux.di.uminho.pt ([193.136.19.96]:44344 "EHLO
	dcs.lsd.di.uminho.pt" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751115AbYDGQrv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2008 12:47:51 -0400
Received: (qmail 16947 invoked by uid 89); 7 Apr 2008 16:47:47 -0000
Received: from unknown (HELO bit.office.eurotux.com) (luciano@lsd.di.uminho.pt@81.84.255.161)
  by dcs.lsd.di.uminho.pt with ESMTPA; 7 Apr 2008 16:47:47 -0000
Content-Disposition: inline
In-Reply-To: <20080407161525.GA25894@old.davidb.org>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78979>


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 07, 2008 at 09:15:25AM -0700, David Brown wrote:
>  On Mon, Apr 07, 2008 at 12:39:21PM +0100, Luciano Rocha wrote:
>=20
> >> > You're using XFS. Did you have a power fail in the recent past?
> >> How did you know?
> >
> > XFS doesn't order metadata writes with data writes, so if the power
> > fails, it can find an update in the journal but the data wasn't written.
> > Then it fills the file with zeroes to the new size.
>=20
>  This behavior should be a lot better for recent kernels.

To be fair, it hasn't happened to me lately. But I haven't lost power
often, so I can't say it's fixed. ;)

>  xfs does even better with write barriers.  But any file change that is m=
ore
>  than one write can be corrupted or split by an inopportune powerdown.

Maybe, but I'm still waiting for barrier support through device-mapper.

--=20
lfr
0/0

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFH+lAqinSul6a7oB8RAqYJAJ4gsbmJPoNnJstSd+qbiN9XMxQPiACcDQIk
lONffvG2n40Mv0zpJ0NPCJ8=
=UREd
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
