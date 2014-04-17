From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [RFC] t7410: 210 tests for various 'git submodule update'
 scenarios
Date: Thu, 17 Apr 2014 08:31:09 -0700
Message-ID: <20140417153109.GM21805@odin.tremily.us>
References: <1397609688-25634-1-git-send-email-johan@herland.net>
 <20140416172153.GW21805@odin.tremily.us>
 <CALKQrgfF2Kkk4itvtm_yU9qm9GrJf-DWQQG8y+CAwisOUqY=eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0yP1TEATOxPughaP"
Cc: Git mailing list <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Apr 17 17:31:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaoHl-0001Mh-GP
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 17:31:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752444AbaDQPbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 11:31:24 -0400
Received: from qmta12.westchester.pa.mail.comcast.net ([76.96.59.227]:48943
	"EHLO qmta12.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751403AbaDQPbN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Apr 2014 11:31:13 -0400
Received: from omta08.westchester.pa.mail.comcast.net ([76.96.62.12])
	by qmta12.westchester.pa.mail.comcast.net with comcast
	id r2531n0060Fqzac5C3XCQA; Thu, 17 Apr 2014 15:31:12 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta08.westchester.pa.mail.comcast.net with comcast
	id r3XA1n008152l3L3U3XAPi; Thu, 17 Apr 2014 15:31:12 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 993AA1150D5C; Thu, 17 Apr 2014 08:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1397748669; bh=vRMH8WXgKpBHGnBOpVy3L4Q1OGpNJ6kuHWiAasWu/l8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YynAr47TwDJ7HPuA5ZrU3rmN/59YpQjHfwXNPXvTW6ZcvGlKozQvE3XTY2ZXluZU+
	 xtKsj/HM8U+JWb2ZajGpiUOYP3ZkiWcmDv/H6x+Q8BabnHXrfmHuiGVi9f7/kqYE+V
	 0CWt6GbczbcfY0sVbAuhvTTaSEf0d6rqSWsrLjn0=
Content-Disposition: inline
In-Reply-To: <CALKQrgfF2Kkk4itvtm_yU9qm9GrJf-DWQQG8y+CAwisOUqY=eg@mail.gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1397748672;
	bh=RIbnc/2HrSEAJA8dR2i/MBoPoNTY9BQggdwxYRAzkDk=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=KaQ5IhXvlsZsApaqCq3GuX6DbWQM33hiUZx4qhC72f4Ti+3GfRjnusgHUlHrSRpfp
	 zZnNuaIc1XNBt5VhYBeuLYU+jBXaS84x5gP3JoFMwqvCYLlLlXaFE/dBdcUoe0Ty6K
	 4nBWk5J+FemCuUNWuFTM1FYBq23lneeE0WIF/Xn5FvCc0iSdAPfXpxlQCQjaA2/bnH
	 bRVXEBtPUC3yJwLfknyg6xE9VqWYVlK9ydZwtIRqsIi3NCNhKPAJLHf2LfWNQKetFP
	 4AvOtFqPOeH8BLdQrwLwiT7ZadvWEzgOegPAEbwyGqWXRHelxBWQimuWvY8Ah8vmWH
	 D4gg5i0oDb/gw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246418>


--0yP1TEATOxPughaP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2014 at 01:42:42PM +0200, Johan Herland wrote:
> >> +# T2: Test with submodule.<name>.url !=3D submodule's remote.origin.u=
rl. Does
> >> +#     "submodule update --remote" sync with submodule.<name>.url, or =
with the
> >> +#     submodule's origin? (or with the submodule's current branch's u=
pstream)?
> >
> > All fetches should currently use the submodule's remote.origin.url.
> > submodule.<name>.url is only used for the initial clone (*.*.*.1), and
> > never referenced again.  This would change using my tightly-bound
> > submodule proposal [1], where a difference between
> > submodule.<name>.url and the submodule's @{upstream} URL would be
> > trigger a dirty-tree condition (for folks with tight-bind syncing
> > enabled) from which you couldn't update before resolving the
> > difference.
>=20
> Ok. As stated above, I am worried about the amount of duplicated
> state between the superproject's submodule config (which itself is
> split between .gitmodules and .git/config) and the submodule's own
> config. And from the above paragraph, I suspect two more dimensions
> need to be added to the test matrix:
>=20
>  - submodule's remote.origin.url =3D=3D/!=3D submodule.<name>.url
>=20
>  - "tightly-bound submodule" is enabled/disabled

