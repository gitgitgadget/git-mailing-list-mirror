Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4059E1FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 13:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932387AbeAHN4R (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 08:56:17 -0500
Received: from mout.gmx.net ([212.227.17.22]:61198 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932190AbeAHN4Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 08:56:16 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LwrS8-1ewkkP4BC4-016QPW; Mon, 08
 Jan 2018 14:56:14 +0100
Date:   Mon, 8 Jan 2018 14:56:13 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: rebase preserve-merges: incorrect merge commits
In-Reply-To: <CAJs94Eas59UxZ+490AUSOuB37i+JBEvbCnGBMVpKi1G469OTbw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1801081452290.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <CAJs94Eas59UxZ+490AUSOuB37i+JBEvbCnGBMVpKi1G469OTbw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Gli1EK363vJrHg7P+J6S8JyTm6xXn5YzcFW7K0oN3Zsntw/DckB
 ZAt51aP7NqIxdNEQVTDCer1MvXAdVPg+flt+bxMoymdE7CscNhpDizp9/Bp7Ih93wM1G1nd
 QQ5rF8zPR7JDtsKXZM202b2caN1q3kLhLLmz2Z71T1aiVDoWXcUooj//kOYiy2iP1mtzSRw
 BjlS+ZsW8AL+6IJFHtwSg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nXa8p9wBDTo=:5jbtkjvkT5ZE+huw153Fmk
 Nt01pZ0yZJzOcxwM2VPH2ZIFUmy7H9pGrccc3u0H3G9IEksw5i8uoTNlKhQkusdwc6nV6ufFG
 gRvXrcri9dL13KtHG8Kd4S9xwYZZA7z/fyUfpnDKZJB3OeIUR4+owdulLst4DivfG2I/qvIT8
 EV2mFIgqSa2Xoey0nu0AeA7jmlBTt7JskMCFDnzW+5VHQzhU2l3DTMYeZRbDlH3JquChfmg2S
 DjREFdfLxuDwyyVkazSNE0VFvX+6g0jK5uVF92T1GFFje+feZrAZwMxN2ZFaEsRFlqybBgJL8
 fRh6GdATMOYgukDY4BIsVs6Gx+8VDArsFoV4ZV6+L+SQ2CO4RoZ1eoTdsmjURVqZkVMfE1nJg
 zgm2GoFDF37Ixq7H+LILWJQUbd9dbu5VuqsFlZUh+HdQlR55rpfjCfdBEd3/BaxBGXOBd0dOc
 7oi/yJqANmK0ata7SuFsNP5uw7LSvTgRlEpOMemn/unSqtwWfmCZFmF6areNN2HuE8oDqZEQJ
 iIF2o/7LojfYPOHWYAiWUjtCQgVz1Zi9NejwOq41yDOkZqWhePgZrX7nUthyGlvxWBcixgW/H
 5EPBPdVZS/7z/vFZoo0UCpk/LIdHmGIEKMOd/OCDAD6DgpfbjYeAzExjdtPTfgeSiklJ7CCnN
 toT3twyB3JEz2apFfKdl2VeUZKqg+6lv+c0b1fHXEdOQuBjLlnXDS8/zQEOAaUHX4+nLckunD
 zhXDMoHBZBTNy4bJbcjil6ivDrWzR8c3Qm8OKizzh6MzJ6N1C2JtiFmbX8h7YUYKVm8cIbDpv
 Tdgi4B05g5e6Sx6J0TIH6DT534r/RVPohxvc6usSOoodyu48Q3i6UGZH/PX6gOZvewn84Yy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matwey,

On Mon, 8 Jan 2018, Matwey V. Kornilov wrote:

> I think that rebase preserve-merges algorithm needs further
> improvements. Probably, you already know it.

Yes. preserve-merges is a fundamentally flawed design.

Please have a look here:

	https://github.com/git/git/pull/447

Since we are in a feature freeze in preparation for v2.16.0, I will
submit these patch series shortly after v2.16.0 is released.

> As far as I understand the root cause of this that when new merge
> commit is created by rebase it is done simply by git merge
> $new_parents without taking into account any actual state of the
> initial merge commit.

Indeed. preserve-merges does not allow commits to be reordered. (Actually,
it *does* allow it, but then fails to handle it correctly.) We even have
test cases that mark this as "known breakage".

But really, I do not think it is worth trying to fix the broken design.
Better to go with the new recreate-merges. (I am biased, of course,
because I invented recreate-merges. But then, I also invented
preserve-merges, so ...)

Ciao,
Johannes

