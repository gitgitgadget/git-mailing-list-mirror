Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70810EE49A5
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 18:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjHUS6q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 14:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjHUS6p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 14:58:45 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DBD49E9
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 11:58:20 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id CFA9223FF0;
        Mon, 21 Aug 2023 14:57:48 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qYA60-Rw1-00; Mon, 21 Aug 2023 20:57:48 +0200
Date:   Mon, 21 Aug 2023 20:57:48 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5] send-email: prompt-dependent exit codes
Message-ID: <ZOOzrHWLchYMgUOd@ugly>
References: <xmqq5y5msmc0.fsf@gitster.g>
 <20230821170720.577835-1-oswald.buddenhagen@gmx.de>
 <xmqq1qfwqnwu.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqq1qfwqnwu.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 21, 2023 at 10:57:05AM -0700, Junio C Hamano wrote:
>Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>
>> to opt-in (which is obviously the status quo, and is likely to persist
>> in most cases) is potentially at least somewhat serious.
>
>What's the weaseling "potentially at least somewhat" phrase about?
>
i think that mails not being sent (timely, until somebody notices the 
mistake) is "at least somewhat serious". at least serious enough to 
justify a few people having to make a minor ajustment to their scripts 
to confirm that they really want the old behavior.

regards