Tight-binding hasn't been implemented yet, or even accumulated much
support from other folks ;).  However, the idea is to unify the state
between the superproject's .gitmodules and .git/config and the
submodule's .git/config (or ../.git/modules/<name>/config, or
whatever).  Then folks with tightly-bound syncing enabled have only
one state space to maintain (and get auto-updates for each
superproject checkout), and folks who opt-out of tightly-bound syncing
are presumably embracing the complexity of our current system, with
it's two, confusingly-aligned configuration spaces.

I'm happy to force syncing (i.e. no opting-out allowed) [1], but I
imagine there are folks who would resist ;).  Maybe a deprecation
period to help ease the transition?  This is all assuming that I get
more folks to buy into the tight-syncing ;).

The end-goal of my tightly-bound approach is to remove 'submodule
update' altogether and end up with a simpler interface [2]:

On Sat, Jan 11, 2014 at 05:08:47PM -0800, W. Trevor King wrote:
> * git submodule [--quiet] add [-b <branch>] [-f|--force] [--name <name>]
>                 [--reference <repository>] [--] <repository> [<path>]
> * git submodule [--quiet] init [--] [<path>...]
> * git submodule [--quiet] deinit [-f|--force] [--] <path>...
> * git submodule [--quiet] foreach [--recursive] <command>

All of this 'submodule update' integration confusion would be resolved
by the developer who updated the gitlink, and superproject checkouts
would just swap the local submodule branch/HEAD without having to
worry about clobbering uncommitted state.

On Thu, Apr 17, 2014 at 01:42:42PM +0200, Johan Herland wrote:
> We should instead seek ways to minimize the duplication of state.

The tightly-bound-submodules I'm proposing try to use the submodule's
config settings (plus submodule.<name>.local-branch) as the familiar
language, while your proposal uses Git commands as the familiar
language.  I think both would work, but config settings are easier to
parse automatically, which helps with automatically syncing between
the superproject and submodule configs.  Syncing, in turn, helps
bridge the gap between the easily shared superproject/.gitmodules and
superproject/.git/modules/<name>/config (enabling familiar-to-use Git
commands in the submodule).

>  - submodule.<name>.create: =E2=80=A6

Syncing submodule state back up into this is going to be a manual
operation.  For example, changing the submodule's remote.origin.url is
going to require hand-tweaking to update this setting.

>  - submodule.<name>.update: =E2=80=A6
>     =E2=80=A6
>     - 'git reset --hard $GITLINK'
>       Equivalent to checkout-mode (without --remote).
>=20
>     - 'git fetch && git reset --hard origin/HEAD'
>       Equivalent to checkout-mode with --remote.

Folks who sometimes use --remote updates will still need non-remote
updates.  For example, if Alice and Bob are both developers on the
same superproject:

  alice$ git submodule update --recursive --remote # integrate upstream cha=
nges
  alice$ git commit -m 'Bumped submodules to upstream tips'
  alice$ git push
  bob$ git pull
  bob$ git submodule update --recursive # integrate Alice's gitlink changes

so it should be easy to toggle back and forth between the two
integration targets.  However:

  git fetch && git reset --hard origin/HEAD

is easy to run using 'git submodule foreach', or after changing into
the submodule directory, so I'm not particularly concerned here.

With tight-binding and superproject-checkout-time auto-updates, the
above would be:

  alice$ git submodule foreach --recursive 'git pull'
  alice$ git commit -m 'Bumped submodules to upstream tips'
  alice$ git push
  bob$ git pull  # update to Alice's new gitlinks happens automatically

Another problem with a single submodule.<name>.update is if I want to
pull origin/HEAD into my submodule's master branch, but origin/dev
into my dev and feature-x branches (table and further discussion in
[3]).  That's not going to pack down into a single command.  In [3], I
lay out how you could setup per-superproject-branch configs for
=2Elocal-branch; you'd need something similar for .update.

> I now realize that my above arguments against increased complexity
> in submodule.<name>.* options arrive way too late, and is probably
> more like trolling than like constructive input.

I'm happy to have more input :).  It's hard to imagine an interface so
polished that it can't be improved, and the current submodule
interface is certainly well short of that hypothetical goal ;).

