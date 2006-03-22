From: Radoslaw Szkodzinski <astralstorm@o2.pl>
Subject: Re: Best way to generate a git tree containing only a subset of commits from another tree?
Date: Wed, 22 Mar 2006 22:28:57 +0100
Message-ID: <200603222229.02763.astralstorm@o2.pl>
References: <Pine.LNX.4.64.0603221920260.22475@hermes-2.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1828300.aP5OXYL2AP";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Anton Altaparmakov <aia21@cam.ac.uk>
X-From: git-owner@vger.kernel.org Wed Mar 22 22:32:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMAwr-0006u0-3e
	for gcvg-git@gmane.org; Wed, 22 Mar 2006 22:32:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932796AbWCVVcu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 16:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932795AbWCVVct
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 16:32:49 -0500
Received: from mx.go2.pl ([193.17.41.41]:57016 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S932796AbWCVVcs (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Mar 2006 16:32:48 -0500
Received: from zen.localdomain (host-81-190-201-167.gorzow.mm.pl [81.190.201.167])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by poczta.o2.pl (Postfix) with ESMTP id D47961378EB;
	Wed, 22 Mar 2006 22:32:44 +0100 (CET)
Received: from zen.localdomain ([192.168.0.1])
	by zen.localdomain with esmtpa (Exim 4.60)
	(envelope-from <astralstorm@o2.pl>)
	id 1FMAtN-0001QC-MB; Wed, 22 Mar 2006 22:29:21 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
In-Reply-To: <Pine.LNX.4.64.0603221920260.22475@hermes-2.csi.cam.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17831>

--nextPart1828300.aP5OXYL2AP
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 22 March 2006 20:28, Anton Altaparmakov wrote yet:
> Preferable I would like to do it so that later when Linus has pulled from
> my /usr/src/linux-2.6 tree, I do a "git pull" of Linus' tree from
> /usr/src/my-big-tree and it all works correctly and I don't end up with
> the same commits twice.
>
> Is that possible at all?

Should work out of the box.

> If not what can I do to do it cleanly?  Does git help in any way or do I
> literally have to export all my commits from /usr/src/my-big-tree to diff
> style patches and then throw away the tree, clone Linus tree after he has
> pulled my /usr/src/linux-2.6 tree and commit all my generated diff patches
> again?  That would be rather horrible to have to do...

It will work flawlessly if Linus merges your patch without any changes.
Else git will merge and maybe conflict if the change was major.

=2D-=20
GPG Key id:  0xD1F10BA2
=46ingerprint: 96E2 304A B9C4 949A 10A0  9105 9543 0453 D1F1 0BA2

AstralStorm

--nextPart1828300.aP5OXYL2AP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQBEIcGelUMEU9HxC6IRAmZVAJ9HPB8l+CDALmyVfyep1p/NWZiBewCffrp7
2MjALyj+25JeOvS2UlulvjY=
=rv41
-----END PGP SIGNATURE-----

--nextPart1828300.aP5OXYL2AP--
