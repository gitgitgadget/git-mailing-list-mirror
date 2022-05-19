Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C934C433EF
	for <git@archiver.kernel.org>; Thu, 19 May 2022 21:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245262AbiESVri (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 17:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239506AbiESVrg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 17:47:36 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF63B972AE
        for <git@vger.kernel.org>; Thu, 19 May 2022 14:47:35 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 64681194BD4;
        Thu, 19 May 2022 17:47:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lEkkkwNh+LIOh3GFgfVAzSD1TTCwka4jBoheDo
        yOKmA=; b=rbtmbyXpJ105szzY/vaxe5Uug+vY2szMKa3OM6mwjLcKJci1GqJP77
        dense46aVIqqhTIusKgKxGMlCa3bG1+ICEi+cKEhAairTe8QY5/ESVdlxlwTqd4r
        eB+IJdVyw+VG9oQgFZ879cg/9HMNq5FrsWRKwgi1egfanBuHRey74=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 52745194BD2;
        Thu, 19 May 2022 17:47:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EF7C5194BC6;
        Thu, 19 May 2022 17:47:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     nksingh85@gmail.com, gitgitgadget@gmail.com,
        Johannes.Schindelin@gmx.de, avarab@gmail.com, bagasdotme@gmail.com,
        jeffhost@microsoft.com, neerajsi@microsoft.com, ps@pks.im,
        worldhello.net@gmail.com
Subject: Re: [PATCH v6 00/12] core.fsyncmethod: add 'batch' mode for faster
 fsyncing of multiple objects
References: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
        <20220405052018.11247-1-neerajsi@microsoft.com>
        <xmqq7d82x8a9.fsf@gitster.g>
Date:   Thu, 19 May 2022 14:47:30 -0700
In-Reply-To: <xmqq7d82x8a9.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        06 Apr 2022 13:32:14 -0700")
Message-ID: <xmqqtu9lkxe5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4949B25A-D7BD-11EC-826A-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> nksingh85@gmail.com writes:
>
>> From: Neeraj Singh <neerajsi@microsoft.com>
>>
>> GGG closed this series erroneously, so I'm trying out
>> git-send-email. Apologies for any mistakes.
>>
>> This series is also available at
>> https://github.com/neerajsi-msft/git/git.git ns/batched-fsync-v6.
>>
>> V6 changes:

We haven't heard anything on this topic from anybody for this round.
I am planning to merge it to 'next' soonish.

Please speak up if anybody has concerns.

Thanks.

