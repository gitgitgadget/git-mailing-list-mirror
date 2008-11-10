From: Kai Blin <kai@samba.org>
Subject: Re: Large media in git (was: How it was at GitTogether'08)?
Date: Mon, 10 Nov 2008 11:13:16 +0100
Organization: Samba Team
Message-ID: <200811101113.17018.kai@samba.org>
References: <200811080254.53202.jnareb@gmail.com> <200811091955.19304.kai@samba.org> <200811101030.54070.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2173757.f8T7HN7pAm";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Tim Ansell <mithro@mithis.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 11:14:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzTmz-00060B-MD
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 11:14:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753962AbYKJKNT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 05:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753936AbYKJKNT
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 05:13:19 -0500
Received: from mail.samba.org ([66.70.73.150]:42406 "EHLO lists.samba.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753917AbYKJKNS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 05:13:18 -0500
Received: from ip6-localhost (localhost [127.0.0.1])
	by lists.samba.org (Postfix) with ESMTP id C74B2163A61;
	Mon, 10 Nov 2008 10:13:07 +0000 (GMT)
User-Agent: KMail/1.9.10
In-Reply-To: <200811101030.54070.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100509>

--nextPart2173757.f8T7HN7pAm
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 10 November 2008 10:30:53 Jakub Narebski wrote:
> On Sun, 9 Nov 2008, Kai Blin wrote:
> > On Sunday 09 November 2008 17:31:47 Jakub Narebski wrote:
> > > The workaround is to put all large files for example in 'media/'
> > > folder, and make this folder be submodule. Each clone of repository c=
an
> > > have this 'media' submodule either present (both in object database,
> > > although usually separate from main project object database), or not
> > > present (not cloned and not checked out).
> >
> > Tim was talking about that media/ folder and managing that in git. If y=
ou
> > want to work on the media, you might end up getting hundreds of gigabyt=
es
> > of data to get that folder, even if you only need to change one single
> > file.
> >
> > That's the issue we're running into, and I don't thing submodules solve
> > this at all.
>
> Ah, well... Submodules cannot be workaround for _this_ issue. You can
> have only all or nothing: either all files in media/ or none of them,
> both in working directory like in repository object database... well
> unless you subdivide further.
>
> I guess that mentioned work on the media is in remote setting (you
> cannot have main repository on network drive) so Dana How's proposed
> solution would not work for you, is it?

If my google-fu worked, the proposed solution you're talking about involves=
=20
simply hiding large blobs from pack files, right? In that case it won't wor=
k,=20
as the users of the repository indeed are remote.

Cheers,
Kai

=2D-=20
Kai Blin
WorldForge developer  http://www.worldforge.org/
Wine developer        http://wiki.winehq.org/KaiBlin
Samba team member     http://www.samba.org/samba/team/
=2D-
Will code for cotton.

--nextPart2173757.f8T7HN7pAm
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBJGAk9EKXX/bF2FpQRApM9AKCoI2TNqIcTVU/2OEelBskn3tjvIgCglVGR
poVS4pygCd1TwdFbyzzQNoo=
=Qexl
-----END PGP SIGNATURE-----

--nextPart2173757.f8T7HN7pAm--
