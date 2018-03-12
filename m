Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 591A91FAE2
	for <e@80x24.org>; Mon, 12 Mar 2018 10:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751247AbeCLKqH (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 06:46:07 -0400
Received: from mout.gmx.net ([212.227.15.15]:54179 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750995AbeCLKqF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 06:46:05 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LcShi-1eBreq1pvK-00jo0F; Mon, 12
 Mar 2018 11:45:58 +0100
Date:   Mon, 12 Mar 2018 11:46:02 +0100 (STD)
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
In-Reply-To: <b329bb98-f9d6-3d51-2513-465aad2fa37a@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803121142550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87y3jtqdyg.fsf@javad.com> <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com> <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com> <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com>
 <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org> <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net> <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com> <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com>
 <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net> <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <754e2735-1288-9a8d-c8bd-ab39cf733812@gmail.com> <nycvar.QRO.7.76.6.1803070810550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <c5a5c2cc-6a11-440f-5b9b-964ae1ca07dd@talktalk.net> <f3872fb9-01bc-b2f1-aee9-cfc0e4db77d6@gmail.com> <nycvar.QRO.7.76.6.1803111301340.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <b329bb98-f9d6-3d51-2513-465aad2fa37a@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:nqDBojiiBXk4PT5ETvtuvNjBr0G88cn8MegLl/GIvMJmSpVMjYS
 vDZvphMc3/GQtPf/eo4R7TPbMIgu8puyz53uHgR8fh07zyGo6nFh4ZxZMIKwXm1OGvSUONg
 LX8CIcvD9FpRikGNJkkOywyI2EnmtRTr2tlwbtNnxpdxCVBGYTc5tjusa/Lj74MRHMNPv22
 kdNnTABkFuSpZGM4xKLTA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WzSkXTNRe0E=:YBQn7281BQiLWMim5M7pkQ
 ths5ZoGVkGVi6yx3qt4O+rLlecxO5ZnFrkK2Ox/ULBjU46UtKBmqrRnj537FVvKo4uM52LDad
 Fca2xyH+KHjsbP9Y3G7Aefs25aDgKK1u1BGCuXZ+ynbgqjy1d6p8MxlO8xgxVY3oX7L7B5C3z
 8LBc9TxdujSj1aHdjTSJFXA0pwfBd8DmNTrclMb5vujbxrARwA8eKyDNwj5EPaPmJdEaPFqHB
 3iRtrtMK7i6Lugqtd9Ws1Tv8lrS0NCpqudDAcv9qqNF5Cjzs34RqRu93QRolqWkKRQ2XgyQ1M
 G7uWnnhkJ5WZRZWMD4Zv5zDCQktQQ8Xt5C6r2G5G91zkN2fIQpRJPU7q6x+EQPYH5gTzt3zxB
 6UeOkJD+nDsOfwDv0sP/0Q+WjUWa0/Q7EChiN/RHLrPGiZ2wO1Hfdm2ZoqVD+9ZaEbrj41Vuf
 t6D28MbQ+vXNVs29MWie/1zuEsBn++/36T9eGWbfrugF+gSORRcFVitkBZN4kz/CphwtAoB9M
 R9ff8yB4WUNc7HeSVBBDbliyEjNfR1yo5uicMvEOolZtQlWl9hO/FgDtYCrN/CWE3MJyzw+QX
 33fOmpRr8iuGhr5x7Ty0X/IJI9iXR4HPdp9hjT7rxIQ8XsY6Oyz/apQSawarz/F4nrK5F8/wG
 Mv6wqn7lmodoqmg1u2T+w/LnLhUHPV2uBKBtoBXzH6DL/SWLw0sIPGQArVOSlYWkAmeprjdJU
 GGJyuhY78TCvQeXz9tzDUQ4iAUR0hxzQvNTzG9BgAvs/yU1aLUlF6goPUVM+WLEHWz/hb8pBH
 oKxShhM7iuX/t9IBGLz7GCrsg738OwiOKRP7fJjKpBYYJ7XjMECxoZZ+XCRib3mtaDN7kmZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Buga,

I just have two thoughts to contribute as answer, so please excuse the
heavily cut quoted text:

On Sun, 11 Mar 2018, Igor Djordjevic wrote:

> Sometimes one just needs to read the manual, and I don`t really think
> this is a ton complicated, but just something we didn`t really have
> before (real merge rebasing), so it requires a moment to grasp the
> concept.

If that were the case, we would not keep getting bug reports about
--preserve-merges failing to reorder patches.

> Saying in favor of `--rebase-merges`, you mean as a separate option,
> alongside `--recreate-merges` (once that series lands)?

No. I am against yet another option. The only reason I pollute the option
name space further with --recreate-merges is that it would be confusing to
users if the new mode was called --preserve-merges=v2 (but work *totally
differently*).

Ciao,
Dscho
