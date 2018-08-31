Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10B931F404
	for <e@80x24.org>; Fri, 31 Aug 2018 20:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbeIAAsE (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 20:48:04 -0400
Received: from mout.gmx.net ([212.227.17.22]:40951 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727181AbeIAAsD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 20:48:03 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LejNC-1fZ8lE3Z9S-00qSCA; Fri, 31
 Aug 2018 22:38:47 +0200
Date:   Fri, 31 Aug 2018 22:38:44 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] builtin rebase: prepare for builtin rebase -i
In-Reply-To: <20180830200911.GC22407@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1808312238250.71@tvgsbejvaqbjf.bet>
References: <pull.23.git.gitgitgadget@gmail.com> <pull.23.v2.git.gitgitgadget@gmail.com> <5403014be738425e942a9bc1ca2029dd8d2137bb.1535553074.git.gitgitgadget@gmail.com> <xmqq5zzs94qb.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1808301259420.71@tvgsbejvaqbjf.bet>
 <20180830200911.GC22407@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jdZQi7CmoCrgOoW0HnOJOmsjCZ5+4OJu7bk1wct10sVBHep1gps
 ZddU1v2fvEUCPH8bWexRAY+SjecsXMlJl+qRESKgDL+NNkt9Oc4qut27PsKeBep/dEFIthJ
 6BfrQQRGLreUnBF8m0sWeXTTGamwrtuArqSaJhKfhFodnYuSm6FVY0EX/D2ZtUuztCpvTOi
 SiPHnQiGEHUE5QGHpVjXg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YwSsKsdo2Tg=:04hTp04/oR/+Q70BI+2u5j
 UPvwaYUdxwoYcV8RK5DT+Fn8HGNlj/Bb8dPtpqTdTRWD+JS9R/hkHL4tNB9wEF8CAhNWzQJmz
 d0q5KYo2CCMRuuyKe38pGmKg64thrCpPFFWB9tA1zs+7ArX7bMgpPvf1nMjhrx+z3U3/dXEXU
 nN8KEmqL2n+NdHIXi6SsJjSs4cLW+sBZa+GQP5ZrWskC+HAbwUg6wvODyverg2D71Fbsv6MTf
 SkLGPk5WNEohxM3E+LnBApeSFmuI7tIw/D7KFhG2v6PhABQtg4OnqggoH6U7rjpXm7zj9da+0
 e1NSY0+mjsoc+eRkDb6FZiNROt+n48B39dQlL2bbe2KJw+ANmEOH12/V++QJBVzjzC5/mau2N
 9nliFDTHfCl6K+0ZgPdCoLHS56UityI8zDXnYZ7QPy+cc3cTtqSWQafq2FwrrKxUCzzxIwqPV
 qn3eXV8vomZzyI9xYe5qouvysd5KpP5NeelADXLffKf+ELyBH09RhUSVe58FqyjHgMTbkor6f
 zAaeebg1enCFVzBHoRqjQr8IzOUl5ZX3sRfBGTxAat4G1KtfFf/4CRFcVfV1cJagJeh4nkRfz
 yoyLnwlYrWNHTkDNqU83jY7iwHG1IYFxjMpaxclj6nylvZzBUppnc1krepqpapJfKHwtct13F
 t5guoMtb2hea2HMeuT0EgxxXrgUWtDlrSluSRo4CmLFXchVvw6xYqeYyhxVVwZ9YHnvLPSCpp
 k9Jqfj2SDUUPrZvU9oUDxp9/Jza1Kk05gUUYxcUL1728LByfyFkIcxvTzUhnfgOOaNIQg4LRw
 4NBokfi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 30 Aug 2018, Jeff King wrote:

> On Thu, Aug 30, 2018 at 01:03:41PM +0200, Johannes Schindelin wrote:
> 
> > > Will replace by doing:
> > > 
> > >     $ git checkout js/rebase-in-c-5.5-work-with-rebase-i-in-c
> > >     $ git checkout HEAD^
> > >     $ git am -s mbox
> > >     $ git range-diff @{-1}...
> > >     $ git checkout -B @{-1}
> > > 
> > >     $ git checkout pk/rebase-i-in-c-6-final
> > >     $ git rebase --onto js/rebase-in-c-5.5-work-with-rebase-i-in-c \
> > >           js/rebase-in-c-5.5-work-with-rebase-i-in-c@{1} HEAD^0
> > >     $ git range-diff @{-1}...
> > >     $ git checkout -B @{-1}
> > > 
> > > to update the two topics and then rebuilding the integration
> > > branches the usual way.  I also need to replace the "other" topic
> > > used in this topic, so the actual procedure would be a bit more
> > > involved than the above, though.
> > 
> > Is there any reason why you avoid using `git rebase -ir` here? This should
> > be so much easier via
> > 
> > 	git checkout pk/rebase-i-in-c-6-final
> > 	git rebase -ir js/rebase-in-c-5.5-work-with-rebase-i-in-c^
> > 
> > and then inserting this at the appropriate position, followed by the `git
> > range-diff @{-1}...`:
> > 
> > 	git am -s mbox
> > 	git update-ref js/rebase-in-c-5.5-work-with-rebase-i-in-c HEAD
> 
> Related discussion, including a fantasy tangent by me (downthread):
> 
>   https://public-inbox.org/git/20180727080807.GA11932@sigill.intra.peff.net/#t

I have no idea what you meant there...

Ciao,
Dscho
