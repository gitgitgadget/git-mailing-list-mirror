Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F31C001DB
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 10:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbjHJKmt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 06:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjHJKms (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 06:42:48 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4A410C3
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 03:42:47 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 9E0C923F29;
        Thu, 10 Aug 2023 06:42:46 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qU37u-1a6-00; Thu, 10 Aug 2023 12:42:46 +0200
Date:   Thu, 10 Aug 2023 12:42:46 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/1] t/lib-rebase: (mostly) cosmetic improvements to
 set_fake_editor()
Message-ID: <ZNS/JteS1nhzk58P@ugly>
References: <8ce40f48-f36f-9e81-1a3f-9d8b170c4a0f@gmail.com>
 <20230809171531.2564785-1-oswald.buddenhagen@gmx.de>
 <xmqqh6p7lxxx.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqh6p7lxxx.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 09, 2023 at 02:15:22PM -0700, Junio C Hamano wrote:
>Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>
>> An update to the documentation, and two minor functional changes that don't
>> actually change anything given current use cases, and are therefore basically
>> documentation updates as well.
>>
>> Oswald Buddenhagen (1):
>>   t/lib-rebase: improve documentation of set_fake_editor()
>>
>>  t/lib-rebase.sh | 21 ++++++++++++---------
>>  1 file changed, 12 insertions(+), 9 deletions(-)
>
>Now I lost track.  This is slightly different from one of the steps
>in the three-patch series.  Were the other two steps retracted?
>
no, this cover letter was a messup on my side, caused by a lack of 
attention and still suboptimal tooling. this was meant to be an update 
to just this one commit, while keeping the other two intact.

regards
