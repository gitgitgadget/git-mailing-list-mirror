From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [BUG] git checkout <branch> allowed with uncommitted changes
Date: Thu, 13 Oct 2011 22:07:31 +0200
Message-ID: <1318536451.4646.79.camel@centaur.lab.cmartin.tk>
References: <loom.20111013T094053-111@post.gmane.org>
	   <CACsJy8Dzy5-kOZAjwdx=ooUdnN0L2F3EiNQ7b==3AGQZYjEUXQ@mail.gmail.com>
	   <20111013145924.2113c142@ashu.dyn.rarus.ru>
	   <loom.20111013T130924-792@post.gmane.org> <4E96D819.20905@op5.se>
	   <loom.20111013T152144-60@post.gmane.org>
	  <1318517194.4646.30.camel@centaur.lab.cmartin.tk>
	  <loom.20111013T171530-970@post.gmane.org>
	 <1318525486.4646.53.camel@centaur.lab.cmartin.tk>
	 <loom.20111013T193054-868@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-pCJwbcVzX+IzMhbfPh0a"
Cc: git@vger.kernel.org
To: arQon <arqon@gmx.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 22:07:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RERZ5-0006Ap-5r
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 22:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754601Ab1JMUHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 16:07:34 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:36188 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754537Ab1JMUHd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 16:07:33 -0400
Received: from [192.168.1.17] (brln-4dbc7ca2.pool.mediaWays.net [77.188.124.162])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 300E5460FE;
	Thu, 13 Oct 2011 22:07:05 +0200 (CEST)
In-Reply-To: <loom.20111013T193054-868@post.gmane.org>
X-Mailer: Evolution 3.0.3-2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183521>


--=-pCJwbcVzX+IzMhbfPh0a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2011-10-13 at 18:19 +0000, arQon wrote:
> Carlos Mart=C3=ADn Nieto <cmn <at> elego.de> writes:
> > If file1.txt in the foo branch is different from the one in the master
> > branch, git will refuse to switch branches. 'git diff foo master' shoul=
d
> > show that those two files are different.
>=20
> Right, but only for a definition of "branch" that is actually "a fully
> committed branch", hence the confusion and the mention of "uncommitted
> changes" in the topic.

I'm not aware of any other definition of a branch, either for git or
subversion.

>=20
> An expectation that "co branch" should be analogous to "cd ../branch/" is=
 by
> no means unreasonable. YOU may know better, but it's surprisingly non-obv=
ious,

I don't see how. Switching branches is not the same as changing
directories. It doesn't work that way, neither with git nor subversion.
If you choose to have each branch in their own directory, that's fine,
but it has very little to do with the VCS tool.

> especially considering the -f option on checkout and the wording of -m, b=
oth
> of which strongly suggest that, in the absence of either of those flags, =
git
> WILL preserve the worktree by refusing to switch until that potentially-
> harmful situation is resolved by the user.

The general description could probably benefit from a more explicit
mention of what happens if there are local modifications. Currently it
looks like it's only mentioned in the text of -f and -m, which is not
particularly helpful.

>=20
> > Committing non-working code is fine, as long as you don't push it out.
>=20
> Right, but for the problem I was describing it's actually "committing
> non-working code is a requirement, in this situation, if you don't want y=
our
> tree to get eaten". Going from "you absolutely must not do this" to "you =
must
> do this" takes some mental adjustment, but you also have to be *aware* th=
at
> you now have to do something that was previously prohibited, which I wasn=
't.

You can also have a different directory for the other branch if you
really don't want to commit until it works. This is the same situation
that you find yourself right now with subversion; I don't see how it's
that hard to recognise that.

>=20
> > The bigger problem seems to be your reluctance to accept that git is
> > different from subversion
>=20
> Not at all. If I didn't WANT something different, I wouldn't have been tr=
ying
> to move to git in the first place.  :)
>=20
> > but don't go around saying that git
> > corrupts branches when that's blatantly not true.
>=20
> See my first para in this post (or indeed, the original post). It's "not =
true"
> provided all branches are fully committed when you switch between them.

Right.

> It blatantly IS true if you switch from a dirty branch.

No. The branch has not been corrupted or changed at all. Your local
modifications to files in the working tree were kept. Again, this
happens both for git and svn.

> Redefining "branch" to mean "fully committed branch" makes it "not true" =
in
> that context, but so does redefining green to be red and saying that gras=
s is
> red in that context: it may be correct from a certain POV, but it's
> incomprehensible to anyone who isn't aware of that semantic change.

This smells like FUD. A branch and a directory are two different things.
If you find it more comfortable to use different directories for
different branches that's fine, but that doesn't make it a branch.
Changing a file doesn't automatically mean that that version of the file
belongs to the currently active branch (or URL in the case for svn). A
branch is only ever changed when you commit. This is something that
holds true across VCSs. Play with subversion's 'switch' command, it
behaves the same way.

   cmn


--=-pCJwbcVzX+IzMhbfPh0a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOl0UDAAoJEHKRP1jG7ZzTdDsH/iY/CbE8t6mt4lxfl+bq7X+0
AWt6zcUOv9OkqiYPRN2EYoEumq11K51L3TCR/74svokUNkYyOLdswrzMDUtlUHdA
LcZVVtJWKr1ObKEQvX1ojDXWpULUsvsYWDFs9n7p3eY2TXlzeIHBCoxbMFB3r+LI
PUkkH1mGSQ3tx0dN3zAwEhVvnuDn1wENLGDXl3MWL6mZKjKNjzoYjS/5QBKry4+P
coX3rM/1kniLPVR4TB331xxzkzI5+hctPryLemyyW1BufWzvQxZSvrgk9qou76eW
2OJ3AYcgRRA31kyOeMYHeWZGgdT7PAmrrAWnPN5MtOmsjHWEOb6vlUw8LeP5T9s=
=lG60
-----END PGP SIGNATURE-----

--=-pCJwbcVzX+IzMhbfPh0a--
