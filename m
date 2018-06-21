Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48DC61F516
	for <e@80x24.org>; Thu, 21 Jun 2018 10:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933206AbeFUKen (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 06:34:43 -0400
Received: from mout.gmx.net ([212.227.15.19]:59869 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932994AbeFUKej (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 06:34:39 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MFdDB-1fSJkF03D3-00EhU6; Thu, 21
 Jun 2018 12:34:34 +0200
Date:   Thu, 21 Jun 2018 12:34:44 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Alban Gruin <alban.gruin@gmail.com>
cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>
Subject: Re: [GSoC][PATCH v2 2/3] rebase -i: rewrite setup_reflog_action()
 in C
In-Reply-To: <20180619154421.14999-3-alban.gruin@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1806211146360.11870@tvgsbejvaqbjf.bet>
References: <20180618131844.13408-1-alban.gruin@gmail.com> <20180619154421.14999-1-alban.gruin@gmail.com> <20180619154421.14999-3-alban.gruin@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1866973707-1529577285=:11870"
X-Provags-ID: V03:K1:cGS7Hsdh2nmT3CMOTv7Z2DScrYak2u6EJokV57JvRR5U0AIfYsL
 o28tT3jyWLAoPFesESu3fe1SCoks/YRGWuPLpSk9R/G02NmtBPS4H/clZHVQYKHlw8sbzVW
 MBlwuUbbXIRgAyD/p5VXeT6IL0C9o6HA59oRJHNvshxEDvYXKMLHcnoHhTAdQTifs4OodLG
 V0ZdFdEVTIrhXQR1RhjNg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4vIloC9MXtA=:v8VOkh0GQNujF5KwsgfU7o
 bTCZHEkqamuk8hC1ffIeYbpiV/n0FqlnhRn9dT+wssM6yMKAZZErl60R/45YvEmEYo6prPpcn
 ECjl+ruUBJR59g2J1DxIWxM3R9mUzYzAEMY6DZLFrgRteTpv4DNWE+QKJ7ARce4xbrqnZEDX3
 87XNeRq894olJUN/JkEbr0seCsQ5OKWH4+oZWg8sJxpM0RTXqeRP99KzfBNd/0/9nsCYegenx
 Vy874ULXXOeC6H9ulXlrfoRscfrbQs6R3Za6x6bWSIx9nKUjEUXTgMyXcX/WKjoYc7jA5AtoB
 yZddkANEDmJAhDF+o+/eT6Al5rNlV2+YgQznXtnzU9yzmEvSbJxdp6RzbykU9SZv082aPuSXX
 hso7WbIjAF4/eo4+T+msMEGEO7SegO67wKJ2Q/DJLTKbbeQboWxzeaiBE/cOqeXbwTZrX3ItW
 lcK8nHtTeiWImrnPdpmJSvOyTt0NmQ9EL3KFXARdQ6NwSPZ5QB+hyNPrIHXF/oMAF2jJAB1dB
 0gPyRzMr5I/g9dMjg3DhQRAgrDh9/rnkM09mkBfbxUTLXJ891lpod9UmW33uiakreRakgBBRW
 Iz/73iJupUI7D4iPLb4+yFNPFo30BV7T0zitsZ6VM6hNNzcVkEhiSdBimn2L9UGMTpf7UeQR1
 jRBTityakmsi+Iph5nn7A2tjQUy41ouglGoQjGyvbXtAosyp3rr+T5K+RthQvqX9DIxa/QFlX
 fy1IcssTYZy4IKGxeLpkdRYT+WYWswN90+7doOk3el5sunt40fZuXKQQ3YmfHzC9jHFFa1eBv
 Xq6543M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1866973707-1529577285=:11870
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Alban,


On Tue, 19 Jun 2018, Alban Gruin wrote:

> This rewrites setup_reflog_action() from shell to C. The new version is
> called checkout_base_commit().

This sounds like a serious mistake. How is it that a function that sets up
a reflog action all of a sudden checks out a base commit?

But you are correct, of course, that is exactly what the shell script
function does!

So maybe insert "the (misnamed)" after "This rewrites"? That would help me
in the future when I stumble across this commit again.

> A new command is added to rebase--helper.c, =E2=80=9Ccheckout-base=E2=80=
=9D, as such as

s/as such as/as well as/

> a new flag, =E2=80=9Cverbose=E2=80=9D, to avoid silencing the output of t=
he checkout
> operation called by checkout_base_commit().
>=20
> The shell version is then stripped in favour of a call to the helper. As

Please start a new paragraph after this sentence, before the "As ...",
because those two sentences represent different thoughts.

> $GIT_REFLOG_ACTION is not longer set at the first call of

s/not longer/no longer/

> checkout_onto(), a call to comment_for_reflog() is added at the
> beginning of this function.
>=20
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>  builtin/rebase--helper.c   |  9 +++++++--
>  git-rebase--interactive.sh | 16 ++--------------
>  sequencer.c                | 28 ++++++++++++++++++++++++++++
>  sequencer.h                |  3 +++
>  4 files changed, 40 insertions(+), 16 deletions(-)
>=20
> diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
> index d2990b210..7cd74da2e 100644
> --- a/builtin/rebase--helper.c
> +++ b/builtin/rebase--helper.c
> @@ -12,12 +12,12 @@ static const char * const builtin_rebase_helper_usage=
[] =3D {
>  int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>  {
>  =09struct replay_opts opts =3D REPLAY_OPTS_INIT;
> -=09unsigned flags =3D 0, keep_empty =3D 0, rebase_merges =3D 0;
> +=09unsigned flags =3D 0, keep_empty =3D 0, rebase_merges =3D 0, verbose =
=3D 0;
>  =09int abbreviate_commands =3D 0, rebase_cousins =3D -1;
>  =09enum {
>  =09=09CONTINUE =3D 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
>  =09=09CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH,
> -=09=09ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO
> +=09=09ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO, CHECKOUT_BASE
>  =09} command =3D 0;
>  =09struct option options[] =3D {
>  =09=09OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
> @@ -27,6 +27,7 @@ int cmd_rebase__helper(int argc, const char **argv, con=
st char *prefix)
>  =09=09OPT_BOOL(0, "rebase-merges", &rebase_merges, N_("rebase merge comm=
its")),
>  =09=09OPT_BOOL(0, "rebase-cousins", &rebase_cousins,
>  =09=09=09 N_("keep original branch points of cousins")),
> +=09=09OPT__VERBOSE(&verbose, N_("print subcommands output even if they s=
ucceed")),

That's very specific a description that applies only to this command
mode... Maybe just say `"be verbose"`, and as a bonus avoid a too-long
line?

> diff --git a/sequencer.c b/sequencer.c
> index 9aa7ddb33..a7a73e3ef 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3133,6 +3133,34 @@ static const char *reflog_message(struct replay_op=
ts *opts,
>  =09return buf.buf;
>  }
> =20
> +static int run_git_checkout(struct replay_opts *opts, const char *commit=
,
> +=09=09=09=09int verbose, const char *action)
> +{
> +=09struct child_process cmd =3D CHILD_PROCESS_INIT;
> +
> +=09cmd.git_cmd =3D 1;
> +
> +=09argv_array_push(&cmd.args, "checkout");
> +=09argv_array_push(&cmd.args, commit);
> +=09argv_array_pushf(&cmd.env_array, GIT_REFLOG_ACTION "=3D%s", action);
> +
> +=09return run_command_silent_on_success(&cmd, verbose);
> +}

Are you planning on reusing that code anywhere else than in
`checkout_base_commit()`? If yes, sure, it makes sense to keep as separate
function. Otherwise I would fold it into that latter function, for reading
simplicity.

> +
> +int checkout_base_commit(struct replay_opts *opts, const char *commit,
> +=09=09=09 int verbose)
> +{
> +=09const char *action;
> +
> +=09if (commit && *commit) {
> +=09=09action =3D reflog_message(opts, "start", "checkout %s", commit);
> +=09=09if (run_git_checkout(opts, commit, verbose, action))
> +=09=09=09return error(_("Could not checkout %s"), commit);
> +=09}
> +
> +=09return 0;
> +}
> +
>  static const char rescheduled_advice[] =3D
>  N_("Could not execute the todo command\n"
>  "\n"

The rest looks fine to me, thank you!
Dscho
--8323328-1866973707-1529577285=:11870--
