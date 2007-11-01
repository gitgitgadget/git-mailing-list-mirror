From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 01 Nov 2007 22:57:38 +0100
Message-ID: <20071101215738.GE7161@artemis.corp>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org> <7vmytycykt.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.999.0711011129460.3342@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="OZkY3AIuv2LYvjdk";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Nov 01 22:57:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ini32-0000g4-5x
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 22:57:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754039AbXKAV5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 17:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753894AbXKAV5l
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 17:57:41 -0400
Received: from pan.madism.org ([88.191.52.104]:55162 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753855AbXKAV5k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 17:57:40 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 3750527F9F;
	Thu,  1 Nov 2007 22:57:39 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id D8D362E062D; Thu,  1 Nov 2007 22:57:38 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0711011129460.3342@woody.linux-foundation.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63020>


--OZkY3AIuv2LYvjdk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 01, 2007 at 06:33:13PM +0000, Linus Torvalds wrote:
>=20
>=20
> On Wed, 31 Oct 2007, Junio C Hamano wrote:
> >=20
> > * ph/parseopt (Tue Oct 30 14:15:21 2007 -0500) 23 commits
> >  + ...
> >=20
> > It appears 1.5.4 will be, to a certain extent, a "Let's clean up
> > the internal implementation" release.  This series should become
> > part of it.  Hopefully will merge to 'master' soon, but I
> > haven't looked this series very closely yet.
>=20
> I certainly think this should go in, but it does make one deficiency=20
> painfully clear: the remaining shell scripts end up having all the old=20
> flags behaviour.

  Those are not the only commands with issues: not all builtins are
migrated on the new option parser, and those with recursive options (I
mean the ones that use diff options e.g.) are not migrated yet either,
because the option parser does not supports a mechanism to deal with
them.

  The issue is not to let parse_option recurse into anoter option
structure, it's that if you do so, you want to express the address of
the "options" to patch in a relative and not absolute way, and I've not
decided myself mind about a way to do that yet.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--OZkY3AIuv2LYvjdk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHKkvSvGr7W6HudhwRAvZMAKCbvHzjhFic9+sSeKuJV0/jb5vrkgCdFTQo
QgKdnIZ+CUwrYT6WWeWeEck=
=Xy7g
-----END PGP SIGNATURE-----

--OZkY3AIuv2LYvjdk--
