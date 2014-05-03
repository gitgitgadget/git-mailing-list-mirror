From: "W. Trevor King" <wking@tremily.us>
Subject: Re: pull.prompt or other way to slow/disable 'git pull'
Date: Fri, 2 May 2014 17:05:30 -0700
Message-ID: <20140503000530.GP28634@odin.tremily.us>
References: <20140502145433.GF28634@odin.tremily.us>
 <5363ea28d3c14_70ef0f30c94@nysa.notmuch>
 <20140502190746.GJ28634@odin.tremily.us>
 <5363ee55ac2af_70ef0f30cf3@nysa.notmuch>
 <20140502194637.GL28634@odin.tremily.us>
 <5364015a94900_135215292ec28@nysa.notmuch>
 <20140502211305.GN28634@odin.tremily.us>
 <53640bc1ee6eb_135215292ec95@nysa.notmuch>
 <20140502220107.GO28634@odin.tremily.us>
 <53641a1be8d24_1c7bdcd2f049@nysa.notmuch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MWF3YmTHhoLNIVQC"
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 03 02:05:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgNSX-0004Tm-A7
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 02:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569AbaECAFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 20:05:34 -0400
Received: from qmta04.westchester.pa.mail.comcast.net ([76.96.62.40]:42317
	"EHLO qmta04.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752109AbaECAFd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 May 2014 20:05:33 -0400
Received: from omta06.westchester.pa.mail.comcast.net ([76.96.62.51])
	by qmta04.westchester.pa.mail.comcast.net with comcast
	id x8dr1n00416LCl054C5YMF; Sat, 03 May 2014 00:05:32 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta06.westchester.pa.mail.comcast.net with comcast
	id xC5W1n00s152l3L3SC5XVT; Sat, 03 May 2014 00:05:32 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 880F71174BE0; Fri,  2 May 2014 17:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1399075530; bh=ixdCARfRq+nBRni64MJuCrzmldNf4JUDHeG/ga4+6LQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ABPrjDmLBk7yiWDWLRgrgqt9ItyDzwk26uFOTHcJXjMfjwblg5vttdg6+uJPw5N1p
	 eN5y0GnBBzd1pQXOB9DjRLrOWUByutO9PJwlDXvsLuhox+pdmDlGPmUR3gjw3W524A
	 0G6QNWm3s3q3hbPZaoiKgPmbZ5AOU74XyjAxvXxg=
Content-Disposition: inline
In-Reply-To: <53641a1be8d24_1c7bdcd2f049@nysa.notmuch>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.23 (2014-03-12)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1399075532;
	bh=KU1PwIIW4KfkTXyXmpPsBW3GelygQyDstnHlh6PcSSw=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=c0EWCrjPl+Z4O66SQDh0drUsCRyR+p3ZQi57OTyYlRiIyT3TVOgp8rIRNQ5Ja22Vk
	 hd3LoXDWPMydFFOIa9MvAXv0KdVa4MFsg4s5gFHi4pgi1OmQTayRZCuUMXguInHcof
	 NXvDRKcL1B1a4SeVvymYllZaSu2xbOOQ0P+Bv+t88LjGCpzqMfMzbpFDeYEaiqNsmF
	 WRsepyTSuGk3Leu/CLM57x6VG3K8nYRj1qmsqwg0cPQr32mZhL1Xd7ukcxTijG/eWA
	 71XMtVSgrFdDS55o/Oqei/CEx0hgSVSnmUhz9d7A4d6NvVjBBHuJMSNe4PkuxhJhn0
	 gNGx6vyK9LjQQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248011>


--MWF3YmTHhoLNIVQC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 02, 2014 at 05:20:11PM -0500, Felipe Contreras wrote:
> W. Trevor King wrote:
> > > > The 'git pull' (with 'none' mode) explainer just helps retrain folks
> > > > that are already using the current 'git pull' incorrectly.
> > >=20
> > > If you are going to train them to use a configuration, it should be:
> > >=20
> > > % git config --global pull.ff false
> >=20
> > I don't want all pulls to be --no-ff, only pulls from topic branches.
>=20
> Pulling some branch to a topic branch, or pulling a topic branch to
> another branch?

The latter.  Here's a more detailed list:

1. HEAD: an integration branch (master, maint, =E2=80=A6)
   target: @{upstream}, branch.*.pushremote, and other mirrors
   my preferred integration mode: ff-only merge the target

2. HEAD: an integration branch
   target: a *different* branch (e.g. maint or feature-x, but not
     origin/master or jdoe/master, if HEAD is master)
   my preferred integration mode: no-ff merge the target into HEAD.

3. HEAD: a topic branch (e.g. feature-x)
   target: a collaborating topic branch (jdoe/feature-x)
   my preferred integration mode: ff-only merge the target

4. HEAD: a topic branch (e.g. feature-x)
   target: a related topic branch (e.g. jdoe/feature-y) or integration
     branch updates used by my feature-x
   my preferred integration mode: rebase feature-x onto the target

Cases 1 and 2 can usually be distinguished by comparing the
checked-out branch with the branch portion of the remote-tracking
reference), but for folks developing in master, jdoe/master may be a
feature branch (case 2) not a mirror of the maintenance branch (case
1).

