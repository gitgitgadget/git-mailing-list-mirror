Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEC3C7618D
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 15:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239269AbjDFPv3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 11:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239257AbjDFPv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 11:51:26 -0400
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135579754
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 08:51:16 -0700 (PDT)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 3DD2E1133CE; Thu,  6 Apr 2023 11:50:45 -0400 (EDT)
References: <CAGP6POLrtA_9kjCwUbVB8-F+dgQbhz==oy5SsXULfspNj_Umuw@mail.gmail.com>
 <87edp0ak45.fsf@vps.thesusis.net>
 <CAGP6POLVpjxO91s1dX98TLepXMrybSWq9y8qJ6b7w+e0SRJT1A@mail.gmail.com>
User-agent: mu4e 1.7.12; emacs 27.1
From:   Phillip Susi <phill@thesusis.net>
To:     Hongyi Zhao <hongyi.zhao@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: git revert with partial commit.
Date:   Thu, 06 Apr 2023 11:48:54 -0400
In-reply-to: <CAGP6POLVpjxO91s1dX98TLepXMrybSWq9y8qJ6b7w+e0SRJT1A@mail.gmail.com>
Message-ID: <87355ddn6y.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hongyi Zhao <hongyi.zhao@gmail.com> writes:

> Because the commit I want to revert is done a long time ago, which is
> not the parent of the commit I'm currently on, so I can't use the `~1`
> which indicates that I want to go back one commit from my current
> position.

You *can* use HEAD~1.  After the git revert, a new commit has been
created, and so HEAD~1 refers to the state of things before running git
revert.
