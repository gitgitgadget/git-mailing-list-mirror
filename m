From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC PATCH] hooks: add some defaults to support sane workflow to pre-commit
Date: Sat, 21 Feb 2009 12:16:35 +0100
Message-ID: <200902211216.43964.trast@student.ethz.ch>
References: <499EF2B6.7060103@hvoigt.net> <C95EAEB9-D520-497F-BA42-0CDCC1348340@wincent.com> <499FDDC2.90502@hvoigt.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7822706.yyhTV9nlo3";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Heiko Voigt <git-list@hvoigt.net>
X-From: git-owner@vger.kernel.org Sat Feb 21 12:27:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Laq0i-0004iy-Mb
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 12:27:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbZBULQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 06:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbZBULQ6
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 06:16:58 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:9057 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751307AbZBULQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 06:16:57 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 21 Feb 2009 12:16:55 +0100
Received: from thomas.localnet ([77.56.223.244]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 21 Feb 2009 12:16:55 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <499FDDC2.90502@hvoigt.net>
X-OriginalArrivalTime: 21 Feb 2009 11:16:56.0111 (UTC) FILETIME=[E7CF33F0:01C99415]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110939>

--nextPart7822706.yyhTV9nlo3
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Heiko Voigt wrote:
> This leads me to a completely different solution to the same problem.
> How about teaching git to inherit its hooks from the parental project
> (e.g. the one it was cloned from)? That way we are not limited to
> one default behaviour but many that would match the one from the
> upstream project.
[...]
> What do you think about that?

Three words: huge security hole.

Especially on cloning, where the checkout immediately afterwards
would already run the post-checkout hook, without any chance for the
user to inspect its contents.

The usual advice is to track the hooks in the repository, e.g., under
hooks/, and instruct the users to copy them to .git/hooks/ if they
want them.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart7822706.yyhTV9nlo3
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmf4psACgkQqUud07tmzP1reQCfZfjON15vWdFg/J3gi2vVjyPV
8+AAn1JizHaz8PXeIWCKXvEP1axdDRqZ
=JGHJ
-----END PGP SIGNATURE-----

--nextPart7822706.yyhTV9nlo3--
