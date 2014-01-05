From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH] submodule: Respect reqested branch on all clones
Date: Sat, 4 Jan 2014 17:08:59 -0800
Message-ID: <20140105010859.GD3156@odin.tremily.us>
References: <CALas-iiF7Og8qjWoYeop3GofG_kR7w5DDcNkA1y3eQhu1Srxkw@mail.gmail.com>
 <dad947caba9e1c49d691ffccc868cfdce7d04e82.1388772192.git.wking@tremily.us>
 <20140104220915.GA5697@book-mint>
 <20140104225401.GA3156@odin.tremily.us>
 <20140105003922.GA21772@sandbox-ub>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SWTRyWv/ijrBap1m"
Cc: Git <git@vger.kernel.org>, Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Jan 05 02:09:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VzcDo-0005n0-G4
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jan 2014 02:09:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755200AbaAEBJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jan 2014 20:09:39 -0500
Received: from qmta09.westchester.pa.mail.comcast.net ([76.96.62.96]:39006
	"EHLO qmta09.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755154AbaAEBJD (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Jan 2014 20:09:03 -0500
Received: from omta18.westchester.pa.mail.comcast.net ([76.96.62.90])
	by qmta09.westchester.pa.mail.comcast.net with comcast
	id A0pw1n0021wpRvQ59192lE; Sun, 05 Jan 2014 01:09:02 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta18.westchester.pa.mail.comcast.net with comcast
	id A1901n00a152l3L3e191BG; Sun, 05 Jan 2014 01:09:02 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id F2D01E842A8; Sat,  4 Jan 2014 17:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1388884139; bh=ZRGA4Xz9Z9NG++bcezzGLi3Hoa1vX0+BMcqeUGxDHpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WYFZGJVFWVvezj3elINsv7gsej32Xdr0zgK3M95bfFz5xkXy9bWNbWLXU0yBfzyfY
	 3dTGZnYY0y1AC0Jdla0rFACS8aou/E26erVY1I+IE0W+nzNcjqSiybXwd4CI9VNyAQ
	 0Pa/BY04TARncSHfeJgtkw04kZKSt9+4xvaPQ3R4=
Content-Disposition: inline
In-Reply-To: <20140105003922.GA21772@sandbox-ub>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1388884142;
	bh=nwgRnkK+FHTQ+cQ1VEr+FdORcYgjkI0si9kjCD6SE/s=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=cLyCie2YEM5s3kiDa3pXb4TRc7NMJWxe3sjMenzksG6PdDR4KN7DTg2oai7JQ1FSp
	 GAsWVRVzf2uKFIOtAUKRMFTBrAAZ2wBKjh4zWlW3ghoVtckM8MQRtZ/tpSVemdag1W
	 K488OXFVEK9hXlBmo/Rpt7iZQxpJeN3KTNy2I+Dj/5nZ8YBetvhmgHCFAO4+TrMiiQ
	 XUi9O+cSLdCG1foisChT8uzx5TzO9aH24LInub8y6o8wa4kWWHPR91gSSUWu40G4mp
	 6qzCs3BVMdcMXSU/Y47et+p3PDAYkMl7ovdCMsabmt1i5Ynwx+j61plqIAimPIsuL0
	 OKrE5hRgpHLpw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239953>


--SWTRyWv/ijrBap1m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 05, 2014 at 01:39:22AM +0100, Heiko Voigt wrote:
> On Sat, Jan 04, 2014 at 02:54:01PM -0800, W. Trevor King wrote:
> > On Sat, Jan 04, 2014 at 11:09:15PM +0100, Heiko Voigt wrote:
> > > On Fri, Jan 03, 2014 at 10:06:11AM -0800, W. Trevor King wrote:
> > > > @@ -861,7 +860,12 @@ Maybe you want to use 'update --init'?")"
> > > >  			case ";$cloned_modules;" in
> > > >  			*";$name;"*)
> > > >  				# then there is no local change to integrate
> > > > -				update_module=3D ;;
> > > > +				if test -n "$branch"; then
> > > > +					update_module=3D"!git reset --hard -q"
> > >=20
> > > Does that not put the user in danger of loosing changes?
> >=20
> > No, because this is only happens for just-cloned modules.  The user
> > hasn't had time to make local changes yet.
>=20
> Ah ok I see. But why the reset then? Doesn't the earlier git
> checkout in your patch take care of checking out the branch and thus
> update to the right revision?

The reset avoids a detached HEAD.  With an empty $update_module, the
following case block will setup:

  command=3D"git checkout $subforce -q"

