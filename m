From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Sun, 5 Jan 2014 15:39:43 -0800
Message-ID: <20140105233943.GJ3156@odin.tremily.us>
References: <CALas-ii90x07Kbxzy_siBJV_RHPkvBw7spFBD9vi6o43mU1k6g@mail.gmail.com>
 <d0de817dfc687fd943349c9d3e1d410161a0f01e.1388938473.git.wking@tremily.us>
 <20140105194850.GA2994@book.hvoigt.net>
 <20140105212458.GG3156@odin.tremily.us>
 <20140105225733.GB4660@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9kwpIYUMbI/2cCx"
Cc: Git <git@vger.kernel.org>, Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Jan 06 00:39:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VzxIP-0004WA-St
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 00:39:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbaAEXjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jan 2014 18:39:48 -0500
Received: from qmta04.westchester.pa.mail.comcast.net ([76.96.62.40]:45601
	"EHLO qmta04.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751405AbaAEXjr (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jan 2014 18:39:47 -0500
Received: from omta15.westchester.pa.mail.comcast.net ([76.96.62.87])
	by qmta04.westchester.pa.mail.comcast.net with comcast
	id APYY1n0021swQuc54Pflht; Sun, 05 Jan 2014 23:39:45 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta15.westchester.pa.mail.comcast.net with comcast
	id APfk1n001152l3L3bPfkVN; Sun, 05 Jan 2014 23:39:45 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 72B81E8B755; Sun,  5 Jan 2014 15:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1388965183; bh=ELLplxu4dHYx6nlo4Y4JiMCLmHqlm6DPdUiKuloVKBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L3yOM8qbpFWNVSw1fw7rvQNDjHbqcmRpli0FaSWq5emv1OvhUeL+Jo8Dj0UzT5c4q
	 TO6nEbod8UdQklGi/ZUuSfP7azaFx80w2eoMScHG3fcK06cXQ5aqMBlEhC6+NB4K08
	 Mr6wUHXFg19gPZ570KhphBOUWd9OhXc6Hkg92wNs=
Content-Disposition: inline
In-Reply-To: <20140105225733.GB4660@book.hvoigt.net>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1388965185;
	bh=p504fWONINL/YgxHgQNZLW7a4v1W1zrvvHoIrBqkX1g=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=ixxLpmNWxxrGv+E1RSmQ42LskC6gWpw0L98kN82Ji+fQDUicb/i+fO/fiti3WtSYR
	 2vjk++4wZZZM0HGHxe+3DLg8ajgBEYbEjMg6KXDf0exwAuVRRjck54vDVXjOuLMXp6
	 1R47zhepI6D3wRCV2lX+vYpj3F0S+d6jGfOqc2SEx6KAHIkxZ5OafJAmk/GYkEolnU
	 PFHwuuHVTcnZmZ2Z+GfgmYs4ZF2gRIXkjg+GqvanjSnnLfqeqojr5k8sE+iRZdUJpN
	 ZOR8hfncK1063O9WCXq5jsn4paWH6xmFXlSND2Xhnf3KtaaUa0xY2SDZOquW9jodJo
	 N+Xjg3sjcrZQg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239980>


--M9kwpIYUMbI/2cCx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 05, 2014 at 11:57:33PM +0100, Heiko Voigt wrote:
> On Sun, Jan 05, 2014 at 01:24:58PM -0800, W. Trevor King wrote:
> > If submodule.<name>.branch is set, it *always* creates a new local
> > branch of that name pointing to the exact sha1.  If
> > submodule.<name>.branch is not set, we still create a
> > detached-HEAD checkout of the exact sha1.
>=20
> Thanks for this clarification. Since the usual usage with --remote
> is with a remote-tracking branch, I confused this here. I am not
> sure whether blindly creating a local branch from the recorded sha1
> is the right thing to do. In what situations would that be helpful?

In any situation where your going to develop the submodule locally,
you're going to want a branch to develop in.  Starting local-submodule
developers off on a branch seems useful, even if we can only use
submodule.<name>.branch to guess at their preferred local branch name.
Sometimes (often?) the guess will be right.  However, A detached HEAD
will never be right for local development, so being right sometimes is
still an improvement ;).

> At $dayjob we usually use feature branches for our work. So if
> someone wants to work in a submodule you simply create a branch at
> the current sha1 which you then send out for review.

