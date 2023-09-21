Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA062E7D0A6
	for <git@archiver.kernel.org>; Thu, 21 Sep 2023 19:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjIUTjK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Sep 2023 15:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjIUTiy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2023 15:38:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F153EEE2B2
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 12:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695323511; x=1695928311; i=johannes.schindelin@gmx.de;
 bh=OgFpKZfl2a0tSUvFaEEcghZeQ6RohE31TdRQvE8Topc=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=U1KQv99VqcBA0Vb5Mbb3ZX0A3MCJ7cr/OIJfANsYeCuHjmWSDJGl6e+gj0Dmb/Ynfrls5oN8t9d
 0Mp6DCfkbKrSNfjTa+yetdzWzlFzMLiri9Z0Aoi0jpcMfPlwuy5WQtGnaEgK5IpIQ89+ZFZAh3b+o
 qC1pOfFEW+PBONo+STFxvvUcqP549ubS7ht9y5PGwbT0Sr4AVbzdknXU1E+DGh09jCJsunByEryIN
 6IjhzyjPbFWsnGsj2xRaUR09d/50hS9MNkGXIPEriWuHEdF05kgWkr7o0RKhaKNvyxlGCbirnZklY
 pHBkXA6whQLsNgF+P904yQKf95QvHfN0v5hw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([167.220.197.144]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MC34X-1qp2uW1bJ7-00CQkk; Thu, 21
 Sep 2023 14:30:37 +0200
Date:   Thu, 21 Sep 2023 14:30:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 1/1] range-diff: treat notes like `log`
In-Reply-To: <6e114271a2e7d2323193bd58bb307f60101942ce.1695154855.git.code@khaugsbakk.name>
Message-ID: <d9c73723-7489-0f4f-c899-eaa14dc4280c@gmx.de>
References: <cover.1695144790.git.code@khaugsbakk.name> <cover.1695154855.git.code@khaugsbakk.name> <6e114271a2e7d2323193bd58bb307f60101942ce.1695154855.git.code@khaugsbakk.name>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1750441375-1695299437=:750"
X-Provags-ID: V03:K1:QiZlsr7QEXmRFMPD6xWn0tcgqmYJpgZA5PaQyBwmDxgh5Vms72y
 qASwhB3qvqK19DaEMb4e1DrgHypL+i0jrVlsQu0EOnGdCZsIn974YJqemomzb5GiO5mtsww
 B6QP9qCrt0O02YnPQx9Etx5IyqtwrmKzWo66xaWqI71KW1nO+73XXvILQ+WKIamQDp9NaCt
 hopFjKNoGT0KCGz2Yp1nQ==
UI-OutboundReport: notjunk:1;M01:P0:IotEY//+SkA=;AtWdY8oOptO9k7DUMfl/OGotx/S
 PMsBdaaJA1zpvt5b7ydoD/QE0ipU6JMOd/vMKvBQXKjpEZc6q2B+UpxQI8/VsUgb9WS37qvEM
 kosw4xbHokUSsHCaSU7CPjRpfoL9tlWc1tx8uJB5bxNH0huIDq5ngoCVFTklOlX6wqwcTDoTH
 EcYOign5rRlZBUKiHLrIcJ/uaTJboyQBEmHljIvTl3IRTOKRFsGoUpEQwqAD44cDZtFUsZ0U4
 /YohfVl9xc8vNtoieL7lk/PUmOln94l771SMfb5zmchu7gyENva2TLCnE/vohoG9lkcjmHwot
 IdcxlfbC05fwfR1D9nAawPaAUPo1s18uP2dim5uGq2PZF3rbF1RBbTeHxsLaTjHjFuenzZB2E
 hmCW5uK2pJlPFUYuTQ5HpVXc7mjdn6WppWcINrca5XcMRoBKruiaO9BQOe2nRuydChcVyYnmm
 o85ntrJt5EG99fv855wDHpSh4Ul+v15yE64lfB/mI66abdU9InfjcM0RbXTE1rtVhDbllnxAX
 NjAs4m9vWfbkXXi2nOKw4OI4NhIP8c08V9xaAdlHGGgl876NjmcNU/7tHgq+OExjEHZqujCa7
 CdrAF5mOuP2adt/bzXHsBaNTsVu0++9Icu1hv7Gyxk3KLiMfDKFNL/I1lnJuhxdyuaBSuokHs
 IYilOnELJ5an2khKAz8EPBtmeg+voGYJ6iL+aIpE/EeAIWTk54YLERBWSnlVi8Ss0/EYCZ1WL
 2OWGhP2WTBHSQ0WagVj1LsuwU1wFTVLFnL0CFhURsjjQnbh6K0HxGlltTx4lG7a6wVfvmlwv2
 uia7Roks7huGrTZQpsXrz57B/UKpPZhmI4BdUdgaL6fdlvGyfsLH2ZkJLplICf7TF0EUPaHW1
 LMWAtumVN24ZaBx16f3uNLTE6DS/f5os7sRowYCSOHF+CTHHK2UQytMqkspLxbzpdBCWEu9Ok
 zsBYK+l5KtJGYZifZyY0cv7x0N4=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1750441375-1695299437=:750
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Kristoffer,

