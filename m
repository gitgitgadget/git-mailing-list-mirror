From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Thu, 9 Jan 2014 11:55:22 -0800
Message-ID: <20140109195522.GT29954@odin.tremily.us>
References: <20140107194503.GA26583@odin.tremily.us>
 <20140107223858.GB10782@sandbox-ub>
 <CALas-ihk6cVfosQ+Ov4QKUcfzvbXrYSonQvsN8Ay1+GTq_Ae-w@mail.gmail.com>
 <20140108010504.GE26583@odin.tremily.us>
 <CALas-iheQ4Rfxvty5guEieVwa8SffRnhRdHkNXUKwmuHRXD2Xg@mail.gmail.com>
 <20140109000338.GM29954@odin.tremily.us>
 <CALas-igFQtG1qa2+grMAtZ9mDE-xGuXkDGwGvSXL8_FzPfXBLQ@mail.gmail.com>
 <52CE5E51.4060507@web.de>
 <20140109173218.GA8042@odin.tremily.us>
 <52CEF71B.5010201@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xSu31lw3TgkWXnjh"
Cc: Francesco Pretto <ceztko@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Jan 09 20:55:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1LhU-0003Vt-Gk
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 20:55:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757254AbaAITz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jan 2014 14:55:28 -0500
Received: from qmta12.westchester.pa.mail.comcast.net ([76.96.59.227]:57371
	"EHLO qmta12.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756267AbaAITz0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jan 2014 14:55:26 -0500
Received: from omta01.westchester.pa.mail.comcast.net ([76.96.62.11])
	by qmta12.westchester.pa.mail.comcast.net with comcast
	id BveK1n0020EZKEL5CvvRRh; Thu, 09 Jan 2014 19:55:25 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta01.westchester.pa.mail.comcast.net with comcast
	id BvvQ1n00C152l3L3MvvQP8; Thu, 09 Jan 2014 19:55:25 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 32BC6EBBC2A; Thu,  9 Jan 2014 11:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1389297323; bh=VZlcHqmC5E22KdDtIgxTEIRtHUUhV4JH3mlxQb5tTJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Lxu3Mfr/Tz9B5FPvfttotXKLI9K3lO7cMeCVHhi4W32w3VZnOy6ruK/m1KcDswaUd
	 tsXDDzNY71W6f1W5tu9eEdJpnZ5CcqyFCYZgEh0ZrE3sYBgsT0qi3ONXUmuh03mwb9
	 nSxgnEKtkrynYYN1q/ZK08s6v3pG3/V3BXS0LtWA=
Content-Disposition: inline
In-Reply-To: <52CEF71B.5010201@web.de>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389297325;
	bh=+9Do6ilkDZJ28bXqy/lM2WOmO2OpiJliJyRYQzVXwyo=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=i4rwUl0cbZ3T8VvN2RUX9J6tNqkZsR54slhVnBj8ouIvs5WeVOAovvwhSoMdiEi2/
	 2N/wmkkfD6/q2ZUP+FK7N4i/t+52YJ4LFsQQyWLmd4WlWw/TGGmdxWtLrO0GHQyoLL
	 wYDMkI3f6NcuNdNxNF63zHWDIL7LyOv4etdUau5SsTMcvRt94Xpa3pDNirHfXpsl7Z
	 JPvAgKpwfqw1UqdIe8t9UJwJdamd1hNqyCWBYg15YsakHdsvsnNEr6MRP1KKBlWzP9
	 egG2pmGcsDlzclX+pL/XKuKAFBLpQ86ubdsqUL5DTx+etdsYPzVqAC5XRvh/84+cCl
	 7XhGelsw9ehPw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240269>


--xSu31lw3TgkWXnjh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 09, 2014 at 08:23:07PM +0100, Jens Lehmann wrote:
> Am 09.01.2014 18:32, schrieb W. Trevor King:
> >  However, the local-branch setting needs to be both
> > per-submodule and per-superproject-branch, so .git/config doesn't work
> > very well.  I think it's better to use something like my
> > .git/modules/<submodule-name>/config implementation [1] to set this
> > override.
>=20
> Yes, the local branch should be set in the submodule's .git/config
> to make operations done inside the submodule work seamlessly.

Once you're inside the submodule my local-branch setting shouldn't
matter, because it just connects superproject branches with submodule
branches.  The submodule's config is just a convenient out-of-tree
place to store per-submodule overrides.

> > This lack of per-superproject-branch overrides applies to all of the
> > submodule.<name>.* settings, but you're unlikely to want an
> > out-of-tree override for 'path' or a per-superproject-branch override
> > for 'url', 'ignore', 'update', or 'chRecurseSubmodules'.
>=20
> Unlikely it is not ;-) We do have people who set update=3Dnone in
> the .git/config of the superproject for submodules they don't have
> access to (and which is not necessary for their work).

