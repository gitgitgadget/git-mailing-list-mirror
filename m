Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34919CE7A81
	for <git@archiver.kernel.org>; Sat, 23 Sep 2023 00:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjIWAtC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 20:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjIWAtB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 20:49:01 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC480B9
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 17:48:55 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C330B26BB3;
        Fri, 22 Sep 2023 20:48:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=+AqtaIgvbxf6/rJ093Ca6QCOw+3u4jk09UK5eS
        4fm2U=; b=S39hKdbqmRy9WNB4QygE5MJdqX9O3xtfBROhwSaPfZ/o3Rr2uSziE9
        TkONGD7zoyC1t8n/RQsPBpblLgAlAxz6051NEAZHVQB1DiRA/5BOBIj/81noDzk5
        NfSdDcI3OpAepLBzuqQ9/KVIS5v6zSn1+qATX3bSnBK5JtdZBGRpY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B7C2A26BB2;
        Fri, 22 Sep 2023 20:48:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4907626B78;
        Fri, 22 Sep 2023 20:48:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Arver <linusa@google.com>
Cc:     Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Glen Choo <glencbz@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 0/9] Trailer readability cleanups
In-Reply-To: <owlyzg1dsswr.fsf@fine.c.googlers.com> (Linus Arver's message of
        "Fri, 22 Sep 2023 16:13:40 -0700")
References: <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com>
        <pull.1563.v3.git.1695412245.gitgitgadget@gmail.com>
        <xmqq8r8xyge6.fsf@gitster.g> <owlyzg1dsswr.fsf@fine.c.googlers.com>
Date:   Fri, 22 Sep 2023 17:48:47 -0700
Message-ID: <xmqqo7htww7k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F57F3DB8-59AA-11EE-8971-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Arver <linusa@google.com> writes:

>> I could revert and discard [4-6/6] of the previous iteration out of
>> 'next' and have only the first three (which I thought have been
>> adequately reviewed without remaining issues) graduate to 'master',
>> if it makes it easier to fix this update on top, but I'd rather not
>> to encourage people to form a habit of reverting changes out of
>> 'next'.
>>
>> Thanks.
>
> I totally agree that reverting changes out of next is undesirable. I
> will do a reroll on top of 'next' with only those incremental (new)
> patches.

OK, so the first 3 patches are now in 'master', and the remainder of
the previous series have been discarded.

Thanks.
