Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 897DB1F4F8
	for <e@80x24.org>; Tue,  4 Oct 2016 08:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753117AbcJDIGh (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 04:06:37 -0400
Received: from mout.gmx.net ([212.227.17.21]:58313 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752905AbcJDIGg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 04:06:36 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LcmN9-1b9iT30xRn-00k54H; Tue, 04 Oct 2016 10:06:30
 +0200
Date:   Tue, 4 Oct 2016 10:06:28 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2016, #07; Fri, 23)
In-Reply-To: <xmqqd1jpkkea.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610032008370.35196@virtualbox>
References: <xmqqlgyiz0lr.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1609242101100.129229@virtualbox> <xmqqd1jpkkea.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:dWEM5J0Mkw7dPQdn0dgXHQ2KfFNZrYFS3AyvQL4YNJjLkdNx/Ic
 77Jv8GOj3Xjy/Em+cq0Z81FDNmKMrZc5aywcSHIAvYoWe1eRV51xAbJYCfDREiuSutOmkWe
 rFkZaJT3Wb2HTfdh1G8axQ76XXqzBKP0rLhFtG4XrWdBXeuMmIJ2572P6F6v3wuQElHt3eS
 l9eL9Rm8xQ1xE86Im888Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YJ/BZeShWk8=:W0SVDpToBa9qp+19gzA5Hs
 oOzypV+LZmdt0nTr1mHddQV5dJ1JK/u8IMGqhfPRgEHd5nBVPPMaJ5T5gR0eAxm8cH4fIl+ww
 sQUnYLPMcTqQDNoLAI290RzCq72KwpHrd+NWs6fu7D/NLAjfdYaQEpJfn8PMyp2k8KXxaaYtl
 t8uKEHL/NLbOTgEKfs197WG/ivEx3vljlRlhH4jNd9R9RjAFLQhEBClPyWFF/6WkwGwlYpg2O
 dtxZaRBkAjMqGimy7FScCwcGjqkTYMj8lD4kPg6nskbp6DH4ONVvDdEfjcjrHYd7MYpIJE+Mv
 34xfigt0kqferdn7KkGsoNEYTlSrrWlvMq8lPfEqvXsxkGqDbrMMDuqzQAjm9a+KrkzcYMlsi
 R4H3JngRlNmuHspQb1aGyJYRbaJa2je7tSBWD6Mgq2XQ5pkglt9MgyMCArUBUialvWUwQjPaz
 zkD5Q9T+/9+gSoMg9DNfXmzhTM80Buf7Ax8R8v8imfSXX3/WqJjzRejpXg6klmvj4fkCdl+T/
 SBUxalMexpjDj9f1fACeU6TrxQoPkE/f5s7m0/K/eNPPhekreMWZa94h5Vy6A7Otf97bA5K7c
 WeDcmUgDgnSM4pAqhOfkr2IAbFEs3xZlUkrubjzphqFxqQE4/0EwtcGezPp8zM0Knnl3iUlAN
 nEso9tF+kAxGwakilPyoGd3xvi2ovFBZ68iALRdmFdm7iNecNmND3aH9XuIwuBIa4luHRwaDM
 OT8WJt81vYEPwhLx0LLdyYdTftoThEv8gZROTne6I7P1gY+ZD/ePVeo4kKkKTOTp+0fjZIdrP
 ibLXTAk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 27 Sep 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > In your previous kitchen status ("What's cooking") you hinted at a
> > possible v2.10.1 soon. I have a couple of bugfixes lined up for Git
> > for Windows and would like to avoid unnecessarily frequent release
> > engineering... Any more concrete ideas on a date for this version?
> 
> I scanned RelNotes for 2.11 and identified these topics that we'd want
> to have in 'maint'.
> 
>     bw/pathspec-remove-unused-extern-decl # 1 (6 days ago) 
>     rs/checkout-some-states-are-const # 1 (6 days ago) 
>     rs/strbuf-remove-fix # 1 (6 days ago) 
>     rs/unpack-trees-reduce-file-scope-global # 1 (6 days ago) 
>     mr/vcs-svn-printf-ulong # 1 (6 days ago) 
>     sy/git-gui-i18n-ja # 7 (12 days ago) 
>     jk/fix-remote-curl-url-wo-proto # 1 (12 days ago) 
>     js/git-gui-commit-gpgsign # 2 (12 days ago) 
>     jk/patch-ids-no-merges # 2 (6 days ago) 
>     ew/http-do-not-forget-to-call-curl-multi-remove-handle # 3 (6 days ago) 
>     rs/xdiff-merge-overlapping-hunks-for-W-context # 1 (6 days ago) 
>     ks/perf-build-with-autoconf # 1 (6 days ago) 
>     jt/format-patch-base-info-above-sig # 1 (6 days ago) 
>     jk/rebase-i-drop-ident-check # 1 (6 days ago) 
>     jk/reduce-gc-aggressive-depth # 1 (6 days ago) 
>     et/add-chmod-x # 1 (6 days ago) 
>     tg/add-chmod+x-fix # 7 (24 hours ago) 
> 
> Most are internal clean-ups that I do not mind leaving out, but I
> think we want to have that "add --chmod=+x" fix in.  As it hasn't
> been enough time passed since the topic was merged to 'master', I'd
> say either
> 
>  (1) 2.10.1 with everything other than the last two in a few days
>      and 2.10.2 late next week with "add --chmod=+x" fix, or
> 
>  (2) just a single 2.10.1 with everything late next week.
> 
> I can go either way and welcome suggestions.  I'd start merging
> older topics in the above list to 'maint' soonish, but not today.

Sorry for the delay in answering. By now, it was probably obvious to you
that (2) was my preference ;-)

Thanks,
Dscho
