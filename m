Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB37C1F453
	for <e@80x24.org>; Mon, 29 Apr 2019 16:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbfD2QPN (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 12:15:13 -0400
Received: from mout.gmx.net ([212.227.15.18]:45427 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728626AbfD2QPN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 12:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556554467;
        bh=GWzJqcN7Zqka8AVlZknnB9zilaRohN22u6pJGle83xU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GEPYi3lMrB5qpqr7a5C2wkM2A60v/k68kQCUMNTrhMorJn9qxxXwTaT0mNRBJ7OgL
         2dXt9NYBvRhlZTkd7lF5r5PN7eSj1QjONdimRqsRTZ2VsZyehoT1PCjpDGt3FXiKHa
         xmDNfUBmIDu2zrGuEmhk+o+CgCMNj2r4pDCaGIjI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.106.210.16] ([167.220.152.16]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LdHeL-1guZb005Ef-00iVfJ; Mon, 29
 Apr 2019 18:14:27 +0200
Date:   Mon, 29 Apr 2019 12:14:29 -0400 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -r: always reword merge -c
In-Reply-To: <20190426103332.9036-1-phillip.wood123@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1904291208210.45@tvgsbejvaqbjf.bet>
References: <20190426103332.9036-1-phillip.wood123@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:LsWN1/qnc038h1aJ/6FFWt6UtLppmvxokV+bqLepilp+DGEfdlQ
 RyW7qatCJn0vUAk3NVCUAT9quZrxNGlkRsSgt8AfhzT+n9tR3Q6DuRAuSW5Q5t3Y8PJcBlB
 IaNs/4d1XOPGybH1TxXWRxC046bMsoe9xG9jYHwF1z3Y+YIcMPO59c0NmZSRhc1GWrfI1Lo
 34CITozbvPly96ByeVU8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xaDjlpj7tso=:vC61VHPDPK81G0p7zBBF9y
 Wu0vx/lscrf/TLDMiOQ/La0hDiPZktbKCrAFs+znxfmbeLnp+wSSvq7sR1zQYRxkH+C+JVWPe
 U8ZZT8sprwWmJlXgUEpkDXCrl32I6fhnKWXRKw/I8Pgowl53diLfHrjTxGg1kE05eDCydsvXe
 LEpx7px31dOgC7hCShwrXdMghlfHY7m0/fNAz114GVb6TOctJYUc1reVh2oYix5hQ1d9ab+22
 8SqJmQTz2ZjcvZrIj/bxK/HxeOIx1QrYSGNr60ejlZyTJWBPbAQ0+C5jw6Lk0TU6Jhq265/N6
 RzcBpnZyNLjJJNJggl4JotjmId+R7ohG1xIxy9HzBaLyqWlo8RbN+yzPatR7hbLneJ73hjvez
 Nx30fcsI/junStxwrsGNQLwJE2HY1faeJVG+qv/q9+QClQ/BwyBoPETiWTwISv+yqo/Xlm99P
 j1CvRCw7/geNmz12xrzV/hIoMMRzVXHNKcOaALCvmQ5yGj881ewr2uqcEEHWOm9Nncg4fdbHU
 UbHtCB0GnArrvD6n5m00m7QmXf547nNyTRUX0EZwCru3rQyIJ3LRVrJEzItivp8dDb6WimSkk
 mxgZlk904CwaoeUCe/uqBm3TgSrxhYdjyk3qrw5VySVArZsNFLGEITuce3FtC/e0CTAWKmr5L
 Kwjqe9HFa7ktybEeXLf4I0sBMo3DHxDyFK+u6vA88cNYzFA8tMq2Ub9umus5SPcXVYmCLieHZ
 QEgmeHpkg3E6vRSYMs8jtq7gmRtQS7xMY2frk12SiTgG8yefTZZYfqLtZjO6+XyM8RAgBqyxF
 jVq2eEyRhSD6ktVmkkH6JppJETdGTfNoLWvMCFgjyv32KK5NwZi4zI79Y7VLoyTkTJ3TmKG20
 PPQTyH1wvtIJYf6zBfgAw42WtQwtkXMvbAPe2BUV77QrJSQVuaWT4F8jaySqW6hOY7+pCqRq5
 mVxes5KJ8Lg==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Fri, 26 Apr 2019, Phillip Wood wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> If a merge can be fast-forwarded then make sure that we still edit the
> commit message if the user specifies -c. The implementation follows the
> same pattern that is used for ordinary rewords that are fast-forwarded.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---

OMG I was bitten twice by this very bug in the past week, and planned on
looking into it next week. Thanks for beating me to it.

Two comments:

> diff --git a/sequencer.c b/sequencer.c
> index 0db410d590..ff8565e7a8 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3248,6 +3248,10 @@ static int do_merge(struct repository *r,
>  		rollback_lock_file(&lock);
>  		ret =3D fast_forward_to(r, &commit->object.oid,
>  				      &head_commit->object.oid, 0, opts);
> +		if (flags & TODO_EDIT_MERGE_MSG) {
> +			run_commit_flags |=3D AMEND_MSG;
> +			goto fast_forward_edit;
> +		}
>  		goto leave_merge;
>  	}
>
> @@ -3351,6 +3355,7 @@ static int do_merge(struct repository *r,
>  		 * value (a negative one would indicate that the `merge`
>  		 * command needs to be rescheduled).
>  		 */
> +	fast_forward_edit:

It is *slightly* awkward that this is an `else` arm of an `if (ret)`, but
I do not necessarily think that it would be better to move the label
before the `if` than what you did; Your version comes out more readable,
still.

>  		ret =3D !!run_git_commit(r, git_path_merge_msg(r), opts,
>  				       run_commit_flags);
>
> diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
> index 4c69255ee6..3d484a3c72 100755
> --- a/t/t3430-rebase-merges.sh
> +++ b/t/t3430-rebase-merges.sh
> @@ -164,6 +164,16 @@ test_expect_success 'failed `merge <branch>` does n=
ot crash' '
>  	grep "^Merge branch ${SQ}G${SQ}$" .git/rebase-merge/message
>  '
>
> +test_expect_success 'fast-forward merge -c still rewords' '
> +	git checkout -b fast-forward-merge-c H &&
> +	set_fake_editor &&

set_fake_editor affects global state AFAIR (setting and exporting
`EDITOR`), therefore this would need to be run in a subshell, i.e.
enclosed in parentheses.

> +	FAKE_COMMIT_MESSAGE=3Dedited GIT_SEQUENCE_EDITOR=3D"echo merge -c H G =
>" \
> +		git rebase -ir @^ &&
> +	echo edited >expected &&
> +	git log --pretty=3Dformat:%B -1 >actual &&
> +	test_cmp expected actual
> +'
> +

The rest looks good, thank you!
Dscho

>  test_expect_success 'with a branch tip that was cherry-picked already' =
'
>  	git checkout -b already-upstream master &&
>  	base=3D"$(git rev-parse --verify HEAD)" &&
> --
> 2.21.0
>
>
