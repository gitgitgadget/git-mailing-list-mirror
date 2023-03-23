Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB4BC74A5B
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 21:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjCWVUl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 17:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjCWVUj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 17:20:39 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77102CC70
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 14:20:38 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 275F820300
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 17:20:34 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pfSML-g5U-00
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 22:20:33 +0100
Date:   Thu, 23 Mar 2023 22:20:33 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] sequencer: actually translate report in do_exec()
Message-ID: <ZBzCoZ0MuysnVj9t@ugly>
Mail-Followup-To: git@vger.kernel.org
References: <20230323162234.995485-1-oswald.buddenhagen@gmx.de>
 <20230323162234.995485-2-oswald.buddenhagen@gmx.de>
 <xmqqpm8z6vxk.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqpm8z6vxk.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2023 at 01:43:03PM -0700, Junio C Hamano wrote:
>But the original does not look particularly a good way to
>allow people to translate the messages (namely, it splits a sentence
>in the middle and makes a sentence lego).
>
it's not that bad, because the "brick" is inserted at a location that is 
specified by another translatable string.

>I wonder if it should prepare two full sentence messages, one for
>dirty case and the other for non-dirty case?
>
... so this seems unnecessary if no translator complained yet.

>In any case, I think
>the latter half of this big warning() should be done as an advice
>message that the user can squelch, so I wouldn't worry too much
>about it before that happens.
>
yeah, but unless this is on someone's shortlist, i don't think it makes 
sense to hold up my fix.

