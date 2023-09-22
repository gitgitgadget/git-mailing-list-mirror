Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F8FCE7AB8
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 19:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjIVTtP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 15:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjIVTtO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 15:49:14 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66D0AC
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 12:49:08 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E04E1B0C5A;
        Fri, 22 Sep 2023 15:49:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=vbGJzaUu3O07yilUiqhojPKXEN1+wWUjTKzuso
        BpWoY=; b=PhasmsUfRGu2/m4cayZvn8KJl+g1NtoC/ps4LP5vfmGmPvjMqiJipU
        CV2xJAHSTTCedYYsOPV7nRv9bpY8J8TaRKd6kbwtsPppeIvSf5Szj2K3a8/Ml1Vp
        gSPQnOgMjumYImAvgwXVBlexH+45waawgLErxH8VmU8mCWaU33JkA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 462001B0C59;
        Fri, 22 Sep 2023 15:49:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 909491B0C58;
        Fri, 22 Sep 2023 15:49:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Arver <linusa@google.com>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] completion: loosen and document the requirement around
 completing alias
In-Reply-To: <owly34z6t5zg.fsf@fine.c.googlers.com> (Linus Arver's message of
        "Fri, 22 Sep 2023 11:31:15 -0700")
References: <pull.1585.git.1694274592854.gitgitgadget@gmail.com>
        <pull.1585.v2.git.1694538135853.gitgitgadget@gmail.com>
        <xmqqy1h08zsp.fsf_-_@gitster.g> <xmqqr0ms8yxs.fsf@gitster.g>
        <owly34z6t5zg.fsf@fine.c.googlers.com>
Date:   Fri, 22 Sep 2023 12:49:06 -0700
Message-ID: <xmqqediq0z0t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 17972052-5981-11EE-8E99-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Arver <linusa@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>>  * We've discussed this when we reviewed the topic that just hit
>>>    'master'.  Before we forget...
> ...
> LGTM, thanks!

Thanks for reading.
