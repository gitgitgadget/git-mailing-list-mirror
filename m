From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git svn: Bad URL passed to RA layer: Unrecognized URL scheme
Date: Mon, 6 Oct 2008 11:47:25 +0200
Message-ID: <200810061147.28986.trast@student.ethz.ch>
References: <pan.2008.10.05.17.24.02.167465@yahoo.com> <237967ef0810051244m51156925x26ae51db038dad49@mail.gmail.com> <pan.2008.10.06.02.28.35.643705@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7038765.L41bstWhzI";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff Kowalczyk <jtk@yahoo.com>
X-From: git-owner@vger.kernel.org Mon Oct 06 11:49:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kmmho-0001ui-7L
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 11:48:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752320AbYJFJrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 05:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752295AbYJFJrc
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 05:47:32 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:37774 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752193AbYJFJrb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 05:47:31 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 6 Oct 2008 11:47:27 +0200
Received: from pcjremy.inf.ethz.ch ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 6 Oct 2008 11:47:26 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <pan.2008.10.06.02.28.35.643705@yahoo.com>
X-OriginalArrivalTime: 06 Oct 2008 09:47:26.0936 (UTC) FILETIME=[8A869D80:01C92798]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97576>

--nextPart7038765.L41bstWhzI
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Jeff Kowalczyk wrote:
> However, each operation ends with a segmentation fault. This is the case
> with all git svn repositories (e.g. several different svn remote hosts).
>=20
>   (master) $ git svn rebase
>      M  django/core/management/commands/makemessages.py
>      M  docs/topics/i18n.txt
>   r9155 =3D 4c86e60f62366ac9c3fd9369c17c54801a8f2ea0 (trunk)
>   First, rewinding head to replay your work on top of it...
>   Fast-forwarded master to refs/remotes/trunk.
>   Segmentation fault

Can you try to find out what exactly segfaults here? git-svn is
implemented in Perl, so that means it's either Perl itself (unlikely),
the SVN libraries hooked into Perl, or some git command run by
git-svn.

=2D Thomas

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch


--nextPart7038765.L41bstWhzI
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkjp3rAACgkQqUud07tmzP2RGQCgj0+HCItEAlsUWH4Z6LPC/p87
G+AAn3GAMkDWnYCTDHag7B6qFSt6M7Ex
=yB3J
-----END PGP SIGNATURE-----

--nextPart7038765.L41bstWhzI--
