From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Preferred local submodule branches
Date: Tue, 7 Jan 2014 19:47:08 -0800
Message-ID: <20140108034708.GG26583@odin.tremily.us>
References: <20140107235208.GC29954@odin.tremily.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z9ECzHErBrwFF8sy"
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Francesco Pretto <ceztko@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 08 04:47:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0k6x-0000HM-Om
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 04:47:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754802AbaAHDrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 22:47:16 -0500
Received: from qmta13.westchester.pa.mail.comcast.net ([76.96.59.243]:57197
	"EHLO qmta13.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753994AbaAHDrO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jan 2014 22:47:14 -0500
Received: from omta13.westchester.pa.mail.comcast.net ([76.96.62.52])
	by qmta13.westchester.pa.mail.comcast.net with comcast
	id BFms1n00317dt5G5DFnDZF; Wed, 08 Jan 2014 03:47:13 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta13.westchester.pa.mail.comcast.net with comcast
	id BFnA1n00R152l3L3ZFnBjU; Wed, 08 Jan 2014 03:47:12 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 05A1EEACC0C; Tue,  7 Jan 2014 19:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1389152829; bh=PsHLf8cIlCZCwnYgpJeGRHMovEKFYAPcu+7EA10LyGQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=SSmaU/iM/BxvE1oakU/0TzDEyl4JHBTo/L8MTtPCxvaoGjtSxctUseXaegG23C5W9
	 3OGfzYNbkVssWwXKEz+CZfegMPfc+2bSVRE5T4O0bjqPozvk5UrF8oxsSMKfuKBTPp
	 Rt0jz0Pmkre8qQminhDtFETtvvnT+MhpSsvA61Jw=
Content-Disposition: inline
In-Reply-To: <20140107235208.GC29954@odin.tremily.us>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389152833;
	bh=l+F636TXvjihbw35VzO1EkNliDc2FXAta1RvDOO7fJQ=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=pAfRBNISvzJM7zD8vOyAWQ1+FIGGv16JfFGbu6RFum9br/KqaC96dj+W7hQniM57c
	 xKFG2vR+Te4gg00SWV1X/MlNithJOeg7HwtErPofzqRKEL9fTgRyFoTkA3cALys7T0
	 H5K8D6qC18108KY9IYZzKhCPrJisJSA4LMNGjc3dkvwcEG6AMrr/kNuteQcKSGU4cg
	 aFrG4BJ0UUq3LAbsjicDm7SCvcItTKWPRhvuWLvcAXNMREZA0kV8isVW/0RhBYq7si
	 XVYMD7339uQgabXHbYsxWN27u0B37GkB9qyHtYdSpJEWcYe2OIR99RrbOq0MckkBKm
	 cA1kdN3XPsypg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240192>


--z9ECzHErBrwFF8sy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 08, 2014 at 03:12:44AM +0100, Francesco Pretto wrote:
> 2014/1/8 W. Trevor King <wking@tremily.us>:
> > Note that I've moved away from =E2=80=9Csubmodule.<name>.branch
> > set means attached=E2=80=9D towards =E2=80=9Cwe should set per-superpro=
ject-branch
> > submodule.<name>.local-branch explicitly=E2=80=9D [1].
>=20
> Honestly, I'm having an hard time to follow this thread.

I tried to refocus things (with a new subject) in this sub-thread.
Hopefully that helps make the discussion more linear ;).

> Also, you didn't update the patch.

I'm waiting [1] to see how the C-level checkout by Jens and Jonathan
progresses [2,3] before writing more code.

> If you were endorsed by someone (Junio, Heiko, ...) for the
> "submodule.<name>.local-branch" feature please show me where.

As far as I know, no-one else has endorsed this idea (yet :).  Heiko
has expressed concern [4], but not convincingly enough (yet :) to win
me over ;).

> I somehow understand the point of the
> "submodule.<name>.local-branch" property, but I can't "see" the the
> workflow. Please, show me some hypothetical scripting example with
> as much complete as possible workflow (creation, developer update,
> mantainers creates feature branch, developer update, developer
> attach to another branch).

I've put this at the bottom of the message to avoid bothering the
tl;dr crowd, although they have probably long since tuned us out ;).

> Also, consider I proposed to support the attached HEAD path to
> reduce complexity and support a simpler use case for git
> submodules. I would be disappointed if the complexity is reduced in
> a way and augmented in another.

