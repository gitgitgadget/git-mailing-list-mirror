Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 349BF1F51C
	for <e@80x24.org>; Mon, 28 May 2018 11:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424688AbeE1LVL (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 May 2018 07:21:11 -0400
Received: from mout.gmx.net ([212.227.17.20]:59081 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424578AbeE1LVA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 May 2018 07:21:00 -0400
Received: from MININT-8E55E86.fareast.corp.microsoft.com ([37.201.195.106]) by
 mail.gmx.com (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0Lkfii-1fxPu23HUK-00aTAI; Mon, 28 May 2018 13:20:42 +0200
Date:   Mon, 28 May 2018 13:20:41 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     peff@peff.net, git@vger.kernel.org
Subject: Re: js/empty-config-section-fix, was Re: What's cooking in git.git
 (May 2018, #03; Wed, 23)
In-Reply-To: <xmqq36ycl4ly.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1805281319530.82@tvgsbejvaqbjf.bet>
References: <xmqqwovtudia.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1805251430420.77@tvgsbejvaqbjf.bet> <xmqq36ycl4ly.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:JPXbV5aqfUaH6hAwDAT03cDWaWTkpCRnI5W4hdHBVOKFKCkLlys
 Zlmm0EW8oX2YRZ4WaOBEAxBZBMJMGRbKLM1pVwWPNcgXea0sqn4XvbE5/CqHFDUZDYSU+Qy
 NJ9rP8GFA4tL8H0k0m/wv26W1NXug58iA3jJG2FBDmUZ6aXuTn2HxyaaaCOL8GXrwvfc+3x
 rtJwu/l9su3+neAXjx5cQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mjGI1nsEuM4=:Q5Y5up6h5LVRX70vnk0enY
 6TgVy13hyFVHtqv+AwvmM9Zp7ZbcQBKuwQKH8COmr1XOMbOtnZzA5ewexcJ59vCFZIBlDxnJt
 OHEyo6wcUlYw8+eGY64P8u6fNy+vp0avjRYQu3BmGJd5UJ8yRVNrZhKTn/Eehd+hxsLMY2hGv
 p/8zMnnr6/k+cUIj1ZWWFl/l/1gFrhx6bctIW5MaPmpu9rGuc+yTZnIUGc+jNWOa9t2BFOFGa
 c4SevSWu6EBGsEjsJ4NEyaTc3uFQZMzq1IEIS1QILC1sdY0QC8AP6RgVUV+3YubRUq/ueBEWV
 lQNrbPm+M43jZdFQMiWI6cX3TeY8cE/hHjKJC4FC2XNPQMRq0skKg4A/fneu+tzFhbWbpOzor
 yx/rmqKyr5LQfuzXPq8RkQ7595YPa4ltBuDCVigPYvevj66+wF5edX4Mz0mjyKtnmn+u72IBA
 RXrFNMxFbUxWagE0HGoH0AZ6qK/s0rKGwD8qzqVZEUFlB04ldQs8DjvWkwdRlLVJsMsw4q8t+
 Ad7K8LMwQ0t9rFDv0qLMtbkufHGj1Hak6pgXvcjheVfWA1p25BjINCnR/kHQ+aW9HEYnExWvn
 KxHIPS3R1zji7pXRsAf+Ft3WrF1DO89b+sCcr/WgjBABj4fySdAzuCyy80IxWxQTPiuDN90Fm
 xr2p45xZdicl3VL4/HVsN0iPjsCCKKDyXwf9zXZBVzi981M9ooBs8ThmMRwakCRiiQJ+g260o
 5xEeVFQ4YsaOrOv8bqfV9beGuXZd9zLE1Qfkn+B7xQYGF9wi/PqAZjS9AuTD2zdEQ+vMOdrsf
 9rSrcj7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 28 May 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Thu, 24 May 2018, Junio C Hamano wrote:
> >
> >> * js/empty-config-section-fix (2018-05-18) 1 commit
> >>  - config: a user-provided invalid section is not a BUG
> >> 
> >>  Error codepath fix.
> >> 
> >>  Will merge to 'next'.
> >
> > As a hotfix, maybe we can fast-track it to master?
> 
> Hotfix is a proposed fix for an issue that is so important to be a
> showstopper.  This one must be fixed before the final release, but I
> do not think it's not that urgent to force us to drop everything
> else and merge it to master immediately.

Well, in this case, a user might report a BUG when they simply have an
invalid config.

I do not care all that much, but Peff (who reported this) might.

Ciao,
Dscho
