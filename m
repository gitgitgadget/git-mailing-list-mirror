From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Tight submodule bindings
Date: Mon, 13 Jan 2014 12:07:24 -0800
Message-ID: <20140113200724.GP10613@odin.tremily.us>
References: <20140112010847.GJ29954@odin.tremily.us>
 <52D44081.7070504@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OwXh6gFRjCd3qPCM"
Cc: Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>, Git <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Jan 13 21:07:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2nnX-0002oi-JX
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jan 2014 21:07:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbaAMUH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jan 2014 15:07:29 -0500
Received: from qmta13.westchester.pa.mail.comcast.net ([76.96.59.243]:44847
	"EHLO qmta13.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751289AbaAMUH1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Jan 2014 15:07:27 -0500
Received: from omta22.westchester.pa.mail.comcast.net ([76.96.62.73])
	by qmta13.westchester.pa.mail.comcast.net with comcast
	id DQTq1n0021ap0As5DY7SF4; Mon, 13 Jan 2014 20:07:26 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta22.westchester.pa.mail.comcast.net with comcast
	id DY7R1n00C152l3L3iY7RX9; Mon, 13 Jan 2014 20:07:26 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 74EB3ED053C; Mon, 13 Jan 2014 12:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1389643644; bh=79HXdAPe0CsGfgVi7tcmRYN+cmJEGnTZIu/dq6PEmbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gNq3wbx8+Ik2F4VjFbRnZ5BYBMA+6q3Fg7AVEuoOOMeWVi9r8wIE77lGL2ihXfQUF
	 Y4Irj3m04y0RBe7v37VBH5Xhl6OI3m351F94MSEAJOW9sgpsXmwfcFKpT6aduTroCN
	 4JK+E3DoIelZcZWa0Ku08d0JBQTcpTYxMk7odZo8=
Content-Disposition: inline
In-Reply-To: <52D44081.7070504@web.de>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389643646;
	bh=uQrtW9GG+ko1kQCgyshXC3/zHQg2FQIAdEC7DNA12Dg=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=jBApnzsKKJfZAtbkOoIizbqhMljomTAhzB00g0UNaKUl+yxzY1cqJ50OhEDQZMGbe
	 iO3jDqnUoJhXV+VmNNZDZ+lt9qf4e7jN8YL02W+kLm4iyrfsg4ITHFenhe9Z9itPd5
	 B5Aij1CqoBEV8mOmJ9kvk1w0zKSzQszwWtlVMd33hbkEgswqzb517F7zDHnwe3BNDF
	 LYVQ9dofMk3O+HHUvHJh3A7KqIwPq3t9ZwC/yj98nR44EkggsE3EKKFMXdspD4Qt0d
	 /dFWLA5Riupcg+E7y4noJtHaQ86fn+Eo6ylL6MIlfp7ALQtBgJGxn9i7qKFcwVVMeE
	 ehmhJOvJMcqNA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240370>


--OwXh6gFRjCd3qPCM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2014 at 08:37:37PM +0100, Jens Lehmann wrote:
> Am 12.01.2014 02:08, schrieb W. Trevor King:
> > For folks who treat the submodule as a black box (and do no local
> > development), switchable trees are all they care about.  They can
> > easily checkout (or not, with deinit), the submodule tree at a
> > gitlinked hash, and everything is nice and reproducible.  The fact
> > that 'submod' is stored as a commit object and not a tree, is just
> > a convenient marker for optional
> > init/deinit/remote-update-integration functionality.
>=20
> But there are users (like me) who do not treat submodules as
> black boxes and nonetheless do development in them with update
> set to checkout (after creating a feature branch of course ;-).

I'm still not clear on how this works for you ;).  Can you sketch out
an example shell history showing how you use checkout updates to do
this?

> > When you checkout a submodule for the first time, Git should take
> > the default information from .gitmodules and file it away in the
> > submodule's appropriate out-of-tree config locations.
>=20
> I disagree, that only makes sense for the URL setting (and this
> currently only happens with the update setting, which I intend to
> change). Everything else should be taken from .gitmodules unless
> the user wants to override it. The only setting I'm not so sure
> about is the local branch setting, as that might have to propagate
> into the submodule.

I think copying into the submodule's out-of-tree config is the way to
go, because users won't always be driving the submodule from the
superproject.  If the settings are in the submodule's out-of-tree
config, everything will be consistent betwee stuff run from the
superproject and stuff run from submodule itself.  It also allows us
to use familiar configuration commands inside the submodule, and have
those automatically mapped back into the .gitmodules file for us.

> > In fact, I think life is easier for everyone if this is the
> > default, and we add a new option (submodule.<name>.sync =3D false)
> > that says =E2=80=9Cdon't overwrite optional settings in my submodule's
> > out-of-tree config on checkout=E2=80=9D for for folks who want to opt o=
ut.
> > Don't worry, this is not going to clobber people, because we'll be
> > syncing the other way too.
>=20
> Yet another flag to make peoples life easier? I don't think so ;-)

I'm fine if there is no opt-out, and the syncing is mandatory, but I
imagine that folks who want a local (unshared, not in .gitmodules) URL
would complain.

> > Purely local metadata
> > ---------------------
> >=20
> > Some metadata does not make sense in the superproject tree.  For
> > example, whether a submodule is interesting enough to checkout
> > (init/deinit) or whether you want to auto-sync optional metadata
> > .gitmodules defaults.  This metadata should live in the
> > superproject's out-of-tree config, and should not be stored in the
> > in-tree .gitmodules.
>=20
> Not always. It makes a lot of sense to let upstream mark a
> submodule as "too big and you won't need it anyway" in the
> .gitmodules file.

Good.  Then there's no need for this special class of settings.

> > Since you *will* want to share the upstream URL, I proposed using
> > an explicit submodule.<name>.active setting to store the =E2=80=9Cdo I
> > care=E2=80=9D information [2], instead of overloading submodule.<name>.=
url
> > (I'd auto-sync the .gitmodule's submodule.<name>.url with the
> > subproject's remote.origin.url unless the user opted out of
> > .gitmodules syncing).
>=20
> That is wrong as it would break horribly when you check out an old
> commit with a now dead submodule URL and that gets automatically
> synced.

If you've already checked out the submodule with a current URL, you
should already have the old commit locally, and Git will use it
without trying to re-fetch from the broken old URL.

> > Subsequent checkouts
> > --------------------
> >=20
> > Now that we have strict linking between the submodule state (both
> > in-tree and out-of-tree configs) and the superproject tree (gitlink
> > and .gitmodules), changing between superproject branches is really
> > easy:
> >=20
> > 1. Make sure the working tree is not dirty.  If it is, ask the user to
> >    either add-and-commit or stash, and then die to let them do so.
>=20
> This condition is too hard, relax that to "a trivial merge can
> switch from current state to target state" and make it behave just
> like branch switching in the superproject. After all submodules
> should behave as much as possible like content of the superproject.

Sounds good to me.

> >  Clobber submodule
> >         configs and local branches at will (modulo
> >         submodule.<name>.sync), because any submodule configs that
> >         the user wanted to keep should have been added to the
> >         superproject branch earlier (or stashed).
>=20
> I don't think I like this part, but I admit I do not fully
> understand what you mean here. Clobbering stuff the user did doesn't
> sound very nice.

It's fine because we forced them to commit or stash any (not trivially
mergable) changes before starting the checkout command.

