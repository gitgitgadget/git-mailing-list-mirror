Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EFC61FF40
	for <e@80x24.org>; Wed, 21 Dec 2016 08:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756708AbcLUIdo (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 03:33:44 -0500
Received: from continuum.iocl.org ([217.140.74.2]:58483 "EHLO
        continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754494AbcLUIdn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2016 03:33:43 -0500
Received: (from krey@localhost)
        by continuum.iocl.org (8.11.3/8.9.3) id uBL8XZp05973;
        Wed, 21 Dec 2016 09:33:35 +0100
Date:   Wed, 21 Dec 2016 09:33:35 +0100
From:   Andreas Krey <a.krey@gmx.de>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: Races on ref .lock files?
Message-ID: <20161221083335.GA1206@inner.h.apk.li>
References: <20161216164751.GA12174@inner.h.apk.li> <xmqqpokru6yg.fsf@gitster.mtv.corp.google.com> <CAGyf7-EvbV4XWCsfLpCUDo5V4_wM3SSJcHxVh9Rp78JUC6S-yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGyf7-EvbV4XWCsfLpCUDo5V4_wM3SSJcHxVh9Rp78JUC6S-yw@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 16 Dec 2016 15:34:22 +0000, Bryan Turner wrote:
...
> Bitbucket Server developer here.

Social media rock. :-)

> If you'd like to investigate more in depth, I'd encourage you to
> create a ticket on support.atlassian.com so we can work with you.

That is going to be postponed until we update our bitbucket instance
to the current state.

> Otherwise, if you just want to prevent seeing these messages, you can
> either fork the relevant repository in Bitbucket Server (which
> disables auto GC), or run "git config gc.auto 0" in

Doing that for now. Will come back either if it doesn't help,
or after the upgrade.

> within Bitbucket Server instead, so a future upgrade should
> automatically prevent these messages from appearing on clients.

I still wonder if git itself should prevent these, or is there
a (git level) recommendation not to enable auto-gc in repos where
people regularly push to?

- Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