That is not a per-superproject-branch override.  local-branch is the
only per-submodule config I can think of where I can imagine a sane
person actually wanting an out-of-tree per-superproject-branch
override.

> And it isn't a "per-superproject-branch override" but a
> "per-superproject-branch default" which can be overridden in
> .git/config (except for 'update', but I intend to fix that).

You're talking about .gitmodules vs. .git/config here, but for
local-branch, I'm talking about a fallback chain like [1]:

1. superproject.<superproject-branch>.local-branch in the submodule's
   config (superproject/.git/modules/=E2=89=A4submodule-name>/config).
2. submodule.<submodule-name>.local-branch in the superproject's
   config (.git/config).
3. submodule.<submodule-name>.local-branch in the superproject's
   .gitmodules file.
4. default to 'master'

Only #1 is a new idea.

> > On the other hand, maybe an in-tree .gitmodules is good enough,
> > and folks who want a local override can just edit .gitmodules in
> > their local branch?  I've never felt the need to override
> > .gitmodules myself (for any setting), so feedback from someone who
> > has would be useful.
>=20
> That way these changes would propagate to others working on the same
> branch when pushing, which I believe is a feature.

Sure.  Unless they don't want to propagate them, at which point they
use an out-of-tree override masking the .gitmodules value.  The
question is, would folks want local overrides for local-branch (like
they do for submodule.<name>.update), or not?  Since it's easy to do
[1], I don't see the point of *not* supporting per-superproject-branch
overrides.

> >> It have the impression that attaching the head to the given
> >> branch for merge and rebase might be the sensible thing to do,
> >> but it would be great to hear from users of merge and rebase if
> >> that would break anything for them in their current use cases for
> >> these settings.
> >=20
> > Which local branch would you attach to before merging?  I think
> > 'git submodule update' should always use the current submodule
> > state (attached branch or detached HEAD) [3], and we should have a
> > separate call that explicitly checked out the desired submodule
> > branch [4].
>=20
> Like we currently do with "git submodule update --remote" (where you
> have to have an explicit command telling git when to advance the
> branch)? Having a separate call that does something *after* a git
> command is exactly the problem I'm trying to fix with recursive
> update, so I'm not terribly excited ;-)

I'm all for rolling my 'git submodule checkout' into 'git checkout
--recurse-submodules' [2].  It was just faster to mock up in shell
while we decide how it should work.

> >>> If it's not the first clone, you should take no action (and your
> >>> original patch was ok about this).
> >>
> >> I'm not sure this is the right thing to do, after all you
> >> configured git to follow that branch so I'd expect it to be
> >> updated later too, no? Otherwise you might end up with an old
> >> version of your branch while upstream is a zillion commits
> >> ahead.
> >=20
> > Non-clone updates should not change the submodule's *local* branch
> > *name*.  They should change the commit that that branch references,
> > otherwise 'git submodule update' would be a no-op ;).
>=20
> Okay, I seem to have misunderstood that. But what happens when the
> branch setting in .gitmodules changes, shouldn't that be updated?

Not by 'git submodule update'.  If there are no out-of-tree overrides
and the user calls 'git submodule checkout' with a new local-branch in
=2Egitmodules, *that* should checkout a new submodule branch.

> >> First I'd like to see a real consensus about what exactly should
> >> happen when a branch is configured to be checked out (and if I
> >> missed such a summary in this thread, please point me to it ;-).
> >=20
> > I don't think we have a consensus yet.  A stand-alone outline of my
> > current position is in my v3 RFC [5], but I don't have any buy-in yet
> > ;).
>=20
> I'll volunteer to prepare a table explaining the different modes
> in my github wiki. Will scan this thread and your pointers for input
> and will come back soon when I have something ready.

Thanks :).

