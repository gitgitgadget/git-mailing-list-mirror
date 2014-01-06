From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Mon, 6 Jan 2014 09:22:30 -0800
Message-ID: <20140106172230.GT3156@odin.tremily.us>
References: <CALas-ii90x07Kbxzy_siBJV_RHPkvBw7spFBD9vi6o43mU1k6g@mail.gmail.com>
 <d0de817dfc687fd943349c9d3e1d410161a0f01e.1388938473.git.wking@tremily.us>
 <20140105194850.GA2994@book.hvoigt.net>
 <20140105212458.GG3156@odin.tremily.us>
 <20140105225733.GB4660@book.hvoigt.net>
 <20140105233943.GJ3156@odin.tremily.us>
 <20140106154739.GD27265@t2784.greatnet.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nSQp8DZZn7gZbDHt"
Cc: Git <git@vger.kernel.org>, Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Jan 06 18:22:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0Dst-0006oQ-Rq
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 18:22:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755725AbaAFRWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 12:22:35 -0500
Received: from qmta01.westchester.pa.mail.comcast.net ([76.96.62.16]:51231
	"EHLO qmta01.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755694AbaAFRWd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jan 2014 12:22:33 -0500
Received: from omta06.westchester.pa.mail.comcast.net ([76.96.62.51])
	by qmta01.westchester.pa.mail.comcast.net with comcast
	id Afo01n00516LCl051hNZbf; Mon, 06 Jan 2014 17:22:33 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta06.westchester.pa.mail.comcast.net with comcast
	id AhNX1n009152l3L3ShNXa5; Mon, 06 Jan 2014 17:22:32 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 9B318E915BB; Mon,  6 Jan 2014 09:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1389028950; bh=rLVPFHo/LvVKi6VkMxWBJx4Ny86ZqUVBBdQfupekjiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j6rz/2aRj/vTewXWxfTQPmX6pBGjMj1Jv4FcstoR1AuE6UmvkYIolrM+yhrW9lncY
	 5q4K4wRnjkckt97dQepEszPXAh4ehbszHOEcdBXz58OTQ2oyth5OjdIowvK1mxVHjq
	 iYWCgnojIXoVHwJTdcQ/xLvBJr11SMOYOXimYLT4=
Content-Disposition: inline
In-Reply-To: <20140106154739.GD27265@t2784.greatnet.de>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389028953;
	bh=z0rU4su+1LO2Qwoig5RbRWL5V/gUkd96Ln7en4psbLQ=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=ln0oUg4kipe5l4j/zGicmVFJSCLxXY1lMueylKjKb04MMlzfw4rIfi+/pM+XvE1K1
	 8GqJEPea0NnVHacs0yC+8+hl20MLUUd3S0vftroyUWwfggG+b4Gt3u/K/7QaLGzVWw
	 qcx+YeonM4Y4gVE/8jlA53WPD5lfdQF0h+e1HNuqU/MQ24G05I3CVTj1r7pmBMB3mX
	 Jzowi0XrXc4PegkPP+jW188oBRFjMJtxX7x8jRjw8ErIRf+tcFOAUgzwCxI+F4UkGA
	 +amT856a6raKksLG85b42Yt4An1lDFcFje6jKTesouN2TCFGCB3Cbkk5SaoGN+30/i
	 xB1i7538FOWyQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240033>


--nSQp8DZZn7gZbDHt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 06, 2014 at 04:47:39PM +0100, Heiko Voigt wrote:
> On Sun, Jan 05, 2014 at 03:39:43PM -0800, W. Trevor King wrote:
> > On Sun, Jan 05, 2014 at 11:57:33PM +0100, Heiko Voigt wrote:
> > > On Sun, Jan 05, 2014 at 01:24:58PM -0800, W. Trevor King wrote:
> > > > Thinking through this more, perhaps the logic should be:
> > > >=20
> > > > * If submodule.<name>.update (defaulting to checkout) is checkout,
> > > >   create a detached HEAD.
> > > > * Otherwise, create a new branch submodule.<name>.branch
> > > >   (defaulting to master).
> > >=20
> > > Why not trigger the attached state with the
> > > submodule.<name>.branch configuration option? If there is a
> > > local branch available use that, if not the tracking branch (as
> > > it is currently). Then a developer can start working on the
> > > branch with:
> > >=20
> > > 	cd submodule; git checkout -t origin/<branchname>
> > >=20
> > > assuming that submodule update learns some more support for this.
> >=20
> > Isn't that already what 'git update --remote <submodule>' already
> > does?
>=20
> Does it? As far as I understood (not using the branch option yet) it
> only does
>=20
> 	git checkout origin/<branchname>
>=20
> so there is no local branch created that tracks the remote branch (-t).

That's right.  Anyone who wants to do local development in a submodule
should probably not be using checkout updates, hence my proposal above
to base local-branch creation on submodule.<name>.update.

> What I was thinking is that when submodule.<name>.branch is set a
>=20
> 	git submodule update
>=20
> will:
>=20
> 1. if no local branch with that name exists:
>=20
>    checkout the remote/<branch>
>=20
> 2. If a local branch with that name exists:
>=20
>    checkout the local branch and possibly advance it according to
>    its setting.

This sounds too complicated to me ;).

