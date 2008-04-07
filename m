From: Luciano Rocha <luciano@lsd.di.uminho.pt>
Subject: Re: git repo being corrupted?
Date: Mon, 7 Apr 2008 12:17:40 +0100
Message-ID: <20080407111740.GA12776@bit.office.eurotux.com>
References: <47F9F1A1.30009@diamand.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Mon Apr 07 13:25:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JipTu-0001lH-OF
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 13:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752894AbYDGLZD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2008 07:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752975AbYDGLZD
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 07:25:03 -0400
Received: from linux.di.uminho.pt ([193.136.19.96]:43935 "EHLO
	dcs.lsd.di.uminho.pt" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752868AbYDGLZB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2008 07:25:01 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Apr 2008 07:25:00 EDT
Received: (qmail 31650 invoked by uid 89); 7 Apr 2008 11:17:46 -0000
Received: from unknown (HELO bit.office.eurotux.com) (luciano@lsd.di.uminho.pt@81.84.255.161)
  by dcs.lsd.di.uminho.pt with ESMTPA; 7 Apr 2008 11:17:46 -0000
Content-Disposition: inline
In-Reply-To: <47F9F1A1.30009@diamand.org>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78969>


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 07, 2008 at 11:04:17AM +0100, Luke Diamand wrote:
> I've recently started to notice the following being reported:
>=20
> % git-status
> error: bad index file sha1 signature
> fatal: index file corrupt
>=20
> (a) Is there anything I can do to fix this (apart from git-clone from
> the repo and start over) ? git-fsck reports the same problem.

rm -f .git/index should do it.

> (b) What is causing it? Is it just my hard disk failing, or is it a bug?
> A memory test seems to be OK.
>=20
> Linux 2.6.22-3-amd64
> File system is XFS
> git version 1.5.4.4

You're using XFS. Did you have a power fail in the recent past?

--=20
lfr
0/0

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFH+gLUinSul6a7oB8RAjcBAJ9aGfhYp5MntKcG15gPsL6WKLgbLQCdETkO
TNbmRfFO/KOltozh5G84vxE=
=3eX5
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
