Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837A2C001B0
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 23:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjHJX5c (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 19:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjHJX5c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 19:57:32 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189B32D47
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 16:57:31 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AB8132CE6A;
        Thu, 10 Aug 2023 19:57:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mzGCuMTcG7bEE69Ed/WO279MbH6Yt+hJX3Z7Ly
        YYPzA=; b=QHELP8Y0rxjcew0/SVrnyQHUZ9Bc5MMQNmNTo/CI5MLxVpRs/v4JdM
        yrrPbnZ0/++vOswqqXYsRPeIEjexRGQewBCUkAKyBx9DM2JXPmbs8MkFqdbucLOC
        hDLHbIbmZhL7PJJlTeudW3FC1cRwrYDLfFvxe5PNpbXoXvR3uXPZE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A4A982CE69;
        Thu, 10 Aug 2023 19:57:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 981E52CE68;
        Thu, 10 Aug 2023 19:57:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/1] t/lib-rebase: (mostly) cosmetic improvements to
 set_fake_editor()
References: <8ce40f48-f36f-9e81-1a3f-9d8b170c4a0f@gmail.com>
        <20230809171531.2564785-1-oswald.buddenhagen@gmx.de>
        <xmqqh6p7lxxx.fsf@gitster.g> <ZNS/JteS1nhzk58P@ugly>
        <xmqqpm3uhopi.fsf@gitster.g>
Date:   Thu, 10 Aug 2023 16:57:24 -0700
In-Reply-To: <xmqqpm3uhopi.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        10 Aug 2023 09:00:41 -0700")
Message-ID: <xmqqo7jepi1n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A7B7FD92-37D9-11EE-A4F7-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> no, this cover letter was a messup on my side, caused by a lack of
>> attention and still suboptimal tooling. this was meant to be an update
>> to just this one commit, while keeping the other two intact.
>
> I see.  It is a bit too late for today's integration cycle to
> resurrect the other two I have discarded, because I have other
> things to do including the -rc1 release engineering, but I can
> easily go back to the list archive.

Now I did, so instead of queuing this as a replacement of the three,
one of the three from the earlier has been replaced with this, and
the push-out of tomorrow will have them in 'seen'.

This piece-meal replacement may break threading on the mailing list
but if we ever need v3 and later for this topic, we will see the
entire set resent (hopefully), so the problem will correct itself.
Also if everybody is happy with all three patches, we may not need
v3 ;-)

Thanks.
