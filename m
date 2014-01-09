From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Thu, 9 Jan 2014 09:32:18 -0800
Message-ID: <20140109173218.GA8042@odin.tremily.us>
References: <xmqqd2k3ejfr.fsf@gitster.dls.corp.google.com>
 <CALas-ihPmJSf9eH0P7Vf28pB4zN_dsa_2=fe+_moZgiP0C3UTA@mail.gmail.com>
 <20140107194503.GA26583@odin.tremily.us>
 <20140107223858.GB10782@sandbox-ub>
 <CALas-ihk6cVfosQ+Ov4QKUcfzvbXrYSonQvsN8Ay1+GTq_Ae-w@mail.gmail.com>
 <20140108010504.GE26583@odin.tremily.us>
 <CALas-iheQ4Rfxvty5guEieVwa8SffRnhRdHkNXUKwmuHRXD2Xg@mail.gmail.com>
 <20140109000338.GM29954@odin.tremily.us>
 <CALas-igFQtG1qa2+grMAtZ9mDE-xGuXkDGwGvSXL8_FzPfXBLQ@mail.gmail.com>
 <52CE5E51.4060507@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Cc: Francesco Pretto <ceztko@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Jan 09 18:32:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1JT1-0007GK-Ha
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 18:32:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814AbaAIRcY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jan 2014 12:32:24 -0500
Received: from qmta15.westchester.pa.mail.comcast.net ([76.96.59.228]:43282
	"EHLO qmta15.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751405AbaAIRcW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jan 2014 12:32:22 -0500
Received: from omta01.westchester.pa.mail.comcast.net ([76.96.62.11])
	by qmta15.westchester.pa.mail.comcast.net with comcast
	id Bobl1n0020EZKEL5FtYMqy; Thu, 09 Jan 2014 17:32:21 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta01.westchester.pa.mail.comcast.net with comcast
	id BtYK1n00e152l3L3MtYLGg; Thu, 09 Jan 2014 17:32:21 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 73868EBABCC; Thu,  9 Jan 2014 09:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1389288738; bh=9EK60zABHC03RZWEYcqDoeIJ/s53T3nnS4apChp3X+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bBvOliqaQEiXuixugzvZ0e0afdiUWX53CemD+5/7g3Y4J19q32haNgKmw5U6ufzSy
	 pL5lIC2hBzhcxcsiSaKZElEJARRBTA8/2HuRxRlBoSvn4zdkIiH45hIx10YMqjUAH+
	 baJE60O7D3VHc1DPfHIHkecJ7eEpiKbAPev0esuM=
Content-Disposition: inline
In-Reply-To: <52CE5E51.4060507@web.de>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389288741;
	bh=hd8slYgJaltuDOrGeYETgEzlsHcZFlrReCJWEjb4Otg=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=hKQbd151DxfrSbhW/4XrycmhNanL5kxK8OQOf7bgd3IG661vZ28i6M4avzJvRLK7j
	 dUEzldUp926KWJLQF5jc5XcfyEu+8aK22LtHjCR3v6P983RY5TGZCS1AZ/+hQ31tcZ
	 QWcVkoqZ4nWINd5ZB+BOeE0QqHn82QVab5MiTFUsUiWUxz8vktpTOwBA+inWYj7/tr
	 X4SoJjsCrK8KnFRnLiPdwChzmOeDPt10uBGex6cXookJB2yjBLp/RmCIRbNdLfr2v3
	 2d+MmXFSGb17wByfJPuyVF82Z2McvIzPlQcfnpLPNawbx2AReibpy1gXsgdrMU7nBH
	 vqSlKk01CpqkQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240260>


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 09, 2014 at 09:31:13AM +0100, Jens Lehmann wrote:
> Am 09.01.2014 02:09, schrieb Francesco Pretto:
> > 2014/1/9 W. Trevor King <wking@tremily.us>:
> >>
> >> However, submodule.<name>.local-branch has nothing to do with remote
> >> repositories or tracking branches.
> >=20
> > My bad: this means the feature is still not entirely clear to me.
> >=20
> >>
> >>   [branch "my-feature"]
> >>         remote =3D origin
> >>         merge =3D refs/heads/my-feature
> >>         [submodule "submod"]
> >>             local-branch =3D "my-feature"
> >>
> >> and I don't think Git's config supports such nesting.
> >>
> >=20
> > Aesthetically, It doesn't look very nice.
>=20
> And I'm not sure we even need that. What's wrong with having the
> branch setting in the .gitmodules file of the my-feature branch?
> The only problem I can imagine is accidentally merging that into
> a branch where that isn't set, but that could be solved by a merge
> helper for the .gitmodules file.

=2Egitmodules is fine so long as the config can live in the versioned
tree.  Many (all?) .gitmodules settings can be overridden in
=2Egit/config.  However, the local-branch setting needs to be both
per-submodule and per-superproject-branch, so .git/config doesn't work
very well.  I think it's better to use something like my
=2Egit/modules/<submodule-name>/config implementation [1] to set this
override.

This lack of per-superproject-branch overrides applies to all of the
submodule.<name>.* settings, but you're unlikely to want an
out-of-tree override for 'path' or a per-superproject-branch override
for 'url', 'ignore', 'update', or 'chRecurseSubmodules'.  Maybe folks
would want per-superproject-branch overrides to 'branch', although I'd
prefer we reuse branch.<name>.merge in the submodule's config for
that [2].

On the other hand, maybe an in-tree .gitmodules is good enough, and
folks who want a local override can just edit .gitmodules in their
local branch?  I've never felt the need to override .gitmodules myself
(for any setting), so feedback from someone who has would be useful.

> >> I can resuscitate that if folks want, but Heiko felt that my initial
> >> consolidation didn't go far enough [2].  If it turns out that we're ok
> >> with the current level of consolidation, would you be ok with
> >> "non-checkout submodule.<name>.update" as the trigger [3]?
> >=20
> > For me it was ok with what you did:
> > -------------------------------------------------
> > if "just_cloned" and "config_branch"
> > then
> >      !git reset --hard -q"
> > fi
> > -------------------------------------------------
> >=20
> > So yes: at the first clone 'checkout' keeps attached HEAD, while
> > 'merge' and 'rebase' attach to the branch.
>=20
> It have the impression that attaching the head to the given branch
> for merge and rebase might be the sensible thing to do, but it
> would be great to hear from users of merge and rebase if that
> would break anything for them in their current use cases for these
> settings.

Which local branch would you attach to before merging?  I think 'git
submodule update' should always use the current submodule state
(attached branch or detached HEAD) [3], and we should have a separate
call that explicitly checked out the desired submodule branch [4].

> > If it's not the first clone, you should take no action (and your
> > original patch was ok about this).
>=20
> I'm not sure this is the right thing to do, after all you
> configured git to follow that branch so I'd expect it to be
> updated later too, no? Otherwise you might end up with an old
> version of your branch while upstream is a zillion commits
> ahead.

