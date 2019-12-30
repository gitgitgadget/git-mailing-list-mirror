Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAE7C2D0C3
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 20:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965DE20718
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 20:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbfL3UlZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 15:41:25 -0500
Received: from bluemchen.kde.org ([209.51.188.41]:43644 "EHLO
        bluemchen.kde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbfL3UlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 15:41:25 -0500
X-Greylist: delayed 455 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Dec 2019 15:41:25 EST
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 2A92C202F7;
        Mon, 30 Dec 2019 15:33:49 -0500 (EST)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1im1jY-UR4-00; Mon, 30 Dec 2019 21:33:48 +0100
Date:   Mon, 30 Dec 2019 21:33:48 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Gal Paikin <paiking@google.com>, git@vger.kernel.org,
        ajp@google.com, Nasser Grainawi <nasser@codeaurora.org>
Subject: Re: Updating the commit message for reverts
Message-ID: <20191230203348.GA831634@ugly>
References: <CAEsQYpNtgMgwjVSOYB9vn-YPvKyKPZ2yZ3NigAVe3PztTN4v8w@mail.gmail.com>
 <20191230195915.GE57251@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191230195915.GE57251@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 30, 2019 at 11:59:15AM -0800, Jonathan Nieder wrote:
>Gal Paikin wrote:
>> The suggestion is to change the behavior to "Revert^N" instead of
>> multiple Reverts one after another.
>
>This would be replacing one kind of jargon with another, so it's not
>clear to me that it would improve matters.
>
>With Revert / Reland, we can forget the N altogether: [...]
>
the irony here is that "reland" is of course yet more jargon. :-D
i'd strongly suggest to use something that actually appears in standard 
dictionaries, preferentially "reapply".

> 1. 'Do some great thing'
> 2. 'Revert "Do some great thing"'
> 3. 'Reland "Do some great thing"'
> 4. 'Revert "Do some great thing"'
> 5. (etc)
>
>For the reader of the shortlog, it's not too important how long the
>edit war has gone.  The single word makes it clear what the commit
>is going to do.
>
in principle i agree, but it irks me somewhat that the summaries become 
non-unique, as that always somewhat impacts history browsing.
