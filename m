Received: from cyborg.thican.net (cyborg.thican.net [94.23.45.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E272BDC26
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 21:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.23.45.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775337029; cv=none; b=qUS+vg7OfFWqv4zjgiQcBKoQ/I9W1tC2MX/zVQAsgsuQ4LNFkDg3hH3jbi5QE6a/HQEPfKobAW5PH426pY+eEkF2l0H9B6inFmuk5SluLg8N3ECcz4YppNr38WoixtJpx3g41bYmYgX8ptujTv5fHmyHa1bpHlZyB0TVtsFpRmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775337029; c=relaxed/simple;
	bh=6Nq7nFosnxnpqUocLFfvhOLnE29Rz9wCm49uiUURQfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EO5Z/haCofTkXbwUwbuWMpTB7bTX9Lpn8hcKyCJ15jUVUleyybMEM3mVw7hwpKEbbcJNM49Vj/0OmWp5D4X3nWJS4mzPJAWhbHmuF3NKCkRs5XODiexsbDv7yB435j0sfLbHHKpTtKxBRVBrpwf/r5iCwyW6c5PwuTkW3ezjS3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thican.net; spf=pass smtp.mailfrom=thican.net; dkim=pass (2048-bit key) header.d=thican.net header.i=@thican.net header.b=F49rPIc0; arc=none smtp.client-ip=94.23.45.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thican.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thican.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thican.net header.i=@thican.net header.b="F49rPIc0"
Received: by cyborg.thican.net (Postfix, from userid 1000)
	id 495B8818076; Sat, 04 Apr 2026 23:10:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=thican.net; s=cyborg;
	t=1775337025; bh=6Nq7nFosnxnpqUocLFfvhOLnE29Rz9wCm49uiUURQfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F49rPIc0xcL9D/Rsytitrok5tVRocf/QDNTWH8k9lxtkdVFhqhHiJdydBRNNT0BdF
	 uNN9VXhzkzf4t3WD8Eo7s4FCxQBKEziSm7+ELFgw+xdLfwtInTlm6KBPd90p9u4hlX
	 ojDl5TGUMKmEPOwBU9zROIOmaSaOyu5940Rz1ZaYMfPchUeW4RNMF1xN+ipwm1qu9/
	 eYPTeg0Mo2487GMhXtkbKTJoFbsA9PLjlIZ69fnWuPSWVrBIdgNdTDDU3skmLSWBTY
	 3yv/c35tK1I/5IdcDZMSs45xLNhfUwWcMnBk2DKzC0wKEfxzXFU0JxRc1Oiaguhqae
	 uKpnadbxRsn9Q==
Date: Sat, 4 Apr 2026 23:10:25 +0200
From: Thibaud CANALE <thican@thican.net>
To: Pablo <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH] switch: provide configurable detach
Message-ID: <4gpvxpm335bvnml57ks5zbfyzd5pzp6jheebvytsobmlffpllg@6ddpoiruhgh6>
References: <njuf62lav6akkmdyqutwk7pim5yutw5cuicjidwpe5eh6qnkqr@4ir6q4uhhvht>
 <CAN5EUNR6x_HWQKrMMHcHj0hF+D_6QBiw782_QGA8E8SS7Q3pcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3vfavvfmdesy55dt"
Content-Disposition: inline
In-Reply-To: <CAN5EUNR6x_HWQKrMMHcHj0hF+D_6QBiw782_QGA8E8SS7Q3pcg@mail.gmail.com>


--3vfavvfmdesy55dt
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH] switch: provide configurable detach
MIME-Version: 1.0

On Saturday 2026-04-04 17:23:46+0200, Pablo <pabloosabaterr@gmail.com> wrot=
e:
> El s=C3=A1b, 4 abr 2026 a las 16:36, Thibaud CANALE (<thican@thican.net>)=
 escribi=C3=B3:
>=20
> Hi Thibaud,

Hello,

