Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29F9C41513
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 19:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbjHHTlB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 15:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236478AbjHHTkv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 15:40:51 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D44DFAB7
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 12:11:25 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id C2DDA24276;
        Tue,  8 Aug 2023 15:11:24 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qTS72-Hnt-00; Tue, 08 Aug 2023 21:11:24 +0200
Date:   Tue, 8 Aug 2023 21:11:24 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3] send-email: prompt-dependent exit codes
Message-ID: <ZNKTXPVK1p1oHhtE@ugly>
References: <xmqqttx1l3zp.fsf@gitster.g>
 <20230807165850.2335067-1-oswald.buddenhagen@gmx.de>
 <xmqqbkfifzry.fsf@gitster.g>
 <ZNIfDXJBqEVcHh+D@ugly>
 <xmqqmsz1a547.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqmsz1a547.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 08, 2023 at 09:08:56AM -0700, Junio C Hamano wrote:
>This behaviour change is, even among Git developers, not a bugfix but 
>is a new feature that not everybody would want to be subjected to.
>
that's debatable, depending on one's expectations. at the very least 
it's an enabler for bugfixes.

>It always is the safest to make such a backward incompatible change a 
>strictly opt-in feature.
>
well, yes. the question is whether we expect non-trivial problems 
arising from imposing it on unsuspecting users. and given that there is 
an (opportunity) cost of having it opt-in only, there is a trade-off. my 
gut feeling is that having it always-on is probably better.

regards
