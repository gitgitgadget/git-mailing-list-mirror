From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: Creating a patch set with git-format-patch
Date: Thu, 10 Apr 2008 13:55:23 +0200
Message-ID: <20080410115523.GD8157@leksak.fem-net>
References: <d0383f90804100151s6ffde16al6035116c27c9cb3a@mail.gmail.com> <20080410105610.GB29742@atjola.homenet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gr/z0/N6AeWAPJVB"
Cc: git@vger.kernel.org
To: Ian Brown <ianbrn@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 13:57:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjvOO-0001xG-Ji
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 13:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755232AbYDJLzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 07:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755149AbYDJLzw
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 07:55:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:55442 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754814AbYDJLzv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 07:55:51 -0400
Received: (qmail invoked by alias); 10 Apr 2008 11:55:49 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp033) with SMTP; 10 Apr 2008 13:55:49 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19+d5NZqAR+t8MflD3UnUE+o/HA5qcr11KNeSmdSR
	cH/S0m23gp34xQ
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1JjvND-0003hi-Ny; Thu, 10 Apr 2008 13:55:23 +0200
Mail-Followup-To: Ian Brown <ianbrn@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20080410105610.GB29742@atjola.homenet>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79212>


--gr/z0/N6AeWAPJVB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> Just create a branch for you work, then start working and creating
> commits.
> [...]

I've got a further question on that "patch-based" workflow because the=20
documentation always stops at "send the patch".

Case 1:
 Assume your patch series get accepted.
 What to do with your local changes branch, say "my-changes"?
 Keeping it would result in a lot of dead branches after a while.

 So, I guess "git branch -D my-changes" is the cleanest way to go,
 but I'm not sure.

Case 2:
 Assume your patch series is not accepted but some patches
 are discussed and need some further work.
 What to do?[1]

 I guess the right way is (after updating master) to rebase--interactive
 the my-changes branch to the master and "edit" every commit that
 need further changes. After the rebase with all changes has finished,
 format-patch and re-send the interesting patches=20
 (or format-patch the whole my-changes branch down to master and re-send
  only the changed patches)...

Are my guesses "right" for the two cases? Comments?

Regards,
 Stephan

Footnotes:
  1. Yes, there is step (3) of "An ideal patch flow" in
     http://git.kernel.org/?p=3Dgit/git.git;a=3Dblob;f=3DDocumentation/Subm=
ittingPatches
     but it does not suggest steps how to "polish" and "refine".

--=20
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F

--gr/z0/N6AeWAPJVB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH/gArbt3SB/zFBA8RAhyfAJ9lfc3jEF0CNl2GTqMnSIMMY5h+yQCgjElJ
yZaoWIMWvxKY0dH+5XrH0hU=
=08mJ
-----END PGP SIGNATURE-----

--gr/z0/N6AeWAPJVB--
