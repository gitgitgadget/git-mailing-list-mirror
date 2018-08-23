Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D518A1F954
	for <e@80x24.org>; Thu, 23 Aug 2018 14:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbeHWR6L (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 13:58:11 -0400
Received: from mout.gmx.net ([212.227.17.22]:58061 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727597AbeHWR6L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 13:58:11 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LwGDy-1ftFVE2t0o-017zA7; Thu, 23
 Aug 2018 16:28:10 +0200
Date:   Thu, 23 Aug 2018 16:28:08 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2018, #05; Mon, 20)
In-Reply-To: <xmqqin42ko8q.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1808231626360.73@tvgsbejvaqbjf.bet>
References: <xmqqsh38admf.fsf@gitster-ct.c.googlers.com> <xmqqo9dumh9z.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1808222339490.73@tvgsbejvaqbjf.bet> <xmqqin42ko8q.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:z3sCRhUewjlsmDCrXLg1ZBYAfefE3EWX7Sw0mZjm7bHCisWo65r
 kOsGPJA8jTNjv2kabDLWqiGxxPBS7XO3406NmqhY/YVMSkNkluukCaE3ch9Ol5vNmMUhvC2
 +jWoqWXNEDMGrMOYa4y5yIFoxGGq3hO67/v2gks1VC2B9QiCPtMp9hKRFeuyuRCEKYvseJ+
 4NvTwwC8q8IJ8NH2ZgI/g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:h3J3K8bLOQ4=:3P50+6UMdjKU8xaNg8bCuq
 wXIMg0HUo7jgfIs4mkB+N5vdLr0wt6/Go/xnmcYzSzV26qInJlHWBJF0SVMpBeYYqj/YkYhxU
 L9QCiuOekPvNoXy7OaBCeEes2UcK8tquhU1SZb93aR/MhtozPV/zLV1/V9A7uvDlvESbP6JvW
 McxJXhqxKyB1oI3IrtspkrUZZ8EapSh8ZhKDdp3aQX36NwDsz4Q23+zzN62CzGR09nrdYpelY
 +F5SPRWpv5un3Rak3dhlt5lywM7iaa0TvNaE5FcdPLAreBj6fOSzSuRqXpYkmpbCsFfWlVALL
 hzOoUhfxNntAErC5aVwAQkUUM5j8a+DESGk73oawsSqmST7jlMAa+R2E1SERADgeR1CEV4JFw
 RHwM/AiK3hak4RgeOg0AW98cS4uWfeDTT3wrpc0Dz5CIv8WDaN0fWHYzVpskPQSuSOjf8bo/8
 cC+4gfO6Enr2LVJqRwievCOQZHp4mLy4tIVE75TD6d/LII43lIGoHnzAtFCyK3kQwce46LHkl
 Z/1w3cxOPGdSBKYR13rg+vcXO3bBBTg6RsKNFTXCNqkhKLJgZ+NzehchgxTmLcg/CdAXEAg/+
 eggJyEGZ+jpOUQ0ANJ9rVwKebzShjgJHOYHZvFu/UZBIi/Md9wS7V9nTwP6qScTslw9UOgy8S
 A7cTdQiPsdQM1wNJg9drer7jqiM/KpclDhTWfPtuq2vPUzaQ+0U1Xdu6sw3AFLa8+rUAGtKjX
 f+VuXJE2VXPY2+4TjVF56jdZLzWIdxHcvg3iRBCF6OEkKVCbJp4vBENElhtP7KgJnrGWH9tG5
 M9xa/X1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 22 Aug 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > FWIW I am a lot more bold about these builtins, and want to get them
> > into Git for Windows v2.19.0, either as full replacements, or like I
> > did with the difftool: by offering them as experimental options in the
> > installer.
> >
> > Maybe this will remain a dream, but maybe, just maybe, I will manage
> > to do this, with your help.
> 
> Heh, I do not think you need much help from me to cut GfW releases.

I know. And that's why I asked for your help with the three massive patch
sets in flight that convert scripted things to builtins instead.

> In any case, thanks for a quick "last mile" patch, which unblocked
> 'pu' that has been in sorry state for about a week or so.  I've
> inserted a new topic branch between -5 and -6 that (1) merges the
> other track into -5 and (2) applies your "call it in a new way"
> patch, and then rebased -6 on top of the result.  If you have a
> chance, it is appreciated if you can give a quick eyeballing near
> the tip of 'pu' today.

It looks good. Thanks.
Dscho
