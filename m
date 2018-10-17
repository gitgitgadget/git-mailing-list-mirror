Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A81D71F453
	for <e@80x24.org>; Wed, 17 Oct 2018 10:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbeJQSNt (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 14:13:49 -0400
Received: from mout.gmx.net ([212.227.17.22]:56195 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbeJQSNt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 14:13:49 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MaW7Z-1fx6wH2bur-00K8cs; Wed, 17
 Oct 2018 12:18:44 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MaW7Z-1fx6wH2bur-00K8cs; Wed, 17
 Oct 2018 12:18:44 +0200
Date:   Wed, 17 Oct 2018 12:18:47 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Daniels Umanovskis <daniels@umanovskis.se>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v4] branch: introduce --show-current display option
In-Reply-To: <CAPig+cRwy2Xhq7uJJ0OfY2nRZgPK9yHr=G+KMKuWx-PXyWv8Gg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1810171211440.4546@tvgsbejvaqbjf.bet>
References: <xmqqva68dqip.fsf@gitster-ct.c.googlers.com> <20181012133321.20580-1-daniels@umanovskis.se> <CAPig+cRCfO=3BB6bvDSKLKkhiSA-4=p4-zZkAXvN446_6B1_HA@mail.gmail.com> <xmqqk1mhxzcz.fsf@gitster-ct.c.googlers.com>
 <CAPig+cRwy2Xhq7uJJ0OfY2nRZgPK9yHr=G+KMKuWx-PXyWv8Gg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Vcq7RXAUQNXUbHQk5MAw2mHosQZSSt4A99IvaZ+K9HmUWfYHcTu
 NeEjHNeVUbQqDh32SppLjslbpCdDN1XNfLyWHSS5ygkEathRbGvruizJEd++4cW4um248KW
 s/fShx5QxZrnu/o1WDgFu4b1/loOrvU6Bk+/aUPR1pdqyiWM8w0nhRhkH/gY5cvcvagcLDJ
 hWELnGqlCstyRWQGkosXg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Dx04AXPAOVY=:7SAdraIVqZUpsOZ7hytBIk
 zX7LCb55EBKYoTSGJ42E2kRtIP+4nSl8NCb6BwTiQJHF/ZMDJ7WTp13/4OD2ANWgeMMcnYRm9
 7oD5nsdeApST4+qDLGuaNqnUaeT6VHGbAdZ7AgK7Rjn06N7TwQ5GuFAdixQnpCr4U0wTNfp3S
 KSHVMGpuMrb+41DP4CoQQpiOR6LA5P2LQqui4aU26QXoM9bUKdTFquox7Yw0TmxXB5g2NtvrH
 EoIbGFASUvIZ7dLaAPLkd7Dpl57AGFp06zusRYMagatlQRKouF0WIITpXhRCadpcJGrD45rVI
 AEJfZdkf3r+8OdQJjLKVkIYgMhOulaSfHkv/vElpbEWyR94OXponBHwKIlDkaMnjxuiudoczB
 69J6lgFn0QLP2JtPEssWg9j57C58WfqGS78q82FsSLDTL7FtJocCIa5eH9sgzyTyJTrxsDlJB
 vB2s+DMaWdXeFRQECbgsba00PwZUBBGvfx2HZzdmXtMWyqjnkp1xm/J2rLXXWiEFqhlAC5uoU
 7UVQsxnDae1IfCY+xeRQ1D73FOZlLWsbvoB4wey3Zjg+kMlMOdbrFyzkDU4h3ScOSyPC1785v
 zZbvZqPSXNXJlqymdiUiTu7+JvINgS+0Lvr2WsVhzTeuDxCZNks9ZrX8LWtGz4FLVRK6J2Lm3
 /SEQY97Y8kGCrpwzPbBUzMgGcOWWyTBpAhQNh2tP8gplb6ziaCYnnMJA+749zYea3m9ks6Rq3
 GtHkLEqPDKLqZ9K6ZEQ/pPMjt6JPSkZLFhtiz9JPA8thsBCpPEtvPfL2+tQM9hRQRP7HlyK81
 xHBN0z9Uzts3WTTUhlZrC0VvMciIy/GPY4una7gkITIc98DWTA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Tue, 16 Oct 2018, Eric Sunshine wrote:

> On Tue, Oct 16, 2018 at 7:09 PM Junio C Hamano <gitster@pobox.com> wrote:
> > Eric Sunshine <sunshine@sunshineco.com> writes:
> > > This cleanup "checkout" needs to be encapsulated within a
> > > test_when_finished(), doesn't it? Preferably just after the "git
> > > checkout -b" invocation.
> >
> > In the meantime, here is what I'll have in 'pu' on top.
> >
> > diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
> > @@ -119,12 +119,14 @@ test_expect_success 'git branch `--show-current` works properly when tag exists'
> >         cat >expect <<-\EOF &&
> >         branch-and-tag-name
> >         EOF
> > -       test_when_finished "git branch -D branch-and-tag-name" &&
> > +       test_when_finished "
> > +               git checkout branch-one
> > +               git branch -D branch-and-tag-name
> > +       " &&
> >         git checkout -b branch-and-tag-name &&
> >         test_when_finished "git tag -d branch-and-tag-name" &&
> >         git tag branch-and-tag-name &&
> >         git branch --show-current >actual &&
> > -       git checkout branch-one &&
> >         test_cmp expect actual
> >  '
> 
> This make sense to me.
> 
> > @@ -137,8 +139,7 @@ test_expect_success 'git branch `--show-current` works properly with worktrees'
> >         git worktree add worktree branch-two &&
> >         (
> >                 git branch --show-current &&
> > -               cd worktree &&
> > -               git branch --show-current
> > +               git -C worktree branch --show-current
> >         ) >actual &&
> >         test_cmp expect actual
> >  '
> 
> The subshell '(...)' could become '{...}' now that the 'cd' is gone,
> but that's a minor point.

Maybe not so minor.

I realized yesterday that the &&-chain linting we use for every single
test case takes a noticeable chunk of time:

	$ time ./t0006-date.sh --quiet
	# passed all 67 test(s)
	1..67

	real    0m20.973s
	user    0m2.662s
	sys     0m14.789s

	$ time ./t0006-date.sh --quiet --no-chain-lint
	# passed all 67 test(s)
	1..67

	real    0m13.607s
	user    0m1.330s
	sys     0m8.070s

My suspicion: it is essentially the `(exit 117)` that adds about 100ms to
every of those 67 test cases.

(Remember: a subshell requires a fork, and the `fork()` emulation on
Windows requires all kinds of things to be copied to a new process,
including memory and open file descriptors, before the `exec()` will undo
at least part of that.)

With that in mind, I would like to suggest that we should start to be very
careful about using subshells in our test suite.

Ciao,
Dscho
