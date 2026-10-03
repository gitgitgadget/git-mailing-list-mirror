Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE502882AB
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 21:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791063517; cv=none; b=EQTB0CbRp2flPSUGG8o5DSqNeKsvnrFqE1FFL2eL2Ex0PIADyGAEfdk5Sx3IkpVkqzNfX34TVpH9vaJBCAC6X6ycFVW0BDzzSLOqHJMaq6EsLc6RQOWtgQG4v4NzpSIOcJh1GFwd1w/E4wp2r4H+WVijubDftHkf0VaVxVPEQl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791063517; c=relaxed/simple;
	bh=NRx622UHKNJRskvNmLi/NFUQg2hsvUVDta2HWsYFrEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rO/yN5+jBCljzlcB8V0n7oBf5BtH/Fl4OHOCfmpdlXDBJe9bf4HknGNFMrz2sK2y4zArRasvBvSpgFvc4CVJGYp/AZJtv2MQen77QGg94gGhZZN3MmWPavW7QuUKkWnaHqdESW3LgO4tscVcNOhCYtNFpvyK0Wiwj6X4SnbhWlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3Jzvw+R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3Jzvw+R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 003291F0089C;
	Sat,  3 Oct 2026 21:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791063516;
	bh=wTQkvnRupmIn5Yxu/Zt00YhrHRUhKHpgOmeCnwNIoXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G3Jzvw+R1jSfmSpWAgtWusS9ocxvZleW5UPbM3EsO3U6K5cs5klOuhEOLU4GXQX1/
	 WViTx63ugDr7YMazywridw1DJnqa3VNoSnAjhIkcYGP20unDp6SpeBKpfAe3NhrHVa
	 0uE0c0Tf9tjgTZzJrkm8iJL1GFM0fW/pTAmgCy2L7CM/VEjqF6EFLweB+TcNL2ZfUc
	 nAVfH11byvTJmaTCew2dJ8omrNk1qtau4zAWLyxY1d1wGS4sK2kw1dMbxtWIOrzLHB
	 Z+wBTVzgvyAi1mSv3Fg+DpPy0bTw5G7tGbZLy0FQ7Qo2N6r+N4LVayqkxvPU+ZTHEU
	 xn2vDBnaD9TgQ==
Date: Sat, 3 Oct 2026 23:38:29 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Nico Williams <nico@cryptonector.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Ben Boeckel <mathstuf@gmail.com>, Viktor Dukhovni <viktor@openssl.org>
Subject: Re: [RFC] git-brebase
Message-ID: <asF0DkNtlnJ9-Sng@debian>
References: <asFRVdMTpshsazgM@debian>
 <asFoDZKscLKqaIf+@ubby>
 <asFoq4gnl1caJM2U@debian>
 <asFv9QcpLgzPnnFb@ubby>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j4e6n5lq4dnf3udx"
Content-Disposition: inline
In-Reply-To: <asFv9QcpLgzPnnFb@ubby>


--j4e6n5lq4dnf3udx
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Nico Williams <nico@cryptonector.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Ben Boeckel <mathstuf@gmail.com>, Viktor Dukhovni <viktor@openssl.org>
Subject: Re: [RFC] git-brebase
Message-ID: <asF0DkNtlnJ9-Sng@debian>
References: <asFRVdMTpshsazgM@debian>
 <asFoDZKscLKqaIf+@ubby>
 <asFoq4gnl1caJM2U@debian>
 <asFv9QcpLgzPnnFb@ubby>
MIME-Version: 1.0
In-Reply-To: <asFv9QcpLgzPnnFb@ubby>

Hi Nico,

> Date: 2026-10-03 16:13:25-0500
> From: Nico Williams <nico@cryptonector.com>
>
> On Sat, Oct 03, 2026 at 10:56:25PM +0200, Alejandro Colomar wrote:
> > > I also have a getopts_long-like function (see my gists) for bash if y=
ou
> > > like.
> >=20
> > I think getopts(1) is not usable for git(1)-related scripts, because
> > getopts(1) interprets '--' as the end of the options, but git(1) uses it
> > for distinguishing commits from paths.  If anyone shows me how it can be
> > used, I'd be interested, because I've hit this issue in the past with
> > other script.
>=20
> https://gist.github.com/nicowilliams/f3fe2b10b380aecdef403acb246dced2
>=20
> Though there's many ways to do this.

