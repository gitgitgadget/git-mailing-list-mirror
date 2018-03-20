Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5C541F404
	for <e@80x24.org>; Tue, 20 Mar 2018 15:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751343AbeCTP2i (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 11:28:38 -0400
Received: from mout.gmx.net ([212.227.17.22]:57371 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750991AbeCTP2h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 11:28:37 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MZlEg-1fJp9R2pdW-00LaCP; Tue, 20
 Mar 2018 16:28:35 +0100
Date:   Tue, 20 Mar 2018 16:28:22 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Pratik Karki <predatoramigo@gmail.com>
cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC] [GSoC] Project proposal: convert scripts to builtins
In-Reply-To: <20180320093421.26817-1-predatoramigo@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803201616290.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <CAP8UFD2gN9Litjm_Wn8XoR7QMg6BXasETUX33ntcB2_gQ5AVTg@mail.gmail.com> <20180320093421.26817-1-predatoramigo@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:LcKtrx8ec8NIsO0q5aRaOSC13JqG1RqiNRolaJxiaSG45giXg2t
 5SBOJrCS8nw/jKF0lNvbP+gsmMPsP+/7TwKf73tDPTC34rD1jjm6fhMh2YgxyLlra+w9UKR
 s+WHRbKJ79oUCJNgskcT0fhvn6SHxurodrKOYIjzaaztmm9Plx0BrhFk+HwTasrw86Skb8/
 KCpJ6p6pB3dVfWoAMlfrw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XzRb5hPsSeA=:z4jGGJd+KGA7z7sGgXmMoI
 TZB1I0p6MGZTfZrSShOkd4ufhOvwOedxYHkGPCGS3sMJR2Vz6TgJ43tqNyIx0tTJR1SJYF1cg
 dwSzPdFUGlrFa30tFAXebKMVpzYflLFyD56dBA1dYtf3cpVkM9gSYNcSKxmOQxm9loBDuuN8n
 VnP1aZi4oLbqHhN3BY7x7+qVxIYTd6jIL+IKX7ykmbWDCX2kcSg6o84kE1x/m+eNUQ+Bc6mOR
 2s4/EHDw8BXQqKTld8ozGFmo7x5VaHJo/1AkhAQWlkJxFlFoMH//Caav2B9RtdxToe76Bv7xm
 8YWKpOlqM01vEFL+g6fmZGxtMeaPnCuvwyGVmkdN4ejXETvRTLnxzEKZx74C/7ncF7szBqQCI
 pDnDgx3m86QqIoyAYA7bXAsGyd8+oOzbClU0xidSykDIthkgkznyjWFnJ8BR1FGhptcbhw7Bn
 0lZWEWroGafqNTkcnHetq7yvzePWaL1Y3sQs9eG5b0b4828ZYPB4sb49gH05sKVohplU6TbK7
 ytQfzbqLLce2BCHicqpVZtYTW7ZuqXAoYITksep1YVJuVc1jimgmn2TasvhwTCedtT2VGj9ao
 iWGFkHxBXDd8DPVaWkbifzGCbei7kuQttOGFtirbLBlSm+W9EOukUBikb/h6VEHo+ZWu02ZOw
 zn3U+Fvm6G0alfuAwPXcHb71UMfBx0Y0WV2J64h8dQk021A6s/dUdxSIs6QTD0BJIExtcoglc
 cEfSV0MO9WwpPd3CZrVLUvGUpfg+DICFfazliVu88A4sl/STmlO9ytw6xbrwV0ayDtu6q9HXL
 ZJUNQ095sXk/4gxMKIxSjthpNldpNnqp+kJR1KVSSx4HKgEEmU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratik,

thank you so much for posting this inline, to make it easier to review.

I will quote only on specific parts below; Please just assume that I like
the other parts and have nothing to add.

On Tue, 20 Mar 2018, Pratik Karki wrote:

> 
> Timeline and Development Cycle
> ------------------------------
> 
> -   Apr 23: Accepted student proposals announced.
> -   Apr 23 onwards: Researching of all the test suites. Discussion of
>     possible test improvements in for `git-stash` and `git-rebase`.
> -   May 1: Rewriting skeleton begins.

I would have liked more detail here. Like, maybe even a rudimentary
initial version identifying, say, a part of `git stash` and/or `git
rebase` that could be put into a builtin (stash--helper and
rebase--helper, respectively).

It is my experience from several GSoCs working on this huge overarching
project to convert the scripts (which are good prototypes, but lack in
stringency in addition to performance) to C that even the individual
scripts are too much to stem for a single GSoC.

> -   May 13: Making `builtin/stash.c` ready for review process. (This
>     goes on for some time.)

There have been two past efforts to turn stash into a builtin:

	https://github.com/git-for-windows/git/pull/508

and

	https://public-inbox.org/git/20171110231314.30711-1-joel@teichroeb.net/

It would be good to read up on those and incorporate the learnings into
the proposal.

> -   May 26: Making `builtin/rebase.c` ready for review process. (This
>     goes on for some time.)

The `git-rebase.sh` script is itself not terribly interesting, as it hands
off to `git-rebase--am.sh`, `git-rebase--interactive.sh` and
`git-rebase--merge.sh`, respectively.

Converting `git-rebase` into a builtin without first converting all of
those scripts would make little sense.

It would probably be better to choose one of those latter scripts and move
their functionality into a builtin, in an incremental fashion.

By doing it incrementally, you can also avoid...

> -   June 10: Make second versions with more improvements and more
>     batteries ready for next review cycle.

... leaving two weeks between checkpoints. Also, doing it incrementally
lets you avoid sitting on your hands while waiting for the first patches
to be reviewed.

> -   June 20: Writing new tests and using more code-coverage tools to
>     squash bugs present.

Typically it helps a lot to have those tests *during* the conversion.
That's how I found most of the bugs when converting difftool, for example.

> -   June 25 - Jul 20: Start optimizing `builtin/stash.c` and
>     `builtin/rebase.c`. Benchmarking and profiling is done. They are
>     exclusively compared to their original shell scripts, to check
>     whether they are more performant or not and the results are
>     published in the mailing list for further discussion.

Could you add details how you would perform benchmarking and profiling?

> -   Jul 20 - Aug 5: More optimizing and polishing of `builtin/stash.c`
>     and `builtin/rebase.c` and running of new tests series written and
>     send them for code review.
> -   Aug 14: Submit final patches.
> -   Aug 22: Results announced.
> -   Apr 24 - Aug 14: Documentation is written. "What I'm working on" is
>     written and posted in my blog regarding GSoC with Git.

The timeline is a bit ambitious. I would like to caution you that these
are all big tasks, and maybe you want to cut down on the deliverables, and
add more detail what exactly you want to deliver (such as: what part of
stash/rebase do you find under-tested in our test suite and would
therefore want to augment, what parts of stash/rebase do you think you
would handle first, and how?).

Ciao,
Johannes
