Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11171C433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 08:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4F386113C
	for <git@archiver.kernel.org>; Tue, 18 May 2021 08:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347437AbhERI2f (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 04:28:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:40512 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239755AbhERI2f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 04:28:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D1E52AC5B;
        Tue, 18 May 2021 08:27:16 +0000 (UTC)
Date:   Tue, 18 May 2021 10:27:15 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Jeff King <peff@peff.net>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH] setup: split "extensions found" messages into singular
 and plural
Message-ID: <20210518082715.GO8544@kitsune.suse.cz>
References: <20210518061917.57556-1-alexhenrie24@gmail.com>
 <YKNe50TDMftkadYI@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKNe50TDMftkadYI@coredump.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 18, 2021 at 02:29:59AM -0400, Jeff King wrote:
> On Tue, May 18, 2021 at 12:19:17AM -0600, Alex Henrie wrote:
> 
> > It's easier to translate this way.
> 
> Makes sense.
> 
> I don't know about "easier to translate", since there are twice as many
> strings now. But certainly what the user sees will be more grammatically
> correct. :)

Note that some languages may still have dual (that is 2 extensions is
different from both 1 and 3 and more extensions), and so on for 3 and 4,
and in some languages 21 (and 31 but not necessarily 11) extensions may
be singular again.

Kind of reminds me of
https://www.kalzumeus.com/2010/06/17/falsehoods-programmers-believe-about-names/

Thanks

Michal
