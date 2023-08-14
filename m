Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9424C04FDF
	for <git@archiver.kernel.org>; Mon, 14 Aug 2023 14:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjHNOQA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Aug 2023 10:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjHNOPg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2023 10:15:36 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8545A19B9
        for <git@vger.kernel.org>; Mon, 14 Aug 2023 07:15:07 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 276C023F13;
        Mon, 14 Aug 2023 10:13:52 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qVYKO-mQ4-00; Mon, 14 Aug 2023 16:13:52 +0200
Date:   Mon, 14 Aug 2023 16:13:52 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     phillip.wood@dunelm.org.uk, Linus Arver <linusa@google.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] doc: revert: add discussion
Message-ID: <ZNo2oPaAsSISBalq@ugly>
References: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>
 <20230809171531.2564807-1-oswald.buddenhagen@gmx.de>
 <20230809171531.2564807-2-oswald.buddenhagen@gmx.de>
 <owly8raih8ho.fsf@fine.c.googlers.com>
 <owly5y5mh81i.fsf@fine.c.googlers.com>
 <07028529-cbe1-55d0-4ab0-9f3ec03a4fd1@gmail.com>
 <ZNclyKWYw4j0C7wM@ugly>
 <xmqqy1iemw75.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqy1iemw75.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 13, 2023 at 03:09:02PM -0700, Junio C Hamano wrote:
>Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>
>> On Fri, Aug 11, 2023 at 04:10:55PM +0100, Phillip Wood wrote:
>>>On 10/08/2023 23:00, Linus Arver wrote:
>>>> Hmph, "repeatedly reverting the same commit" sounds wrong because
>>>> strictly speaking there is only 1 "same commit" (the original commit).
>>>
>>> While it isn't strictly accurate I think that wording is easy enough
>>> to understand.
>>>
>> yes, but why would that be _better_ than saying "repeatedly reverting
>> reversions" like i did?
>
>To me at least, "repeatedly reverting reversions" sounds more like a
>riddle, compared to "repeatedly reverting the same commit", whose
>intent sounds fairly obvious.
>
a more natural way for git users to say it would be "reverting reverts", 
which i think everyone in the target audience would understand, but it 
seems linguistically questionable to me. native speakers may want to 
opine ...

>An explicit mention of "commit", which
>is a more familiar noun to folks than "reversion", does contribute to
>it, I suspect.
>
yes, but "commit" may be misunderstood, as linus pointed out in his 
reply to himself. phillip dismissed the concern, but i don't think 
ambiguity is a good idea in the authoritative documentation.

unfortunately, linus' proposed alternatives seem even more like 
"riddles" to me than what i am proposing.

regards
