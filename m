Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE4E81F453
	for <e@80x24.org>; Mon, 21 Jan 2019 15:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbfAUPde (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 10:33:34 -0500
Received: from mout.gmx.net ([212.227.17.22]:44529 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728848AbfAUPde (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 10:33:34 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M4kfR-1h8FGf2ap3-00ywX2; Mon, 21
 Jan 2019 16:33:28 +0100
Date:   Mon, 21 Jan 2019 16:33:12 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jan 2019, #03; Fri, 18)
In-Reply-To: <CABPp-BFmYoeiOaB9Pf70TC3XftXjMEHGrPqxS8TgiiXR39q2rQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1901211632140.41@tvgsbejvaqbjf.bet>
References: <xmqqfttpimdc.fsf@gitster-ct.c.googlers.com> <CABPp-BFmYoeiOaB9Pf70TC3XftXjMEHGrPqxS8TgiiXR39q2rQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:tyUjEL5zmzQWfEDKwv6bGXUhfHF1xnKuOnPSPavbevjAfAwnMmn
 qMepvj9rQ7x+1qcJaSy39hGiRE3PuxzI7nA8dgOVN8qhg3tO85OM3dqdVZPHSmg2o8Z14Ze
 9yzn8wBw1zSsP95b1dZdCSy9xKaFbHllhuVtMfeUdSVFHpJRNFxL4nwpG2MmerGJpqdEK1+
 0VARgD0gli3yM1toegKQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MhxIBoGI0yc=:juPYGplOG/DVBcx+0QP8s/
 FifSe6wPqHPL2xwDVEEQnC/P87YCHfrzkUbVXOf9jq3ZOTvbWrOUfesE+d2Jj84wCR/iqfxoi
 py3DrciDcHlO65jVB33A5wDkTTVhbc4s+hOsZjLXy3tBHxnUHQTS+OrsSHyXbhmEw69iTHvm5
 GrCP3VH4018JELpdeqpbSiBliXaCbvUEMng8wjyqzvbrKqf9+eGqsEbTfwWvm79aBTcdWZF0Z
 IrHCd8GXcqKfBvVeh1BMhJUGW1kHPomVK4VO83jmctJWCzy5FIX5w2zWBE12JXkuE005Gbh4k
 3lUp7H8rFCGimfoEnDmEOQfIy2dFMtHJy4Y4arJ2j2lvooiN3zqSylbSnVyUfp4Mq9apPsm6g
 dZhdAZ3K4dDbPxdIzI3F3IRG+oH9YUjqQe/pVPpL7vUMYS0F2uxaSXNu/XlKIbspBRxr43lNY
 050Ye0B6BMtofsXShDkNqfdd623u0AIBva0CXhlrVu0LlkBFAsEaEGuojhZjAMotrj+xVvX5K
 GMPYbfpeSld58hSdVEGI8e16WpdPw7EhHew3LXKBjnl+W43EhxZxtm0Y9M2Kd9I0EjGgodmD5
 L+WReQYyGxPul2kwLvOHqkOLUJ/+qGUNGYCKpbX+oQUtTVb51jKaqztkKBoW1NXC29FVx/y15
 9Xkqio4dnJNDRzoA6UBDJzKaeEu4uCHSgptv+1FJ0ltQ+2ZD6GbNLwNbOzQdhAn2CLPFacjj2
 pxpZm2aJuJhFieuCbAqqacu+4SwU/1B5gyIazr5amF0os/kvajs0B2ZYEe6FE0CTHbDO/t/O9
 WKhuAJJbNYKkui8aIT1tQETURt+xCeHWD1NiXdawkDu8fVlNrBgxB8ftRtS0NX/SRlqT7QnSP
 G+rliSL3B6SyugGo/718BgH8ovs6wLXWlROk7X5ZFNKiitClXCye5PQYN7Mdk+QTv+Nnd1+GQ
 /wR+wHCFNUg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Fri, 18 Jan 2019, Elijah Newren wrote:

> On Fri, Jan 18, 2019 at 3:22 PM Junio C Hamano <gitster@pobox.com> wrote:
> > * en/rebase-merge-on-sequencer (2019-01-07) 8 commits
> >  - rebase: implement --merge via the interactive machinery
> >  - rebase: define linearization ordering and enforce it
> >  - git-legacy-rebase: simplify unnecessary triply-nested if
> >  - git-rebase, sequencer: extend --quiet option for the interactive machinery
> >  - am, rebase--merge: do not overlook --skip'ed commits with post-rewrite
> >  - t5407: add a test demonstrating how interactive handles --skip differently
> >  - rebase: fix incompatible options error message
> >  - rebase: make builtin and legacy script error messages the same
> >
> >  "git rebase --merge" as been reimplemented by reusing the internal
> >  machinery used for "git rebase -i".
> >
> >  On hold.
> >  cf. <CABPp-BFckuONYcGGkCY3BuPypRULmhsk_OFHyYA2E4jM66BfeQ@mail.gmail.com>
> 
> Is the "on hold" comment still accurate?  And if so, can I ask for
> clarification on what the hold is so I can know what action if any I
> need to take?  The two things mentioned in the linked email that I see
> are (1) the need to lower-case part of the subject (which you squashed
> in already to create commit 68aa495b590d), and (2) the semantic
> conflict between js/rebase-am and my patch, for which you already
> squashed my fix into your merge of his series and suggested I not
> resend and just let the rerere logic handle it (cf.
> <xmqqmunxluj8.fsf@gitster-ct.c.googlers.com>)

My sincerest apologies. I really wanted to have a look at them, and then
got side tracked every time I checked my mail. The Git mailing list really
is a little bit like a fire hose.

Will have a look *right now* so as not to forget *again*.

Ciao,
Dscho

> I'm beginning to wonder if I should just resubmit patches individually
> or take some other dramatic action as the combined amount of time this
> series has been on hold has been quite a bit longer than usual for me.
> Suggestions welcome.
> 
> Thanks,
> Elijah
> 
