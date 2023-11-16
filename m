Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="HzHMgIbD"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4411B1
	for <git@vger.kernel.org>; Thu, 16 Nov 2023 00:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1700124797; x=1700729597; i=johannes.schindelin@gmx.de;
	bh=NjagQ2kevpU4c5DIgee9fj/k5ic9fI6dYkCUIMWy0gA=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=HzHMgIbDFRsh07qsZSGuW9J1RPITjmO5ubJxqMDRh37YqkgdZ44pWzjS/v670p9m
	 szTUW7Q+AffzgIH/bS0ZHQTbFUzn7cTcX1Cynza3HCR0yMTfLJDqtq9RqEgnvWdYZ
	 JKE5fpwPd0bIhtSUaCWTS8qdvmbf6z9ppHqt4d/s09PgDbnD+MukCGbF68jFSgjNV
	 0144F808gS/dFsjHp19Q5p/yMpQM98rRoesRqDYdFUf2KLs1QK2Gzkxm/17jGfaf1
	 oSM0DP2V0iS4dw/MUkoLu/J69lxbGyZ+hLu/5IpHRF8x70qM0RlLKP3+MKw5tE++p
	 PDaQayN3hdx/kyDIBQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.165]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mwwdf-1rIzji0TUZ-00yR4k; Thu, 16
 Nov 2023 09:53:17 +0100
Date: Thu, 16 Nov 2023 09:53:15 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Christian Couder <christian.couder@gmail.com>
cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
    Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>, 
    John Cai <johncai86@gmail.com>, Derrick Stolee <stolee@gmail.com>, 
    Phillip Wood <phillip.wood123@gmail.com>, 
    Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>, 
    Dragan Simic <dsimic@manjaro.org>, Linus Arver <linusa@google.com>
Subject: Re: [PATCH v7 00/14] Introduce new `git replay` command
In-Reply-To: <20231115143327.2441397-1-christian.couder@gmail.com>
Message-ID: <fb6eb685-0af1-082a-b20c-028b06b6914e@gmx.de>
References: <20231102135151.843758-1-christian.couder@gmail.com> <20231115143327.2441397-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:L7lLQbR0MXzdQUvtaTosxAMN8h1U+8Sk8iZ+A1RFL8mFSSTdbhg
 u8N6MrUHM+c28r9oJjpEo4IueZK6FhjV1C+PpKXMrBG8KynQ1wjPkULhtvGktxyG31YE9Qh
 Y3v0Ui+e4qOMQazJb0cusKeFhN8Liqy+OYyfUGa0naulpw4AptcP6auVt8lTKVTfLesLOWp
 I2SvrarDwtpVpmYZLWDEw==
UI-OutboundReport: notjunk:1;M01:P0:3rxvEuGzXNs=;G9Eyb09pCg59SA7xzKfJKANkH96
 BSWFc5KR9eN7TTnRabgaqaQztLOCRXh1j6TWQO021eNZnfAPHFPkZ+fBQdHqh2CMX/NieiFoW
 idjBZBk733Rl4L5Xq+Gf9uL09uLzP/G3xwlKFWRRyOQGZpMtyIRv1yKzILN/Hk3I997LzPGYM
 rL0+8yq73MT38WupqIYJ68WwtxR89Enw9WfPDR+nLsPCUIGeZfGyeuTeVx+EUNvL1/d2oZLtr
 mJmLny7rNGAj/jMEj2k4cbqGUVt0Is9fM2cvEMsXc2L5O0Mx3OKBeZ3J0tD2dYh5THOFfoNjJ
 IytX5x7K0HMkCWoKawjh6i91GwdPxLGosfCmgp3C1UQhl9vxDrCFDJng4fiC2hlk5cSuWWfiP
 lsbsOaEZE9nS8bw+rxTTZ/TbHUeqd+mUlA1LuzRkZ0FNeqwD5/JPgyHFJhxdn3iPhHTIrXe9l
 smzE9gZUOHSTdDHgPQ/N7JsNYsZDpztoIgZUfqcaBoN+UzVsVxVEQgxU7qRQIn+KsXiHpCups
 qK9et04LJxEbgEA+SmDWMdMApIX8Kt8slC8qSTd1uUVih87/Q/0Po0FbL62ASUxgBhBCuZBAu
 xS1rTX3WZ6eY6yTejf47GRZ6i+LVy/gw20zUDgX8LjdOh5UjKPNHRDdxN8WlkqYvm3xizNIUC
 5AXdEzrus2UWA6ggcm7gt/6VaQ8cpyGMBWx+u3jZ3QMSFV9gRpfACSTG+5Owsvo8KS5V5okbQ
 wTNi5K46gZm0qP5wPzLJDHxp9LJQ3R/CHKPgRRILo9BkaVAGfV8l8E/NHxmUVndCunxPw76Qo
 z6vbBi6qeIT9et33voIX/H/Wvb3+7ninb5qRe5QR07kN5mrYY1EeOoqsi44vRoPmkVfYLz5pa
 MoqtA5Ep4Tvu4BN/MTs9ZWzkDOHgEuhE9h+N+o10Qw4g3TQMegC7ZMviNpopeFT7XFekzo1J9
 9GyO5x1ekKdv84s5E2fqklA73ak=
