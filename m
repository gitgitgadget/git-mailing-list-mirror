Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9AD11C86
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 11:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Aa/eWZ/7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iDMKqSp1"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC476F7
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 04:44:58 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 64D995C04FB;
	Wed,  1 Nov 2023 07:44:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 01 Nov 2023 07:44:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698839098; x=1698925498; bh=wv
	7zTkuLAoqdA90M0RX8e0tMP6CixPlOeqpzTm7ObrE=; b=Aa/eWZ/7pZjlBTLKmu
	ihK++5dPoirBK19uqmjmh92e3IOlNRytv9OL/ryx/DLjnjfTdnaW4d8CGksUzVUR
	vbi5zIhdMfLIcfBjZd3KJ4s7U8FvEAzagu2aSQVNexk1+e0dN0uJIc+rhIt3apxt
	rtdlh1EUEtG4SLzs1wdR4MqH0KEtqxJSaVzSAe5FRpiqoOHGOd3KhmU7hVVNDKL3
	1at74t7d0Lclf0l86bnCLHpq808FjspmOh0wNhtiJnmmjD6dpmslG+zeR1+10vQn
	bsYrUL9D4msp7tKpOCyW6udEzBmcO7R73xfIDVFHEjj3ytIa7wSEvNyBl564fkJk
	8NmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698839098; x=1698925498; bh=wv7zTkuLAoqdA
	90M0RX8e0tMP6CixPlOeqpzTm7ObrE=; b=iDMKqSp1Hvy5WJOp/kc9v88vW0rBX
	qKqcOw7W0O409aF5zbz1mTsJ/WrJpRnWDPrQ3RF8tdMvfET+/d/79Ytay237Lztg
	E5zbaoNTCq9voRcQGXj21p2EhyABpnAT+DwCaOkW/bIx6xwfMMjV8ezJ04IsSC31
	wV+quIHSMmuUnR5SxPJm6b9zyKcQEHoVAK9GA8v7MjwA7aAZ7UFDIUH+TGaRxymp
	KmUUogDKh+iBat76LtVQv6uGvkyGbpiIRPV4u8GVxMd7sI/xZdt0m7vy1ZB2xZ9l
	MMtXrYllmxv0wXCTVcADN7/gfwvcnOeZCmnVssdC4b0/xNLR6CuihMGvA==
X-ME-Sender: <xms:OjpCZQygcmA6Vfbunp3pl_4dWnyrDzGeSzsHlakflfYULTTxvyISFQ>
    <xme:OjpCZUQJn0eKOUImKbvsW43T6cYKJaHCkabg5X7JkniA3Ae_CePmCK9QaUvJIm2eE
    m1EDjFait3VJ-Qu1w>
X-ME-Received: <xmr:OjpCZSViGtvzM8nWxB3AuwbouXkJGPfbcZVyfM4sgVxOaWejJivi6k9o_kP9H-Zg_jT_5zHRty_brnhU_uwO0JH3BohzTK-vaw2DVM8AqDuw2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtgedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:OjpCZehzaNNRbRkf9TTMHFqbv7sYHPC1g1ocQT-t02rOUUzVSl6mnQ>
    <xmx:OjpCZSCOvyHglU59voX1S0tb8S4wql89JFESBiA4jyuTl-sUw0AH2g>
    <xmx:OjpCZfLfpr4ZGp9n0sJuxdD5-guOF7KlEFFgIElG2xhBaEQuRYYmZQ>
    <xmx:OjpCZV9I5cf8EB8DATTsrXXpOelfAwVyY4lJ6qhIaJ9zzcof0h6tjQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Nov 2023 07:44:56 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 58ba9c66 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Nov 2023 11:44:46 +0000 (UTC)
Date: Wed, 1 Nov 2023 12:44:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Victoria Dye <vdye@github.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: Re: [PATCH v4 8/8] ci: add support for GitLab CI
Message-ID: <ZUI6Nv-HIxXuPMVC@tanuki>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698742590.git.ps@pks.im>
 <f3f2c98a0dc6042b7ed5eab9c10bee4f64858f02.1698742590.git.ps@pks.im>
 <4c8c2f19-1a7e-4524-81e7-c74091e88edf@github.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ACslhabbD2e9DmaD"
Content-Disposition: inline
In-Reply-To: <4c8c2f19-1a7e-4524-81e7-c74091e88edf@github.com>


--ACslhabbD2e9DmaD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 10:47:44AM -0700, Victoria Dye wrote:
> Patrick Steinhardt wrote:> diff --git a/ci/install-docker-dependencies.sh=
 b/ci/install-docker-dependencies.sh