That one still consumes the '--', but we don't want to consume it.  We
want it to remain there in $@ after the options have been parsed.

> > > > cat >"$callback" <<__EOF__
> > > > #!/bin/bash
> > > > ...
> > > > __EOF__
> > > > chmod +x "$callback";
> > >=20
> > > Here what might be better is to have a command-line option to execute
> > > this callback without having to write it to a file,
> >=20
> > How would you do it?
>=20
> I'd have an option or sub-command of the main script that says "do the
> callback thing", then when you run `git bisect run ...` put in the name
> of this script as the command and the "do the callback thing" option
> next.

I'd need to see some code.  I'm not seeing it.  :)

> > > and use environment
> > > variables to pass arguments to it.
> >=20
> > The callback doesn't really need any arguments, since 'git bisect run'
> > won't pass any arguments to it.
>=20
> But you're embedding values into the temp executable script -- if you
> don't have that any more you'll have to pass those in.

But why would we want to not have it?
That would complicate the script, no?

> > > which means I can't use this in detached HEAD mode :(
> >=20
> > Oh!  I wasn't aware that git-rebase(1) supported detached HEAD mode.
>=20
> Sure does!
>=20
> > > I work in detached HEAD mode almost exclusively.  I know, that's..
> > > weird.  But it works for me.
> >=20
> > Ouch!  Indeed.  :)
> > Out of curiosity, are there any interesting reasons for such
> > self-implied pain?
>=20
> I often do:
>=20
> : ; git checkout origin/master
> : ; <do some work>
> : ; git add ...; git commit -m '...'
> : ; git push myfork HEAD:refs/heads/the-branch-name-here  # <-- I name it=
 here
>=20
> then open a PR.
>=20
> Now I don't have a branch here, but who cares?  If I switch to other
> work and later want to come back to this work I'll either a) create a
> local branch then, and/or b) when I resume work on the first thing I'll
> `git checkout myfork/the-branch-name-here` and...  once more work in
> detached HEAD mode.
>=20
> And if I need to see "what was I doing?" then I use `git log --oneline`
> and `git reflog` and I quickly see the remote branch of interest.
>=20
> The remote branches are the symbolic names I need to preserve, and my
> clone will know them, so I only need local branch names for things I
> work on w/o a network or over a long time.
>=20
> I do exaggerate a bit.  I do this a lot, but maybe not quite "almost
> exclusively".  Often I'm forced to have a local branch by opinionated
> tools other than git itself.

Hmmm, actually resembles what I do.  I use branches, then push to
a remote, and once it's in the remote, I remove the local branch.
I try to remove the local branches as soon as I can, because that way
I don't need to remember whether there was something I forgot to push,
or I wanted to explicitly discard it.  If there's no local branch,
there's no confusion.  Since I work with two local computers, having the
source of truth be the remote makes it less ambiguous.  But while
working locally, the branch helps a lot.

