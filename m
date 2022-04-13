Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E53C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 17:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237430AbiDMRrn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 13:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237438AbiDMRrm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 13:47:42 -0400
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F7639BB3
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 10:45:20 -0700 (PDT)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id C4B1DBE27D; Wed, 13 Apr 2022 13:44:49 -0400 (EDT)
References: <20220413164336.101390-1-eantoranz@gmail.com>
User-agent: mu4e 1.7.0; emacs 27.1
From:   Phillip Susi <phill@thesusis.net>
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] introducing git replay
Date:   Wed, 13 Apr 2022 13:44:01 -0400
In-reply-to: <20220413164336.101390-1-eantoranz@gmail.com>
Message-ID: <8735iglvxq.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Edmundo Carmona Antoranz <eantoranz@gmail.com> writes:

> If HEAD and v2.35.0 share the same tree, it _should_ be possible
> to recreate the commits that make up the range v2.35.0..v2.36.0-rc1
> on top of HEAD without requiring any real "rebasing". Just creating

Isn't that literally the definition of rebase?