Agreed.  I think we're all looking for the least-complex solution that
covers all (or most) reasonable workflows.

> > On Wed, Jan 08, 2014 at 01:17:49AM +0100, Francesco Pretto wrote:
> >> # Attach the submodule HEAD to <branch>.
> >> # Also set ".git/config" 'submodule.<module>.branch' to <branch>
> >> $ git submodule head -b <branch> --attach <module>
> > [...]
> > I also prefer 'checkout' to 'head', because 'checkout'
> > already exists in non-submodule Git for switching between local
> > branches.
>=20
> I can agree with similarity to other git commands, but 'checkout'
> does not give me the idea of something that writes to ".git/config"
> or ".gitmodules".

Neither does 'head'.  We have precedence in 'git submodule add' for
embracing and extending a core git command with additional .gitmodules
manipulation.  I think it's easier to pick up the submodule jargon
when we add submodule-specific side-effects to submodule-specific
commands named after their core analogs than it would be if we pick
unique names for the submodule-specific commands.

> >> # Unset  ".git/config" 'submodule.<module>.branch'
> >> # Also attach or detach the HEAD according to what is in ".gitmodules":
> >> # with Trevor's patch 'submodule.<module>.branch' set means attached,
> >> # unset means detached
> >> $ git submodule head --reset <module>
> >
> > To me this reads =E2=80=9Calways detach HEAD=E2=80=9D (because it unsets
> > submodule.<name>.branch, and submodule.<name>.branch unset means
> > detached).
>=20
> I disagree: this would remove only the value in ".git/config". If the
> value is till present in ".gitmodules", as I wrote above, the behavior
> of what is in the index should be respected as for the other
> properties. Also it gives a nice meaning to a switch like --reset :
> return to how it was before.

Ah, that makes more sense.  I had confused .git/config with
=E2=80=9C.gitmodules and .git/config=E2=80=9D.

> >> NOTE: feature branch part!
> >>
> >> # Set ".gitmodules" 'submodule.<module>.branch' to <branch>
> >> $ git submodule head -b <branch> --attach --index <module>
> >>
> >> # Unset ".gitmodules" 'submodule.<module>.branch'
> >> $ git submodule head --reset --index <module>
> >> ---------------------------------------------------------------------
> >
> > These are just manipulating .gitmodules.  I think we also need
> > per-superproject-branch configs under the superproject's .git/ for
> > developer overrides.
>=20
> I disagree: in my idea the --index switch is a maintainer only command
> to modify the behavior of the developers and touch only indexed files
> (.gitmodules, or create a new submodule branch). It expressly don't
> touch .git/config.

Something that just touches the config files is syntactic sugar, so I
avoided a more detailed review and moved on to address what I saw as a
more fundamental issue (preferred submodule local branches on a
per-superproject-branch level).

Here's a detailed workflow for the {my-feature, my-feature, master}
example I roughed out before [5].

  # create the subproject
  mkdir subproject &&
  (
    cd subproject &&
    git init &&
    echo 'Hello, world' > README &&
    git add README &&
    git commit -m 'Subproject v1'
  ) &&
  # create the superproject
  mkdir superproject
  (
    cd superproject &&
    git init &&
    git submodule add ../subproject submod &&
    git config -f .gitmodules submodule.submod.update merge &&
    git commit -am 'Superproject v1' &&
    ( # 'submodule update' doesn't look in .gitmodules (yet [6]) for a
      # default update mode.  Copy submodule.submod.update over to
      # .git/config
      git submodule init
    )
  ) &&
  # start a feature branch on the superproject
  (
    cd superproject &&
    #git checkout -b my-feature --recurse-submodules &&
    ( # 'git submodule checkout --recurse-submodules' doesn't exist yet, so=
=2E..
      git checkout -b my-feature &&
      git config -f .gitmodules submodule.submod.local-branch my-feature &&
      cd submod &&
      git checkout -b my-feature
    ) &&
    (
      cd submod &&
      echo 'Add the subproject side of this feature' > my-feature &&
      git add my-feature &&
      git commit -m 'Add my feature to the subproject'
    ) &&
    echo 'Add the superproject side of this feature' > my-feature &&
    git add my-feature &&
    git commit -m 'Add the feature to the superproject'
  ) &&
  # meanwhile, the subproject has been advancing
  (
    cd subproject &&
    echo 'Goodbye, world' >> README &&
    git commit -am 'Subproject v2'
  ) &&
  # we need to get that critical advance into the superproject quick!
  (
    cd superproject &&
    # update the master branch
    #git checkout --recurse-submodules master
    ( # 'git checkout --recurse-submodules' doesn't exist yet [2,3].
      # Even with that patch, 'git checkout' won't respect
      # submodule.<name>.local-branch without further work.
      git checkout master &&
      cd submod &&
      git checkout master  # don't pull in our my-feature work
    )
    git submodule update --remote &&
    git commit -am 'Catch submod up with Subproject v2' &&
    # update the my-feature branch
    git checkout my-feature
    ( # 'git checkout' doesn't mess with submodules
      cd submod &&
      git checkout my-feature
    )
    git submodule update --remote &&
    git commit -am 'Catch submod up with Subproject v2' &&
    # what does the history look like?
    (
      cd submod &&
      git --no-pager log --graph --date-order --oneline --decorate --all
      # *   3a22cef (HEAD, my-feature) Merge commit 'd53958b18277ce5bd6c734=
e9597a69bb878b31e1' into my-feature
      # |\ =20
      # * | 8322dcc Add my feature to the subproject
      # | * d53958b (origin/master, origin/HEAD, master) Subproject v2
      # |/ =20
      # * 9813010 Subproject v1
    ) &&
    git ls-tree master submod &&
    # 160000 commit d53958b18277ce5bd6c734e9597a69bb878b31e1  submod
    git ls-tree my-feature submod
    # 160000 commit 3a22cef30db57f1b89251f3e434fa0bd0f1b99a2  submod
  )
  git --version
  # git version 1.8.3.2

