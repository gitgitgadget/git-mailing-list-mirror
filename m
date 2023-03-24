Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AC2C6FD1C
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 19:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjCXTDM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 15:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCXTDK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 15:03:10 -0400
Received: from bluemchen.kde.org (unknown [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BAD9773
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 12:03:09 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 90621242DD
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 15:02:53 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pfmgf-SJA-00
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 20:02:53 +0100
Date:   Fri, 24 Mar 2023 20:02:53 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: Re: limiting git branch --contains
Message-ID: <ZB3z3e5G3Lrv9g3Y@ugly>
Mail-Followup-To: git@vger.kernel.org
References: <ZBygZbz5E6jVNp3y@ugly>
 <xmqqpm8z8dab.fsf@gitster.g>
 <ZBy6Ku+znv/wuOix@ugly>
 <594a358e-7bd4-e7a1-ad0f-7e41ca1fe767@github.com>
 <ZB3o0seQJVbtPa+j@ugly>
 <85f81579-5876-a573-6d35-88b35ab0f290@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <85f81579-5876-a573-6d35-88b35ab0f290@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2023 at 02:20:01PM -0400, Derrick Stolee wrote:
>Hm. The point is that it _should_ improve things by several orders
>of magnitude [...]
>
well, at that point it would be kinda sufficient. ^^
but it really doesn't do anything at all (i tried moving away the graph 
for comparison).
maybe the operation just forgets to load the graph?

>But what you were originally asking was also about filtering the
>set of branches to pick,
>
i didn't, i was just misunderstood.
