From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [BUG (or misfeature?)] git checkout and symlinks
Date: Wed, 4 Jul 2007 23:05:59 +0200
Message-ID: <20070704210559.GB13286@artemis.corp>
References: <20070704203541.GA13286@artemis.corp> <7vabubhoxb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="6sX45UoQRIJXqkqR";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 04 23:06:24 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6C3K-0000nR-21
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 23:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755517AbXGDVGI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 17:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755514AbXGDVGH
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 17:06:07 -0400
Received: from pan.madism.org ([88.191.52.104]:43323 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755174AbXGDVGG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 17:06:06 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id D700C13098;
	Wed,  4 Jul 2007 23:06:04 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 68A864045; Wed,  4 Jul 2007 23:05:59 +0200 (CEST)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vabubhoxb.fsf@assigned-by-dhcp.cox.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51641>


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 04, 2007 at 01:52:32PM -0700, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> >   if in a branch [branch1] you track the file: dir1/file1.c
> > and in the branch [branch2] you track elsewhere/file1.c and dir1 be
> > symlink on elsewhere, then it's not possible to checkout the branch
> > [branch1] if your previous checkout was [branch2]. You have to manually
> > remove the symlink `dir1` else git complains that checkouting branch1
> > would overwrite dir1/file1.c.
> >
> >   I'm not sure how to fix this, and it's quite painful actually :)
>=20
> Yeah, I think our handling of symlinks in both read-tree and
> merge-recursive codepath are Ok for symlinks at the leaf level
> but not for intermediate levels.  I think we have some patches
> in the recent git (post 1.5.1) to fix (perhaps some of) the
> issues, though.

  that was with the git in debian unstable, 1.5.2.3 actually.  I'll try
again with HEAD to see if that's fixed.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGjAu3vGr7W6HudhwRAt2PAJ9hUb0+LLmxtDd+ViZHnGJSWnCBmACeIFDJ
xPihA7hQ3izNhDfFJszBc/E=
=6KiU
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
