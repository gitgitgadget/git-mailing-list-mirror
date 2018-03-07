Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28DFF1F576
	for <e@80x24.org>; Wed,  7 Mar 2018 07:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751023AbeCGHKT (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 02:10:19 -0500
Received: from mout.gmx.net ([212.227.17.21]:36115 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750984AbeCGHKS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 02:10:18 -0500
Received: from [192.168.1.106] ([88.26.243.156]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MfAog-1f3yun3h7K-00OpKo; Wed, 07
 Mar 2018 08:10:12 +0100
Date:   Wed, 7 Mar 2018 08:09:57 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate
 solution(RoadClear)
In-Reply-To: <xmqqzi3k23fu.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1803070804440.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87y3jtqdyg.fsf@javad.com> <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com> <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com> <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com> <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com> <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com>
 <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com> <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org> <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net> <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com> <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com>
 <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net> <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <xmqqzi3k23fu.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:lRdGc+MhjYhmZmYUG+68VtDvjXDhUyQyXZ+3ebruJ/PWr09ecMr
 5HQXdQimUMzthNLV2+yTUSi0pQ4m5YTAyoOlz4BUBxcigE31IXE/kkFWlKDPXH/EY9usKcz
 tOknxWbTayaSMGDJ4bpQbWCgiaYtlmvCtL4h55/94imxTzrq2QC4hXB1MEDJYEs5DI1dPMM
 0VX0gVg8M6j2eE/iUZiuw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ChJbHQ775CA=:hW5Fk+6chkhZvO0pt9eHQN
 uma9wVzQMQcoz5Yss1UjNcxTDrO9scLPerG3iUYu1HJCobG4yjgLfUyC2JolKpU9/3VgyfCFZ
 +WdQyvefFimU5UnvGFInQAmznj0nRhnyhBbYLA1XgljxhOZ/1c9+NK5Fc73/WG3Xlx5NFNMyv
 kP94Kjsu8U4leGCJDMK1FD4/FT3Lazhu/JeAs1SMJnxTRLPlRiuVkhKyXpcy79ornBseXb5Vm
 z7a09mQsWvO8pxUMhlTI6UqGtw5Yjn10YgCy34fVBPnrTZHHwxAARGcLzGIjjhu18se5nCTsB
 g+8C4q1JgjFP1FzCNYejbq4ngtf6tqNK7umuGzJGVy1iHmF30qYaHwsxIjR1B8N52EqLfIUYi
 WaBNjisYUu9+kvm8k1qT4hzNQ95M43S9Y1ZUQHK1glpHx/ApkffzbW9pa+uXfaO7uhagDnPl4
 Z1P6HvSPWMvnxOOnWXgA09YcopqnDO2MAqobqCKoyNyu7//2+200JcHoCUVO12r59sOkLqABO
 wBxDK3DXym2gG3HFUYp7UGc2EFR2xvIkbHAfP0wkKwQdqS+L95y2bbLhBkmDr1hj+NtQCM+zg
 f4U0MBiNjEQKcvW0vBLZ4HtfbvjX1b6jsFdclnATsoX/ZjG2mfAcxuM4uqGVL/O/2esIWhhHI
 2o6QWkqFh/xw4Rjp4ZsYuycZpWiMpJRwI/I/5HrGbBWHvjCyjHsY5pcXmNufDzVhYJd7Ot+c1
 JuF5TXsgsVJDrikMjDup320o3Rbqbjo0D+zsFerViL84JRs99gdhI527W2HG+NZZEdQ1iV066
 vOgOBZs/Amql2UycPesO5WEOft7rBJlowf1G/OICwgXws4Mmwo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 6 Mar 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> I don't think its possible to guess the semantics of the original merge
> >> as users can use custom merge strategies and amend the result. It would
> >> be possible to detect and unamended '-s ours' merge but special casing
> >> that may end up causing users more confusion rather than helping them.
> >
> > FWIW I agree.
> 
> I think it is a mistake to sacrifice predictability only to add
> cleverness that sometimes work.  Elsewhere in the thread, I think I
> saw an argument to treat interactive and non-interactive something
> very different, but there is no fundamental difference between them
> (it is far easier with interactive to force the command to "port"
> each change to a vastly different context) so having consistent
> behaviour between the two cases is important, too.

I could be swayed both ways, but Buga already pointed out that we do not
have to compromise any consistency, simply by adding some syntactic sugar
to the `merge` command so that the different behavior is *explicit*.

> > My original plan was to always merge recursively and suggest to use `exec`
> > commands if anything else is needed.
> >
> > But now with that excellent new idea to perform successive three-way
> > merges of the original merge commit with the new tips, using the old tips
> > as merge base, I am considering to change that.
> 
> OK, does this mean we want to wait before merging the "recreate
> merge" topic down to 'next'?  For more than a few weeks, it has been
> slated for 'next'.

Maybe a few more days.

My current thinking is to rework the handling of -c vs -C and *not* have
two different todo_command enum values, but rather introduce an unsigned
integer that has flags such as TODO_MERGE_EDIT.

And for this new behavior, we could introduce a new flag
(TODO_MERGE_REBASE_MERGE_COMMIT or something less unwieldy) and set that
flag via

	merge -R -C <commit> <merge>...

(i.e. via a new flag `-R`).

I want to discuss this in the other subthread, though.

Ciao,
Dscho
