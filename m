Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3BEC433F5
	for <git@archiver.kernel.org>; Sun, 20 Mar 2022 10:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237557AbiCTKyi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Mar 2022 06:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbiCTKyh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Mar 2022 06:54:37 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD042AE3E
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 03:53:14 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id C6D5B23FAE;
        Sun, 20 Mar 2022 06:53:09 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1nVtBN-VzO-00; Sun, 20 Mar 2022 11:53:09 +0100
Date:   Sun, 20 Mar 2022 11:53:09 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
Subject: Re: using oldest date when squashing commits
Message-ID: <YjcHlf3Tyvq+vazm@ugly>
References: <YjXRM5HiRizZ035p@ugly>
 <9fae5292-d58f-95da-245b-6e205383cb50@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <9fae5292-d58f-95da-245b-6e205383cb50@kdbg.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 20, 2022 at 09:05:45AM +0100, Johannes Sixt wrote:
>You want `fixup -C` in the todo-list. See the hints near the end of the
>todo-list.
>
oh, cool, thanks. i didn't expect to find it _there_. :}

note that neither the man page nor the inline comment mention either 
"date" or "timestamp". of course that seems redundant when one knows how 
commit -C works, but it's not helpful for discoverability by keywords.
