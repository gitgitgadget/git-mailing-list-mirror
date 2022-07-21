Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CFAC43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 16:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbiGUQ2M convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 21 Jul 2022 12:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiGUQ2L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 12:28:11 -0400
X-Greylist: delayed 491 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 Jul 2022 09:28:10 PDT
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5678875B
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 09:28:10 -0700 (PDT)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 545FCD600D; Thu, 21 Jul 2022 12:19:28 -0400 (EDT)
References: <bdbe9b7c1123f70c0b4325d778af1df8fea2bb1b.camel@that.guru>
 <220718.86ilnuw8jo.gmgdl@evledraar.gmail.com>
User-agent: mu4e 1.7.12; emacs 27.1
From:   Phillip Susi <phill@thesusis.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Stephen Finucane <stephen@that.guru>, git@vger.kernel.org
Subject: Re: Feature request: provide a persistent IDs on a commit
Date:   Thu, 21 Jul 2022 12:18:17 -0400
In-reply-to: <220718.86ilnuw8jo.gmgdl@evledraar.gmail.com>
Message-ID: <87a692e8vj.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> This has come up a bunch of times. I think that the thing git itself
> should be doing is to lean into the same notion that we use for tracking
> renames. I.e. we don't, we analyze history after-the-fact and spot the
> renames for you.

I've never been a big fan of that quality of git because it is
inherently unreliable.
