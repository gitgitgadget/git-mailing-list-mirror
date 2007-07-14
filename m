From: Jan Hudec <bulb@ucw.cz>
Subject: Re: mtimes of working files
Date: Sun, 15 Jul 2007 00:22:21 +0200
Message-ID: <20070714222221.GB3678@efreet.light.src>
References: <f36b08ee0707110808h56ecbc7at9c92727c01cca508@mail.gmail.com> <Pine.LNX.4.64.0707111940080.4516@racer.site> <20070711202615.GE3069@efreet.light.src> <200707120857.53090.andyparkins@gmail.com> <1184261246.31598.139.camel@pmac.infradead.org> <20070713003700.GA21304@thunk.org> <1184367619.2785.58.camel@shinybook.infradead.org> <alpine.LFD.0.999.0707131617270.20061@woody.linux-foundation.org> <1184370414.2785.79.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Theodore Tso <tytso@mit.edu>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: David Woodhouse <dwmw2@infradead.org>
X-From: git-owner@vger.kernel.org Sun Jul 15 00:22:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9q0W-0000bb-Bx
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 00:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764137AbXGNWW3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 18:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763862AbXGNWW3
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 18:22:29 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:57380 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762102AbXGNWW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 18:22:28 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id C57AF57283;
	Sun, 15 Jul 2007 00:22:27 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id 7W9GuDD8EAX5; Sun, 15 Jul 2007 00:22:26 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 935B85726E;
	Sun, 15 Jul 2007 00:22:24 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1I9q0L-0002cB-FB; Sun, 15 Jul 2007 00:22:21 +0200
Content-Disposition: inline
In-Reply-To: <1184370414.2785.79.camel@shinybook.infradead.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52513>


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 14, 2007 at 00:46:54 +0100, David Woodhouse wrote:
> On the occasions I actually try to _use_ branches, I find it very
> suboptimal. Perhaps it's just because I'm stupid. I'm sure that's why I
> ended up committing changes to the wrong branch. But having to rebuild
> (even with ccache) after changing branches is a PITA. Just changing
> branches at all is a PITA if you have uncommitted changes (which I
> usually do because I've usually tested _some_ random patch in a build
> tree for the hardware which is closest to hand). Pulling a whole bunch
> of unwanted changes on the 'development' branch while on GPRS, when all
> I really needed was a single commit from the 'stable' branch also didn't
> amuse me, although I'm sure if I had the time to play with it I'd have
> been able to avoid that.

I have to say it's the exact oposite for me. I used to have branches checked
out separately, with arch and than bzr, and I find the git way much easier =
in
the end. Exactly because I don't need the multiple checkouts. Often, each of
them needed to contain some local stuff (like test data or some configurati=
on
for building) and rebuilding in one of them does not help the others (usual=
ly
they are very close to each other).

For uncommited changes, git makes it possible (yes, I agree it is an extra
command one might want to avoid) to commit them and them uncommit or amend
the commit when you get back to them.

Pulling something into the wrong place can happen quite as likely, at least
to me, with separate checkouts as with switching in one place. And than git
actually makes it much easier to fix it when you are in a single tree. Until
you publish, you git allows fixing anything with commit --amend and/or rese=
t.

> I can, and do, mirror stuff from all kinds of suboptimal version control
> systems into single-branch git trees. And I include multi-branched git
> trees in my definition of 'suboptimal'. My ability to do that doesn't
> really help the newbies who are expected with branches, though.

For newbies, the bzr approach is much easier to grasp, even though I really
find that the git one is actually a little nicer to work with.

> I just wish people would make stuff available on the _servers_ in
> separate trees rather than in branches -- if some people prefer branches
> locally then that's their option; at the moment we kind of force people
> into it. They _could_ avoid it but they'd have to know what they're
> doing.

You can treat the servers as separate trees! When cloning and/or pulling, y=
ou
can set up to pull just the one branch you are interested in. Having them as
separate trees would either be inefficient (the data would not be shared), =
or
would bring it's own class of problems.

I would like, if git could have something like "checkouts". The idea is, th=
at
a checkout would contain the working tree, .git/HEAD saying what revision it
is at and .git/index and everything else would be linked from the repository
it is checked out from. That would allow you to have different branches
checked out at different places, while not only sharing all the data, but
also all of them available in all the checkouts and commands like pull
updating it in all of them.

It would be IMHO possible to symlink all the stuff in .git except HEAD and
index, except for one problem. This is if you have two checkouts from the
same branch and check out of them, the other one needs to know, that it's
head should now be detached to stay where it was.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGmUydRel1vVwhjGURAtmNAJ9g+57292vBgcNwYZgT6MHlcP1e4wCg3a/X
tphaHRspIEsjVt8FEeAJjnA=
=RLh6
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