Anyway, I've patched it to work with detached HEAD.  (I need to remember
to add two traps, now.)

	diff --git i/src/bin/git-brebase w/src/bin/git-brebase
	index d652c37ef08d..a57acc350d7e 100755
	--- i/src/bin/git-brebase
	+++ w/src/bin/git-brebase
	@@ -50,8 +50,16 @@ if test $# -gt 1; then
	 fi;
	 git rev-list -1 "$1" \
	 | read -r tgt;
	-git rev-parse --abbrev-ref HEAD \
	+
	+mktemp \
	 | read -r branch;
	+{
	+       git rev-parse --abbrev-ref HEAD;
	+       git rev-list -1 HEAD;
	+} \
	+| sed '/^HEAD$/d' \
	+| sed '1!d' \
	+>"$branch";
	=20
	 # Set up the callback script for 'git rebase run'.
	 mktemp \
	@@ -91,7 +99,8 @@ cat >"$callback" <<__EOF__
			fi;
		fi;
	=20
	-       git switch '$branch' >/dev/null 2>/dev/null;
	+       cat '$branch' \
	+       | xargs -I{} git checkout {} >/dev/null 2>/dev/null;
		git rev-list -1 HEAD \
		| read -r old_head;
		printf '%s' 'Rebase: ';
	@@ -103,6 +112,13 @@ cat >"$callback" <<__EOF__
			git checkout --detach "\$bisect_head" 2>/dev/null;
			exit 1;
		fi;
	+       {
	+               git rev-parse --abbrev-ref HEAD;
	+               git rev-list -1 HEAD;
	+       } \
	+       | sed '/^HEAD$/d' \
	+       | sed '1!d' \
	+       >"$branch";
	=20
		if test -n '$post'; then
			printf '%s' 'Post-rebase exec: ';
	@@ -146,7 +162,8 @@ fi;
	 # shellcheck disable=3DSC2248  # gbopts may hold multiple options
	 git bisect start $gbopts >/dev/null;
	 git bisect bad "$tgt" >/dev/null;
	-git merge-base "$branch" "$tgt" \
	+cat "$branch" \
	+| xargs -I{} git merge-base {} "$tgt" \
	 | xargs -I{} git bisect good {};
	 git bisect run "$callback";
	 git rev-list -1 bisect/bad \
	@@ -154,7 +171,8 @@ git rev-list -1 bisect/bad \
	 git bisect reset >/dev/null 2>/dev/null;
	=20
	 # Perform the conflicting rebase
	-git switch "$branch";
	+cat "$branch" \
	+| xargs -I{} git checkout {};
	 # shellcheck disable=3DSC2086  # gropts may hold multiple options
	 git rebase $gropts "$bad";
	 if test -v post; then

I've tested it, and it works fine with a detached HEAD.


Cheers,
Alex

>=20
> Nico
> --=20

--=20
<https://www.alejandro-colomar.es>

--j4e6n5lq4dnf3udx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrBddUACgkQ64mZXMKQ
wqlh0hAAmewl12QbhwyN3INRC00qntMo32XyarrY3HoShYphYjcms2Sd4S4aFpNb
5yeq2wOT6maEBWLXRt1ywG4ohaaqZMja3DGOuLAjc4W/timvP173NXYOB1IiOG2k
dYWg3hnwyo9xgILKiJBZyHlRmUGXJx0hx0SJASLlwp0sgEYLDAFUeNfMFQe5og+x
ecQnoCPv9dB2iYNNZnLmyum23CCWmOPBTTH2WyV42GFObggbaEATLxzUauMFHrjl
j4U9gHd2dtfgdJ2LkrI0pVZTg6WH8gBybQn2lemE54TDL1DF08W0/iQqf0UIju1b
6VKL0D6tsKnRXBOA0WxYWnxUMQGV1X9/eXdeNxtEfKWaiBnJWCze9ldOurx5NLni
1GjoW0Le1WUkfpzB/aiWx2eJjuLVkWPp8lby2l2wc+yxgA8SjkyyLUbuGD7H7Ty1
S6KSV4/VAdwUhKoYIcdb/8Z8fvz2PCq/oixdPN+7TGigpDvKZVft6RLlcKbcqPf1
w5rntxxRxOJmvJhKxgZE3MJQZTXZPS17ppI4ktlrdnvXnum7+TW+SCFgN0jvCWMN
jiadBhDCnozVkmG4LQhNWiKQC6vLIy+sUCh0F3VLB3vVnJktu3tUH/zyBFnQV/yR
8h1ZsVNjMN36iUsVOf7WfjZ6xVVPWrKU5WIXoOQcgXbzQ0BtaJ0=
=40Ko
-----END PGP SIGNATURE-----

--j4e6n5lq4dnf3udx--
