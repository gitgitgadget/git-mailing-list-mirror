Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F333C04AAD
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 15:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbjITPtP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 11:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235498AbjITPtN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 11:49:13 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E06B4
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 08:49:08 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AE6B11AA54A;
        Wed, 20 Sep 2023 11:49:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=9haTjLXHla0MBb2sj9d6GJlNodNayYyDhDTv+5
        8ZXMQ=; b=ZzgNCU9BjAgcGrZRcX1750rADrUs1PYncwQ5b233+CyjdL+ChvZQET
        cOY/QzvDnXGNJWkCvTcWrGYAjlF+FjiRnTcw+VzzYUS6SiSEC9ErB0eleoigvAqR
        aE4GmYLD4c1RZffgwtGP2ygpketLMR3eIjiiYObThgTXIF1CfEf94=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A3E781AA549;
        Wed, 20 Sep 2023 11:49:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0F45D1AA547;
        Wed, 20 Sep 2023 11:49:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Mark Levedahl <mlevedahl@gmail.com>, johannes.schindelin@gmx.de,
        git@vger.kernel.org
Subject: Re: [PATCH] git-gui - use git-hook, honor core.hooksPath
In-Reply-To: <mafs01qetq9kk.fsf@yadavpratyush.com> (Pratyush Yadav's message
        of "Wed, 20 Sep 2023 15:05:15 +0200")
References: <fa876f80-02dc-2c04-0db3-bf3f6269b427@gmail.com>
        <20230917192431.101775-1-mlevedahl@gmail.com>
        <mafs01qetq9kk.fsf@yadavpratyush.com>
Date:   Wed, 20 Sep 2023 08:49:05 -0700
Message-ID: <xmqqttroalqm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3B5AFFDC-57CD-11EE-B60D-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush Yadav <me@yadavpratyush.com> writes:

> In the past, git-gui has tried to keep backward compatibility with all
> versions of Git, not just the latest ones. v2.36 is relatively new and
> this code would not work for anyone using an older version of Git.
>
> I have largely followed this practice for all the code I have written
> but I am not sure if it is a good idea to insist on it -- especially if
> it would end up adding some more complexity. I would be interested to
> hear what other people think about this.

Good point.

> Junio, I was under the impression that I would keep maintaining the tree
> until we found a replacement maintainer. If you are okay with being the
> interim maintainer, that sounds good to me. Let me know what works best.

I am actually not OK ;-).

I prefer to see somebody who does use git-gui, or at least somebody
who uses Git in a graphical environment in their daily work, to be
maintaining it.  I am disqualified on both counts.

> I have applied another patch since my last pull request. So I can apply
> this one, send you a new one and sync our trees.

OK.  I'll drop the copy I have on my end when it happens, then.

Thanks.

