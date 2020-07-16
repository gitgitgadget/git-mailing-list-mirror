Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC779C433ED
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 17:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D04FB2067D
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 17:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgGPRZw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 13:25:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:35824 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbgGPRZv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 13:25:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AEB10AC36;
        Thu, 16 Jul 2020 17:25:54 +0000 (UTC)
Date:   Thu, 16 Jul 2020 19:25:49 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Alireza <rezaxm@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Request for adding a "clean" merge strategy for a double-commit
 merge to deal with conflicts separately
Message-ID: <20200716172549.GJ32107@kitsune.suse.cz>
References: <CAD9n_qh0y84HC6sX1OxXWWv8dDMMA_tPv9zRknePVivQq_rfww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD9n_qh0y84HC6sX1OxXWWv8dDMMA_tPv9zRknePVivQq_rfww@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 16, 2020 at 09:45:24PM +0430, Alireza wrote:
> Hi,
> 
> Even though the merge commit's message includes conflicted files by
> default, the *resolution* itself is lost, that is, it's hard or
> impossible to review how the author *resolved* said conflicts.
No, the merge commit includes the resolution. You can compare with all
parents, and even perform the same merge locally using your strategy and
tooling of choice and compare the result with what the merge author
committed as resolution.

> 
> The proposal is that an option like `-X clean` would commit a clean
> merge and leave out any conflicting hunks in the tree for a follow-up
> commit to resolve conflicts.
I don't see any value above performing the same merge locally and
comparing with the committed resolution. Can you please elaborate on the
expected format of the merge that does add some value?

Thanks

Michal
