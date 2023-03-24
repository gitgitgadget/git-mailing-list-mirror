Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E754C6FD1C
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 18:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjCXSQK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 14:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbjCXSQH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 14:16:07 -0400
Received: from bluemchen.kde.org (unknown [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB111816C
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 11:16:03 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 3C2F62430A
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 14:15:47 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pflx4-Rdj-00
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 19:15:46 +0100
Date:   Fri, 24 Mar 2023 19:15:46 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: Re: limiting git branch --contains
Message-ID: <ZB3o0seQJVbtPa+j@ugly>
Mail-Followup-To: git@vger.kernel.org
References: <ZBygZbz5E6jVNp3y@ugly>
 <xmqqpm8z8dab.fsf@gitster.g>
 <ZBy6Ku+znv/wuOix@ugly>
 <594a358e-7bd4-e7a1-ad0f-7e41ca1fe767@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <594a358e-7bd4-e7a1-ad0f-7e41ca1fe767@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2023 at 01:23:32PM -0400, Derrick Stolee wrote:
>Could you make sure to run 'git commit-graph write --reachable' before
>testing again?
>
i did, didn't help.

but regardless, even if this would improve things by an order of 
magnitude (or even two), it would be still wasteful, given that the 
expected working set contains a few tens commits, while the whole graph 
contains well over a million commits.