The currently-ugly bits could be fixed with:

* 'git submodule update' falling back on .gitmodules for
  submodule.<name>.update [6].
* 'git submodule checkout -b my-feature --recurse-submodules' should
  checkout the submodule.<name>.local-branch configured for the
  super-project's my-feature branch (but only if that wouldn't destroy
  some current submodule information).  This would build on work in
  Jens and Jonathans' branch [2,3].

Cheers,
Trevor

[1]: http://article.gmane.org/gmane.comp.version-control.git/240127
[2]: http://article.gmane.org/gmane.comp.version-control.git/240117
[3]: http://thread.gmane.org/gmane.comp.version-control.git/239695
[4]: http://article.gmane.org/gmane.comp.version-control.git/240178
[5]: http://article.gmane.org/gmane.comp.version-control.git/240190
[6]: http://article.gmane.org/gmane.comp.version-control.git/239246

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--z9ECzHErBrwFF8sy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzMo6AAoJEKKfehoaNkbt/L8P/2wjEVx29pgLJTRyl9+O7q09
Zik6WfKSsJRtSDEUe2TaKztRx2aFxY1ZW2XZWwVc28hTeJtQ9K8QU9wwCUju7vq5
mPSmTihnoryDKSG/xOz/Z5XLa9IcZQqPcQ4KRdtkFI8qXZpKVTvFv4DWnr/XVEb7
oxiqcj7ZFay/lPkstZU/1W0W08Rz+KmYrExcrBg1O0D8pGOkpIvyJGvAclj0TF0Y
hVXjh76PrEY9ft8OLR8gL17VYZvpeiKclKGFFr2SdzNGfmhpU2h6aWD2g6vYGDl7
/eGF0dmdLe3KbQ/Zk+Bgql5f9Fkva5kZuQ6H1IBqMV3bf/ErLBYqv5wmEp3ol7Vi
7cXviO4H4o2haxmnJT8x9DOk5Xgckay3Ylrqz8tpram7WEQnB3JPwMEbI6Sr8CiC
aZYiH77/W+FzKHKCNjkc9qH0hygNSHqLa6FvGguSVhsAJg97x4Bge9LC4tRWsHFJ
1mgKVV2aOtYIRTGZjdgbpnD0qMiO6aan7wNJcuIIsEClFPCfEGlLNmQlgmjeHwGy
Me23zfOLqP35HTNBYje/VwrGjkUALD0rEOfv2cYBmTNOX5lLGiwn1FGwVKbeAdvb
ijwCn8KHZWDCjOnEuGITufD9a8g8mSKY/HdqxqVpG3kiVuf+lvD1XBQhDQFvgOFv
CIN65g/TJGU86r1rC5j2
=n7kG
-----END PGP SIGNATURE-----

--z9ECzHErBrwFF8sy--
