Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09FB7211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 16:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbeK3DcI (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 22:32:08 -0500
Received: from chiark.greenend.org.uk ([212.13.197.229]:34594 "EHLO
        chiark.greenend.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728334AbeK3DcI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 22:32:08 -0500
Received: by chiark.greenend.org.uk (Debian Exim 4.84_2 #1) with local
        (return-path ijackson@chiark.greenend.org.uk)
        id 1gSP8k-0001Sg-Pl; Thu, 29 Nov 2018 16:26:10 +0000
From:   Ian Jackson <ijackson@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <23552.4898.603829.719325@chiark.greenend.org.uk>
Date:   Thu, 29 Nov 2018 16:26:10 +0000
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] rebase: mark the C reimplementation as an experimental
 opt-in feature (was Re: [ANNOUNCE] Git v2.20.0-rc1)
In-Reply-To: <nycvar.QRO.7.76.6.1811291713030.41@tvgsbejvaqbjf.bet>
References: <xmqqmuq25ufc.fsf@gitster-ct.c.googlers.com>
        <87y39w1wc2.fsf@evledraar.gmail.com>
        <877eh219ih.fsf@evledraar.gmail.com>
        <xmqq36rq2cp0.fsf@gitster-ct.c.googlers.com>
        <xmqq36roz7ve.fsf_-_@gitster-ct.c.googlers.com>
        <20181128043154.GA34163@google.com>
        <nycvar.QRO.7.76.6.1811281015360.41@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.1811291516540.41@tvgsbejvaqbjf.bet>
        <23551.63504.876084.449440@chiark.greenend.org.uk>
        <nycvar.QRO.7.76.6.1811291638400.41@tvgsbejvaqbjf.bet>
        <23552.2773.538601.372248@chiark.greenend.org.uk>
        <nycvar.QRO.7.76.6.1811291713030.41@tvgsbejvaqbjf.bet>
X-Mailer: VM 8.2.0b under 24.4.1 (i586-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin writes ("Re: [PATCH] rebase: mark the C reimplementation as an experimental opt-in feature (was Re: [ANNOUNCE] Git v2.20.0-rc1)"):
> I'll have to take a (lengthy) dinner break now, but this is what I have so
> far: a regression test that verifies the breakage (see the
> `fix-reflog-action` branch at https://github.com/dscho/git). I'll continue
> after dinner and am confident that this bug will be fixed within the next
> four hours.

That seems super speedy to me!

When you have a fix I will leave it up to the Debian git maintainers
to decide whether they want to cherry pick your fix into their
package, or await an updated upstream branch with rc, or what.

> [Ian:]
> > While you're looking at this, I observe that the fact that the `rebase
> > finished' message also does not honour GIT_REFLOG_ACTION appears to be
> > a pre-existing bug.
> 
> I noticed that, too, but at this point I am only fixing regressions. We
> can try to fix this long-standing bug in the v2.20 cycle.

Right.

Thanks,
Ian.

-- 
Ian Jackson <ijackson@chiark.greenend.org.uk>   These opinions are my own.

If I emailed you from an address @fyvzl.net or @evade.org.uk, that is
a private address which bypasses my fierce spamfilter.