> > Summary
> > -------
> >=20
> > New .gitmodules options:
> >=20
> > * submodule.<name>.local-branch, store the submodule's HEAD, must
> >   stay in sync for checkouts.
>=20
> I'm still not convinced that the current branch setting couldn't be
> extended to carry that information, but no objections against
> configuring such a branch. But what do you mean with "must stay in
> sync for checkouts"?

That checkout-inducing commands should die if the .gitmodule's
local-branch and the submodule's HEAD don't match.

> > New .git/config options:
> >=20
> > * submodule.<name>.active, for init/deinit.
>=20
> I understand an option for automatic init (autoinit), but not for
> automatic deinit. Is the latter really useful?

This isn't auto-anything.  This is just =E2=80=9CI think the submodule is
interesting, please turn it on=E2=80=9D (i.e. I ran =E2=80=9Cgit submodule =
init
<submod>=E2=80=9D).

Only active submodules should get all the syncing, setup, and teardown
logic that goes along with submodule checkout.  Inactive submodules
are ignored.

> > I see no reason to add --recurse-submodule flags to 'git checkout'
> > (and merge, =E2=80=A6).  Anything that happens post-clone should recurse
> > through submodules automatically, and use the
> > submodule.<name>.active setting to decide when recursion is
> > desired.
>=20
> Backwards compatibility and testing. Let's first implement that and
> provide a config option to enable it for real world testing, and
> then let's discuss changing the default later.

