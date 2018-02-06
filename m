Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31FBC1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 14:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752013AbeBFOx4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 09:53:56 -0500
Received: from mout.gmx.net ([212.227.17.21]:64789 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751837AbeBFOxz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 09:53:55 -0500
Received: from minint-tb4pce7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx102 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 0LgeFd-1f5oa118uD-00o2Sc; Tue, 06 Feb 2018 15:53:48 +0100
Date:   Tue, 6 Feb 2018 15:53:46 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Genki Sky <sky@genki.is>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] rebase: add --allow-empty-message option
In-Reply-To: <05bedbb20d5f02a9fe1a74996038f7ca42e35829.1517774326.git.sky@genki.is>
Message-ID: <nycvar.QRO.7.76.6.1802061552090.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <9d0414b869f21f38b81f92ee0619fd76410cbcfc.1517552392.git.sky@genki.is> <05bedbb20d5f02a9fe1a74996038f7ca42e35829.1517774326.git.sky@genki.is>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:SXhY1M8eRzJR01VQ648vSxpmj+dw0vvcGZMTfLqxvyuf8ObDjZc
 Qt1RMe/ESKIjdKz7whB65n0qhKnGesyhIuQe6Su1V2Glr/jNGOgTy2cZOPAORKbl1Q8rml5
 8jWzn0vHLmFfvQiwMV7H+rf8FPWn9F7pR7xyFuS2gZBDw+D5owoLFcKtJpl0JNQjPIM512X
 Q2UgZhr/ir3eEn4SG3vCA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Gl+UkDnWmP4=:FmJnBBfPQQPpH/qppSiyeR
 SK8GgHARAwqk3FDXQM+lR6s0cxciiYCGBWwuWBS7ECrIiRnxIk88b9Kv2bImHwkYi0jTimGF6
 gVAkblrlqx8CRHW3eBvuBu3mEIU2Hcwm/31XfLh1o/1MttYsH0Yh9YaDp98JAGFk+4m1nU07Z
 xbDLtXH50k6EqiEVxtg6KLxiU0hbHgq51YqzV6ot74wtXssAjyMxJ1r27RzEtIryoLQ+914KO
 684bPqu/qXoQtrruny2e80SjUNAteFhG2mKR1ldLXOnSSFcZuh2uLRLwDV3dko7PiuWNkQ87n
 aB1ce9TGKDb1/yw0mqW+/IMmhGUvl1JkDJbe/CU9or3GJkwWKlamEtjffdeOdVprVQOFadDrL
 5xrSh+0xIG6lBE1YSQVe8uwfLu2c73ZWHFJiFM1RlRgYCZPTOFe8KrCezmeKUfGOk9DSJ4vD3
 YIiakWche8OYPj+l9ZQdflDS8cqgkHzFxb9hDClsZRcE8m4TnXour4/32EMiuoWFnGJ8UhW2S
 7x4Fg9vLcUtmJDC/ZAI3P7M0hfefMC2ChLHhR638ak2Lg+cdEjmiVoDQyx/YXRNq9gfsKvnpK
 t19A37bwHWlCzZpltgBfSLcTTTTH7ZEXIeiRhk9y/4yyfHltXoi2Fow/+VJcfpZ5DneP/OUvX
 sq9HzuiOUS4Q2Ll7I9TTVaaseWF3QB1uHaKe8kqX+yO9dn3sCzwZPTl1XVauSkV1iSMryIJ2/
 SNDCdxdcS7Zh3H1/Sbpui8gfrdOWPbEeTGFZy2QPSOuvVL5hEDis4DY5kQGoWKR+hQ47T8HnT
 8f1aD8mqybjIYIGKEjz8YHaeoV8WV4A/ytJEz0uO1rF2vMlVfA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Genki,

On Sun, 4 Feb 2018, Genki Sky wrote:

> This option allows commits with empty commit messages to be rebased,
> matching the same option in git-commit and git-cherry-pick. While empty
> log messages are frowned upon, sometimes one finds them in older
> repositories (e.g. translated from another VCS [0]), or have other
> reasons for desiring them. The option is available in git-commit and
> git-cherry-pick, so it is natural to make other git tools play nicely
> with them. Adding this as an option allows the default to be "give the
> user a chance to fix", while not interrupting the user's workflow
> otherwise [1].
> 
>   [0]: https://stackoverflow.com/q/8542304
>   [1]: https://public-inbox.org/git/7vd33afqjh.fsf@alter.siamese.dyndns.org/
> 
> To implement this, add a new --allow-empty-message flag. Then propagate
> it to all calls of 'git commit', 'git cherry-pick', and 'git rebase--helper'
> within the rebase scripts.
> 
> Signed-off-by: Genki Sky <sky@genki.is>
> ---
> 
> Notes:
> 
>   Thanks for the initial feedback, here are the changes from [v1]:
>   - Made my commit message include the main motivations inline.
>   - Moved new tests to t/t3405-rebase-malformed.sh, which has the
>     relevant test description: "rebase should handle arbitrary git
>     message".
>   - Accordingly re-used existing test setup.
>   - Minimized tests to just one for git-rebase--interactive.sh and one
>     for git-rebase--merge.sh. First, one test per file keeps things
>     focused while getting most benefit (other code within same file is
>     likely to be noticed by modifiers). And, while git-rebase--am.sh
>     does have one cherry-pick, it is only for a special case with
>     --keep-empty. So git-rebase--am.sh otherwise doesn't have this
>     empty-message issue.
> 
>   In general, there was a concern of over-testing, and over-checking
>   implementation details. So, this time, I erred on the conservative
>   side.
> 
>   [v1]: https://public-inbox.org/git/9d0414b869f21f38b81f92ee0619fd76410cbcfc.1517552392.git.sky@genki.is/t/

Very nice. I looked over the patch (sorry, I have too little time to test
this thoroughly, but then, it is the custom on this here mailing list to
just review the patch as per the mail) and it looks very good to me.

Junio, if you like, please add a "Reviewed-by:" line for me.

Thanks!
Johannes