> Thinking further: Maybe submodule.<name>.update =3D pull could denote
> that a user wants to have a branch ready for work in a submodule.

This sounds like my quoted realization above.  We both even preface
the idea with "thinking" ;).  However, I think merge, rebase,
!command, and all other non-checkout update schemes are already
signals that the developer is interested in local developent (and
therefore wants a branch), without the need to add an aditional 'pull'
(and then how to distinguish between rebase/merge?).

> submodule update will then
>=20
> 1. if no local branch with that name exists:
>=20
>    - automatically create the branch based on the referenced sha1
>    - set up that its tracking remote/<branch>

With my patch this happens with the initial clone-update (as of v2,
only when submodule.<name>.branch is set.  In a hypothetical v3, only
when submodule.<name>.update is not checkout).  I'm not sure we want
to do this if the user switches to non-checkout updates after the
initial cloning update though.  They may actually have work in that
detached HEAD that we'd be clobbering.

>    - issue a git pull in the submodule

I think that updating using the gitlinked sha1 (a local update) and
updating using the upstream origin/$branch (a --remote update) should
always be two distinct events.  Combining them in a single operation
just complicates the situation.

> 2. if a local branch with that name exists:
>=20
>    - issue a git pull in the submodule

That's what we already have with submodule.<name>.update as 'merge'.
The merged object is either the gitlinked sha1 (a local update) or a
re-fetched upstream branch tip (a --remote update).

> > > > We are on a local branch at this point, but not neccessarily
> > > > pointing at the gitlinked sha1.  The reset here ensures that
> > > > the new local branch does indeed point at the gitlinked sha1.
> > >=20
> > > But isn't this a fresh clone? Why should the branch point at
> > > anything else?
> >=20
> > We don't pass $sha1 to module_clone().  Before my patch, we don't
> > even pass $branch to module_clone().  That means that
> > module_clone() will only checkout the gitlinked sha1 when the
> > upstream HEAD (or $branch with my patch) happens to point to the
> > gitlinked sha1.  For example, if Alice adds Charie's repo as a
> > submodule (gitlinking his current master d2dbd39), then Charlie
> > pushes a new commit d0de817 to his master, and then Bob clones
> > Alice's superproject.  Post-clone, Charlie's submodule will have
> > checked out Charlie's new d0de817, and we need update's
> > additional:
> >=20
> >   git reset --hard -q d2dbd39
> >=20
> > to rewind to Alice's gitlinked sha1.
>=20
> Ah yeah, sorry I was confusing this with the checkout of
> remote/<branch> here again. Since I have done that twice already
> maybe we should be careful about not confusing users with this as
> well...
>
> After wrapping my head around the fact that you want to simply create a
> local branch on the referenced sha1 (and hopefully remembering it) I
> still would like to think a little more about it and let it settle a
> bit.

