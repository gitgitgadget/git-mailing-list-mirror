Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5E6C83F12
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 10:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238658AbjHaKjo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 06:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjHaKjn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 06:39:43 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0FBCF4
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 03:39:39 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 9F1482423B;
        Thu, 31 Aug 2023 06:39:37 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qbf5N-EYR-00; Thu, 31 Aug 2023 12:39:37 +0200
Date:   Thu, 31 Aug 2023 12:39:37 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 10/10] lower core.maxTreeDepth default to 2048
Message-ID: <ZPBt6VYAWHJhv3N2@ugly>
References: <20230831061735.GA2702156@coredump.intra.peff.net>
 <20230831062320.GJ3185325@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230831062320.GJ3185325@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 31, 2023 at 02:23:20AM -0400, Jeff King wrote:
>But I thought that
>following the sequence of logic (from "4096 is probably OK" to "whoops,
>it's not") had some value to share.
>
of course, but you can just integrate that into the squashed commit 
message. having it all in one place makes it easier to follow.

regards
