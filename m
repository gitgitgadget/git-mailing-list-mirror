From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Add a simple option parser.
Date: Thu, 04 Oct 2007 01:11:45 +0200
Message-ID: <20071003231145.GF28188@artemis.corp>
References: <1191447902-27326-1-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="NQTVMVnDVuULnIzU";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, gitster@pobox.com
To: Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 01:12:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdDNl-0001SQ-7L
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 01:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbXJCXLs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 19:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbXJCXLs
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 19:11:48 -0400
Received: from pan.madism.org ([88.191.52.104]:49672 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751031AbXJCXLr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 19:11:47 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 305DF23440;
	Thu,  4 Oct 2007 01:11:45 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 5A4A6366DA2; Thu,  4 Oct 2007 01:11:45 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>,
	git@vger.kernel.org, gitster@pobox.com
Content-Disposition: inline
In-Reply-To: <1191447902-27326-1-git-send-email-krh@redhat.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59906>


--NQTVMVnDVuULnIzU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 03, 2007 at 09:45:01PM +0000, Kristian H=C3=B8gsberg wrote:
> The option parser takes argc, argv, an array of struct option
> and a usage string.  Each of the struct option elements in the array
> describes a valid option, its type and a pointer to the location where the
> value is written.  The entry point is parse_options(), which scans through
> the given argv, and matches each option there against the list of valid
> options.  During the scan, argv is rewritten to only contain the
> non-option command line arguments and the number of these is returned.

  if we are going in that direction (and I believe it's a good one), we
should be sure that the model fits with other commands as well. And as I
said on IRC, I believe the most "horrible" (as in complex) option parser
in git is the one from git-grep.

  A migration of git-grep on that API should be tried first. If this
works well enough, I believe that the rest of the git commands will be
migrated easily enough. (with maybe small addition to parse-option.[hc]
but the hardcore things should have been met with git-grep already I
think).

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--NQTVMVnDVuULnIzU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHBCGxvGr7W6HudhwRArO3AJ9tp0DI5PsjQP/FaRPFt928Fv2+AgCfXrZP
H7Jkk0qRrcDijAVC0AyIYO8=
=CxkA
-----END PGP SIGNATURE-----

--NQTVMVnDVuULnIzU--
