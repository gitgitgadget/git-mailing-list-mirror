Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07398C433DF
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 13:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD30F20758
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 13:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438154AbgJQNrB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 09:47:01 -0400
Received: from vulcan.kevinlocke.name ([107.191.43.88]:42924 "EHLO
        vulcan.kevinlocke.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438051AbgJQNrA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 09:47:00 -0400
Received: from kevinlocke.name (2600-6c67-5080-46fc-566a-f14a-6484-6735.res6.spectrum.com [IPv6:2600:6c67:5080:46fc:566a:f14a:6484:6735])
        (Authenticated sender: kevin@kevinlocke.name)
        by vulcan.kevinlocke.name (Postfix) with ESMTPSA id 54C9C1D1E355;
        Sat, 17 Oct 2020 13:46:59 +0000 (UTC)
Received: by kevinlocke.name (Postfix, from userid 1000)
        id 03767130021D; Sat, 17 Oct 2020 07:46:55 -0600 (MDT)
Date:   Sat, 17 Oct 2020 07:46:55 -0600
From:   Kevin Locke <kevin@kevinlocke.name>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [Request] gitweb: tag feeds
Message-ID: <20201017134655.GA127715@kevinlocke.name>
Mail-Followup-To: Kevin Locke <kevin@kevinlocke.name>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
References: <20201013221250.GA20483@kevinlocke.name>
 <xmqqtuuuceat.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtuuuceat.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2020-10-16 at 09:43 -0700, Junio C Hamano wrote:
> Kevin Locke <kevin@kevinlocke.name> writes:
>> I've found the support for Atom and RSS commit feeds in gitweb to be
>> very useful.  I'd like to extend the support to include tag feeds as a
>> simple means of announcing/tracking releases.  Might such a feature be
>> acceptable in some form?
>>
>> Giuseppe Bilotta raised this idea and provided an implementation in
>> 2012[1] and 2017[2] which did not receive any responses on-list that I
>> could find.  Would these be a suitable starting point?
> 
> I suspect that these patches would have been OK back then.
> 
> The thing is, it appears nobody actively maintains gitweb anymore,
> which cuts both ways.
> 
>  - We may not have made fundamental changes to the program in the
>    last 3 years, so patches from 2017 may still be relevant.
> 
>  - Even if 2017 patch were to be resurrected, nobody would be able
>    to review and vouch for the result.
> 
> So, if you still use gitweb and want to take over its maintenance,
> or if we can revive interest in those who want to maintain it,
> perhaps.

Understandable.  Thanks for explaining the situation!  That's good to
know.

For my current needs, switching to another web interface, like cgit,
seems preferable.

Best,
Kevin
