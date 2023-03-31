Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DFFC6FD18
	for <git@archiver.kernel.org>; Fri, 31 Mar 2023 12:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjCaMDR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 08:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjCaMDQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 08:03:16 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A671CB89
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 05:03:14 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 87C5523F9C;
        Fri, 31 Mar 2023 08:03:13 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1piDTN-OJe-00; Fri, 31 Mar 2023 14:03:13 +0200
Date:   Fri, 31 Mar 2023 14:03:13 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     ryicoh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, ryicoh <ryicoh@gmail.com>
Subject: Re: [PATCH] doc: add that '-' is the same as '@{-1}'
Message-ID: <ZCbMAWsaseAmwmqc@ugly>
Mail-Followup-To: ryicoh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, ryicoh <ryicoh@gmail.com>
References: <pull.1484.git.git.1680257503697.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <pull.1484.git.git.1680257503697.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 31, 2023 at 10:11:43AM +0000, ryicoh via GitGitGadget wrote:
>+  before the current one. You may also specify - which is synonymous
>+  to @{-1}.
> 
i'd recommend quoting the dash as you do in the summary (or adding some 
markup?), as otherwise it's way too easy to misread.

