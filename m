Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9261BEE498D
	for <git@archiver.kernel.org>; Fri, 18 Aug 2023 19:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379527AbjHRTAc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Aug 2023 15:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379534AbjHRTAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2023 15:00:16 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCCE2D7D
        for <git@vger.kernel.org>; Fri, 18 Aug 2023 12:00:14 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id A52EA24129;
        Fri, 18 Aug 2023 15:00:12 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qX4hg-kR7-00; Fri, 18 Aug 2023 21:00:12 +0200
Date:   Fri, 18 Aug 2023 21:00:12 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] update-index doc: v4 is OK with JGit and libgit2
Message-ID: <ZN+/vJysYcri/iBz@ugly>
References: <xmqqil9cusfn.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqil9cusfn.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 18, 2023 at 11:16:44AM -0700, Junio C Hamano wrote:
>+time. The first version to support it was Git 1.8.0 released in
>+October 2012,

"Git supports it since version 1.8.0[, which was] released in October 
2012, and ..." would be probably easier to read.

>and support for it was added to libgit2 in 2016 and

+to

>+JGit in 2020,

>respectively.
>
this use of "respectively" is bogus; just leave it off. it would make 
sense if you wrote "was added to libgit2 and jgit in 2016 and 2020, 
respectively", but this would just complicate matters.

regards
