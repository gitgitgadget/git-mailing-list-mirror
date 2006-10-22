From: David Clymer <david@zettazebra.com>
Subject: Re: VCS comparison table
Date: Sun, 22 Oct 2006 15:18:05 -0400
Message-ID: <1161544685.22276.127.camel@zepto.home.zettazebra.com>
References: <45357CC3.4040507@utoronto.ca>
	 <200610211608.18895.jnareb@gmail.com>
	 <20061021181149.GM75501@over-yonder.net>
	 <200610212141.51829.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-9v78VrB7Bbiv22lN93M7"
Cc: "Matthew D. Fuller" <fullermd@over-yonder.net>,
	Andreas Ericsson <ae@op5.se>,
	Linus Torvalds <torvalds@osdl.org>,
	Carl Worth <cworth@cworth.org>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 21:17:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gbip9-00048g-Aq
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 21:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWJVTRR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 15:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbWJVTRR
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 15:17:17 -0400
Received: from zettazebra.com ([72.36.162.130]:40644 "EHLO zettazebra.com")
	by vger.kernel.org with ESMTP id S1750761AbWJVTRQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Oct 2006 15:17:16 -0400
Received: from 67-23-48-101.chvlva.adelphia.net ([67.23.48.101] helo=[192.168.11.100])
	by zettazebra.com with esmtpa (Exim 4.50)
	id 1Gbiok-0001Qw-70; Sun, 22 Oct 2006 15:17:06 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610212141.51829.jnareb@gmail.com>
X-Mailer: Evolution 2.6.3 
X-SA-Exim-Connect-IP: 67.23.48.101
X-SA-Exim-Mail-From: david@zettazebra.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29775>


--=-9v78VrB7Bbiv22lN93M7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 2006-10-21 at 21:41 +0200, Jakub Narebski wrote:
> Matthew D. Fuller wrote:
> > On Sat, Oct 21, 2006 at 04:08:18PM +0200 I heard the voice of
> > Jakub Narebski, and lo! it spake thus:
> >> Dnia sobota 21. pa=C5=BAdziernika 2006 15:01, Matthew D. Fuller napisa=
=C5=82:
>=20
> >> When two clones of the same repository (in git terminology), or two
> >> "branches" (in bzr terminology), used by different people, cannot be
> >> totally equivalent that is centralization bias.
> >=20
> > This is obviously some new meaning of "centralization" bearing no
> > resemblance whatsoever to how I understand the word.
>=20
> Perhaps I'd better use "star topology bias" instead of "centralization
> bias".
> =20
> > In git, apparently, you don't give a crap about a branch's identity
> > (alternately expressible as "it has none"), and so you throw it away
> > all the time.  Given that, revnos even if git had them would never be
> > of ANY use to you, so it's no wonder you have no use for the notion.
>=20
> In git branches are lightweight. Branch names are local to repository.
> Repositories have identity. Bzr "branch" is strange mix of one-branch
> git repository and git branch.
>=20
> Git main workflow is fully decentralized workflow. All clones of the
> same repository are created equal. In bzr the suggested workflow
> (with revnos) forces one (or more) branches to be mainline (use "merge",
> get empty-merges, revnos don't change) and leaf (use "pull", revnos
> change).
> =20
> > I DO give a crap about my branchs' identities.  I WANT them to retain
> > them.  If I have 8 branches, they have 8 identities.  When I merge one
> > into another, I don't WANT it to lose its identity.  When I merge a
> > branch that's a strict superset of second into that second, I don't
> > WANT the second branch to turn into a copy of the first.  If I wanted
> > that, I'd just use the second branch, or make another copy of it.  I
> > don't WANT to copy it.  I just want to merge the changes in, and keep
> > on with my branch's current identity.
>=20
> I don't understand. If I merge 'next' branch into 'master' in git, I=20
> still have two branches: 'master' and 'next'.
>=20
> And I don't understand why you are so hung on branch identities. Yes, if
> somebody clones your 'repo' repository, he can have your 'master' branch
> (refs/heads/master) named 'repo' (refs/heads/repo) or 'repo/master'
> (refs/remotes/repo/master), but why that matters to you. It is _his_
> (or her ;-) clone.=20
>=20

I think you missed the point. Speaking for myself, I want to maintain
the identity of _my_ branches. If you clone one of them, I _don't_ care.
That's your branch. Branch identity as presented here is not intended to
be globally significant. It's locally significant.

> > Now, we can discuss THAT distinction.  I'm not _opposed_ to git's
> > model per se, and I can think of a lot of cases where it's be really
> > handy.  But those aren't most of my cases.  And as long as we don't
> > agree on branch identity, it's completely pointless to keep yakking
> > about revnos, because they're a direct CONSEQUENCE of that difference
> > in mental model.  See?  They're an EFFECT, not a CAUSE.  If bzr didn't
> > have revnos, I'd STILL want my branch to keep its identity.  You could
> > name the mainline revisions after COLORS if you wanted, and I'd still
> > want my branch to keep its identity.  Aren't we through rehashing the
> > same discussion about the EFFECTS?
>=20
> For revnos to work you MUST have one "branch" to be considered
> special, the hub in star topology. This very much precludes fully
> distributed development.=20
>=20
> BTW. I get that you can use revids in revnos in bzr for fully
> distributed and not star-topology geared development. But
> Bazaar-NG revids are uglier that Git commit-ids.

