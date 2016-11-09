Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99E502021E
	for <e@80x24.org>; Wed,  9 Nov 2016 14:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753378AbcKIOgn (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 09:36:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:36103 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751203AbcKIOgm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 09:36:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 929FDADCA;
        Wed,  9 Nov 2016 14:36:40 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        git@vger.kernel.org
Subject: Re: [PATCH] t6026-merge-attr: don't fail if sleep exits early
References: <mvmtwbhdhvb.fsf@hawking.suse.de>
        <20161108200543.7ivo3xoafdl4uw6h@sigill.intra.peff.net>
        <alpine.DEB.2.20.1611091437280.72596@virtualbox>
X-Yow:  Vote for ME -- I'm well-tapered, half-cocked, ill-conceived and
 TAX-DEFERRED!
Date:   Wed, 09 Nov 2016 15:36:40 +0100
In-Reply-To: <alpine.DEB.2.20.1611091437280.72596@virtualbox> (Johannes
        Schindelin's message of "Wed, 9 Nov 2016 14:47:13 +0100 (CET)")
Message-ID: <mvmzil8btzb.fsf@hawking.suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Nov 09 2016, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> The reason why we do not ignore kill errors is that we want to make sure
> that the script *actually ran*. Otherwise, the thing we need to test here
> does not necessarily get tested.

That can be tested by looking for the pid file.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
