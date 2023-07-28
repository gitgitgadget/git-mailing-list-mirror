Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE889C001DF
	for <git@archiver.kernel.org>; Fri, 28 Jul 2023 16:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbjG1QuO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jul 2023 12:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbjG1Qt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2023 12:49:56 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640084227
        for <git@vger.kernel.org>; Fri, 28 Jul 2023 09:48:29 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 2E55F24188;
        Fri, 28 Jul 2023 12:47:38 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qPQcr-f6R-00; Fri, 28 Jul 2023 18:47:37 +0200
Date:   Fri, 28 Jul 2023 18:47:37 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Arver <linusa@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v2] sequencer: beautify subject of reverts of reverts
Message-ID: <ZMPxKVsMvISQpXx4@ugly>
References: <ZGSlqAPwaLhgWm6v@ugly>
 <2d416834-ef3e-01a2-6be0-9e88bc0de25e@gmail.com>
 <ZGUIqBU0+Vr5LSBF@ugly>
 <10523968-0f02-f483-69c4-24e62e839f70@gmail.com>
 <xmqqmt21txid.fsf@gitster.g>
 <owly7cqkfvyu.fsf@fine.c.googlers.com>
 <ZMOOQTMk2wFwtSfa@ugly>
 <xmqqpm4c5ax9.fsf@gitster.g>
 <ZMPgn1QQltyE7koe@ugly>
 <xmqqwmyk3slm.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqwmyk3slm.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 28, 2023 at 09:31:49AM -0700, Junio C Hamano wrote:
>From that point
>of view, allowing arbitrary number of "Reapply" repeated, optionally
>prefixed by a single "Revert", does not sound like it is much better
>compared to the current one---is it worth this much time to discuss,
>only to halve the length of long runs of "Revert"?
>
yes, for two reasons:
- the single "reapply" case is actually common; it's usually done after 
   a previously missed pre-requisite was applied.
- the fact that it's "beautified" _at all_ sends a signal (see previous 
   mails). it doesn't have to be particularly sophisticated for that.

regards
