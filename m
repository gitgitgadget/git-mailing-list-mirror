Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6237EEAA5D
	for <git@archiver.kernel.org>; Thu, 14 Sep 2023 18:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240416AbjINSP7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Sep 2023 14:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjINSP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2023 14:15:57 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F7A1FD7
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 11:15:53 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 493BB1C571D;
        Thu, 14 Sep 2023 14:15:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=VQ0woFpdhlwy+Hhdtja9HAzmOzpyIOlrESny49
        GRmaU=; b=FLDbYo1DMRw24Ag+CqcjUNZNcGUUHfJHMQd8vErD1DZuwr+cNcoSXf
        pG0A1YrU6y0piBu+UjT/RgK/iUS2Wn8mceqtGI5gFQ10jqR5aMwEp/4Q8lO/iojc
        my5xLujxOihwTazqDK3PRNHUIOaET9b163slkg2VdXRqmXeNmWMCg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 40B4C1C571B;
        Thu, 14 Sep 2023 14:15:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A50B21C571A;
        Thu, 14 Sep 2023 14:15:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Arver <linusa@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 0/3] "update-index --show-index-version"
In-Reply-To: <owlypm2ljmzi.fsf@fine.c.googlers.com> (Linus Arver's message of
        "Wed, 13 Sep 2023 23:19:13 -0700")
References: <20230818233729.2766281-1-gitster@pobox.com>
        <20230912193235.776292-1-gitster@pobox.com>
        <owlypm2ljmzi.fsf@fine.c.googlers.com>
Date:   Thu, 14 Sep 2023 11:15:49 -0700
Message-ID: <xmqqjzssk4dm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BC3D283E-532A-11EE-8404-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Arver <linusa@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>
>> This iteration takes suggestions by Linus Arver; the tests added by
>> [2/3] have been clarified.
>>
>
> This version LGTM, thanks!

Thanks.
