Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C47A1F403
	for <e@80x24.org>; Sat,  9 Jun 2018 21:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753383AbeFIVqI (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 17:46:08 -0400
Received: from mout.gmx.net ([212.227.15.18]:33605 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753373AbeFIVqH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 17:46:07 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lt1eU-1gPo3s1MZW-012bt8; Sat, 09
 Jun 2018 23:46:02 +0200
Date:   Sat, 9 Jun 2018 23:45:46 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, alban.gruin@gmail.com
Subject: Re: [RFC PATCH 1/3] git-rebase, sequencer: add a --quiet option for
 the interactive machinery
In-Reply-To: <20180607171344.23331-2-newren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1806092336320.77@tvgsbejvaqbjf.bet>
References: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com> <20180607171344.23331-1-newren@gmail.com> <20180607171344.23331-2-newren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:10n5bxQK48MyKn5VTr4g3kWFrfieiW45+RuBeFiHRl8PweSfTo8
 CXNGs0ppJhUh16vV8cZWH2tAMo9QYKzx/jjHPsxnAY/EP/G/8VuGd6y/rGhOI7+n28tjzPM
 Cn8zMZlsiIh/lxrbIdIxiHbt56bk7oVHFwqpovUOkiov36WH0kqHH4eoqlcxgx6sHImYPSB
 EWFziawglTSRf4KZXJung==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pGUhBLFcB9s=:YIEDOiRkGO3pKeVX6EsIHU
 K3003YPiv6YaigX3F6SjnR3zYGibv5HWOkUrB2UctpyDlU4zTtebDKrFvPUL3+mr/P9AipQdU
 ZAaALaEOPKbl2zeq7dtTnFW1qnnvrsGW4778ymtd9QHJ0BZnjgEopTlRfcNcpB5mERnEdum4T
 4wnXwUJGJqxRoni6+/ioRM4Fn1T+f/wuiT795Z+SGSdX3AKH/RL+avVm5pfa5zTPMIEAU5mo9
 AthfGrmS7P9lKHCMLjTLTjC7L1YIC7saeJYJUCR6gPOB3a6qlbtinUDZzZTAIngaxMph/8imV
 9gQ4sFKb3vnY1YMt+DyWCQR3BhFtEcddVy6eANOfBvGJjdhyp4CiU68xKpigi8CF20+FNSSih
 rR4rmOEPzdlevcGwvkc/spZJNgTYWEeiTrxJgjzfSAhNhaAOSjMS7JpF5BQFRxWZR6hk1Kn7+
 BYpUVN2dfxc0YEknOmqhJ0JMFS+MLVW2Time5Qrt7C+cCzl9hjGnhwnDa0WTN8ubPPNOszX2V
 cS43vY6el7Wzj+EhHkpZPFohJObed0jPKARmX2phi0/5egZdVdsHR7Fab1S9yYNJm5xrFpVJw
 UVtg7e/vRR/6wGL/yoc6CC8/1w5v2RtKRDh0oBg4j3gBv+yUxV/F4r0YZBJrQWlrgRalqRb0i
 +ganXtfjlRtajimVc5aaBWLrTw6puT7ro6p75s3oakNdI7d63Hw/0CMX+lHhRXFf8p6gwJerf
 7XRgByTb8ZbUTe4w0Opi/6BmViAEoFPB6TDMm0oP7QKeLGC2/utnZkee4YYK8Trgf7ccvCjNL
 QIOmq9W
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Thu, 7 Jun 2018, Elijah Newren wrote:

> While 'quiet' and 'interactive' may sound like antonyms, the interactive
> machinery actually has logic that implements several
> interactive_rebase=implied cases (--exec, --keep-empty, --rebase-merges)
> which won't pop up an editor.  Further, we want to make the interactive
> machinery also take over for git-rebase--merge and become the default
> merge strategy, so it makes sense for these other cases to have a quiet
> option.
> 
> git-rebase--interactive was already somewhat quieter than
> git-rebase--merge and git-rebase--am, possibly because cherry-pick has
> just traditionally been quieter.  As such, we only drop a few
> informational messages -- "Rebasing (n/m)" and "Succesfully rebased..."

Makes sense. As long as it is coordinated with Alban and Pratik, as both
of their GSoC projects are affected by this.

In particular Pratik's project, I think, would actually *benefit* from
your work, as it might even make it possible to turn all modes but
--preserve-merges into pure builtin code, which would be awesome.

> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 06a7b79307..1f2401f702 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -139,8 +139,12 @@ mark_action_done () {
>  	if test "$last_count" != "$new_count"
>  	then
>  		last_count=$new_count
> -		eval_gettext "Rebasing (\$new_count/\$total)"; printf "\r"
> -		test -z "$verbose" || echo
> +		if test -z "$GIT_QUIET"
> +		then
> +			eval_gettext "Rebasing (\$new_count/\$total)";
> +			printf "\r"
> +			test -z "$verbose" || echo
> +		fi
>  	fi
>  }
>  
> @@ -713,6 +717,7 @@ Commit or stash your changes, and then run
>  		"$hook" rebase < "$rewritten_list"
>  		true # we don't care if this hook failed
>  	fi &&
> +		test -z "$GIT_QUIET" &&
>  		warn "$(eval_gettext "Successfully rebased and updated \$head_name.")"

In general, I tried the statements to return success at all times. That
means that

		test -n "$GIT_QUIET" ||

would be better in this case.

> diff --git a/git-rebase.sh b/git-rebase.sh
> index 7d1612b31b..b639c0d4fe 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -136,7 +136,7 @@ write_basic_state () {
>  	echo "$head_name" > "$state_dir"/head-name &&
>  	echo "$onto" > "$state_dir"/onto &&
>  	echo "$orig_head" > "$state_dir"/orig-head &&
> -	echo "$GIT_QUIET" > "$state_dir"/quiet &&
> +	test t = "$GIT_QUIET" && : > "$state_dir"/quiet

Maybe it would be better to `echo t` into that file? That way, scripts
that used the value in that file would continue to work. (But maybe there
were no scripts that could use it, as only the interactive rebase allows
scripting, and it did not handle that flag before?)

The rest looks obviously good.

Thank you!
Dscho
