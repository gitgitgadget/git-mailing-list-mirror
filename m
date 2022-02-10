Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126DDC433FE
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 02:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbiBJCCR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 21:02:17 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbiBJCAP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 21:00:15 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57EC2B241
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 17:42:56 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9F52D191444;
        Wed,  9 Feb 2022 20:42:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qIeJzptq1uFlc7VtYS8rWP3rCaeYcvfdVK2I5Y
        S7bBI=; b=kZ9AJhYkwVkv37KXfMpEbO2Om88hNRe21Zvm29oNdEIbKwKWHPHTGK
        hkYdfUumO72wvPuZKQMBeUftgI8XnzOuiSR0V8H+8LVMBKLIKOZ3UX2cQSlHVYsh
        srv5O+1l+O/98T7hCnXdxFF2YXSyUCriPBhyVeXfMWV8qHS/BynJA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9954D191443;
        Wed,  9 Feb 2022 20:42:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AA847191440;
        Wed,  9 Feb 2022 20:42:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Jaydeep P Das <jaydeepjd.8914@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] t/t0015-hash.sh: removed unnecessary '\' at line end
References: <20220208092339.651761-1-jaydeepjd.8914@gmail.com>
        <20220208092339.651761-2-jaydeepjd.8914@gmail.com>
        <81e8a217-356d-65cd-3a89-f20ef9c1a5d7@gmail.com>
Date:   Wed, 09 Feb 2022 17:42:51 -0800
In-Reply-To: <81e8a217-356d-65cd-3a89-f20ef9c1a5d7@gmail.com> (Bagas Sanjaya's
        message of "Thu, 10 Feb 2022 08:18:07 +0700")
Message-ID: <xmqqleyjxzs4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C2FE4262-8A12-11EC-AEDE-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

>> -	perl -e "$| = 1; print q{aaaaaaaaaa} for 1..100000;" | \
>> +	perl -e "$| = 1; print q{aaaaaaaaaa} for 1..100000;" |
>> -	perl -e "$| = 1; print q{aaaaaaaaaa} for 1..100000;" | \
>> +	perl -e "$| = 1; print q{aaaaaaaaaa} for 1..100000;" |
>> -	perl -e "$| = 1; print q{abcdefghijklmnopqrstuvwxyz} for 1..100000;" | \
>> +	perl -e "$| = 1; print q{abcdefghijklmnopqrstuvwxyz} for 1..100000;" |
>>   		test-tool sha256 >actual &&
>>   	grep e406ba321ca712ad35a698bf0af8d61fc4dc40eca6bdcea4697962724ccbde35 actual &&
>>   	printf "blob 0\0" | test-tool sha256 >actual &&
>
> Looks OK.

Yeah, with "removed" -> "remove" on the title, this would look
perfect.

Thanks, both.
