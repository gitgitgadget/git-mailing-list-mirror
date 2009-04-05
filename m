From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH 3/4] Makefile: allow building without perl
Date: Sat, 4 Apr 2009 17:06:09 -0700
Message-ID: <20090405T000318Z@curie.orbis-terrarum.net>
References: <20090403192700.GA14965@coredump.intra.peff.net> <20090403193220.GC5547@coredump.intra.peff.net> <20090404T224109Z@curie.orbis-terrarum.net> <20090404233936.GB26906@coredump.intra.peff.net> <20090404T234556Z@curie.orbis-terrarum.net> <20090404235636.GA27354@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1XWsVB21DFCvn2e8"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 05 02:09:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqFvU-0006vb-0r
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 02:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756024AbZDEAGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 20:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755892AbZDEAGS
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 20:06:18 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:45731 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755057AbZDEAGR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 20:06:17 -0400
Received: (qmail 31249 invoked from network); 5 Apr 2009 00:06:12 -0000
Received: from tsi-static.orbis-terrarum.net (HELO curie.orbis-terrarum.net) (76.10.188.108)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Sun, 05 Apr 2009 00:06:12 +0000
Received: (qmail 32715 invoked by uid 10000); 4 Apr 2009 17:06:09 -0700
Content-Disposition: inline
In-Reply-To: <20090404235636.GA27354@coredump.intra.peff.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115609>


--1XWsVB21DFCvn2e8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 04, 2009 at 07:56:36PM -0400, Jeff King wrote:
> Ah, I see. You are not asking "was PERL_PATH blank" but rather "does
> PERL_PATH exist". And I think that is not the right thing for the
> Makefile, as it is unlike any other part of the git Makefile, which
> generally does what it is told with the minimum of magic. That sort of
> magic generally goes into configure.ac.
At a glance, PERL_PATH in configure.ac isn't actually used at the
moment, the definition in the Makefile overrides it.

> So NO_PERL_MAKEMAKER is _already_ exported, and I don't think there is
> any reason to export NO_PERL in the environment (see patch 4/4, which
> exports it via GIT-BUILD-OPTIONS).
Ok, drop the export then, but do keep at least the if(is empty
PERL_PATH) then { set NO_PERL }, even if you won't keep the existence
check.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--1XWsVB21DFCvn2e8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.10 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAknX9fEACgkQPpIsIjIzwiw89QCfa+oc9vaC6pHn6M5WEcTp3083
jOkAn1avF4A1cXRV7LNBJJx7kUX7+Nd0
=gxg+
-----END PGP SIGNATURE-----

--1XWsVB21DFCvn2e8--
