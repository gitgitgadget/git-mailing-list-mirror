Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9D5020248
	for <e@80x24.org>; Fri, 29 Mar 2019 15:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbfC2Prt (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 11:47:49 -0400
Received: from mout.gmx.net ([212.227.17.20]:34623 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728720AbfC2Prt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 11:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553874462;
        bh=RMzeekQVvkuLn+pcsZuq3nfpI8oJJN6pt77qxd6S5yk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LsaGtkQFgEMjGbhTiJA8Tybo+LqNu2RVzNi790x6I9Dv2Wu+GE/QNjSETMB5UGVFZ
         m+NNYU4kSdobr8+D9rE/smSJFhGy/bcgx4eNp3jXpRyBKGYV8kNJUJj+1Rmf13TSO2
         FSWBjPFxq3ipOGwkQq5bw5vTzBvnkrtGnU9Y1Sy8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MLB89-1hAAqV1XlZ-000HZV; Fri, 29
 Mar 2019 16:47:42 +0100
Date:   Fri, 29 Mar 2019 16:47:42 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Denton Liu <liu.denton@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v2] rebase: teach rebase --keep-base
In-Reply-To: <20190328221745.GA3941@dev-l>
Message-ID: <nycvar.QRO.7.76.6.1903291643060.41@tvgsbejvaqbjf.bet>
References: <cover.1553354374.git.liu.denton@gmail.com> <20190328221745.GA3941@dev-l>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-802038762-1553874464=:41"
X-Provags-ID: V03:K1:Zzb5X1aR0fZPCLRQEhpUOWItugCSg7Fl2j02DZppmJNM0CskhFa
 41m6rCRl2OkgdD0R2t8maLQBIAr2FNJ2kL/aTk2x3dVZUlq1yi2Ni6k2CiqawDpZq1KafJ9
 THaQFPb+6CXQkXcC6klt+FbArY2O3p7lPmf8ZsQojZ1gXDwn3258bMxHmjpt4YKJOLgAz0o
 KJEmAsAvavDYbA4nAh9+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8hEkekAlvUY=:oQ+x3boyfq+8JhN+Ee+Q/Z
 Nz8/iCcE6Q9hsZl7nSpjTeWHEjJ0EVcdm6K6z1IajKsCaFKFzc/74RHtGCR1aO5+/m5394vP2
 055aTjWSv67IM8LogE+ujZ79DQOTBeOEnj+/hMQmCgMES1/lMnYcCtu4j2xPal4DIwLeVMq/M
 UUAPCOEH7PPoMF+J4sGS51cb98/kPJITifV4o5pxIF+bD/MbOWlX8fOjTxcy0Ntrco+2IL+v9
 83Q6+3NP/akCA0CLUNPatOy9sAg0TTiwAcIEMjBiVAsd+Uzod4568tArnwZ3+CTuLIW9KqErj
 C2hvYOPJN7XgM2gAYiZ1VMHFeTIDZ0IL5PC9eaGD64dWnbi5kreuPL8Rgoa17yctC8tVr4ybo
 XKkptkscYHSbmB7dC+OTvSEfTqZBRl2FiPkjaPm3bT82BwyJN2U5O47Me+DwXZ1bb37Ggka7f
 UG8HuFBg/17D6Qca9k4vaGPV9oO4ndZQMZWTwGiUgDo6PwNY2NLJmkW+eDKCNYPo2Z8eKokLN
 O40gWWCrlrIdUY6pEX2KAqJU+ED4cZmyWd7no+7tANir4BzMEKjVA2uErVU4urN2dfGqyd1sQ
 L940d+5OYgWXor7OStohtouv2WvjTqWVzh7/vhxt+Py3BzB7yGOx7b4dm5ntibMnMLEIelFQ6
 +hAg1MEyO8uhmiAMhzIkIs82uVo5a7FAgwYbjLiIbSKvzdkx5ZRJkAlmH3NZ+xjm8zgg0Pqxc
 wfd2F9jxU505fAprT37nM1q2DOmE9CK266Ns8Gcmi+rAqhzvbKmBMJcdHOcVS3OLZDnmgu/OM
 ro08pysCD7nxa63pIVv8lHyzOp4WnKeeUvNWwtgRfvBIlNoktHwDHyK/RCofbCF1yYgcxyJtF
 /pLE67z3Bo28gpd6ZdoBYnc73yKZzzsc2cjrLuZHDi3zVql7kXmcYeuaYMtmfhCB/6m2rFYLs
 FbtU621FspA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-802038762-1553874464=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Denton,

On Thu, 28 Mar 2019, Denton Liu wrote:

> A common scenario is if a user is working on a topic branch and they
> wish to make some changes to intermediate commits or autosquash, they
> would run something such as
>
> 	git rebase -i --onto master... master
>
> in order to preserve the merge base. This prevents unnecessary commit
> churning.

Maybe an example would clarify what you try to do here? Something like:

	Example: When contributing a patch series to the Git mailing list,
	one often starts on top of the current `master`. However, while
	developing the patch series, `master` is also developed further,
	and it is sometimes not the best idea to keep rebasing on top
	of `master`, but to keep the base commit as-is. In such a case,
	the user can call

		git rebase -i --onto master... master

	as a shortcut to using the merge base between `master` and the
	current branch as base commit.

I wonder, however, whether it makes sense to introduce a shorter, sweeter
way to do this:

		git rebase -i master...

I.e. if we detect that the `<upstream>` argument is not a valid ref, that
it ends with three dots, and that stripping those dots off makes it a
valid ref, then we internally convert that to the same as `--onto
master... master`.

What do you think?

Ciao,
Dscho

> Alternatively, a user wishing to test individual commits in a topic
> branch without changing anything may run
>
> 	git rebase -x ./test.sh master... master
>
> Since rebasing onto the merge base of the branch and the upstream is
> such a common case, introduce the --keep-base option as a shortcut.
>
> This allows us to rewrite the above as
>
> 	git rebase -i --keep-base master
>
> and
>
> 	git rebase -x ./test.sh --keep-base master
>
> respectively.
>
> Add tests to ensure --keep-base works correctly in the normal case and
> fails when there are multiple merge bases, both in regular and
> interactive mode. Also, test to make sure conflicting options cause
> rebase to fail. While we're adding test cases, add a missing
> set_fake_editor call to 'rebase -i --onto master...side'.
>
> While we're documenting the --keep-base option, change an instance of
> "merge-base" to "merge base", which is the consistent spelling.
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>
> =C3=86var, I have a feeling that we're still miscommunicating and we don=
't
> fully understand each other. I'm putting up v2 to hopefully clear things
> up a little but I welcome more feedback.
>
> This patch now depends "[PATCH 1/8] tests (rebase): spell out the
> `--keep-empty` option" which is the first patch of Johannes's "Do not
> use abbreviated options in tests" patchset[1]. (Thanks for catching
> that, Johannes!)
>
> Changes since v1:
>
> * Squashed old set into one patch
> * Fixed indentation style and dangling else
> * Added more documentation after discussion with =C3=86var
>
> [1]: https://public-inbox.org/git/a1b4b74b9167e279dae4cd8c58fb28d8a714a6=
6a.1553537656.git.gitgitgadget@gmail.com/
>
>  Documentation/git-rebase.txt     | 25 ++++++++++++--
>  builtin/rebase.c                 | 32 ++++++++++++++----
>  t/t3416-rebase-onto-threedots.sh | 57 ++++++++++++++++++++++++++++++++
>  3 files changed, 105 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 6363d674b7..27be1f48ff 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -8,8 +8,8 @@ git-rebase - Reapply commits on top of another base tip
>  SYNOPSIS
>  --------
>  [verse]
> -'git rebase' [-i | --interactive] [<options>] [--exec <cmd>] [--onto <n=
ewbase>]
> -	[<upstream> [<branch>]]
> +'git rebase' [-i | --interactive] [<options>] [--exec <cmd>]
> +	[--onto <newbase> | --keep-base] [<upstream> [<branch>]]
>  'git rebase' [-i | --interactive] [<options>] [--exec <cmd>] [--onto <n=
ewbase>]
>  	--root [<branch>]
>  'git rebase' --continue | --skip | --abort | --quit | --edit-todo | --s=
how-current-patch
> @@ -217,6 +217,19 @@ As a special case, you may use "A\...B" as a shortc=
ut for the
>  merge base of A and B if there is exactly one merge base. You can
>  leave out at most one of A and B, in which case it defaults to HEAD.
>
> +--keep-base::
> +	Set the starting point at which to create the new commits to the
> +	merge base of <upstream> <branch>. Running
> +	'git rebase --keep-base <upstream> <branch>' is equivalent to
> +	running 'git rebase --onto <upstream>... <upstream>'.
> ++
> +Although both this option and --fork-point find the merge base between
> +<upstream> and <branch>, this option uses the merge base as the _starti=
ng
> +point_ on which new commits will be created, whereas --fork-point uses
> +the merge base to determine the _set of commits_ which will be rebased.
> ++
> +See also INCOMPATIBLE OPTIONS below.
> +
>  <upstream>::
>  	Upstream branch to compare against.  May be any valid commit,
>  	not just an existing branch name. Defaults to the configured
> @@ -364,6 +377,10 @@ ends up being empty, the <upstream> will be used as=
 a fallback.
