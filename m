Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AABFEB64D9
	for <git@archiver.kernel.org>; Sat, 17 Jun 2023 08:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjFQIjR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jun 2023 04:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjFQIjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jun 2023 04:39:16 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD57FA
        for <git@vger.kernel.org>; Sat, 17 Jun 2023 01:39:13 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 8A337240DD;
        Sat, 17 Jun 2023 04:39:11 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1qARSh-meX-00; Sat, 17 Jun 2023 10:39:11 +0200
Date:   Sat, 17 Jun 2023 10:39:11 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Nadav Goldstein via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nadav Goldstein <nadav.goldstein96@gmail.com>
Subject: Re: [PATCH] Add 'preserve' subcommand to 'git stash'
Message-ID: <ZI1xLwemOs9Vxorf@ugly>
References: <pull.1528.git.git.1686913210137.gitgitgadget@gmail.com>
 <xmqqjzw3qry6.fsf@gitster.g>
 <ZIzALOe8GBsNGIhR@ugly>
 <xmqqv8fnrwtt.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqv8fnrwtt.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 16, 2023 at 01:11:58PM -0700, Junio C Hamano wrote:
>Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>
>>>Why a new subcommand, not a new option to "push"?  Adding a new
>>>subcommand would mean it would be another unfamiliar thing users
>>>need to learn, as opposed to a slight variation of what they are
>>>already familiar with.
>>>
>> to be fair, there's also `apply` and not `pop --keep`.
>
>I do not care all that much if that is fair, but I do not think it
>is a meaningful comparison.  "stash apply" is merely exposing the
>first half (the other half is "stash drop") of a two step operation
>that is "stash pop".
>
i may be totally wrong about it (because i don't understand the 
motivation behind this feature, either), but i think the _intent_ of 
nadav's patch is to merely expose the first half of "stash push" (the 
other half is the implicit "reset --hard"). it may not be a sufficiently 
good one, but there is clearly an analogy here.

regards,
ossi
