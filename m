Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D28A51F424
	for <e@80x24.org>; Thu, 12 Apr 2018 11:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752125AbeDLLgC (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 07:36:02 -0400
Received: from mout.gmx.net ([212.227.17.20]:36929 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751747AbeDLLgB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 07:36:01 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MZ7bs-1elcos3u28-00KzuR; Thu, 12
 Apr 2018 13:35:59 +0200
Date:   Thu, 12 Apr 2018 13:35:43 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Stefan Beller <sbeller@google.com>
cc:     Harald Nordgren <haraldnordgren@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH] Create '--merges-only' option for 'git bisect'
In-Reply-To: <CAGZ79kbt=J5SHsHJTfOZYhgSdn9_gOjVBC3qp_oL0sC-b3ZRmw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804121333340.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180411225534.48658-1-haraldnordgren@gmail.com> <CAGZ79kbt=J5SHsHJTfOZYhgSdn9_gOjVBC3qp_oL0sC-b3ZRmw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Ltljtfb31mNFY4xgpv321kOQZwE7ZvddSNa6F56bVIeCh9hMJwf
 2L48/3kxvtmKXQdRqDNw5PnJaPP9L6//LzsjeKsAgWzOszAbJiPzDLRM1Uf6QDnRaRk3QAn
 woNp7HOGKOhLS6WT6gt/Ha5Y7ATNiViRvU9c0J74XfUbBlYF/1/1hshiAADWKY/VIm5U/0t
 SdLwY195Cuh3VeOAh3XSQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EEVzGLdtTPo=:VdzhZgKeU9Cf+CAOdkFu6h
 VFxvsmmpJJklrbvQzn/z5K75HxVMDE89+hH4TzW/sjJ23iAJigGtf8xnUOBNGXJg2g7josqUr
 xBVKnaSFRYgVWkD3cS1UWINPO9xrJdRjcsKeGfst0tudpvDb4+KAcdf0HnQH726K9TRFNoDyW
 r5hHRN4BJ+MRjUV7Gs8IczpHcgEyaWDkx5VseEyOKoD0SCgJ9POPvPvaWzEA1cxuC1aWsndmC
 IgAig7QLTYRmCFY1DifhpOWksBU8E7E/wClFRegq9ftFTJzUAI4tr6gYCD2jtBPVPNuyZjwDO
 GyrBxiKmzKLkYsdgEg28dRa1pr2ZG0b5fBnzhr9CnmB4SuFu7mQZqXw/X7wo5Wl0GL172QJbk
 J9qL/EG+7uy3lzeXfjXzJgyNYqSTte4mnKIedazXaiMAqAFMa+avct3WfNu9sf3XTuR6r4/8x
 BAd57xm0CnOIV2fG8H4KL/nZNHPWe0dt39OgPNOZ4UxSNl9a153i+k5F3qcGV2k9IyVEtJWob
 F1EnmOBs2qoSWmMSHk9yBoTeuOjTBvLlaFRHNZe/NcwiYbGNkVF1Y1OkG12yfb6oed0TX8dIN
 iOPiEqony9UUj/VuEhGBuhaypPY65wVeq4nzFhvu4xq7LOAEdv9gfud81mPWnTwQSIzw1hqJp
 EqBf5akQP8dF78U9rJ2WmTC61/FxNxbGyaTR6erTEOYJX2OG03Ci3yjlTO6NXs46u2JVmbRy8
 mcbo4Q8W/XtlaeVO6MUS2NthJ6g/I9dr0xcyEpDC7QY8piioyUF2q4+Fe3Cgsa4C6hIraL7vE
 eTYN+z2eKIhgGYJTlFCcya1W8PNBe4Vc6Al3ZiPqaRyvG0TU3s=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Wed, 11 Apr 2018, Stefan Beller wrote:

> On Wed, Apr 11, 2018 at 3:55 PM, Harald Nordgren
> <haraldnordgren@gmail.com> wrote:
> > When ran with '--merges-only', git bisect will only look at merge commits -- commits with 2 or more parents or the initial commit.
> 
> There has been quite some talk on the mailing list, e.g.
> https://public-inbox.org/git/20160427204551.GB4613@virgo.localdomain/
> which suggests a --first-parent mode instead.

I like that mode, but I would love to have *both*. And from what I see, it
should be relatively easy to add the --first-parent mode on top of
Harald's patches.

> For certain histories these are the same, but merges-only is more
> restrictive for back-and-forth-cross merges.

You mean merges-only tests *more* in back-and-forth-cross-merges
scenarios?

Ciao,
Dscho
