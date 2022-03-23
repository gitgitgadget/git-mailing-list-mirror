Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDF6C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 21:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241131AbiCWVjZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 17:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240607AbiCWVjY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 17:39:24 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9AF7D00F
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 14:37:54 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A5DEE122C0C;
        Wed, 23 Mar 2022 17:37:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0QkjDsUdiJz19s26Ya4mWHxjufRlPFe4HXcD3z
        OVMfc=; b=mtaoVMDy5CBwFxTTO8opebOlYr162SR+dTbvM4zOYUIuBjKooiVx4I
        KrSM07ps9voEHMjNvxmWr5s9bMQbxKjvVSkLzfE9wKHfoKsTDi20i5iA7mrlTZjj
        VYXOtwrhwCqsULuXYt/J78kwboWCj6GQv7HZBHJQGLX6jAdj0ceK8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E478122C0B;
        Wed, 23 Mar 2022 17:37:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EBC4B122C09;
        Wed, 23 Mar 2022 17:37:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2022, #04; Thu, 17)
References: <xmqqv8wcizi4.fsf@gitster.g> <YjkloVk0BTqcgIiL@nand.local>
        <xmqqo81wsewt.fsf@gitster.g> <Yjty9DhYLDfz5Oay@nand.local>
Date:   Wed, 23 Mar 2022 14:37:51 -0700
In-Reply-To: <Yjty9DhYLDfz5Oay@nand.local> (Taylor Blau's message of "Wed, 23
        Mar 2022 15:20:20 -0400")
Message-ID: <xmqqczicqrio.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7E9FB15A-AAF1-11EC-B139-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Wed, Mar 23, 2022 at 11:27:14AM -0700, Junio C Hamano wrote:
>> I think <Yjpxd8qhwnAIJJma@nand.local> yesterday is the last message
>> in that thread?
>>
>> Let's see how well it goes.
>
> Yeah, that is the last message in the thread (at least, at the time of
> writing this message).
>
> Jonathan had a few suggestions of things that we could add to
> Documentation/cruft-packs.txt. I added details in my reply where they
> were unclear, but I'll focus on touching up the new documentation in a
> follow-up set of patches to avoid delaying things further.

If we cannot come up with a clear description, isn't it a sign that
our thinking is still not clear and merging things in haste would
produce a suboptimal waste?  If that is not the case, I'd be happy
to merge it down.

Thanks.
