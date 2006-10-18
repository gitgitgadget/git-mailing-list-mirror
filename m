From: Robert Collins <robertc@robertcollins.net>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 14:55:48 +1000
Message-ID: <1161147348.3423.24.camel@localhost.localdomain>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	 <200610170119.09066.jnareb@gmail.com> <45346290.6050300@utoronto.ca>
	 <200610171120.09747.jnareb@gmail.com>
	 <1161078035.9020.73.camel@localhost.localdomain>  <4534AB8B.8030505@op5.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-tNA1Is/FuRPXROPiW1+p"
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 18 07:14:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga3lP-00052l-0u
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 07:14:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771AbWJRFOo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 01:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWJRFOo
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 01:14:44 -0400
Received: from ipmail01.adl2.internode.on.net ([203.16.214.140]:28558 "EHLO
	ipmail01.adl2.internode.on.net") by vger.kernel.org with ESMTP
	id S1751376AbWJRFOn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 01:14:43 -0400
Received: from ppp245-86.static.internode.on.net (HELO lifelesswks.robertcollins.net) ([59.167.245.86])
  by ipmail01.adl2.internode.on.net with ESMTP; 18 Oct 2006 14:26:26 +0930
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AR4FAMtTNUWBSg
X-IronPort-AV: i="4.09,322,1157293800"; 
   d="asc'?scan'208"; a="31225256:sNHT5673019044"
Received: from ppp112-44.static.internode.on.net ([150.101.112.44] helo=lifelesslap.robertcollins.net)
	by lifelesswks.robertcollins.net with esmtpa (Exim 4.60)
	(envelope-from <robertc@robertcollins.net>)
	id 1Ga3Tb-0006hr-0A; Wed, 18 Oct 2006 14:56:23 +1000
Received: from localhost.on.net ([127.0.0.1] helo=localhost.localdomain)
	by lifelesslap.robertcollins.net with esmtp (Exim 4.60)
	(envelope-from <robertc@robertcollins.net>)
	id 1Ga3T4-0001AB-2Q; Wed, 18 Oct 2006 14:55:50 +1000
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <4534AB8B.8030505@op5.se>
X-Mailer: Evolution 2.6.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29188>


--=-tNA1Is/FuRPXROPiW1+p
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-10-17 at 12:08 +0200, Andreas Ericsson wrote:
> Robert Collins wrote:
> > On Tue, 2006-10-17 at 11:20 +0200, Jakub Narebski wrote:
> >>           ---- time --->
> >>
> >>     --*--*--*--*--*--*--*--*--*-- <branch>
> >>           \            /
> >>            \-*--X--*--/
> >>
> >> The branch it used to be on is gone...
> >=20
> > In bzr 0.12 this is :
> > 2.1.2
> >=20
>=20
> Would it be a different number in a different version of bazaar?

The dotted decimal display has only been introduced in bzr 0.12

> > (assuming the first * is numbered '1'.)
> >=20
> > These numbers are fairly stable, in particular everything's number in
> > the mainline will be the same number in all the branches created from i=
t
> > at that point in time, but a branch that initially creates a revision o=
r
> > obtains it before the mainline will have a different number until they
> > syncronise with the mainline via pull.
> >=20
>=20
> So basically anyone can pull/push from/to each other but only so long as=20
> they decide upon a common master that handles synchronizing of the=20
> number part of the url+number revision short-hands?

Anyone can push and pull from each other - full stop. Whenever they
'pull' in bzr terms, they get fast-forward happening (if I understand
the git fast-forward behaviour correctly). After a fast-forward, the
dotted decimal revision numbers in the two branches are identical - and
they remain immutable until another fast forward occurs. Push always
fast forwards, so the public copy of ones own repository that others
pull or merge from is identical to your own. In a 'collection of
branches with no mainline' scenario, people usually have fast forward
occur from time to time, keeping the numbers consistent from the point
your branch was last pulled by someone else, or you pulled them.

> One thing that's been nagging me is how you actually find out the=20
> url+number where the desired revision exists. That is, after you've=20
> synced with master, or merged the mothership's master-branch into one of=20
> your experimental branches where you've done some work that went before=20
> mothership's master's current tip, do you have to have access to the=20
> mothership's repo (as in, do you have to be online) to find out the=20
> number part of url+number shorthand, or can you determine it solely from=20
> what you have on your laptop?

You can determine it locally - if you know any of the motherships
revisions locally, we can generate the dotted-revnos that the
motherships master-branch would have from the local data - and the last
merge of mothership you did will have given you that details. I dont
think we have a ui command to spit this out just yet, but it will be
trivial to whip one up.

More commonly though, like git users have 'origin' and 'master'
branches, bzr users tend to have a branch that is the 'origin' (for bzr
itself this is usually called bzr.dev), as well as N other branches for
their own work, which is probably why we haven't seen the need to have a
ui command to spit out the revnos for an arbitrary branch.

-Rob

--=20
GPG key available at: <http://www.robertcollins.net/keys.txt>.

--=-tNA1Is/FuRPXROPiW1+p
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBFNbPUM4BfeEKYx2ERAjStAJ4jj4QNqmuihdmGGByNswpBjOGaqgCgnolS
FEsH1jfz4FgqC3P5y7MFIKg=
=xTM5
-----END PGP SIGNATURE-----

--=-tNA1Is/FuRPXROPiW1+p--
