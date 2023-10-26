Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58B72AB25
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 09:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qKTfoTiJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EVcqXWQ/"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733CA198
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 02:56:22 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id A777A3200928;
	Thu, 26 Oct 2023 05:56:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 26 Oct 2023 05:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698314181; x=1698400581; bh=9c
	4c/7icKmNlxtu0X5KNzkJUCBDDS9uS2Ebz6WAPPII=; b=qKTfoTiJLJGWJpNQvp
	pbbPhzvR4iw9mKbsvRcZ66FT0kdCa15McDaflV5rUAo6p8hihoWphK7vvslE24Me
	53RhpMyg6vxSNIfahvTWMq14AGUxZ3SMdf4VhCUUdTjhAKNisH87iw6PYe2Swd6b
	KuG1jDqf8huMroWFKauvwggI5z7tYj0mZqwWIQ4/MYd1cXdAMJZXBs23pbATjfnl
	Km2IkPAPqhmcSBrmGg2VgZzEl03zsjV+GYJHQ70xBCKf2qt5xroI+CQiEJd0bbW+
	i1RZtntvoGMGctert+ceWIU5JPH5FyFhGc4mbOjVD2Brl0YTyF4+Wuz+wFo2gQWu
	pCwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698314181; x=1698400581; bh=9c4c/7icKmNlx
	tu0X5KNzkJUCBDDS9uS2Ebz6WAPPII=; b=EVcqXWQ/yWQeVyzV1vx2mVvB+gysb
	KNxJLHhdaTfk0gd5UiUdXEjtor7Yt/EzjYhkyo1gv54qJVb4MksbpHtMhK47pBjB
	DLEMvpM8VqS0Xvf43O1WPWOjcwreCo6+F13TfWg1YjHRdUJUBYLsX9B4gy7qiBBp
	QFZQxy8fPOsmO89Q8BHaq/OM1j5Iw80+wHVVpSmPlEy60LxGmHl35IBFPIHIT3ty
	USNO5wIdhZaO0gZJu5IJFVQNR+U+dxibGxO+LVd0VtLuepdJ9akKQ1FGEW1YDHgF
	Cc8lY5NN23hdv1Xk9T3doQpYHd+4J5g0YLD3b2u7wdK/bS5OwwR2VIuQQ==
X-ME-Sender: <xms:xTc6Za2uaY2ciAxFCRjBV0z8K-087po7spa9n13_Eg12d4UnjIAaEw>
    <xme:xTc6ZdHpYH5g-VbpiblI2ZR0Q67OU2y0K0qVCtsAzug0CYWKsBPah1kxfo4A4EoV2
    EHtDmKmFKooHWoDjQ>
X-ME-Received: <xmr:xTc6ZS6sYaNUu5BhE8v4n-UXStqX7WtmCQXO8dIbIHhVxjJ1vr-dt8-dvGnf87Z9GPYdOlgFVfo_Wc8WnRr2ZvqxpkLEch7mJPR1i5tRQd8eUUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledvgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:xTc6Zb0PkzTPjONEQhcAxERWad8LzvnnW2SHNGHo6jU4lBk2HwYBBA>
    <xmx:xTc6ZdFFQScAZyf1CVw_ux9-IH_K0HtRizUpBVNxhP0sjSZr2TsfRg>
    <xmx:xTc6ZU8cF3fagfL1HaOvPLF63ueYy4jj7_eKSlYWrf0lsyYIWXAXDg>
    <xmx:xTc6ZSTcxjw0QROHfXseNU9kXCrMWOWXa59FOJTMg0I2jET8IjAlHw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Oct 2023 05:56:20 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bbb56984 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Oct 2023 09:56:10 +0000 (UTC)
Date: Thu, 26 Oct 2023 11:56:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v2 00/12] show-ref: introduce mode to check for ref existence
Message-ID: <cover.1698314128.git.ps@pks.im>
References: <cover.1698152926.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V9kA/qz4KxwEldXr"
Content-Disposition: inline
In-Reply-To: <cover.1698152926.git.ps@pks.im>


--V9kA/qz4KxwEldXr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that introduces a new `git
show-ref --exists` mode to check for reference existence.

