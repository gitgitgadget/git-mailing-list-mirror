From: Pierre Habouzit <madcoder@debian.org>
Subject: [RFC] Re: git-svn: make git-svn commit-diff able to work without explicit arguments
Date: Tue, 2 Jan 2007 22:13:39 +0100
Message-ID: <20070102211339.GF17898@hades.madism.org>
References: <459AA31E.5070705@gmail.com> <7vr6udtbmv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="R6sEYoIZpp9JErk7";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Cc: Steve =?utf-8?Q?Fr=C3=A9cinaux?= <nudrema@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 02 22:14:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1qxD-0006fZ-Rl
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 22:13:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754971AbXABVNs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 16:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754973AbXABVNs
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 16:13:48 -0500
Received: from pan.madism.org ([88.191.16.128]:43666 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754971AbXABVNr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 16:13:47 -0500
Received: from hades.madism.org (olympe.madism.org [82.243.245.108])
	by hermes.madism.org (Postfix) with ESMTP id 4BC7CC001;
	Tue,  2 Jan 2007 22:13:40 +0100 (CET)
Received: by hades.madism.org (Postfix, from userid 1001)
	id CC90762750; Tue,  2 Jan 2007 22:13:39 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>,
	Steve =?utf-8?Q?Fr=C3=A9cinaux?= <nudrema@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vr6udtbmv.fsf@assigned-by-dhcp.cox.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel-git (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35818>


--R6sEYoIZpp9JErk7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 02, 2007 at 12:30:16PM -0800, Junio C Hamano wrote:
> Steve Fr=C3=A9cinaux <nudrema@gmail.com> writes:
>=20
> > When using git-svn to access a SVN repo, the commit policy may
> > vary. While git makes you commit small patches often, svn users tend
> > to prefer bigger patches that implement a functionnality at once.
> >
> > So at the end you have a SVN commit which corresponds to several git on=
es.
>=20
> I personally think this is solving a wrong problem.  Commit
> granularity is a property of the project, the way in which
> people involved in the project prefer working.  It is not about
> "svn users" vs "git users", and it shouldn't be, especially if
> the end result is still a single project.
>=20
> Is git "making you commit small patches often"?  I honestly hope
> we are not forcing you to do so, although we took pains to make
> it easier because it tends to be easier to look at the history
> later when commit boundaries match the logical steps of
> evolution.
>=20
> So my suggestion would be to educate people who tend to make too
> large commits better separate their commits, and at the same
> time coallesce the commits you create on the git side into a
> presentable size, if you acquired a bad habit of making too
> small commits, so that everybody follows the same commit
> granularity guideline set by the project.

  Though an operation that I'd often like to do is to merge two (or
more) patches as one, and reedit its entry, preferably as a merge of the
two (or more) old logs.

  The reason is simple, I often use git commit as :wq in my editor, and
sometimes think that in a A--B--C--D and in fact, I'd prefer to have:

  {A,C}--B--D. how is it possible to do that in a not too cumbersome
way? because that would make sens to work in some scratch branch, and
then reorganize patches in a saner better way in the master branch.

  But I fail to see how to achieve that without using cumbersome
export-to-patch then git apply patch and edit logs which is painful and
not really using git.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--R6sEYoIZpp9JErk7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFmssDvGr7W6HudhwRAgrAAJ459mqxclVp+1fRJYJDE9ZyfXK5vwCbBHWk
wtYMiE3KGnHJmI/kXq4XLgQ=
=PYCk
-----END PGP SIGNATURE-----

--R6sEYoIZpp9JErk7--