Content-Transfer-Encoding: quoted-printable

Hi Christian,

[focusing exclusively on the `range-diff` because I lack the capacity for
anything beyond that]

On Wed, 15 Nov 2023, Christian Couder wrote:

> # Range-diff between v6 and v7
>
> (Sorry it looks like patch 6/14 in v7 is considered to be completely
> different from what it was in v6, so the range-diff is not showing
> differences between them.)
>
>  1:  fac0a9dff4 =3D  1:  cddcd967b2 t6429: remove switching aspects of f=
ast-rebase
>  2:  bec2eb8928 !  2:  c8476fb093 replay: introduce new builtin
>     @@ Documentation/git-replay.txt (new)
>      +DESCRIPTION
>      +-----------
>      +
>     -+Takes a range of commits and replays them onto a new location.
>     ++Takes a range of commits, specified by <oldbase> and <branch>, and
>     ++replays them onto a new location (see `--onto` option below).
>      +
>      +THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
>      +

Thank you.

>  3:  b0cdfdc0c3 =3D  3:  43322abd1e replay: start using parse_options AP=
I
>  4:  c3403f0b9d =3D  4:  6524c7f045 replay: die() instead of failing ass=
ert()
>  5:  4188eeac30 =3D  5:  05d0efa3cb replay: introduce pick_regular_commi=
t()
>  6:  b7b4d9001e <  -:  ---------- replay: change rev walking options
>  -:  ---------- >  6:  c7a5aad3d6 replay: change rev walking options

The actual range-diff for the sixth patch looks like this:

=2D- snip --
6:  b7b4d9001e9 ! 6:  c7a5aad3d62 replay: change rev walking options
    @@ Metadata
      ## Commit message ##
         replay: change rev walking options

    -    Let's set the rev walking options we need after calling
    -    setup_revisions() instead of before. This enforces options we alw=
ays
    -    want for now.
    +    Let's force the rev walking options we need after calling
    +    setup_revisions() instead of before.
    +
    +    This might override some user supplied rev walking command line o=
ptions
    +    though. So let's detect that and warn users by:
    +
    +      a) setting the desired values, before setup_revisions(),
    +      b) checking after setup_revisions() whether these values differ=
 from
    +         the desired values,
    +      c) if so throwing a warning and setting the desired values agai=
n.

         We want the command to work from older commits to newer ones by d=
efault.
         Also we don't want history simplification, as we want to deal wit=
h all
         the commits in the affected range.

    -    When we see an option that we are going to override, we emit a wa=
rning
    -    to avoid confusion as much as possible though.
    -
         Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
         Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
         Signed-off-by: Elijah Newren <newren@gmail.com>
    @@ Commit message

      ## builtin/replay.c ##
     @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, cons=
