From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Thu, 9 Jan 2014 14:18:40 -0800
Message-ID: <20140109221840.GW29954@odin.tremily.us>
References: <CALas-ihk6cVfosQ+Ov4QKUcfzvbXrYSonQvsN8Ay1+GTq_Ae-w@mail.gmail.com>
 <20140108010504.GE26583@odin.tremily.us>
 <CALas-iheQ4Rfxvty5guEieVwa8SffRnhRdHkNXUKwmuHRXD2Xg@mail.gmail.com>
 <20140109000338.GM29954@odin.tremily.us>
 <CALas-igFQtG1qa2+grMAtZ9mDE-xGuXkDGwGvSXL8_FzPfXBLQ@mail.gmail.com>
 <52CE5E51.4060507@web.de>
 <20140109173218.GA8042@odin.tremily.us>
 <52CEF71B.5010201@web.de>
 <20140109195522.GT29954@odin.tremily.us>
 <52CF1764.40604@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B0+HW0pjZ+2jqF7e"
Cc: Francesco Pretto <ceztko@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Jan 09 23:18:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1Nw9-0001Nc-LR
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 23:18:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072AbaAIWSq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jan 2014 17:18:46 -0500
Received: from qmta10.westchester.pa.mail.comcast.net ([76.96.62.17]:50415
	"EHLO qmta10.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751501AbaAIWSo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jan 2014 17:18:44 -0500
Received: from omta20.westchester.pa.mail.comcast.net ([76.96.62.71])
	by qmta10.westchester.pa.mail.comcast.net with comcast
	id BtjP1n0051YDfWL5AyJj9S; Thu, 09 Jan 2014 22:18:43 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta20.westchester.pa.mail.comcast.net with comcast
	id ByJh1n00X152l3L3gyJiVv; Thu, 09 Jan 2014 22:18:43 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id E4CEEEBC9BD; Thu,  9 Jan 2014 14:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1389305920; bh=VSj8z73ciQQo0SFLdZuccLzOHo+8SveDejSuzJvw7ps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XBzCdkkj1/+eSn+0oWDiSaiOasd1OSFqYxXkI+F24aT0LTT3nCeHUwOpm6alnHi7b
	 vBNdNECfgjdwj0suU3gygHjr1/tMjmL9XIdt0pLu1cNlsXJ9beaZajgumTKRj55QeA
	 TgpaxTInGVLizqZbni5U/V1QVgCmbDTkv/y/zCok=
Content-Disposition: inline
In-Reply-To: <52CF1764.40604@web.de>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389305923;
	bh=1JpuRZ7d91lG212vP+jEy0ZzwnXX2xZCXCdn3TYckw4=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=lBJD52euQMcqg39NXZ8GZwsBXy566URRaCFXgzOrngYJD6rUv2tqEJNIAdcv06wjq
	 kfDK9dP9u7yrdoqifXRT7MQLXct2IMpPcHXvD87LE1wW42UXvSpeJjetO2gEBaawiU
	 9PVED1hMto64Q5aQLQARIDm5nEJ4Q0Dxwiwr926ligr8Dbz9DfDiK9wShwW/EjopLS
	 0L7EU3p+w70Bg9c61bMfvbqjP36lwqpIjdliDF/qK1rUFqiJc3ptTPLY5m3Gh7tlD6
	 S7rJce2I8u1eyb+PLLNt4pViiLpi2oQkypVxqlpccyTEdb58kcQHjQOcYFSdVc8/+Y
	 i+ZguTVL2ZhGw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240279>


--B0+HW0pjZ+2jqF7e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 09, 2014 at 10:40:52PM +0100, Jens Lehmann wrote:
> Am 09.01.2014 20:55, schrieb W. Trevor King:
> > On Thu, Jan 09, 2014 at 08:23:07PM +0100, Jens Lehmann wrote:
> >> Am 09.01.2014 18:32, schrieb W. Trevor King:
> >>>  However, the local-branch setting needs to be both
> >>> per-submodule and per-superproject-branch, so .git/config doesn't work
> >>> very well.  I think it's better to use something like my
> >>> .git/modules/<submodule-name>/config implementation [1] to set this
> >>> override.
> >>
> >> Yes, the local branch should be set in the submodule's .git/config
> >> to make operations done inside the submodule work seamlessly.
> >=20
> > Once you're inside the submodule my local-branch setting shouldn't
> > matter, because it just connects superproject branches with submodule
> > branches. The submodule's config is just a convenient out-of-tree
> > place to store per-submodule overrides.
>=20
> Now I get it, you want to be able to override a submodule branch for
> every superproject branch. I'm not sure I'd add that in the first
> iteration though, as it seems to add quite some complexity and I'm
> not convinced yet users really need it (but I won't object when we
> find real world use cases for that).

Not much complexity in the code, it's all in the first patch of my v3
series [1].  Adding a new override location doesn't seem that
complicated to me, but I haven't been very successful at getting this
idea across, so maybe it's weirder than I think ;).  Clearer
explanations welcome ;).

