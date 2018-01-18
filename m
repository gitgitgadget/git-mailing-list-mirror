Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98CF21FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 22:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753696AbeARWAr (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 17:00:47 -0500
Received: from mout.gmx.net ([212.227.15.15]:59208 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752705AbeARWAp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 17:00:45 -0500
Received: from [10.122.129.233] ([46.142.197.184]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MMk99-1ekFOR3Bjb-008Wdz; Thu, 18
 Jan 2018 23:00:40 +0100
Date:   Thu, 18 Jan 2018 23:00:39 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Stefan Beller <sbeller@google.com>
cc:     git@vger.kernel.org, gitster@pobox.com, jacob.keller@gmail.com
Subject: Re: [PATCH 10/8] [DO NOT APPLY, but improve?] rebase--interactive:
 introduce "stop" command
In-Reply-To: <20180118183618.39853-3-sbeller@google.com>
Message-ID: <nycvar.QRO.7.76.6.1801182254470.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <20180118183618.39853-1-sbeller@google.com> <20180118183618.39853-3-sbeller@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Wtw6RWDv9o/S8PcDb1oR/SWhNWdtaIfcK0Y/DkUSwjG9j5Wf1nJ
 mQ4klWECnBmmCYzkrXgW+K+alCiXS1++l8PkR9gFqflsKyP6PPyKRvvKTnpuAv2xicyYYpg
 V5c9HJcNlT5gSIbyD31bTBadHFXal0vUcw+L7AGCYYtpy6Mdv8eZIVYTfcTGNzcMLFYZa9d
 fSE6/HpbUx6Dawyl0DP6g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GhW2LMqk2wE=:F7ArG85P7+BRQhi6HZ5lGE
 4UwF3aPszVSRuwTjxfhkSn1L0UPuxrZKQzsFK64WGSOwwk2OXx4NrvwUjAKAgDcquqYCOWfqg
 oc5fnwkPYayz1Tw4bIneXBehl+fzs0jOA6RYTiNUHxjOLj//diTMy7i9LxFFFMG1GA+oTpfNQ
 eAm3zxloKpYP2bg1NW/wNJJJCF1OeFvWrMYZMKz2pNho21n3Dbsby/JYN8V0iKwDgixcSfaSZ
 PRJrIQb+0a2dKAXQ2fshIFv2MY56kUp3/T3hd2tf3VGKRe/p8pcd7DeRxyonAaFYxu0b2Dp8+
 OBUjTqOJqDOoz2MLwAtePigm+CueNEvSHZ6VoxUxf7gOY+pnOUjoGWhhOQWRjizPe0Eyat8Va
 NBj7f+xGB1xD/DNfk52Ao+zX2JJsKlhtWSyEGhUCt3RyLGArBg2aFF83QakvK9dOau0He2jpZ
 ajs+XysCJ6XzOyWF4g/7HgQtBPCf51Hjul0IbbhBhmRRabRUVo6vyr6SLDR8ZcwriwQNsAeTo
 oCJ/L7hJ1LejRHYG8Wef1D+aJdOo4fJxAx0coeQygwwM9wV21FZV61qMM7jTmL7LYMVefQDX2
 p2CRE16tMzIm0Lnu6yIGTtGx8KJq5Bx7aIcfK8WKchaXlR4mwJr3skkggW9/yvWt4Rri/Qp0U
 EvWWQvhJK+FjhfN0ShNQeJSO1S4ItmTpV7vXZhBgNBa4iviF0q0WQ75HoTIFOlL9jC7aiUyJQ
 h7hKoUObFBMs2hv0Oxp72E9KJXfwH95DUuLXx12AE32r8qhH7Pwbjy5sFaXVaZQNGwsm4V0nd
 3XNk4jyfF6z4NiuHjWVTrdu9C3eG8oPV9n9zhse3GashqVh+nU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Thu, 18 Jan 2018, Stefan Beller wrote:

> Jake suggested using "x false" instead of "edit" for some corner cases.
> 
> I do prefer using "x false" for all kinds of things such as stopping
> before a commit (edit only let's you stop after a commit), and the
> knowledge that "x false" does the least amount of actions behind my back.
> 
> We should have that command as well, maybe?
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  git-rebase--interactive.sh |  1 +
>  sequencer.c                | 10 ++++++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 3cd7446d0b..9eac53f0c5 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -166,6 +166,7 @@ l, label <label>= label current HEAD with a name
>  t, reset <label> = reset HEAD to a label
>  b, bud = reset HEAD to the revision labeled 'onto', no arguments
>  m, merge [<label-or-commit>]* = create a merge commit using a given commit's message
> +y, stay = stop for  shortcut for
>  
>  These lines can be re-ordered; they are executed from top to bottom.
>  " | git stripspace --comment-lines >>"$todo"
> diff --git a/sequencer.c b/sequencer.c
> index 2b4e6b1232..4b3b9fe59d 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -782,6 +782,7 @@ enum todo_command {
>  	TODO_RESET,
>  	TODO_BUD,
>  	TODO_MERGE,
> +	TODO_STOP,

I see that your original idea was "stop", but then you probably realized
that there would be no good abbreviation for that, and changed your mind.

Personally, I would have called it `break`...

> @@ -2407,6 +2415,8 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
>  				/* `current` will be incremented below */
>  				todo_list->current = -1;
>  			}
> +		} else if (item->command == TODO_STOP) {
> +			todo_list->current = -1;

That is incorrect, it will most likely write an unexpected `done` file.

Did you mean `return 0` instead?

Ciao,
Dscho
