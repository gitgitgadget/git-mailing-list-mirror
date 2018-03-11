Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D86E71FAE2
	for <e@80x24.org>; Sun, 11 Mar 2018 12:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932216AbeCKMA2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 08:00:28 -0400
Received: from mout.gmx.net ([212.227.15.15]:57415 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932126AbeCKMAX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Mar 2018 08:00:23 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MU0pN-1f3cc80jqL-00QjXL; Sun, 11
 Mar 2018 13:00:13 +0100
Date:   Sun, 11 Mar 2018 13:00:16 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
cc:     phillip.wood@dunelm.org.uk, Jacob Keller <jacob.keller@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate
 solution(RoadClear)
In-Reply-To: <29bc6661-1d78-8f89-194e-1dcc9d88c34e@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803111256410.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87y3jtqdyg.fsf@javad.com> <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com> <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com> <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com>
 <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com> <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org> <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net> <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com> <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com>
 <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net> <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <754e2735-1288-9a8d-c8bd-ab39cf733812@gmail.com> <nycvar.QRO.7.76.6.1803070810550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <c5a5c2cc-6a11-440f-5b9b-964ae1ca07dd@talktalk.net> <483674f8-4097-a374-c8f3-cf56cbb92042@talktalk.net> <29bc6661-1d78-8f89-194e-1dcc9d88c34e@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:cT2HQpCyBCMgoRccWecugcwnlvqOUvRUFHQHVtXtqYbcD5r5HvL
 u4WgQnQJcFBbs1JQFMJg2y5jE9Bp/TK0oZ94/QliMjFiLU4tR+rTEDKM2TqAYZYhtWGv+Bv
 rWtUnU/YjtV17di6Jl2s2RhWiujWJQZie7jjfROjilLQeeynmaOh22gt3ldssUgMnk7U0zT
 prXEn2whI6OBQlFeNSUGQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vvyMDFjW9PI=:kBr8OthwVg6e83Ho30JsIu
 a4/Nq3mCp4g7+HxXKAsDRdXua9+sQjj2R5dbvS47zB7bQrjFQwATLsqWwHV6BIxxWR0AY3kEv
 XATJxfq9KVnOKv6J4RPPJrlnvnQRPzb52A3UISLai0gS8jTjoXnxlT28ZtS+EtmUXq5FIdxoF
 fXS+QEJBrnqZRyb5t0xjUOjNyv30c3P7BzMUUbVm7mQ/nNT0vSRw83PXpJw/FCfzqLHPXWOab
 BkRdLHKFhS37UPxmo/+BHdF8adMVb5ZgpvGWrdqmPc7wLjhfimRZCW1dQnCUTujMhneYOuRh5
 vJ9UfUHpewAsD1ddxP2Wf0boQSLPSArvBMYXEg9weTltutDRYnVBDMPMpifJdutP+EaWCCvPT
 zKqOcrZAtlqGVhkA/RPaI+r4R8a9HolebKAcS54WFA0sNvjZnzllV+/HdINplcfBbJ4KFQZe8
 PuPn5wdJzJ7Vc1/MdgY4YxINLu1dUdhwiVqcLE0PNf1lKtmKFVJzQScC491rWQWJ6koGdFwjP
 umjTeEmqnit78Pzr1r/PATqBtu3UU4pGo85ocpTmmh22DgYYj1wvp6eNzXqaNx5w7V+wgopFB
 h64CH4jNSR+Iv5bsHJNX6816Of/ahW75iqXcYfl862pWrv5adF5XMgBBSWnMLsP5I14DXhIQF
 vtyor8hHr0RTh2fVRZF1z1+ShpfMDEcGEcRbBe+xdFSSWJxQSqsKHBxBWzo6h82ih6/xDlYSN
 bE4Mb+j7+VD4McSj5fqqCtuV89OTKE+7JKEYfe0bKguRSazPm+7cri0Fs91rlZZOraWM01JSU
 WrZkPoG0AgM+buJeD0BEhkAL1nWpdN2duRo1+MUwkIQZYKKHXkp13AGh5f2I+RUZz3kNcbq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Buga,

On Thu, 8 Mar 2018, Igor Djordjevic wrote:

> On 08/03/2018 13:16, Phillip Wood wrote:
> > 
> > > I did wonder about using 'pick <original-merge>' for rebasing merges
> > > and keeping 'merge ...' for recreating them but I'm not sure if that
> > > is a good idea. It has the advantage that the user cannot specify
> > > the wrong parents for the merge to be rebased as 'git rebase' would
> > > work out if the parents have been rebased, but maybe it's a bit
> > > magical to use pick for merge commits. Also there isn't such a
> > > simple way for the user to go from 'rabase this merge' to 'recreate
> > > this merge' as they'd have to write the whole merge line themselves
> > > (though I guess something like emacs' git-rebase.el would be able to
> > > help with that)
> > 
> > Scrub that, it is too magical and I don't think it would work with
> > rearranged commits - it's making the --preserve-merges mistake all
> > over again. It's a shame to have 'merge' mean 'recreate the merge' and
> > 'rebase the merge' but I don't think there is an easy way round that.
> 
> I actually like `pick` for _rebasing_ merge commits, as `pick` is 
> already used for rebasing non-merge commits, too, so it feels natural.

Phillip is right, though: this would repeat the design mistake of
--preserve-merges.

We must not forget that the interactive mode is the target here, and that
the syntax (as well as the generated todo list) must allow for easy
modification. The `pick <merge>` approach does not allow that, so we
cannot use it.

The `merge -R -C <original-commit> <merge-head>` approach is a lot better:
it offers the flexibility, without sacrificing the ease when not modifying
the todo list.

Ciao,
Dscho
