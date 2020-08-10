Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C098C433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 11:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D54BC206C3
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 11:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="XE7bK7Wy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgHJLyR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 07:54:17 -0400
Received: from mout.gmx.net ([212.227.15.15]:33379 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbgHJLyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 07:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597060442;
        bh=DzYJfmlW7yZdq5osvt9M6SDsJ8h3ZYvAttW9CRQeZkk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XE7bK7Wy54xoq6l+mpefGYHtUChB1tBVCuyBwEyPx4ClXuNqn+Mgklxwa7g5Jh3RJ
         e1BbMQjdZpKTVy9WGAnWYzI14oBZzJkwBSzkjdUT/1CDdABfT9qAha5i01x/bc2Zb7
         tNXl9xTFhgOJDaBVlYySvJxcFZno7j1Vci4auHvo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.90.36] ([213.196.212.215]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2wL0-1k8PED2ybs-003JAK; Mon, 10
 Aug 2020 13:54:01 +0200
Date:   Mon, 10 Aug 2020 13:53:58 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: Avoiding 'master' nomenclature
In-Reply-To: <xmqq5za596uo.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2008101349570.50@tvgsbejvaqbjf.bet>
References: <CAHk-=wgutLH=mPdJkLU_E6gO4q0FcG+=EEQJVVQeb+OxG9CfgQ@mail.gmail.com> <xmqqime69jfc.fsf@gitster.c.googlers.com> <CAHk-=wisOOrfEvab9S417MnPSY8dVkbDOKa6ccdi1Bg3X1PMaw@mail.gmail.com> <CAHk-=wi2dsROeg=mij5C8O=UBVZGEpOUp=Bn-arQ7i+Wscynnw@mail.gmail.com>
 <20200729205846.GA2992025@coredump.intra.peff.net> <xmqqv9i6814y.fsf@gitster.c.googlers.com> <xmqqlfj27x7q.fsf@gitster.c.googlers.com> <xmqq5za596uo.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:t6og/ZQAHDnHGCvpne2d1SsrXTW8Fhfx4H+rvUMAcmGNscfFN1U
 fN2u9kIpvBWVWez7U6FKYpmOazvJVCMAsAlAWatsOd7bSTyfy8LXSwmq4JOjndn8IUDMb+4
 URIicI/6Ug5sgHDrE3Qkn5HHzyVpZfQpo0xM5TG/zu7N4JAuFXjAjLRbK73SNaHn7NV+083
 VgdL1yHe6w19B3R63/Cgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WxBZQCBZGOg=:xGBI1vcKNnHx9ThU5WbySk
 WHIBiWwURnAzp2r4ntAYi9HOTm3F0q8CFDblZgvFf4BtUTCcopoDRHLBhpGCRu13edY/GuGhg
 638Jw7dLaacU3eUH0PyGwSlt2xA9hJs4DrynppENhm7zc0TjpuIi8nzHQYAPQOnBJBYtqAUhH
 xKGMRA4GmwV+dlPvMvulDOM3MTLQApC5VKItzVpOlH7SjtDNfXYVMFRk8T41IPfRimgfrTksD
 l6Xk7nYC77YvDue9OD/RjbyEgvvO7dkDueCSh8EBUvWY+e5GO5TcBksyQ9LfSiwDvHz/uQh4o
 xqqGMDrQYBLDo9KG5WohaQr8eYoLTtQlnUY/g/8Pb8Z/iL2LIsDe5k84pT71fjoCCHN6cw3QA
 X68krE/XOithjBk16ckaJ2vats3LYOHGTf72ezPOM73x8p/5/m27cZtf/HTzipviMsDRxEuRr
 wzcS6jo2Oy4aYzfNEVu6eMaT/07curThd4dHrokag5mpf5fgCPn7z7zUOv1dFNsUNXRe8hZIc
 YkQgwIecGy/BPzrkQdfRGOV9Cc00yAg9vfZyluYM87E/dYVecRtvtHT966hEP8BPHS/SPomYb
 LaWANPqpm82c9k3SU0x0uj89r3sJ2o9CVdOe0rthYdu1qbBH+mzfUE/TJ9WAhwtsiiPT8hETB
 255DDuzZQH61pFXJHRtsPtihMa2u0lqGYzZtwxcA4qRJ5QJcQfoL194eoQY/ZGg+npNuxyTej
 3kWBVYnSj/rcaTJ90sxHZ10qjSXY7ZMDIpqzyiLu4BYI1pt3ff4mcYe6dGFqCmVaxkeYvP9em
 88Gpwt1/xBPg/4cGW4fRVo98YccvByKrZoS6ifUiYk6Zzen5PIJq69SACSLQTGveVCTCqpXjC
 Yl5xL+udJmatssDqa5Ajd5nK3MLA0m8cNK6LjIyY0GsJnot0UxqARyFWxesFvZr3AgzsSpcgz
 SaRWAXDBtx9oahhf64jIIgBgvmV96uaT8xp+HLYHGADjxGvUICKwhOR+65vW01UhUg9myNhRt
 EYoVCHKAP+paB8/zL0bOpkKvKPh1y07IVybJOwQ9PNRA0jRpo9tgEiH+zH5C16y5mtgmEEA3i
 SZVYfpa0pTb1iygxMvuNGuyUn3RaxdoMgMAe9x773QPssdKlgBqBc+1OPVdgjEufCXNMsiRSo
 1fz7mj2Hwn0jDv66z0VprNCjvVWIqPgC0RdV5Bmkp9XEGAl447vO5W4uCwzY6gR60FDiNXqiG
 6h8mMAzKksAQFCG1kiZIb1bKmuvVJnT7BqY+trQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 29 Jul 2020, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> > A rough outline I did while waiting for today's integration builds
> > to finish looks like this, which does not look _too_ bad.
>
> This time, with full test suite, documentation and a log message.
>
> A few bugs in the code are also fixed since the preview version.
>
>  - I was confused about wildmatch's return value.
>
>  - wildmatch is now called with WM_PATHNAME.
>
>  - Not just the "unvalued truth", but an empty string also works as
>    a "clear the list of globs" now.
>
>  - The final LF still needs to be added even when we suppress "into X".
>
> -- >8 --
> Subject: [PATCH] fmt-merge-msg: allow merge destination to be omitted ag=
ain
>
> In Git 2.28, we stopped special casing 'master' when producing the
> default merge message by just removing the code to squelch "into
> 'master'" at the end of the message.
>
> Introduce multi-valued merge.suppressDest configuration variable
> that gives a set of globs to match against the name of the branch
> into which the merge is being made, to let users specify for which
> branch fmt-merge-msg's output should be shortened.  When it is not
> set, 'master' is used as the sole value of the variable by default.
>
> Because this reverts the behaviour to that of pre-2.28 in
> repositories that have no relevant configuration, revert most of the
> changes made to the tests back then.  At the end of t6200, add a few
> tests to document the behaviour with the new configuration variable
> and protect it from future regression.
>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Looks good to me, and apart from the config key (for which I also don't
have a better suggestion), this looks pretty much how I would have done it
(but refrained from doing because I really wanted the patch series to be
part of v2.28.0).

TBH I expected some discussion along the line "Shouldn't this be an
opt-in, with the initial default saying 'every branch except `master`'?",
but that seems not to have taken place.

Thank you!
Dscho

> ---
>  Documentation/config/fmt-merge-msg.txt        | 12 ++++
>  fmt-merge-msg.c                               | 24 ++++++-
>  t/t1507-rev-parse-upstream.sh                 |  2 +-
>  t/t4013-diff-various.sh                       |  4 +-
>  t/t4013/diff.log_--decorate=3Dfull_--all        |  2 +-
>  t/t4013/diff.log_--decorate_--all             |  2 +-
>  ...--patch-with-stat_--summary_master_--_dir_ |  2 +-
>  t/t4013/diff.log_--patch-with-stat_master     |  2 +-
>  .../diff.log_--patch-with-stat_master_--_dir_ |  2 +-
>  ...ot_--cc_--patch-with-stat_--summary_master |  2 +-
>  ..._--root_--patch-with-stat_--summary_master |  2 +-
>  .../diff.log_--root_--patch-with-stat_master  |  2 +-
>  ...root_-c_--patch-with-stat_--summary_master |  2 +-
>  t/t4013/diff.log_--root_-p_master             |  2 +-
>  t/t4013/diff.log_--root_master                |  2 +-
>  t/t4013/diff.log_-m_-p_--first-parent_master  |  2 +-
>  t/t4013/diff.log_-m_-p_master                 |  4 +-
>  t/t4013/diff.log_-p_--first-parent_master     |  2 +-
>  t/t4013/diff.log_-p_master                    |  2 +-
>  t/t4013/diff.log_master                       |  2 +-
>  t/t4013/diff.show_--first-parent_master       |  2 +-
>  t/t4013/diff.show_-c_master                   |  2 +-
>  t/t4013/diff.show_-m_master                   |  4 +-
>  t/t4013/diff.show_master                      |  2 +-
>  ...ot_--cc_--patch-with-stat_--summary_master |  2 +-
>  ...root_-c_--patch-with-stat_--summary_master |  2 +-
>  t/t4202-log.sh                                | 72 +++++++++----------
>  t/t6200-fmt-merge-msg.sh                      | 56 ++++++++++-----
>  t/t7600-merge.sh                              | 14 ++--
>  t/t7608-merge-messages.sh                     | 10 +--
>  30 files changed, 148 insertions(+), 94 deletions(-)
>
> diff --git a/Documentation/config/fmt-merge-msg.txt b/Documentation/conf=
ig/fmt-merge-msg.txt
> index c73cfa90b7..a8e8f74d0a 100644
> --- a/Documentation/config/fmt-merge-msg.txt
> +++ b/Documentation/config/fmt-merge-msg.txt
> @@ -8,3 +8,15 @@ merge.log::
>  	most the specified number of one-line descriptions from the
>  	actual commits that are being merged.  Defaults to false, and
>  	true is a synonym for 20.
> +
> +merge.suppressDest::
> +	By adding a glob that matches the names of integration
> +	branches to this multi-valued configuration variable, the
> +	default merge message computed for merges into these
> +	integration branches will omit " into <branch name>" from
> +	its title.
> ++
> +An element with an empty value can be used to clear the list
> +of globs accumulated from previous configuration entries.
> +When there is no `merge.suppressDest` variable defined, the
> +default value of `master` is used for backward compatibility.
> diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
> index cfb8ff2f33..5fe879207b 100644
> --- a/fmt-merge-msg.c
> +++ b/fmt-merge-msg.c
> @@ -10,6 +10,8 @@
>  #include "commit-reach.h"
>
>  static int use_branch_desc;
> +static int suppress_dest_pattern_seen;
> +static struct string_list suppress_dest_patterns =3D STRING_LIST_INIT_D=
UP;
>
>  int fmt_merge_msg_config(const char *key, const char *value, void *cb)
>  {
> @@ -22,6 +24,12 @@ int fmt_merge_msg_config(const char *key, const char =
*value, void *cb)
>  			merge_log_config =3D DEFAULT_MERGE_LOG_LEN;
>  	} else if (!strcmp(key, "merge.branchdesc")) {
>  		use_branch_desc =3D git_config_bool(key, value);
> +	} else if (!strcmp(key, "merge.suppressdest")) {
> +		if (!value || !*value)
> +			string_list_clear(&suppress_dest_patterns, 0);
> +		else
> +			string_list_append(&suppress_dest_patterns, value);
> +		suppress_dest_pattern_seen =3D 1;
>  	} else {
>  		return git_default_config(key, value, cb);
>  	}
> @@ -408,6 +416,8 @@ static void fmt_merge_msg_title(struct strbuf *out,
>  {
>  	int i =3D 0;
>  	char *sep =3D "";
> +	struct string_list_item *item;
> +	int suppress_merge_dest =3D 0;
>
>  	strbuf_addstr(out, "Merge ");
>  	for (i =3D 0; i < srcs.nr; i++) {
> @@ -451,7 +461,16 @@ static void fmt_merge_msg_title(struct strbuf *out,
>  			strbuf_addf(out, " of %s", srcs.items[i].string);
>  	}
>
> -	strbuf_addf(out, " into %s\n", current_branch);
> +	for_each_string_list_item(item, &suppress_dest_patterns) {
> +		if (!wildmatch(item->string, current_branch, WM_PATHNAME)) {
> +			suppress_merge_dest =3D 1;
> +			break;
> +		}
> +	}
> +
> +	if (!suppress_merge_dest)
> +		strbuf_addf(out, " into %s", current_branch);
> +	strbuf_addch(out, '\n');
>  }
>
>  static void fmt_tag_signature(struct strbuf *tagbuf,
> @@ -596,6 +615,9 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf *=
out,
>  	void *current_branch_to_free;
>  	struct merge_parents merge_parents;
>
> +	if (!suppress_dest_pattern_seen)
> +		string_list_append(&suppress_dest_patterns, "master");
> +
>  	memset(&merge_parents, 0, sizeof(merge_parents));
>
>  	/* get current branch */
> diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.=
sh
> index f213aa8053..dfc0d96d8a 100755
> --- a/t/t1507-rev-parse-upstream.sh
> +++ b/t/t1507-rev-parse-upstream.sh
> @@ -137,7 +137,7 @@ test_expect_success 'merge my-side@{u} records the c=
orrect name' '
>  	git branch -t new my-side@{u} &&
>  	git merge -s ours new@{u} &&
>  	git show -s --pretty=3Dtformat:%s >actual &&
> -	echo "Merge remote-tracking branch ${SQ}origin/side${SQ} into master" =
>expect &&
> +	echo "Merge remote-tracking branch ${SQ}origin/side${SQ}" >expect &&
>  	test_cmp expect actual
>  )
>  '
> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index 43267d6024..3f60f7d96c 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -117,12 +117,12 @@ test_expect_success setup '
>
>  : <<\EOF
>  ! [initial] Initial
> - * [master] Merge branch 'side' into master
> + * [master] Merge branch 'side'
>    ! [rearrange] Rearranged lines in dir/sub
>     ! [side] Side
>  ----
>    +  [rearrange] Rearranged lines in dir/sub
> - -   [master] Merge branch 'side' into master
> + -   [master] Merge branch 'side'
>   * + [side] Side
>   *   [master^] Third
>   *   [master~2] Second
> diff --git a/t/t4013/diff.log_--decorate=3Dfull_--all b/t/t4013/diff.log=
_--decorate=3Dfull_--all
> index c56783b985..3f9b872ece 100644
> --- a/t/t4013/diff.log_--decorate=3Dfull_--all
> +++ b/t/t4013/diff.log_--decorate=3Dfull_--all
> @@ -31,7 +31,7 @@ Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:04:00 2006 +0000
>
> -    Merge branch 'side' into master
> +    Merge branch 'side'
>
>  commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a (refs/heads/side)
>  Author: A U Thor <author@example.com>
> diff --git a/t/t4013/diff.log_--decorate_--all b/t/t4013/diff.log_--deco=
rate_--all
> index 1cbdc038f4..f5e20e1e14 100644
> --- a/t/t4013/diff.log_--decorate_--all
> +++ b/t/t4013/diff.log_--decorate_--all
> @@ -31,7 +31,7 @@ Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:04:00 2006 +0000
>
> -    Merge branch 'side' into master
> +    Merge branch 'side'
>
>  commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a (side)
>  Author: A U Thor <author@example.com>
> diff --git a/t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir_=
 b/t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir_
> index f5b1b6516b..a18f1472a9 100644
> --- a/t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir_
> +++ b/t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir_
> @@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:04:00 2006 +0000
>
> -    Merge branch 'side' into master
> +    Merge branch 'side'
>
>  commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
>  Author: A U Thor <author@example.com>
> diff --git a/t/t4013/diff.log_--patch-with-stat_master b/t/t4013/diff.lo=
g_--patch-with-stat_master
> index af23803cdc..ae425c4672 100644
> --- a/t/t4013/diff.log_--patch-with-stat_master
> +++ b/t/t4013/diff.log_--patch-with-stat_master
> @@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:04:00 2006 +0000
>
> -    Merge branch 'side' into master
> +    Merge branch 'side'
>
>  commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
>  Author: A U Thor <author@example.com>
> diff --git a/t/t4013/diff.log_--patch-with-stat_master_--_dir_ b/t/t4013=
/diff.log_--patch-with-stat_master_--_dir_
> index 814098fbf8..d5207cadf4 100644
> --- a/t/t4013/diff.log_--patch-with-stat_master_--_dir_
> +++ b/t/t4013/diff.log_--patch-with-stat_master_--_dir_
> @@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:04:00 2006 +0000
>
> -    Merge branch 'side' into master
> +    Merge branch 'side'
>
>  commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
>  Author: A U Thor <author@example.com>
> diff --git a/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_ma=
ster b/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_master
> index b927fe4a98..0fc1e8cd71 100644
> --- a/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_master
> +++ b/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_master
> @@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:04:00 2006 +0000
>
> -    Merge branch 'side' into master
> +    Merge branch 'side'
>
>   dir/sub | 2 ++
>   file0   | 3 +++
> diff --git a/t/t4013/diff.log_--root_--patch-with-stat_--summary_master =
b/t/t4013/diff.log_--root_--patch-with-stat_--summary_master
> index 6db3cea329..dffc09dde9 100644
> --- a/t/t4013/diff.log_--root_--patch-with-stat_--summary_master
> +++ b/t/t4013/diff.log_--root_--patch-with-stat_--summary_master
> @@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:04:00 2006 +0000
>
> -    Merge branch 'side' into master
> +    Merge branch 'side'
>
>  commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
>  Author: A U Thor <author@example.com>
> diff --git a/t/t4013/diff.log_--root_--patch-with-stat_master b/t/t4013/=
diff.log_--root_--patch-with-stat_master
> index 98e9c320c3..55aa98012d 100644
> --- a/t/t4013/diff.log_--root_--patch-with-stat_master
> +++ b/t/t4013/diff.log_--root_--patch-with-stat_master
> @@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:04:00 2006 +0000
>
> -    Merge branch 'side' into master
> +    Merge branch 'side'
>
>  commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
>  Author: A U Thor <author@example.com>
> diff --git a/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_mast=
er b/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_master
> index b61b1117ae..019d85f7de 100644
> --- a/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_master
> +++ b/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_master
> @@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:04:00 2006 +0000
>
> -    Merge branch 'side' into master
> +    Merge branch 'side'
>
>   dir/sub | 2 ++
>   file0   | 3 +++
> diff --git a/t/t4013/diff.log_--root_-p_master b/t/t4013/diff.log_--root=
_-p_master
> index 345bd9e8a9..b42c334439 100644
> --- a/t/t4013/diff.log_--root_-p_master
> +++ b/t/t4013/diff.log_--root_-p_master
> @@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:04:00 2006 +0000
>
> -    Merge branch 'side' into master
> +    Merge branch 'side'
>
>  commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
>  Author: A U Thor <author@example.com>
> diff --git a/t/t4013/diff.log_--root_master b/t/t4013/diff.log_--root_ma=
ster
> index db56b1fe6b..e8f46159da 100644
> --- a/t/t4013/diff.log_--root_master
> +++ b/t/t4013/diff.log_--root_master
> @@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:04:00 2006 +0000
>
> -    Merge branch 'side' into master
> +    Merge branch 'side'
>
>  commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
>  Author: A U Thor <author@example.com>
> diff --git a/t/t4013/diff.log_-m_-p_--first-parent_master b/t/t4013/diff=
.log_-m_-p_--first-parent_master
> index bcadb50e26..7a0073f529 100644
> --- a/t/t4013/diff.log_-m_-p_--first-parent_master
> +++ b/t/t4013/diff.log_-m_-p_--first-parent_master
> @@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:04:00 2006 +0000
>
> -    Merge branch 'side' into master
> +    Merge branch 'side'
>
>  diff --git a/dir/sub b/dir/sub
>  index cead32e..992913c 100644
> diff --git a/t/t4013/diff.log_-m_-p_master b/t/t4013/diff.log_-m_-p_mast=
er
> index 2acf43a9fb..9ca62a01ed 100644
> --- a/t/t4013/diff.log_-m_-p_master
> +++ b/t/t4013/diff.log_-m_-p_master
> @@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:04:00 2006 +0000
>
> -    Merge branch 'side' into master
> +    Merge branch 'side'
>
>  diff --git a/dir/sub b/dir/sub
>  index cead32e..992913c 100644
> @@ -33,7 +33,7 @@ Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:04:00 2006 +0000
>
> -    Merge branch 'side' into master
> +    Merge branch 'side'
>
>  diff --git a/dir/sub b/dir/sub
>  index 7289e35..992913c 100644
> diff --git a/t/t4013/diff.log_-p_--first-parent_master b/t/t4013/diff.lo=
g_-p_--first-parent_master
> index c6a5876d80..3fc896d424 100644
> --- a/t/t4013/diff.log_-p_--first-parent_master
> +++ b/t/t4013/diff.log_-p_--first-parent_master
> @@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:04:00 2006 +0000
>
> -    Merge branch 'side' into master
> +    Merge branch 'side'
>
>  commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
>  Author: A U Thor <author@example.com>
> diff --git a/t/t4013/diff.log_-p_master b/t/t4013/diff.log_-p_master
> index 1841cded94..bf1326dc36 100644
> --- a/t/t4013/diff.log_-p_master
> +++ b/t/t4013/diff.log_-p_master
> @@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:04:00 2006 +0000
>
> -    Merge branch 'side' into master
> +    Merge branch 'side'
>
>  commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
>  Author: A U Thor <author@example.com>
> diff --git a/t/t4013/diff.log_master b/t/t4013/diff.log_master
> index f8ec445eb3..a8f6ce5abd 100644
> --- a/t/t4013/diff.log_master
> +++ b/t/t4013/diff.log_master
> @@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:04:00 2006 +0000
>
> -    Merge branch 'side' into master
> +    Merge branch 'side'
>
>  commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
>  Author: A U Thor <author@example.com>
> diff --git a/t/t4013/diff.show_--first-parent_master b/t/t4013/diff.show=
_--first-parent_master
> index 94548f4598..3dcbe473a0 100644
> --- a/t/t4013/diff.show_--first-parent_master
> +++ b/t/t4013/diff.show_--first-parent_master
> @@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:04:00 2006 +0000
>
> -    Merge branch 'side' into master
> +    Merge branch 'side'
>
>  diff --git a/dir/sub b/dir/sub
>  index cead32e..992913c 100644
> diff --git a/t/t4013/diff.show_-c_master b/t/t4013/diff.show_-c_master
> index 1c46ed64fd..81aba8da96 100644
> --- a/t/t4013/diff.show_-c_master
> +++ b/t/t4013/diff.show_-c_master
> @@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:04:00 2006 +0000
>
> -    Merge branch 'side' into master
> +    Merge branch 'side'
>
>  diff --combined dir/sub
>  index cead32e,7289e35..992913c
> diff --git a/t/t4013/diff.show_-m_master b/t/t4013/diff.show_-m_master
> index 7559fc22f8..4ea2ee453d 100644
> --- a/t/t4013/diff.show_-m_master
> +++ b/t/t4013/diff.show_-m_master
> @@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:04:00 2006 +0000
>
> -    Merge branch 'side' into master
> +    Merge branch 'side'
>
>  diff --git a/dir/sub b/dir/sub
>  index cead32e..992913c 100644
> @@ -33,7 +33,7 @@ Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:04:00 2006 +0000
>
> -    Merge branch 'side' into master
> +    Merge branch 'side'
>
>  diff --git a/dir/sub b/dir/sub
>  index 7289e35..992913c 100644
> diff --git a/t/t4013/diff.show_master b/t/t4013/diff.show_master
> index 57091c5d90..fb08ce0e46 100644
> --- a/t/t4013/diff.show_master
> +++ b/t/t4013/diff.show_master
> @@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:04:00 2006 +0000
>
> -    Merge branch 'side' into master
> +    Merge branch 'side'
>
>  diff --cc dir/sub
>  index cead32e,7289e35..992913c
> diff --git a/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--su=
mmary_master b/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--su=
mmary_master
> index 5f13a71bb5..30aae7817b 100644
> --- a/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--summary_m=
aster
> +++ b/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--summary_m=
aster
> @@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:04:00 2006 +0000
>
> -    Merge branch 'side' into master
> +    Merge branch 'side'
>
>   dir/sub | 2 ++
>   file0   | 3 +++
> diff --git a/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summ=
ary_master b/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summar=
y_master
> index 8acb88267b..d1d32bd34c 100644
> --- a/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summary_mas=
ter
> +++ b/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summary_mas=
ter
> @@ -4,7 +4,7 @@ Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:04:00 2006 +0000
>
> -    Merge branch 'side' into master
> +    Merge branch 'side'
>
>   dir/sub | 2 ++
>   file0   | 3 +++
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index fd9af658af..a0930599aa 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -483,7 +483,7 @@ test_expect_success 'set up merge history' '
>  '
>
>  cat > expect <<\EOF
> -*   Merge branch 'side' into master
> +*   Merge branch 'side'
>  |\
>  | * side-2
>  | * side-1
> @@ -502,7 +502,7 @@ test_expect_success 'log --graph with merge' '
>  '
>
>  cat > expect <<\EOF
> -| | | *   Merge branch 'side' into master
> +| | | *   Merge branch 'side'
>  | | | |\
>  | | | | * side-2
>  | | | | * side-1
> @@ -521,7 +521,7 @@ test_expect_success 'log --graph --line-prefix=3D"| =
| | " with merge' '
>  '
>
>  cat > expect.colors <<\EOF
> -*   Merge branch 'side' into master
> +*   Merge branch 'side'
>  <BLUE>|<RESET><CYAN>\<RESET>
>  <BLUE>|<RESET> * side-2
>  <BLUE>|<RESET> * side-1
> @@ -555,7 +555,7 @@ cat > expect <<\EOF
>  |\  Merge: A B
>  | | Author: A U Thor <author@example.com>
>  | |
> -| |     Merge branch 'side' into master
> +| |     Merge branch 'side'
>  | |
>  | * commit tags/side-2
>  | | Author: A U Thor <author@example.com>
> @@ -632,11 +632,11 @@ test_expect_success 'set up more tangled history' =
'
>  '
>
>  cat > expect <<\EOF
> -*   Merge tag 'reach' into master
> +*   Merge tag 'reach'
>  |\
>  | \
>  |  \
> -*-. \   Merge tags 'octopus-a' and 'octopus-b' into master
> +*-. \   Merge tags 'octopus-a' and 'octopus-b'
>  |\ \ \
>  * | | | seventh
>  | | * | octopus-b
> @@ -646,14 +646,14 @@ cat > expect <<\EOF
>  |/ /
>  | * reach
>  |/
> -*   Merge branch 'tangle' into master
> +*   Merge branch 'tangle'
>  |\
>  | *   Merge branch 'side' (early part) into tangle
>  | |\
>  | * \   Merge branch 'master' (early part) into tangle
>  | |\ \
>  | * | | tangle-a
> -* | | |   Merge branch 'side' into master
> +* | | |   Merge branch 'side'
>  |\ \ \ \
>  | * | | | side-2
>  | | |_|/
> @@ -735,16 +735,16 @@ test_expect_success 'log.decorate configuration' '
>
>  test_expect_success 'decorate-refs with glob' '
>  	cat >expect.decorate <<-\EOF &&
> -	Merge-tag-reach-into-master
> -	Merge-tags-octopus-a-and-octopus-b-into-master
> +	Merge-tag-reach
> +	Merge-tags-octopus-a-and-octopus-b
>  	seventh
>  	octopus-b (octopus-b)
>  	octopus-a (octopus-a)
>  	reach
>  	EOF
>  	cat >expect.no-decorate <<-\EOF &&
> -	Merge-tag-reach-into-master
> -	Merge-tags-octopus-a-and-octopus-b-into-master
> +	Merge-tag-reach
> +	Merge-tags-octopus-a-and-octopus-b
>  	seventh
>  	octopus-b
>  	octopus-a
> @@ -765,8 +765,8 @@ test_expect_success 'decorate-refs with glob' '
>
>  test_expect_success 'decorate-refs without globs' '
>  	cat >expect.decorate <<-\EOF &&
> -	Merge-tag-reach-into-master
> -	Merge-tags-octopus-a-and-octopus-b-into-master
> +	Merge-tag-reach
> +	Merge-tags-octopus-a-and-octopus-b
>  	seventh
>  	octopus-b
>  	octopus-a
> @@ -779,8 +779,8 @@ test_expect_success 'decorate-refs without globs' '
>
>  test_expect_success 'multiple decorate-refs' '
>  	cat >expect.decorate <<-\EOF &&
> -	Merge-tag-reach-into-master
> -	Merge-tags-octopus-a-and-octopus-b-into-master
> +	Merge-tag-reach
> +	Merge-tags-octopus-a-and-octopus-b
>  	seventh
>  	octopus-b (octopus-b)
>  	octopus-a (octopus-a)
> @@ -794,8 +794,8 @@ test_expect_success 'multiple decorate-refs' '
>
>  test_expect_success 'decorate-refs-exclude with glob' '
>  	cat >expect.decorate <<-\EOF &&
> -	Merge-tag-reach-into-master (HEAD -> master)
> -	Merge-tags-octopus-a-and-octopus-b-into-master
> +	Merge-tag-reach (HEAD -> master)
> +	Merge-tags-octopus-a-and-octopus-b
>  	seventh (tag: seventh)
>  	octopus-b (tag: octopus-b)
>  	octopus-a (tag: octopus-a)
> @@ -811,8 +811,8 @@ test_expect_success 'decorate-refs-exclude with glob=
' '
>
>  test_expect_success 'decorate-refs-exclude without globs' '
>  	cat >expect.decorate <<-\EOF &&
> -	Merge-tag-reach-into-master (HEAD -> master)
> -	Merge-tags-octopus-a-and-octopus-b-into-master
> +	Merge-tag-reach (HEAD -> master)
> +	Merge-tags-octopus-a-and-octopus-b
>  	seventh (tag: seventh)
>  	octopus-b (tag: octopus-b, octopus-b)
>  	octopus-a (tag: octopus-a, octopus-a)
> @@ -828,8 +828,8 @@ test_expect_success 'decorate-refs-exclude without g=
lobs' '
>
>  test_expect_success 'multiple decorate-refs-exclude' '
>  	cat >expect.decorate <<-\EOF &&
> -	Merge-tag-reach-into-master (HEAD -> master)
> -	Merge-tags-octopus-a-and-octopus-b-into-master
> +	Merge-tag-reach (HEAD -> master)
> +	Merge-tags-octopus-a-and-octopus-b
>  	seventh (tag: seventh)
>  	octopus-b (tag: octopus-b)
>  	octopus-a (tag: octopus-a)
> @@ -851,8 +851,8 @@ test_expect_success 'multiple decorate-refs-exclude'=
 '
>
>  test_expect_success 'decorate-refs and decorate-refs-exclude' '
>  	cat >expect.no-decorate <<-\EOF &&
> -	Merge-tag-reach-into-master (master)
> -	Merge-tags-octopus-a-and-octopus-b-into-master
> +	Merge-tag-reach (master)
> +	Merge-tags-octopus-a-and-octopus-b
>  	seventh
>  	octopus-b
>  	octopus-a
> @@ -866,8 +866,8 @@ test_expect_success 'decorate-refs and decorate-refs=
-exclude' '
>
>  test_expect_success 'deocrate-refs and log.excludeDecoration' '
>  	cat >expect.decorate <<-\EOF &&
> -	Merge-tag-reach-into-master (master)
> -	Merge-tags-octopus-a-and-octopus-b-into-master
> +	Merge-tag-reach (master)
> +	Merge-tags-octopus-a-and-octopus-b
>  	seventh
>  	octopus-b (octopus-b)
>  	octopus-a (octopus-a)
> @@ -881,10 +881,10 @@ test_expect_success 'deocrate-refs and log.exclude=
Decoration' '
>
>  test_expect_success 'decorate-refs-exclude and simplify-by-decoration' =
'
>  	cat >expect.decorate <<-\EOF &&
> -	Merge-tag-reach-into-master (HEAD -> master)
> +	Merge-tag-reach (HEAD -> master)
>  	reach (tag: reach, reach)
>  	seventh (tag: seventh)
> -	Merge-branch-tangle-into-master
> +	Merge-branch-tangle
>  	Merge-branch-side-early-part-into-tangle (tangle)
>  	tangle-a (tag: tangle-a)
>  	EOF
> @@ -1068,7 +1068,7 @@ cat >expect <<\EOF
>  |\  Merge: MERGE_PARENTS
>  | | Author: A U Thor <author@example.com>
>  | |
> -| |     Merge branch 'tangle' into master
> +| |     Merge branch 'tangle'
>  | |
>  | *   commit COMMIT_OBJECT_NAME
>  | |\  Merge: MERGE_PARENTS
> @@ -1102,7 +1102,7 @@ cat >expect <<\EOF
>  |\ \ \ \  Merge: MERGE_PARENTS
>  | | | | | Author: A U Thor <author@example.com>
>  | | | | |
> -| | | | |     Merge branch 'side' into master
> +| | | | |     Merge branch 'side'
>  | | | | |
>  | * | | | commit COMMIT_OBJECT_NAME
>  | | |_|/  Author: A U Thor <author@example.com>
> @@ -1343,7 +1343,7 @@ cat >expect <<\EOF
>  *** |\  Merge: MERGE_PARENTS
>  *** | | Author: A U Thor <author@example.com>
>  *** | |
> -*** | |     Merge branch 'tangle' into master
> +*** | |     Merge branch 'tangle'
>  *** | |
>  *** | *   commit COMMIT_OBJECT_NAME
>  *** | |\  Merge: MERGE_PARENTS
> @@ -1377,7 +1377,7 @@ cat >expect <<\EOF
>  *** |\ \ \ \  Merge: MERGE_PARENTS
>  *** | | | | | Author: A U Thor <author@example.com>
>  *** | | | | |
> -*** | | | | |     Merge branch 'side' into master
> +*** | | | | |     Merge branch 'side'
>  *** | | | | |
>  *** | * | | | commit COMMIT_OBJECT_NAME
>  *** | | |_|/  Author: A U Thor <author@example.com>
> @@ -1540,8 +1540,8 @@ cat >expect <<-\EOF
>  * reach
>  |
>  | A	reach.t
> -* Merge branch 'tangle' into master
> -*   Merge branch 'side' into master
> +* Merge branch 'tangle'
> +*   Merge branch 'side'
>  |\
>  | * side-2
>  |
> @@ -1562,8 +1562,8 @@ cat >expect <<-\EOF
>  * reach
>  |
>  | reach.t
> -* Merge branch 'tangle' into master
> -*   Merge branch 'side' into master
> +* Merge branch 'tangle'
> +*   Merge branch 'side'
>  |\
>  | * side-2
>  |
> diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
> index 2b3fd498d0..7d549748ef 100755
> --- a/t/t6200-fmt-merge-msg.sh
> +++ b/t/t6200-fmt-merge-msg.sh
> @@ -79,7 +79,7 @@ test_expect_success GPG 'set up a signed tag' '
>  '
>
>  test_expect_success 'message for merging local branch' '
> -	echo "Merge branch ${apos}left${apos} into master" >expected &&
> +	echo "Merge branch ${apos}left${apos}" >expected &&
>
>  	git checkout master &&
>  	git fetch . left &&
> @@ -107,7 +107,7 @@ test_expect_success GPG 'message for merging local t=
ag signed by unknown key' '
>  '
>
>  test_expect_success 'message for merging external branch' '
> -	echo "Merge branch ${apos}left${apos} of $(pwd) into master" >expected=
 &&
> +	echo "Merge branch ${apos}left${apos} of $(pwd)" >expected &&
>
>  	git checkout master &&
>  	git fetch "$(pwd)" left &&
> @@ -118,7 +118,7 @@ test_expect_success 'message for merging external br=
anch' '
>
>  test_expect_success '[merge] summary/log configuration' '
>  	cat >expected <<-EOF &&
> -	Merge branch ${apos}left${apos} into master
> +	Merge branch ${apos}left${apos}
>
>  	# By Another Author (3) and A U Thor (2)
>  	# Via Another Committer
> @@ -160,7 +160,7 @@ test_expect_success 'setup FETCH_HEAD' '
>
>  test_expect_success 'merge.log=3D3 limits shortlog length' '
>  	cat >expected <<-EOF &&
> -	Merge branch ${apos}left${apos} into master
> +	Merge branch ${apos}left${apos}
>
>  	# By Another Author (3) and A U Thor (2)
>  	# Via Another Committer
> @@ -177,7 +177,7 @@ test_expect_success 'merge.log=3D3 limits shortlog l=
ength' '
>
>  test_expect_success 'merge.log=3D5 shows all 5 commits' '
>  	cat >expected <<-EOF &&
> -	Merge branch ${apos}left${apos} into master
> +	Merge branch ${apos}left${apos}
>
>  	# By Another Author (3) and A U Thor (2)
>  	# Via Another Committer
> @@ -195,7 +195,7 @@ test_expect_success 'merge.log=3D5 shows all 5 commi=
ts' '
>
>  test_expect_success '--log=3D5 with custom comment character' '
>  	cat >expected <<-EOF &&
> -	Merge branch ${apos}left${apos} into master
> +	Merge branch ${apos}left${apos}
>
>  	x By Another Author (3) and A U Thor (2)
>  	x Via Another Committer
> @@ -212,14 +212,14 @@ test_expect_success '--log=3D5 with custom comment=
 character' '
>  '
>
>  test_expect_success 'merge.log=3D0 disables shortlog' '
> -	echo "Merge branch ${apos}left${apos} into master" >expected &&
> +	echo "Merge branch ${apos}left${apos}" >expected &&
>  	git -c merge.log=3D0 fmt-merge-msg <.git/FETCH_HEAD >actual &&
>  	test_cmp expected actual
>  '
>
>  test_expect_success '--log=3D3 limits shortlog length' '
>  	cat >expected <<-EOF &&
> -	Merge branch ${apos}left${apos} into master
> +	Merge branch ${apos}left${apos}
>
>  	# By Another Author (3) and A U Thor (2)
>  	# Via Another Committer
> @@ -236,7 +236,7 @@ test_expect_success '--log=3D3 limits shortlog lengt=
h' '
>
>  test_expect_success '--log=3D5 shows all 5 commits' '
>  	cat >expected <<-EOF &&
> -	Merge branch ${apos}left${apos} into master
> +	Merge branch ${apos}left${apos}
>
>  	# By Another Author (3) and A U Thor (2)
>  	# Via Another Committer
> @@ -253,13 +253,13 @@ test_expect_success '--log=3D5 shows all 5 commits=
' '
>  '
>
>  test_expect_success '--no-log disables shortlog' '
> -	echo "Merge branch ${apos}left${apos} into master" >expected &&
> +	echo "Merge branch ${apos}left${apos}" >expected &&
>  	git fmt-merge-msg --no-log <.git/FETCH_HEAD >actual &&
>  	test_cmp expected actual
>  '
>
>  test_expect_success '--log=3D0 disables shortlog' '
> -	echo "Merge branch ${apos}left${apos} into master" >expected &&
> +	echo "Merge branch ${apos}left${apos}" >expected &&
>  	git fmt-merge-msg --no-log <.git/FETCH_HEAD >actual &&
>  	test_cmp expected actual
>  '
> @@ -300,7 +300,7 @@ test_expect_success 'fmt-merge-msg -m' '
>
>  test_expect_success 'setup: expected shortlog for two branches' '
>  	cat >expected <<-EOF
> -	Merge branches ${apos}left${apos} and ${apos}right${apos} into master
> +	Merge branches ${apos}left${apos} and ${apos}right${apos}
>
>  	# By Another Author (3) and A U Thor (2)
>  	# Via Another Committer
> @@ -397,7 +397,7 @@ test_expect_success 'merge-msg with nothing to merge=
' '
>
>  test_expect_success 'merge-msg tag' '
>  	cat >expected <<-EOF &&
> -	Merge tag ${apos}tag-r3${apos} into master
> +	Merge tag ${apos}tag-r3${apos}
>
>  	* tag ${apos}tag-r3${apos}:
>  	  Right #3
> @@ -418,7 +418,7 @@ test_expect_success 'merge-msg tag' '
>
>  test_expect_success 'merge-msg two tags' '
>  	cat >expected <<-EOF &&
> -	Merge tags ${apos}tag-r3${apos} and ${apos}tag-l5${apos} into master
> +	Merge tags ${apos}tag-r3${apos} and ${apos}tag-l5${apos}
>
>  	* tag ${apos}tag-r3${apos}:
>  	  Right #3
> @@ -448,7 +448,7 @@ test_expect_success 'merge-msg two tags' '
>
>  test_expect_success 'merge-msg tag and branch' '
>  	cat >expected <<-EOF &&
> -	Merge branch ${apos}left${apos}, tag ${apos}tag-r3${apos} into master
> +	Merge branch ${apos}left${apos}, tag ${apos}tag-r3${apos}
>
>  	* tag ${apos}tag-r3${apos}:
>  	  Right #3
> @@ -479,7 +479,7 @@ test_expect_success 'merge-msg tag and branch' '
>  test_expect_success 'merge-msg lots of commits' '
>  	{
>  		cat <<-EOF &&
> -		Merge branch ${apos}long${apos} into master
> +		Merge branch ${apos}long${apos}
>
>  		* long: (35 commits)
>  		EOF
> @@ -516,7 +516,7 @@ test_expect_success 'merge-msg with "merging" an ann=
otated tag' '
>  	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
>  	{
>  		cat <<-\EOF
> -		Merge tag '\''annote'\'' into master
> +		Merge tag '\''annote'\''
>
>  		An annotated one
>
> @@ -531,7 +531,7 @@ test_expect_success 'merge-msg with "merging" an ann=
otated tag' '
>  	git merge --no-commit --no-ff $annote &&
>  	{
>  		cat <<-EOF
> -		Merge tag '\''$annote'\'' into master
> +		Merge tag '\''$annote'\''
>
>  		An annotated one
>
> @@ -542,4 +542,24 @@ test_expect_success 'merge-msg with "merging" an an=
notated tag' '
>  	test_cmp expected .git/MERGE_MSG
>  '
>
> +test_expect_success 'merge.suppressDest configuration' '
> +	git checkout -B side master &&
> +	git commit --allow-empty -m "One step ahead" &&
> +	git checkout master &&
> +	git fetch . side &&
> +
> +	git -c merge.suppressDest=3D"" fmt-merge-msg <.git/FETCH_HEAD >full.1 =
&&
> +	head -n1 full.1 >actual &&
> +	grep -e "Merge branch .side. into master" actual &&
> +
> +	git -c merge.suppressDest=3D"mast" fmt-merge-msg <.git/FETCH_HEAD >ful=
l.2 &&
> +	head -n1 full.2 >actual &&
> +	grep -e "Merge branch .side. into master$" actual &&
> +
> +	git -c merge.suppressDest=3D"ma??er" fmt-merge-msg <.git/FETCH_HEAD >f=
ull.3 &&
> +	head -n1 full.3 >actual &&
> +	grep -e "Merge branch .side." actual &&
> +	! grep -e " into master$" actual
> +'
> +
>  test_done
> diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
> index 1d45f9a4ed..5883a6adc3 100755
> --- a/t/t7600-merge.sh
> +++ b/t/t7600-merge.sh
> @@ -14,9 +14,9 @@ Testing basic merge operations/option parsing.
>      ! [c4] c4
>       ! [c5] c5
>        ! [c6] c6
> -       * [master] Merge commit 'c1' into master
> +       * [master] Merge commit 'c1'
>  --------
> -       - [master] Merge commit 'c1' into master
> +       - [master] Merge commit 'c1'
>   +     * [c1] commit 1
>        +  [c6] c6
>       +   [c5] c5
> @@ -44,8 +44,8 @@ test_write_lines '1 X' 2 '3 X' 4 '5 X' 6 7 8 '9 X' >re=
sult.1-3-5-9
>  test_write_lines 1 2 3 4 5 6 7 8 '9 Z' >result.9z
>
>  create_merge_msgs () {
> -	echo "Merge tag 'c2' into master" >msg.1-5 &&
> -	echo "Merge tags 'c2' and 'c3' into master" >msg.1-5-9 &&
> +	echo "Merge tag 'c2'" >msg.1-5 &&
> +	echo "Merge tags 'c2' and 'c3'" >msg.1-5-9 &&
>  	{
>  		echo "Squashed commit of the following:" &&
>  		echo &&
> @@ -258,7 +258,7 @@ test_expect_success 'merge c3 with c7 with commit.cl=
eanup =3D scissors' '
>  	git commit --no-edit -a &&
>
>  	cat >expect <<-\EOF &&
> -	Merge tag '"'"'c7'"'"' into master
> +	Merge tag '"'"'c7'"'"'
>
>  	# ------------------------ >8 ------------------------
>  	# Do not modify or remove the line above.
> @@ -808,10 +808,10 @@ test_expect_success 'merge with conflicted --autos=
tash changes' '
>  '
>
>  cat >expected.branch <<\EOF
> -Merge branch 'c5-branch' (early part) into master
> +Merge branch 'c5-branch' (early part)
>  EOF
>  cat >expected.tag <<\EOF
> -Merge commit 'c5~1' into master
> +Merge commit 'c5~1'
>  EOF
>
>  test_expect_success 'merge early part of c2' '
> diff --git a/t/t7608-merge-messages.sh b/t/t7608-merge-messages.sh
> index 2af33f195b..8e7e0a5865 100755
> --- a/t/t7608-merge-messages.sh
> +++ b/t/t7608-merge-messages.sh
> @@ -16,7 +16,7 @@ test_expect_success 'merge local branch' '
>  	git checkout master &&
>  	test_commit master-2 &&
>  	git merge local-branch &&
> -	check_oneline "Merge branch Qlocal-branchQ into master"
> +	check_oneline "Merge branch Qlocal-branchQ"
>  '
>
>  test_expect_success 'merge octopus branches' '
> @@ -26,7 +26,7 @@ test_expect_success 'merge octopus branches' '
>  	test_commit octopus-2 &&
>  	git checkout master &&
>  	git merge octopus-a octopus-b &&
> -	check_oneline "Merge branches Qoctopus-aQ and Qoctopus-bQ into master"
> +	check_oneline "Merge branches Qoctopus-aQ and Qoctopus-bQ"
>  '
>
>  test_expect_success 'merge tag' '
> @@ -35,7 +35,7 @@ test_expect_success 'merge tag' '
>  	git checkout master &&
>  	test_commit master-3 &&
>  	git merge tag-1 &&
> -	check_oneline "Merge tag Qtag-1Q into master"
> +	check_oneline "Merge tag Qtag-1Q"
>  '
>
>  test_expect_success 'ambiguous tag' '
> @@ -44,7 +44,7 @@ test_expect_success 'ambiguous tag' '
>  	git checkout master &&
>  	test_commit master-4 &&
>  	git merge ambiguous &&
> -	check_oneline "Merge tag QambiguousQ into master"
> +	check_oneline "Merge tag QambiguousQ"
>  '
>
>  test_expect_success 'remote-tracking branch' '
> @@ -54,7 +54,7 @@ test_expect_success 'remote-tracking branch' '
>  	git checkout master &&
>  	test_commit master-5 &&
>  	git merge origin/master &&
> -	check_oneline "Merge remote-tracking branch Qorigin/masterQ into maste=
r"
> +	check_oneline "Merge remote-tracking branch Qorigin/masterQ"
>  '
>
>  test_done
> --
> 2.28.0
>
>