Cases 1 and 3 are the same idea, with any feature branch running long
enough to get collaborators being indistinguishable from an
integration branch except that the latter will eventually be merged
(or dropped) and deleted.

In the event of non-trivial merge conflicts in case 2, I sometimes
rebase the target onto HEAD and no-ff merge the resulting target'.  On
the other hand, sometimes rebasing is not an option.  For example, if
I want to merge the target into both master and maint, but master
contains a conflicting commit A:

  -o---o---A---o---B  master
   |\
   | o---o---C  maint
    \
     o---D  target

Rebasing would drag A into maint at F:

  -o---o---A---o---B---E  master
    \       \         /
     \       o---D'---  target'
      \           \
       o---o---C---F  maint

And I don't want both the pre- and post-rebase versions in my history
at G:

  -o---o---A---o---B---E---G  master
   |\       \         /   /
   | \       o---D'---   /  target'
   |  \                 /
   |   o---o---C---F----  maint
    \             /
     o---D--------  target

So I'd just deal with a complicated merge at E:

  -o---o---A---o---B---E---G  master
   |\                 /   /
   | o---D------------   /  target
    \           \       /
     o---o---C---F------  maint

Case 4 has similar caveats, since you don't want to rebase feature-x
on top of jdoe/feature-y if there are already other branches based on
the current feature-x that can't (or won't) be rebased.

> Either way, since I think these two are different modes:
>=20
>   1) git pull
>   2) git pull origin topic
>=20
> Maybe it would actually make sense to have a configuration specific to
> 2): pull.topicmode.

I think it makes more sense to just use merge/rebase explicitly, and
not try and bundle all of this complication into something that *also*
fetches.  Unfortunately, there's currently no finger-breaker to help
compulsive pull users break the habit or keep novices from starting.
Adding more elaborate handling to pull just pushes back the point
where you reach something that is pretty much impossible to resolve
automatically (like my case 2 caveat).  When that happens, it would be
nice to have a workflow independent way to calm the pull-happy user
(e.g. pull.mode=3Dnone, or pull.prompt=3Dtrue) while they learn to
explicitly use fetch/{merge|rebase} or more careful pulls.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--MWF3YmTHhoLNIVQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTZDLHAAoJEKKfehoaNkbtbw4P/0N2zSefSJEcA+kmY+kqsYMC
7i8b2sgEZOxTucLezKX+3SFGGh1yg5qFSZ17jerkKYrxru8I7swM1Tnzd9CM4PIT
yHnE1tbkk7cub2ESNAbHBHVNVOK/RuDQX/t4mXmCKhpOmQ3iM9kHSytKROTvtOHA
Ec8p1QDZ2mnQY7q/enk+f8w1DvKzQVml5zchyxK8sjYslWiLFMM7hqHT3d2tnpMb
PD2rv1vARj6w4yen4LxZNU5GOKDo61JwPLFoCmTYG/2R+bSVFae9s59ogLhGnDy9
VvJBSN65BXSMO56NVxcSA7yK0dsh4awKkNOQRisoWMA9kdnKHWLTTJ/WzmpVjRw0
hh/FeB9ZjX4E1DnhJmxUqWuj0xnGOf2t3nbNidWSwEbFMWNpR9iKhTPYsgs/rIV8
Pkc/i9tTJHfRauetrUBCGLPWSoMeZJDe897obZ5fJE/XcgHsGM4ROUul9tg0UEyq
c8MxDh8x4d4ECcscrZHDGkS4fHvOkmsiRv3foZnoUwP8vLAdj49/TNJyGygqrtj+
m5cTBBvWicUF2hJ6448hH5Yn5Qu6AgCgVskzlGrTQmuVSZ8Sgq0tMY89i2GXsHfO
m7jvCH8MCxxVElc0NUbeoStxdewzrDFvxc8DmBEKgqib0ti5s07o9yb/eFhJcswG
Tvrw4MfhbEswUg5gZRXh
=4X+i
-----END PGP SIGNATURE-----

--MWF3YmTHhoLNIVQC--