>  +
>  If either <upstream> or --root is given on the command line, then the
>  default is `--no-fork-point`, otherwise the default is `--fork-point`.
> ++
> +If your branch was based on <upstream> but <upstream> was rewound and
> +your branch contains commits which were dropped, this option can be use=
d
> +with `--keep-base` in order to drop those commits from your branch.
>
>  --ignore-whitespace::
>  --whitespace=3D<option>::
> @@ -539,6 +556,8 @@ In addition, the following pairs of options are inco=
mpatible:
>   * --preserve-merges and --rebase-merges
>   * --rebase-merges and --strategy
>   * --rebase-merges and --strategy-option
> + * --keep-base and --onto
> + * --keep-base and --root
>
>  BEHAVIORAL DIFFERENCES
>  -----------------------
> @@ -863,7 +882,7 @@ NOTE: While an "easy case recovery" sometimes appear=
s to be successful
>        --interactive` will be **resurrected**!
>
>  The idea is to manually tell 'git rebase' "where the old 'subsystem'
> -ended and your 'topic' began", that is, what the old merge-base
> +ended and your 'topic' began", that is, what the old merge base
>  between them was.  You will have to find a way to name the last commit
>  of the old 'subsystem', for example:
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 77deebc65c..7c14a00460 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -27,8 +27,8 @@
>  #include "branch.h"
>
>  static char const * const builtin_rebase_usage[] =3D {
> -	N_("git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] "
> -		"[<upstream>] [<branch>]"),
> +	N_("git rebase [-i] [options] [--exec <cmd>] "
> +		"[--onto <newbase> | --keep-base] [<upstream> [<branch>]]"),
>  	N_("git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] "
>  		"--root [<branch>]"),
>  	N_("git rebase --continue | --abort | --skip | --edit-todo"),
> @@ -1018,6 +1018,7 @@ int cmd_rebase(int argc, const char **argv, const =
char *prefix)
>  	};
>  	const char *branch_name;
>  	int ret, flags, total_argc, in_progress =3D 0;
> +	int keep_base =3D 0;
>  	int ok_to_skip_pre_rebase =3D 0;
>  	struct strbuf msg =3D STRBUF_INIT;
>  	struct strbuf revisions =3D STRBUF_INIT;
> @@ -1051,6 +1052,8 @@ int cmd_rebase(int argc, const char **argv, const =
char *prefix)
>  		OPT_STRING(0, "onto", &options.onto_name,
>  			   N_("revision"),
>  			   N_("rebase onto given branch instead of upstream")),
> +		OPT_BOOL(0, "keep-base", &keep_base,
> +			 N_("use the merge-base of upstream and branch as the current base")=
),
>  		OPT_BOOL(0, "no-verify", &ok_to_skip_pre_rebase,
>  			 N_("allow pre-rebase hook to run")),
>  		OPT_NEGBIT('q', "quiet", &options.flags,
> @@ -1217,6 +1220,13 @@ int cmd_rebase(int argc, const char **argv, const=
 char *prefix)
>  		usage_with_options(builtin_rebase_usage,
>  				   builtin_rebase_options);
>
> +	if (keep_base) {
> +		if (options.onto_name)
> +			die(_("cannot combine '--keep-base' with '--onto'"));
> +		if (options.root)
> +			die(_("cannot combine '--keep-base' with '--root'"));
> +	}
> +
>  	if (action !=3D NO_ACTION && !in_progress)
>  		die(_("No rebase in progress?"));
>  	setenv(GIT_REFLOG_ACTION_ENVIRONMENT, "rebase", 0);
> @@ -1541,12 +1551,22 @@ int cmd_rebase(int argc, const char **argv, cons=
t char *prefix)
>  	}
>
>  	/* Make sure the branch to rebase onto is valid. */
> -	if (!options.onto_name)
> +	if (keep_base) {
> +		strbuf_reset(&buf);
> +		strbuf_addstr(&buf, options.upstream_name);
> +		strbuf_addstr(&buf, "...");
> +		options.onto_name =3D xstrdup(buf.buf);
> +	} else if (!options.onto_name)
>  		options.onto_name =3D options.upstream_name;
>  	if (strstr(options.onto_name, "...")) {
> -		if (get_oid_mb(options.onto_name, &merge_base) < 0)
> -			die(_("'%s': need exactly one merge base"),
> -			    options.onto_name);
> +		if (get_oid_mb(options.onto_name, &merge_base) < 0) {
> +			if (keep_base)
> +				die(_("'%s': need exactly one merge base with branch"),
> +				    options.upstream_name);
> +			else
> +				die(_("'%s': need exactly one merge base"),
> +				    options.onto_name);
> +		}
>  		options.onto =3D lookup_commit_or_die(&merge_base,
>  						    options.onto_name);
>  	} else {
> diff --git a/t/t3416-rebase-onto-threedots.sh b/t/t3416-rebase-onto-thre=
edots.sh
> index ddf2f64853..9c2548423b 100755
> --- a/t/t3416-rebase-onto-threedots.sh
> +++ b/t/t3416-rebase-onto-threedots.sh
> @@ -99,7 +99,64 @@ test_expect_success 'rebase -i --onto master...side' =
'
>  	git checkout side &&
>  	git reset --hard K &&
>
> +	set_fake_editor &&
>  	test_must_fail git rebase -i --onto master...side J
>  '
>
> +test_expect_success 'rebase --keep-base --onto incompatible' '
> +	test_must_fail git rebase --keep-base --onto master...
> +'
> +
> +test_expect_success 'rebase --keep-base --root incompatible' '
> +	test_must_fail git rebase --keep-base --root
> +'
> +
> +test_expect_success 'rebase --keep-base master from topic' '
> +	git reset --hard &&
> +	git checkout topic &&
> +	git reset --hard G &&
> +
> +	git rebase --keep-base master &&
> +	git rev-parse C >base.expect &&
> +	git merge-base master HEAD >base.actual &&
> +	test_cmp base.expect base.actual &&
> +
> +	git rev-parse HEAD~2 >actual &&
> +	git rev-parse C^0 >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'rebase --keep-base master from side' '
> +	git reset --hard &&
> +	git checkout side &&
> +	git reset --hard K &&
> +
> +	test_must_fail git rebase --keep-base master
> +'
> +
> +test_expect_success 'rebase -i --keep-base master from topic' '
> +	git reset --hard &&
> +	git checkout topic &&
> +	git reset --hard G &&
> +
> +	set_fake_editor &&
> +	EXPECT_COUNT=3D2 git rebase -i --keep-base master &&
> +	git rev-parse C >base.expect &&
> +	git merge-base master HEAD >base.actual &&
> +	test_cmp base.expect base.actual &&
> +
> +	git rev-parse HEAD~2 >actual &&
> +	git rev-parse C^0 >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'rebase -i --keep-base master from side' '
> +	git reset --hard &&
> +	git checkout side &&
> +	git reset --hard K &&
> +
> +	set_fake_editor &&
> +	test_must_fail git rebase -i --keep-base master
> +'
> +
>  test_done
> --
> 2.21.0.695.gaf8658f249
>
>

--8323328-802038762-1553874464=:41--
