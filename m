Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 289791F453
	for <e@80x24.org>; Mon, 21 Jan 2019 16:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbfAUQH7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 11:07:59 -0500
Received: from mout.gmx.net ([212.227.15.15]:49559 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729270AbfAUQH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 11:07:58 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MEXHd-1h0iH20JSb-00FnPP; Mon, 21
 Jan 2019 17:07:53 +0100
Date:   Mon, 21 Jan 2019 17:07:36 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, predatoramigo@gmail.com,
        phillip.wood@talktalk.net
Subject: Re: [PATCH v4 4/8] am, rebase--merge: do not overlook --skip'ed
 commits with post-rewrite
In-Reply-To: <20181211161139.31686-5-newren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1901211706250.41@tvgsbejvaqbjf.bet>
References: <20181122044841.20993-1-newren@gmail.com> <20181211161139.31686-1-newren@gmail.com> <20181211161139.31686-5-newren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bffWWHmqQcCSgyYSwhESr3iyYFoU9zWvIvlUp8I8HGvdeU4jLgw
 lJ9tiHrTe6MO4nOx6e3r9OM533xq+GgcFfJ3MK1Tv7UXUes8wq4vaZK+rlQFabDzQUqLOuh
 QpgXdqGci0jyizBJa3g3GcKMOLHdOIU0iyNZk33I20GoKPDqXKwpF+tYi1+SR0beKrmrBs4
 03Jk+sHKwHKtnk9552utA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9Yx51qrytSE=:CK7y/J2dq0JhZU3xzExZBK
 tPsKvzzarvfnDsdaDQMw3x5sHNnKUNUxgpxu2QAW/F2xh0XXmTt1NmBdsCsrMTdanQOHzDgWe
 g46intnm73c6VYIxKBBt3qnYJZeN8AgSuKprM4u22nunxMoKMuC5aWnRtgK/c1KgpgxXtJlUT
 rZYqhom3Imkrbe6i6Sm6Env6ne7N1kfQ4uGhJ33QPlg+KdKwwOF27U/0/ujf7+eElLplTxMLQ
 kItSMJDaqK40ei3EZaXaRNDzxg66ZdNexKR9TQRWPAKs/HfeSCv1tt4lrTR5KlSZjKo7fhyxg
 0Y3VcB3kGU4/secxFA/rY+lu95+Dsmorh6K/fNQvhQX/oAZ64iO4Ks2ectKqHGShxDrB5vnwL
 rk9sr19QcEH/Hkhu23cri6cHTXKo4eGnvUfsHcn+DDjv8UPfqEFcVcqP/lpxlmd4OljWTzZ1k
 Yo4eo5/9SExTS+Mw7AAcinnOdM4CpPufUM4S/7iYv7hfI4miQSX5Wa66R4qWO4Y1dKjkjwC9g
 UJEL5m49ib3/xOqk4a4KiTQ6hCybzdQC/+1njyiIG+owJGvnLR1RutC9CEsLBstshu5l2ZrlN
 XlMfkDJrdL1nfLl05gJfTiSNmydD5CyroOdxwIFBnFtxpAWXitjN6o+h0I4iHKzNC9+h413ZX
 65xIceL+8ABzPCkx3co40fqEF+ph2HnWlXpRLHr7I6Qh9vVUqDEnbJiBAW4/isnUnTyX9l5z6
 KR83BNv85as97w1ycgGvv6XtjW1rO0pdrT15V+JaLU5m1XGJHynNwbSeWYNg3dy6aE7Sm3T5E
 C71vnMkGj63c6MjpdB0lq1r+nUas4nXbAWkah0AKTiGCiIEIH/VceqORtHIsykyFs/rFzqzcw
 76y8LhpK07FU3r/VBUGu+Ibn73zgmu2jkzO+Vax/GdP4CUZEtMMPy8TbLhZgqwojcV5Aw5Ofm
 aNZOMyf6WhQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 11 Dec 2018, Elijah Newren wrote:

> The post-rewrite hook is supposed to be invoked for each rewritten
> commit.  The fact that a commit was selected and processed by the rebase
> operation (even though when we hit an error a user said it had no more
> useful changes), suggests we should write an entry for it.  In
> particular, let's treat it as an empty commit trivially squashed into
> its parent.
> 
> This brings the rebase--am and rebase--merge backends in sync with the
> behavior of the interactive rebase backend.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>

This makes sense. I think, though, that we need to be more careful...

> ---
>  builtin/am.c                 | 9 +++++++++
>  git-rebase--merge.sh         | 2 ++
>  t/t5407-post-rewrite-hook.sh | 3 +++
>  3 files changed, 14 insertions(+)
> 
> diff --git a/builtin/am.c b/builtin/am.c
> index 8f27f3375b..af9d034838 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -2000,6 +2000,15 @@ static void am_skip(struct am_state *state)
>  	if (clean_index(&head, &head))
>  		die(_("failed to clean index"));
>  
> +	if (state->rebasing) {
> +		FILE *fp = xfopen(am_path(state, "rewritten"), "a");
> +
> +		assert(!is_null_oid(&state->orig_commit));
> +		fprintf(fp, "%s ", oid_to_hex(&state->orig_commit));

... here. What if `fp == NULL`? (Users do all kinds of interesting
things...)

Ciao,
Dscho

> +		fprintf(fp, "%s\n", oid_to_hex(&head));
> +		fclose(fp);
> +	}
> +
>  	am_next(state);
>  	am_load(state);
>  	am_run(state, 0);
> diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
> index aa2f2f0872..91250cbaed 100644
> --- a/git-rebase--merge.sh
> +++ b/git-rebase--merge.sh
> @@ -121,6 +121,8 @@ continue)
>  skip)
>  	read_state
>  	git rerere clear
> +	cmt="$(cat "$state_dir/cmt.$msgnum")"
> +	echo "$cmt $(git rev-parse HEAD^0)" >> "$state_dir/rewritten"
>  	msgnum=$(($msgnum + 1))
>  	while test "$msgnum" -le "$end"
>  	do
> diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
> index 6426ec8991..a4a5903cba 100755
> --- a/t/t5407-post-rewrite-hook.sh
> +++ b/t/t5407-post-rewrite-hook.sh
> @@ -78,6 +78,7 @@ test_expect_success 'git rebase --skip' '
>  	git rebase --continue &&
>  	echo rebase >expected.args &&
>  	cat >expected.data <<-EOF &&
> +	$(git rev-parse C) $(git rev-parse HEAD^)
>  	$(git rev-parse D) $(git rev-parse HEAD)
>  	EOF
>  	verify_hook_input
> @@ -91,6 +92,7 @@ test_expect_success 'git rebase --skip the last one' '
>  	echo rebase >expected.args &&
>  	cat >expected.data <<-EOF &&
>  	$(git rev-parse E) $(git rev-parse HEAD)
> +	$(git rev-parse F) $(git rev-parse HEAD)
>  	EOF
>  	verify_hook_input
>  '
> @@ -120,6 +122,7 @@ test_expect_success 'git rebase -m --skip' '
>  	git rebase --continue &&
>  	echo rebase >expected.args &&
>  	cat >expected.data <<-EOF &&
> +	$(git rev-parse C) $(git rev-parse HEAD^)
>  	$(git rev-parse D) $(git rev-parse HEAD)
>  	EOF
>  	verify_hook_input
> -- 
> 2.20.0.8.g5de428d695
> 
> 
