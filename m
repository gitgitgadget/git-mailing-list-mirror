Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A531EC433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 18:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245720AbiCWS2s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 14:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbiCWS2r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 14:28:47 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A9E7892F
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 11:27:17 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 039B81292C8;
        Wed, 23 Mar 2022 14:27:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZRhr8B7cnpu0aZ0bpF1+XDZTI+/TAg+zRrPPZ+
        ySST8=; b=IjwPM0koiI3ynhLOJMXLYIbuuC5mSthX3EaaAXq1l+B6rl4bZCRI8V
        8zeS7VThWCv7y2HTGt/fPh8W6LIG2GFds66rcUo+s8EaPqrLZhsGjUxbp4pbu5Y3
        VXGe8JBiVVYl17bECGpahCypEkywCYEfeKrGHuUT8j0mcW8czbX+4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ED8911292C7;
        Wed, 23 Mar 2022 14:27:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 548501292C6;
        Wed, 23 Mar 2022 14:27:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2022, #04; Thu, 17)
References: <xmqqv8wcizi4.fsf@gitster.g> <YjkloVk0BTqcgIiL@nand.local>
Date:   Wed, 23 Mar 2022 11:27:14 -0700
In-Reply-To: <YjkloVk0BTqcgIiL@nand.local> (Taylor Blau's message of "Mon, 21
        Mar 2022 21:25:53 -0400")
Message-ID: <xmqqo81wsewt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD446AA4-AAD6-11EC-BEF7-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Thu, Mar 17, 2022 at 04:34:27AM -0700, Junio C Hamano wrote:
>> * tb/cruft-packs (2022-03-02) 17 commits
>>
>>  A mechanism to pack unreachable objects into a "cruft pack",
>>  instead of ejecting them into loose form to be reclaimed later, has
>>  been introduced.
>>
>>  Waiting for discussion to settle.
>>  cf. <YiZI99yeijQe5Jaq@google.com>
>>  source: <cover.1646266835.git.me@ttaylorr.com>
>
> I responded to Jonathan's message here:
>
>     https://lore.kernel.org/git/YjkjaH61dMLHXr0d@nand.local/
>
> and I think it should be settled now. In an earlier thread, there was
> some discussion about whether or not a repository format extension is
> required. An extension is explicitly not required here, since the
> implementation of cruft packs was designed to avoid such a thing (see
> [1] for details on "why").

I think <Yjpxd8qhwnAIJJma@nand.local> yesterday is the last message
in that thread?

Let's see how well it goes.

Thanks.
