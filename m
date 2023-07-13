Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDB5C0015E
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 20:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjGMUzj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 16:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjGMUzi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 16:55:38 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96E7CE
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 13:55:34 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E4A8839769;
        Thu, 13 Jul 2023 16:55:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0L92s8kAiHMniOyvupVuCsM9yRSS/Vk7YHIYDu
        pqhTY=; b=NWiiIym3nA3duNGTBYs3dAUGXcE1BOs363UZLF5XWa2QG6de2m40Gn
        asZ9d97NXXZfnpsjBvc0NHL91tt7HsbrO81v8dKMyzca7padEbQ4ogiEZM+utQjW
        yPJxJRbABuBvRfub4UR6O3cnCSZt/3uM8FM1Df9ZekF7+LuWyWRAY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CECFE39768;
        Thu, 13 Jul 2023 16:55:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5C4A039766;
        Thu, 13 Jul 2023 16:55:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Petar Vutov <pvutov@imap.cc>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/1] docs: highlight that .gitmodules does not
 support !command
References: <d775437e-7fa3-189b-a1c3-4fd358dd9768@imap.cc>
        <20230713193342.1053968-1-pvutov@imap.cc>
        <a8bde495-57fc-6a70-e325-6e2a52f40552@imap.cc>
        <xmqqwmz3oacg.fsf@gitster.g>
        <9de918bc-6913-0486-02dd-5b4028a7fe1b@imap.cc>
Date:   Thu, 13 Jul 2023 13:55:29 -0700
In-Reply-To: <9de918bc-6913-0486-02dd-5b4028a7fe1b@imap.cc> (Petar Vutov's
        message of "Thu, 13 Jul 2023 22:34:16 +0200")
Message-ID: <xmqqa5vzo7jy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A292E9C-21BF-11EE-82D0-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Petar Vutov <pvutov@imap.cc> writes:

> I prefer the original description as it uses shorter sentences. I
> can't hold that 5-liner in my head :)

But you are comparing oranges and apples, aren't you?  You are not
counting "oh by the way this cannot be in .gitmodules" as part of 5.

> But now I really am bikeshedding, and I've taken enough of your
> time. I will send a v4 with just the .gitmodules disclaimer, no
> rewrite, in case you end up agreeing.

After reading the original again and again, I hate more and more the
way the original wasted too many words to refer to one thing twice
(e.g. "arbitrary command" and then "is the custom command", "a
single argument" and then the parenthesized explanation of it)
without adding any clarity.

