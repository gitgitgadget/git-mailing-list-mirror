Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A00211F453
	for <e@80x24.org>; Fri, 18 Jan 2019 09:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbfARJ7D (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 04:59:03 -0500
Received: from mout.gmx.net ([212.227.15.19]:33901 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbfARJ7D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 04:59:03 -0500
Received: from [10.49.182.9] ([95.208.59.217]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MgcTf-1gYhCo21QN-00O2iF; Fri, 18
 Jan 2019 10:58:57 +0100
Date:   Fri, 18 Jan 2019 10:58:41 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: ps/stash-in-c, was Re: What's cooking in git.git (Jan 2019, #02;
 Tue, 15)
In-Reply-To: <20190116212631.GK25639@hank.intra.tgummerer.com>
Message-ID: <nycvar.QRO.7.76.6.1901172141480.41@tvgsbejvaqbjf.bet>
References: <xmqq4la9r1sl.fsf@gitster-ct.c.googlers.com> <20190116212631.GK25639@hank.intra.tgummerer.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:2S7jzgS6d1YzM2CxO3EXZOGMQaAYh3bK1+IyRTi/+PjwgRx4M9T
 G75yKLHhqQ+lR1ym6Kd5zGqzcy+aWoOh7vuBjfuexCdcHYzyvLvBpJqfzKtoWc197OH2H9h
 bVd+Ch3ngJ2NJevKsGNpwncVbOODYwuDWSvQFfU5y/I4V+Q+WFGcSlTs96lhz285Ps59PfY
 GYdDRlvXINOpx/vUq7XIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QzPv6ylGNRU=:x6lJJ2ynkur+j0z3Rqtq/3
 nxVHsMJnJQu5yuoP9QthjHllY3feBgXsThVBjmvDKKkyR1UHDHjCJtLo8EBtkbvpLcUxOZ5wq
 zhn881vmfj+uWNNdn28y7CvPxQO4f6WYRKIQL68MYeE2zJ9J+R8XW/UWDd5oGhofKjJtYERs2
 /paVJh6UScPJ1C6GHkrlzdaGAB9/yGJrkERZEfSo6LyITVLKfx/lKErDbJuFXmJI5kRPjlrAb
 YQMFMUCJQLPFc0iaeBptmcKcZrkl+IUV0fSULKsHgSbMr3g5wcaJfZepAdZ1S7jYpLaYdSBZW
 4e+YgThqDLQ4IYeL3o9fzjjgNLWmMDJNVN1ESXmYisPKFXXNEQHGizqVUpD0uj5He2D3H17Qg
 ltjMi271bDp96w4e4bBEssuI60lbHE5mhV4mPA386sjDbvuUtg/NlzRikTfS8sB1IYN0+o6LY
 qx37TkHTE417Bo/5hML6VkRaag2UOoDR0mgu9I0ufIiTw6AXX3yE49gBOHO1cQ+uExU39fBAa
 J8ZHhzqPup9D1KzA6HPdY74opOuFnXA6NiNXHceVwIDUseCHJIoKv9B+udEpPKwDnznnn3NQE
 LKBeC4t3ZsxoTaZRd2xo++kwYJH1zjHVGhSscVgfb7Iv5hRLnldm9PBamwKV+xMK+sAvF/C1D
 uD8R6beh27vlwas8pH28sZfVXa6F9xB/9sX94HnLh/Ns73JDHbBbihutTkzQZav9OjzeACnEL
 6CRYq8X1cSohW6Ij2nolgeSQj/dszBGWirRjCmhzYyAotBDgsdpGdccp6oTqO1OxlQvVMnStf
 xZU5uPBOe5UIXZfXyNFQbPLlg7gchy4D+cYa10zRupXVuiEcmRe8t1HcxXH6StH35Sqg4aad3
 +1HZXqLEfl+jmb37y3zdniziDks56oANWsURZfJ6KA66WzadJIGt7i8AuzIZjoGo+/8JQR9Ie
 /VxfhRNZ91A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas & Junio,

On Wed, 16 Jan 2019, Thomas Gummerer wrote:

> On 01/15, Junio C Hamano wrote:
> > * ps/stash-in-c (2019-01-04) 27 commits
> >  - tests: add a special setup where stash.useBuiltin is off
> >  - stash: optionally use the scripted version again
> >  - stash: add back the original, scripted `git stash`
> >  - stash: convert `stash--helper.c` into `stash.c`
> >  - stash: replace all `write-tree` child processes with API calls
> >  - stash: optimize `get_untracked_files()` and `check_changes()`
> >  - stash: convert save to builtin
> >  - stash: make push -q quiet
> >  - stash: convert push to builtin
> >  - stash: convert create to builtin
> >  - stash: convert store to builtin
> >  - stash: convert show to builtin
> >  - stash: convert list to builtin
> >  - stash: convert pop to builtin
> >  - stash: convert branch to builtin
> >  - stash: convert drop and clear to builtin
> >  - stash: convert apply to builtin
> >  - stash: mention options in `show` synopsis
> >  - stash: add tests for `git stash show` config
> >  - stash: rename test cases to be more descriptive
> >  - t3903: modernize style
> >  - stash: improve option parsing test coverage
> >  - ident: add the ability to provide a "fallback identity"
> >  - strbuf.c: add `strbuf_insertf()` and `strbuf_vinsertf()`
> >  - strbuf.c: add `strbuf_join_argv()`
> >  - sha1-name.c: add `get_oidf()` which acts like `get_oid()`
> >  - Merge branch 'sd/stash-wo-user-name'
> > 
> >  "git stash" rewritten in C.
> > 
> >  Comments?
> 
> I read over the series last weekend.  I had some small comments on
> 21/26 and 25/26.  I forgot to reply with my overall assessment on the
> thread though.  I'd be happy to give my Reviewed-by for the whole
> series with or without the changes I suggested.  I double-checked the
> re-introduced "legacy" stash script to make sure it is actually the
> same as it is on master.
> 
> So I'd be happy to get this merged into 'next', and if anything comes
> up to fix that on top.

Me, too. There is actually one patch that is needed on top (it came in via
Git for Windows, which already switched to the built-in stash, leaving the
legacy-stash command only as an emergency escape hatch that is not even
exposed in the installer anymore): after `git add -N <file>`, the built-in
stash caused a segmentation fault.

At this stage, I would recommend to simply add it as separate topic, just
because it would delay the stash-in-c even further otherwise. I
contributed the patch here:

	https://public-inbox.org/git/pull.110.git.gitgitgadget@gmail.com/

Ciao,
Dscho
