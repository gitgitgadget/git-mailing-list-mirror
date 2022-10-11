Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842EEC433F5
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 17:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiJKRmG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 13:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJKRmF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 13:42:05 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB71FD12B
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 10:42:03 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F1CD14BD04;
        Tue, 11 Oct 2022 13:42:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RjPnFTWGyXCvNQ7dng1i1aW6pajUob0KQPw8qH
        WBKrk=; b=lFBmxtKt3JN3KhgNMVl3DoN6NJVRdVV0RK5uAztOo4l34p+0E3Smh/
        IRugANaq1eeB69N0qGx9iW4gWUd/UisaAHLdPk9n/4puP7TFi42VZiVaZDmw1LNy
        DN43wdyrXYKQbPBsvAbL53ch1tIG+dPWlXrCAz9crPOctlUhAaR88=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D216714BD02;
        Tue, 11 Oct 2022 13:42:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E398514BD00;
        Tue, 11 Oct 2022 13:42:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sotir Danailov <sndanailov@wired4ever.net>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        aaron@schrab.com, philipoakley@iee.email
Subject: Re: [PATCH v2] docs: git-send-email: difference between ssl and tls
 smtp-encryption
References: <20221011164927.1516-1-sndanailov@wired4ever.net>
        <xmqqh70auvf3.fsf@gitster.g>
        <f384d6b9-fb4c-cf22-ea88-8ab50f319a78@wired4ever.net>
Date:   Tue, 11 Oct 2022 10:41:59 -0700
In-Reply-To: <f384d6b9-fb4c-cf22-ea88-8ab50f319a78@wired4ever.net> (Sotir
        Danailov's message of "Tue, 11 Oct 2022 19:31:43 +0200")
Message-ID: <xmqqczayuujc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 02CBF82E-498C-11ED-8BD0-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sotir Danailov <sndanailov@wired4ever.net> writes:

> On Tue 11 10 2022 19:22, Junio C Hamano wrote:
>> Please always start the description of a thing by explaining what
>> the thing is.
>
> Wow I can't believe I missed that...sorry!
>
>> I think the updated text is otherwise good, but it would be better
>> to remove "The difference between ... is the following."  The text
>> is easier to read without that sentence.
>
> I just wanted to make it clear that this is how Git interprets these values.
> But yeah, you're right, it's unnecessary.
>
> I will make a v3 tomorrow.

Thanks.
