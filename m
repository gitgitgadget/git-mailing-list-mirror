Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB5FCE79A8
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 18:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjISSJP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 14:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjISSJO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 14:09:14 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FF0BD
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 11:09:07 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6E5152CB04;
        Tue, 19 Sep 2023 14:09:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=lAL4VYMqcyIGqQy2pr460k/LNXUMQneMH46vLZ
        EFfj8=; b=wWllugH14Qh3RmpWSM+6GnfcrEPM7g0qd6wDtdGoKNqYqJOAd0pnIs
        N612xjVxNRA66leh9P/sMoX7qdJjM1Jh7LbLlKQbdL1ySGu9Rn3bVZtdQYcTaZ5M
        qxpZ0JwBa+NHelRz3qOgJe1yy2iRBKiKpfnxQpxTTOgxrhPXf3GW8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 675502CB03;
        Tue, 19 Sep 2023 14:09:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 036042CB01;
        Tue, 19 Sep 2023 14:09:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Jeff Hostetler <jeffhostetler@github.com>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH 0/8] fsmonitor unused parameter cleanups
In-Reply-To: <7356bb25-12aa-dc6a-9b32-87d13c49994c@jeffhostetler.com> (Jeff
        Hostetler's message of "Tue, 19 Sep 2023 09:34:07 -0400")
References: <20230918222908.GA2659096@coredump.intra.peff.net>
        <7356bb25-12aa-dc6a-9b32-87d13c49994c@jeffhostetler.com>
Date:   Tue, 19 Sep 2023 11:09:02 -0700
Message-ID: <xmqqttrqf329.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9DEA515E-5717-11EE-AD6F-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> On 9/18/23 6:29 PM, Jeff King wrote:
>> Here are a few cleanups of the fsmonitor code to remove or annotate
>> unused parameters (working towards my goal of making us compile clean
> ...
> LGTM
>
> Thanks,
> Jeff

Thanks, both.  Let's merge it down.

