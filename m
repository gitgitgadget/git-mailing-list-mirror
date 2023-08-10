Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24B1C001B0
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 12:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjHJMIt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 08:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjHJMIs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 08:08:48 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E981704
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 05:08:46 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 0866923F0C;
        Thu, 10 Aug 2023 08:08:45 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qU4T6-46z-00; Thu, 10 Aug 2023 14:08:44 +0200
Date:   Thu, 10 Aug 2023 14:08:44 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3] rebase: clarify conditionals in todo_list_to_strbuf()
Message-ID: <ZNTTTAtNE2/DY9vT@ugly>
References: <20230428125601.1719750-1-oswald.buddenhagen@gmx.de>
 <20230807170935.2336745-1-oswald.buddenhagen@gmx.de>
 <xmqqv8dqd2bh.fsf@gitster.g>
 <ZNO7IVphPf8KOC3Q@ugly>
 <xmqqbkfgm2di.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqbkfgm2di.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 09, 2023 at 12:39:37PM -0700, Junio C Hamano wrote:
>Thanks.  Then this patch is still a strict "Meh" to me.
>
i can't really think of a reason why you reject such a no-brainer other 
than that you consider it churn. in that case i need to tell you that 
you have unreasonable standards, which actively contribute to the code 
remaining a mess.

regards