Changes compared to v1:

    - Various typo fixes in commit messages.

    - Stopped using non-constant designated initializers.

    - Renamed a varible from `matchlen` to `patternlen` to match another
      renamed variable better.

    - Improved the error message for mutually exclusive modes to be
      easier to handle for translators.

    - "--quiet" is not advertised for the pattern-based mode of
      git-show-ref(1) anymore.

    - Rephrased "error code" to "exit code" in the documentation.

Thanks for the feedback so far!

Patrick

Patrick Steinhardt (12):
  builtin/show-ref: convert pattern to a local variable
  builtin/show-ref: split up different subcommands
  builtin/show-ref: fix leaking string buffer
  builtin/show-ref: fix dead code when passing patterns
  builtin/show-ref: refactor `--exclude-existing` options
  builtin/show-ref: stop using global variable to count matches
  builtin/show-ref: stop using global vars for `show_one()`
  builtin/show-ref: refactor options for patterns subcommand
  builtin/show-ref: ensure mutual exclusiveness of subcommands
  builtin/show-ref: explicitly spell out different modes in synopsis
  builtin/show-ref: add new mode to check for reference existence
  t: use git-show-ref(1) to check for ref existence

 Documentation/git-show-ref.txt |  20 ++-
 builtin/show-ref.c             | 280 ++++++++++++++++++++++-----------
 t/t1403-show-ref.sh            |  70 +++++++++
 t/t1430-bad-ref-name.sh        |  27 ++--
 t/t3200-branch.sh              |  33 ++--
 t/t5521-pull-options.sh        |   4 +-
 t/t5605-clone-local.sh         |   2 +-
 t/test-lib-functions.sh        |  55 +++++++
 8 files changed, 369 insertions(+), 122 deletions(-)

Range-diff against v1:
 1:  78163accbd2 =3D  1:  78163accbd2 builtin/show-ref: convert pattern to =
a local variable
 2:  7e6ab5dee23 !  2:  9a234622d99 builtin/show-ref: split up different su=
