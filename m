From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Subversion developer: svn is for dumb people
Date: Fri, 19 Oct 2007 13:34:47 +0200
Message-ID: <20071019113447.GC4404@artemis.corp>
References: <47176CE0.7030609@midwinter.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="hOcCNbCCxyk/YU74";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: 'git' <git@vger.kernel.org>
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Fri Oct 19 13:39:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IiqCZ-0007FZ-Kq
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 13:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140AbXJSLev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 07:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753161AbXJSLev
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 07:34:51 -0400
Received: from pan.madism.org ([88.191.52.104]:38495 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752140AbXJSLeu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 07:34:50 -0400
Received: from madism.org (def92-2-81-57-219-236.fbx.proxad.net [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id C88B925CD3;
	Fri, 19 Oct 2007 13:34:48 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id D3D2035778E; Fri, 19 Oct 2007 13:34:47 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Steven Grimm <koreth@midwinter.com>, 'git' <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <47176CE0.7030609@midwinter.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61689>


--hOcCNbCCxyk/YU74
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 18, 2007 at 02:25:36PM +0000, Steven Grimm wrote:
> Thought folks here might get a kick out of this:
>=20
> http://blog.red-bean.com/sussman/?p=3D79
>=20
> Okay, my summary is slightly facetious, but that's basically the gist of=
=20
> what he's saying: you should choose Subversion rather than a DVCS because=
=20
> most of your users won't be smart enough to use the better tool.
>=20
> I can't say he's completely wrong, especially about the 20/80% idea=20
> (though I think "20%" is generous), but some of his specific arguments=20
> about DVCS are on the bogus side. "Centralized systems encourage code=20
> reviews," for one -- I challenge him to find a project with a more=20
> pervasive and effective code-reviewing culture than the git project.

  Your argument is also bogus.

  IMNSHO, peer reviewing has nothing to do with git, svn, or $SCM. It's
a social pattern. There are people that do it because they understand
it's a good and necessary sound thing to do, and there are the others.
Guess what, it has a lot to do with the 20%/80% line (that I would have
more described as the 2/98 but well=E2=80=A6).

  Put git into the hands of fools, they won't proofread their code more
or less than with svn. And they will shoot themselves into their foots
twice as often as with svn.

  Though, for people that are able to deal with git and use it, git
allows way better code reviewing patterns than with svn, because you
can prepare a nice incremental branch that adds each new features you
worked on with small patches (see my parse-options series). With svn,
you can't do that, because there is no tool that allow you to record
those patches on your end, so you submit a big +4123/-2341 patch. That
makes peer reviewing really harder.

  Of course the git community is a perfect example of how code should be
reviewed. But it's not because we use git, it's because we definitely
are in the "20%".

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--hOcCNbCCxyk/YU74
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHGJZXvGr7W6HudhwRApdsAJ91cbMlnznrlx603osDJlnvss9pzQCdGC6M
+ZO85Z5IS9+fybimjQYLpSA=
=ucKc
-----END PGP SIGNATURE-----

--hOcCNbCCxyk/YU74--