Non-clone updates should not change the submodule's *local* branch
*name*.  They should change the commit that that branch references,
otherwise 'git submodule update' would be a no-op ;).

> First I'd like to see a real consensus about what exactly should
> happen when a branch is configured to be checked out (and if I
> missed such a summary in this thread, please point me to it ;-).

I don't think we have a consensus yet.  A stand-alone outline of my
current position is in my v3 RFC [5], but I don't have any buy-in yet
;).

> And we should contrast that to the exact checkout and floating
> branch use cases.

With my v3 series, there are no more detached HEADs.  Folks using
checkout updates get a local master branch.  I do not change any of
the exact checkout (superproject gitlinked sha1) vs. floating
(subproject's remote submodule.<name>.branch via 'update --remote')
logic, because that already works well.  The problem is the local
branch handling, not the update/integration logic.

> So what should happen on initial clone,

For 'add', clone the command line URL and create a new branch 'master'
pointing at the commit referenced by the remote's HEAD (or other
branch with --branch).

For 'update', do the same, except use a local-branch setting to
determine the name for the local branch, falling back to 'master' if
it is not set.

> later updates,

The same thing that currently happens, with the exception that
checkout-style updates should use reset to update the
currently-checked out branch (or detached-HEAD), instead of always
detaching the HEAD.