bcommands
    @@ builtin/show-ref.c: static int exclude_existing(const char *match)
     +
     +static int cmd_show_ref__patterns(const char **patterns)
     +{
    -+	struct show_ref_data show_ref_data =3D {
    -+		.patterns =3D (patterns && *patterns) ? patterns : NULL,
    -+	};
    ++	struct show_ref_data show_ref_data =3D {0};
    ++
    ++	if (patterns && *patterns)
    ++		show_ref_data.patterns =3D patterns;
     +
     +	if (show_head)
     +		head_ref(show_ref, &show_ref_data);
 3:  ae2e401fbd8 =3D  3:  bb0d656a0b4 builtin/show-ref: fix leaking string =
buffer
 4:  29c0c0c6c97 !  4:  87afcee830c builtin/show-ref: fix dead code when pa=
ssing patterns
    @@ Commit message
         builtin/show-ref: fix dead code when passing patterns
    =20
         When passing patterns to `git show-ref` we have some code that will
    -    cause us to die of `verify && !quiet` is true. But because `verify`
    +    cause us to die if `verify && !quiet` is true. But because `verify`
         indicates a different subcommand of git-show-ref(1) that causes us=
 to
         execute `cmd_show_ref__verify()` and not `cmd_show_ref__patterns()=
`, the
         condition cannot ever be true.
 5:  8d0b0b5700c !  5:  bed2a8a0769 builtin/show-ref: refactor `--exclude-e=
xisting` options
    @@ Commit message
         builtin/show-ref: refactor `--exclude-existing` options
    =20
         It's not immediately obvious options which options are applicable =
to
    -    what subcommand ni git-show-ref(1) because all options exist as gl=
obal
    +    what subcommand in git-show-ref(1) because all options exist as gl=
obal
         state. This can easily cause confusion for the reader.
    =20
         Refactor options for the `--exclude-existing` subcommand to be con=
tained
         in a separate structure. This structure is stored on the stack and
    -    passed down as required. Consequentially, it clearly delimits the =
scope
    -    of those options and requires the reader to worry less about global
    -    state.
    +    passed down as required. Consequently, it clearly delimits the sco=
pe of
    +    those options and requires the reader to worry less about global s=
tate.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    @@ builtin/show-ref.c: static int add_existing(const char *refname,
      	struct string_list existing_refs =3D STRING_LIST_INIT_DUP;
      	char buf[1024];
     -	int matchlen =3D match ? strlen(match) : 0;
    -+	int matchlen =3D opts->pattern ? strlen(opts->pattern) : 0;
    ++	int patternlen =3D opts->pattern ? strlen(opts->pattern) : 0;
     =20
      	for_each_ref(add_existing, &existing_refs);
      	while (fgets(buf, sizeof(buf), stdin)) {
    @@ builtin/show-ref.c: static int cmd_show_ref__exclude_existing(const =
char *match)
     -		if (match) {
     +		if (opts->pattern) {
      			int reflen =3D buf + len - ref;
    - 			if (reflen < matchlen)
    +-			if (reflen < matchlen)
    ++			if (reflen < patternlen)
      				continue;
     -			if (strncmp(ref, match, matchlen))
    -+			if (strncmp(ref, opts->pattern, matchlen))
    ++			if (strncmp(ref, opts->pattern, patternlen))
      				continue;
      		}
      		if (check_refname_format(ref, 0)) {
 6:  6e0f3d4e104 =3D  6:  d52a5e8ced2 builtin/show-ref: stop using global v=
ariable to count matches
 7:  2da1e65dd8f !  7:  63f1dadf4c2 builtin/show-ref: stop using global var=
s for `show_one()`
    @@ builtin/show-ref.c: static int cmd_show_ref__verify(const char **ref=
s)
     +static int cmd_show_ref__patterns(const struct show_one_options *show=
_one_opts,
     +				  const char **patterns)
      {
    - 	struct show_ref_data show_ref_data =3D {
    +-	struct show_ref_data show_ref_data =3D {0};
    ++	struct show_ref_data show_ref_data =3D {
     +		.show_one_opts =3D show_one_opts,
    - 		.patterns =3D (patterns && *patterns) ? patterns : NULL,
    - 	};
    ++	};
     =20
    + 	if (patterns && *patterns)
    + 		show_ref_data.patterns =3D patterns;
     @@ builtin/show-ref.c: static int cmd_show_ref__patterns(const char **=
patterns)
     =20
      static int hash_callback(const struct option *opt, const char *arg, i=
nt unset)
 8:  805889eda4c !  8:  88dfeaa4871 builtin/show-ref: refactor options for =
patterns subcommand
    @@ builtin/show-ref.c: static int cmd_show_ref__verify(const struct sho=
w_one_option
      	struct show_ref_data show_ref_data =3D {
      		.show_one_opts =3D show_one_opts,
     +		.show_head =3D opts->show_head,
    - 		.patterns =3D (patterns && *patterns) ? patterns : NULL,
      	};
     =20
    + 	if (patterns && *patterns)
    + 		show_ref_data.patterns =3D patterns;
    +=20
     -	if (show_head)
     +	if (opts->show_head)
      		head_ref(show_ref, &show_ref_data);
 9:  d0a991cf4f8 !  9:  5ba566723e8 builtin/show-ref: ensure mutual exclusi=
veness of subcommands
    @@ builtin/show-ref.c: int cmd_show_ref(int argc, const char **argv, co=
nst char *pr
      			     show_ref_usage, 0);
     =20
     +	if ((!!exclude_existing_opts.enabled + !!verify) > 1)
    -+		die(_("only one of --exclude-existing or --verify can be given"));
    ++		die(_("only one of '%s' or '%s' can be given"),
    ++		    "--exclude-existing", "--verify");
     +
      	if (exclude_existing_opts.enabled)
      		return cmd_show_ref__exclude_existing(&exclude_existing_opts);
    @@ t/t1403-show-ref.sh: test_expect_success 'show-ref --verify with dan=
gling ref' '
     =20
     +test_expect_success 'show-ref sub-modes are mutually exclusive' '
     +	test_must_fail git show-ref --verify --exclude-existing 2>err &&
    -+	grep "only one of --exclude-existing or --verify can be given" err
    ++	grep "only one of ${SQ}--exclude-existing${SQ} or ${SQ}--verify${SQ}=
 can be given" err
     +'
     +
      test_done
10:  adcfa7a6a9d ! 10:  b78ccc5f692 builtin/show-ref: explicitly spell out =
different modes in synopsis
    @@ Commit message
         Split up the synopsis for these two modes such that we can disambi=
guate
         those differences.
    =20
    +    While at it, drop "--quiet" from the pattern mode's synopsis. It d=
oes
    +    not make a lot of sense to list patterns, but squelch the listing =
output
    +    itself. The description for "--quiet" is adapted accordingly.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## Documentation/git-show-ref.txt ##
    @@ Documentation/git-show-ref.txt: git-show-ref - List references in a =
local reposi
      --------
      [verse]
     -'git show-ref' [-q | --quiet] [--verify] [--head] [-d | --dereference]
    -+'git show-ref' [-q | --quiet] [--head] [-d | --dereference]
    ++'git show-ref' [--head] [-d | --dereference]
      	     [-s | --hash[=3D<n>]] [--abbrev[=3D<n>]] [--tags]
      	     [--heads] [--] [<pattern>...]
     +'git show-ref' --verify [-q | --quiet] [-d | --dereference]
    @@ Documentation/git-show-ref.txt: git-show-ref - List references in a =
local reposi
      'git show-ref' --exclude-existing[=3D<pattern>]
     =20
      DESCRIPTION
    +@@ Documentation/git-show-ref.txt: OPTIONS
    + -q::
    + --quiet::
    +=20
    +-	Do not print any results to stdout. When combined with `--verify`, t=
his
    +-	can be used to silently check if a reference exists.
    ++	Do not print any results to stdout. Can be used with `--verify` to
    ++	silently check if a reference exists.
    +=20
    + --exclude-existing[=3D<pattern>]::
    +=20
    =20
      ## builtin/show-ref.c ##
     @@
    @@ builtin/show-ref.c
     =20
      static const char * const show_ref_usage[] =3D {
     -	N_("git show-ref [-q | --quiet] [--verify] [--head] [-d | --derefere=
nce]\n"
    -+	N_("git show-ref [-q | --quiet] [--head] [-d | --dereference]\n"
    ++	N_("git show-ref [--head] [-d | --dereference]\n"
      	   "             [-s | --hash[=3D<n>]] [--abbrev[=3D<n>]] [--tags]\n"
      	   "             [--heads] [--] [<pattern>...]"),
     +	N_("git show-ref --verify [-q | --quiet] [-d | --dereference]\n"
11:  2f876e61dd3 ! 11:  327942b1162 builtin/show-ref: add new mode to check=
 for reference existence
    @@ Commit message
    =20
             - Dangling symrefs can be resolved via git-symbolic-ref(1), bu=
t this
               requires the caller to special case existence checks dependi=
ng on
    -          whteher or not a reference is symbolic or direct.
    +          whether or not a reference is symbolic or direct.
    =20
         Furthermore, git-rev-list(1) and other commands do not let the cal=
ler
         distinguish easily between an actually missing reference and a gen=
eric
         error.
    =20
    -    Taken together, this gseems like sufficient motivation to introduc=
e a
    +    Taken together, this seems like sufficient motivation to introduce=
 a
         separate plumbing command to explicitly check for the existence of=
 a
         reference without trying to resolve its contents.
    =20
         This new command comes in the form of `git show-ref --exists`. This
         new mode will exit successfully when the reference exists, with a
    -    specific error code of 2 when it does not exist, or with 1 when th=
ere
    +    specific exit code of 2 when it does not exist, or with 1 when the=
re
         has been a generic error.
    =20
         Note that the only way to properly implement this command is by us=
ing
    @@ Documentation/git-show-ref.txt: OPTIONS
     =20
     +--exists::
     +
    -+	Check whether the given reference exists. Returns an error code of 0=
 if
    -+	it does, 2 if it is missing, and 128 in case looking up the reference
    ++	Check whether the given reference exists. Returns an exit code of 0 =
if
    ++	it does, 2 if it is missing, and 1 in case looking up the reference
     +	failed with an error other than the reference being missing.
     +
      --abbrev[=3D<n>]::
    @@ builtin/show-ref.c: static int cmd_show_ref__patterns(const struct p=
atterns_opti
     +	unsigned int unused_type;
     +	int failure_errno =3D 0;
     +	const char *ref;
    -+	int ret =3D 1;
    ++	int ret =3D 0;
     +
     +	if (!refs || !*refs)
     +		die("--exists requires a reference");
    @@ builtin/show-ref.c: static int cmd_show_ref__patterns(const struct p=
atterns_opti
     +			error(_("reference does not exist"));
     +			ret =3D 2;
     +		} else {
    -+			error(_("failed to look up reference: %s"), strerror(failure_errno=
));
    ++			errno =3D failure_errno;
    ++			error_errno(_("failed to look up reference"));
    ++			ret =3D 1;
     +		}
     +
     +		goto out;
     +	}
     +
    -+	ret =3D 0;
    -+
     +out:
     +	strbuf_release(&unused_referent);
     +	return ret;
    @@ builtin/show-ref.c: int cmd_show_ref(int argc, const char **argv, co=
nst char *pr
      			     show_ref_usage, 0);
     =20
     -	if ((!!exclude_existing_opts.enabled + !!verify) > 1)
    --		die(_("only one of --exclude-existing or --verify can be given"));
    +-		die(_("only one of '%s' or '%s' can be given"),
    +-		    "--exclude-existing", "--verify");
     +	if ((!!exclude_existing_opts.enabled + !!verify + !!exists) > 1)
    -+		die(_("only one of --exclude-existing, --exists or --verify can be =
given"));
    ++		die(_("only one of '%s', '%s' or '%s' can be given"),
    ++		    "--exclude-existing", "--verify", "--exists");
     =20
      	if (exclude_existing_opts.enabled)
      		return cmd_show_ref__exclude_existing(&exclude_existing_opts);
    @@ t/t1403-show-ref.sh: test_expect_success 'show-ref --verify with dan=
gling ref' '
     =20
      test_expect_success 'show-ref sub-modes are mutually exclusive' '
     +	cat >expect <<-EOF &&
    -+	fatal: only one of --exclude-existing, --exists or --verify can be g=
iven
    ++	fatal: only one of ${SQ}--exclude-existing${SQ}, ${SQ}--verify${SQ} =
or ${SQ}--exists${SQ} can be given
     +	EOF
     +
      	test_must_fail git show-ref --verify --exclude-existing 2>err &&
    --	grep "only one of --exclude-existing or --verify can be given" err
    +-	grep "only one of ${SQ}--exclude-existing${SQ} or ${SQ}--verify${SQ}=
 can be given" err
     +	test_cmp expect err &&
     +
     +	test_must_fail git show-ref --verify --exists 2>err &&
12:  a3a43d82e1f =3D 12:  226731c5f18 t: use git-show-ref(1) to check for r=
ef existence

base-commit: a9ecda2788e229afc9b611acaa26d0d9d4da53ed
--=20
2.42.0


--V9kA/qz4KxwEldXr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU6N8AACgkQVbJhu7ck
PpT0rQ//XlzzXfjQqEIMNJK5MVPjUjnwu/Vk+LKeeivpqim8AkVz7I+2CfT2ZwNn
rYZVl0zfuBMGogV/5jgjfNTEyty4Ld/wnGoLrc/ag18qLUllz48/uPAEN4Fh3UwE
vj7Nps4ans+l1RyRuYjvPxcAS7DgixtRbqLsuuIv6n/5TjG2ahI2Wcg/wr5tmrsc
6hpsNSAfNmEie6JUeugr7QkR+Sku6poP6ohaWR2p3ojV3K+rFCf3cn6i7bmSI3Aw
yHxgl8IqTOH3K/27VySehUmtsemh+l+mh0lV+VKVx0TJi2x84OyobCKrDHyvdLAb
LwELnKBcZbA9kj7dnt89ivOjfZ6THwPllv53l/XDW7nqjimu+j2mg5z+CU848fWK
AFbK0AwmVUKN1q04lHsw+MeMLZYza3Dwj32RzY5gOhhfKYbtKBKWTSeGUvHqkqpX
EcWWCfgdZr+jkww4hzl3l+BUu+BhN993aWQtUwh19SlUnBbspZiuRpbFAQRVASKH
cYCfcK/t0v6D5+V5kprO7MeY3Ze9SV9++0pfTckDLZ4rTdOtOLEAXIqEnT3NAblP
UG6HjZgrPqpUt+b2ZtXsnI+2TROy17fBiYU+hOX2K8K5fyVFcrZ7h3dTGePQSscP
LW3JKq1SJSUAf2K2dtLdUBJ2+vhCkDQMj/uzYisIGWQMVQMP9Rk=
=vPfW
-----END PGP SIGNATURE-----

--V9kA/qz4KxwEldXr--