The way I keep this straight is:

1. Submodules are links to Git commits (that's how they're stored in
   the index).
2. There are two places to look if you want to update the linked
   commit:
   a. The superproject's tree (a local updates).
   b. The remote subproject's current submodule.<name>.branch tip (a
      --remote update).
3. There are a number of ways to integrate external updates with your
   local submodule development.
   a. checkout: blow away local development
   b. merge: merge the update into the local branch
   c. rebase: rebase the local branch onto the update
   d. !command: do something fancier

We currently have easy config and command-line switches to select
between 2.a and 2.b, which for me makes extending 1 to support
floating branches unnecessary.  Note that we're always updating to a
referenced sha1, and there are only two places we can look to find
that sha1.

We also have easy config and command-line switches to select between
3.a, 3.b, 3.c, and 3.d.

One thing that's a bit fuzzy is the definition of "local development".
We're currently treating it as "any commits leading up to HEAD that
are not in the update source", which works well until upstream starts
rebasing (or rolling back to an earlier release, etc.).  It's hard for
Git to handle that sort of thing automatically, for all the usual
"recovering from upstream rebase" reasons [1].  I'm fine if we leave
it up to users to resolve this sort of situation by hand.  Folks with
local work should know what was local, and folks without local work
can use a checkout update.

We're also not doing a great job of setting people up for local
development, but that's tricky if they may already have local work.
My "start them on a branch" patch is not saving anyone a lot of work,
but it's a step in that direction.  Doing anything after the initial
cloning update is going to be much harder, because there's not much
that would be unabmiguously helpful.  After all, the current submodule
implementation supports my workflows pretty well.

Cheers,
Trevor

[1]: See "RECOVERING FROM UPSTREAM REBASE" in git-rebase(1).

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--nSQp8DZZn7gZbDHt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSyuZVAAoJEKKfehoaNkbtrAoP/ROTH/s8sW1efGxQJUCL10Ni
w86C6WTXHfU9ZwSCG+YerAhADKbVZ7tH+FCp3QTCqiWjbDaMTo9SC07j608OCNnS
Be5LsHoqbPsicKse2gaup1XCpL7g6+0l19Mv6q3NhHfE8UoLsoIQBeX7kUej5PaS
kifNQ98eNwEGXWxWf4P0+Zbff5LZ7geS8jFjLqz+5A++ZWhpCyFWKrUGTBjzHgoM
e3EspnUil0dWaiz73XEWljHK58NiextiFxgAg0e0uQ+eykfx+j8uJ+6w4bb1PqFf
iGH5OauTEfTu/5cVjCLZc1D3oNfcAzHdY3zCzzlQAEHnJvCOjx6lSeZfnk5lq/ry
aqTcqhjIyxxQZ0u0wzjbAqIe8w1GHNZxAxF3KI2D+l2ZPLTlxPsRxc/QpGlhez1B
Uz2EOPM9XDI2q6HtmRaLen7D4CPPQ5diFt9P+9cQsWLS7nLrrd8xItvwO6IGqpBG
dPvwVuSRuYnSOPseA944Rod5Ypo1ApXkQ1Wb3vsP+BFkSvoc5EoqENONXfm0867E
gQQ8iPltrHl99JwMgmUNcNxbkI9FO2GOhfuZOc9mRmiN+vI/y7sLeLy57RgBlZkW
l8XlCYVinOlkkbNBupFLQ0C2gqwaFzSI2iR0Bao9BVgdCDx2b8cUgpUfXac19tWB
Z/v69x6jT8gRRvB6qucq
=MWP1
-----END PGP SIGNATURE-----

--nSQp8DZZn7gZbDHt--