this iteration looks good to me!

Thank you so much,
Johannes

On Tue, 19 Sep 2023, Kristoffer Haugsbakk wrote:

> Currently, `range-diff` shows the default notes if no notes-related
> arguments are given. This is also how `log` behaves. But unlike
> `range-diff`, `log` does *not* show the default notes if
> `--notes=3D<custom>` are given. In other words, this:
>
>     git log --notes=3Dcustom
>
> is equivalent to this:
>
>     git log --no-notes --notes=3Dcustom
>
> While:
>
>     git range-diff --notes=3Dcustom
>
> acts like this:
>
>     git log --notes --notes-custom
>
> This can=E2=80=99t be how the user expects `range-diff` to behave given =
that the
> man page for `range-diff` under `--[no-]notes[=3D<ref>]` says:
>
> > This flag is passed to the `git log` program (see git-log(1)) that
> > generates the patches.
>
> This behavior also affects `format-patch` since it uses `range-diff` for
> the cover letter. Unlike `log`, though, `format-patch` is not supposed
> to show the default notes if no notes-related arguments are given.[1]
> But this promise is broken when the range-diff happens to have something
> to say about the changes to the default notes, since that will be shown
> in the cover letter.
>
> Remedy this by introducing `--show-notes-by-default` that `range-diff` c=
an
> use to tell the `log` subprocess what to do.
>
> =C2=A7 Authors
>
> =E2=80=A2 Fix by Johannes
> =E2=80=A2 Tests by Kristoffer
>
> =E2=80=A0 1: See e.g. 66b2ed09c2 (Fix "log" family not to be too agressi=
ve about
>     showing notes, 2010-01-20).
>
> Co-authored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>  Documentation/pretty-options.txt |  4 ++++
>  range-diff.c                     |  2 +-
>  revision.c                       |  7 +++++++
>  revision.h                       |  1 +
>  t/t3206-range-diff.sh            | 28 ++++++++++++++++++++++++++++
>  5 files changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-opt=
ions.txt
> index dc685be363a..335395b727f 100644
> --- a/Documentation/pretty-options.txt
> +++ b/Documentation/pretty-options.txt
> @@ -87,6 +87,10 @@ being displayed. Examples: "--notes=3Dfoo" will show =
only notes from
>  	"--notes --notes=3Dfoo --no-notes --notes=3Dbar" will only show notes
>  	from "refs/notes/bar".
>
> +--show-notes-by-default::
> +	Show the default notes unless options for displaying specific
> +	notes are given.
> +
>  --show-notes[=3D<ref>]::
>  --[no-]standard-notes::
>  	These options are deprecated. Use the above --notes/--no-notes
> diff --git a/range-diff.c b/range-diff.c
> index ca5493984a5..c45b6d849cb 100644
> --- a/range-diff.c
> +++ b/range-diff.c
> @@ -60,7 +60,7 @@ static int read_patches(const char *range, struct stri=
ng_list *list,
>  		     "--output-indicator-context=3D#",
>  		     "--no-abbrev-commit",
>  		     "--pretty=3Dmedium",
> -		     "--notes",
> +		     "--show-notes-by-default",
>  		     NULL);
>  	strvec_push(&cp.args, range);
>  	if (other_arg)
> diff --git a/revision.c b/revision.c
> index 2f4c53ea207..49d385257ac 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2484,6 +2484,8 @@ static int handle_revision_opt(struct rev_info *re=
vs, int argc, const char **arg
>  		revs->break_bar =3D xstrdup(optarg);
>  		revs->track_linear =3D 1;
>  		revs->track_first_time =3D 1;
> +	} else if (!strcmp(arg, "--show-notes-by-default")) {
> +		revs->show_notes_by_default =3D 1;
>  	} else if (skip_prefix(arg, "--show-notes=3D", &optarg) ||
>  		   skip_prefix(arg, "--notes=3D", &optarg)) {
>  		if (starts_with(arg, "--show-notes=3D") &&
> @@ -3054,6 +3056,11 @@ int setup_revisions(int argc, const char **argv, =
struct rev_info *revs, struct s
>  	if (revs->expand_tabs_in_log < 0)
>  		revs->expand_tabs_in_log =3D revs->expand_tabs_in_log_default;
>
> +	if (!revs->show_notes_given && revs->show_notes_by_default) {
> +		enable_default_display_notes(&revs->notes_opt, &revs->show_notes);
> +		revs->show_notes_given =3D 1;
> +	}
> +
>  	return left;
>  }
>
> diff --git a/revision.h b/revision.h
> index 82ab400139d..50091bbd13f 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -253,6 +253,7 @@ struct rev_info {
>  			shown_dashes:1,
>  			show_merge:1,
>  			show_notes_given:1,
> +			show_notes_by_default:1,
>  			show_signature:1,
>  			pretty_given:1,
>  			abbrev_commit:1,
> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> index b5f4d6a6530..b33afa1c6aa 100755
> --- a/t/t3206-range-diff.sh
> +++ b/t/t3206-range-diff.sh
> @@ -662,6 +662,20 @@ test_expect_success 'range-diff with multiple --not=
es' '
>  	test_cmp expect actual
>  '
>
> +# `range-diff` should act like `log` with regards to notes
> +test_expect_success 'range-diff with --notes=3Dcustom does not show def=
ault notes' '
> +	git notes add -m "topic note" topic &&
> +	git notes add -m "unmodified note" unmodified &&
> +	git notes --ref=3Dcustom add -m "topic note" topic &&
> +	git notes --ref=3Dcustom add -m "unmodified note" unmodified &&
> +	test_when_finished git notes remove topic unmodified &&
> +	test_when_finished git notes --ref=3Dcustom remove topic unmodified &&
> +	git range-diff --notes=3Dcustom main..topic main..unmodified \
> +		>actual &&
> +	! grep "## Notes ##" actual &&
> +	grep "## Notes (custom) ##" actual
> +'
> +
>  test_expect_success 'format-patch --range-diff does not compare notes b=
y default' '
>  	git notes add -m "topic note" topic &&
>  	git notes add -m "unmodified note" unmodified &&
> @@ -679,6 +693,20 @@ test_expect_success 'format-patch --range-diff does=
 not compare notes by default
>  	! grep "note" 0000-*
>  '
>
> +test_expect_success 'format-patch --notes=3Dcustom --range-diff only co=
mpares custom notes' '
> +	git notes add -m "topic note" topic &&
> +	git notes --ref=3Dcustom add -m "topic note (custom)" topic &&
> +	git notes add -m "unmodified note" unmodified &&
> +	git notes --ref=3Dcustom add -m "unmodified note (custom)" unmodified =
&&
> +	test_when_finished git notes remove topic unmodified &&
> +	test_when_finished git notes --ref=3Dcustom remove topic unmodified &&
> +	git format-patch --notes=3Dcustom --cover-letter --range-diff=3D$prev =
\
> +		main..unmodified >actual &&
> +	test_when_finished "rm 000?-*" &&
> +	grep "## Notes (custom) ##" 0000-* &&
> +	! grep "## Notes ##" 0000-*
> +'
> +
>  test_expect_success 'format-patch --range-diff with --no-notes' '
>  	git notes add -m "topic note" topic &&
>  	git notes add -m "unmodified note" unmodified &&
> --
> 2.42.0
>
>

--8323328-1750441375-1695299437=:750--
