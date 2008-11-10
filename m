From: Kai Blin <kai@samba.org>
Subject: Re: How it was at GitTogether'08 ?
Date: Mon, 10 Nov 2008 11:08:51 +0100
Organization: Samba Team
Message-ID: <200811101109.02885.kai@samba.org>
References: <200811080254.53202.jnareb@gmail.com> <200811091955.19304.kai@samba.org> <alpine.DEB.1.00.0811101055020.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2162334.MrksqQGTc8";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	David Symonds <dsymonds@gmail.com>, git@vger.kernel.org,
	Tim Ansell <mithro@mithis.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 10 11:11:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzTj2-0004WW-G1
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 11:10:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbYKJKJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 05:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753834AbYKJKJI
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 05:09:08 -0500
Received: from mail.samba.org ([66.70.73.150]:42251 "EHLO lists.samba.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750985AbYKJKJH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 05:09:07 -0500
Received: from ip6-localhost (localhost [127.0.0.1])
	by lists.samba.org (Postfix) with ESMTP id D0F96163A61;
	Mon, 10 Nov 2008 10:08:53 +0000 (GMT)
User-Agent: KMail/1.9.10
In-Reply-To: <alpine.DEB.1.00.0811101055020.30769@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100508>

--nextPart2162334.MrksqQGTc8
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 10 November 2008 10:58:05 Johannes Schindelin wrote:
Hi Dscho,

> > Tim was talking about that media/ folder and managing that in git. If
> > you want to work on the media, you might end up getting hundreds of
> > gigabytes of data to get that folder, even if you only need to change
> > one single file.
> >
> > That's the issue we're running into, and I don't thing submodules solve
> > this at all.
>
> You'd have to have a single repository for each and every media file, and
> you'd need to use shallow clones and shallow fetches.
>
> However, a push-conflict will probably be beyond any non-programmer
> skillz.

Ok, I agree. But you could work around that by teaching the artists to=20
fetch/rebase/push instead of just pushing, or hiding this in the GUI. If=20
there's a conflict on a binary data file you're screwed anyway. :)

> I'd rather propose to have a different interface, like through a web
> server, where the user can say "I have some cool new graphics, in this
> .zip file" together with a commit message.
>
> Kind of a git-gui via browser.

Incidentally I'm currently working on something like this, just aimed at=20
the "artist side", instead of the VCS side. This certainly is a useable=20
solution for artists. But at some point a developer will want to check out=
=20
the repository to cut a release tarball, and we're back to wanting shallow=
=20
and narrow clones. :)

Cheers,
Kai

=2D-=20
Kai Blin
WorldForge developer  http://www.worldforge.org/
Wine developer        http://wiki.winehq.org/KaiBlin
Samba team member     http://www.samba.org/samba/team/
=2D-
Will code for cotton.

--nextPart2162334.MrksqQGTc8
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBJGAg+EKXX/bF2FpQRAkbmAJ4+prRwNAeFA0ZOXBMPx52WlH5P3gCfUsnS
EVE2XH6jh786e1OTPT+mC+w=
=CPIc
-----END PGP SIGNATURE-----

--nextPart2162334.MrksqQGTc8--