> > index 6e845283680..48cb2e735b5 100755
> > --- a/ci/install-docker-dependencies.sh
> > +++ b/ci/install-docker-dependencies.sh
> > @@ -7,6 +7,9 @@
> > =20
> >  begin_group "Install dependencies"
> > =20
> > +# Required so that apt doesn't wait for user input on certain packages.
> > +export DEBIAN_FRONTEND=3Dnoninteractive
> > +
> >  case "$jobname" in
> >  linux32)
> >  	linux32 --32bit i386 sh -c '
> > @@ -16,11 +19,19 @@ linux32)
> >  	'
> >  	;;
> >  linux-musl)
> > -	apk add --update build-base curl-dev openssl-dev expat-dev gettext \
> > +	apk add --update shadow sudo build-base curl-dev openssl-dev expat-de=
v gettext \
> >  		pcre2-dev python3 musl-libintl perl-utils ncurses \
> >  		apache2 apache2-http2 apache2-proxy apache2-ssl apache2-webdav apr-u=
til-dbd_sqlite3 \
> >  		bash cvs gnupg perl-cgi perl-dbd-sqlite >/dev/null
> >  	;;
> > +linux-*)
> > +	apt update -q &&
> > +	apt install -q -y sudo git make language-pack-is libsvn-perl apache2 =
libssl-dev \
> > +		libcurl4-openssl-dev libexpat-dev tcl tk gettext zlib1g-dev \
> > +		perl-modules liberror-perl libauthen-sasl-perl libemail-valid-perl \
> > +		libdbd-sqlite3-perl libio-socket-ssl-perl libnet-smtp-ssl-perl ${CC_=
PACKAGE:-${CC:-gcc}} \
> > +		apache2 cvs cvsps gnupg libcgi-pm-perl subversion
> > +	;;
> >  pedantic)
> >  	dnf -yq update >/dev/null &&
> >  	dnf -yq install make gcc findutils diffutils perl python3 gettext zli=
b-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
>=20
> ...
>=20
> > diff --git a/ci/lib.sh b/ci/lib.sh
> > index e14b1029fad..6e3d64004ec 100755
> > --- a/ci/lib.sh
> > +++ b/ci/lib.sh
> > @@ -208,6 +224,7 @@ then
> >  	cache_dir=3D"$HOME/test-cache/$SYSTEM_PHASENAME"
> > =20
> >  	GIT_TEST_OPTS=3D"--write-junit-xml"
> > +	JOBS=3D10
> >  elif test true =3D "$GITHUB_ACTIONS"
> >  then
> >  	CI_TYPE=3Dgithub-actions
>=20
> ...
>=20
> > -MAKEFLAGS=3D"$MAKEFLAGS --jobs=3D10"
> > -GIT_PROVE_OPTS=3D"--timer --jobs 10 --state=3Dfailed,slow,save"
> > +MAKEFLAGS=3D"$MAKEFLAGS --jobs=3D${JOBS}"
> > +GIT_PROVE_OPTS=3D"--timer --jobs ${JOBS} --state=3Dfailed,slow,save"
> > =20
>=20
> Organizationally, this commit seems to be doing two things at once:
>=20
> - Adding GitLab-specific CI setup (either in the new .gitlab-ci.yml or in
>   conditions gated on "gitlab-ci").
> - Updating the common CI scripts with things that are needed for GitLab C=
I,
>   but aren't conditioned on it (i.e. the patch excerpts I've included
>   above).=20
>=20
> I'd prefer these being separated into two patches, mainly to isolate "thi=
ngs
> that affect all CI" from "things that affect only GitLab CI". This is
> ultimately a pretty minor nit, though; if you're not planning on re-rolli=
ng
> (or just disagree with what I'm suggesting :) ), I'm okay with leaving it
> as-is.

Yeah, the JOBS refactoring can certainly be split out into a preparatory
commit where we unify the envvars (currently patch 5). But for the other
changes it makes a bit less sense to do so, in my opinion:

    - The DEBIAN_FRONTEND variable isn't needed before as the there are
      no Docker-based CI jobs that use apt.

    - Adding the shadow and sudo packages to the linux-musl job wouldn't
      be needed either as there are no cases yet where we run
      unprivileged CI builds via Docker.

    - Adding the apt packages as a preparatory step doesn't make much
      sense either as there is no Docker job using it.

But anyway. I will:

    - Move around the JOBS variable refactoring to a preparatory patch,
      which feels sensible to me.

    - Move the `DEBIAN_FRONTEND` varible into the "linux-*" case, which
      should further clarify that this only impacts the newly added and
      thus GitLab-specific infrastructure.

With these changes, the only thing left in this commit that is not
guarded by a GitLab CI specific condition is the change to the
"linux-musl" case where we install shadow and sudo now. But I don't feel
like it makes sense to move them into a standalone preparatory commit.

Thanks!

Patrick

> Otherwise, I can't comment on the correctness of the GitLab CI definition=
 (I
> assume you've tested it anyway), but AFAICT the changes above shouldn't b=
reak
> GitHub CI.


--ACslhabbD2e9DmaD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVCOjUACgkQVbJhu7ck
PpSJYBAApxJFuHzKhX01pppMVX2I4nc0SpRe2t8cvjMKQuNuXViA78CWpqZNZskB
7JHOIZqDRNC057qWqennj+BEvIQ+hbLeH7dWicVrc3b9wcQ//lixqc/rgXmN4bAC
vlXigJytxgNpVsUkAe1rou+vsUw79993CHl/Vz7Js89U+c9kqLic0IwrTd0y/TdN
8vrThRVevyjm+LgzCUP3k3wVynmieTqL/N5buoHaWr9Xjqnp3GDZTSXuneuZJs3S
WR8Zs4IqluVSDJixAOSYWQzItkYoDoBb0APUGN2gavToUjNTNqA4J98hGJIh72zF
jYQZZ7BT/mgD0c7rllC/KUgzOQdRBLToVJUwCnBwNHG0Kj5yHjQJ8oVmTHzcfFjy
W70dD/Oc7/XUfrQVfLqWppbkgTfAzdiIWdpinrTM8F/CjxbetTTin6GvFVW3qcQR
GPfWhRul0+pH2G0UPqt4G+gblUsecxeJvNLF/+SK54P3OvIHLacMbbrIUfwAs10D
yQVUIA/od9OzbbgAw4QOtY/QvHl6p7JXeEH4hwjWPxO/tM5Tlu3uBVtsjGzn3qyR
zI96na5AQ/G0vvqOd2f0KI+cZAyAZAeiasa1iDV/H/nXR2b3SVef9b6S/OQo6Mpu
HZke8ONuFboYz+WYe7qig2UiG7xF6B9jtZPSQXlRzQH5NmG7LuQ=
=c0cO
-----END PGP SIGNATURE-----

--ACslhabbD2e9DmaD--
