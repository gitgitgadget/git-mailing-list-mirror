From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] git integrated bugtracking
Date: Sun, 3 Jun 2007 18:07:36 +0200
Message-ID: <20070603160736.GC30347@artemis>
References: <20070603114843.GA14336@artemis> <878xb19ot5.fsf@graviton.dyn.troilus.org> <20070603133109.GD14336@artemis> <200706031548.30111.johan@herland.net> <20070603151921.GB30347@artemis> <vpq1wgtnith.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="oJ71EGRlYNjSvfq7";
	protocol="application/pgp-signature"; micalg=SHA1
To: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Poole <mdpoole@troilus.org>
X-From: git-owner@vger.kernel.org Sun Jun 03 18:07:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuscL-0004B0-1E
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 18:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753029AbXFCQHi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 12:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753082AbXFCQHi
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 12:07:38 -0400
Received: from smtp7-g19.free.fr ([212.27.42.64]:41829 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753029AbXFCQHh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 12:07:37 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 6F4011893F;
	Sun,  3 Jun 2007 18:07:36 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 495B417D75; Sun,  3 Jun 2007 18:07:36 +0200 (CEST)
Mail-Followup-To: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Poole <mdpoole@troilus.org>
Content-Disposition: inline
In-Reply-To: <vpq1wgtnith.fsf@bauges.imag.fr>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49011>


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 03, 2007 at 05:44:58PM +0200, Matthieu Moy wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> >   Yeah, now that I read that thread, well yeah, I think notes are a hell
> > of a good concept for my ideas. I mean, a bug report would be basically
> > a collection of notes:
> >   * the bug has been found at this commit ;
> >   * the bug has been not-found at this commit ;
> >   * this commit is a fix for that bug ;
>=20
> That's my feeling too. "Commiting" bug information in the tree is only
> half of a good idea. You want to be able to say, after the fact, "This
> commit had bug XYZ". OTOH, the idea (followed by bugs everywhere) that
> merging a branch would automatically close bugs fixed by this branch
> is a really cool thing.

  That would work with notes, as while merging you'll get the notes of
the commit in your branch, *and* the note about the fixing patch. So
there is no loss of "concept" here. In fact that was the thing that I
looked for. Notes are good. They just may not be enough to write an
in-git bugtracking tool, as a bug needs the "notes collection" concepts,
and maybe a few other.

> The kind of information you're mentionning above can be a great
> starting point for "bisect". I can even imagine a kind of distributed
> bisect, where several users could give their "bad commits" for the
> same bug.

  Heh yes. Sometimes it's more complex than that as bugs can come back
(regressions) or be the result of many commits (like the cases that suck
with bisect). For a complex bug it's more a set of [found..notfound[
intervals. Though this indeed is very valuable information, and the
distributed component thing *is* great.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD4DBQBGYudIvGr7W6HudhwRAnn2AJiaSzzae8sgcSwTuljBnytzdgIdAJ94HSqD
IZK6Zy3U3QNoPmp8q2uoUg==
=oxZV
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--
