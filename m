Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DE6C433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 21:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240706AbiA0VjL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 16:39:11 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56616 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbiA0VjK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 16:39:10 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9201C10769C;
        Thu, 27 Jan 2022 16:39:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ug0gi0nfNn60oTCZ/fDtIB0ePOeNKOcReIfhbz
        9QIKM=; b=JtehsjrvXcssDow0hsykDTahFS/W0wbeRT8dVRg5seBj7kl1JRTdxK
        mM9qqyD3VR0nf8hCXraJc6dwSRqrqjRoFi2R87XTWq1vJb4AlXOY4YRKJ+XzeMjW
        y3OGdW6WqMQu0yL838eZWVM0rgdDU5RewkoTUdTteWezwxuXTD5j0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8854E10769B;
        Thu, 27 Jan 2022 16:39:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 84905107695;
        Thu, 27 Jan 2022 16:39:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v9 9/9] grep: simplify config parsing and option parsing
References: <cover-v8-00.10-00000000000-20220118T155211Z-avarab@gmail.com>
        <cover-v9-0.9-00000000000-20220127T115058Z-avarab@gmail.com>
        <patch-v9-9.9-445467e87f7-20220127T115058Z-avarab@gmail.com>
        <xmqq35l82a7i.fsf@gitster.g> <xmqqpmoczwtu.fsf@gitster.g>
Date:   Thu, 27 Jan 2022 13:39:07 -0800
In-Reply-To: <xmqqpmoczwtu.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        27 Jan 2022 13:35:09 -0800")
Message-ID: <xmqqk0ekzwn8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8EF33652-7FB9-11EC-85CA-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> In addition to squashing the following in, we must update the
> proposed log message.  Given that, even after taking _this long_ (I
> think I have been saying this since the review of v5 iteration),

I found a reference:

    https://lore.kernel.org/git/xmqqv8zf6j86.fsf@gitster.g/

it indeed was [v5 7/7].

It is interesting that the breaking example I gave in the message is
exactly the one that I wrote (without going back to the archive) in
the "squashable fix" patch in the message I am responding to.