> > Its purpose is to provide for git-switch(1) same detach behavior on
> > commit it than git-checkout(1) through configuration option
> > `checkout.switchDetach`.
>=20
> The commit needs some work, following Documentation/SubmittingPatches:
> The subject looks fine but the body, you should write imperatively, somet=
hing
> like "Allow git-switch to..." instead of "Its purpose is to...".

It was a (almost) copy of the message I wrote in the documentation, I
wanted to avoid giving different and possibly confusing explanations
between the two of them. I just noticed the typo on "commit it".
By the way, is "commit id" correct for constructs such as "${branch}~x" or
"${commit_id}~y", or is there a better word for this?

> >  same detach behavior on commit it than
>=20
> This is confusing.
>=20
> Also the body should explain WHY this change would be wanted.

May you tell me what you find confusing? I don=E2=80=99t see what else I can
explain without over-explaining.

Maybe I can provide a real case example:
Using `git checkout my_branch~2` works and automatically detach on the
2nd parent of the top commit of branch "my_branch", but the same
argument with `git switch` does not.
The command `git switch -` also does not work if the previous step was
a detached commit while `git checkout -` can move back and forth
between detached mode and branch.

About why force_detach flag is necessary, read below.

About why this feature, I know some users won=E2=80=99t change to switch/re=
store
commands and keep relying on checkout command because of this =E2=80=9Cmiss=
ing=E2=80=9D
feature, as its =E2=80=9Cdisrupts=E2=80=9D their workflow (humans, =E2=80=
=99am I right?).

> >
> > Signed-off-by: Thibaud CANALE <thican@thican.net>
> > ---
> >  Documentation/config/checkout.adoc |  4 ++++
> >  builtin/checkout.c                 | 18 +++++++++++++++---
> >  t/t2060-switch.sh                  | 27 +++++++++++++++++++++++++++
> >  3 files changed, 46 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/config/checkout.adoc b/Documentation/config/=
checkout.adoc
> > index e35d2129..3a6c1049 100644
> > --- a/Documentation/config/checkout.adoc
> > +++ b/Documentation/config/checkout.adoc
> > @@ -22,6 +22,10 @@ commands or functionality in the future.
> >         option in `git checkout` and `git switch`. See
> >         linkgit:git-switch[1] and linkgit:git-checkout[1].
> >
> > +`checkout.switchDetach`::
> > +       Provides for linkgit:git-switch[1] the same detach behavior on =
commit id
> > +       than linkgit:git-checkout[1] without the explicit --detach opti=
on.
> > +
>=20
> I think it would be better to describe how it would be if set rather
> than directly
> the what it does. e.g.:
> "If set, detaches HEAD when..."

Rewritten with details and example.

> >  `checkout.workers`::
> >         The number of parallel workers to use when updating the working=
 tree.
