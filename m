Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCA611F516
	for <e@80x24.org>; Tue, 26 Jun 2018 21:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752221AbeFZVaS (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 17:30:18 -0400
Received: from mout.gmx.net ([212.227.17.22]:42015 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751879AbeFZVaR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 17:30:17 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LyVcA-1gBxdB1VIc-015oRr; Tue, 26
 Jun 2018 23:30:15 +0200
Date:   Tue, 26 Jun 2018 23:30:14 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     dana <dana@dana.is>
cc:     git@vger.kernel.org, Wink Saville <wink@saville.com>
Subject: Re: [PATCH] rebase -i: Fix white space in comments
In-Reply-To: <614F0C12-7173-48BD-9212-71AD6FBBDAA7@dana.is>
Message-ID: <nycvar.QRO.7.76.6.1806262329390.21419@tvgsbejvaqbjf.bet>
References: <614F0C12-7173-48BD-9212-71AD6FBBDAA7@dana.is>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:n8qhg3BJjNF/5weImj+Sqol5YynlJyhkosjBJWpMpvneYPVV+ES
 ZyM6kmccPYuogNbByMa4MIjZWRfp5rGOlDlvuGdQhxDOTngn4lHmj82MOwO9FlFeBTE4CKA
 bKGVtaSXkoPsRLRf/OIB7WkPUL0BnBDG19OuhzUsD6gXRDzFzaJclft1P1LylqxhJzB6yv+
 0vlDdTZ0X7pkGvLpWTPBQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:q1MhmOCtOUA=:iQOyKL92bxKN9IS6ws327h
 kKUN75FACrZF/foClOv1DmNTDLo8iIqIoBAotTBpJG+RAqhQfrX3VouZk/T9ANIEx2+NXuO3O
 vksIf0yv8lm5bqI162wDRLfmElQHjh3bjSZwNY2FfwM4LrIIKdBtHeDxy5n7LVUDDBee523cn
 V78xpw03AdvChwM2TvIpLYkaEN2ZreOoqsFTKlt1LZ0nWFfM6DBDqlzZ2ZTNT7nKmMxaU7j7U
 vn/uxCSPP4nNvveKkyYztHY4EuwXc8JU49yElQFxeNRh6Aeyxke0VVsP8N4dhzCxPSLk8zTf3
 AmVmSiAWBWVhgqKKw/pElF2wV2s8edlD27maM1X3bNIh3vpI2mSylwd09Nep4acWybyp2Muk8
 XCkanq2InU1YgMb5XOXHdrK+BzgmmNk73a1vt3jkVqaBA7aTLY9/3G3gONCAhNKXnxYgG+G3j
 qLlT6JO8cTwHwvKmvzPjBb5gn5qJfQQhRW4C/jQ3K3Jj/jiz6E/xr6ow5dEoNcM+l/As6cs/f
 5dHkQy49TY6ivJIdh/kN333QFqECC2bQCn7/a+ZjXttTMcbgKylzqMInE6CBz4UsgND3mBf6M
 cOxFwOLmHFhYmQX5V3ePrvkT704HDSJQeohF7FHgrXYEuv70zH/7pyZ8+EP9sL+dIa+/YXe7u
 QcLOm02i0RnzViDRiIhCVTIFmHQYj/+JxI5Iz8IfYk+T6EbC9oIEIsuL1oVukOvHa+d/8Rjyv
 b8kY4heFDvNAynJt/wznYH70CB5JGB2ACXGRRrYk5qFlBGH1qFtNBjZn3Wq/XXwT4sWJunaoj
 oDk2f/X
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's Cc: Wink, who authored the commit mentioned as culprit in the commit
message.


On Tue, 26 Jun 2018, dana wrote:

> Fix a trivial white-space issue introduced by commit d48f97aa8
> ("rebase: reindent function git_rebase__interactive", 2018-03-23). This
> affected the instructional comments displayed in the editor during an
> interactive rebase.
> 
> Signed-off-by: dana <dana@dana.is>
> ---
> 
> Sorry if i've done any of this wrong; i've never used this work-flow
> before. In any case, if it's not immediately obvious, this is the issue
> i mean to fix:
> 
> BEFORE (2.17.1):
> 
> # If you remove a line here THAT COMMIT WILL BE LOST.
> #
> # However, if you remove everything, the rebase will be aborted.
> #
> # Note that empty commits are commented out
> 
> AFTER (2.18.0):
> 
> # If you remove a line here THAT COMMIT WILL BE LOST.
> #
> #	However, if you remove everything, the rebase will be aborted.
> #
> #	
> # Note that empty commits are commented out
> 
> The 2.18.0 version is particularly irritating because many editors
> highlight the trailing tab in the penultimate line as a white-space
> error.
> 
> Aside: It's not a new thing, but i've always felt like that last line
> should end in a full stop. Maybe i'll send a patch for that too.
> 
> Cheers,
> dana
> 
>  git-rebase--interactive.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 299ded213..a31af6d4c 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -222,9 +222,9 @@ $comment_char $(eval_ngettext \
>  EOF
>  	append_todo_help
>  	gettext "
> -	However, if you remove everything, the rebase will be aborted.
> +However, if you remove everything, the rebase will be aborted.
>  
> -	" | git stripspace --comment-lines >>"$todo"
> +" | git stripspace --comment-lines >>"$todo"
>  
>  	if test -z "$keep_empty"
>  	then
> -- 
> 2.18.0
> 
> 
