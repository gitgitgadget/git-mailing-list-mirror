Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91BC71F453
	for <e@80x24.org>; Fri, 26 Oct 2018 08:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbeJZQka (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 12:40:30 -0400
Received: from mout.gmx.net ([212.227.17.22]:49253 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbeJZQka (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 12:40:30 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LtEtL-1fZhML47nH-012mx9; Fri, 26
 Oct 2018 10:04:23 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LtEtL-1fZhML47nH-012mx9; Fri, 26
 Oct 2018 10:04:23 +0200
Date:   Fri, 26 Oct 2018 10:04:28 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/2] rebase -i: recognize short commands without
 arguments
In-Reply-To: <fff6fec5-88c9-4125-bf51-5e96e34bf1f6@kdbg.org>
Message-ID: <nycvar.QRO.7.76.6.1810261004110.4546@tvgsbejvaqbjf.bet>
References: <pull.43.v2.git.gitgitgadget@gmail.com> <pull.43.v3.git.gitgitgadget@gmail.com> <fff6fec5-88c9-4125-bf51-5e96e34bf1f6@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:BVtVnfU7jpGu/Vcm5EcwUqzgw/Ti7PF/8InV1PRbpiq4+VwolXd
 S/+7UFqmByxwfWkMUx06cQFFuXK8NxAWGZKELsoY+NrKxyuX2nhMXpmESxej/P/xgXbVinP
 emA6ViSwsC+hIFW/5XQgZJEOwnKDlgU5lWnlU9vesyjBknI1COs4mhEI5+ydyzyOxagZul+
 FjB33lNTwmtPUx8E/neiA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0LfZlFsU4pk=:Okdt+onMLi5OYxGkFFSRnH
 9ZZQvnsaNLXkYtu+i8a2SPeWaeKO4Za9HPwLEmAFDxuG2v4yq4pJqb8r9/13QKKFHYd6cYfLe
 UeTMCIE5fvdJb2uclwro4sy4IccBxuuAyRR26dXmLHo2PS8YjLsiUNxBPtMxn4lzdLegumSqF
 zwJ6KFoWw1/WEMjzOFK9LPYCMtkZPkNbCFt9w1kJ95LSYJJ5qUGA/vyzyQS6NegoCSiHpETyA
 g32YWN24yxClpd40mrxv2pZGqhFDm5+/6tXYSc18KbX/LIaVXykxqnD0Lctn+GAuiZTVo/G8w
 qWWVKjbgGwiSO6UoFYLmX/+eWCaiDbZXDugfzUxs3d5PzwP872tLKVUBtXBUv9TZ/CLTN7U36
 1a178hXGe3mJmxmINxvgzWMP+k5llYPhRoXNyhPrzYbChJ7FWrwW21MgflwczsgHKZ7pMaD0d
 gc1yWPtw9+KniVeLT0NQpVPKeqAqT9w7Kj+V5cR/NQcUMMDqOr58j8MEl912sML6T8uHKmj1o
 RjAVlUbz59kTMdMSvtxjIXCJx8ww++cFpBf9yJMxPUjA7Dpubz7SP0P74qXiN0zgJgjtsHA1t
 6xbN8ALGQNqVdO6XXNzvSGFmkQY1LCo9KIozkH5LS1s4qwb8d7qRlYUmZFAeNWNup2jd1Ul/U
 jm25rbbaG0RIA2m5IsohvfN4ZPWHfyk7r0wU0O1iomul/uuzurKoXamIJWaLRhXCL3I3/ch+H
 6zME6j/B+7ZMRacIGUwqWr7dMBCB7ep+Pr1qfJ/TRlzd0tFlHDoJezHdw52INDt6GTeB/VXky
 UKp0mguqq4V+vCh5yzXTVHTY5k51JgAh/+PQH7l2KfckmhGhMs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Thu, 25 Oct 2018, Johannes Sixt wrote:

> The sequencer instruction 'b', short for 'break', is rejected:
> 
>   error: invalid line 2: b
> 
> The reason is that the parser expects all short commands to have
> an argument. Permit short commands without arguments.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---

ACK.

Thanks for fixing this,
Dscho

>  I'll send a another patch in a moment that tests all short
>  sequencer commands, but it is independent from this topic.
> 
>  sequencer.c                | 3 ++-
>  t/lib-rebase.sh            | 2 +-
>  t/t3418-rebase-continue.sh | 4 +++-
>  3 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index ee3961ec63..3107f59ea7 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1954,7 +1954,8 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
>  		if (skip_prefix(bol, todo_command_info[i].str, &bol)) {
>  			item->command = i;
>  			break;
> -		} else if (bol[1] == ' ' && *bol == todo_command_info[i].c) {
> +		} else if ((bol + 1 == eol || bol[1] == ' ') &&
> +			   *bol == todo_command_info[i].c) {
>  			bol++;
>  			item->command = i;
>  			break;
> diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
> index 584604ee63..86572438ec 100644
> --- a/t/lib-rebase.sh
> +++ b/t/lib-rebase.sh
> @@ -49,7 +49,7 @@ set_fake_editor () {
>  		case $line in
>  		squash|fixup|edit|reword|drop)
>  			action="$line";;
> -		exec*|break)
> +		exec*|break|b)
>  			echo "$line" | sed 's/_/ /g' >> "$1";;
>  		"#")
>  			echo '# comment' >> "$1";;
> diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
> index 185a491089..b282505aac 100755
> --- a/t/t3418-rebase-continue.sh
> +++ b/t/t3418-rebase-continue.sh
> @@ -243,7 +243,9 @@ unset GIT_SEQUENCE_EDITOR
>  
>  test_expect_success 'the todo command "break" works' '
>  	rm -f execed &&
> -	FAKE_LINES="break exec_>execed" git rebase -i HEAD &&
> +	FAKE_LINES="break b exec_>execed" git rebase -i HEAD &&
> +	test_path_is_missing execed &&
> +	git rebase --continue &&
>  	test_path_is_missing execed &&
>  	git rebase --continue &&
>  	test_path_is_file execed
> -- 
> 2.19.1.406.g1aa3f475f3
> 