OK, just to clarify what you are saying here:=20

1. revnos don't work because they don't serve the same purpose as revids
or git's SHA1 commit ids.

2. bzr does not support fully distributed development because revnos
"don't work" as stated in #1.

3. Ok, bzr does support distributed development, I just say it doesn't
because I think revids are ugly.

Thus, revids are ugly.

Is this really the argument you want to be making? I'm not disagreeing
with you; it's just that I'm not sure it's relevant.

Can we just put the whole "revnos don't work" thing to rest?

Revnos are only intended to be significant relative to a given branch.
They are not intended to serve as an absolute, global identifier.

Revnos + a url _are_ globally significant, but are not static except in
certain topologies.

Revids are globally significant and static in any topology.

If a user does not like or cannot use revnos, they may use revids.
Revnos are not a tool to be used for every job. In no way does that mean
that they are broken.

If a given developer or group of developers primarily use revnos or
revids, it _may_ indicate that _they_ have a bias towards central (or
star) or distributed development, but does not necessarily have any
bearing on the capability of the VCS being used.

>=20
> [...]
> >> And you say that bzr is not biased towards centralization? In git
> >> you can just pull (fetch) to check if there were any changes, and if
> >> there were not you don't get useless marker-merges.
> >=20
> > If I don't tell you my branch has something in it ready to grab, you
> > shouldn't merge it.  It probably won't work, and is quite likely to
> > set your computer on fire, slaughter and fillet your pet goldfish, and
> > make demons fly out of your nose.  If you wanna get stuck with all my
> > incomplete WIP, let's just use a CVS module and be done with it.
>=20
> In git I can fetch your changes but I don't need to merge them. Take
> for example Junio 'pu' (proposed updates) branch: this is the branch
> you shouldn't merge as it's history is constantly being rewritten.
>=20
> If you don't want for your WIP to be publicly available, you don't
> publish it. For example as far as I understand Junio works on Git
> in his private repository, with many, many feature branches, but
> he does push to public [bare] repository only some subset of branches,
> and we can fetch/pull only those.
>=20
> But still, if I am impatient I can pull from Junio every hour, and
> I don't get 24 totally useless empty merge messages if he took day
> off and didn't publish any changes till day later.
>=20
> >> 2. But the preferred git workflow is to have two branches in each of
> >> two clones. The 'origin' branch where you fetch changes from other
> >> repository (so called "tracking branch") and you don't commit your
> >> changes to [...]
> >=20
> > Funny, since this reads to me EXACTLY like the bzr flow of "upstream
> > branch I pull" and "my branch I merge from upstream" that's getting
> > kvetched around...
>=20
> But please, have you realized that in this workflow the two clones
> of the same repository are totally symmetrical? One's 'master' is
> another 'origin' and vice versa. After pull on one side, and pull
> on the other side (without any changes in between) we have the same
> contents, and the same revision names (commit-ids in git), even if
> the changes (revisions) got to those clones in different order.
> In bzr those two "branches" would get different revnos. No symmetry.
> Full distributed vs star topology (one branch "central", hence
> "centralized" - I don't mean need to access to one central repository,
> although...)

I think that when I attempt to pull from one branch to another, if they
are identical, neither branch changes. Merging + pulling results in
identical history, causing revnos on the pulling branch to change. Just
merging maintains divergent views of the same history.=20

Perhaps bzr has a central bias in the view that each developer has the
option of seeing their own branch as the central focus of his/her
development. This view would be the same from each branch; each
developer views his/her own branch as special. If the developer does not
want to view their own branch specially, they would merge + pull rather
than just merging. If I remember correctly, abentley covered this
earlier in this whole "VCS comparison table" thread.

Anyway, much of this seems to be a disagreement over the definition of
"distributed VCS." Perhaps this is too simplistic, but to my inexpert
eyes, these appear to be the positions of each side:

Bzr: Branches and all shared history may be stored locally in disparate
locations, and all VCS functions are available locally.

Git: Same thing, except that all shared history must also be identically
ordered.

Did I get that right?

In general, as a mere _user_ of distributed VCS, all I care about is if
I can accurately point you to a particular commit or set of commits, and
that you can access them either in shared history or in a given branch.
The fact that the VCS does not require a central branch and facilitates
code interchange, means to me that it is distributed. As long as all
major uses are fully supported, being slightly biased toward one use
case or another is not a distinction I consider to be worth making.

-davidc
--=20
gpg-key: http://www.zettazebra.com/files/key.gpg

--=-9v78VrB7Bbiv22lN93M7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFO8Pt2XpGgG+SNaERArj9AKCKP1IDkwgkemDKTDMSMCiTckCLJwCgmSNi
yygCMURMQjHsthryMKHz/nA=
=JqcJ
-----END PGP SIGNATURE-----

--=-9v78VrB7Bbiv22lN93M7--
