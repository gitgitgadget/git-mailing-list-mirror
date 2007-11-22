From: Jonas Juselius <jonas@iki.fi>
Subject: Re: Git in a Nutshell guide
Date: Thu, 22 Nov 2007 14:15:03 +0100
Message-ID: <1195737303.19260.27.camel@localhost>
References: <1195477504.8093.15.camel@localhost>
	 <fhsc7b$k4g$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-XagGm0oiCFPdYK8ZCDgg"
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 14:22:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvC0R-00064s-Gl
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 14:22:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbXKVNVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 08:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbXKVNVx
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 08:21:53 -0500
Received: from radon.chem.helsinki.fi ([128.214.14.200]:38298 "EHLO
	radon.chem.helsinki.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbXKVNVx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 08:21:53 -0500
X-Greylist: delayed 407 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Nov 2007 08:21:52 EST
Received: from [129.242.24.54] (snowflake.chem.uit.no [129.242.24.54])
	by radon.chem.helsinki.fi (Postfix) with ESMTP id 92DE6DBFA5;
	Thu, 22 Nov 2007 15:15:13 +0200 (EET)
In-Reply-To: <fhsc7b$k4g$1@ger.gmane.org>
X-Mailer: Evolution 2.12.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65820>


--=-XagGm0oiCFPdYK8ZCDgg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I'm planning to write a section in the "Nutshell guide" on rewriting
history and rebasing. I have a question related to rewriting history. As
usual, I'll assume that the part of the history I'm mucking with has not
been pushed or pulled by anyone.=20
Suppose I have been working on some topic branch for a while and been
overly trigger happy, i.e. I have produced a ridiculous number of
commits along the way. At some point when I'm done I want to publish my
changes, but doing so would create an insanely obese history full of
near nonsense commits. What I want to do is to slim down the commit log
into pieces that actually makes sense. What is the preferred (or best,
most convenient) way of doing this? The way I have done this previously
is essentially:

1.  git branch -m mytopic tmp_mytopic  # rename
2.  git branch mytopci tmp_mytpoic~42  # go back in history
Loop:
3.1 git log; git diff; git annotate...
3.2 git diff tmp_mytopic~42..tmp_mytopic~33 | git-apply
3.3 git commit -m "sane commit message" -a
4.  git branch -d tmp_mytopic

If I need to reorder commits I can first use git-rebase -i to get
everything streamlined. There must be a better way of doing this, right?

.jonas.

--=-XagGm0oiCFPdYK8ZCDgg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHRYDWwakVfwpZemYRAkE6AKC12uLhs7WqdU0QYYXOJcdz0vtBkgCgo1bp
h9cHdjotDaTvRXZU9Hk1yZw=
=6GP9
-----END PGP SIGNATURE-----

--=-XagGm0oiCFPdYK8ZCDgg--
