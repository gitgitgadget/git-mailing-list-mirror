Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFA451F462
	for <e@80x24.org>; Tue, 28 May 2019 17:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfE1R5a (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 13:57:30 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51454 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfE1R5a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 13:57:30 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A2C6E6C69A;
        Tue, 28 May 2019 13:57:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nPlbb4BoSLsCI2V5cbDVJHMNaoo=; b=ouoWrE
        +q64ImB5cQGr/nkMbByTotbyeRNQy+yPOq416B4ijqqkNRlJiGAqVZp31cwQvBPz
        r7YLe5FaiidT6tqXyhQ+5kH/dab6aCQETrtnx+dRuNqT1FN0EGx4QKhE0WbFcW5x
        3P5ZAUZGHHRcrDplm772ssy2k//3D9TeLGKiw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=p2nCQ25yWF+JNPrYMMqJAj3N1hX5KOor
        fRKjMNE4LOu5uAB8lk8jg6pHoMsi2xLNFenYLZ7ApFQcRSzRunh3+I6XARG9FN6s
        wxwhLAeSwimXUy6OuA4brT8jWayAGugrltGemfzU9ejJ7mZ1qvF5kWf4dgLzH8d6
        ciYbW9wdEU4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9AED86C699;
        Tue, 28 May 2019 13:57:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C7ADB6C698;
        Tue, 28 May 2019 13:57:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] grep: fail if call could output and name is null
References: <20190522003402.77767-1-emilyshaffer@google.com>
        <20190523202355.152742-1-emilyshaffer@google.com>
        <20190523203415.GB70860@google.com>
Date:   Tue, 28 May 2019 10:57:23 -0700
In-Reply-To: <20190523203415.GB70860@google.com> (Jonathan Nieder's message of
        "Thu, 23 May 2019 13:34:15 -0700")
Message-ID: <xmqqmuj631j0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D25B7D2-8172-11E9-A83F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Emily Shaffer wrote:
>
>> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
>> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>> ---
>> Since v3, only the commit message has changed. Reworked based on
>> Jonathan Nieder's suggestions (with some modifications for readability).
>>
>>  grep.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>
> This is indeed
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> Thanks for your patient work.

Thanks, both.  Will queue.
