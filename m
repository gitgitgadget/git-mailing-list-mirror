Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF43C433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 19:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7072A64E6B
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 19:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbhBWTmJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 14:42:09 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60996 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbhBWTmI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 14:42:08 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 64C9A10DA59;
        Tue, 23 Feb 2021 14:41:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=45vHqQ5vTEXg9OqrOxa0ripgMvs=; b=nwNX88
        sizO1tB1VlRvvnQoTqcoPhcwvQLgFvdd9THtV/OM9csyAYAcmpaK1rET4K8VZlEX
        v88tgv3bIc2q53Ht8ryLjzapmrHaU0+TmxiGvw3FMSFJW05SXXN9PMH097o0x8BS
        7uKTeVKehbZ01Lnw2yFtFux+fnIIrCW0EARE0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BMJiGt6WVSL/spZk/SXdrxXPd1lL/6A+
        TQ5TMsqZsvPI4xBmKmblQfeY5VABV7M4y82UP1M56NNhWx8EQGtGfLG5zcaR56SP
        sd9cLuuAh0YdRjg/pIrmutwnEZQL696+unxGEiPOomt6I0bsZAGlyYKwoVgrD6wz
        PEEK0l5fncM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4461410DA57;
        Tue, 23 Feb 2021 14:41:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5D0C910DA56;
        Tue, 23 Feb 2021 14:41:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2] i18n.txt: camel case and monospace
 "i18n.commitEncoding"
References: <cover.1614062288.git.liu.denton@gmail.com>
        <cc48b125166a241ef5f24138fd161223ab35e361.1614062288.git.liu.denton@gmail.com>
        <xmqqy2fe1t6o.fsf_-_@gitster.g>
        <CAPig+cSSnx3y1Uh6uLvdiMn_xg2--w2-_4VDLqXYJ+WARhc6Gg@mail.gmail.com>
Date:   Tue, 23 Feb 2021 11:41:21 -0800
In-Reply-To: <CAPig+cSSnx3y1Uh6uLvdiMn_xg2--w2-_4VDLqXYJ+WARhc6Gg@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 23 Feb 2021 14:32:16 -0500")
Message-ID: <xmqqlfbe1sim.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1C289540-760F-11EB-B826-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Feb 23, 2021 at 2:28 PM Junio C Hamano <gitster@pobox.com> wrote:
>> In 95791be750 (doc: camelCase the i18n config variables to improve
>> readability, 2017-07-17), the other i18n config variables were
>> camel cased. However, this one instance was missed.
>>
>> Camel case and monospace "i18n.commitEncoding" so that it matches the
>> surrounding text.
>>
>> Signed-off-by: Denton Liu <liu.denton@gmail.com>
>> [jc: fixed 3 other mistakes that are exactly the same]
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  * So, while I still remember, I amended your commit and queued
>>    this.
>
> Denton's authorship seems to have been lost (no From: header). Was
> that intentional?

I didn't even notice.

I actually expect that Denton will produce a more complete series
based on the "comm -3" output, so that this patch itself (or its
authorship) won't matter ;-)

And I also expect that somebody will take the "two greps and comm"
trick I showed and wrap it into some form of doc-lint.  Hint, hint...

Thanks.