Ok.

> > The current 'git submodule update --remote' would just be:
> >=20
> >   $ git submodule foreach 'git pull'
> >=20
> > because all of the local-branch checkouts would have already been
> > handled.
>=20
> Nope, that does different things to submodules where "branch" isn't
> configured, right?

It does the same thing.  Without submodule.<name>.branch configured,
you just integrate the subproject's master.

> >  Similarly, a global push would be just:
> >=20
> >   $ git submodule foreach 'git push'
>=20
> What's wrong with:
>=20
> $ git push --recurse-submodules=3Don-demand
>=20
> And it'll push the superproject at the same time. Extra points for
> already being implemented ;-)

That's a strong argument ;).  I still don't think the new-in-1.7.4 UI
change will add value.  The new-in-1.7.7 --recurse-submodules=3Dcheck
would still be useful.

> > I'd be happy to mock this up in shell, but only if anyone else
> > would be interested enough to review the implementation ;).  Then
> > I'll look into integrating the preferred model (this tightly bound
> > proposal, or v3's looser bindings, or <your idea here>) in C,
> > building on Jens and Jonathan's work.
>=20
> The update modes (cleaning removed submodules and creating new ones)
> are better handled in my recursive checkout series. But I believe we
> can at least prototype the branch handling in shell.

I'll prototype it, and keep trying to convince you about the syncing
;).  I think the main arguments for syncing are:

* No divergent configs between superproject-initiated actions and
  submodule-initiated actions.
* No work clobbered, or accidentally uncommitted, due to syncing
  submodule -> superproject before checkout-inducing commands.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--OwXh6gFRjCd3qPCM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS1Ed6AAoJEKKfehoaNkbtZeMP/jwXFTKKIiM0lNw/qraeC76F
zgMWRm+tTO2W+EShotQCsJip9DsIedY+m8WlpgW5ICkaZrN982y1INuyMMDccdLS
BRUggT8M8+Yo8EBXBMfPB/ZRDgQcHlUjZQrcODdQAeEs94oXQXXWiKNrErvbXVua
GCfunEoL+ppQxBklQTJdcJvW0bnmgPVhHDtcer4wf9nP/IxDpYtBLVdyTMkbXBxV
5WhXBndYgnt8HqmFYJKJGDw26X1xA2MYOSgkJ1w+0RRXBzP3Qw8lUK9KFXRlAT2s
pBdQvzkdh3w1ssRog//Pt36TwkQKnlQOGCPQsFMHujE6zLrhQxbC+rDDYMtHceKn
OQ1yMAvncdM33T/1SFpFMicPqVnt9SbRL381394kP4BBysYFOyYvc/p2WYAauZbU
7pjfvmco3DX4wF3my5o811fanBGFRbbGhdbS8VXp+rmY5TTuDcdx6X9TGrfdoqUL
mQqThGBQ6RYaob3nDiZpm7qQjpDj3Sxkeqgcxgd0ZuLTvGdVptAo2Ob1sbDQ9EFR
LmqsPfgcxAGExrG4SzC/8dOkmjzTkRlTHX8j7oFTp+lnHPOopfvUqCfmzx7KL/AC
U828s0Zn1LFr2MYBEM84Pp3gTrS5edA9Z3Gw1Ju7XB7R0dHbPF4JmqXG+9llnQq3
L8mDxzjBXlNDF5i6kWc0
=a2ZX
-----END PGP SIGNATURE-----

--OwXh6gFRjCd3qPCM--
