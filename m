Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A710EEE49B0
	for <git@archiver.kernel.org>; Wed, 23 Aug 2023 09:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235455AbjHWJgD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Aug 2023 05:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbjHWJfD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2023 05:35:03 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA81449A
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 02:25:26 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 49B9723FA5;
        Wed, 23 Aug 2023 05:25:24 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qYk79-ujR-00; Wed, 23 Aug 2023 11:25:23 +0200
Date:   Wed, 23 Aug 2023 11:25:23 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 1/3] scalar: add --[no-]src option
Message-ID: <ZOXQg3V1EU/FXnwV@ugly>
References: <pull.1569.git.1692025937.gitgitgadget@gmail.com>
 <pull.1569.v2.git.1692725056.gitgitgadget@gmail.com>
 <0b6957beccbd1815c49c15c3525bfd6cbe077d34.1692725056.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <0b6957beccbd1815c49c15c3525bfd6cbe077d34.1692725056.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

just nitpicking the commit message:

On Tue, Aug 22, 2023 at 05:24:13PM +0000, Derrick Stolee via GitGitGadget wrote:
>From: Derrick Stolee <derrickstolee@github.com>
>
>Some users have strong aversions to Scalar's opinion that the repository
>should be in a 'src' directory, even though

>it
>
i'd use "this" here.

>creates a clean slate for
>placing build

>outputs
>
"artifacts" maybe.

>in adjacent directories.
>

>The
>
i'd insert "new" here.

>--no-src option allows users to

>opt-out
>
pedantically, there should be no dash here, as it's a regular verbal 
phrase. the dash should be used when it's turned into a noun, "to 
provide an opt-out". at least i think so ...

>of the default behavior.
>
>While adding options, make sure the usage output by 'scalar clone -h'
>reports the same as the SYNOPSIS line in Documentation/scalar.txt.
>

regards