which is later called with:

  $command "$sha1"

That's going to give you a detached HEAD.  The new code sets up:

  command=3D"git reset --hard -q"

which will keep you on the branch checked out in module_clone().

> > > If submodule.<name>.branch is configured:
> > >=20
> > > 	git submodule update
> > >=20
> > > will checkout the configured branch instead of the sha1?
> >=20
> > The use case described by Francesco, a submodule maintainer Alice
> > sets up the submodule, which downstream developer Bob want to
> > checkout to a branch.  I think that matching the exact commit
> > specified by Alice in Bob's checkout is important, even if the
> > upstream developer Charlie has advanced the referenced branch in
> > the meantime.  Shifting the referenced submodule commit should be
> > an explicit decision made by Alice, not a clone-time accident for
> > Bob.
>=20
> But from what I understand of this part of Francesco's use-case
> description:
>=20
> > # Developer
> > $ git pull
> > $ git submodule init
> > $ git submodule update --remote
> > $ cd <path>
> > $ branch=3D"$(git config -f ..\.gitmodules submodule.common.branch)"; g=
it checkout $branch
>=20
> Is that he wants to allow the developer to switch to following a
> branch instead of an exact sha1 while some extension in the common
> module is still under development. That makes it easier to develop
> in parallel in the submodule and the superproject because you do not
> need to update the sha1 all the time.

I'll wait for Francesco to clarify his use case.  All my patch does is
replace the manual:

  $ cd <path>
  $ branch=3D"$(git config -f ..\.gitmodules submodule.common.branch)"; git=
 checkout $branch

with an automatic (on update):

  $ branch=3D"$(git config -f .gitmodules submodule.${name}.branch)";
  $ cd "$path"
  $ git checkout -f -q -B "$branch" "origin/$branch"
  $ git reset --hard -q "$sha"

when submodule.<name>.branch is configured.  Whether that last bit is
desirable or not is debatable.  If you *do* want to float the
submodule past the commit blessed by Alice, it's easy to add a manual:

  $ git submodule update --remote --rebase "$path"

If we drop the trailing reset (to float the checkout), it's harder to
rewind to the commit blessed by Alice, because distinguising between:

a) locally added stuff that we want to merge/rebase onto Alice's $sha,
   and
b) advancements from the automatic float that we *don't* want to
   merge/rebase onto Alice's $sha.

is difficult/impossible.  If you use the --checkout strategy (there
are no local commits), you can use:

  $ git submodule update --checkout "$path"

but you'd still need to update the branch references to point to the
that particular commit.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--SWTRyWv/ijrBap1m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSyLCpAAoJEKKfehoaNkbt1wkQAI+3X0YtB7CVjr+LUjLDF3tk
OB8CGb9KU4c6XeoIGh9/7Nd3V11HpurDRqysW2ZHjRU0iCtzDIvvB4Vz2ERM9Jn4
tfIHBk+DQ1fCEBi6ofFclxza3Fzph3VOyaBn1b7tqpwM50HLLbw9rvg8WzHOiv+d
pOdTZJsl2H8ySghxWyNtCxAZ4K1Q9RlpPeSWBV78j7PaV6uW3QlFMxzGC0DMDU3t
sjiH1Y2EIeWqN64J+sLk1VAt+7Y8OhcCalvzMdHA1tPHXb638zXPyubkDxnyknVr
rdMFjLNeZC2V/C5mTp2XQFJMa/sCBwzZXytyMT3bZxkztItbxSd7D43bUBZX1U2G
v6dTWOMgwEYqBCXRxLjyoAzfjpCvjEejW51Yn4RxovAyweSdLCoKawc90sCUuDiw
lwufkjn0E+p50q+VgM0RN2xBDfjbbiRAWeiRj9cwx5qgMKZ5+N/uYOwgFd2sXfaP
BhHCp3hGyO3LA6tOcF3hx+gPUQqoLj5V7aqoRTxEw9QmlYB9adtV8n306bqTktzc
+9+KsGC2ww5J+h8bqlkrWfBdLhcauJiOL9hs8SyyaRFeZs8nK7fQRkGs9iDMzjqg
sy8pvUIIjETsy69SkIq0iiEwyXxqajPJkkAvB29cODi/Af4wu7d12IMJTIz/FQ47
f+Zex/OAfRRdCujfqu2g
=LHGQ
-----END PGP SIGNATURE-----

--SWTRyWv/ijrBap1m--