> >> And it isn't a "per-superproject-branch override" but a
> >> "per-superproject-branch default" which can be overridden in
> >> .git/config (except for 'update', but I intend to fix that).
> >=20
> > You're talking about .gitmodules vs. .git/config here, but for
> > local-branch, I'm talking about a fallback chain like [1]:
> >=20
> > 1. superproject.<superproject-branch>.local-branch in the submodule's
> >    config (superproject/.git/modules/=E2=89=A4submodule-name>/config).
> > 2. submodule.<submodule-name>.local-branch in the superproject's
> >    config (.git/config).
> > 3. submodule.<submodule-name>.local-branch in the superproject's
> >    .gitmodules file.
> > 4. default to 'master'
> >=20
> > Only #1 is a new idea.
>=20
> Thanks for the explanation, now I understand what you're aiming at.

For additional clarity, my whole v3 series is not super long [2]=E2=80=A6 ;)

> >>> On the other hand, maybe an in-tree .gitmodules is good enough,
> >>> and folks who want a local override can just edit .gitmodules in
> >>> their local branch?  I've never felt the need to override
> >>> .gitmodules myself (for any setting), so feedback from someone
> >>> who has would be useful.
> >>
> >> That way these changes would propagate to others working on the
> >> same branch when pushing, which I believe is a feature.
> >=20
> > Sure.  Unless they don't want to propagate them, at which point
> > they use an out-of-tree override masking the .gitmodules value.
> > The question is, would folks want local overrides for local-branch
> > (like they do for submodule.<name>.update), or not?  Since it's
> > easy to do [1], I don't see the point of *not* supporting
> > per-superproject-branch overrides.
>=20
> Unless actual use cases are shown I'd vote for YAGNI here. A new
> config option means considerable maintenance burden, no matter how
> easy it is to implement in the first place.

Automatically checking out the preferred submodule branch for a given
superproject branch already requires a new config option.  The
per-superproject-branch out-of-tree override just renames it (from
submodule.<submodule-name>.local-branch to
superproject.<superproject-branch>.local-branch).  So different names
depending on superproject-level or submodule-level config, but still
the same option.  That doesn't sound like it's adding that much of a
maintenance burden.

On the other hand, I, personally, have no need for out-of-tree
overrides for *any* submodule-related config, so I'm fine if we drop
the submodule-level lookup location ;).

> > I'm all for rolling my 'git submodule checkout' into 'git checkout
> > --recurse-submodules' [2].  It was just faster to mock up in shell
> > while we decide how it should work.
>=20
> Sure. As I said that's perfectly fine for testing this approach,
> but we should do that right in "git checkout" and friends and not
> add yet another submodule command.

The current C code looked fairly focused on detached HEAD sha1
checkouts, which was so far away from what I think should happen that
I didn't know where to start ;).  If we like the logic layed out in my
v3 series, I'll take another look at the C series and see if I can
come up with something.

> >>>>> If it's not the first clone, you should take no action (and your
> >>>>> original patch was ok about this).
> >>>>
> >>>> I'm not sure this is the right thing to do, after all you
> >>>> configured git to follow that branch so I'd expect it to be
> >>>> updated later too, no? Otherwise you might end up with an old
> >>>> version of your branch while upstream is a zillion commits
> >>>> ahead.
> >>>
> >>> Non-clone updates should not change the submodule's *local* branch
> >>> *name*.  They should change the commit that that branch references,
> >>> otherwise 'git submodule update' would be a no-op ;).
> >>
> >> Okay, I seem to have misunderstood that. But what happens when the
> >> branch setting in .gitmodules changes, shouldn't that be updated?
> >=20
> > Not by 'git submodule update'.  If there are no out-of-tree overrides
> > and the user calls 'git submodule checkout' with a new local-branch in
> > .gitmodules, *that* should checkout a new submodule branch.
>=20
> Hmm, but isn't "submodule sync" the command that copies changed
> upstream config values (currently only the url) into the local config?
> Then a subsequent "submodule update" could do the actual checkout.

'submodule update' currently only checks out detached HEADs with the
'checkout' update mode.  I got rid of that in my v3 series, so now all
'submodule update' does is integrate some branch (the gitlinked sha1
or the upstream --remote).  It has nothing to do with changing the
locally-checked-out branch.

> >>>> later updates,
> >>>
> >>> The same thing that currently happens, with the exception that
> >>> checkout-style updates should use reset to update the
> >>> currently-checked out branch (or detached-HEAD), instead of
> >>> always detaching the HEAD.
> >>
> >> Won't the user loose any modifications to his local branch here?
> >=20
> > They just called for a checkout-style update, so yes.  If they
> > want to keep local modifications, chose an integration mode that
> > preserves local changes.
>=20
> Hmm, as current "submodule updates" already makes it too easy to
> loose commits, this does not look right to me. I'd prefer to stop at
> that point and tell the user what he can do to solve the conflict.

Users who are worried about loosing local updates should not be using
a checkout-style updates.  If they are using a checkout-style update,
and they ask for an update, they're specifically requesting that we
blow away their local work and checkout/reset to the new sha1.
Solving update conflicts is the whole point of the non-checkout update
modes.