> >> And we should contrast that to the exact checkout and floating
> >> branch use cases.
> >=20
> > With my v3 series, there are no more detached HEADs.  Folks using
> > checkout updates get a local master branch.  I do not change any of
> > the exact checkout (superproject gitlinked sha1) vs. floating
> > (subproject's remote submodule.<name>.branch via 'update --remote')
> > logic, because that already works well.  The problem is the local
> > branch handling, not the update/integration logic.
>=20
> Ok. Maybe we could use the "<remote>:<local>" notation to store both
> remote and local branch in a single setting?

Meh :p.  I'm fine with (remote-)branch and local-branch as separate
settings, or a single combined '<remote>:<local>' setting.  However, I
think the local branch name is going to be more closely associated
with the superproject branch than with the subproject's remote branch,
and expect folks to want to override the local-branch on a
per-superproject-branch basis much more often then they'll override
the latter.

> >> later updates,
> >=20
> > The same thing that currently happens, with the exception that
> > checkout-style updates should use reset to update the
> > currently-checked out branch (or detached-HEAD), instead of always
> > detaching the HEAD.
>=20
> Won't the user loose any modifications to his local branch here?

They just called for a checkout-style update, so yes.  If they want to
keep local modifications, chose an integration mode that preserves
local changes.

> >> updates where the local and the remote branch diverged,
> >=20
> > The same thing that currently happens.  For local (non --remote)
> > updates, the integrated branch is the superproject's gitlinked sha1.
> > For --remote updates, the integrated branch is the remote subproject's
> > submodule.<name>.branch.  We integrate that with the
> > currently-checked-out local branch (or detached HEAD) using the user's
> > preferred submodule.<name>.update strategy.
>=20
> And for checkout I can easily overwrite the upstream branch with
> my local changes?

?  I don't understand.  How would you overwrite something in the
upstream repository?  Maybe you meant "for checkout I can easily
overwrite the local changes with the upstream branch", which is what I
understand checkout to do.

> >> when superproject branches are merged (with and without conflicts),
> >=20
> > I don't think this currently does anything to the submodule itself,
> > and that makes sense to me (use 'submodule update' or my 'submodule
> > checkout' if you want such effects).  We should keep the current logic
> > for updating the gitlinked $sha.  In the case that the
> > .gitmodule-configured local-branches disagree, we should give the
> > usual conflict warning (and <<<=3D=3D=3D>>> markup) and let the user re=
solve
> > the conflict in the usual way.
>=20
> For me it makes lots of sense that in recursive checkout mode the
> merged submodules are already checked out (if possible) right after
> a superproject merge, making another "submodule update" unnecessary
> (the whole point of recursive update is to make "submodule update"
> obsolete, except for "--remote").

If you force the user to have the configured local-branch checked out
before a non-checkout operations with checkout side-effects (as we
currently do for other kinds of dirty trees), I think you'll avoid
most (all?) of the branch-clobbering problems.

Cheers,
Trevor

[1]: http://article.gmane.org/gmane.comp.version-control.git/240251
[2]: http://article.gmane.org/gmane.comp.version-control.git/240249

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--xSu31lw3TgkWXnjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzv6pAAoJEKKfehoaNkbtbPgP/A1XAeZFj6HGPvsxePGRH9Vv
fyaIXQW/AJ7NaSgCZdqCIqtvtXGOi9ptymb/aShB+y8KwYO/vgSIKBjVPGH4Y7Rm
/ACCmVs6z/FTHj3RMbVT1Rd/tTV43FDaNtS8N81SI1WKCV+waj0aYoTE27Yq5avB
Wu6/B5arz2ZXYqxYMXIy+GTWtNksI8eUN+IEJs6GeHlJvqDIVT5KURuMOR4VjPw7
9xvrDouBPzkUM2fxlVI42NLXPNevhjFQ7WdOlnQLXDCIMqvOPCtDDWhPN6UF/l6R
0glQQ8AFnutsU/StHhzkmDnNwYu4CgDO/0b5xRIQUsXYrp0R/+tWljOf2Bs6MqCp
L7oQFbwMYBoAo4bDXOtAGU46avMjcW1etGG+AYVS4GbMYi3TooXVo3TTOEKMYHAE
s+SmvFXKSYAfC+E/XDIPJLPBS2mmywwzPpg7o2wnTnqEYxiCEgaqhKuFQ26UqH7P
s4YATQnuQhdm3Gs3mHJINRwIWAsykEkSqmBP/xOw+hnOQOCE+NEk060pXwEzYmdo
TfRsfGmhdzY3BYXGDJEEGPP1D/Nru87KQron0XwVlcqCnEKuyVeKOHMEWxgB9R70
3PZoTIeiQ+w+SDubyJ92z56/e4avBUdWSIdB0rtjWCYpYrwsAt9Dkif80gSIg8ME
EaVh19JDEkaWQP5zyrTz
=uyvt
-----END PGP SIGNATURE-----

--xSu31lw3TgkWXnjh--