> updates where the local and the remote branch diverged,

The same thing that currently happens.  For local (non --remote)
updates, the integrated branch is the superproject's gitlinked sha1.
For --remote updates, the integrated branch is the remote subproject's
submodule.<name>.branch.  We integrate that with the
currently-checked-out local branch (or detached HEAD) using the user's
preferred submodule.<name>.update strategy.

> when superproject branches are merged (with and without conflicts),

I don't think this currently does anything to the submodule itself,
and that makes sense to me (use 'submodule update' or my 'submodule
checkout' if you want such effects).  We should keep the current logic
for updating the gitlinked $sha.  In the case that the
=2Egitmodule-configured local-branches disagree, we should give the
usual conflict warning (and <<<=3D=3D=3D>>> markup) and let the user resolve
the conflict in the usual way.

> on a rebase in the superproject and so on.

Same as the merge case.  Why would configuring a preferred
local-branch that only affects checkout (and the initial clone) have
anything to do with rebases and merges?

> After that we can discuss about how to implement them (even though I
> believe we won't need a new submodule command at the end of this
> process, simply because if it isn't configurable we cannot teach git
> checkout and friends to do that automatically for us later).

I think it is configurable, and I have an implementation that works
(modulo bugs) [5].  I think we should teach 'git checkout
--recurse-submodules' this logic, and then we can drop my 'git
submodule checkout' entirely.

> And from reading this discussion I believe we need another value for
> the ignore option which only ignores changes to the SHA-1 but not to
> work tree modifications of a submodule work tree relative to its HEAD
> (or make that two: another one which ignores untracked files too and
> only shows modification of tracked files). Otherwise users of the
> floating or attached model can easily miss submodule modifications.

I am ignore-agnostic ;).  Do whatever you like here.

Cheers,
Trevor

[1]: http://article.gmane.org/gmane.comp.version-control.git/240251
[2]: http://article.gmane.org/gmane.comp.version-control.git/240164
[3]: http://article.gmane.org/gmane.comp.version-control.git/240250
[4]: http://article.gmane.org/gmane.comp.version-control.git/240249
[5]: http://article.gmane.org/gmane.comp.version-control.git/240248

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzt0eAAoJEKKfehoaNkbtmMEQALGvrdSMiurhxRS+nDMq1bfj
yvKMcaG6CvykU8s8LbAnMFAz8RkiF8EdwjyFahpeUfihcxE8oODBfpm9SCYseEx7
1xrMIuEkyRYdQYKyxDQrLNGAUdDpnWPIeF51MzICev6znxdj5jYACe6bphDf36lI
3VxfZyaWZX+li4m7Xyf2BwMjgaOikxY14rtpCWhuLajVI+rlMdIDG8hgJMiEmqqf
ho2c7ILvHsOHGOGTmoVrxe0WsPOUA9CF1nXhzvmvW12h/u6tHsSt5m/k4h2tWb9g
hypR4aWtjg3B3NYCG1ogJXG3e8okTQBF/UboPxr1XtvU2legNi0oY92kQkbk6pHG
ZmnWpiAiXocI910e5wLImWGQSc/cP0Ra8zBAmJzIPJmiENAmKOf+BYUb7kK92Hty
eI5jOzKU0sDRWgpFfdTVoU6b3iBCQp+7c4FfgjWKRJIXkFxYUXqJPj1psqh8Y8EB
cc4Y9+OyYxydrxTtK2RHrIn+KLpVsfk4JHYC2Kl39a8OjPoP5IBYrJ75NECY/1gF
czwe9Vvgw122gcd1Tx+Bs/c71zAnYm2GPT1lhWHN2m+B2aWw98dq1aP3P23TR1mw
bvKKh4jxtilUrkdSqiP5ZBJx/08vOEgOxdTXNDsSAXIo2oVxBgZhcKmfefn9Ib1j
E5xf3JovdGzI36RYfH3O
=4NXx
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
