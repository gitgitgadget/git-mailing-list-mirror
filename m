Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8871EB64DD
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 17:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236622AbjHKRNL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 13:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjHKRNK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 13:13:10 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722A2E5F
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 10:13:09 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id DFC2820386;
        Fri, 11 Aug 2023 13:13:05 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qUVhB-erh-00; Fri, 11 Aug 2023 19:13:05 +0200
Date:   Fri, 11 Aug 2023 19:13:05 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v3 1/2] sequencer: beautify subject of reverts of reverts
Message-ID: <ZNZsIfwj2t2wYWEG@ugly>
References: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>
 <20230809171531.2564807-1-oswald.buddenhagen@gmx.de>
 <dba3f15a-3575-e4f9-2291-c5a342cfed43@gmail.com>
 <xmqq1qg9v7k9.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqq1qg9v7k9.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 11, 2023 at 09:59:34AM -0700, Junio C Hamano wrote:
>Presumably the next time this gets reverted we will see a doubled
>reapply?
>
yes

>Isn't that something we care about documenting as a part
>of this test?  i.e. another four-line block after the above?
>
the third case documents that it's the same as the first case, i.e., 
"nothing special". so at this point we have full coverage in all 
regards. going beyond that would be redundant, and we'd again get into 
the "uh, where do we stop?" situation.

regards