I'm all for named feature branches for development, and in this case
submodule.<name>.branch is likely to be the wrong choice.  However,
it's still safer to develop in that branch and then rename the branch
to match your feature than it would be to develop your fix with a
detached HEAD.  If your developers have enough discipline to always
checkout their feature branch before starting development, my patch
won't affect them.  However, I know a number of folks who go into
fight-or-flight mode when they have a detached HEAD :p.

> The reason why one would set a branch option here is to share the
> superproject branch with colleagues. He can make sure they can
> always fetch and checkout the submodule even though the branch there
> is still under cleanup and thus will be rebased often. The commit
> referenced by sha1 would not be available to a developer fetching
> after a rebase.

Yeah, floating gitlinks are something else.  I'd be happy to have that
functionality (gitlinks pointing to references) should be built into
gitlinks themselves, not added as an additional layer in the submodule
script.  This "gitlinked sha1 rebased out of existence" scenario is
the first I've heard where I think gitlinked references would be
useful.

> > Thinking through this more, perhaps the logic should be:
> >=20
> > * If submodule.<name>.update (defaulting to checkout) is checkout,
> >   create a detached HEAD.
> > * Otherwise, create a new branch submodule.<name>.branch
> >   (defaulting to master).
>=20
> Why not trigger the attached state with the submodule.<name>.branch
> configuration option? If there is a local branch available use that,
> if not the tracking branch (as it is currently). Then a developer
> can start working on the branch with:
>=20
> 	cd submodule; git checkout -t origin/<branchname>
>=20
> assuming that submodule update learns some more support for this.

Isn't that already what 'git update --remote <submodule>' already
does?

> > > > -				update_module=3D ;;
> > > > +				if test -n "$config_branch"; then
> > > > +					update_module=3D"!git reset --hard -q"
> > >=20
> > > If we get here the checkout has already been done. Shouldn't
> > > this rather specify a noop. I.E. like
> > >=20
> > > 	update_module=3D"!true"
> >=20
> > We are on a local branch at this point, but not neccessarily
> > pointing at the gitlinked sha1.  The reset here ensures that the
> > new local branch does indeed point at the gitlinked sha1.
>=20
> But isn't this a fresh clone? Why should the branch point at
> anything else?

We don't pass $sha1 to module_clone().  Before my patch, we don't even
pass $branch to module_clone().  That means that module_clone() will
only checkout the gitlinked sha1 when the upstream HEAD (or $branch
with my patch) happens to point to the gitlinked sha1.  For example,
if Alice adds Charie's repo as a submodule (gitlinking his current
master d2dbd39), then Charlie pushes a new commit d0de817 to his
master, and then Bob clones Alice's superproject.  Post-clone,
Charlie's submodule will have checked out Charlie's new d0de817, and
we need update's additional:

  git reset --hard -q d2dbd39

to rewind to Alice's gitlinked sha1.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--M9kwpIYUMbI/2cCx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSye09AAoJEKKfehoaNkbtyFEQAKxMNMeLLdGgB6IlAeOo26Gs
JsE21tzT7A6TY/HkdJIJLYYACibGEGsfo5XFpIuMUrR7nHkMBOkusepFH5ROlURQ
OIR+KzRkoO9cCB4sMwNnNQOVtp1iiUmGUp30erqsm3+pv/1KtD4hVl3nY5uJEppv
iV0ZDIryQuFkRtR9Rdg+z/qNZwEtV2vPZQmJgqzy6PZe3L8eGmDVyJY84/BiKfpP
uNizud9NfUtJF6oOmKYrK0etRVCJLb6eQ12vrhyvDQtkaPI6Luy2uz0O+GfvWP5W
V1QL4/e8eRlp2wLJuh72jc12aqJhfaZtTpi9UrUaX91OOtCshCMeaKBb7RIAWLkE
+J+9Bm+emtOgNpXC62j1vmblI6dGmJmHGpO2dwiYhYhbS8mnS5KTzLHDmx88x52M
z1q5okLLIH/X6Gu5Kis8YTs5966Pcat4uv5V7mBCV0RFvourVXNDsEwr3b2n70Kt
TZAQDzvibOv9YO+uKHLx80INCLa7pQ/Kary5OzZZodXrBnGPYM+vSB8UEdipNp4P
xX9XnJyh8HR5LU5Ej3FJjCJyHzKNxgD8xzTIQhhf1fqhqVHBpf6VCErbrwMVpnGD
ANOOOo9vVl4rGAMtsfuoxuYj4nm2mufAqrGpjxMG/rzT57jdICrVDXYjzczXWgA+
rovN0e+yRu1CyjiEIaLT
=cMMw
-----END PGP SIGNATURE-----

--M9kwpIYUMbI/2cCx--
