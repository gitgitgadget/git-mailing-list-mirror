Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A707C6FD1C
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 18:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjCWSye (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 14:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjCWSyc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 14:54:32 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70752B609
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 11:54:31 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 33D6A20309
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 14:54:30 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pfQ4z-dP8-00
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 19:54:29 +0100
Date:   Thu, 23 Mar 2023 19:54:29 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: limiting git branch --contains
Message-ID: <ZBygZbz5E6jVNp3y@ugly>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

moin,

git branch --contains can be a rather expensive operation in big 
repositories. as my use case is actually a rather limited search for 
commits in my local wip branches, it would be helpful to be able to 
specify exclusions for the rev-walk, say

   git branch --contains deadbeef ^origin/master

suggestions how this is actually already achievable efficiently are of 
course welcome as well. ^^

thanks!