t char *prefix)
    - 	struct merge_result result;
    - 	struct strbuf reflog_msg =3D STRBUF_INIT;
    - 	struct strbuf branch_name =3D STRBUF_INIT;
    --	int ret =3D 0;
    -+	int i, ret =3D 0;
    -
    - 	const char * const replay_usage[] =3D {
    - 		N_("git replay --onto <newbase> <oldbase> <branch> # EXPERIMENTAL"=
),
    -@@ builtin/replay.c: int cmd_replay(int argc, const char **argv, cons=
t char *prefix)

      	repo_init_revisions(the_repository, &revs, prefix);

    @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const=
 char *prefix
     -	revs.max_parents =3D 1;
     -	revs.cherry_mark =3D 1;
     -	revs.limited =3D 1;
    --	revs.reverse =3D 1;
    ++	strvec_pushl(&rev_walk_args, "", argv[2], "--not", argv[1], NULL);
    ++
    ++	/*
    ++	 * Set desired values for rev walking options here. If they
    ++	 * are changed by some user specified option in setup_revisions()
    ++	 * below, we will detect that below and then warn.
    ++	 *
    ++	 * TODO: In the future we might want to either die(), or allow
    ++	 * some options changing these values if we think they could
    ++	 * be useful.
    ++	 */
    + 	revs.reverse =3D 1;
     -	revs.right_only =3D 1;
    --	revs.sort_order =3D REV_SORT_IN_GRAPH_ORDER;
    --	revs.topo_order =3D 1;
    + 	revs.sort_order =3D REV_SORT_IN_GRAPH_ORDER;
    + 	revs.topo_order =3D 1;
     -
    - 	strvec_pushl(&rev_walk_args, "", argv[2], "--not", argv[1], NULL);
    +-	strvec_pushl(&rev_walk_args, "", argv[2], "--not", argv[1], NULL);
    ++	revs.simplify_history =3D 0;

    -+	/*
    -+	 * TODO: For now, let's warn when we see an option that we are
    -+	 * going to override after setup_revisions() below. In the
    -+	 * future we might want to either die() or allow them if we
    -+	 * think they could be useful though.
    -+	 */
    -+	for (i =3D 0; i < argc; i++) {
    -+		if (!strcmp(argv[i], "--reverse") || !strcmp(argv[i], "--date-orde=
r") ||
    -+		    !strcmp(argv[i], "--topo-order") || !strcmp(argv[i], "--author=
-date-order") ||
    -+		    !strcmp(argv[i], "--full-history"))
    -+			warning(_("option '%s' will be overridden"), argv[i]);
    -+	}
    -+
      	if (setup_revisions(rev_walk_args.nr, rev_walk_args.v, &revs, NULL)=
 > 1) {
      		ret =3D error(_("unhandled options"));
      		goto cleanup;
      	}

    -+	/* requirements/overrides for revs */
    -+	revs.reverse =3D 1;
    -+	revs.sort_order =3D REV_SORT_IN_GRAPH_ORDER;
    -+	revs.topo_order =3D 1;
    -+	revs.simplify_history =3D 0;
    ++	/*
    ++	 * Detect and warn if we override some user specified rev
    ++	 * walking options.
    ++	 */
    ++	if (revs.reverse !=3D 1) {
    ++		warning(_("some rev walking options will be overridden as "
    ++			  "'%s' bit in 'struct rev_info' will be forced"),
    ++			"reverse");
    ++		revs.reverse =3D 1;
    ++	}
    ++	if (revs.sort_order !=3D REV_SORT_IN_GRAPH_ORDER) {
    ++		warning(_("some rev walking options will be overridden as "
    ++			  "'%s' bit in 'struct rev_info' will be forced"),
    ++			"sort_order");
    ++		revs.sort_order =3D REV_SORT_IN_GRAPH_ORDER;
    ++	}
    ++	if (revs.topo_order !=3D 1) {
    ++		warning(_("some rev walking options will be overridden as "
    ++			  "'%s' bit in 'struct rev_info' will be forced"),
    ++			"topo_order");
    ++		revs.topo_order =3D 1;
    ++	}
    ++	if (revs.simplify_history !=3D 0) {
    ++		warning(_("some rev walking options will be overridden as "
    ++			  "'%s' bit in 'struct rev_info' will be forced"),
    ++			"simplify_history");
    ++		revs.simplify_history =3D 0;
    ++	}
     +
      	strvec_clear(&rev_walk_args);

=2D- snap --

This looks really good. Thank you for going the extra step to make this
patch so much better.

>  7:  c57577a9b8 =3D  7:  01f35f924b replay: add an important FIXME comme=
nt about gpg signing
>  8:  e78be50f3d =3D  8:  1498b24bad replay: remove progress and info out=
put
>  9:  e4c79b676f =3D  9:  6786fc147b replay: remove HEAD related sanity c=
heck
> 10:  8d89f1b733 ! 10:  9a24dbb530 replay: make it a minimal server side =
command
>     @@ Commit message
>          Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>
>       ## Documentation/git-replay.txt ##
>     -@@ Documentation/git-replay.txt: SYNOPSIS
>     - DESCRIPTION
>     +@@ Documentation/git-replay.txt: DESCRIPTION
>       -----------
>
>     --Takes a range of commits and replays them onto a new location.
>     -+Takes a range of commits and replays them onto a new location. Lea=
ves
>     -+the working tree and the index untouched, and updates no
>     -+references. The output of this command is meant to be used as inpu=
t to
>     + Takes a range of commits, specified by <oldbase> and <branch>, and
>     +-replays them onto a new location (see `--onto` option below).
>     ++replays them onto a new location (see `--onto` option below). Leav=
es
>     ++the working tree and the index untouched, and updates no reference=
s.
>     ++The output of this command is meant to be used as input to
>      +`git update-ref --stdin`, which would update the relevant branches=
.
>
>       THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
>     @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, con=
st char *prefix
>         struct merge_result result;
>      -  struct strbuf reflog_msg =3D STRBUF_INIT;
>         struct strbuf branch_name =3D STRBUF_INIT;
>     -   int i, ret =3D 0;
>     +   int ret =3D 0;
>
>      @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, co=
nst char *prefix)
>         onto =3D peel_committish(onto_name);

Looks good to me.

> 11:  3d433a1322 ! 11:  ad6ca2fbef replay: use standard revision ranges
>     @@ Documentation/git-replay.txt: git-replay - EXPERIMENTAL: Replay c=
ommits on a new
>
>       DESCRIPTION
>       -----------
>     -@@ Documentation/git-replay.txt: DESCRIPTION
>     - Takes a range of commits and replays them onto a new location. Lea=
ves
>     - the working tree and the index untouched, and updates no
>     - references. The output of this command is meant to be used as inpu=
t to
>     +
>     +-Takes a range of commits, specified by <oldbase> and <branch>, and
>     +-replays them onto a new location (see `--onto` option below). Leav=
es
>     ++Takes ranges of commits and replays them onto a new location. Leav=
es
>     + the working tree and the index untouched, and updates no reference=
s.
>     + The output of this command is meant to be used as input to
>      -`git update-ref --stdin`, which would update the relevant branches=
.
>      +`git update-ref --stdin`, which would update the relevant branches
>      +(see the OUTPUT section below).
>     @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, con=
st char *prefix
>         struct merge_options merge_opt;
>         struct merge_result result;
>      -  struct strbuf branch_name =3D STRBUF_INIT;
>     -   int i, ret =3D 0;
>     +   int ret =3D 0;
>
>         const char * const replay_usage[] =3D {
>      -          N_("git replay --onto <newbase> <oldbase> <branch> # EXP=
ERIMENTAL"),
>     @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, con=
st char *prefix
>      -  strvec_pushl(&rev_walk_args, "", argv[2], "--not", argv[1], NULL=
);
>      -
>         /*
>     -    * TODO: For now, let's warn when we see an option that we are
>     -    * going to override after setup_revisions() below. In the
>     +    * Set desired values for rev walking options here. If they
>     +    * are changed by some user specified option in setup_revisions(=
)
>      @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, co=
nst char *prefix)
>     -                   warning(_("option '%s' will be overridden"), arg=
v[i]);
>     -   }
>     +   revs.topo_order =3D 1;
>     +   revs.simplify_history =3D 0;
>
>      -  if (setup_revisions(rev_walk_args.nr, rev_walk_args.v, &revs, NU=
LL) > 1) {
>      -          ret =3D error(_("unhandled options"));
>     @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, con=
st char *prefix
>         }
>
>      @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, co=
nst char *prefix)
>     -   revs.topo_order =3D 1;
>     -   revs.simplify_history =3D 0;
>     +           revs.simplify_history =3D 0;
>     +   }
>
>      -  strvec_clear(&rev_walk_args);
>      -

This is the correct spot for that documentation change. Good.

> 12:  cca8105382 ! 12:  081864ed5f replay: add --advance or 'cherry-pick'=
 mode
>     @@ builtin/replay.c: static struct commit *pick_regular_commit(struc=
t commit *pickm
>         struct merge_options merge_opt;
>         struct merge_result result;
>      +  struct strset *update_refs =3D NULL;
>     -   int i, ret =3D 0;
>     +   int ret =3D 0;
>
>         const char * const replay_usage[] =3D {
>      -          N_("git replay --onto <newbase> <revision-range>... # EX=
PERIMENTAL"),
>     @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, con=
st char *prefix
>
>         /*
>      @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, co=
nst char *prefix)
>     -   revs.topo_order =3D 1;
>     -   revs.simplify_history =3D 0;
>     +           revs.simplify_history =3D 0;
>     +   }
>
>      +  determine_replay_mode(&revs.cmdline, onto_name, &advance_name,
>      +                        &onto, &update_refs);
> 13:  92287a2cc8 ! 13:  19c4016c7c replay: add --contained to rebase cont=
ained branches
>     @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, con=
st char *prefix
>         struct rev_info revs;
>         struct commit *last_commit =3D NULL;
>      @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, co=
nst char *prefix)
>     -   int i, ret =3D 0;
>     +   int ret =3D 0;
>
>         const char * const replay_usage[] =3D {
>      -          N_("git replay (--onto <newbase> | --advance <branch>) <=
revision-range>... # EXPERIMENTAL"),
> 14:  529a7fda40 ! 14:  29556bcc86 replay: stop assuming replayed branche=
s do not diverge
>     @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, con=
st char *prefix
>         struct merge_result result;
>         struct strset *update_refs =3D NULL;
>      +  kh_oid_map_t *replayed_commits;
>     -   int i, ret =3D 0;
>     +   int ret =3D 0;
>
>         const char * const replay_usage[] =3D {
>      @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, co=
nst char *prefix)

The last three only have context-only changes. Obviously good.

Apart from the one little outstanding nit where I would love to see
`(EXPERIMENTAL!)` as the first word of the synopsis both in the manual
page and in the output of `git replay -h`, you have addressed all of my
concerns.

Thank you!
Johannes
