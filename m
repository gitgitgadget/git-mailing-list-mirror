Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398DCC4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 16:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FD3660FA0
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 16:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbhHKQEu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 12:04:50 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51798 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbhHKQEt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 12:04:49 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C3E781301CF;
        Wed, 11 Aug 2021 12:04:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=T/zrzkzYPXJBI8g5DlP21JjOm3n08+xWDfSu9Q
        wq7Qc=; b=lgDTvss7XjrJqDQu+QtsXzPb7jCdeiggKfkW6g/l7qUNKj55M6gAsg
        +YOCvdZcFxCJpdL42+V28ZdGwDD2kbdYuoEuOh8XQC4lDqzQcK62Q00yjXQoWut4
        pf6/sf+tHIjipw22IxcjXzAXDpn4XEZ8I5Ty03J6Em/LY4Clkhg2Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BC5F51301CE;
        Wed, 11 Aug 2021 12:04:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E8F781301CD;
        Wed, 11 Aug 2021 12:04:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Tassilo Horn <tsdh@gnu.org>, git@vger.kernel.org
Subject: Re: Re* [PATCH v4] userdiff: improve java hunk header regex
References: <20210810190937.305765-1-tsdh@gnu.org>
        <d3484278-8413-0d10-e6cd-59a7ff04564b@kdbg.org>
        <xmqq35rhc5la.fsf_-_@gitster.g>
        <157a0c35-1c82-9a2e-3bcd-ae6059ec71bd@kdbg.org>
Date:   Wed, 11 Aug 2021 09:04:21 -0700
In-Reply-To: <157a0c35-1c82-9a2e-3bcd-ae6059ec71bd@kdbg.org> (Johannes Sixt's
        message of "Wed, 11 Aug 2021 09:14:13 +0200")
Message-ID: <xmqqv94c9ddm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CB31445A-FABD-11EB-A1DB-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

>> + * When writing or updating patterns, assume that the contents these
>> + * patterns are applied to are syntactically correct.  You do not have
>> + * to implement all syntactical corner cases---the patterns have to be
>> + * sufficiently permissive.
>> + */
>
> IMO, as written, the comment falls short of suggesting that patterns can
> be simple. How about appending "and can be simple"?

    The patterns can be simple without implementing all syntactical
    corner cases, as long as they are sufficiently permissive.

perhaps?

Thanks.


