Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87106C433F5
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 16:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbiCMQVN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Mar 2022 12:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiCMQVM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 12:21:12 -0400
Received: from relay5.hostedemail.com (relay5.hostedemail.com [64.99.140.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571897004A
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 09:20:04 -0700 (PDT)
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay01.hostedemail.com (Postfix) with ESMTP id 8D7BB6083D;
        Sun, 13 Mar 2022 16:20:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: seanm@seanm.ca) by omf19.hostedemail.com (Postfix) with ESMTPA id 135F020026;
        Sun, 13 Mar 2022 16:20:02 +0000 (UTC)
Date:   Sun, 13 Mar 2022 12:19:51 -0400
From:   Sean MacLennan <seanm@seanm.ca>
To:     <rsbecker@nexbridge.com>
Cc:     <git@vger.kernel.org>
Subject: Re: Request: a way to ignore .gitattributes
Message-ID: <20220313121951.093495fb@zonker.seanm.ca>
In-Reply-To: <01ab01d83656$071d7cd0$15587670$@nexbridge.com>
References: <20220312130712.6d9d2d00@zonker.seanm.ca>
        <01ab01d83656$071d7cd0$15587670$@nexbridge.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 4h3akm71eskkw71ryfddne5q8rocbsq5
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 135F020026
X-Session-Marker: 7365616E6D407365616E6D2E6361
X-Session-ID: U2FsdGVkX18/BGSqTraimqXBpBLl2F0F14F0C/6vfIk=
X-HE-Tag: 1647188402-246070
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 12 Mar 2022 16:13:26 -0500
<rsbecker@nexbridge.com> wrote:

> These may seem a little off the wall, but:
> 1. Could you use a clean/smudge approach to mess with your bad
> .gitattributes file before it gets put down on disk? I realize that
> registering the filter might not be possible given that you need to
> muck with .gitattributes to do it, but if you have any control at all
> and can get the filter in, perhaps that might be a way to clean up
> the bad .gitattributes file.

I have no access to the servers.

> 2. What about a post-checkout hook that fixes .gitattributes and then
> does an update-index --assume-unchanged on it. This is under the
> assumption that you will never change .gitattributes in your clone.

That seems to work. I did not know about update-index.

> My $0.02,
> --Randall

Cheers,
   Sean