> >         The default is one, i.e. sequential execution. If set to a valu=
e less
> > diff --git a/builtin/checkout.c b/builtin/checkout.c
> > index e031e618..1da1062e 100644
> > --- a/builtin/checkout.c
> > +++ b/builtin/checkout.c
> > @@ -53,6 +53,7 @@ struct checkout_opts {
> >         int force;
> >         int force_detach;
> >         int implicit_detach;
> > +       int switch_detach;  // For checkout.switchDetach configuration
>=20
> // coments are not used in Git, if you need to add comments make them with
> /* */.
> Nit I don't think a comment here is necessary, it is very self
> explanatory already.

I agree, I originally didn=E2=80=99t, I thought we could tell me to describ=
e it
here to avoid looking for explanation somewhere else.

> >         int writeout_stage;
> >         int overwrite_ignore;
> >         int ignore_skipworktree;
> > @@ -1005,7 +1006,10 @@ static void update_refs_for_switch(const struct =
checkout_opts *opts,
> >         else
> >                 strbuf_insertstr(&msg, 0, reflog_msg);
> >
> > -       if (!strcmp(new_branch_info->name, "HEAD") && !new_branch_info-=
>path && !opts->force_detach) {
> > +       if (!strcmp(new_branch_info->name, "HEAD") &&
> > +           !new_branch_info->path &&
> > +           !opts->force_detach &&
> > +           !opts->switch_detach) {
>=20
> seems that you're checking force_detach and switch_detach together
> every time,they look very similar,
> sure  you need them separated?

Not every time.
There is cases where switch_detach is not used such as using a branch.

> >                 /* Nothing to do. */
> >         } else if (opts->force_detach || !new_branch_info->path) {     =
 /* No longer on any branch. */
> >                 refs_update_ref(get_main_ref_store(the_repository), msg=
=2Ebuf,
> > @@ -1014,7 +1018,9 @@ static void update_refs_for_switch(const struct c=
heckout_opts *opts,
> >                                 REF_NO_DEREF, UPDATE_REFS_DIE_ON_ERR);
> >                 if (!opts->quiet) {
> >                         if (old_branch_info->path &&
> > -                           advice_enabled(ADVICE_DETACHED_HEAD) && !op=
ts->force_detach)
> > +                           advice_enabled(ADVICE_DETACHED_HEAD) &&
> > +                           !opts->force_detach &&
> > +                           !opts->switch_detach)
> >                                 detach_advice(new_branch_info->name);
> >                         describe_detached_head(_("HEAD is now at"), new=
_branch_info->commit);
> >                 }
> > @@ -1541,8 +1547,11 @@ static void die_expecting_a_branch(const struct =
branch_info *branch_info)
> >                  */
> >                 code =3D die_message(_("a branch is expected, got '%s'"=
), branch_info->name);
> >
> > -       if (advice_enabled(ADVICE_SUGGEST_DETACHING_HEAD))
> > +       if (advice_enabled(ADVICE_SUGGEST_DETACHING_HEAD)) {
> >                 advise(_("If you want to detach HEAD at the commit, try=
 again with the --detach option."));
> > +               advise(_("Also you can detach by default by setting the=
 config variable "
> > +                        "checkout.switchDetach to true."));
> > +       }
>=20
> Nit "Also, you can..." or "You can also..."

As you prefer.

> >
> >         exit(code);
> >  }
> > @@ -1660,6 +1669,7 @@ static int checkout_branch(struct checkout_opts *=
opts,
> >
> >         if (!opts->implicit_detach &&
> >             !opts->force_detach &&
> > +           !opts->switch_detach &&
>=20
> Again force_detach + switch_detach
>=20
> >             !opts->new_branch &&
> >             !opts->new_branch_force &&
> >             new_branch_info->name &&
> > @@ -2119,6 +2129,8 @@ int cmd_switch(int argc,
> >         options =3D add_common_options(&opts, options);
> >         options =3D add_common_switch_branch_options(&opts, options);
> >
> > +       repo_config_get_bool(the_repository, "checkout.switchDetach", &=
opts.switch_detach);
> > +
> >         cb_option =3D 'c';
> >
> >         return checkout_main(argc, argv, prefix, &opts, options,
> > diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
> > index c91c4db9..3435ae98 100755
> > --- a/t/t2060-switch.sh
> > +++ b/t/t2060-switch.sh
> > @@ -177,4 +177,31 @@ test_expect_success 'switch back when temporarily =
detached and checked out elsew
> >         git -C wt2 switch --ignore-other-worktrees shared
> >  '
> >
> > +test_expect_success 'switch with configured detach behavior from confi=
guration ' '
>=20
> Trailing space here at the end, also the title is kinda confusing with the
> configured + configuration, what about:
> "switch detaches on commit when switchDetach is set"

For the trailing space I was mislead by the previous test, line 149; it
has its trailing space, I thought it was mandatory somehow.
Thank you for the rewording.

> > +       test_when_finished "
> > +               test_config checkout.switchDetach false;
> > +               git switch main
> > +       " &&
> > +       test_config checkout.switchDetach true &&
> > +       git switch main &&
> > +       git symbolic-ref HEAD &&
> > +       git switch main~ &&
> > +       test_must_fail git symbolic-ref HEAD &&
> > +       git switch - &&
> > +       git symbolic-ref HEAD &&
> > +       git switch - &&
> > +       test_must_fail git symbolic-ref HEAD
> > +'
> > +
> > +test_expect_success 'switch without configured detach behavior from co=
nfiguration ' '
>=20
> Trailing space.
>=20
> > +       test_when_finished "
> > +               test_config checkout.switchDetach false;
>=20
> test_config already has test_when_finished
> I would git config --unset.

ACK.

> > +               git switch main
> > +       " &&
> > +       test_config checkout.switchDetach false &&
>=20
> This is already false.

I prefer to be explicit, to test the case where the user disables this
feature on purpose.

> > +       git switch main &&
> > +       git symbolic-ref HEAD &&
> > +       test_must_fail git switch main~
> > +'
> > +
> >  test_done
> >
> > base-commit: 2855562ca6a9c6b0e7bc780b050c1e83c9fcfbd0
> > --
> > Thibaud CANALE
> > thican [at] thican [dot] net
> > https://thican.net/
> > GPG: rsa4096 2013-10-14 485EF628CB85CDD4CB7CFF0D52F5127650733A18
>=20
> Overall seems reasonable, it might be a design choice having to
> explicitly use --detach, force_detach it's pretty clear about it but
> I dunno.
>=20
> For now:
> I would rewrite the commit.
> Make sure that you need a new flag, force_detach looks very similar.
> Fix the style issue.

It was already sure a new flag was necessary, using force detach flag is
uncorrect as it will not anymore allow to use back a branch for example.
We can see this new flag is not everywhere force_detach is.
For testing, I tried only force_detach, the tests are failing.

V2 will follow shortly.

Best regards,


--=20
Thibaud CANALE
thican [at] thican [dot] net
https://thican.net/
GPG: rsa4096 2013-10-14 485EF628CB85CDD4CB7CFF0D52F5127650733A18

--3vfavvfmdesy55dt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEESF72KMuFzdTLfP8NUvUSdlBzOhgFAmnRfjwbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyAAoJEFL1EnZQczoYRskP/itfQNxIvZIekGyYBO1b
ATj2GF7ulxGFd5o7Ai2sZcwbbh+W0oNrDt1DFkXpLS1CIOqidE5XA5ymmrzmLC7X
7fsLx6GJqokphGQcZVpidnYlbQtNNcqfupdd6TJi8wy19RsIETdtAqbVQdsSyrON
g1Sx6rYX5Dnn/asy7ea3B4wYCU73yIN2Q3U2pETFyOjEUtXwnEzn39N0e49Rpusd
9LE1T6u0JT44FcvUNPl3Y9HiDCizbkByV+P4Lo/90prJk1HfJ+yJ07DlJnVPF4pP
XoUa1UTI3Smj7MOH2zswWKZ22DhVCRX+PBNCo3Z5OWhfEmr6v5PKToQ17sXRV1Jt
VDm0UF3pTVlEc5loSNa89qbTimOyeR1o2qjY5NSAM9LKbiGatN3Qt6BF3w0HmZ8l
IXwBDKaYf5yyNfuFM7i5C5xtIrfr/qlJ+7t/Gr6y9Bjm7SW7RlQb+OlxbnucDA6j
17Z7UrcDqRghr/ba0azpF7+wLDMcmdkuxXtuYuJv596aKPtPlNn+6AeyO4Hd4zX8
lWet6JjvF+WaqHun4gk9cxFqg8F4jLiq4NUz1q5NkiXO8S0HIDjbQTcokOx5OViV
4Xq2hPO5abbjVs3jRZ2asGs0KL/6aFYaawde0wCQA6FanbZMUp7xRdo8Fdyjs1JX
hZnFl5MmzqlEdF7wdk3jT1mv
=UpAQ
-----END PGP SIGNATURE-----

--3vfavvfmdesy55dt--
