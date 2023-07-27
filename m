Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BF7EB64DD
	for <git@archiver.kernel.org>; Thu, 27 Jul 2023 21:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjG0VwO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jul 2023 17:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjG0VwN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2023 17:52:13 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9B62135
        for <git@vger.kernel.org>; Thu, 27 Jul 2023 14:52:12 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2C7B3316AE;
        Thu, 27 Jul 2023 17:52:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DlY/YxhJzfO+iTTtKrbuW1wYV95y5gbhLpAuXK
        VPAeU=; b=afy797haAaLuviPhqF1+Q2urARdsCtBjS74pI6snMBTCIfKHtRE6jL
        NALQyq7jsjEucGt96gcmJSv1fcefaTWQ6gM/24KElWSE1psKkTdh/eA4TsfKYX8t
        lklC8I0Ulj8pitnjSyL7QxX8U6D9RLkW/RENAlInDwuzH8UIhpSr4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 257D0316AD;
        Thu, 27 Jul 2023 17:52:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B92EE316AC;
        Thu, 27 Jul 2023 17:52:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Arver <linusa@google.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2023, #05; Tue, 25)
References: <xmqqedkvk8u4.fsf@gitster.g>
        <owlyedktf3of.fsf@fine.c.googlers.com>
Date:   Thu, 27 Jul 2023 14:52:07 -0700
In-Reply-To: <owlyedktf3of.fsf@fine.c.googlers.com> (Linus Arver's message of
        "Thu, 27 Jul 2023 14:24:48 -0700")
Message-ID: <xmqqpm4d9g54.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D589734E-2CC7-11EE-8685-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Arver <linusa@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> ...
>> 
>> --------------------------------------------------
>> [Cooking]
>>
>> ...
>> 
>> * jc/doc-sent-patch-now-what (2023-07-19) 1 commit
>>  - MyFirstContribution: refrain from self-iterating too much
>>
>>  Process document update.
>>
>>  Will merge to 'next'?
>>  source: <xmqqzga9opdu.fsf@gitster.g>
>
> Please wait until seeing my review (will send later today).

Thanks.