> > Maybe you meant "for checkout I can easily overwrite the local
> > changes with the upstream branch", which is what I understand
> > checkout to do.
>=20
> But which I find really unfriendly and would not like to see in a
> new feature. We should protect the user from loosing any local
> changes, not simply throw them away. Recursive update makes sure it
> won't overwrite any local modification before it checks out anything
> and will abort before doing so (unless forced of course).

If you want to get rid of checkout-mode updates, I'm fine with that.
However, I don't think it supports use-cases like Heiko's (implied) =E2=80=
=9CI
don't care what's happening upstream, I never touch that submodule,
just checkout what the superproject maintainer says should be checked
out for this branch.  Even if they have been rebasing or whatever=E2=80=9D
[3].

> >>>> when superproject branches are merged (with and without conflicts),
> >>>
> >>> I don't think this currently does anything to the submodule itself,
> >>> and that makes sense to me (use 'submodule update' or my 'submodule
> >>> checkout' if you want such effects).  We should keep the current logic
> >>> for updating the gitlinked $sha.  In the case that the
> >>> .gitmodule-configured local-branches disagree, we should give the
> >>> usual conflict warning (and <<<=3D=3D=3D>>> markup) and let the user =
resolve
> >>> the conflict in the usual way.
> >>
> >> For me it makes lots of sense that in recursive checkout mode the
> >> merged submodules are already checked out (if possible) right after
> >> a superproject merge, making another "submodule update" unnecessary
> >> (the whole point of recursive update is to make "submodule update"
> >> obsolete, except for "--remote").
> >=20
> > If you force the user to have the configured local-branch checked out
> > before a non-checkout operations with checkout side-effects (as we
> > currently do for other kinds of dirty trees), I think you'll avoid
> > most (all?) of the branch-clobbering problems.
>=20
> I'm thinking that a local branch works in two directions: It should
> make it easy to follow an upstream branch and also make changes to it
> (and publish those) if necessary.

Those both sound like =E2=80=9Cintegration with the remote submodule=E2=80=
=9D issues
to me.  I'm more worried about what happens purely locally as the
developer checks out different superproject branches and wants the
submodules to follow along automatically (without detaching HEADs).
Once we have something that works there, I expect it will be easier to
add recursive superproject branch integration cleanly.  For example,
all of the usual branch-level config options (branch.<name>.*) come
along for free.

> But neither local nor upstream changes take precedence, so the user
> should either use "merge" or "rebase" as update strategy

That sounds good to me.

> or be asked to resolve the conflict manually when "checkout" is
> configured and the branches diverged.

I still think that checkout-mode updates should be destructive.  See
my paraphrased-version of Heiko's use case above.  How are they going
to resolve this manually?  Merge or rebase?  Why weren't they using
that update mode in the first place?

Cheers,
Trevor

[1]: http://article.gmane.org/gmane.comp.version-control.git/240251
[2]: http://article.gmane.org/gmane.comp.version-control.git/240248
[3]: http://article.gmane.org/gmane.comp.version-control.git/240013

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--B0+HW0pjZ+2jqF7e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzyA+AAoJEKKfehoaNkbtKMsP/jTyOky1yX/myvhck+yxhslB
XLb6OQcHkgjH/ZhzeEGuIVcezo/8kq8mJ3jOLLITLOKGwAEZK5YoDu3oBw1utY9T
F13xXykOK3k7Sa3Bs91xiqNzcxZLUxMWe489kiCyl06A9fT/jYS0Q4FQE+LwKhSQ
/zNwlQxSQo/RaydvpvVOamhQoFc8rjFCBK1eoQBUhcNBz0GR+wLldJGLB0V5iJAW
6TyYt/7Bm75uQmMjBj1mJLrm8ZtDCEip4qOptjUBtxDKWi1FXdKgxLlOveervBy9
7QmkGOeWJJ6h8pJumBGU9gAKD2CQN8zYKMjpCiBib3w7efDKuVg46eTgX+D2Yn3Z
xdB8H7jFSE2yqZoOTJR3amK8Ile4yq0WuIACD78oiviqbCIG6k90+05wx3TL9ReJ
ek2cvdtLEQpz+V69KZHBO/B6Yqa8o4eS1rqIXqNQU2XuiJGgj1Iy654+xsSXEOnW
o8j7oP0QLJgln7HqMtDItuo7HL49ubQCfB74N2Tof5ZGPF9xOg/C2BhtUoFypjn9
YdA5DZgnk2qU4NIZUhp9aAcaeGgEjKzx5BzuvhLVyR9uD7EQMFcCxpi0eAJ20w5b
U/xrAbOpuw66ThwQgKAf41ZftPE6x8pFVaEvaF4pchUcT0fykX8hiPC8r8PMRgxr
gZYR7VUjbeb8Tb0lRapB
=6HWJ
-----END PGP SIGNATURE-----

--B0+HW0pjZ+2jqF7e--
