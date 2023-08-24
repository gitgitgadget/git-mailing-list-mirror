Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E51C27C40
	for <git@archiver.kernel.org>; Thu, 24 Aug 2023 06:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240020AbjHXGPe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Aug 2023 02:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240038AbjHXGPH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2023 02:15:07 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E6B170C
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 23:14:49 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 69529241CA;
        Thu, 24 Aug 2023 02:14:47 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qZ3cE-AcW-00; Thu, 24 Aug 2023 08:14:46 +0200
Date:   Thu, 24 Aug 2023 08:14:46 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 1/2] sequencer: beautify subject of reverts of reverts
Message-ID: <ZOb1ViHIaqX8PcHV@ugly>
References: <20230809171531.2564807-1-oswald.buddenhagen@gmx.de>
 <20230821170720.577850-1-oswald.buddenhagen@gmx.de>
 <ZOZnNDd2pMX6M2Au@nand.local>
 <xmqqsf89e8wz.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqsf89e8wz.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 23, 2023 at 02:38:36PM -0700, Junio C Hamano wrote:
>Taylor Blau <me@ttaylorr.com> writes:
>
>> This version is looking good. The main functionality is well-reasoned
>> and straightforwardly implemented. One minor suggestion that you could
>> consider squashing in is some test clean-up like so:
>>
>
>Yeah it does make the test more concise and what is expected stand
>out more clearly.  Good suggestion.
>
agreed. do you want to squash it on your end, or should i reroll?

regards
