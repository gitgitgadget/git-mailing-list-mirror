Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703AFC001DE
	for <git@archiver.kernel.org>; Fri, 28 Jul 2023 09:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbjG1Jpp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jul 2023 05:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbjG1Jpn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2023 05:45:43 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12622686
        for <git@vger.kernel.org>; Fri, 28 Jul 2023 02:45:41 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 380B7241EF;
        Fri, 28 Jul 2023 05:45:38 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qPK2T-UJ8-00; Fri, 28 Jul 2023 11:45:37 +0200
Date:   Fri, 28 Jul 2023 11:45:37 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Linus Arver <linusa@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v2] sequencer: beautify subject of reverts of reverts
Message-ID: <ZMOOQTMk2wFwtSfa@ugly>
References: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>
 <3f5e4116-54e6-9753-f925-ed4a9f6e3518@gmail.com>
 <ZGSlqAPwaLhgWm6v@ugly>
 <2d416834-ef3e-01a2-6be0-9e88bc0de25e@gmail.com>
 <ZGUIqBU0+Vr5LSBF@ugly>
 <10523968-0f02-f483-69c4-24e62e839f70@gmail.com>
 <xmqqmt21txid.fsf@gitster.g>
 <owly7cqkfvyu.fsf@fine.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <owly7cqkfvyu.fsf@fine.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 27, 2023 at 10:26:01PM -0700, Linus Arver wrote:
>How about introducing a suffix (+ or -) after the word "Revert" to
>indicate the application/inclusion (+) or removal (-) of a commit?
>
i think that falls squarely into the "too nerdy" category, like the 
Revert^n proposal does.

>(Sorry for jumping into this thread so late, but the mention of this
>topic on the recent "What's cooking" message [1] (that this topic would
>be discarded) got me interested.)
>
i actually have finally updated my patches, but then found a problem in 
my script i'm using for submitting them, and want to fix that first for 
dogfooding purposes. shouldn't be long.

regards
