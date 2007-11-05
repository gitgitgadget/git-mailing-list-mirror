From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] parseopt: introduce OPT_RECURSE to specify shared options
Date: Mon, 05 Nov 2007 14:53:19 +0100
Message-ID: <20071105135319.GA6205@artemis.corp>
References: <Pine.LNX.4.64.0711051209061.4362@racer.site> <20071105123923.GC25574@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="u3/rZRmxL6MmkK24";
	protocol="application/pgp-signature"; micalg=SHA1
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 05 14:53:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip2OX-00067p-Lj
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 14:53:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755677AbXKENxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 08:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755676AbXKENxW
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 08:53:22 -0500
Received: from pan.madism.org ([88.191.52.104]:60176 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755647AbXKENxV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 08:53:21 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id A1843285DB;
	Mon,  5 Nov 2007 14:53:20 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id CF5EA8525; Mon,  5 Nov 2007 14:53:19 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
Content-Disposition: inline
In-Reply-To: <20071105123923.GC25574@artemis.corp>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63519>


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2007 at 12:39:23PM +0000, Pierre Habouzit wrote:
>   I like the kind of code that I allow to write better (I tend to
> dislike big fat global variables), though it's obvious that Johannes
> patch is a lot simpler and I like that.

  We discussed it further, and what came out is that instead of
supporting quite complicated recursion mechanisms (or even a non so
complicated one), we can just define an
OPT__DIFFOPTIONS(diffopts)/OPT__REVOPTIONS(rev) macro that would inline
the needed options.

  That's an idea I had but dismissed. Though, maybe it's not _that_
ugly, is clearly simpler, and one can argue that it's in the logical
continuation of OPT__QUIET and friends. What do you think ?

  If it's the road we decide to take, then my documentation patch (2/4),
the parseopt fix (my 1/4 or johannes 1/3) and Johannes usage generator
enhancement (his 3/3) are still to be taken.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHLyBPvGr7W6HudhwRAjKQAJ9tioOnfKLX6lFj3b7UsNlLZLkX2wCfRY5M
hn+P6Zks45FHRbl5TXbCIkk=
=INOB
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