> >> +# D6: The meaning of submodule.<name>.branch is initially confusing, =
as it does
> >> +#     not really concern the submodule's local branch (except as a na=
ming hint
> >> +#     when the submodule is first cloned). Instead, submodule.<name>.=
branch is
> >> +#     really about which branch in the _upstream_ submodule
> >
> > Which is how gitmodules(5) explains it:
> >
> >   submodule.<name>.branch
> >     A remote branch name for tracking updates=E2=80=A6
>=20
> Good, but I fear gitmodules(5) is too hidden for the regular user.
> It'd be better to mention this in git-submodule(1), as I expect
> gitmodules(5) is largely read by .gitmodules _authors_, and not
> regular users. Obviously, the real fix would be a better name...

I'm fine with a rename to .remote-branch.  Migrating through a config
rename should be pretty easy to do, but it's going to make future
changes more difficult until the migration wraps up $n releases in the
future.  I'd prefer jumping straight to my tight-binding approach,
though; where --remote updates are replaced by the more familiar:

  $ git submodule foreach [--recursive] 'git pull =E2=80=A6'

> >> +#     submodule.<name>.url, or by the submodule's remote.origin.url?)
> >> +#     want to integrate with.
> >
> > The submodule's remote.origin.url for everything except the initial
> > clone (*.*.*.1).  See my response to T2.
>=20
> As mentioned above, submodule.<name>.url is then an unnecessary state
> duplication.

It's not unnecessary before you've cloned.  And you'll also want to
update it if you change the submodule's remote.origin.url, so other
folks (who haven't cloned yet) aren't stranded with the old URL.

> >> +# D7: What to do when .branch refers to a branch that is missing from=
 upstream?
> >> +#     Currently, when trying to clone, the clone fails (which causes =
'git
> >> +#     submodule update --remote' to fail), but leaves the submodule i=
n an
> >> +#     uninitialized state (there is a .git, but the work tree is miss=
ing).
> >> +#     This is probably not the behavior we want...
> >> +#     Affects: pre, 3.2.2.1, 3.3.2.1, 3.4.2.1, 3.5.2.1
> >
> > I think we should remove the submodule's .git file after the failed clo=
ne.
>=20
> Agreed, but does that extend to the superproject's .git/modules/<name> to=
o?

That's what 'git clone' usually does, so yes.  Ideally we'd add a
check to the initial clone that bailed out before fetching tons of
objects in the event that the referenced branch / commit was not
present on the remote.

Cheers,
Trevor

[1]: http://article.gmane.org/gmane.comp.version-control.git/240370
[2]: http://article.gmane.org/gmane.comp.version-control.git/240336
[3]: http://article.gmane.org/gmane.comp.version-control.git/240251

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--0yP1TEATOxPughaP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTT/O6AAoJEKKfehoaNkbt420P/2/C4s7doZE9UK5oatFIwmkE
y3jhN1iCKOu0ANFYRb53pDMWYD2vs6GU6DIPXGuaI2tMwk9QYNJhNv9oRjUJyIUH
7zDFpWhSiLP1lcshUJlcA9SKl91tg4eNDh487yyxJaHkI8XOtqyFoKbmNbXt/sxM
ObfTo75FShFSC+wK+6XHoIz9PFC7CvRfOPWsWpbUueLp6WAhwTzgOQyH4D/XmoKw
PabDpFivPgGviJkw1vww6XTlHz+7wYyxkWxee88PWtuofqJOaOG3OgmKhY4MjQ0P
5TFB9eZqd2k1pt1zdsTui1/SVn5oxjsyTw2KqNqtuaYua+sQlY4B7g9QvAPuJEi9
70wl/p3FIf/7bjaWFizVDmCcCT6C1Dhhxn2aS+vghSjP0gDF1NJNT2+/PwkiZ6i9
NP4tWXrCDAUcf4Zsndcp0Kz+YrT81TlyFOY47/Q5yL9olGJa5t/hEqzy9tSLv+7X
TLmdK8Dxsxzg/R1B17xcOMvJEDVC15cEDtFNiWxKhctEWZeNL/23YOZiWxIJAPOP
ohQSlKYiMW7m5mOiT2zqGDr57bIrhHg6UampbS9lKH/Tw3f58uLmIvqeHyxu9np/
e2a/ByPKQSTICGbFVcljwhD6Jdg57nQxiruLcuL5M4Y34SbYBwCQHdXWddDrUdRn
dU2Ck2soraSQkp0YOsck
=LTf7
-----END PGP SIGNATURE-----

--0yP1TEATOxPughaP--
