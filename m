From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Equivalent of `svn switch` for git-svn?
Date: Thu, 27 Sep 2007 19:02:05 +0200
Message-ID: <20070927170205.GA6076@artemis.corp>
References: <46FB5086.7070408@apple.com> <20070927100607.GC10289@artemis.corp> <Pine.LNX.4.64.0709271253040.28395@racer.site> <46FBDCBF.7060909@apple.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="WIyZ46R2i8wDzkSu";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Adam Roben <aroben@apple.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 19:03:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iawl3-0001Yh-DP
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 19:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756453AbXI0RCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 13:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756720AbXI0RCI
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 13:02:08 -0400
Received: from pan.madism.org ([88.191.52.104]:58210 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756453AbXI0RCH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 13:02:07 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 48B9922096;
	Thu, 27 Sep 2007 19:02:06 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 706E6BDB9A; Thu, 27 Sep 2007 19:02:05 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Adam Roben <aroben@apple.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <46FBDCBF.7060909@apple.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59304>


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 27, 2007 at 04:39:27PM +0000, Adam Roben wrote:
> Will doing this then change all the git-svn-id: lines in the commit logs=
=20
> for those imported revisions? I'm asking because my understanding is that=
=20
> git-svn uses those git-svn-id: lines to determine which branch you're on,=
=20
> and if the URLs are now all out of date won't it then think it can't=20
> determine the correct branch?

  fwiw If it breaks git-svn, then it's a deep git-svn misconception.
I've always believed that git-svn should always have done what git
checkout --track do, meaning set into the configuration which svn remote
branch you are following.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG++INvGr7W6HudhwRAlN/AJ9tJQrrZcpru/jFCccqbstPQFEEOgCcDQOJ
g8TE0zzsKeJq3AImphpKDhs=
=3bVa
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
