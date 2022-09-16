Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C164ECAAD8
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 16:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiIPQob (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 12:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiIPQoa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 12:44:30 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70EDCCC
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 09:44:28 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AC05813587A;
        Fri, 16 Sep 2022 12:44:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=82rGUSMnmpgVEd3eTNvBBReYmSWixWHVYoOSkq
        OLwpc=; b=rYZ1ZgOe4eJJr/ESQJxy8aS6iMVUL+KCbjdUK2vo/kHbAnhcjbpNyk
        PvMUD9KAOkzKjc2AVMV8tO6mdM+65NXtf8JskPCfPjMdASYrJzKxODDCM+NmgaE8
        nmO+RDkQ0XK+EDeEpwqHeScgMfT42b0RL3cE2sZh+R+/KfDWEaDeI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A2748135879;
        Fri, 16 Sep 2022 12:44:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0D13B135878;
        Fri, 16 Sep 2022 12:44:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/5] environ: simplify description of GIT_INDEX_FILE
References: <xmqq8rmkpsit.fsf@gitster.g>
        <20220915160659.126441-1-gitster@pobox.com>
        <20220915160659.126441-5-gitster@pobox.com>
        <YySYq94EEGfwXMjd@pobox.com>
Date:   Fri, 16 Sep 2022 09:44:25 -0700
In-Reply-To: <YySYq94EEGfwXMjd@pobox.com> (Todd Zullinger's message of "Fri,
        16 Sep 2022 11:39:23 -0400")
Message-ID: <xmqqk063i80m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D3CBD96A-35DE-11ED-BB77-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> Junio C Hamano wrote:
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  Documentation/git.txt | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/Documentation/git.txt b/Documentation/git.txt
>> index 3d31252bf2..535ff561c6 100644
>> --- a/Documentation/git.txt
>> +++ b/Documentation/git.txt
>> @@ -472,7 +472,7 @@ is worth noting that they may be used/overridden by SCMS sitting above
>>  Git so take care if using a foreign front-end.
>>  
>>  `GIT_INDEX_FILE`::
>> -	This environment allows the specification of an alternate
>> +	This environment specifies an alternate
>
> While here, `s/environment/& variable/` would make this a
> bit easier to read and more consistent with the nearby
> descriptions.

Absolutely.  Thanks!
