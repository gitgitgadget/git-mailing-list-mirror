From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC/RFH] Fun things with git-notes, or: patch tracking backwards
Date: Tue, 10 Feb 2009 23:42:27 +0100
Message-ID: <200902102342.29962.trast@student.ethz.ch>
References: <200902091508.11460.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4232548.JnWJNA4P7V";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 10 23:44:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX1L0-0007TQ-0N
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 23:44:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756512AbZBJWmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 17:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756180AbZBJWmh
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 17:42:37 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:35680 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756148AbZBJWmh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 17:42:37 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 10 Feb 2009 23:42:34 +0100
Received: from thomas.localnet ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 10 Feb 2009 23:42:34 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <200902091508.11460.trast@student.ethz.ch>
X-OriginalArrivalTime: 10 Feb 2009 22:42:34.0908 (UTC) FILETIME=[DDE635C0:01C98BD0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109328>

--nextPart4232548.JnWJNA4P7V
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thomas Rast wrote:
>   git fetch git://repo.or.cz/git/trast.git mailnotes &&
>   GIT_NOTES_REF=3DFETCH_HEAD git log origin/pu

An update: I have fully automated the process, it now fetches mails
from Gmane over HTTP which gives it the Gmane URLs for free.  I'm
rather happy with the latter feature, especially since Konsole has a
feature to recognize and open links directly.

I have imported all commits, and mails since roughly July 2008
(starting with Gmane 89000).  In this timeframe there were 1802
non-merge commits, and the mailnotes tree now holds 1122 annotations.
I won't import mails any further back until the parsing-related code
has become reasonably stable, but this at least covers the post-v1.6.0
commits.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart4232548.JnWJNA4P7V
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmSAtUACgkQqUud07tmzP0AYACeNh0RQ0WsSGg/3MLelgFbDAmB
M9MAoIeDphayags/h/stDoQtGsOa29oq
=3eYK
-----END PGP SIGNATURE-----

--nextPart4232548.JnWJNA4P7V--
