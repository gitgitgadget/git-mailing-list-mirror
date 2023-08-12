Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1A9C0015E
	for <git@archiver.kernel.org>; Sat, 12 Aug 2023 06:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjHLGZT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Aug 2023 02:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHLGZS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Aug 2023 02:25:18 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CB2271E
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 23:25:17 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 76EB7242A2;
        Sat, 12 Aug 2023 02:25:12 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qUi3k-owy-00; Sat, 12 Aug 2023 08:25:12 +0200
Date:   Sat, 12 Aug 2023 08:25:12 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     phillip.wood@dunelm.org.uk
Cc:     Linus Arver <linusa@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] doc: revert: add discussion
Message-ID: <ZNclyKWYw4j0C7wM@ugly>
References: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>
 <20230809171531.2564807-1-oswald.buddenhagen@gmx.de>
 <20230809171531.2564807-2-oswald.buddenhagen@gmx.de>
 <owly8raih8ho.fsf@fine.c.googlers.com>
 <owly5y5mh81i.fsf@fine.c.googlers.com>
 <07028529-cbe1-55d0-4ab0-9f3ec03a4fd1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <07028529-cbe1-55d0-4ab0-9f3ec03a4fd1@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 11, 2023 at 04:10:55PM +0100, Phillip Wood wrote:
>On 10/08/2023 23:00, Linus Arver wrote:
>> Linus Arver <linusa@google.com> writes:
>> 
>>> How about
>>> the following rewording?
>>>
>>>      While git creates a basic commit message automatically, it is
>>>      _strongly_ recommended to explain why the original commit is being
>>>      reverted. In addition, repeatedly reverting the same commit will
>> 
>> Hmph, "repeatedly reverting the same commit" sounds wrong because
>> strictly speaking there is only 1 "same commit" (the original commit).
>
>While it isn't strictly accurate I think that wording is easy enough to 
>understand.
>
yes, but why would that be _better_ than saying "repeatedly reverting 
reversions" like i did?

regards

