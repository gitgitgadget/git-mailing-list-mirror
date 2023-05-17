Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD93C77B7D
	for <git@archiver.kernel.org>; Wed, 17 May 2023 15:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjEQPeF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 11:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjEQPeB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 11:34:01 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57532AD2C
        for <git@vger.kernel.org>; Wed, 17 May 2023 08:33:37 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 18E012049BB;
        Wed, 17 May 2023 11:33:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AkM+ziiGszQBY0HsOp/3+kuIT2JqPco8OrZkC3
        xTIdE=; b=hpdy2X63knSC00nbOiN29udDosnvvgk2kSycEv3zpu1Y1cJuF+kBJf
        J0UWpzAW5gSx08H/oL4SXN+sjusK4aIifotW1kX9EA+htxzPS9pXgagOXrerorRi
        p12OrAuRyQi0wvFIMgbXKYHAHN+Qxs4b+J/DVtoIvzql+opOeWi5I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0EC552049BA;
        Wed, 17 May 2023 11:33:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.203.137.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1EFF92049B7;
        Wed, 17 May 2023 11:32:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, code@khaugsbakk.name, git@vger.kernel.org,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v9 4/6] notes.c: introduce
 '--separator=<paragraph-break>' option
References: <xmqqttwcus7p.fsf@gitster.g>
        <20230517035812.4210-1-tenglong.tl@alibaba-inc.com>
Date:   Wed, 17 May 2023 08:32:58 -0700
In-Reply-To: <20230517035812.4210-1-tenglong.tl@alibaba-inc.com> (Teng Long's
        message of "Wed, 17 May 2023 11:58:12 +0800")
Message-ID: <xmqq5y8rrn11.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A5F02E6-F4C8-11ED-8042-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>> I think --no-separator maybe a better name, means that not any separator will be
>>> append between two paragraphs even a newline.
>>
>>It would work as well.  Is it something we can safely add before
>>merging the topic to upcoming -rc1?
>
> I noticed rc-1 will be released at this Friday, I will post a new patch
> about "--no-separator" today(UTC/GMT+08:00).

Thanks.
