Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C1EC433E0
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 00:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDB4E64E50
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 00:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbhBJAeB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 19:34:01 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60589 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbhBJAN2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 19:13:28 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6D2AD10DB78;
        Tue,  9 Feb 2021 19:12:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5L63R1f3Ee4/jMDUX5ruUt02mkk=; b=q7rWQr
        DTCFyAIDvF8XGEIpamU2FJtaKsaw+YhNI6rtX2wDmFGtAFLtsy/kkNJ75feXdbS8
        RlZ4g2IqmG8Vq+GzPcdexE2FBjSgYEyGnltRLo7ZaQbwyItfCIQCCHWnJ5ugfsts
        O9eA8nby8NbJfqTYs/jYkJz4s02g7hyih8vto=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Dlk0r/iXSF6qjDx2VmkxOWbFbLmA8Yv7
        B9mVSRfxRsUp3MQDaIPVecY3Ar+bupLXX7zn5S8tsp6NgIZqCLlsTx2omJCrIeJK
        yfp45GgrYMC+wlzuWOAcG9dlmLMZSa8KFLOtWKTi9AqtU4474LqHLciyt5LnkbFc
        vbizL7GRPi8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 65AB510DB77;
        Tue,  9 Feb 2021 19:12:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B024F10DB76;
        Tue,  9 Feb 2021 19:12:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [rfh] where is coccinelle these days on Ubuntu?
References: <xmqqeehv2t71.fsf@gitster.c.googlers.com>
        <YBylBKMG4G4dbiOW@nand.local>
        <xmqqr1lt9gm3.fsf@gitster.c.googlers.com>
        <YCGrmsg8J7XT32TM@nand.local>
Date:   Tue, 09 Feb 2021 16:12:41 -0800
In-Reply-To: <YCGrmsg8J7XT32TM@nand.local> (Taylor Blau's message of "Mon, 8
        Feb 2021 16:22:34 -0500")
Message-ID: <xmqqlfbwye4m.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B19E8A66-6B34-11EB-8F93-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> So, I guess we could continue to run on 18.04 until there is a focal
> coccinelle. Below would be the way to do that...
>
> Thanks,
> Taylor

Thanks.  Let's merge this down to 'next', 'master' and then to
'maint'.
