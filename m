Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55C8C433EF
	for <git@archiver.kernel.org>; Sun, 20 Mar 2022 08:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242562AbiCTIHL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Mar 2022 04:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbiCTIHL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Mar 2022 04:07:11 -0400
Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611CA60CF
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 01:05:48 -0700 (PDT)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4KLr0T2zp3z5tlD;
        Sun, 20 Mar 2022 09:05:45 +0100 (CET)
Message-ID: <9fae5292-d58f-95da-245b-6e205383cb50@kdbg.org>
Date:   Sun, 20 Mar 2022 09:05:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: using oldest date when squashing commits
Content-Language: en-US
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
References: <YjXRM5HiRizZ035p@ugly>
Cc:     git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <YjXRM5HiRizZ035p@ugly>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.03.22 um 13:48 schrieb Oswald Buddenhagen:
> during interactive rebasing, i sometimes find it necessary to move a
> hunk from one commit to a later one in the branch. now, if that hunk
> cannot be re-ordered with the later commit due to conflicting with it,
> it becomes necessary to squash the later commit onto a temporary commit
> created from the extracted hunk, not the other way around (or using a
> stash). unfortunately, this causes the author date of the later commit
> to be reset, which can rather seriously falsify the date if the branch
> is long-lived.

You want `fixup -C` in the todo-list. See the hints near the end of the
todo-list.

-- Hannes
